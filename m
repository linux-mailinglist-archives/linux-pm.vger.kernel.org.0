Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 969C7187AC7
	for <lists+linux-pm@lfdr.de>; Tue, 17 Mar 2020 09:03:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725870AbgCQIDp (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 17 Mar 2020 04:03:45 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:34296 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725536AbgCQIDo (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 17 Mar 2020 04:03:44 -0400
Received: by mail-pl1-f196.google.com with SMTP id a23so9291546plm.1
        for <linux-pm@vger.kernel.org>; Tue, 17 Mar 2020 01:03:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=wJzj+NhO+lX1yEtnXWO3HvgiRxvAHYyMwldXylz/g50=;
        b=uaNAUErhn8Wd3uexgimEazU8oaz2CrrpINTw3zlsRrv70YFqLvop1Mm4dr5cHY2TQ+
         tlguxrHlr1t/Tf56J59gXfrDqU5q9OIq9C36XMKu6hosdc97qIwiKaEtHCX8r3eitpRw
         6nolpgswSdHtVLtNa8s2ZTGzXh8VLzxbaO1YF/y1LwNmupkZSALAA9mwcIULIpaneNn1
         Hvv83kSpGXCFlzl1aWtp8CLaeWqU1oF8cjKFmz0w7kHptEP7AL4uY7HS+7v6K1AoLD7m
         hZaTc8HFgSVpBeOI2GtB+TXNiUZzc3bz5jk7aIlhIvGStQdBiGJukG8s/BGUbsL/VR70
         OZng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=wJzj+NhO+lX1yEtnXWO3HvgiRxvAHYyMwldXylz/g50=;
        b=DU6GxYVpqdDbdkZGGSIl3Dpfr7hrv39PnW2/89O8wyu9gfb5DAnJkA6cIrUHIjDlw9
         Uzo4oUjQETiu8R78EaRrAUq+EvOCb7gUHTJe4B0HYzTydEMfIefoG4Eiv068VutiIe6a
         GwDiZUDCY1FrBuWXW10EeA/1MBPIOaQVG94uxFkm/y+ZEd/ychE+Kkd8bmExGkNCbanv
         Fx2TkYYBqu+2FQH42svN2CyYFf6fG7Axg+D25KLCUgX7nMjjchEWuiY6sVwMdZiuQPvO
         50RyuchYNvSUdNOLA/KRGeN5Of9uhYt8O7Q8Rl+uK+hmXmGsmtuvstg1Q+Ugv+89D927
         BTog==
X-Gm-Message-State: ANhLgQ0Yu7w5yLt1u/dUyt8/2eSgvzTknsK5nSCUgpfuYkzoNy+1Yoh3
        Hbf9kP9+OUOPC3Nuv9Sapj+tYg==
X-Google-Smtp-Source: ADFU+vsA93AKpo6rZVnei/jHWtpv1Oy0bklJm2y9V7JgrzPTTmeqgzvFd+SAx1MK0x6Lnj2Ha34y2w==
X-Received: by 2002:a17:902:9a45:: with SMTP id x5mr3005594plv.296.1584432223464;
        Tue, 17 Mar 2020 01:03:43 -0700 (PDT)
Received: from localhost ([122.171.122.128])
        by smtp.gmail.com with ESMTPSA id j19sm2106447pfe.102.2020.03.17.01.03.42
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 17 Mar 2020 01:03:42 -0700 (PDT)
Date:   Tue, 17 Mar 2020 13:33:40 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Anson Huang <Anson.Huang@nxp.com>
Cc:     rjw@rjwysocki.net, shawnguo@kernel.org, s.hauer@pengutronix.de,
        kernel@pengutronix.de, festevam@gmail.com,
        linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Linux-imx@nxp.com
Subject: Re: [PATCH] cpufreq: imx6q-cpufreq: Improve the logic of
 -EPROBE_DEFER handling
Message-ID: <20200317080340.475xamakfosykrro@vireshk-i7>
References: <1584419934-2303-1-git-send-email-Anson.Huang@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1584419934-2303-1-git-send-email-Anson.Huang@nxp.com>
User-Agent: NeoMutt/20180716-391-311a52
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 17-03-20, 12:38, Anson Huang wrote:
> Improve the -EPROBE_DEFER handling logic to simplify the code.
> 
> Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
> ---
>  drivers/cpufreq/imx6q-cpufreq.c | 8 +++-----
>  1 file changed, 3 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/cpufreq/imx6q-cpufreq.c b/drivers/cpufreq/imx6q-cpufreq.c
> index 285b8e9..fdb2fff 100644
> --- a/drivers/cpufreq/imx6q-cpufreq.c
> +++ b/drivers/cpufreq/imx6q-cpufreq.c
> @@ -400,11 +400,9 @@ static int imx6q_cpufreq_probe(struct platform_device *pdev)
>  		ret = imx6q_opp_check_speed_grading(cpu_dev);
>  	}
>  	if (ret) {
> -		if (ret == -EPROBE_DEFER)
> -			goto out_free_opp;
> -
> -		dev_err(cpu_dev, "failed to read ocotp: %d\n",
> -			ret);
> +		if (ret != -EPROBE_DEFER)
> +			dev_err(cpu_dev, "failed to read ocotp: %d\n",
> +				ret);
>  		goto out_free_opp;
>  	}

Applied. Thanks.


-- 
viresh
