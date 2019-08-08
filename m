Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EE00C8670F
	for <lists+linux-pm@lfdr.de>; Thu,  8 Aug 2019 18:27:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732302AbfHHQ1m (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 8 Aug 2019 12:27:42 -0400
Received: from mga01.intel.com ([192.55.52.88]:53283 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729925AbfHHQ1m (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Thu, 8 Aug 2019 12:27:42 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 08 Aug 2019 09:27:37 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,362,1559545200"; 
   d="scan'208";a="374205601"
Received: from linux.intel.com ([10.54.29.200])
  by fmsmga005.fm.intel.com with ESMTP; 08 Aug 2019 09:27:36 -0700
Received: from [10.251.21.180] (kliang2-mobl.ccr.corp.intel.com [10.251.21.180])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by linux.intel.com (Postfix) with ESMTPS id 7878458043A;
        Thu,  8 Aug 2019 09:27:35 -0700 (PDT)
Subject: Re: [PATCH] x86/cpu: Add Elkhart Lake to Intel family
To:     "Bhardwaj, Rajneesh" <rajneesh.bhardwaj@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     x86@kernel.org, bp@suse.de, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Qiuxu Zhuo <qiuxu.zhuo@intel.com>, Len Brown <lenb@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Linux PM <linux-pm@vger.kernel.org>
References: <20190808101045.19239-1-rajneesh.bhardwaj@linux.intel.com>
 <9ea08a94-a3e0-0e89-401b-a240e1bce7fa@linux.intel.com>
 <20190808141427.GI2369@hirez.programming.kicks-ass.net>
 <599ca9b6-442a-3764-e117-0311f995bb51@linux.intel.com>
 <20190808152326.GL2369@hirez.programming.kicks-ass.net>
 <20190808153144.GM2369@hirez.programming.kicks-ass.net>
 <76d459fd-5d23-6d1a-1d2d-30205ec5a518@linux.intel.com>
From:   "Liang, Kan" <kan.liang@linux.intel.com>
Message-ID: <5a331216-de2d-c89f-2851-a3b92400bc5b@linux.intel.com>
Date:   Thu, 8 Aug 2019 12:27:34 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <76d459fd-5d23-6d1a-1d2d-30205ec5a518@linux.intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org



On 8/8/2019 11:50 AM, Bhardwaj, Rajneesh wrote:
> 
> On 08-Aug-19 9:01 PM, Peter Zijlstra wrote:
>> On Thu, Aug 08, 2019 at 05:23:26PM +0200, Peter Zijlstra wrote:
>>> On Thu, Aug 08, 2019 at 08:40:49PM +0530, Bhardwaj, Rajneesh wrote:
>>>> On 08-Aug-19 7:44 PM, Peter Zijlstra wrote:
>>>>> On Thu, Aug 08, 2019 at 09:19:23AM -0400, Liang, Kan wrote:
>>>>>> Usually, we should use the code name of microarchitecture for the 
>>>>>> name of
>>>>>> CPUID.
>>>>> Oh yes, very much. A quick google seems to suggest these are in fact
>>>>> Tremont cores. So then the naming should be:
>>>>>
>>>>>     INTEL_FAM6_ATOM_TREMONT_xxx
>>>> Sure, I feel INTEL_FAM6_ATOM_TREMONT_ELKHART_LAKE may be too long so is
>>>> INTEL_FAM6_ATOM_TREMONT_PLUS a better name?
>>> Neither. WikiChip says it is the successor to Denverton, which is a
>>> server chip. If this is true then:
>>>
>>> #define INTEL_FAM6_ATOM_TREMONT_X    0x.. /* Elkhart Lake */
>>>
>>> is what it should be.
>> Of course we already have a TREMONT_X :-/ WikiChip is also confusing me
>> further by stating that Jacobsville is the platform that carries the
>> Elkhart Lake core, so they should be the bloody same chip.
>>
>> But here we are, with two different model numbers.
>>
>> Can someone please spell out in dummy language wth these chips are?
>>
>> Are they both server chips?
> 
> 
> Elkhart Lake is Intel Atom based CPU product targeting primarily PC 
> Client, IOT and industrial segments.  Jacobsville is Atom (Tremont) 
> based Microserver.
> 
> Internally, preferred acronym for Elkhart Lake is EHL so does 
> INTEL_FAM6_ATOM_TREMONT_EHL look ok?

I think only the name of microarchitecture should be good enough, 
INTEL_FAM6_ATOM_TREMONT.
We usually don't add the platform's acronym to the name of CPUID.

Thanks,
Kan

