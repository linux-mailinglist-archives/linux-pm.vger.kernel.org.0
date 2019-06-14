Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 93D6F456C4
	for <lists+linux-pm@lfdr.de>; Fri, 14 Jun 2019 09:49:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725812AbfFNHty (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 14 Jun 2019 03:49:54 -0400
Received: from mga07.intel.com ([134.134.136.100]:12480 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725775AbfFNHtx (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Fri, 14 Jun 2019 03:49:53 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 14 Jun 2019 00:49:53 -0700
X-ExtLoop1: 1
Received: from rbhardw1-mobl.gar.corp.intel.com (HELO [10.252.89.98]) ([10.252.89.98])
  by fmsmga008.fm.intel.com with ESMTP; 14 Jun 2019 00:49:51 -0700
Subject: Re: [PATCH 2/2] powercap/rapl: Add Ice Lake NNPI support to RAPL
 driver
To:     rjw@rjwysocki.net, linux-kernel@vger.kernel.org
Cc:     len.brown@intel.com, rafael.j.wysocki@intel.com,
        linux-pm@vger.kernel.org
References: <20190614073947.12270-1-rajneesh.bhardwaj@linux.intel.com>
 <20190614073947.12270-2-rajneesh.bhardwaj@linux.intel.com>
From:   "Bhardwaj, Rajneesh" <rajneesh.bhardwaj@linux.intel.com>
Message-ID: <2d097ac4-2533-42a1-3658-9b646d105a84@linux.intel.com>
Date:   Fri, 14 Jun 2019 13:19:50 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190614073947.12270-2-rajneesh.bhardwaj@linux.intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Rafael

On 14-Jun-19 1:09 PM, Rajneesh Bhardwaj wrote:
> Enables support for ICL-NNPI, neural network processor for deep learning
> inference. From RAPL point of view it is same as Ice Lake Mobile
> processor.
>
> Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>
> Cc: linux-pm@vger.kernel.org
> Link: https://lkml.org/lkml/2019/6/5/1034
> Signed-off-by: Rajneesh Bhardwaj <rajneesh.bhardwaj@linux.intel.com>
> ---
>   drivers/powercap/intel_rapl.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/powercap/intel_rapl.c b/drivers/powercap/intel_rapl.c
> index 4347f15165f8..19d470c73b6e 100644
> --- a/drivers/powercap/intel_rapl.c
> +++ b/drivers/powercap/intel_rapl.c
> @@ -1156,7 +1156,7 @@ static const struct x86_cpu_id rapl_ids[] __initconst = {
>   	INTEL_CPU_FAM6(KABYLAKE_MOBILE,		rapl_defaults_core),
>   	INTEL_CPU_FAM6(KABYLAKE_DESKTOP,	rapl_defaults_core),
>   	INTEL_CPU_FAM6(CANNONLAKE_MOBILE,	rapl_defaults_core),
> -	INTEL_CPU_FAM6(ICELAKE_MOBILE,		rapl_defaults_core),
> +	INTEL_CPU_FAM6(ICELAKE_NNPI,		rapl_defaults_core),

Sorry, i sent the wrong patch, please ignore this one. I will send 
another one.

Thanks.

>   	INTEL_CPU_FAM6(ATOM_SILVERMONT,		rapl_defaults_byt),
>   	INTEL_CPU_FAM6(ATOM_AIRMONT,		rapl_defaults_cht),
