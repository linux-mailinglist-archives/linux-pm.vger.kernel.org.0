Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7CFC17489A
	for <lists+linux-pm@lfdr.de>; Thu, 25 Jul 2019 10:01:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388695AbfGYIBI (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 25 Jul 2019 04:01:08 -0400
Received: from mga07.intel.com ([134.134.136.100]:20296 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388596AbfGYIBI (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Thu, 25 Jul 2019 04:01:08 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 25 Jul 2019 01:01:07 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,306,1559545200"; 
   d="scan'208";a="170170809"
Received: from rbhardw1-mobl.gar.corp.intel.com (HELO [10.66.75.233]) ([10.66.75.233])
  by fmsmga008.fm.intel.com with ESMTP; 25 Jul 2019 01:01:05 -0700
Subject: Re: [PATCH 2/2] powercap/rapl: Add Ice Lake NNPI support to RAPL
 driver
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc:     linux-kernel@vger.kernel.org, len.brown@intel.com,
        rafael.j.wysocki@intel.com, linux-pm@vger.kernel.org
References: <20190614080523.13464-1-rajneesh.bhardwaj@linux.intel.com>
 <2359736.lHFMKXy7DL@kreacher>
 <52eaefed-8f94-8cb0-0cfa-c0c16a34bd0b@linux.intel.com>
 <3695289.DUDsO16Ie3@kreacher>
From:   "Bhardwaj, Rajneesh" <rajneesh.bhardwaj@linux.intel.com>
Message-ID: <ec3be69b-5728-9d5a-b580-83e98c1c41ae@linux.intel.com>
Date:   Thu, 25 Jul 2019 13:31:04 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <3695289.DUDsO16Ie3@kreacher>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Rafael,

On 05-Jul-19 3:43 PM, Rafael J. Wysocki wrote:
> On Friday, June 28, 2019 10:21:41 AM CEST Bhardwaj, Rajneesh wrote:
>> On 28-Jun-19 3:32 AM, Rafael J. Wysocki wrote:
>>> On Friday, June 14, 2019 10:05:23 AM CEST Rajneesh Bhardwaj wrote:
>>>> Enables support for ICL-NNPI, which is a neural network processor for deep
>>>> learning inference. From RAPL point of view it is same as Ice Lake Mobile
>>>> processor.
>>>>
>>>> Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>
>>>> Cc: linux-pm@vger.kernel.org
>>>> Link: https://lkml.org/lkml/2019/6/5/1034
>>>> Signed-off-by: Rajneesh Bhardwaj <rajneesh.bhardwaj@linux.intel.com>
>>>> ---
>>>>    drivers/powercap/intel_rapl.c | 1 +
>>>>    1 file changed, 1 insertion(+)
>>>>
>>>> diff --git a/drivers/powercap/intel_rapl.c b/drivers/powercap/intel_rapl.c
>>>> index 4347f15165f8..431c8c8bdf07 100644
>>>> --- a/drivers/powercap/intel_rapl.c
>>>> +++ b/drivers/powercap/intel_rapl.c
>>>> @@ -1157,6 +1157,7 @@ static const struct x86_cpu_id rapl_ids[] __initconst = {
>>>>    	INTEL_CPU_FAM6(KABYLAKE_DESKTOP,	rapl_defaults_core),
>>>>    	INTEL_CPU_FAM6(CANNONLAKE_MOBILE,	rapl_defaults_core),
>>>>    	INTEL_CPU_FAM6(ICELAKE_MOBILE,		rapl_defaults_core),
>>>> +	INTEL_CPU_FAM6(ICELAKE_NNPI,		rapl_defaults_core),
>>>>    
>>>>    	INTEL_CPU_FAM6(ATOM_SILVERMONT,		rapl_defaults_byt),
>>>>    	INTEL_CPU_FAM6(ATOM_AIRMONT,		rapl_defaults_cht),
>>>>
>>> It is in my queue, but I get build errors when I try to apply it.
>>>
>>> I guess the definition of ICELAKE_NNPI is not there in the Linus' tree yet.
>> Yes, though
>> https://www.spinics.net/lists/linux-tip-commits/msg48978.html is
>> accepted by Thomas already.
> It is not in 5.2-rc7, though, AFAICS.
>
> The patch is still in my queue and waiting.


The CPUID patch on which this change depends is upstream now. 
https://github.com/torvalds/linux/blob/bed38c3e2dca01b358a62b5e73b46e875742fd75/arch/x86/include/asm/intel-family.h#L59 


Thank you

Rajneesh

>
>
>
