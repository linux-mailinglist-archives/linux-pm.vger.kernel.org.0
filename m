Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EABE7595F6
	for <lists+linux-pm@lfdr.de>; Fri, 28 Jun 2019 10:21:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726508AbfF1IVp (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 28 Jun 2019 04:21:45 -0400
Received: from mga03.intel.com ([134.134.136.65]:5861 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726463AbfF1IVp (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Fri, 28 Jun 2019 04:21:45 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 28 Jun 2019 01:21:43 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.63,427,1557212400"; 
   d="scan'208";a="164596648"
Received: from rbhardw1-mobl.gar.corp.intel.com (HELO [10.66.75.132]) ([10.66.75.132])
  by fmsmga007.fm.intel.com with ESMTP; 28 Jun 2019 01:21:39 -0700
Subject: Re: [PATCH 2/2] powercap/rapl: Add Ice Lake NNPI support to RAPL
 driver
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc:     linux-kernel@vger.kernel.org, len.brown@intel.com,
        rafael.j.wysocki@intel.com, linux-pm@vger.kernel.org
References: <20190614080523.13464-1-rajneesh.bhardwaj@linux.intel.com>
 <2359736.lHFMKXy7DL@kreacher>
From:   "Bhardwaj, Rajneesh" <rajneesh.bhardwaj@linux.intel.com>
Message-ID: <52eaefed-8f94-8cb0-0cfa-c0c16a34bd0b@linux.intel.com>
Date:   Fri, 28 Jun 2019 13:51:41 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <2359736.lHFMKXy7DL@kreacher>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


On 28-Jun-19 3:32 AM, Rafael J. Wysocki wrote:
> On Friday, June 14, 2019 10:05:23 AM CEST Rajneesh Bhardwaj wrote:
>> Enables support for ICL-NNPI, which is a neural network processor for deep
>> learning inference. From RAPL point of view it is same as Ice Lake Mobile
>> processor.
>>
>> Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>
>> Cc: linux-pm@vger.kernel.org
>> Link: https://lkml.org/lkml/2019/6/5/1034
>> Signed-off-by: Rajneesh Bhardwaj <rajneesh.bhardwaj@linux.intel.com>
>> ---
>>   drivers/powercap/intel_rapl.c | 1 +
>>   1 file changed, 1 insertion(+)
>>
>> diff --git a/drivers/powercap/intel_rapl.c b/drivers/powercap/intel_rapl.c
>> index 4347f15165f8..431c8c8bdf07 100644
>> --- a/drivers/powercap/intel_rapl.c
>> +++ b/drivers/powercap/intel_rapl.c
>> @@ -1157,6 +1157,7 @@ static const struct x86_cpu_id rapl_ids[] __initconst = {
>>   	INTEL_CPU_FAM6(KABYLAKE_DESKTOP,	rapl_defaults_core),
>>   	INTEL_CPU_FAM6(CANNONLAKE_MOBILE,	rapl_defaults_core),
>>   	INTEL_CPU_FAM6(ICELAKE_MOBILE,		rapl_defaults_core),
>> +	INTEL_CPU_FAM6(ICELAKE_NNPI,		rapl_defaults_core),
>>   
>>   	INTEL_CPU_FAM6(ATOM_SILVERMONT,		rapl_defaults_byt),
>>   	INTEL_CPU_FAM6(ATOM_AIRMONT,		rapl_defaults_cht),
>>
> It is in my queue, but I get build errors when I try to apply it.
>
> I guess the definition of ICELAKE_NNPI is not there in the Linus' tree yet.

Yes, though 
https://www.spinics.net/lists/linux-tip-commits/msg48978.html is 
accepted by Thomas already.


>
>
>
