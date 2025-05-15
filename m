Return-Path: <linux-pm+bounces-27202-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 02BF9AB8A42
	for <lists+linux-pm@lfdr.de>; Thu, 15 May 2025 17:08:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C0CBB171EE2
	for <lists+linux-pm@lfdr.de>; Thu, 15 May 2025 15:06:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3F7D1F8691;
	Thu, 15 May 2025 15:06:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="I8Orkj+A"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8906023BE;
	Thu, 15 May 2025 15:06:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747321571; cv=none; b=mL9RHTXnqbWrqZDyt2TAWCyF93bcTOs+KX2Ht21mbxulvEmHR5i0JnJ9aJQ7ncnQNu1hphm7kyhTPpUaMf5VEjuRMqMG2EyYiXC+5pdptoTUHa0n1Fi3+XXGF17BlppLtW3hsFWH7A6zA4L6B5GL+uK+a3HPgcc6C6NSl8xQEQ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747321571; c=relaxed/simple;
	bh=FlUH0o0HQ8UiYkcGGiHz4cGt/8yWibv5yobf4uyVa+o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DfO2nmKg6DTmwTRMMV76P6TgSDg+Zs7hL+mC4avhg07q0ZOzOu9uHg3eHOlwheCKWs+UqthI/15I0BMa3bjh1y43ExgGm71TnFvJsZ3fUgkjAviI8qRbk1nXekYB4F8zwjryaoow2hk5gT6/GmQXmlcI51ZlS1tmy1deEyHWG2M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=I8Orkj+A; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2CE10C4CEE7;
	Thu, 15 May 2025 15:06:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747321570;
	bh=FlUH0o0HQ8UiYkcGGiHz4cGt/8yWibv5yobf4uyVa+o=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=I8Orkj+ANvhMbwsaCNLZt60rhU9KMAaCGgsKGDDrBag7kjHaqmVHJO0lRN616nRyl
	 Qj4mz/Ent+beYHVvHBlMLC5iWpWsMXC3u17fC6u16XMiO9VGReG9nK36AR6ans60Pf
	 VABOa0ZZw6ZtH8EdVtT0ftFuTLOI5WpZlzknv4AaWHuptaxZswfeX+WMq66sD+Zi3i
	 0E4Xq9l662KgLIWCG5TQ4aHLI10IyRMgCumO9B1GIDi5x8+j15lbHQPkSso5QzaVd3
	 YVUGQg0e4BsjDzs3RsZIxs7hfv8wqKMUmRuT2Wbsc0ZU+ENSFkeP2XtBJTaIAS8t0X
	 Q4FCtK/jIBL9A==
Date: Thu, 15 May 2025 17:06:02 +0200
From: Ingo Molnar <mingo@kernel.org>
To: Shivank Garg <shivankg@amd.com>
Cc: tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
	dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com,
	luto@kernel.org, peterz@infradead.org, rafael@kernel.org,
	pavel@kernel.org, akpm@linux-foundation.org,
	linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
	sohil.mehta@intel.com, rui.zhang@intel.com, yuntao.wang@linux.dev,
	kai.huang@intel.com, xiaoyao.li@intel.com, peterx@redhat.com,
	sandipan.das@amd.com, ak@linux.intel.com, rostedt@goodmis.org
Subject: Re: [PATCH RESEND 1/4] x86/mm: pgtable: Fix W=1 build kernel-doc
 warnings
Message-ID: <aCYC2pYpXeYVlxA1@gmail.com>
References: <20250514062637.3287779-1-shivankg@amd.com>
 <aCRMT0TlpFvpRGYk@gmail.com>
 <6c4b227e-abdd-4e7f-8abd-d85cae0f0ec3@amd.com>
 <aCRgRxmO6rsR-0k3@gmail.com>
 <c5ad88e9-434a-4399-8e21-3c41e9295e93@amd.com>
 <aCWPp4wYwauSuTed@gmail.com>
 <eddc986d-62be-425c-8065-3cd5a3922026@amd.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <eddc986d-62be-425c-8065-3cd5a3922026@amd.com>


* Shivank Garg <shivankg@amd.com> wrote:

