Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id ED97C15B5E
	for <lists+linux-pm@lfdr.de>; Tue,  7 May 2019 07:53:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728426AbfEGFxb (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 7 May 2019 01:53:31 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:34633 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726771AbfEGFxa (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 7 May 2019 01:53:30 -0400
Received: by mail-pf1-f195.google.com with SMTP id b3so8059913pfd.1
        for <linux-pm@vger.kernel.org>; Mon, 06 May 2019 22:53:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=8uyCOz7KxCA9rdrZ980SRkWPRIiBf6qTqibeSY1JMf4=;
        b=IPLZhXXADfzehFr/wqjL7whdB44mR9KjDFbBF7sCg6EG3jSmMqa1CZOc/OkUdmjDsw
         qwM0kdZFpHbv+rChs78Blg0U2pmmY32M3D2EldxhIfD2+W6dAaTUA1A23w2rC9cGe4Dy
         bIbRgfceNAs8Pi8/K1CUKD7zqgM9oODVfStxkccdl50A3p90rOnrRj47o2PUlFbWwjKP
         3xtesPSZph710XTjvBHKZuzPvdByrJO9DPZuCM+XDbPAMp/tR3ucAPo5mqC/57Zm5LoK
         GWReKDRSMgJW+ZLAvXL76ouaY/fl/Yj5mZ1DCVLRTXdfZTFYZEvITneMHZelCNjBD4zV
         eAWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=8uyCOz7KxCA9rdrZ980SRkWPRIiBf6qTqibeSY1JMf4=;
        b=LjvVAgUFyIj7WBfvbK0t9xkH08LjRjjja0AhQKjEgmybjw8eCQkOLJcwNVq4p5fx28
         OZ/7VhBGtwc0SKijrnVRywDqW9vWQXZdjvFxP3LCLot/PknIWX8kIKyee9DbiljnSeuD
         UKxgRX9rLoTTGbb513OFychY5EX0Bhu6+VocRf9hC95A+zX0FscarbRXMkk01v3mOStI
         9EEl1PFbF284STagI6vNYJ2Hb6d97IrAwrmM2shMvcM1lviSfYpimg5mlko/57QS0vyg
         xCeBqx/ktxRaM4FQlU/SB5w8fffFxLPrCBg6zolp/HyfNuJt8mbCLF/4BxnOhq3Ov8k4
         AkVw==
X-Gm-Message-State: APjAAAVRGPTH2PjZ+vprcw/EhN2VUjCMj0aduPLqs/MKjXZBv44AAcAE
        VlRaz6Iqd+KwEmN+s8qdEQ+pHw==
X-Google-Smtp-Source: APXvYqw8aVBMyNC18fXZGRkbVE4vEgsE4gtXjBTmyTJdR1WZmNX8H11pXfh6usgB7sK6uXkhC4iU8g==
X-Received: by 2002:a65:44c7:: with SMTP id g7mr32972066pgs.399.1557208409857;
        Mon, 06 May 2019 22:53:29 -0700 (PDT)
Received: from localhost ([122.172.118.99])
        by smtp.gmail.com with ESMTPSA id k14sm33275146pfj.171.2019.05.06.22.53.28
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 06 May 2019 22:53:29 -0700 (PDT)
Date:   Tue, 7 May 2019 11:23:27 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Jacky Bai <ping.bai@nxp.com>
Cc:     "festevam@gmail.com" <festevam@gmail.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "rjw@rjwysocki.net" <rjw@rjwysocki.net>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        dl-linux-imx <linux-imx@nxp.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>
Subject: Re: [PATCH v2] cpufreq: imx6q: Fix the resource leak caused by
 incorrect error return
Message-ID: <20190507055327.sakuoy2j3g7dwv3f@vireshk-i7>
References: <20190505080736.27970-1-ping.bai@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190505080736.27970-1-ping.bai@nxp.com>
User-Agent: NeoMutt/20180716-391-311a52
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 05-05-19, 08:02, Jacky Bai wrote:
> Previous goto only handled the node reference, the opp table,
> regulator & clk resource also need to be free before error return.
> 
> Fixes: ddb64c5db3c (cpufreq: imx6q: fix possible object reference leak).

This should have been.

Fixes: ddb64c5db3cc ("cpufreq: imx6q: fix possible object reference leak")

Auto configure it with following in .gitconfig

[pretty]
	fixes = Fixes: %h (\"%s\")
	onelin = commit %h (\"%s\")

and then:

git log --pretty=fixes ddb64c5db3c

will generate it by itself.

> Signed-off-by: Jacky Bai <ping.bai@nxp.com>
> Reviewed-by: Dong Aisheng <aisheng.dong@nxp.com>
> ---
>  drivers/cpufreq/imx6q-cpufreq.c | 15 +++++++--------
>  1 file changed, 7 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/cpufreq/imx6q-cpufreq.c b/drivers/cpufreq/imx6q-cpufreq.c
> index 3e17560b1efe..1d4ecefaabc6 100644
> --- a/drivers/cpufreq/imx6q-cpufreq.c
> +++ b/drivers/cpufreq/imx6q-cpufreq.c
> @@ -383,23 +383,22 @@ static int imx6q_cpufreq_probe(struct platform_device *pdev)
>  		goto put_reg;
>  	}
>  
> +	/* Because we have added the OPPs here, we must free them */
> +	free_opp = true;
> +
>  	if (of_machine_is_compatible("fsl,imx6ul") ||
>  	    of_machine_is_compatible("fsl,imx6ull")) {
>  		ret = imx6ul_opp_check_speed_grading(cpu_dev);
>  		if (ret) {
> -			if (ret == -EPROBE_DEFER)
> -				goto put_node;
> -
> -			dev_err(cpu_dev, "failed to read ocotp: %d\n",
> -				ret);
> -			goto put_node;
> +			if (ret != -EPROBE_DEFER)
> +				dev_err(cpu_dev, "failed to read ocotp: %d\n",
> +					ret);
> +			goto out_free_opp;
>  		}
>  	} else {
>  		imx6q_opp_check_speed_grading(cpu_dev);
>  	}
>  
> -	/* Because we have added the OPPs here, we must free them */
> -	free_opp = true;
>  	num = dev_pm_opp_get_opp_count(cpu_dev);
>  	if (num < 0) {
>  		ret = num;

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

@Rafael: This needs to go in 5.2 itself, can you queue it directly ?

-- 
viresh
