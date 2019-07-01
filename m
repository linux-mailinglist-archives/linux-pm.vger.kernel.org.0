Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6AA035C31A
	for <lists+linux-pm@lfdr.de>; Mon,  1 Jul 2019 20:37:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726757AbfGAShu (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 1 Jul 2019 14:37:50 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:51710 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725853AbfGASht (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 1 Jul 2019 14:37:49 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id C2C3C6081E; Mon,  1 Jul 2019 18:37:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1562006267;
        bh=8fNYQV/mX48XAQ/7BIca3VAe6+C0LHKpD0No3pF+wh8=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=AInBaBeCGy4MNIoUUIrby009e1q7FOqQZE9CK+ZBM71SHkJKCs53J+1OAAjLsYcPj
         20MbG4abYW9GyXm34jMgeKPXl4KT9Mz1eH+mG55rdTMu7CtybyEaR2frlAOOVhWro3
         jjzcWu1FfAcW7Q9/Rf6BXoAYVvP5bWRgAZNOb2pg=
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
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 6398E6025A;
        Mon,  1 Jul 2019 18:37:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1562006266;
        bh=8fNYQV/mX48XAQ/7BIca3VAe6+C0LHKpD0No3pF+wh8=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=g/aIB2b1vMtE9WRT9Ka77ODQA0C5O2r+3ZRQOHVvVF5yFyB5LFm15VD0vPNd245q9
         zInHPA/A8x/rGw6oJV73DB/7YKYsgPVGyNY6PznWRvDlQ3hhyhqARP6FoqP0UWj/R5
         mKcnwrMX+tky0L5Nte4vZnrpVNxLuO6fxVWoiVew=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 6398E6025A
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=jhugo@codeaurora.org
Subject: Re: [PATCH 4/5] drm/msm/dsi: get the clocks into OFF state at init
To:     Rob Clark <robdclark@gmail.com>, dri-devel@lists.freedesktop.org,
        linux-arm-msm@vger.kernel.org
Cc:     freedreno@lists.freedesktop.org, aarch64-laptops@lists.linaro.org,
        linux-clk@vger.kernel.org, linux-pm@vger.kernel.org,
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
        linux-kernel@vger.kernel.org
References: <20190630150230.7878-1-robdclark@gmail.com>
 <20190630150230.7878-5-robdclark@gmail.com>
From:   Jeffrey Hugo <jhugo@codeaurora.org>
Message-ID: <75a2921d-bf1a-c4c1-6d9a-122474eface4@codeaurora.org>
Date:   Mon, 1 Jul 2019 12:37:44 -0600
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190630150230.7878-5-robdclark@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 6/30/2019 9:01 AM, Rob Clark wrote:
> From: Rob Clark <robdclark@chromium.org>
> 
> Do an extra enable/disable cycle at init, to get the clks into disabled
> state in case bootloader left them enabled.
> 
> In case they were already enabled, the clk_prepare_enable() has no real
> effect, other than getting the enable_count/prepare_count into the right
> state so that we can disable clocks in the correct order.  This way we
> avoid having stuck clocks when we later want to do a modeset and set the
> clock rates.
> 
> Signed-off-by: Rob Clark <robdclark@chromium.org>
> ---
>   drivers/gpu/drm/msm/dsi/dsi_host.c         | 18 +++++++++++++++---
>   drivers/gpu/drm/msm/dsi/pll/dsi_pll_10nm.c |  1 +
>   2 files changed, 16 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/gpu/drm/msm/dsi/pll/dsi_pll_10nm.c b/drivers/gpu/drm/msm/dsi/pll/dsi_pll_10nm.c
> index aabab6311043..d0172d8db882 100644
> --- a/drivers/gpu/drm/msm/dsi/pll/dsi_pll_10nm.c
> +++ b/drivers/gpu/drm/msm/dsi/pll/dsi_pll_10nm.c
> @@ -354,6 +354,7 @@ static int dsi_pll_10nm_lock_status(struct dsi_pll_10nm *pll)
>   	if (rc)
>   		pr_err("DSI PLL(%d) lock failed, status=0x%08x\n",
>   		       pll->id, status);
> +rc = 0; // HACK, this will fail if PLL already running..

Umm, why?  Is this intentional?


-- 
Jeffrey Hugo
Qualcomm Datacenter Technologies as an affiliate of Qualcomm 
Technologies, Inc.
Qualcomm Technologies, Inc. is a member of the
Code Aurora Forum, a Linux Foundation Collaborative Project.
