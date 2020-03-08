Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3533317D4B1
	for <lists+linux-pm@lfdr.de>; Sun,  8 Mar 2020 17:27:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726270AbgCHQ1b (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 8 Mar 2020 12:27:31 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:38827 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726296AbgCHQ1b (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 8 Mar 2020 12:27:31 -0400
Received: by mail-lj1-f195.google.com with SMTP id w1so7406050ljh.5
        for <linux-pm@vger.kernel.org>; Sun, 08 Mar 2020 09:27:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ragnatech-se.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=AgbZPWzyECAbkrihwQ1V8G57nxvx4bfh3QjN09MX4mo=;
        b=CxJtmWvGW5GMhmcbRj1vIsbYCyoCD/ElANMvE4JV93La5RSPJePznKPb6yXWxMCs7K
         6oPu2Vhi2M34P7RE16gagWFr0JJnZ9De2RNopc0I7Hu5HAtk200/XMxiXfKJeoIcCuvF
         moznl//TQHl716hsco1JdhqiWtDRdtnZENpUs63CMCH1I6vhjRqe5sIVpMKr6gbFiGPl
         y1leHHRDT+Y6z5W0KPmrbQK8FVfyZAAmxB2ZYwfudcK+JC1RRFsxlj+ZcjSDz7PJ+W3b
         KyCKSQyED8uoWTpzXzqTD4s+LEREmkcPNAnf/uOoOLJIZPtmneRzVXTc/Ei/xwbiR61C
         s+9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=AgbZPWzyECAbkrihwQ1V8G57nxvx4bfh3QjN09MX4mo=;
        b=NI0HxxIPa1pE+pwr4JddJoYKBXph9OMfn7r/kzxCTlizgZiqELnfkXLlcVk3H9W0V7
         wpfNgqj1RJGNjQ6yjshN6ls+flgplR7QNz0MOTaYk/M9FtRd7jcbK7PnuXEAqwp4PEo5
         mrBGX85r7kD1xf7+zcl93+A/luNA/HwgyIk4l3HOXy1d7QuiW2pUdBff0yuxCHx1U9EV
         lKbGk/2tJV0lLH9u06JIKi7vOFDGBiPnvwaPma7U0ylxCcqBScgrPUHKX9hInVwyaqec
         ny0PhB115UzVnu7vkwYrvq46zAsEL7aUKS4CpceeL6ifFxZ+rMpq+S53RldvonXqg1aJ
         OUtw==
X-Gm-Message-State: ANhLgQ1MTFsa6rW72uYYogCTSlvuMrFWIOvK597qMEIO3nQH8T1/fFDT
        ++FFtHW4tm5kRJDYdmOeHbUn2mFlKzs=
X-Google-Smtp-Source: ADFU+vs6GeXsR2Zjj1pVsfKvGQrdo/jEqEgzExz1YOhG1fanLSSMkOS2n6KjRkfdZpcWTkdiW8bEaQ==
X-Received: by 2002:a2e:a584:: with SMTP id m4mr7733555ljp.46.1583684847185;
        Sun, 08 Mar 2020 09:27:27 -0700 (PDT)
Received: from localhost (h-200-138.A463.priv.bahnhof.se. [176.10.200.138])
        by smtp.gmail.com with ESMTPSA id c20sm13177024lfb.60.2020.03.08.09.27.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Mar 2020 09:27:26 -0700 (PDT)
Date:   Sun, 8 Mar 2020 17:27:26 +0100
From:   Niklas =?iso-8859-1?Q?S=F6derlund?= 
        <niklas.soderlund@ragnatech.se>
To:     Geert Uytterhoeven <geert+renesas@glider.be>
Cc:     Zhang Rui <rui.zhang@intel.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Amit Kucheria <amit.kucheria@verdurent.com>,
        Rob Herring <robh+dt@kernel.org>, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-renesas-soc@vger.kernel.org
Subject: Re: [PATCH 2/2] thermal: rcar_gen3_thermal: Add r8a77961 support
Message-ID: <20200308162726.GC2975348@oden.dyn.berto.se>
References: <20200306105503.24267-1-geert+renesas@glider.be>
 <20200306105503.24267-3-geert+renesas@glider.be>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200306105503.24267-3-geert+renesas@glider.be>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Geert,

Thanks for your patch.

On 2020-03-06 11:55:03 +0100, Geert Uytterhoeven wrote:
> Add support for the Thermal Sensor/Chip Internal Voltage Monitor in the
> R-Car M3-W+ (R8A77961) SoC.
> 
> According to the R-Car Gen3 Hardware Manual Errata for Revision 2.00 of
> Jan 31, 2020, the thermal parameters for R-Car M3-W+ are the same as for
> R-Car M3-W.
> 
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>

Reviewed-by: Niklas Söderlund <niklas.soderlund+renesas@ragnatech.se>

> ---
>  drivers/thermal/rcar_gen3_thermal.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/drivers/thermal/rcar_gen3_thermal.c b/drivers/thermal/rcar_gen3_thermal.c
> index 72877bdc072daaed..a6b0c31f1509c45c 100644
> --- a/drivers/thermal/rcar_gen3_thermal.c
> +++ b/drivers/thermal/rcar_gen3_thermal.c
> @@ -324,6 +324,10 @@ static const struct of_device_id rcar_gen3_thermal_dt_ids[] = {
>  		.compatible = "renesas,r8a7796-thermal",
>  		.data = &rcar_gen3_ths_tj_1_m3_w,
>  	},
> +	{
> +		.compatible = "renesas,r8a77961-thermal",
> +		.data = &rcar_gen3_ths_tj_1_m3_w,
> +	},
>  	{
>  		.compatible = "renesas,r8a77965-thermal",
>  		.data = &rcar_gen3_ths_tj_1,
> -- 
> 2.17.1
> 

-- 
Regards,
Niklas Söderlund
