Return-Path: <linux-pm+bounces-14952-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5478498A7C1
	for <lists+linux-pm@lfdr.de>; Mon, 30 Sep 2024 16:52:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 86C671C23687
	for <lists+linux-pm@lfdr.de>; Mon, 30 Sep 2024 14:52:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E168192D8F;
	Mon, 30 Sep 2024 14:49:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="m1NTag+d"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 887C4191F6B;
	Mon, 30 Sep 2024 14:49:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727707756; cv=none; b=ctbY2tuI4+qfv7ISQJ+DteYesaH2PP2oswzeSRHPnD4NVnttipbH6dmG7Iz2+Yr3gsZvu5VPK7+GxXj8WGtb1s0wyX/CTr8NcxweWjfWsVNfWUWCM0YXvVkovSm82a3k9emjTslUuDH8+bvVSSloUai5jVGEh2d6h7T/hrBgeQg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727707756; c=relaxed/simple;
	bh=ysYUgCiujfaTybXqioFulPopZi37CP7a8Iadi2yWj3I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=l6/FJcFFSyXPRpCkN9gu3cM2n5l+50vmuxUyq21WWKWEg6QOnfba1tRDn7UYzrtox2Zj1Er/IWEX/aEBTcSogVe4aaEeZNZIFfSqv6BCoTq8Nnv61/6Bzg9BHlXdITNRez/JjgsD8e3EVPY6l0718cj/vjYpVOf0st3EWCkCYxE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=m1NTag+d; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1727707756; x=1759243756;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=ysYUgCiujfaTybXqioFulPopZi37CP7a8Iadi2yWj3I=;
  b=m1NTag+dw7C5zD9rWhmJDKsHpwixddZR6pDI0y7PwpgVJVJqUPXJW+te
   C6Oh3eaAxEKs0ph+0szthxLqna9klf1Bf631JK9FTmix+k6Tc4XmFU/xu
   WxRmODnVdgz+755J8bt+8cBvWxmr2KgtGWZYC1IB2NWFsWfgy06j2xWnb
   T6JxTEIRn5igtFKsY/xCHyjLBKxvlZ32XuFQhdpyfkFbHOEQbyrNWT8Mz
   vPPathLrLJBVB38xGGbp4z94Q/dD2RYoLbFLwtrgiBteCtCaco4dw2fF9
   82YS+V+aqd/1wN4D4INeoDb53cH0snOfvyUmsoBGnOJHYsGEm1vnyLiMF
   Q==;
X-CSE-ConnectionGUID: 1gwbUK3hQjeaUjOvsjG6+Q==
X-CSE-MsgGUID: xG6j1KYKTxSevTcjxbHrXA==
X-IronPort-AV: E=McAfee;i="6700,10204,11211"; a="26927397"
X-IronPort-AV: E=Sophos;i="6.11,165,1725346800"; 
   d="scan'208";a="26927397"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Sep 2024 07:47:21 -0700
X-CSE-ConnectionGUID: EnwmsgsFTeyVW+swLx6xEQ==
X-CSE-MsgGUID: N9Hvlg4xScuJpY1Nu6Flvg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,165,1725346800"; 
   d="scan'208";a="104128950"
Received: from smkirkla-mobl.amr.corp.intel.com (HELO desk) ([10.125.147.240])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Sep 2024 07:47:19 -0700
Date: Mon, 30 Sep 2024 07:47:17 -0700
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
Subject: [PATCH v4 01/10] x86/cpu: Prepend 0x to the hex values in
 cpu_debug_show()
Message-ID: <20240930-add-cpu-type-v4-1-104892b7ab5f@linux.intel.com>
X-Mailer: b4 0.14.1
References: <20240930-add-cpu-type-v4-0-104892b7ab5f@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240930-add-cpu-type-v4-0-104892b7ab5f@linux.intel.com>

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



