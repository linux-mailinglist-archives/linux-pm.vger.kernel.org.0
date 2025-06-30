Return-Path: <linux-pm+bounces-29836-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 39514AEDB23
	for <lists+linux-pm@lfdr.de>; Mon, 30 Jun 2025 13:34:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5FF4E169B21
	for <lists+linux-pm@lfdr.de>; Mon, 30 Jun 2025 11:34:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABEDD242D83;
	Mon, 30 Jun 2025 11:34:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="dNeDq6Wf"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8E731DC988;
	Mon, 30 Jun 2025 11:34:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751283258; cv=none; b=hb2WPLrFUo/7OZ5XhNEZfamJQUqKnoIBISJVXX30UnHowUzeutE+opWvoT7GQtmPx7KjrjjIF1YWAkGLel1Xirt6M0N+mqTDpt4Wn74BFRW9GUrchxoLHbcsiMrDL8M60Sfu8rTGbXlqBveR96Z6ubtFhaHeNZPxlOzmnz0AmEM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751283258; c=relaxed/simple;
	bh=7rjs2UO4TyOIPTYIMJ5GytKnyOMhcJ2QgfmKOMCrPbs=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=nyaiKt7XXVa3EIAt/AHxgJWpvBMIo7TFX8AVHThkbA5V87+FTC+U4ZzE0EeH0JhRoWWUb2mFcoSQp7QGgizsl0L6XOjdAExNBd4FmPiF9H9Zsfi4oR6NIH46l3R6ATg3WRaRUolofUq02a57etWRwTbJUnWlt2ldx9IRPHZppmY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=dNeDq6Wf; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1751283257; x=1782819257;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=7rjs2UO4TyOIPTYIMJ5GytKnyOMhcJ2QgfmKOMCrPbs=;
  b=dNeDq6WfcT3rJNhZbr1EvxOd0MJMgBaJqDPXRJieZlFax/4KgxXVFXaV
   uTbqAuRgrRI7Y+sPOjCqPSUlaLs48OhHYvIoZdfiq/IZ6jBcXw8NVMgPd
   0/S9YHiNXDRSmMa8cStjZCzZVPiT4VAhmrDnLmrE6t2KBe8uiBnXbI/Lb
   cvAdVbMYB3gatviNcFxRk7HP6NLSUQcgB6q/F/m1wNmeBqiD/RSWYMhcA
   f+u5txWYhNPaXiaWBt3BObAHJXwO7MdwLbAZ8BFbqdGReEP758fR9WT9z
   nkXDLqe5gQSPa9bp4n/0P1sTJoth9tar1silpO9pXARjWDN4L+QkkHO5w
   g==;
X-CSE-ConnectionGUID: Rd7z84+NTaiWTBa8lmruow==
X-CSE-MsgGUID: D05+o72NTAOQBuAP+iXJRw==
X-IronPort-AV: E=McAfee;i="6800,10657,11479"; a="64101331"
X-IronPort-AV: E=Sophos;i="6.16,277,1744095600"; 
   d="scan'208";a="64101331"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jun 2025 04:34:16 -0700
X-CSE-ConnectionGUID: oT8cKoigSduM7r/cTWJkrw==
X-CSE-MsgGUID: LKul3bNwQYC3OL/QBrX9vw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,277,1744095600"; 
   d="scan'208";a="157980421"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.65])
  by orviesa004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jun 2025 04:34:14 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Mon, 30 Jun 2025 14:34:10 +0300 (EEST)
To: Xi Pardee <xi.pardee@linux.intel.com>
cc: irenic.rajneesh@gmail.com, david.e.box@linux.intel.com, 
    Hans de Goede <hdegoede@redhat.com>, platform-driver-x86@vger.kernel.org, 
    LKML <linux-kernel@vger.kernel.org>, linux-pm@vger.kernel.org
Subject: Re: [PATCH v2 3/5] platform/x86:intel/pmc: Improve function to show
 substate header
In-Reply-To: <20250625063145.624585-4-xi.pardee@linux.intel.com>
Message-ID: <951682a6-66e7-cd1a-4798-c5b4f88c79ec@linux.intel.com>
References: <20250625063145.624585-1-xi.pardee@linux.intel.com> <20250625063145.624585-4-xi.pardee@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Tue, 24 Jun 2025, Xi Pardee wrote:

> Refactor pmc_core_substate_req_header_show() to accept a new argument.
> This is a preparation patch to introduce a new way to show Low Power
> Mode substate requirement data for platforms starting from Panther
> Lake. Increased the size for the name column as the Low Power Mode
> requirement register name is longer in newer platforms.
> 
> Signed-off-by: Xi Pardee <xi.pardee@linux.intel.com>
> ---
>  drivers/platform/x86/intel/pmc/core.c | 15 +++++++++------
>  1 file changed, 9 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/platform/x86/intel/pmc/core.c b/drivers/platform/x86/intel/pmc/core.c
> index a1dd80bdbd413..47cc5120e7dd6 100644
> --- a/drivers/platform/x86/intel/pmc/core.c
> +++ b/drivers/platform/x86/intel/pmc/core.c
> @@ -828,17 +828,20 @@ static int pmc_core_substate_l_sts_regs_show(struct seq_file *s, void *unused)
>  }
>  DEFINE_SHOW_ATTRIBUTE(pmc_core_substate_l_sts_regs);
>  
> -static void pmc_core_substate_req_header_show(struct seq_file *s, int pmc_index)
> +static void pmc_core_substate_req_header_show(struct seq_file *s, int pmc_index, char *name)
>  {
>  	struct pmc_dev *pmcdev = s->private;
>  	int mode;
>  
> -	seq_printf(s, "%30s |", "Element");
> +	seq_printf(s, "%40s |", "Element");
>  	pmc_for_each_mode(mode, pmcdev)
>  		seq_printf(s, " %9s |", pmc_lpm_modes[mode]);
>  
> -	seq_printf(s, " %9s |", "Status");
> -	seq_printf(s, " %11s |\n", "Live Status");
> +	if (!strcmp(name, "Status")) {

I'm not very happy passing this as string. Could we use an 
internal defines/enum instead for this differentiation?

> +		seq_printf(s, " %9s |", name);
> +		seq_printf(s, " %11s |\n", "Live Status");
> +	} else
> +		seq_printf(s, " %9s |\n", name);

Please always use braces symmetrically in both blocks.

>  }
>  
>  static int pmc_core_substate_req_regs_show(struct seq_file *s, void *unused)
> @@ -872,7 +875,7 @@ static int pmc_core_substate_req_regs_show(struct seq_file *s, void *unused)
>  			continue;
>  
>  		/* Display the header */
> -		pmc_core_substate_req_header_show(s, pmc_index);
> +		pmc_core_substate_req_header_show(s, pmc_index, "Status");
>  
>  		/* Loop over maps */
>  		for (mp = 0; mp < num_maps; mp++) {
> @@ -910,7 +913,7 @@ static int pmc_core_substate_req_regs_show(struct seq_file *s, void *unused)
>  				}
>  
>  				/* Display the element name in the first column */
> -				seq_printf(s, "pmc%d: %26s |", pmc_index, map[i].name);
> +				seq_printf(s, "pmc%d: %34s |", pmc_index, map[i].name);
>  
>  				/* Loop over the enabled states and display if required */
>  				pmc_for_each_mode(mode, pmcdev) {
> 

-- 
 i.


