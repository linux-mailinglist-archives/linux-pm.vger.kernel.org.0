Return-Path: <linux-pm+bounces-24834-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1891FA7C6B9
	for <lists+linux-pm@lfdr.de>; Sat,  5 Apr 2025 01:31:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C06073BBDA5
	for <lists+linux-pm@lfdr.de>; Fri,  4 Apr 2025 23:31:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC3FF21C176;
	Fri,  4 Apr 2025 23:31:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=r-ricci.it header.i=@r-ricci.it header.b="RmG31kDe"
X-Original-To: linux-pm@vger.kernel.org
Received: from out-189.mta1.migadu.com (out-189.mta1.migadu.com [95.215.58.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCA2C33FD
	for <linux-pm@vger.kernel.org>; Fri,  4 Apr 2025 23:31:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743809503; cv=none; b=mErvPQ9k+R6qWO0mKcrp30cticyqKYQiuyzPuHBFO7zaDFJ4ZZDp1vMIgmLx2NyUVLTPjinkNrIp4UE35ctM3I2ektKVMvhuX7jnm1eM2Ok2po6OX0g7MNkhWE2V64qO7k1YIy3hzCP8766BFYDXTjvSvcBf8BJd6eC0YfyGg7U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743809503; c=relaxed/simple;
	bh=DLrmo7qftsxWmkzmpPrjiS+73lluGOPDVD+Tr1lb7f0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uVBSK3Q7saQrgV/LE+CeZbFB8bhig0m5/5KvshwpeTOIODA/hNv3DCs8XVOdSC7iHem0W4zDvNEZyjhVsrY/Qys2Tg5pueRjVj2yhWwlFKPAHN9CWsm3hz9yZZdiQOK+oeJTGtbZuPvSbJKr5sLWK642zFm4QinjR7vxXUeebnw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=r-ricci.it; spf=pass smtp.mailfrom=r-ricci.it; dkim=pass (2048-bit key) header.d=r-ricci.it header.i=@r-ricci.it header.b=RmG31kDe; arc=none smtp.client-ip=95.215.58.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=r-ricci.it
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=r-ricci.it
Date: Sat, 5 Apr 2025 01:31:23 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=r-ricci.it; s=key1;
	t=1743809488;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=GLVJtIoQpdVmEAUKr1dsLDOJiHfbCf/jS5iodZmlkgE=;
	b=RmG31kDenvozuDOddYRWpflGvE3ElGPz3cik7+hh0dJCWN8CE0NucAjU1F4kUp68nl/u7E
	0FQlN5Th6DK30djI0bA7G1UXgXsoMru0q5QE4LPklDV7Bva17wxz1wpCkAYuGWQNF2dFHh
	DvV9TLJLh7AeYOTH55GQPvqzEH3jKa+cr8x/ouMYvAE33BV+SSVa0XZ5OmCPZMGPn5nzCn
	zdmf2tphLjbW+OxNf1qxxurKkyrCTnZddgQFv+DQg8SDkw9i7y2ZlF3EhKe2Q6oaLAQQ4T
	a0MaB0kSGbJiDPCZMcqpDiq5+aXHXaCgGk5Ln+qYjoxr25eAJBqul0jdrfD1RQ==
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Roberto Ricci <io@r-ricci.it>
To: Baoquan He <bhe@redhat.com>
Cc: Dave Young <dyoung@redhat.com>, ebiederm@xmission.com,
	rafael@kernel.org, pavel@ucw.cz, ytcoode@gmail.com,
	kexec@lists.infradead.org, linux-pm@vger.kernel.org,
	akpm@linux-foundation.org, regressions@lists.linux.dev,
	linux-kernel@vger.kernel.org, msizanoen@qtmlabs.xyz,
	rafael.j.wysocki@intel.com, yu.c.chen@intel.com
Subject: Re: [REGRESSION] Kernel booted via kexec fails to resume from
 hibernation
Message-ID: <Z_Bry0JcB1jqPztR@desktop0a>
References: <Z4WFjBVHpndct7br@desktop0a>
 <Z5bx7ZHNcyc5fM_L@darkstar.users.ipa.redhat.com>
 <CALu+AoSSKh=5ELgQyzDrGEDm5fm2XKteH1ZC70mm89pNSSPMHw@mail.gmail.com>
 <Z-c7V2hptt9U9UCl@desktop0a>
 <Z+dQZozsbdls6yqJ@MiWiFi-R3L-srv>
 <Z-hYWc9LtBU1Yhtg@desktop0a>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z-hYWc9LtBU1Yhtg@desktop0a>
X-Migadu-Flow: FLOW_OUT

On 2025-03-29 21:30 +0100, Roberto Ricci wrote:
> On 2025-03-29 09:44 +0800, Baoquan He wrote:
> > [snip]
> > 3) If answer to 1) and 2) is yes, does kexec_load works for you? Asking
> > this because kexec_load interface defaults to put kexec kernel on top of
> > system RAM which is equivalent to applying commit b3ba234171cd.
> 
> No, it doesn't. While hibernation alone works, kexec + hibernation
> results in the system just rebooting without resuming the hibernation
> image, but no crash or other weird behaviour occurs.
> Initially I decided to focus on kexec_file_load in order to narrow
> things down, but that was before noticing that the bug could manifest
> itself in different forms.
> It is possible, indeed, that both syscalls are affected by the same
> problem, which is not caused by commit b3ba234171cd.
> I tried to test kexec_load with some older kernels, but I got build
> errors, so I tested longterm releases where such errors have been fixed.
> With v4.9.337, kexec (via kexec_load) + hibernation works.
> With v5.4.291 it doesn't.
> I'm not sure how bisection could be done in this case.
> [snip]

