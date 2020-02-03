Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2FBBF150FD6
	for <lists+linux-pm@lfdr.de>; Mon,  3 Feb 2020 19:42:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729654AbgBCSmR (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 3 Feb 2020 13:42:17 -0500
Received: from mail-pl1-f193.google.com ([209.85.214.193]:39067 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729069AbgBCSmR (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 3 Feb 2020 13:42:17 -0500
Received: by mail-pl1-f193.google.com with SMTP id g6so6196371plp.6
        for <linux-pm@vger.kernel.org>; Mon, 03 Feb 2020 10:42:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=agwkyBrldDg9XuoJ/vuTI4Bkm2/60ebehPR4ONCSu1A=;
        b=VXhPfUbvBDPUPwgbLZ+4MxcC+79OxTxus1DagUQ6PZIiK2UHMJjD6BUw6ZUhutRicA
         AJg5jJl+3QUgunQNplsGHuqurSmnQvgznY5mbYUSue4QpFGXen18JGdddf7mEHTxfT74
         jb2o3f8djD5lRy6hUQlrkaUErCqYG4eG6l6u2yvJeVNF7ZtE3ztFOpquhw5qhSzp0CMh
         PGnyIfgYBh/T42kRWPuPqYwCwZWOHa2r32p6LCLt/5LiT5jZPxsTMltX9yHxR8eQkoRj
         q5ZLWse95cjzwqVE7EXLBn05/9sO8rDgF+NotlOpDB83qYZK6UK9SudViPpb5uJL19sY
         b99w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=agwkyBrldDg9XuoJ/vuTI4Bkm2/60ebehPR4ONCSu1A=;
        b=SO3aSlhQ/iVZeT0l7shtuIS/5gJBG2URuLEEWSrQyhUT+hpG5YHDdcgJYVG3JRXtsn
         +ffU39XtW0+U+T0qUdXdmAwxM+TJcvENZGciFL7lN1HD+TLsO7OBr059dG1pI8aevi0z
         1uPrGQTtUFLLSfmu8RV2pVTSrbMWcAtoiddpBUmPbOxBS0kHxAs9nINZVh9xVflU26R1
         jR57Mql5FDLyyAE1eAMhWO9BozyOD45AfgA0mGs0dk3MwtLyXu8aOvRMEZ/FAJLM+kyn
         PtZ9gKI3T6mDe7sVPcWxaY5J5VO32QKJcSDyJFtsbzSG5+315fkS7Ch6BKz2eI71H7N1
         ti/Q==
X-Gm-Message-State: APjAAAXJavW+zcxMa1y35nzFBTEJbkiT0oBordn8bU1A9MuuQFlmmFO/
        T84fPZOkmUCl0GekhGPMBlah5Q==
X-Google-Smtp-Source: APXvYqywujKu1jX+eoX2Ww6KqrPLX4hn6f7F55QKMclqSfe3MX/7rEZ4+VJs8S0YyZQpaUrEQwhQtg==
X-Received: by 2002:a17:902:ff08:: with SMTP id f8mr21399303plj.261.1580755336546;
        Mon, 03 Feb 2020 10:42:16 -0800 (PST)
Received: from builder (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id t8sm159330pjy.20.2020.02.03.10.42.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Feb 2020 10:42:16 -0800 (PST)
Date:   Mon, 3 Feb 2020 10:42:13 -0800
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Amit Kucheria <amit.kucheria@linaro.org>
Cc:     linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        swboyd@chromium.org, sivaa@codeaurora.org,
        Andy Gross <agross@kernel.org>,
        Amit Kucheria <amit.kucheria@verdurent.com>,
        linux-pm@vger.kernel.org
Subject: Re: [PATCH v4 5/7] drivers: thermal: tsens: Add watchdog support
Message-ID: <20200203184213.GG3948@builder>
References: <cover.1580390127.git.amit.kucheria@linaro.org>
 <a1f7d34b7281c4e40307f67fce9a5c435ee5e7eb.1580390127.git.amit.kucheria@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a1f7d34b7281c4e40307f67fce9a5c435ee5e7eb.1580390127.git.amit.kucheria@linaro.org>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Thu 30 Jan 05:27 PST 2020, Amit Kucheria wrote:

> TSENS IP v2.3 onwards adds support for a watchdog to detect if the TSENS
> HW FSM is stuck. Add support to detect and restart the FSM in the
> driver. The watchdog is configured by the bootloader, we just enable the
> watchdog bark as a debug feature in the kernel.
> 
> Signed-off-by: Amit Kucheria <amit.kucheria@linaro.org>
> ---
>  drivers/thermal/qcom/tsens-common.c | 43 +++++++++++++++++++++++++++++
>  drivers/thermal/qcom/tsens-v2.c     | 10 +++++++
>  drivers/thermal/qcom/tsens.h        | 14 ++++++++++
>  3 files changed, 67 insertions(+)
> 
> diff --git a/drivers/thermal/qcom/tsens-common.c b/drivers/thermal/qcom/tsens-common.c
> index 9d1594d2f1ed..ee2414f33606 100644
> --- a/drivers/thermal/qcom/tsens-common.c
> +++ b/drivers/thermal/qcom/tsens-common.c
> @@ -377,6 +377,26 @@ irqreturn_t tsens_critical_irq_thread(int irq, void *data)
>  	struct tsens_irq_data d;
>  	unsigned long flags;
>  	int temp, ret, i;
> +	u32 wdog_status, wdog_count;
> +
> +	if (priv->feat->has_watchdog) {
> +		ret = regmap_field_read(priv->rf[WDOG_BARK_STATUS], &wdog_status);
> +		if (ret)
> +			return ret;
> +
> +		if (wdog_status) {
> +			/* Clear WDOG interrupt */
> +			regmap_field_write(priv->rf[WDOG_BARK_CLEAR], 1);
> +			regmap_field_write(priv->rf[WDOG_BARK_CLEAR], 0);
> +			ret = regmap_field_read(priv->rf[WDOG_BARK_COUNT], &wdog_count);
> +			if (ret)
> +				return ret;
> +			if (wdog_count)
> +				dev_dbg(priv->dev, "%s: watchdog count: %d\n", __func__, wdog_count);
> +
> +			return IRQ_HANDLED;

Patch looks good, but would is make sense to fall through and handle
critical interrupts as well (both in positive and error cases of this
hunk)?


Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>

Regards,
Bjorn
