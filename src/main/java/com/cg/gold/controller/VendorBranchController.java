package com.cg.gold.controller;

import java.time.LocalDateTime;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.core.env.Environment;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.cg.gold.entity.Address;
import com.cg.gold.entity.TransactionHistory;
import com.cg.gold.entity.VendorBranch;
import com.cg.gold.exception.VendorBranchException;
import com.cg.gold.service.AddressService;
import com.cg.gold.service.VendorBranchService;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.validation.Valid;

@Controller
@RequestMapping("/api/v1/vendor_branches")
public class VendorBranchController {

	@Autowired
	private VendorBranchService vendorBranchService;

	@Autowired
	private AddressService addressService;

	@Autowired
	private Environment environment;

	@GetMapping("/home")
	public String showBranchHome(Model model) {
		if (!model.containsAttribute("branch")) {
			model.addAttribute("branch", new VendorBranch());
		}
		return "vendor-branch-home";
	}

	@GetMapping
	public String getAllBranches(Model model) {
		List<VendorBranch> branches = vendorBranchService.getAllVendorBranches();
		model.addAttribute("branches", branches);
		return "vendor-branch-list";
	}

	@PostMapping("/add")
	public String addBranch(@Valid @ModelAttribute VendorBranch branch, BindingResult result,
			RedirectAttributes redirectAttributes, Model model, HttpServletRequest request) {
		if (result.hasErrors()) {
			model.addAttribute("branch", branch);
			return "vendor-branch-home";
		}
		try {
			vendorBranchService.addBranch(branch);
			redirectAttributes.addFlashAttribute("message", "Vendor Branch added successfully!");
			return "redirect:/api/v1/vendor_branches/home";
		} catch (Exception e) {
			return handleError(e, request, model);
		}
	}

	@GetMapping("/search")
	public String redirectToBranchById(@RequestParam Integer branchId) {
		return "redirect:/api/v1/vendor_branches/" + branchId;
	}

	@GetMapping("/{branch_id}")
	public String getBranchById(@PathVariable("branch_id") Integer branchId, Model model, HttpServletRequest request) {
		try {
			VendorBranch branch = vendorBranchService.getVendorBranchByBranchId(branchId);
			model.addAttribute("branch", branch);
			return "vendor-branch-by-id";
		} catch (VendorBranchException e) {
			return handleError(e, request, model);
		}
	}

	@GetMapping("/by_vendor")
	public String redirectToVendorBranches(@RequestParam Integer vendorId) {
		return "redirect:/api/v1/vendor_branches/by_vendor/" + vendorId;
	}

	@GetMapping("/by_vendor/{vendor_id}")
	public String getBranchesByVendor(@PathVariable("vendor_id") Integer vendorId, Model model,
			HttpServletRequest request) {
		try {
			List<VendorBranch> branches = vendorBranchService.getVendorBranchesByVendorId(vendorId);
			model.addAttribute("branches", branches);
			model.addAttribute("vendorId", vendorId);
			return "vendor-branch-by-vendor-id";
		} catch (VendorBranchException e) {
			return handleError(e, request, model);
		}
	}

	@GetMapping("/by_city")
	public String redirectToCityBranches(@RequestParam String city) {
		return "redirect:/api/v1/vendor_branches/by_city/" + city;
	}

	@GetMapping("/by_city/{city}")
	public String getBranchesByCity(@PathVariable String city, Model model, HttpServletRequest request) {
		try {
			List<VendorBranch> branches = vendorBranchService.getVendorBranchesByCity(city);
			model.addAttribute("branches", branches);
			model.addAttribute("city", city);
			return "vendor-branch-by-city";
		} catch (VendorBranchException e) {
			return handleError(e, request, model);
		}
	}

	@GetMapping("/by_state")
	public String redirectToStateBranches(@RequestParam String state) {
		return "redirect:/api/v1/vendor_branches/by_state/" + state;
	}

