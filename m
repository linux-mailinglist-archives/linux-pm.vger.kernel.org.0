Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E177012EA3C
	for <lists+linux-pm@lfdr.de>; Thu,  2 Jan 2020 20:18:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728295AbgABTSj (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 2 Jan 2020 14:18:39 -0500
Received: from mail-pl1-f196.google.com ([209.85.214.196]:43567 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728243AbgABTSi (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 2 Jan 2020 14:18:38 -0500
Received: by mail-pl1-f196.google.com with SMTP id p27so18160509pli.10
        for <linux-pm@vger.kernel.org>; Thu, 02 Jan 2020 11:18:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=5v8YmE4lq5pm3n48JSYbm+XxfNVgtGcEo9dEgVmMKes=;
        b=nqVjCCKi/RNZVE/bmRsnbbEhTSk8MhBG5ALiX+uI5k6s9VYGdUmI3AXqT9iLB9Kdng
         QSVMiEpnDR401TBusnOYbk2scewB5MkdJnKQ+bkLK9pcYQJTu60BrpwOkLxAE1umKIo8
         c/e/7TH55dyh8FZe1aSAI0Ohpbp4PeZRrcNfvp69EllKrOMDWjeQInoogKexLb57Jv1U
         DD0PNRXvi8RfdSpYdVfwZqDi92cXi3E95ZiK2vJLq3wz5X0KYW6a2+tDdSsEFYfbU33M
         phPyknsg/cM1bMlq4Tqtuj/el/ie6p+Z8hB2C5Dk7nPMp00EsHD3DGSzmFQLPo0MvIe/
         1aqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=5v8YmE4lq5pm3n48JSYbm+XxfNVgtGcEo9dEgVmMKes=;
        b=JpLEUHuSYROgKWl3p03LSzBIlZiiulNaTv0sZS1R8MkiVU6bciXTMMYPYmgWEos7MQ
         DLDdVkKBF2NQjNnCRyouOMipLBWJcOAG2iyCMufMoRilczvJMM8UUsmKYbwHFRPyg43Y
         6hrj/Y+YQmjSCHTFJDuMabaDirRb5A+vOhFxqZ8lc2ZH4Csxj25+Qs1bR13aMuuk+H6W
         IbVu+iFru+WJqoExfvrqvZDWb32gBb1yHNoJt1goNHEuzy7skXD6Ne/cVJKzaCVih/PO
         D5kGpr4jXRNuHHzwii5N/TZzgyrdBwgpyUPDm1J31RtlBhiZDVx4ZLBLn05L+/E9U/Ot
         YP9w==
X-Gm-Message-State: APjAAAWmwy1OExKCult91/u5C4iT0LjMEYpWrMfffYN42C2kECRmYgqr
        gegU0eJ9H/wTDGZzMp4WSUwZJA==
X-Google-Smtp-Source: APXvYqzUZXast5HDCFoCWpka7cRchbSV4gtoHv7dita+qvQPpmpysiWRq22r6mn49W4QMAJRITOhZg==
X-Received: by 2002:a17:902:9b83:: with SMTP id y3mr61188806plp.32.1577992718051;
        Thu, 02 Jan 2020 11:18:38 -0800 (PST)
Received: from minitux (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id g19sm65407665pfh.134.2020.01.02.11.18.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Jan 2020 11:18:37 -0800 (PST)
Date:   Thu, 2 Jan 2020 11:18:35 -0800
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Amit Kucheria <amit.kucheria@linaro.org>
Cc:     linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        swboyd@chromium.org, sivaa@codeaurora.org,
        Andy Gross <agross@kernel.org>,
        Amit Kucheria <amit.kucheria@verdurent.com>,
        linux-pm@vger.kernel.org
Subject: Re: [PATCH v3 3/9] drivers: thermal: tsens: use simpler variables
Message-ID: <20200102191835.GB988120@minitux>
References: <cover.1577976221.git.amit.kucheria@linaro.org>
 <09ac47eea963e84bd3eb630897c2b77f3868b90b.1577976221.git.amit.kucheria@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <09ac47eea963e84bd3eb630897c2b77f3868b90b.1577976221.git.amit.kucheria@linaro.org>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Thu 02 Jan 06:54 PST 2020, Amit Kucheria wrote:

> We already dereference the sensor and save it into a variable. Use the
> variable directly to make the code easier to read.
> 

Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>

> Signed-off-by: Amit Kucheria <amit.kucheria@linaro.org>
> ---
>  drivers/thermal/qcom/tsens-common.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/thermal/qcom/tsens-common.c b/drivers/thermal/qcom/tsens-common.c
> index c2df30a08b9e..1cbc5a6e5b4f 100644
> --- a/drivers/thermal/qcom/tsens-common.c
> +++ b/drivers/thermal/qcom/tsens-common.c
> @@ -368,7 +368,7 @@ irqreturn_t tsens_irq_thread(int irq, void *data)
>  			tsens_set_interrupt(priv, hw_id, UPPER, disable);
>  			if (d.up_thresh > temp) {
>  				dev_dbg(priv->dev, "[%u] %s: re-arm upper\n",
> -					priv->sensor[i].hw_id, __func__);
> +					hw_id, __func__);
>  				tsens_set_interrupt(priv, hw_id, UPPER, enable);
>  			} else {
>  				trigger = true;
> @@ -379,7 +379,7 @@ irqreturn_t tsens_irq_thread(int irq, void *data)
>  			tsens_set_interrupt(priv, hw_id, LOWER, disable);
>  			if (d.low_thresh < temp) {
>  				dev_dbg(priv->dev, "[%u] %s: re-arm low\n",
> -					priv->sensor[i].hw_id, __func__);
> +					hw_id, __func__);
>  				tsens_set_interrupt(priv, hw_id, LOWER, enable);
>  			} else {
>  				trigger = true;
> @@ -392,7 +392,7 @@ irqreturn_t tsens_irq_thread(int irq, void *data)
>  		if (trigger) {
>  			dev_dbg(priv->dev, "[%u] %s: TZ update trigger (%d mC)\n",
>  				hw_id, __func__, temp);
> -			thermal_zone_device_update(priv->sensor[i].tzd,
> +			thermal_zone_device_update(s->tzd,
>  						   THERMAL_EVENT_UNSPECIFIED);
>  		} else {
>  			dev_dbg(priv->dev, "[%u] %s: no violation:  %d\n",
> @@ -435,7 +435,7 @@ int tsens_set_trips(void *_sensor, int low, int high)
>  	spin_unlock_irqrestore(&priv->ul_lock, flags);
>  
>  	dev_dbg(dev, "[%u] %s: (%d:%d)->(%d:%d)\n",
> -		s->hw_id, __func__, d.low_thresh, d.up_thresh, cl_low, cl_high);
> +		hw_id, __func__, d.low_thresh, d.up_thresh, cl_low, cl_high);
>  
>  	return 0;
>  }
> -- 
> 2.20.1
> 
