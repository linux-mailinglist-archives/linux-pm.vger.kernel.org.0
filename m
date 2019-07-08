Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BCC8361999
	for <lists+linux-pm@lfdr.de>; Mon,  8 Jul 2019 05:51:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728920AbfGHDvC (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 7 Jul 2019 23:51:02 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:34741 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727622AbfGHDvC (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 7 Jul 2019 23:51:02 -0400
Received: by mail-pf1-f196.google.com with SMTP id b13so2297435pfo.1
        for <linux-pm@vger.kernel.org>; Sun, 07 Jul 2019 20:51:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=/1pK4KTnhC89gqGYh7RqYsGWCRyTdp8pAHVuXCVYQM0=;
        b=rcOUQmSGNhVpug3mIyjRLWjXiIaNo6rSisJB7mCEu56J3i3r5wszqroltHwaefo8vt
         FJDolSTb9COCAUPHEGmXp44a6WgYMNaoFB4kjRxvZjojSvG8SQMDG6OYic4T1MQE6uA2
         7Vrndp5vb1fxgXpz4LpAvyqwp0UnYxe4Ggcp7XsuGSF4TAzn/Biuj8atuRDXEXY5mUtJ
         KEZfwdEobRo9Gd/bIam2/We+/7UualkhGP2pQR2FafF5FOQ8LRRCWVZOW096GA+lW5Fm
         LZcUyPzr5ka9SttykNopIJMhRkEI2r8N8aBTz7NxcdIA/4wmiwDRB5HqwB831axXIcfV
         WuXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=/1pK4KTnhC89gqGYh7RqYsGWCRyTdp8pAHVuXCVYQM0=;
        b=aIZ1HZ9DhZWswDjs3YjJh3aMv4Ro6ANvjnhkfA2gztda8tulRpwfKAHJCOj6hmKYut
         ErDGpmR/KSjih0rB1azLKB42seywNcd2zpIx7VIkfb/dMPonOBQX4KBA5rlPrxrRvjFq
         nfm+Wuu9VgM0bR+0U1WUZamjGjeCk/vymeVxG3nRpZJxNccD4ROEECviVkizRlCwo8UR
         zS1x828to+/hlICcrNBiNp2y0zkWq+nkHXBRFsfYRpYPAraL8WkZgjL2PIIXTbgx5LKf
         6N0aaszHBPfuAoz78rUSgPNTcS1mporAi2rptShIbiY5Ar/bzvvFkobJ+EfbBv9jBh4I
         iLDg==
X-Gm-Message-State: APjAAAUIZYANQHs7JY9sisRL1ZaVIwjJVCKAL8ttMVAnA1xIFUTs66pl
        3hxcv8e2V8RC5847rDFuNlP3zQ==
X-Google-Smtp-Source: APXvYqwChaIoPvXaa69JPPf8K46yTRYkCg4Tm7IDyulcIk9nICKW8Ynmx8kiGVyy7hwFcgTvMhQjWg==
X-Received: by 2002:a63:7e17:: with SMTP id z23mr19550031pgc.14.1562557861027;
        Sun, 07 Jul 2019 20:51:01 -0700 (PDT)
Received: from localhost ([122.172.28.117])
        by smtp.gmail.com with ESMTPSA id b1sm16054904pfi.91.2019.07.07.20.50.59
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 07 Jul 2019 20:51:00 -0700 (PDT)
Date:   Mon, 8 Jul 2019 09:20:57 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Anson.Huang@nxp.com
Cc:     rjw@rjwysocki.net, shawnguo@kernel.org, s.hauer@pengutronix.de,
        kernel@pengutronix.de, festevam@gmail.com,
        linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Linux-imx@nxp.com
Subject: Re: [PATCH] cpufreq: imx-cpufreq-dt: Add i.MX8MN support
Message-ID: <20190708035057.h2lgadm56tgdqsor@vireshk-i7>
References: <20190708030308.1815-1-Anson.Huang@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190708030308.1815-1-Anson.Huang@nxp.com>
User-Agent: NeoMutt/20180716-391-311a52
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 08-07-19, 11:03, Anson.Huang@nxp.com wrote:
> From: Anson Huang <Anson.Huang@nxp.com>
> 
> i.MX8MN is a new SoC of i.MX8M series, it also uses speed
> grading and market segment fuses for OPP definitions, add
> support for this SoC.
> 
> Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
> ---
>  drivers/cpufreq/imx-cpufreq-dt.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/cpufreq/imx-cpufreq-dt.c b/drivers/cpufreq/imx-cpufreq-dt.c
> index b54fd26..4f85f31 100644
> --- a/drivers/cpufreq/imx-cpufreq-dt.c
> +++ b/drivers/cpufreq/imx-cpufreq-dt.c
> @@ -44,10 +44,11 @@ static int imx_cpufreq_dt_probe(struct platform_device *pdev)
>  	 * According to datasheet minimum speed grading is not supported for
>  	 * consumer parts so clamp to 1 to avoid warning for "no OPPs"
>  	 *
> -	 * Applies to 8mq and 8mm.
> +	 * Applies to i.MX8M series SoCs.
>  	 */
>  	if (mkt_segment == 0 && speed_grade == 0 && (
>  			of_machine_is_compatible("fsl,imx8mm") ||
> +			of_machine_is_compatible("fsl,imx8mn") ||
>  			of_machine_is_compatible("fsl,imx8mq")))
>  		speed_grade = 1;

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

@Rafael: Can you pick this one directly, no point sending another pull request
for just one patch. Thanks.

-- 
viresh
