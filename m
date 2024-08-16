Return-Path: <linux-pm+bounces-12289-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FA97954056
	for <lists+linux-pm@lfdr.de>; Fri, 16 Aug 2024 06:08:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 505061C220E3
	for <lists+linux-pm@lfdr.de>; Fri, 16 Aug 2024 04:08:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB5E212BF32;
	Fri, 16 Aug 2024 04:06:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="VsV1ZVTh"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4885E83CA0;
	Fri, 16 Aug 2024 04:06:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723781176; cv=none; b=BCcPfhWyjPZH/m/WXPGz6bHa6T8VIgPQgr9Yf24ZGrg4LuNTaTW0JlzbZ3WO3rygOEwK42TWzpdCS49fTBi5rUl5FDat+U5zQBbMkfqcDtdgJV8PPmDUr8zmss4YMWpW8bQcrIQeT2yJpsReUvvFTkmCFchRTop6kA+LQzd/UhM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723781176; c=relaxed/simple;
	bh=ysYUgCiujfaTybXqioFulPopZi37CP7a8Iadi2yWj3I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QU3ZtW5IxFAtdmrYTw8n7jv1kFJsRZ3lHo/WzyqTEwrlYhANmHcHaH+FZik+VKYb/oothTjZt7LvL3eBtsrhZ/61pFqkd3T2eiCs/TmOTvXLcOrBPOXP/nkiYTFTzIDbw71VBZFK2tsRUOBisn7uvCsgDIFbdKCDwGcYB9SRGww=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=VsV1ZVTh; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1723781175; x=1755317175;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=ysYUgCiujfaTybXqioFulPopZi37CP7a8Iadi2yWj3I=;
  b=VsV1ZVThOzZBanBk7iqRnM4kGnUR4E1fTRZDwEcE1h3emgDyz72u9NO+
   lNNbult+fuOmua3wXvrpqjy10ek9cyF5W3OZrbiwxTc5C3MZcCHo/Lebz
   FLJ6O55+YyZr+YK8voM1xUDgWuONDnh1RI3udx5FaOLb4+wExBokYx0sd
   O2/0bRQGE2IvHQ6o80c6HyIr/rAF935eZ39DhAtj1pSsZHeCd6snlzl0h
   B16WWWdttG0AKezvA+dA5DyELIVoBW82tf7o6I2GvxOANSBWYLDy6B6KQ
   xQ/2NqY/8BBBAxZNxjmzscMYWb8wWZbJ3ibxOgxKVMeQvzrXR176qgJ7N
   Q==;
X-CSE-ConnectionGUID: DdELEOUtQkam5ftDgUrbWg==
X-CSE-MsgGUID: iZy2Ln4cTM2YcHoHmrcG0Q==
X-IronPort-AV: E=McAfee;i="6700,10204,11165"; a="39521710"
X-IronPort-AV: E=Sophos;i="6.10,150,1719903600"; 
   d="scan'208";a="39521710"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Aug 2024 21:06:15 -0700
X-CSE-ConnectionGUID: hYVM8tdqT9u/JZaLdGr8DA==
X-CSE-MsgGUID: iUujCzfGTIubs8muKB5a7A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,150,1719903600"; 
   d="scan'208";a="97070305"
Received: from kerandaa-mobl.amr.corp.intel.com (HELO desk) ([10.125.112.221])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Aug 2024 21:06:14 -0700
Date: Thu, 15 Aug 2024 21:06:13 -0700
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
Subject: [PATCH v3 01/10] x86/cpu: Prepend 0x to the hex values in
 cpu_debug_show()
Message-ID: <20240815-add-cpu-type-v3-1-234162352057@linux.intel.com>
X-Mailer: b4 0.14.1
References: <20240815-add-cpu-type-v3-0-234162352057@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240815-add-cpu-type-v3-0-234162352057@linux.intel.com>

The hex values in CPU debug interface are not prepended with 0x. This may
cause misinterpretation of values. Fix it.

Signed-off-by: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
---
 arch/x86/kernel/cpu/debugfs.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/x86/kernel/cpu/debugfs.c b/arch/x86/kernel/cpu/debugfs.c
index 3baf3e435834..ca373b990c47 100644
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



