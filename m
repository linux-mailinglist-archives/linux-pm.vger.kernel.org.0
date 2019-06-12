Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AE7BC42D27
	for <lists+linux-pm@lfdr.de>; Wed, 12 Jun 2019 19:12:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2409469AbfFLRMU (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 12 Jun 2019 13:12:20 -0400
Received: from mga12.intel.com ([192.55.52.136]:14588 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2409094AbfFLRMT (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 12 Jun 2019 13:12:19 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 12 Jun 2019 10:12:19 -0700
X-ExtLoop1: 1
Received: from rbhardw1-mobl.gar.corp.intel.com (HELO [10.252.82.121]) ([10.252.82.121])
  by orsmga008.jf.intel.com with ESMTP; 12 Jun 2019 10:12:14 -0700
Subject: Re: [Patch v2] x86/cpu: Add Ice Lake NNPI to Intel family
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Dave Hansen <dave.hansen@intel.com>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org, bp@suse.de,
        Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        platform-driver-x86@vger.kernel.org,
        Qiuxu Zhuo <qiuxu.zhuo@intel.com>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Len Brown <lenb@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Linux PM <linux-pm@vger.kernel.org>
References: <20190606012419.13250-1-rajneesh.bhardwaj@linux.intel.com>
 <20190612095233.GE9224@smile.fi.intel.com>
 <73eb1ba5-dc29-53ee-487d-d22700b874a1@intel.com>
 <20190612162918.GP9224@smile.fi.intel.com>
 <414a8fe8-4c85-f323-d71c-16b231823ffe@intel.com>
 <20190612170848.GQ9224@smile.fi.intel.com>
From:   "Bhardwaj, Rajneesh" <rajneesh.bhardwaj@linux.intel.com>
Message-ID: <1a59d0cc-32f5-c06b-c951-f05c64864f7f@linux.intel.com>
Date:   Wed, 12 Jun 2019 22:42:13 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190612170848.GQ9224@smile.fi.intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


On 12-Jun-19 10:38 PM, Andy Shevchenko wrote:
> On Wed, Jun 12, 2019 at 09:33:30AM -0700, Dave Hansen wrote:
>> On 6/12/19 9:29 AM, Andy Shevchenko wrote:
>>> What I'm talking is a consistency among suffixes. If there is a real
>>> abbreviation (NNPI) which anybody can google,
>> There is and you can. :)
> Good, I have no objections.


Great, thanks Andy and Dave for your valuable comments. I see that 
Thomas has accepted this one, thanks a lot, Thomas!

https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git/commit/?id=61caa8621b9979a78b04e353ab2ee44a47ef7a62&anzwix=1 


>