	@GetMapping("/by_state/{state}")
	public String getBranchesByState(@PathVariable String state, Model model, HttpServletRequest request) {
		try {
			List<VendorBranch> branches = vendorBranchService.getVendorBranchesByState(state);
			model.addAttribute("branches", branches);
			model.addAttribute("state", state);
			return "vendor-branch-by-state";
		} catch (VendorBranchException e) {
			return handleError(e, request, model);
		}
	}

	@GetMapping("/by_country")
	public String getBranchesByCountry(@RequestParam String country, Model model) throws VendorBranchException {
		return "redirect:/api/v1/vendor_branches/by_country/" + country;
	}

	@GetMapping("/by_country/{country}")
	public String getBranchesByCountry(@PathVariable String country, Model model, HttpServletRequest request) {
		try {
			List<VendorBranch> branches = vendorBranchService.getVendorBranchesByCountry(country);
			model.addAttribute("branches", branches);
			model.addAttribute("country", country);
			return "vendor-branch-by-country";
		} catch (VendorBranchException e) {
			return handleError(e, request, model);
		}
	}

	@GetMapping("/transactions")
	public String getTransactionsById(@RequestParam("branch_id") Integer branchId) {
		return "redirect:/api/v1/vendor_branches/transactions/" + branchId;
	}

	@GetMapping("/transactions/{branch_id}")
	public String getBranchTransactions(@PathVariable("branch_id") Integer branchId, Model model,
			HttpServletRequest request) throws VendorBranchException {
		try {
			List<TransactionHistory> transactions = vendorBranchService.getVendorBranchTransactionsByBranchId(branchId);
			model.addAttribute("transactions", transactions);
			model.addAttribute("branchId", branchId);
			return "vendor-branch-transactions-by-branchid";
		} catch (VendorBranchException e) {
			return handleError(e, request, model);
		}
	}


	@GetMapping("/updatePage/{branch_id}")
	public String showUpdateBranchForm(@PathVariable("branch_id") Integer branchId, Model model,
			HttpServletRequest request) {
		try {
			VendorBranch branch = vendorBranchService.getVendorBranchByBranchId(branchId);
			List<Address> addressList = addressService.getAllAddresses();
			model.addAttribute("branch", branch);
			model.addAttribute("addressList", addressList);
			return "vendor-branch-update";
		} catch (VendorBranchException e) {
			return handleError(e, request, model);
		}
	}

	@PostMapping("/update")
	public String updateBranchForm(@Valid @ModelAttribute VendorBranch branch, BindingResult result, Model model,
			HttpServletRequest request) {
		if (result.hasErrors()) {
			model.addAttribute("branch", branch);
			model.addAttribute("addressList", addressService.getAllAddresses());
			return "vendor-branch-update";
		}
		try {
			vendorBranchService.updateBranch(branch.getBranchId(), branch);
			return "redirect:/api/v1/vendor_branches/home";
		} catch (VendorBranchException e) {
			return handleError(e, request, model);
		}
	}

	@GetMapping("/transfer")
	public String showTransferForm() {
		return "vendor-branch-transfer-gold";
	}

	@PostMapping("/transfer")
	public String transferGold(@RequestParam Integer sourceBranchId, @RequestParam Integer destinationBranchId,
			@RequestParam Double quantity, Model model, HttpServletRequest request) {
		try {
			vendorBranchService.transferGold(sourceBranchId, destinationBranchId, quantity);
			model.addAttribute("successMessage", "Vendor Branch transfer was successful!");
		} catch (VendorBranchException e) {
			return handleError(e, request, model);
		}
		return "vendor-branch-transfer-gold";
	}

	private String handleError(Exception e, HttpServletRequest request, Model model) {
		model.addAttribute("errorMessage", environment.getProperty(e.getMessage()));
		model.addAttribute("url", request.getRequestURL());
		model.addAttribute("timestamp", LocalDateTime.now());
		return "vendor-branch-error";
	}

}
