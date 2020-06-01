Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B00A41EA177
	for <lists+linux-pm@lfdr.de>; Mon,  1 Jun 2020 12:01:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725788AbgFAKBL (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 1 Jun 2020 06:01:11 -0400
Received: from m43-7.mailgun.net ([69.72.43.7]:29237 "EHLO m43-7.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726316AbgFAKBK (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Mon, 1 Jun 2020 06:01:10 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1591005670; h=Message-ID: References: In-Reply-To: Subject:
 Cc: To: From: Date: Content-Transfer-Encoding: Content-Type:
 MIME-Version: Sender; bh=VZgW0yWmZWnfdGXGSRXAEISoIkntsyNDe6/pKlJFF58=;
 b=gHfabsPOxHyT6AkNfhiva/GaTzeeLjZIvhNDNPUbfu5hiHymFu4DZmhatEuVkX1tJ4UZz58b
 j3dYYbaaKA9eoRHezq+GMfYT9Xg1o5wSoeQ/k6iZhDI7RerB8xkiE+uf7MCIbKH4/qypW6t9
 i8XqIFxqPTm4pIbtvOZzAreYETs=
X-Mailgun-Sending-Ip: 69.72.43.7
X-Mailgun-Sid: WyI5ZDFmMiIsICJsaW51eC1wbUB2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n06.prod.us-east-1.postgun.com with SMTP id
 5ed4d1b8c0031c71c2434c95 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Mon, 01 Jun 2020 10:00:24
 GMT
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id BE642C43391; Mon,  1 Jun 2020 10:00:23 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=2.0 tests=ALL_TRUSTED
        autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: sibis)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 2CD57C433C6;
        Mon,  1 Jun 2020 10:00:23 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Mon, 01 Jun 2020 15:30:23 +0530
From:   Sibi Sankar <sibis@codeaurora.org>
To:     Viresh Kumar <viresh.kumar@linaro.org>
Cc:     sboyd@kernel.org, georgi.djakov@linaro.org, nm@ti.com,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, saravanak@google.com, mka@chromium.org,
        smasetty@codeaurora.org, linux-arm-msm-owner@vger.kernel.org,
        linux-kernel-owner@vger.kernel.org
Subject: Re: [PATCH] OPP: Check for bandwidth values before creating icc paths
In-Reply-To: <20200601071349.gbuyfaasdu27a3bd@vireshk-i7>
References: <20200527192418.20169-1-sibis@codeaurora.org>
 <20200529052031.n2nvzxdsifwmthfv@vireshk-i7>
 <0205034b0ece173a7152a43b016985a7@codeaurora.org>
 <20200601040742.3a4cmhrwgh2ueksy@vireshk-i7>
 <ee51e55bdf518832e4ecb2faf98c6b58@codeaurora.org>
 <20200601071349.gbuyfaasdu27a3bd@vireshk-i7>
Message-ID: <4258c6b122fa352a6b5cccb07a9b1203@codeaurora.org>
X-Sender: sibis@codeaurora.org
User-Agent: Roundcube Webmail/1.3.9
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 2020-06-01 12:43, Viresh Kumar wrote:
> On 01-06-20, 12:09, Sibi Sankar wrote:
>> On 2020-06-01 09:37, Viresh Kumar wrote:
>> > On 29-05-20, 19:47, Sibi Sankar wrote:
>> > > opp_np needs to be subjected
>> > > to NULL check as well.
>> >
>> > No, it isn't. It should already be valid and is set by the OPP core.
>> > Actually we don't need to do of_node_get(opp_table->np) and just use
>> > np, I did that to not have a special case while putting the resource.
>> >
>> 
>> I should have phrased it differently.
>> opp_np needs to be checked to deal
>> with cases where devices don't have
>> "operating-points-v2" associated with
>> it.
>> 
>> diff --git a/drivers/opp/of.c b/drivers/opp/of.c
>> index a5d87ca0ab571..06976d14e6ccb 100644
>> --- a/drivers/opp/of.c
>> +++ b/drivers/opp/of.c
>> @@ -344,14 +344,14 @@ static int _bandwidth_supported(struct device 
>> *dev,
>> struct opp_table *opp_table)
>> 
>>                 opp_np = _opp_of_get_opp_desc_node(np, 0);
>>                 of_node_put(np);
>> -
>> -               /* Lets not fail in case we are parsing opp-v1 
>> bindings */
>> -               if (!opp_np)
>> -                       return 0;
>>         } else {
>>                 opp_np = of_node_get(opp_table->np);
>>         }
>> 
>> +       /* Lets not fail in case we are parsing opp-v1 bindings */
>> +       if (!opp_np)
>> +               return 0;
>> +
>> 
>> sdhci_msm 7c4000.sdhci: OPP table empty
>> sdhci_msm 7c4000.sdhci: _allocate_opp_table: Error finding 
>> interconnect
>> paths: -22
>> 
>> I see the following errors without
>> the check.
> 
> My reply unfortunately only considered the case where this routine was
> called from within the opp table. Are you testing it for the case
> where you are adding OPPs dynamically from the code ?

Yeah dev_pm_opp_add/dev_pm_opp_set_clkname
or pretty much any api doing a
dev_pm_opp_get_opp_table without
a opp_table node associated with
it will run into this issue.

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project.
