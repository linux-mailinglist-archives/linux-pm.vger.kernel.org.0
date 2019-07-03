Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 47FF35E09F
	for <lists+linux-pm@lfdr.de>; Wed,  3 Jul 2019 11:11:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727282AbfGCJLR (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 3 Jul 2019 05:11:17 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:48244 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727212AbfGCJLR (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 3 Jul 2019 05:11:17 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 1652060A97; Wed,  3 Jul 2019 09:11:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1562145076;
        bh=nX45R+dm6a1Jwcb05CDNUgx4njh6ZeQnVggN92Rhfok=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=IwyYn5xbQlKBd5czIMxMeX5+JmCORmGtYPOCCMxJFf7o2tP6ZeF1DdLW/kjhKQumd
         NjKU5M9dpWYKu8mD1sOjnlx50LUzcmRDUDLh7e2l1u3m9U8Eu1eMf0Po03lF7kmzvY
         B/NWYtuyNak548lgxE8K1YPt77Xx6H7Da8MiJW34=
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=2.0 tests=ALL_TRUSTED,BAYES_00,
        DKIM_INVALID,DKIM_SIGNED,SPF_NONE autolearn=no autolearn_force=no
        version=3.4.0
Received: from [10.79.43.141] (blr-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.18.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: rnayak@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 9D41360A0A;
        Wed,  3 Jul 2019 09:11:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1562145074;
        bh=nX45R+dm6a1Jwcb05CDNUgx4njh6ZeQnVggN92Rhfok=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=cEu0Eo/koIVPkWdry5K4U/iyWjCti1fQO0gIETQh0RFInFA5nvbtyEAz1rDl/ze/X
         sEzNwmGt7Nn2mjoQgj1ac/6VIG54hQ2COGaHhsAU8NwEh8JqvE1y5GAFKo/njRBwRd
         k7lg2EPqkAdJvYnIg4tkseG4OiD17285DOvKauH8=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 9D41360A0A
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=rnayak@codeaurora.org
Subject: Re: [PATCH 2/2] opp: Manage empty OPP tables with clk handle
To:     Viresh Kumar <viresh.kumar@linaro.org>
Cc:     vireshk@kernel.org, sboyd@kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org
References: <20190702043643.1746-1-rnayak@codeaurora.org>
 <20190702043643.1746-2-rnayak@codeaurora.org>
 <20190703085026.xe3hwxqah76b7np3@vireshk-i7>
From:   Rajendra Nayak <rnayak@codeaurora.org>
Message-ID: <95cf4e44-d57a-9aa4-40ce-3b7013e10813@codeaurora.org>
Date:   Wed, 3 Jul 2019 14:41:10 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <20190703085026.xe3hwxqah76b7np3@vireshk-i7>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

[]..
>>   
> 
> Explain the rationale behind this code here in a comment.
> 
>> +	if (!_get_opp_count(opp_table)) {
>> +		ret = _generic_set_opp_clk_only(dev, clk, freq);
>> +		goto put_opp_table;
>> +	}
>> +
>>   	temp_freq = old_freq;
>>   	old_opp = _find_freq_ceil(opp_table, &temp_freq);
>>   	if (IS_ERR(old_opp)) {
> 
> Also, rebase over the OPP branch please:

thanks, I will fix/rebase and repost,
in the meantime while I was testing this a little more I realized I also need
something like the change below to avoid a refcount mismatch WARN when empty OPP
table is removed using dev_pm_opp_of_remove_table()

diff --git a/drivers/opp/core.c b/drivers/opp/core.c
index fa7d4d6d37b3..20128a88baf2 100644
--- a/drivers/opp/core.c
+++ b/drivers/opp/core.c
@@ -2118,7 +2118,8 @@ void _dev_pm_opp_find_and_remove_table(struct device *dev)
                 return;
         }
  
-       _put_opp_list_kref(opp_table);
+       if (_get_opp_count(opp_table))
+               _put_opp_list_kref(opp_table);
  
         /* Drop reference taken by _find_opp_table() */
         dev_pm_opp_put_opp_table(opp_table);

Does this look like a good way to fix it?

-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member
of Code Aurora Forum, hosted by The Linux Foundation
