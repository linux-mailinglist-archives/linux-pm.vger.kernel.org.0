Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5BD6D150FDA
	for <lists+linux-pm@lfdr.de>; Mon,  3 Feb 2020 19:43:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729194AbgBCSnX (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 3 Feb 2020 13:43:23 -0500
Received: from mail-pj1-f66.google.com ([209.85.216.66]:52164 "EHLO
        mail-pj1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728693AbgBCSnX (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 3 Feb 2020 13:43:23 -0500
Received: by mail-pj1-f66.google.com with SMTP id fa20so143389pjb.1
        for <linux-pm@vger.kernel.org>; Mon, 03 Feb 2020 10:43:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=xOTk3g8W7pXsEb3fB9weLwB8mgi1DoDYv/P++HZPauA=;
        b=WntZtkVuJvCU93iqhDKUAwLVSj6S62pzDhf4dzlnYjaC6kdbQaJmlmnbJjA09n8fKB
         9GEzu88rpv/GOmPVMKaiEpTdN86/xX7PRwkQ229XpO2MwjA2WlInv9QyENywTXuLdrzg
         XT69EC4/0g2meSc0wdkX5lW/5R3YXVXyU8HjyFkanlRBhBoo8e05Ki6lzv3zbEz2WpwK
         DysHr0kDGwTGkXwKZlYmcZby55t/gkLzHkp3Q3J5ZK+4NnIqKEyHnbHUCfIL95O8vvap
         b1cOZJv5S7TVINX1GzEqMwuvIEG6qnGs2vyrPT2gAZcpwY6slvW7RgisKGGSEHh/224H
         R+hA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=xOTk3g8W7pXsEb3fB9weLwB8mgi1DoDYv/P++HZPauA=;
        b=nxQjWNRdUCeUT2A1WdkyVziWQdAdxIkOzkRsW1NJNGFV9d1ylZK9ui28PhN8ej7odL
         onmf0WSQJzuKPjTcUsgx4VaGwe6L2Z7S833PeYL4D45BmJc4ux6KSsbtKpawMbBHFIvB
         C0OXyvFDzaKCBscdX6cST6khtoQD3yn/ejDzY5nARdbtjT/WSCsZP/NXQwuo29irvonU
         5aeq2fy9uHqxONBsK4+JKBSeVPzEtomAAoHamr49m60MVWoVaeVxgWF3ioShuoMS3+DY
         3f/Uy9g/3QjESk58uqav/JHfwLFEpC+98dWfnNCwKrFK3irVPhtzbOx/1Ft6FBB2d5bB
         rU8g==
X-Gm-Message-State: APjAAAX56okTMpVjTjdQcPTqO7ecne3qB1DV6x//k41HspG185VuOaYg
        HEyZNimQyfI2P/CUppIHEzzYaw==
X-Google-Smtp-Source: APXvYqxg4wWsrsQKMZeeGYwT0lz6oFlgUbwB1raH4pu13jkLYVEo4GJDTDDZsk1GP+8pUqoEw1FYCQ==
X-Received: by 2002:a17:902:8f91:: with SMTP id z17mr24761583plo.234.1580755402569;
        Mon, 03 Feb 2020 10:43:22 -0800 (PST)
Received: from builder (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id 72sm21106619pfw.7.2020.02.03.10.43.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Feb 2020 10:43:22 -0800 (PST)
Date:   Mon, 3 Feb 2020 10:43:20 -0800
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Amit Kucheria <amit.kucheria@linaro.org>
Cc:     linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        swboyd@chromium.org, sivaa@codeaurora.org,
        Andy Gross <agross@kernel.org>,
        Amit Kucheria <amit.kucheria@verdurent.com>,
        linux-pm@vger.kernel.org
Subject: Re: [PATCH v4 6/7] drivers: thermal: tsens: kernel-doc fixup
Message-ID: <20200203184320.GH3948@builder>
References: <cover.1580390127.git.amit.kucheria@linaro.org>
 <1fccb71bd5d54842d2c54d175c080d0edeabca26.1580390127.git.amit.kucheria@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1fccb71bd5d54842d2c54d175c080d0edeabca26.1580390127.git.amit.kucheria@linaro.org>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Thu 30 Jan 05:27 PST 2020, Amit Kucheria wrote:

> Document ul_lock, threshold and control structure members and make
> the following kernel-doc invocation happy:
> 
> $ scripts/kernel-doc -v -none drivers/thermal/qcom/*
> 
> drivers/thermal/qcom/qcom-spmi-temp-alarm.c:105: info: Scanning doc for qpnp_tm_get_temp_stage
> drivers/thermal/qcom/tsens-common.c:18: info: Scanning doc for struct tsens_irq_data
> drivers/thermal/qcom/tsens-common.c:130: info: Scanning doc for tsens_hw_to_mC
> drivers/thermal/qcom/tsens-common.c:163: info: Scanning doc for tsens_mC_to_hw
> drivers/thermal/qcom/tsens-common.c:245: info: Scanning doc for tsens_set_interrupt
> drivers/thermal/qcom/tsens-common.c:268: info: Scanning doc for tsens_threshold_violated
> drivers/thermal/qcom/tsens-common.c:362: info: Scanning doc for tsens_critical_irq_thread
> drivers/thermal/qcom/tsens-common.c:438: info: Scanning doc for tsens_irq_thread
> drivers/thermal/qcom/tsens.h:41: info: Scanning doc for struct tsens_sensor
> drivers/thermal/qcom/tsens.h:59: info: Scanning doc for struct tsens_ops
> drivers/thermal/qcom/tsens.h:494: info: Scanning doc for struct tsens_features
> drivers/thermal/qcom/tsens.h:513: info: Scanning doc for struct tsens_plat_data
> drivers/thermal/qcom/tsens.h:529: info: Scanning doc for struct tsens_context
> 

Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>

> Signed-off-by: Amit Kucheria <amit.kucheria@linaro.org>
> ---
>  drivers/thermal/qcom/tsens.h | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/thermal/qcom/tsens.h b/drivers/thermal/qcom/tsens.h
> index cf0511a947d4..dd163b27add4 100644
> --- a/drivers/thermal/qcom/tsens.h
> +++ b/drivers/thermal/qcom/tsens.h
> @@ -526,6 +526,8 @@ struct tsens_plat_data {
>  
>  /**
>   * struct tsens_context - Registers to be saved/restored across a context loss
> + * @threshold: Threshold register value
> + * @control: Control register value
>   */
>  struct tsens_context {
>  	int	threshold;
> @@ -540,6 +542,7 @@ struct tsens_context {
>   * @srot_map: pointer to SROT register address space
>   * @tm_offset: deal with old device trees that don't address TM and SROT
>   *             address space separately
> + * @ul_lock: lock while processing upper/lower threshold interrupts
>   * @crit_lock: lock while processing critical threshold interrupts
>   * @rf: array of regmap_fields used to store value of the field
>   * @ctx: registers to be saved and restored during suspend/resume
> -- 
> 2.20.1
> 
