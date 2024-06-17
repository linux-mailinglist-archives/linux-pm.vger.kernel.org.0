Return-Path: <linux-pm+bounces-9302-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 89AE090A938
	for <lists+linux-pm@lfdr.de>; Mon, 17 Jun 2024 11:13:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3ECDA1F24C7A
	for <lists+linux-pm@lfdr.de>; Mon, 17 Jun 2024 09:13:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 823631922DB;
	Mon, 17 Jun 2024 09:11:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ligFLd8Q"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0E671922D9;
	Mon, 17 Jun 2024 09:11:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718615507; cv=none; b=hCnwovLDKXK37J2GetcKl3nFeC18OmK2R6lqc8CHJRdINKG9/2qge56tLY/pB2YUi3s308ItUs46c35lzKL/fyXPv+kcudyStnIljUSZ4CEnHBLeawFdocmX2FaVamLzOqNBd1OCL5MDcT8a6o2jJ+Ohbzx6W9T/Bp3XGEhW31s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718615507; c=relaxed/simple;
	bh=JRUYiTG4Cf5bmbIhN3gccg8DQqgmW2TjfTfk58bo2jM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pK5u1BrJ2nmShpMiH6F90uwH/x2y18VQcBkCdv0IF/SZ++xWMTJcrZD+i+ExhGoxI8iHJQYVpzdB9kY76KHTmvA4FASebvzM90yJfA1yHqPRFNojTVTHc0I4uCoTmEaky1blPsm/iU2pipdGOLsycIbGTN/arG5t8pz02aRdzXM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ligFLd8Q; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1718615506; x=1750151506;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=JRUYiTG4Cf5bmbIhN3gccg8DQqgmW2TjfTfk58bo2jM=;
  b=ligFLd8QcI0ye8v9vhAn1n6nbusk2vZjwxQgI/vBRtxMjjZNhJlvM2Se
   mchzUWZ0DxNfpLFpOcM221OMsLmLbB1NLqH7VN42lRKWJvm7oDvXe3yqx
   DpU8JC21pDz7nnrvGK0ZEPGZwByhcYeuG8VNegCDEKtjU7PmHEnQgkAgA
   MBFwW5q8bf/jhbkbDYmrBUTFWewloFofWaBki0G6XDW2uOlofaKQ67NVj
   BF66i8a5iUIKtp/2+UxhjqzRW6pT+3ChqcudlOr+kXwbJYAyRiw9kLFdW
   q6AfHwLYq44p6uVWsjqxhRZ8aVS+W0fHxeF3DaZCnLAdNZcvkQ+aAHQvL
   A==;
X-CSE-ConnectionGUID: AyM0TF1ISQStFdcXQm+bEw==
X-CSE-MsgGUID: UC49pASXTYapylQuIcNWDQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11105"; a="32902557"
X-IronPort-AV: E=Sophos;i="6.08,244,1712646000"; 
   d="scan'208";a="32902557"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jun 2024 02:11:46 -0700
X-CSE-ConnectionGUID: Fw+IOsHYTtSGnXWj7Xb3jg==
X-CSE-MsgGUID: D/Xi1GEuTpKilqjiA4k2HA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,244,1712646000"; 
   d="scan'208";a="72339004"
Received: from mshehzad-mobl.amr.corp.intel.com (HELO desk) ([10.209.21.13])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jun 2024 02:11:44 -0700
Date: Mon, 17 Jun 2024 02:11:44 -0700
From: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
To: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org
Cc: daniel.sneddon@linux.intel.com, tony.luck@intel.com,
	linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
	linux-perf-users@vger.kernel.org,
	Josh Poimboeuf <jpoimboe@kernel.org>,
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Ricardo Neri <ricardo.neri-calderon@linux.intel.com>,
	"Liang, Kan" <kan.liang@linux.intel.com>,
	Andrew Cooper <andrew.cooper3@citrix.com>
Subject: [PATCH PATCH 4/9] x86/cpu: Remove get_this_hybrid_cpu_type()
Message-ID: <20240617-add-cpu-type-v1-4-b88998c01e76@linux.intel.com>
X-Mailer: b4 0.12.3
References: <20240617-add-cpu-type-v1-0-b88998c01e76@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240617-add-cpu-type-v1-0-b88998c01e76@linux.intel.com>

get_this_hybrid_cpu_type() is replaced by topology_cpu_type(). There are no
more users left, remove it.

Signed-off-by: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
---
 arch/x86/include/asm/cpu.h  |  6 ------
 arch/x86/kernel/cpu/intel.c | 16 ----------------
 2 files changed, 22 deletions(-)

diff --git a/arch/x86/include/asm/cpu.h b/arch/x86/include/asm/cpu.h
index aa30fd8cad7f..20e491c22b98 100644
--- a/arch/x86/include/asm/cpu.h
+++ b/arch/x86/include/asm/cpu.h
@@ -31,7 +31,6 @@ extern void __init sld_setup(struct cpuinfo_x86 *c);
 extern bool handle_user_split_lock(struct pt_regs *regs, long error_code);
 extern bool handle_guest_split_lock(unsigned long ip);
 extern void handle_bus_lock(struct pt_regs *regs);
-u8 get_this_hybrid_cpu_type(void);
 #else
 static inline void __init sld_setup(struct cpuinfo_x86 *c) {}
 static inline bool handle_user_split_lock(struct pt_regs *regs, long error_code)
@@ -45,11 +44,6 @@ static inline bool handle_guest_split_lock(unsigned long ip)
 }
 
 static inline void handle_bus_lock(struct pt_regs *regs) {}
-
-static inline u8 get_this_hybrid_cpu_type(void)
-{
-	return 0;
-}
 #endif
 #ifdef CONFIG_IA32_FEAT_CTL
 void init_ia32_feat_ctl(struct cpuinfo_x86 *c);
diff --git a/arch/x86/kernel/cpu/intel.c b/arch/x86/kernel/cpu/intel.c
index fdf3489d92a4..ac6c68a39051 100644
--- a/arch/x86/kernel/cpu/intel.c
+++ b/arch/x86/kernel/cpu/intel.c
@@ -1335,19 +1335,3 @@ void __init sld_setup(struct cpuinfo_x86 *c)
 	sld_state_setup();
 	sld_state_show();
 }
-
-#define X86_HYBRID_CPU_TYPE_ID_SHIFT	24
-
-/**
- * get_this_hybrid_cpu_type() - Get the type of this hybrid CPU
- *
- * Returns the CPU type [31:24] (i.e., Atom or Core) of a CPU in
- * a hybrid processor. If the processor is not hybrid, returns 0.
- */
-u8 get_this_hybrid_cpu_type(void)
-{
-	if (!cpu_feature_enabled(X86_FEATURE_HYBRID_CPU))
-		return 0;
-
-	return cpuid_eax(0x0000001a) >> X86_HYBRID_CPU_TYPE_ID_SHIFT;
-}

-- 
2.34.1



