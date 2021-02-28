Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8FD8532731B
	for <lists+linux-pm@lfdr.de>; Sun, 28 Feb 2021 16:44:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230299AbhB1PoR (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 28 Feb 2021 10:44:17 -0500
Received: from mga11.intel.com ([192.55.52.93]:12581 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230228AbhB1PoR (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Sun, 28 Feb 2021 10:44:17 -0500
IronPort-SDR: 5ooTB0pWCFQWSlAH4X1SUguk6O3g+zcYf/aI5fVJKuZ8P6Qpo2f6b2Y5NAl9LkSORWwmTRvudy
 RvH+6zNIaRWg==
X-IronPort-AV: E=McAfee;i="6000,8403,9909"; a="182859921"
X-IronPort-AV: E=Sophos;i="5.81,213,1610438400"; 
   d="scan'208";a="182859921"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Feb 2021 07:42:31 -0800
IronPort-SDR: +HjWRq1K/RLC7zS4juh4aHx8voq+CEGvmGCz8xnc2D+4yuSM0bdLXSf3Z8BLpVTw97CivYXp0v
 lpqLWUBOCLIg==
X-IronPort-AV: E=Sophos;i="5.81,213,1610438400"; 
   d="scan'208";a="405808377"
Received: from mvvallab-mobl1.amr.corp.intel.com ([10.254.180.194])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Feb 2021 07:42:30 -0800
Message-ID: <0a8f11cfbc761767b7a994f724af3dac124184c9.camel@linux.intel.com>
Subject: Re: [RFC PATCH] powercap: Add Hygon Fam18h RAPL support
From:   Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
To:     Pu Wen <puwen@hygon.cn>, linux-kernel@vger.kernel.org
Cc:     linux-pm@vger.kernel.org, rjw@rjwysocki.net, rafael@kernel.org,
        bp@alien8.de, victording@google.com, kim.phillips@amd.com,
        rui.zhang@intel.com
Date:   Sun, 28 Feb 2021 07:42:29 -0800
In-Reply-To: <20210225130129.21512-1-puwen@hygon.cn>
References: <20210225130129.21512-1-puwen@hygon.cn>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.34.4 (3.34.4-1.fc31) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Thu, 2021-02-25 at 21:01 +0800, Pu Wen wrote:
> Enable Hygon Fam18h RAPL support for the power capping framework.
> 
If this patch is tested and works on this processor, not sure why this
is RFC?

Thanks,
Srinivas

> Signed-off-by: Pu Wen <puwen@hygon.cn>
> ---
>  drivers/powercap/intel_rapl_common.c | 1 +
>  drivers/powercap/intel_rapl_msr.c    | 1 +
>  2 files changed, 2 insertions(+)
> 
> diff --git a/drivers/powercap/intel_rapl_common.c
> b/drivers/powercap/intel_rapl_common.c
> index fdda2a737186..73cf68af9770 100644
> --- a/drivers/powercap/intel_rapl_common.c
> +++ b/drivers/powercap/intel_rapl_common.c
> @@ -1069,6 +1069,7 @@ static const struct x86_cpu_id rapl_ids[]
> __initconst = {
>  
>  	X86_MATCH_VENDOR_FAM(AMD, 0x17, &rapl_defaults_amd),
>  	X86_MATCH_VENDOR_FAM(AMD, 0x19, &rapl_defaults_amd),
> +	X86_MATCH_VENDOR_FAM(HYGON, 0x18, &rapl_defaults_amd),
>  	{}
>  };
>  MODULE_DEVICE_TABLE(x86cpu, rapl_ids);
> diff --git a/drivers/powercap/intel_rapl_msr.c
> b/drivers/powercap/intel_rapl_msr.c
> index 78213d4b5b16..cc3b22881bfe 100644
> --- a/drivers/powercap/intel_rapl_msr.c
> +++ b/drivers/powercap/intel_rapl_msr.c
> @@ -150,6 +150,7 @@ static int rapl_msr_probe(struct platform_device
> *pdev)
>  	case X86_VENDOR_INTEL:
>  		rapl_msr_priv = &rapl_msr_priv_intel;
>  		break;
> +	case X86_VENDOR_HYGON:
>  	case X86_VENDOR_AMD:
>  		rapl_msr_priv = &rapl_msr_priv_amd;
>  		break;

