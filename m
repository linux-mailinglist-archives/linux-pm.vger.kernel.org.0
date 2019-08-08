Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5689D8653C
	for <lists+linux-pm@lfdr.de>; Thu,  8 Aug 2019 17:10:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732725AbfHHPKy (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 8 Aug 2019 11:10:54 -0400
Received: from mga03.intel.com ([134.134.136.65]:51676 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732404AbfHHPKy (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Thu, 8 Aug 2019 11:10:54 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 08 Aug 2019 08:10:54 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,361,1559545200"; 
   d="scan'208";a="374881703"
Received: from rbhardw1-mobl.gar.corp.intel.com (HELO [10.252.86.4]) ([10.252.86.4])
  by fmsmga006.fm.intel.com with ESMTP; 08 Aug 2019 08:10:50 -0700
Subject: Re: [PATCH] x86/cpu: Add Elkhart Lake to Intel family
To:     Peter Zijlstra <peterz@infradead.org>,
        "Liang, Kan" <kan.liang@linux.intel.com>
Cc:     x86@kernel.org, bp@suse.de, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Qiuxu Zhuo <qiuxu.zhuo@intel.com>, Len Brown <lenb@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Linux PM <linux-pm@vger.kernel.org>
References: <20190808101045.19239-1-rajneesh.bhardwaj@linux.intel.com>
 <9ea08a94-a3e0-0e89-401b-a240e1bce7fa@linux.intel.com>
 <20190808141427.GI2369@hirez.programming.kicks-ass.net>
From:   "Bhardwaj, Rajneesh" <rajneesh.bhardwaj@linux.intel.com>
Message-ID: <599ca9b6-442a-3764-e117-0311f995bb51@linux.intel.com>
Date:   Thu, 8 Aug 2019 20:40:49 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190808141427.GI2369@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


On 08-Aug-19 7:44 PM, Peter Zijlstra wrote:
> On Thu, Aug 08, 2019 at 09:19:23AM -0400, Liang, Kan wrote:
>>
>> On 8/8/2019 6:10 AM, Rajneesh Bhardwaj wrote:
>>> Elkhart Lake is Atom based SoC that uses model number 0x96. CPUID details
>>> will be documented in a future version of Intel Software Development
>>> Manual.
>>>
>>> Cc: bp@suse.de
>>> Cc: Borislav Petkov <bp@alien8.de>
>>> Cc: Dave Hansen <dave.hansen@linux.intel.com>
>>> Cc: "H. Peter Anvin" <hpa@zytor.com>
>>> Cc: Kan Liang <kan.liang@linux.intel.com>
>>> Cc: Peter Zijlstra <peterz@infradead.org>
>>> Cc: Qiuxu Zhuo <qiuxu.zhuo@intel.com>
>>> Cc: Len Brown <lenb@kernel.org>
>>> Cc: Thomas Gleixner <tglx@linutronix.de>
>>> Cc: x86-ml <x86@kernel.org>
>>> Cc: Linux PM <linux-pm@vger.kernel.org>
>>> Signed-off-by: Rajneesh Bhardwaj <rajneesh.bhardwaj@linux.intel.com>
>>> ---
>>>    arch/x86/include/asm/intel-family.h | 1 +
>>>    1 file changed, 1 insertion(+)
>>>
>>> diff --git a/arch/x86/include/asm/intel-family.h b/arch/x86/include/asm/intel-family.h
>>> index 0278aa66ef62..06e94ae65f28 100644
>>> --- a/arch/x86/include/asm/intel-family.h
>>> +++ b/arch/x86/include/asm/intel-family.h
>>> @@ -79,6 +79,7 @@
>>>    #define INTEL_FAM6_ATOM_GOLDMONT_PLUS	0x7A /* Gemini Lake */
>>>    #define INTEL_FAM6_ATOM_TREMONT_X	0x86 /* Jacobsville */
>>> +#define INTEL_FAM6_ATOM_ELKHART_LAKE	0x96 /*Elkhart Lake */
>> Usually, we should use the code name of microarchitecture for the name of
>> CPUID.
> Oh yes, very much. A quick google seems to suggest these are in fact
> Tremont cores. So then the naming should be:
>
>    INTEL_FAM6_ATOM_TREMONT_xxx

Sure, I feel INTEL_FAM6_ATOM_TREMONT_ELKHART_LAKE may be too long so is 
INTEL_FAM6_ATOM_TREMONT_PLUS a better name?


>
>
