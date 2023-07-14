Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2098A75440E
	for <lists+linux-pm@lfdr.de>; Fri, 14 Jul 2023 23:02:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236344AbjGNVC5 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 14 Jul 2023 17:02:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229579AbjGNVCx (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 14 Jul 2023 17:02:53 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F34E2735
        for <linux-pm@vger.kernel.org>; Fri, 14 Jul 2023 14:02:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1689368572; x=1720904572;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=oo1AYuC1OfW145NSqixpxA4OqSIWXLXAKx7dHa/nciY=;
  b=dKUSxLOhZIMev3xQrwZRlos83BDLz0gLXFtXbcgVPHKEan4RyaFdv+DE
   dRFD5gsMBzw2ytp4yIiMikDRXUG48ra1OUkTyHnNtgQMuVEcuHR9Cr/bH
   CrAOepyjAePiFYfTpA7x9MGKCB7euDA/uIZdTDp30HEOqwsFbS9G+lQW8
   3f+Mz0qWH187Y6DSiXo1Qujn1kxyUeD9hY9SbkOtco03oQvDlSRIcK55E
   gOR/4BwsApuLs6uhJQ2tMQ/vwMPbpXLL/PVZHcO2uoAZVxkX+YMu8XEdF
   DhRpzNzyTOJvJ6MTPkJ2whqNYZ7bW6W6DT+TQ/iEc4nnrHBkSZJ442h5F
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10771"; a="350447842"
X-IronPort-AV: E=Sophos;i="6.01,206,1684825200"; 
   d="scan'208";a="350447842"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jul 2023 14:02:51 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10771"; a="672831227"
X-IronPort-AV: E=Sophos;i="6.01,206,1684825200"; 
   d="scan'208";a="672831227"
Received: from avandeve-mobl1.amr.corp.intel.com (HELO [10.251.9.164]) ([10.251.9.164])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jul 2023 14:02:51 -0700
Message-ID: <6dd1be2f-184b-fc0e-da28-c2244aed9d70@linux.intel.com>
Date:   Fri, 14 Jul 2023 14:02:51 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v4 3/4] intel_idle: rename 'intel_idle_hlt_irq_on()'
To:     Peter Zijlstra <peterz@infradead.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Artem Bityutskiy <dedekind1@gmail.com>, x86@kernel.org,
        Linux PM Mailing List <linux-pm@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
References: <20230710093100.918337-1-dedekind1@gmail.com>
 <20230710093100.918337-4-dedekind1@gmail.com>
 <CAJZ5v0hb9ns2yZ==n83viqniCr4QqupY+FKR2Dy0jE0Obahq_g@mail.gmail.com>
 <20230714210132.GA3275140@hirez.programming.kicks-ass.net>
Content-Language: en-US
From:   Arjan van de Ven <arjan@linux.intel.com>
In-Reply-To: <20230714210132.GA3275140@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 7/14/2023 2:01 PM, Peter Zijlstra wrote:
> On Fri, Jul 14, 2023 at 05:34:43PM +0200, Rafael J. Wysocki wrote:
>> On Mon, Jul 10, 2023 at 11:31 AM Artem Bityutskiy <dedekind1@gmail.com> wrote:
>>>
>>> From: Artem Bityutskiy <artem.bityutskiy@linux.intel.com>
>>>
>>> Rename 'intel_idle_hlt_irq_on()' to 'intel_idle_hlt_irq()' for consistency with
>>> 'intel_idle_irq()'.
>>>
>>> While on it, fix indentation in 'intel_idle_hlt_irq()' declaration to use tabs
>>> instead of white-spaces.
>>>
>>> Signed-off-by: Artem Bityutskiy <artem.bityutskiy@linux.intel.com>
>>
>> I think I can apply this right away without the rest of the series as
>> it doesn't seem to depend on the other patches.
>>
>> Any concerns regarding this?
> 
> Yeah, as per:
> 
>    https://lkml.kernel.org/r/20230711132553.GN3062772%40hirez.programming.kicks-ass.net

and it's going to get deleted - renaming is harmless for that

