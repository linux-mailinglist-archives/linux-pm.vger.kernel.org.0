Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B32AD753F21
	for <lists+linux-pm@lfdr.de>; Fri, 14 Jul 2023 17:39:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235986AbjGNPjk (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 14 Jul 2023 11:39:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236017AbjGNPjj (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 14 Jul 2023 11:39:39 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53E8C30E5
        for <linux-pm@vger.kernel.org>; Fri, 14 Jul 2023 08:39:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1689349177; x=1720885177;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=+FXpOSO3AHbv+JZj8Bm4w9zwQH84DdhdAjvJOt2SSnI=;
  b=ROoFPTMA/GMGeuGrhVHkk6TkXVmGBUgDWoDYslkkHh3SpaUpX6OlNqOZ
   2H9lZZAmlmq0SWOOwgKuDzRJjJ+K48BSJluPRigkEw6g59Aoho3oNFjDX
   /pf2kqsUJ/0hxHkhr3Uy4gHhZ/UuetW7c39ilIvj87lyQVPEAax/VxgiI
   Z4cTCuerVznCau4pRYgEGnd6PBLFukOgp0Or49YyqO4Xsh1dXZjtZsM7U
   UhEbtdQQO4zxfIetn8KRmu1Ktjh0WK/lSjB1I9hYOZx2P5KhalMoxWGGH
   qyD06p2pY9VBqt4zLBK+zH6pcVanrGpVegx/WHrhvQBM6n0R/xk/aEFAx
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10771"; a="365542092"
X-IronPort-AV: E=Sophos;i="6.01,205,1684825200"; 
   d="scan'208";a="365542092"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jul 2023 08:39:15 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10771"; a="716375185"
X-IronPort-AV: E=Sophos;i="6.01,205,1684825200"; 
   d="scan'208";a="716375185"
Received: from avandeve-mobl1.amr.corp.intel.com (HELO [10.251.9.164]) ([10.251.9.164])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jul 2023 08:39:15 -0700
Message-ID: <02b1a9b0-6ba5-af56-283f-981c7c8855b6@linux.intel.com>
Date:   Fri, 14 Jul 2023 08:39:15 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v4 3/4] intel_idle: rename 'intel_idle_hlt_irq_on()'
Content-Language: en-US
To:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Artem Bityutskiy <dedekind1@gmail.com>
Cc:     x86@kernel.org, Linux PM Mailing List <linux-pm@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
References: <20230710093100.918337-1-dedekind1@gmail.com>
 <20230710093100.918337-4-dedekind1@gmail.com>
 <CAJZ5v0hb9ns2yZ==n83viqniCr4QqupY+FKR2Dy0jE0Obahq_g@mail.gmail.com>
From:   Arjan van de Ven <arjan@linux.intel.com>
In-Reply-To: <CAJZ5v0hb9ns2yZ==n83viqniCr4QqupY+FKR2Dy0jE0Obahq_g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 7/14/2023 8:34 AM, Rafael J. Wysocki wrote:
> On Mon, Jul 10, 2023 at 11:31 AM Artem Bityutskiy <dedekind1@gmail.com> wrote:
>>
>> From: Artem Bityutskiy <artem.bityutskiy@linux.intel.com>
>>
>> Rename 'intel_idle_hlt_irq_on()' to 'intel_idle_hlt_irq()' for consistency with
>> 'intel_idle_irq()'.
>>
>> While on it, fix indentation in 'intel_idle_hlt_irq()' declaration to use tabs
>> instead of white-spaces.
>>
>> Signed-off-by: Artem Bityutskiy <artem.bityutskiy@linux.intel.com>
> 
> I think I can apply this right away without the rest of the series as
> it doesn't seem to depend on the other patches.
> 
> Any concerns regarding this?
> 

no other than that I will likely delete some of the code in a next patch but that's ok


