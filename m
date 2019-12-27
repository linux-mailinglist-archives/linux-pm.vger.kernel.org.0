Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8555E12B21A
	for <lists+linux-pm@lfdr.de>; Fri, 27 Dec 2019 07:47:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726265AbfL0Gre (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 27 Dec 2019 01:47:34 -0500
Received: from mail-pl1-f194.google.com ([209.85.214.194]:44561 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726197AbfL0Grd (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 27 Dec 2019 01:47:33 -0500
Received: by mail-pl1-f194.google.com with SMTP id az3so11362851plb.11
        for <linux-pm@vger.kernel.org>; Thu, 26 Dec 2019 22:47:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=i1jU9WYAPc4xCJGOPq7dKOHOVBSIJC7kt5waCW6o8GA=;
        b=QnOlMNeoamFT7k80Gi3W8E7wIrQQrDVW5lIfs86YZeKFKUc4hbVU56vVe3CziL2pEJ
         L0Em10TSKqhJQtnhTZcUrgtvn+uu3ToHsQTUnJeSlLtQCzzlp1ihgHTYwxllrdqxieKN
         PpvBNGA4G6kyFAkQIeZUXrc2q0jidchmksgXUuh96wwRTVO+wnTxBAQHb1WcAArdGzna
         UrpQiK9MXZnea3NR+J+WrPEbOBteNEeR/SnTDGMFAnS0MBicArmC+25W7y23jLgGqBiW
         K/hQ4cNhCqQgsglPsU1uCArOrhXtOGgV4maTeY7gFbAA6mM0UBMMw3HqUKSO7NxbaemB
         9shA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=i1jU9WYAPc4xCJGOPq7dKOHOVBSIJC7kt5waCW6o8GA=;
        b=AJsqZkX+YIPnohIgcoSEsut+nYdvUYo1Z/ZykeDAHopxtHBlxWnWiOeA4wN9UL/CYV
         +Swjx+WQWfjtu+vraVEIXeM/+Rfu1DAWsoBw+V+NP3IQHitPHv9e2avOQHCluM4qzL1H
         7WOdZX/eClq+9UvW3d0pDwF77Cy/fjH75Xk4zSTsWMwDf2MvyReHkdt+A44g8WbvBFw9
         QRHEraKYNZc+CnxnlJcYvOWEREtk+bJPWf4hfpYC7vOWv1d3iwc7rKg0TyRv/y1QbQsG
         x9QbAP/IHmu1uwbVItX4/v2bKwY/P1ZtT5YWHLoXEVwvaJynIszD46hVD11n403F9eKs
         lx4g==
X-Gm-Message-State: APjAAAVM6R5u3WxQ6l5j+HBs6cPPhgTn0TRuOgsAFlr9E5Ao2mcgBJBJ
        lMHjObL8wxUP4UYNxEbf1rfzTY/J5rw=
X-Google-Smtp-Source: APXvYqxYzqcRJTeW8lgh2UOjxmMS6lGC8m3AbQR50vG7aWXM/hganMvePsChhKRmm0NuIT26chs2vA==
X-Received: by 2002:a17:902:6906:: with SMTP id j6mr45719615plk.321.1577429253190;
        Thu, 26 Dec 2019 22:47:33 -0800 (PST)
Received: from ripper (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id q8sm36443082pgg.92.2019.12.26.22.47.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Dec 2019 22:47:32 -0800 (PST)
Date:   Thu, 26 Dec 2019 22:47:18 -0800
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Niklas Cassel <nks@flawful.org>
Cc:     "Rafael J . Wysocki" <rjw@rjwysocki.net>, linux-pm@vger.kernel.org,
        linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH 2/5] power: avs: qcom-cpr: fix unsigned expression
 compared with zero
Message-ID: <20191227064718.GK1908628@ripper>
References: <20191223141934.19837-1-nks@flawful.org>
 <20191223141934.19837-3-nks@flawful.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191223141934.19837-3-nks@flawful.org>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Mon 23 Dec 06:19 PST 2019, Niklas Cassel wrote:

> drivers/power/avs/qcom-cpr.c:1539:5-21:
> warning: unsigned expression compared with zero: drv->num_corners < 0
> 

Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>

> Reported-by: kbuild test robot <lkp@intel.com>
> Reported-by: Julia Lawall <julia.lawall@lip6.fr>
> Signed-off-by: Niklas Cassel <nks@flawful.org>
> ---
>  drivers/power/avs/qcom-cpr.c | 8 +++++---
>  1 file changed, 5 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/power/avs/qcom-cpr.c b/drivers/power/avs/qcom-cpr.c
> index a52d2cef1300..232836a1ef27 100644
> --- a/drivers/power/avs/qcom-cpr.c
> +++ b/drivers/power/avs/qcom-cpr.c
> @@ -1535,11 +1535,13 @@ static int cpr_pd_attach_dev(struct generic_pm_domain *domain,
>  	 * The reason for this is that we need to know the highest
>  	 * frequency associated with each fuse corner.
>  	 */
> -	drv->num_corners = dev_pm_opp_get_opp_count(&drv->pd.dev);
> -	if (drv->num_corners < 0) {
> -		ret = drv->num_corners;
> +	ret = dev_pm_opp_get_opp_count(&drv->pd.dev);
> +	if (ret < 0) {
> +		dev_err(drv->dev, "could not get OPP count\n");
>  		goto unlock;
>  	}
> +	drv->num_corners = ret;
> +
>  	if (drv->num_corners < 2) {
>  		dev_err(drv->dev, "need at least 2 OPPs to use CPR\n");
>  		ret = -EINVAL;
> -- 
> 2.24.1
> 
