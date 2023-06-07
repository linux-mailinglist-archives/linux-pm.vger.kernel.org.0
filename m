Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6294C726259
	for <lists+linux-pm@lfdr.de>; Wed,  7 Jun 2023 16:08:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240700AbjFGOIp (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 7 Jun 2023 10:08:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240912AbjFGOIk (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 7 Jun 2023 10:08:40 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C98F212E
        for <linux-pm@vger.kernel.org>; Wed,  7 Jun 2023 07:08:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1686146894; x=1717682894;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=Vix8+wKBfuDmlPKHLF53DrLkz+CFkclmYjggSU6jj7s=;
  b=hv9K7MGtZ3h78O5icpncvGmkqqHUVXkW/itAwfPc52TcrtsLNIF3Slmt
   ve8Oc694jd5FJSG3m87BzZflVTEUSNwxnJ3YM3xGqs6UYbea/R3KYm8AE
   cZt0yc/3w347xWtH5C0x7EixahzxI8CBmir+OrGz3O+qtlnMcX4GYmtfr
   cslkdbn6JSW85pjGKzInprPHeniXjQ2wM1VuAu/Ox/fT5ed8dGgrt1KuI
   4UfWldnizx2IEn81Wq8SRwCXRkzloTs+lrytEyXGRSFSRtZbftDQFbjmL
   JDB5oz+zJZHBXawd7SyxUbSIr5Q6tUcL3J/fnha8nsxBU11RYbu37lMc9
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10734"; a="385316968"
X-IronPort-AV: E=Sophos;i="6.00,224,1681196400"; 
   d="scan'208";a="385316968"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jun 2023 07:08:13 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10734"; a="712672561"
X-IronPort-AV: E=Sophos;i="6.00,224,1681196400"; 
   d="scan'208";a="712672561"
Received: from fitchbe-mobl2.amr.corp.intel.com (HELO [10.212.130.55]) ([10.212.130.55])
  by fmsmga007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jun 2023 07:08:12 -0700
Message-ID: <183ea3e9-87a5-c686-a135-a0eb5dd4dad8@linux.intel.com>
Date:   Wed, 7 Jun 2023 07:08:12 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.2
Subject: Re: [PATCH 1/4] intel_idle: refactor state->enter manipulation into
 its own function
Content-Language: en-US
To:     "Zhang, Rui" <rui.zhang@intel.com>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>
Cc:     "artem.bityutskiy@linux.intel.com" <artem.bityutskiy@linux.intel.com>,
        "rafael@kernel.org" <rafael@kernel.org>
References: <20230605154716.840930-1-arjan@linux.intel.com>
 <20230605154716.840930-2-arjan@linux.intel.com>
 <0626374836562df9925e440fd8dd7444d36f7025.camel@intel.com>
From:   Arjan van de Ven <arjan@linux.intel.com>
In-Reply-To: <0626374836562df9925e440fd8dd7444d36f7025.camel@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 6/7/2023 12:34 AM, Zhang, Rui wrote:
> Just one minor comment.
> 
> On Mon, 2023-06-05 at 15:47 +0000, arjan@linux.intel.com wrote:
>>
>>   
>> +static void state_update_enter_method(struct cpuidle_state *state,
>> int cstate)
>> +{
>> +       if (state->flags & CPUIDLE_FLAG_INIT_XSTATE) {
>> +               /*
>> +                * Combining with XSTATE with IBRS or IRQ_ENABLE
>> flags
>> +                * is not currently supported but this driver.
> 
> s/but/by?
> seems like a typo in the original commit.

this commit is a strict move of the existing code into a function, with zero changes
I would prefer to keep it that way obviously.
If someone wants to fix up spelling in comments that should be some completely independent commit


