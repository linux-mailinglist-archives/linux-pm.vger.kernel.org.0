Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 05FB6258912
	for <lists+linux-pm@lfdr.de>; Tue,  1 Sep 2020 09:32:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726078AbgIAHcB (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 1 Sep 2020 03:32:01 -0400
Received: from m43-7.mailgun.net ([69.72.43.7]:10169 "EHLO m43-7.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726006AbgIAHb5 (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Tue, 1 Sep 2020 03:31:57 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1598945515; h=Content-Transfer-Encoding: Content-Type:
 In-Reply-To: MIME-Version: Date: Message-ID: From: References: Cc: To:
 Subject: Sender; bh=Zfqd1NY57glLHp+F+Na2YYDd6T8pT12Sz/2at7PsBCY=; b=OYkAThpin2UUh7tKZPeLcarX2TYkm9RxNb4rvuflAmVuEG+uJCpD+Ic4Wm3GXbj3qrZhgT12
 bbS4ruUkftom4XsJd/5jANWarW+gqtBVxoY3U4gyboHT1fwprd4abokGg0gw25vEMPuznQuu
 6hkqcUOyWgsn+UKK55EQRzDe7pw=
X-Mailgun-Sending-Ip: 69.72.43.7
X-Mailgun-Sid: WyI5ZDFmMiIsICJsaW51eC1wbUB2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n03.prod.us-west-2.postgun.com with SMTP id
 5f4df8ebbe06707b34e4edca (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Tue, 01 Sep 2020 07:31:55
 GMT
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 59E7EC43395; Tue,  1 Sep 2020 07:31:55 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=2.0 tests=ALL_TRUSTED,NICE_REPLY_A,
        SPF_NONE,URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from [192.168.1.16] (unknown [61.1.231.241])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: rnayak)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 808A5C433C6;
        Tue,  1 Sep 2020 07:31:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 808A5C433C6
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=rnayak@codeaurora.org
Subject: Re: [PATCH V2 3/8] drm/msm: Unconditionally call
 dev_pm_opp_of_remove_table()
To:     Viresh Kumar <viresh.kumar@linaro.org>,
        Rob Clark <robdclark@gmail.com>, Sean Paul <sean@poorly.run>
Cc:     linux-pm@vger.kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Rafael Wysocki <rjw@rjwysocki.net>,
        Stephen Boyd <sboyd@kernel.org>, Nishanth Menon <nm@ti.com>,
        Douglas Anderson <dianders@chromium.org>,
        Naresh Kamboju <naresh.kamboju@linaro.org>,
        linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org
References: <cover.1598594714.git.viresh.kumar@linaro.org>
 <6e4110032f8711e8bb0acbeccfe66dec3b09d5c1.1598594714.git.viresh.kumar@linaro.org>
From:   Rajendra Nayak <rnayak@codeaurora.org>
Message-ID: <bc64e031-c42f-9ed2-c597-18a790a4d3bb@codeaurora.org>
Date:   Tue, 1 Sep 2020 13:01:47 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <6e4110032f8711e8bb0acbeccfe66dec3b09d5c1.1598594714.git.viresh.kumar@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


On 8/28/2020 11:37 AM, Viresh Kumar wrote:
> dev_pm_opp_of_remove_table() doesn't report any errors when it fails to
> find the OPP table with error -ENODEV (i.e. OPP table not present for
> the device). And we can call dev_pm_opp_of_remove_table()
> unconditionally here.

Its a little tricky to call things unconditionally for this driver, more below.

> 
> While at it, also create a label to put clkname.
> 
> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
> 
> ---
> V2:
> - Compare with -ENODEV only for failures.
> - Create new label to put clkname.
> ---
>   drivers/gpu/drm/msm/disp/dpu1/dpu_kms.c | 14 +++++---------
>   drivers/gpu/drm/msm/disp/dpu1/dpu_kms.h |  1 -
>   drivers/gpu/drm/msm/dsi/dsi_host.c      |  8 ++------
>   3 files changed, 7 insertions(+), 16 deletions(-)
> 
> diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_kms.c b/drivers/gpu/drm/msm/disp/dpu1/dpu_kms.c
> index c0a4d4e16d82..c8287191951f 100644
> --- a/drivers/gpu/drm/msm/disp/dpu1/dpu_kms.c
> +++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_kms.c
> @@ -1010,12 +1010,9 @@ static int dpu_bind(struct device *dev, struct device *master, void *data)
>   		return PTR_ERR(dpu_kms->opp_table);
>   	/* OPP table is optional */
>   	ret = dev_pm_opp_of_add_table(dev);
> -	if (!ret) {
> -		dpu_kms->has_opp_table = true;
> -	} else if (ret != -ENODEV) {
> +	if (ret && ret != -ENODEV) {
>   		dev_err(dev, "invalid OPP table in device tree\n");
> -		dev_pm_opp_put_clkname(dpu_kms->opp_table);
> -		return ret;
> +		goto put_clkname;

So FWIU, dpu_unbind() gets called even when dpu_bind() fails for some reason.
I tried to address that earlier [1] which I realized did not land. But with these changes
it will be even more broken unless we identify if we failed dpu_bind() before
adding the OPP table, while adding it, or all went well with opps and handle things
accordingly in dpu_unbind.

[1] https://lore.kernel.org/patchwork/patch/1275632/

>   	}
>   
>   	mp = &dpu_kms->mp;
> @@ -1037,8 +1034,8 @@ static int dpu_bind(struct device *dev, struct device *master, void *data)
>   	priv->kms = &dpu_kms->base;
>   	return ret;
>   err:
> -	if (dpu_kms->has_opp_table)
> -		dev_pm_opp_of_remove_table(dev);
> +	dev_pm_opp_of_remove_table(dev);
> +put_clkname:
>   	dev_pm_opp_put_clkname(dpu_kms->opp_table);
>   	return ret;
>   }
> @@ -1056,8 +1053,7 @@ static void dpu_unbind(struct device *dev, struct device *master, void *data)
>   	if (dpu_kms->rpm_enabled)
>   		pm_runtime_disable(&pdev->dev);
>   
> -	if (dpu_kms->has_opp_table)
> -		dev_pm_opp_of_remove_table(dev);
> +	dev_pm_opp_of_remove_table(dev);
>   	dev_pm_opp_put_clkname(dpu_kms->opp_table);
>   }
>   
> diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_kms.h b/drivers/gpu/drm/msm/disp/dpu1/dpu_kms.h
> index e140cd633071..8295979a7165 100644
> --- a/drivers/gpu/drm/msm/disp/dpu1/dpu_kms.h
> +++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_kms.h
> @@ -129,7 +129,6 @@ struct dpu_kms {
>   	bool rpm_enabled;
>   
>   	struct opp_table *opp_table;
> -	bool has_opp_table;
>   
>   	struct dss_module_power mp;
>   
> diff --git a/drivers/gpu/drm/msm/dsi/dsi_host.c b/drivers/gpu/drm/msm/dsi/dsi_host.c
> index b17ac6c27554..4335fe33250c 100644
> --- a/drivers/gpu/drm/msm/dsi/dsi_host.c
> +++ b/drivers/gpu/drm/msm/dsi/dsi_host.c
> @@ -113,7 +113,6 @@ struct msm_dsi_host {
>   	struct clk *byte_intf_clk;
>   
>   	struct opp_table *opp_table;
> -	bool has_opp_table;
>   
>   	u32 byte_clk_rate;
>   	u32 pixel_clk_rate;
> @@ -1891,9 +1890,7 @@ int msm_dsi_host_init(struct msm_dsi *msm_dsi)
>   		return PTR_ERR(msm_host->opp_table);
>   	/* OPP table is optional */
>   	ret = dev_pm_opp_of_add_table(&pdev->dev);
> -	if (!ret) {
> -		msm_host->has_opp_table = true;
> -	} else if (ret != -ENODEV) {
> +	if (ret && ret != -ENODEV) {
>   		dev_err(&pdev->dev, "invalid OPP table in device tree\n");
>   		dev_pm_opp_put_clkname(msm_host->opp_table);
>   		return ret;
> @@ -1934,8 +1931,7 @@ void msm_dsi_host_destroy(struct mipi_dsi_host *host)
>   	mutex_destroy(&msm_host->cmd_mutex);
>   	mutex_destroy(&msm_host->dev_mutex);
>   
> -	if (msm_host->has_opp_table)
> -		dev_pm_opp_of_remove_table(&msm_host->pdev->dev);
> +	dev_pm_opp_of_remove_table(&msm_host->pdev->dev);
>   	dev_pm_opp_put_clkname(msm_host->opp_table);
>   	pm_runtime_disable(&msm_host->pdev->dev);
>   }
> 

-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member
of Code Aurora Forum, hosted by The Linux Foundation