I've bisected this other bug with kexec_load. I found commit
62a03defeabd PM / hibernate: Verify the consistent of e820 memory map by md5 digest
Reverting it on v6.14 fixes kexec_load, but not kexec_file_load.
Also applying the patch suggested by msizanoen fixes kexec_file_load, too:
https://lore.kernel.org/all/Z_BDbwmFV6wxDPV1@desktop0a/

FYI, this is how I reverted that commit (I had to manually resolve
conflicts):

diff --git a/arch/x86/power/hibernate.c b/arch/x86/power/hibernate.c
index 5b81d19cd114..f2021a515bad 100644
--- a/arch/x86/power/hibernate.c
+++ b/arch/x86/power/hibernate.c
@@ -40,20 +40,6 @@ unsigned long restore_cr3 __visible;
 unsigned long temp_pgt __visible;
 unsigned long relocated_restore_code __visible;
 
-/**
- *	pfn_is_nosave - check if given pfn is in the 'nosave' section
- */
-int pfn_is_nosave(unsigned long pfn)
-{
-	unsigned long nosave_begin_pfn;
-	unsigned long nosave_end_pfn;
-
-	nosave_begin_pfn = __pa_symbol(&__nosave_begin) >> PAGE_SHIFT;
-	nosave_end_pfn = PAGE_ALIGN(__pa_symbol(&__nosave_end)) >> PAGE_SHIFT;
-
-	return pfn >= nosave_begin_pfn && pfn < nosave_end_pfn;
-}
-
 struct restore_data_record {
 	unsigned long jump_address;
 	unsigned long jump_address_phys;
@@ -83,69 +69,6 @@ static inline u32 compute_e820_crc32(struct e820_table *table)
 #define RESTORE_MAGIC	0x12345679UL
 #endif
 
-/**
- *	arch_hibernation_header_save - populate the architecture specific part
- *		of a hibernation image header
- *	@addr: address to save the data at
- */
-int arch_hibernation_header_save(void *addr, unsigned int max_size)
-{
-	struct restore_data_record *rdr = addr;
-
-	if (max_size < sizeof(struct restore_data_record))
-		return -EOVERFLOW;
-	rdr->magic = RESTORE_MAGIC;
-	rdr->jump_address = (unsigned long)restore_registers;
-	rdr->jump_address_phys = __pa_symbol(restore_registers);
-
-	/*
-	 * The restore code fixes up CR3 and CR4 in the following sequence:
-	 *
-	 * [in hibernation asm]
-	 * 1. CR3 <= temporary page tables
-	 * 2. CR4 <= mmu_cr4_features (from the kernel that restores us)
-	 * 3. CR3 <= rdr->cr3
-	 * 4. CR4 <= mmu_cr4_features (from us, i.e. the image kernel)
-	 * [in restore_processor_state()]
-	 * 5. CR4 <= saved CR4
-	 * 6. CR3 <= saved CR3
-	 *
-	 * Our mmu_cr4_features has CR4.PCIDE=0, and toggling
-	 * CR4.PCIDE while CR3's PCID bits are nonzero is illegal, so
-	 * rdr->cr3 needs to point to valid page tables but must not
-	 * have any of the PCID bits set.
-	 */
-	rdr->cr3 = restore_cr3 & ~CR3_PCID_MASK;
-
-	rdr->e820_checksum = compute_e820_crc32(e820_table_firmware);
-	return 0;
-}
-
-/**
- *	arch_hibernation_header_restore - read the architecture specific data
- *		from the hibernation image header
- *	@addr: address to read the data from
- */
-int arch_hibernation_header_restore(void *addr)
-{
-	struct restore_data_record *rdr = addr;
-
-	if (rdr->magic != RESTORE_MAGIC) {
-		pr_crit("Unrecognized hibernate image header format!\n");
-		return -EINVAL;
-	}
-
-	restore_jump_address = rdr->jump_address;
-	jump_address_phys = rdr->jump_address_phys;
-	restore_cr3 = rdr->cr3;
-
-	if (rdr->e820_checksum != compute_e820_crc32(e820_table_firmware)) {
-		pr_crit("Hibernate inconsistent memory map detected!\n");
-		return -ENODEV;
-	}
-
-	return 0;
-}
 
 int relocate_restore_code(void)
 {
diff --git a/arch/x86/power/hibernate_64.c b/arch/x86/power/hibernate_64.c
index a595953f1d6d..924420fdaab4 100644
--- a/arch/x86/power/hibernate_64.c
+++ b/arch/x86/power/hibernate_64.c
@@ -140,3 +140,56 @@ asmlinkage int swsusp_arch_resume(void)
 	restore_image();
 	return 0;
 }
+
+/*
+ *	pfn_is_nosave - check if given pfn is in the 'nosave' section
+ */
+
+int pfn_is_nosave(unsigned long pfn)
+{
+	unsigned long nosave_begin_pfn = __pa_symbol(&__nosave_begin) >> PAGE_SHIFT;
+	unsigned long nosave_end_pfn = PAGE_ALIGN(__pa_symbol(&__nosave_end)) >> PAGE_SHIFT;
+	return (pfn >= nosave_begin_pfn) && (pfn < nosave_end_pfn);
+}
+
+struct restore_data_record {
+	unsigned long jump_address;
+	unsigned long jump_address_phys;
+	unsigned long cr3;
+	unsigned long magic;
+};
+
+#define RESTORE_MAGIC	0x123456789ABCDEF0UL
+
+/**
+ *	arch_hibernation_header_save - populate the architecture specific part
+ *		of a hibernation image header
+ *	@addr: address to save the data at
+ */
+int arch_hibernation_header_save(void *addr, unsigned int max_size)
+{
+	struct restore_data_record *rdr = addr;
+
+	if (max_size < sizeof(struct restore_data_record))
+		return -EOVERFLOW;
+	rdr->jump_address = (unsigned long)&restore_registers;
+	rdr->jump_address_phys = __pa_symbol(&restore_registers);
+	rdr->cr3 = restore_cr3;
+	rdr->magic = RESTORE_MAGIC;
+	return 0;
+}
+
+/**
+ *	arch_hibernation_header_restore - read the architecture specific data
+ *		from the hibernation image header
+ *	@addr: address to read the data from
+ */
+int arch_hibernation_header_restore(void *addr)
+{
+	struct restore_data_record *rdr = addr;
+
+	restore_jump_address = rdr->jump_address;
+	jump_address_phys = rdr->jump_address_phys;
+	restore_cr3 = rdr->cr3;
+	return (rdr->magic == RESTORE_MAGIC) ? 0 : -EINVAL;
+}

