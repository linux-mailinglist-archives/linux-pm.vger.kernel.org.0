Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 440E1258BF0
	for <lists+linux-pm@lfdr.de>; Tue,  1 Sep 2020 11:45:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726310AbgIAJpr (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 1 Sep 2020 05:45:47 -0400
Received: from mail29.static.mailgun.info ([104.130.122.29]:13397 "EHLO
        mail29.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726307AbgIAJpr (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 1 Sep 2020 05:45:47 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1598953546; h=Content-Transfer-Encoding: Content-Type:
 In-Reply-To: MIME-Version: Date: Message-ID: From: References: Cc: To:
 Subject: Sender; bh=b2eZhuFSLo8S06dwvehEezfz44wgJ9E7gdBWdQThQNc=; b=gBv0hnVN4WOarUCqCTztyT9P7p7u295gTxkyqqWr0KNGcP3DYtILUYRdVwhujRkSp2njTg3j
 J9Gf9nH0FidTo1kOA4+XVO7UWH3MOZQUq0nh3ZiNiom7th9ZLZ1OeD5fXegx74T+DuNrM9mR
 FC0vsTJkEaS35vvXulH4HG0K6v4=
X-Mailgun-Sending-Ip: 104.130.122.29
X-Mailgun-Sid: WyI5ZDFmMiIsICJsaW51eC1wbUB2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n01.prod.us-east-1.postgun.com with SMTP id
 5f4e1846885efaea0ab604eb (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Tue, 01 Sep 2020 09:45:42
 GMT
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 2C538C433CA; Tue,  1 Sep 2020 09:45:41 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=2.0 tests=ALL_TRUSTED,NICE_REPLY_A,
        SPF_NONE autolearn=unavailable autolearn_force=no version=3.4.0
Received: from [192.168.1.16] (unknown [61.1.231.241])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: rnayak)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 42FFAC433CB;
        Tue,  1 Sep 2020 09:45:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 42FFAC433CB
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=rnayak@codeaurora.org
Subject: Re: [PATCH V2 3/8] drm/msm: Unconditionally call
 dev_pm_opp_of_remove_table()
To:     Viresh Kumar <viresh.kumar@linaro.org>
Cc:     Rob Clark <robdclark@gmail.com>, Sean Paul <sean@poorly.run>,
        linux-pm@vger.kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Rafael Wysocki <rjw@rjwysocki.net>,
        Stephen Boyd <sboyd@kernel.org>, Nishanth Menon <nm@ti.com>,
        Douglas Anderson <dianders@chromium.org>,
        Naresh Kamboju <naresh.kamboju@linaro.org>,
        linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        saiprakash.ranjan@codeaurora.org
References: <cover.1598594714.git.viresh.kumar@linaro.org>
 <6e4110032f8711e8bb0acbeccfe66dec3b09d5c1.1598594714.git.viresh.kumar@linaro.org>
 <bc64e031-c42f-9ed2-c597-18a790a4d3bb@codeaurora.org>
 <20200901083806.a2wz7idmfce2aj3a@vireshk-i7>
From:   Rajendra Nayak <rnayak@codeaurora.org>
Message-ID: <fceb0b09-30cd-5084-0d0e-e7795cfc5fc9@codeaurora.org>
Date:   Tue, 1 Sep 2020 15:15:33 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <20200901083806.a2wz7idmfce2aj3a@vireshk-i7>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


On 9/1/2020 2:08 PM, Viresh Kumar wrote:
> On 01-09-20, 13:01, Rajendra Nayak wrote:
>> So FWIU, dpu_unbind() gets called even when dpu_bind() fails for some reason.
> 
> Ahh, I see.
> 
>> I tried to address that earlier [1] which I realized did not land.
> 
> I don't think that patch was required, as you can call
> dev_pm_opp_put_clkname() multiple times and it will return without any
> errors/crash.

We did see a crash (Sai had reported it), perhaps with dsi [1] and not this
driver. But it was the same scenario that was possible here as well, which is
dev_pm_opp_put_clkname() getting called without dev_pm_opp_set_clkname()
being done. I think we ended up passing a NULL as opp_table in that case
and the function tries de-referencing it.

> 
>> But with these changes
>> it will be even more broken unless we identify if we failed dpu_bind() before
>> adding the OPP table, while adding it, or all went well with opps and handle things
>> accordingly in dpu_unbind.
> 
> Maybe not as dev_pm_opp_of_remove_table() can be called multiple times
> as well without any errors or crash.

Can it be called without the driver ever doing a dev_pm_opp_of_add_table()?

[1] https://lore.kernel.org/patchwork/patch/1275628/
-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member
of Code Aurora Forum, hosted by The Linux Foundation
