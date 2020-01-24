Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 22A0C148CC1
	for <lists+linux-pm@lfdr.de>; Fri, 24 Jan 2020 18:10:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730639AbgAXRKV (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 24 Jan 2020 12:10:21 -0500
Received: from mail-pl1-f196.google.com ([209.85.214.196]:34172 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730514AbgAXRKV (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 24 Jan 2020 12:10:21 -0500
Received: by mail-pl1-f196.google.com with SMTP id q13so1055639pls.1
        for <linux-pm@vger.kernel.org>; Fri, 24 Jan 2020 09:10:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=/UDl2CSs5NDCzyt6gqztK0kBwmmG9JqPSbLXXLuCYQc=;
        b=OepOlltd59Y9qm/dr5uznRyVYp96+QSX+Ko/beCmCsK4pzEiLys0PO+iX7DII6WrvE
         u9bfWm3llOdotGn/DEWDYNhyXiV8tedVVaFMMCiUrdkcKEwYqHfNqT43Vd0fxtPeI1lj
         K34aK6l5Vw/MytdkDVxDFK4QU4pQdLj/WojyVvWNsLeIONOiaZHbiNtXvJBOVnBoAu8k
         2cZER4I0YvITci2FJ+Nml01O7jv1XreUCh0X7o01Sh+bx1YIGC81MHp5yk2Ro8tL0/Yr
         qV/ZOg6wR8KIw9qFVhpa+69tz1DbrGDAf7TZoIY6TUfJJpz9Axrxk9Oxb53tAt6xTDeX
         /rUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=/UDl2CSs5NDCzyt6gqztK0kBwmmG9JqPSbLXXLuCYQc=;
        b=f5AnzxcsJtcMbw5UwJR7w/sn/oyzHSlyAaX3fcUqC4enY8VrMqCtkAn7vPSHbGgtUF
         IXyKcEkpF5qUL+TG3aAPuBrDtRkrF+V0fPc1bmWeydSUVzdl3ykLG1Y/kMHxErsLZ3B4
         z4Xyh4ZF8StOS0TxYIGiYRNRI6+OWXb1m30PVo+gxmqf9ujKwS6ojcr8k6Cxu/ryO2MB
         r9WnoKhot4Hfp3rt26wfaWdAf4NrspeVf5R6Q66MMDG0QmCOw5G6zDDTQClekIaUkiNp
         Jaf+D4kf+F9usQPGym2UlUlLownYNNwAf3quEQ1Ulqjw4bRv6s/wN+gAuCiwCTf9yQyE
         1oww==
X-Gm-Message-State: APjAAAVTxuQRSCkVTaW6nTSRsbQMWd947BBosY8W2rKA/b4MgypdvYbN
        v0RW3B29dBuYNH12QB2pP3o1x700qUY=
X-Google-Smtp-Source: APXvYqzTd8zB8kpOgWNAOAiG+sv7OMOPcpm851dd0SMNeuw7808uPdsRExDiKP+nAwXwjVbeL/zTRw==
X-Received: by 2002:a17:902:bb93:: with SMTP id m19mr4660798pls.310.1579885820596;
        Fri, 24 Jan 2020 09:10:20 -0800 (PST)
Received: from yoga (pat_11.qualcomm.com. [192.35.156.11])
        by smtp.gmail.com with ESMTPSA id b19sm6995961pfo.56.2020.01.24.09.10.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Jan 2020 09:10:19 -0800 (PST)
Date:   Fri, 24 Jan 2020 09:10:17 -0800
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Niklas Cassel <nks@flawful.org>
Cc:     "Rafael J . Wysocki" <rjw@rjwysocki.net>, linux-pm@vger.kernel.org,
        linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH] power: avs: qcom-cpr: add a printout after the driver
 has been initialized
Message-ID: <20200124171017.GY1511@yoga>
References: <20200113200258.18031-1-nks@flawful.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200113200258.18031-1-nks@flawful.org>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Mon 13 Jan 12:02 PST 2020, Niklas Cassel wrote:

> In order to easier inform the user that the driver has been initialized
> successfully, add a printout after the driver has been initialized.
> 
> At the same time, remove a dev_dbg() that is now redundant.
> 

Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>

> Signed-off-by: Niklas Cassel <nks@flawful.org>
> ---
>  drivers/power/avs/qcom-cpr.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/power/avs/qcom-cpr.c b/drivers/power/avs/qcom-cpr.c
> index 9192fb747653..b158a684d05c 100644
> --- a/drivers/power/avs/qcom-cpr.c
> +++ b/drivers/power/avs/qcom-cpr.c
> @@ -1547,8 +1547,6 @@ static int cpr_pd_attach_dev(struct generic_pm_domain *domain,
>  		goto unlock;
>  	}
>  
> -	dev_dbg(drv->dev, "number of OPPs: %d\n", drv->num_corners);
> -
>  	drv->corners = devm_kcalloc(drv->dev, drv->num_corners,
>  				    sizeof(*drv->corners),
>  				    GFP_KERNEL);
> @@ -1586,6 +1584,9 @@ static int cpr_pd_attach_dev(struct generic_pm_domain *domain,
>  				   acc_desc->enable_mask,
>  				   acc_desc->enable_mask);
>  
> +	dev_info(drv->dev, "driver initialized with %u OPPs\n",
> +		 drv->num_corners);
> +
>  unlock:
>  	mutex_unlock(&drv->lock);
>  
> -- 
> 2.24.1
> 