> > Also, similar errors are elsewhere as well.
> 
> I'm sorry for missing these details in the previous revision.
> I'm changing the first letter of variable description to capital.
> 
> https://docs.kernel.org/doc-guide/kernel-doc.html
> /**
>  * function_name() - Brief description of function.
>  * @arg1: Describe the first argument.
>  * @arg2: Describe the second argument.
>  *        One can provide multiple line descriptions
>  *        for arguments.
> 
> Function description also starts with capital letter in the doc-guide
> and other kernel places so this should make it consistent.

Thank you! This version is much more complete. There were a few other 
things missing, quite a few of them pre-existing, which I fixed up in 
the commit (see the delta patch below).

Note that I standardized on a kernel-doc style variant without full 
stops for simple singular sentences. This is what most of the x86 code 
and the core kernel is doing, and it's contrary to the kernel-doc.html 
recommendation - but you couldn't really have known that.

Thanks,

	Ingo

=====================>
 arch/x86/mm/pgtable.c | 50 +++++++++++++++++++++++++-------------------------
 1 file changed, 25 insertions(+), 25 deletions(-)

diff --git a/arch/x86/mm/pgtable.c b/arch/x86/mm/pgtable.c
index 9aa3c60c6afa..59c42dec7076 100644
--- a/arch/x86/mm/pgtable.c
+++ b/arch/x86/mm/pgtable.c
@@ -543,11 +543,11 @@ pud_t pudp_invalidate(struct vm_area_struct *vma, unsigned long address,
 #endif
 
 /**
- * reserve_top_address - Reserves a hole in the top of kernel address space
- * @reserve: Size of hole to reserve.
+ * reserve_top_address - Reserve a hole in the top of the kernel address space
+ * @reserve: Size of hole to reserve
  *
  * Can be used to relocate the fixmap area and poke a hole in the top
- * of kernel address space to make room for a hypervisor.
+ * of the kernel address space to make room for a hypervisor.
  */
 void __init reserve_top_address(unsigned long reserve)
 {
@@ -594,10 +594,10 @@ void native_set_fixmap(unsigned /* enum fixed_addresses */ idx,
 #ifdef CONFIG_HAVE_ARCH_HUGE_VMAP
 #ifdef CONFIG_X86_5LEVEL
 /**
- * p4d_set_huge - Setup kernel P4D mapping
- * @p4d: Pointer to the P4D entry.
- * @addr: Virtual address associated with the P4D entry.
- * @prot: Protection bits to use.
+ * p4d_set_huge - Set up kernel P4D mapping
+ * @p4d: Pointer to the P4D entry
+ * @addr: Virtual address associated with the P4D entry
+ * @prot: Protection bits to use
  *
  * No 512GB pages yet -- always return 0
  */
@@ -608,7 +608,7 @@ int p4d_set_huge(p4d_t *p4d, phys_addr_t addr, pgprot_t prot)
 
 /**
  * p4d_clear_huge - Clear kernel P4D mapping when it is set
- * @p4d: Pointer to the P4D entry to clear.
+ * @p4d: Pointer to the P4D entry to clear
  *
  * No 512GB pages yet -- do nothing
  */
@@ -618,10 +618,10 @@ void p4d_clear_huge(p4d_t *p4d)
 #endif
 
 /**
- * pud_set_huge - Setup kernel PUD mapping
- * @pud: Pointer to the PUD entry.
- * @addr: Virtual address associated with the PUD entry.
- * @prot: Protection bits to use.
+ * pud_set_huge - Set up kernel PUD mapping
+ * @pud: Pointer to the PUD entry
+ * @addr: Virtual address associated with the PUD entry
+ * @prot: Protection bits to use
  *
  * MTRRs can override PAT memory types with 4KiB granularity. Therefore, this
  * function sets up a huge page only if the complete range has the same MTRR
@@ -652,10 +652,10 @@ int pud_set_huge(pud_t *pud, phys_addr_t addr, pgprot_t prot)
 }
 
 /**
- * pmd_set_huge - Setup kernel PMD mapping
- * @pmd: Pointer to the PMD entry.
- * @addr: Virtual address associated with the PMD entry.
- * @prot: Protection bits to use.
+ * pmd_set_huge - Set up kernel PMD mapping
+ * @pmd: Pointer to the PMD entry
+ * @addr: Virtual address associated with the PMD entry
+ * @prot: Protection bits to use
  *
  * See text over pud_set_huge() above.
  *
@@ -717,11 +717,11 @@ int pmd_clear_huge(pmd_t *pmd)
 
 #ifdef CONFIG_X86_64
 /**
- * pud_free_pmd_page - Clear pud entry and free pmd page.
- * @pud: Pointer to a PUD.
- * @addr: Virtual address associated with pud.
+ * pud_free_pmd_page - Clear PUD entry and free PMD page
+ * @pud: Pointer to a PUD
+ * @addr: Virtual address associated with PUD
  *
- * Context: The pud range has been unmapped and TLB purged.
+ * Context: The PUD range has been unmapped and TLB purged.
  * Return: 1 if clearing the entry succeeded. 0 otherwise.
  *
  * NOTE: Callers must allow a single page allocation.
@@ -764,11 +764,11 @@ int pud_free_pmd_page(pud_t *pud, unsigned long addr)
 }
 
 /**
- * pmd_free_pte_page - Clear pmd entry and free pte page.
- * @pmd: Pointer to a PMD.
- * @addr: Virtual address associated with pmd.
+ * pmd_free_pte_page - Clear PMD entry and free PTE page.
+ * @pmd: Pointer to the PMD
+ * @addr: Virtual address associated with PMD
  *
- * Context: The pmd range has been unmapped and TLB purged.
+ * Context: The PMD range has been unmapped and TLB purged.
  * Return: 1 if clearing the entry succeeded. 0 otherwise.
  */
 int pmd_free_pte_page(pmd_t *pmd, unsigned long addr)
@@ -790,7 +790,7 @@ int pmd_free_pte_page(pmd_t *pmd, unsigned long addr)
 
 /*
  * Disable free page handling on x86-PAE. This assures that ioremap()
- * does not update sync'd pmd entries. See vmalloc_sync_one().
+ * does not update sync'd PMD entries. See vmalloc_sync_one().
  */
 int pmd_free_pte_page(pmd_t *pmd, unsigned long addr)
 {

