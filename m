Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EDB845C375
	for <lists+linux-pm@lfdr.de>; Mon,  1 Jul 2019 21:07:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726757AbfGATHt (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 1 Jul 2019 15:07:49 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:36502 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726668AbfGATHs (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 1 Jul 2019 15:07:48 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 726AF60909; Mon,  1 Jul 2019 19:07:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1562008067;
        bh=JOuG+nTYGCjaeKzLDowBOJbURARYzc8K6dnbmDqxo5w=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=ck38QBfhx0ASNbTLUs/P7hIZ/CHzVCxwrz+NbEpXD3OEIsHZe2T6LtR8briEtk0LK
         GWqgTvbW+tP+p+Wwb7vlXbN2cYcPcppYPG6jK6ituM1S012ZCzq3dgQwy3BCYYW5Nf
         KzSOwmJDz16LR+fzu6wOimuHBwIGOz3ZxAR8WRr4=
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=2.0 tests=ALL_TRUSTED,BAYES_00,
        DKIM_INVALID,DKIM_SIGNED,SPF_NONE autolearn=no autolearn_force=no
        version=3.4.0
Received: from [10.226.58.28] (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: jhugo@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 1039860159;
        Mon,  1 Jul 2019 19:07:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1562008066;
        bh=JOuG+nTYGCjaeKzLDowBOJbURARYzc8K6dnbmDqxo5w=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=LU5l7gGr1FEPmta4AJmGEQAPQFGo0rdKD+PFdW62YuNsghwk7IwzUe6tzRFn6F7js
         PyWhjfYebOvd+IaTv+2fyeLFffPjkvQUKRJ/KTt/WY3HqzlSUUaWp1m3/ThDO3xO16
         QU7nH04rCu8zINAGQPc/dTsdQoiuGfUSocRV9tp4=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 1039860159
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=jhugo@codeaurora.org
Subject: Re: [PATCH 4/5] drm/msm/dsi: get the clocks into OFF state at init
To:     Rob Clark <robdclark@gmail.com>
Cc:     dri-devel <dri-devel@lists.freedesktop.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        freedreno <freedreno@lists.freedesktop.org>,
        aarch64-laptops@lists.linaro.org,
        linux-clk <linux-clk@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Rob Clark <robdclark@chromium.org>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Jordan Crouse <jcrouse@codeaurora.org>,
        Abhinav Kumar <abhinavk@codeaurora.org>,
        Sibi Sankar <sibis@codeaurora.org>,
        Mamta Shukla <mamtashukla555@gmail.com>,
        Chandan Uddaraju <chandanu@codeaurora.org>,
        Archit Taneja <architt@codeaurora.org>,
        Rajesh Yadav <ryadav@codeaurora.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20190630150230.7878-1-robdclark@gmail.com>
 <20190630150230.7878-5-robdclark@gmail.com>
 <75a2921d-bf1a-c4c1-6d9a-122474eface4@codeaurora.org>
 <CAF6AEGufiSU_sFZFdLH=KT5iCQGwccszURqAQCHd=dhuZafvZg@mail.gmail.com>
From:   Jeffrey Hugo <jhugo@codeaurora.org>
Message-ID: <9fbf9226-578a-90aa-693d-9ea4fcda8281@codeaurora.org>
Date:   Mon, 1 Jul 2019 13:07:44 -0600
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <CAF6AEGufiSU_sFZFdLH=KT5iCQGwccszURqAQCHd=dhuZafvZg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 7/1/2019 12:58 PM, Rob Clark wrote:
> On Mon, Jul 1, 2019 at 11:37 AM Jeffrey Hugo <jhugo@codeaurora.org> wrote:
>>
>> On 6/30/2019 9:01 AM, Rob Clark wrote:
>>> From: Rob Clark <robdclark@chromium.org>
>>>
>>> Do an extra enable/disable cycle at init, to get the clks into disabled
>>> state in case bootloader left them enabled.
>>>
>>> In case they were already enabled, the clk_prepare_enable() has no real
>>> effect, other than getting the enable_count/prepare_count into the right
>>> state so that we can disable clocks in the correct order.  This way we
>>> avoid having stuck clocks when we later want to do a modeset and set the
>>> clock rates.
>>>
>>> Signed-off-by: Rob Clark <robdclark@chromium.org>
>>> ---
>>>    drivers/gpu/drm/msm/dsi/dsi_host.c         | 18 +++++++++++++++---
>>>    drivers/gpu/drm/msm/dsi/pll/dsi_pll_10nm.c |  1 +
>>>    2 files changed, 16 insertions(+), 3 deletions(-)
>>>
>>> diff --git a/drivers/gpu/drm/msm/dsi/pll/dsi_pll_10nm.c b/drivers/gpu/drm/msm/dsi/pll/dsi_pll_10nm.c
>>> index aabab6311043..d0172d8db882 100644
>>> --- a/drivers/gpu/drm/msm/dsi/pll/dsi_pll_10nm.c
>>> +++ b/drivers/gpu/drm/msm/dsi/pll/dsi_pll_10nm.c
>>> @@ -354,6 +354,7 @@ static int dsi_pll_10nm_lock_status(struct dsi_pll_10nm *pll)
>>>        if (rc)
>>>                pr_err("DSI PLL(%d) lock failed, status=0x%08x\n",
>>>                       pll->id, status);
>>> +rc = 0; // HACK, this will fail if PLL already running..
>>
>> Umm, why?  Is this intentional?
>>
> 
> I need to sort out a proper solution for this.. but PLL lock will fail
> if the clk is already running (which, in that case, is fine since it
> is already running and locked), which will cause the clk_enable to
> fail..
> 
> I guess there is some way that I can check that clk is already running
> and skip this check..


I'm sorry, but this makes no sense to me.  What clock are we talking 
about here?

If the pll is locked, the the lock check should just drop through.  If 
the pll cannot lock, you have an issue.  I'm confused as to how any of 
the downstream clocks can actually be running if the pll isn't locked.

I feel like we are not yet on the same page about what situation you 
seem to be in.  Can you describe in exacting detail?

