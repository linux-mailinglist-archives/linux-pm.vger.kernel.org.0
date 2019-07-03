Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BBE845E251
	for <lists+linux-pm@lfdr.de>; Wed,  3 Jul 2019 12:47:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725820AbfGCKrV (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 3 Jul 2019 06:47:21 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:46746 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725796AbfGCKrU (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 3 Jul 2019 06:47:20 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 85181607DE; Wed,  3 Jul 2019 10:47:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1562150839;
        bh=EAJJi3gmJ59kawq1tWepQWDrFAsUgd0cWTVqW/judU4=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=WK27Jb9pkWRSAxcPsRmy5QIWoQupZzOYKc7Jc6Zm/2f8cyFJpClrwCtDxld4k++Cd
         t2/95dRl7oAstI5/iFUdaJDJEiTOkWIT4+j0R800ByPERVpHwzO4HejV6CdCV21bKj
         gS1ptQkWUrSKYDsNEDPrJ3Fv6cx77tbvTRXTN7gc=
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
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 5CF766025A;
        Wed,  3 Jul 2019 10:47:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1562150839;
        bh=EAJJi3gmJ59kawq1tWepQWDrFAsUgd0cWTVqW/judU4=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=WK27Jb9pkWRSAxcPsRmy5QIWoQupZzOYKc7Jc6Zm/2f8cyFJpClrwCtDxld4k++Cd
         t2/95dRl7oAstI5/iFUdaJDJEiTOkWIT4+j0R800ByPERVpHwzO4HejV6CdCV21bKj
         gS1ptQkWUrSKYDsNEDPrJ3Fv6cx77tbvTRXTN7gc=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 5CF766025A
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=rnayak@codeaurora.org
Subject: Re: [PATCH 2/2] opp: Manage empty OPP tables with clk handle
To:     Viresh Kumar <viresh.kumar@linaro.org>
Cc:     vireshk@kernel.org, sboyd@kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org
References: <20190702043643.1746-1-rnayak@codeaurora.org>
 <20190702043643.1746-2-rnayak@codeaurora.org>
 <20190703085026.xe3hwxqah76b7np3@vireshk-i7>
 <95cf4e44-d57a-9aa4-40ce-3b7013e10813@codeaurora.org>
 <20190703094746.l354nwp2gwuwhiu4@vireshk-i7>
From:   Rajendra Nayak <rnayak@codeaurora.org>
Message-ID: <c8e42b38-8ce0-c02c-98d3-6d6598dc3fad@codeaurora.org>
Date:   Wed, 3 Jul 2019 16:17:15 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <20190703094746.l354nwp2gwuwhiu4@vireshk-i7>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org



On 7/3/2019 3:17 PM, Viresh Kumar wrote:
> On 03-07-19, 14:41, Rajendra Nayak wrote:
>> []..
>>>
>>> Explain the rationale behind this code here in a comment.
>>>
>>>> +	if (!_get_opp_count(opp_table)) {
>>>> +		ret = _generic_set_opp_clk_only(dev, clk, freq);
>>>> +		goto put_opp_table;
>>>> +	}
>>>> +
>>>>    	temp_freq = old_freq;
>>>>    	old_opp = _find_freq_ceil(opp_table, &temp_freq);
>>>>    	if (IS_ERR(old_opp)) {
>>>
>>> Also, rebase over the OPP branch please:
>>
>> thanks, I will fix/rebase and repost,
>> in the meantime while I was testing this a little more I realized I also need
>> something like the change below to avoid a refcount mismatch WARN when empty OPP
>> table is removed using dev_pm_opp_of_remove_table()
>>
>> diff --git a/drivers/opp/core.c b/drivers/opp/core.c
>> index fa7d4d6d37b3..20128a88baf2 100644
>> --- a/drivers/opp/core.c
>> +++ b/drivers/opp/core.c
>> @@ -2118,7 +2118,8 @@ void _dev_pm_opp_find_and_remove_table(struct device *dev)
>>                  return;
>>          }
>> -       _put_opp_list_kref(opp_table);
>> +       if (_get_opp_count(opp_table))
>> +               _put_opp_list_kref(opp_table);
>>          /* Drop reference taken by _find_opp_table() */
>>          dev_pm_opp_put_opp_table(opp_table);
>>
>> Does this look like a good way to fix it?
> 
> No. If an OPP table only has dynamic OPPs, this will still generate
> warning. Below is the fix I would suggest. Please test it, I haven't
> tested it at all :)

thanks, yes, this seems to work.

-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member
of Code Aurora Forum, hosted by The Linux Foundation
