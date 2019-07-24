Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CBFFA731A9
	for <lists+linux-pm@lfdr.de>; Wed, 24 Jul 2019 16:29:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726990AbfGXO3a (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 24 Jul 2019 10:29:30 -0400
Received: from mx1.redhat.com ([209.132.183.28]:54486 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726910AbfGXO3a (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 24 Jul 2019 10:29:30 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 5DFB630833B2;
        Wed, 24 Jul 2019 14:29:29 +0000 (UTC)
Received: from prarit.bos.redhat.com (prarit-guest.khw1.lab.eng.bos.redhat.com [10.16.200.63])
        by smtp.corp.redhat.com (Postfix) with ESMTP id A6E5A60A9F;
        Wed, 24 Jul 2019 14:29:28 +0000 (UTC)
Subject: Re: [PATCH] turbostat: Fix Haswell Core systems
To:     Kosuke Tatsukawa <tatsu@ab.jp.nec.com>
Cc:     "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        Len Brown <lenb@kernel.org>
References: <17EC94B0A072C34B8DCF0D30AD16044A02A66DD0@BPXM09GP.gisp.nec.co.jp>
From:   Prarit Bhargava <prarit@redhat.com>
Message-ID: <263dbd7a-6149-afb3-eb7b-23ee40a8875d@redhat.com>
Date:   Wed, 24 Jul 2019 10:29:28 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <17EC94B0A072C34B8DCF0D30AD16044A02A66DD0@BPXM09GP.gisp.nec.co.jp>
Content-Type: text/plain; charset=iso-2022-jp
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.44]); Wed, 24 Jul 2019 14:29:29 +0000 (UTC)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org



On 6/9/19 11:14 PM, Kosuke Tatsukawa wrote:
> Hi,
> 
>> On Haswell (model 0x3C) turbostat fails with
>>
>> turbostat: cpu0: msr offset 0x630 read failed: Input/output error
>>
>> because Haswell Core does not have C8-C10.
>>
>> Output C8-C10 only on Haswell ULT.
> 
> has_hsw_msrs() uses the model number returned by intel_model_duplicates(),
> but commit f5a4c76ad7de added code to return INTEL_FAM6_HASWELL_CORE for
> INTEL_FAM6_HASWELL_ULT there.  So I think Haswell UTL also doesn't
> output C8-C10 with your patch.
> 
> Something similar to the below patch is needed to differentiate between
> INTEL_FAM6_HASWELL_CORE and INTEL_FAM6_HASWELL_ULT.  I don't have a
> Haswell-ULT machine, so I've only tested it on a Haswell-DT CPU.
> 

Kosuke, my apologies this was in my junk folder and I just found it.

Yes.  I agree with your patch below.  I will resubmit.  OK to add Signed-off-by
from you?

P.

> Best regards.
> 
>> Fixes: f5a4c76ad7de ("tools/power turbostat: consolidate duplicate model
>> numbers")
>> Cc: Len Brown <len.brown@intel.com>
>> ---
>>  tools/power/x86/turbostat/turbostat.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/tools/power/x86/turbostat/turbostat.c b/tools/power/x86/turbostat/turbostat.c
>> index c7727be9719f..ec8797005731 100644
>> --- a/tools/power/x86/turbostat/turbostat.c
>> +++ b/tools/power/x86/turbostat/turbostat.c
>> @@ -4296,7 +4296,7 @@ int has_hsw_msrs(unsigned int family, unsigned int model)
>> 		return 0;
>>
>> 	switch (model) {
>> -	case INTEL_FAM6_HASWELL_CORE:
>> +	case INTEL_FAM6_HASWELL_ULT:
>> 	case INTEL_FAM6_BROADWELL_CORE:	/* BDW */
>> 	case INTEL_FAM6_SKYLAKE_MOBILE:	/* SKL */
>> 	case INTEL_FAM6_CANNONLAKE_MOBILE:	/* CNL */
>> -- 
>> 2.21.0
> 
> 
> diff --git a/tools/power/x86/turbostat/turbostat.c b/tools/power/x86/turbostat/turbostat.c
> index 75fc4fb..5830552 100644
> --- a/tools/power/x86/turbostat/turbostat.c
> +++ b/tools/power/x86/turbostat/turbostat.c
> @@ -3209,6 +3209,7 @@ int probe_nhm_msrs(unsigned int family, unsigned int model)
>  		break;
>  	case INTEL_FAM6_HASWELL_CORE:	/* HSW */
>  	case INTEL_FAM6_HASWELL_X:	/* HSX */
> +	case INTEL_FAM6_HASWELL_ULT:	/* HSW */
>  	case INTEL_FAM6_HASWELL_GT3E:	/* HSW */
>  	case INTEL_FAM6_BROADWELL_CORE:	/* BDW */
>  	case INTEL_FAM6_BROADWELL_GT3E:	/* BDW */
> @@ -3405,6 +3406,7 @@ int has_config_tdp(unsigned int family, unsigned int model)
>  	case INTEL_FAM6_IVYBRIDGE:	/* IVB */
>  	case INTEL_FAM6_HASWELL_CORE:	/* HSW */
>  	case INTEL_FAM6_HASWELL_X:	/* HSX */
> +	case INTEL_FAM6_HASWELL_ULT:	/* HSW */
>  	case INTEL_FAM6_HASWELL_GT3E:	/* HSW */
>  	case INTEL_FAM6_BROADWELL_CORE:	/* BDW */
>  	case INTEL_FAM6_BROADWELL_GT3E:	/* BDW */
> @@ -3841,6 +3843,7 @@ void rapl_probe_intel(unsigned int family, unsigned int model)
>  	case INTEL_FAM6_SANDYBRIDGE:
>  	case INTEL_FAM6_IVYBRIDGE:
>  	case INTEL_FAM6_HASWELL_CORE:	/* HSW */
> +	case INTEL_FAM6_HASWELL_ULT:	/* HSW */
>  	case INTEL_FAM6_HASWELL_GT3E:	/* HSW */
>  	case INTEL_FAM6_BROADWELL_CORE:	/* BDW */
>  	case INTEL_FAM6_BROADWELL_GT3E:	/* BDW */
> @@ -4032,6 +4035,7 @@ void perf_limit_reasons_probe(unsigned int family, unsigned int model)
>  
>  	switch (model) {
>  	case INTEL_FAM6_HASWELL_CORE:	/* HSW */
> +	case INTEL_FAM6_HASWELL_ULT:	/* HSW */
>  	case INTEL_FAM6_HASWELL_GT3E:	/* HSW */
>  		do_gfx_perf_limit_reasons = 1;
>  	case INTEL_FAM6_HASWELL_X:	/* HSX */
> @@ -4251,6 +4255,7 @@ int has_snb_msrs(unsigned int family, unsigned int model)
>  	case INTEL_FAM6_IVYBRIDGE_X:	/* IVB Xeon */
>  	case INTEL_FAM6_HASWELL_CORE:	/* HSW */
>  	case INTEL_FAM6_HASWELL_X:	/* HSW */
> +	case INTEL_FAM6_HASWELL_ULT:	/* HSW */
>  	case INTEL_FAM6_HASWELL_GT3E:	/* HSW */
>  	case INTEL_FAM6_BROADWELL_CORE:	/* BDW */
>  	case INTEL_FAM6_BROADWELL_GT3E:	/* BDW */
> @@ -4284,7 +4289,7 @@ int has_hsw_msrs(unsigned int family, unsigned int model)
>  		return 0;
>  
>  	switch (model) {
> -	case INTEL_FAM6_HASWELL_CORE:
> +	case INTEL_FAM6_HASWELL_ULT:	/* HSW */
>  	case INTEL_FAM6_BROADWELL_CORE:	/* BDW */
>  	case INTEL_FAM6_SKYLAKE_MOBILE:	/* SKL */
>  	case INTEL_FAM6_CANNONLAKE_MOBILE:	/* CNL */
> @@ -4568,9 +4573,6 @@ unsigned int intel_model_duplicates(unsigned int model)
>  	case INTEL_FAM6_XEON_PHI_KNM:
>  		return INTEL_FAM6_XEON_PHI_KNL;
>  
> -	case INTEL_FAM6_HASWELL_ULT:
> -		return INTEL_FAM6_HASWELL_CORE;
> -
>  	case INTEL_FAM6_BROADWELL_X:
>  	case INTEL_FAM6_BROADWELL_XEON_D:	/* BDX-DE */
>  		return INTEL_FAM6_BROADWELL_X;
> 
