Return-Path: <linux-pm+bounces-19089-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D94649EDFA2
	for <lists+linux-pm@lfdr.de>; Thu, 12 Dec 2024 07:57:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C2D811889956
	for <lists+linux-pm@lfdr.de>; Thu, 12 Dec 2024 06:57:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57B18204F84;
	Thu, 12 Dec 2024 06:57:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="mktYEr1o"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A42B8204F76;
	Thu, 12 Dec 2024 06:57:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733986647; cv=none; b=J6hCHIJl8SkAbjMCRHpqa8gNgfQLmuihvyQWE4hmKpOD97MyaMWwe4t//NKHgT67IVLn3XuFBe3HdLDTrplJuONFWxTnMKCkYfb8PpeQACtSU+kHJCgDg068GG68iAclmaCJwGXgjylpQYvX5F/dFJdYH4rTcM5M8dw/bhpkXWU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733986647; c=relaxed/simple;
	bh=r1boVyI0fpZDL7gD/4Uo8Jj/l76Exljk4VjOn7uHTX8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NBAooWZO3G9VHgx+mcTv9RSKzuUfND4NQc5w9d89zh4nQS3JQchd7fOy/ySymWAIVDeJgIQpG0NINRPWRJnZBI+cz2U5qDy1FqRVl3nYq5GGyoEzHdxXSf+8uDVhFZWwXuDqMMRkbAEWCcvZ5/9Dvt4M4cd550fqXfec/SMtPBU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=mktYEr1o; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1733986646; x=1765522646;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=r1boVyI0fpZDL7gD/4Uo8Jj/l76Exljk4VjOn7uHTX8=;
  b=mktYEr1ohBmPUGnQBoEfH47R5K3AnH8p6+YK5c111QUsGwFx8g9ioCaL
   phVmRGNZHWyTerxLd4tKw2ketDqRxVk5kPItA3PuHgsGmdelz4R3z8Ic7
   r/cfCa2CwsP9ue0fvydt1yTInF6SmMXYpGQ4BymRpnNsu9bZITk2kHYXt
   3wVXZLm+FvObYgUBlAD1QPLfFSabOOeNj0SzyBWeaZkfJ+o5r8jgz0g3o
   M562bNdgOZV4cWjSU7aM8FCy/gueIKbgH+0z4is2G9wlm1axgcqI+kpP/
   RMy7Uu4PtzhK3+3zOX02zOIu51xb1/Lf0/PbG5dkJEuQnqUxiCi+cvlkY
   g==;
X-CSE-ConnectionGUID: ZFTz+QU5TsmJkaR2e1VKXw==
X-CSE-MsgGUID: PxG2sSXXSe6ZpWHqnmJzXw==
X-IronPort-AV: E=McAfee;i="6700,10204,11283"; a="59786313"
X-IronPort-AV: E=Sophos;i="6.12,227,1728975600"; 
   d="scan'208";a="59786313"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Dec 2024 22:57:25 -0800
X-CSE-ConnectionGUID: qOw2JYMdRBuFNenhEH4qOg==
X-CSE-MsgGUID: I+vSvhekQxGunY8kLuFUkw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,227,1728975600"; 
   d="scan'208";a="96372289"
Received: from unknown (HELO desk) ([10.125.145.3])
  by fmviesa008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Dec 2024 22:57:24 -0800
Date: Wed, 11 Dec 2024 22:57:24 -0800
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
	Andrew Cooper <andrew.cooper3@citrix.com>,
	Brice Goglin <brice.goglin@gmail.com>,
	Mario Limonciello <mario.limonciello@amd.com>,
	Perry Yuan <Perry.Yuan@amd.com>,
	Dapeng Mi <dapeng1.mi@linux.intel.com>
Subject: [PATCH v5 1/9] x86/cpu: Prepend 0x to the hex values in
 cpu_debug_show()
Message-ID: <20241211-add-cpu-type-v5-1-2ae010f50370@linux.intel.com>
X-Mailer: b4 0.14.1
References: <20241211-add-cpu-type-v5-0-2ae010f50370@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241211-add-cpu-type-v5-0-2ae010f50370@linux.intel.com>

The hex values in CPU debug interface are not prepended with 0x. This may
cause misinterpretation of values. Fix it.

Acked-by: Dave Hansen <dave.hansen@linux.intel.com>
Signed-off-by: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
---
 arch/x86/kernel/cpu/debugfs.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/x86/kernel/cpu/debugfs.c b/arch/x86/kernel/cpu/debugfs.c
index 10719aba6276..9c8142ddd481 100644
--- a/arch/x86/kernel/cpu/debugfs.c
+++ b/arch/x86/kernel/cpu/debugfs.c
@@ -16,8 +16,8 @@ static int cpu_debug_show(struct seq_file *m, void *p)
 	if (!c->initialized)
 		return 0;
 
-	seq_printf(m, "initial_apicid:      %x\n", c->topo.initial_apicid);
-	seq_printf(m, "apicid:              %x\n", c->topo.apicid);
+	seq_printf(m, "initial_apicid:	  0x%x\n", c->topo.initial_apicid);
+	seq_printf(m, "apicid:		  0x%x\n", c->topo.apicid);
 	seq_printf(m, "pkg_id:              %u\n", c->topo.pkg_id);
 	seq_printf(m, "die_id:              %u\n", c->topo.die_id);
 	seq_printf(m, "cu_id:               %u\n", c->topo.cu_id);

-- 
2.34.1



