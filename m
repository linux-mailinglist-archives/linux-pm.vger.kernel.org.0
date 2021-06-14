Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7707D3A6D32
	for <lists+linux-pm@lfdr.de>; Mon, 14 Jun 2021 19:30:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235578AbhFNRcR (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 14 Jun 2021 13:32:17 -0400
Received: from mail-wm1-f53.google.com ([209.85.128.53]:37443 "EHLO
        mail-wm1-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235624AbhFNRcQ (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 14 Jun 2021 13:32:16 -0400
Received: by mail-wm1-f53.google.com with SMTP id f16-20020a05600c1550b02901b00c1be4abso13644445wmg.2
        for <linux-pm@vger.kernel.org>; Mon, 14 Jun 2021 10:29:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=0HZoKw5adrZfJ9skcd1RFBbDTV0dwPz1XUywXf4yuGQ=;
        b=KH4afTS4+SGTi1cTqbnj17kLVaHyIIdrXkw76mYjnBhCBVmacQqZWF8psAl99FXcj8
         9vsXwwDyVyha/0K+hYWfiLoYMJM9EsCXOwoj6fDk5ppvq3/Bw8tOMLUYzNWSqBnVUg9e
         NvuWRy5+SERZMK8cDJV/oc8y9m+1fgZ0zxJ0CxUcVZptEqewDbUTQbcm4Zpeu/MBS+kR
         Ko4KBytCQC/dZr+WN0k8YFRUSG0CDYADE6/GjXvwaYeLOm98MVitNzm6QO+z5Ka7EOeP
         OoXa/Ch27iS3FxCneanLpPVBzcCOjYqu2fvlN+bxTvr5VIrAxCJIVPzRy/UVaHHJXRQI
         5fBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=0HZoKw5adrZfJ9skcd1RFBbDTV0dwPz1XUywXf4yuGQ=;
        b=fJ1x5EhRIPIVlHevwH8VtICVkHUrIjHYCHYzXz1JRpuwZmLLudxl980Qv39haycP9j
         PHqaweh5MqtCU1Zk2NyCyJ2ppUJBGafwp7OyESElOr0gW031OoZj26r2NN53X5V5awqd
         eEwhIJ0T4dli3UmDypLNVCaiXwaff7m22QEcPAqLocrB23JmL0LdDBMUJB5K3HDm++Kk
         09Sa5ijex7DF53TVukQeGwPKUpKEs2GZ+VTwX1WzH9Ppt0QkznyASlfqY3OtCnc3K1Gc
         QJ7hAQQBhu1q473Q6HWeeaevO2ThJLbJbTgExnI/Be2mOkw/wIRPwLhQCm/lzpCcCfs4
         McXw==
X-Gm-Message-State: AOAM5300VYglspE/ggQgz8RLhMv7kymH99TjuqAbzpabGasarAUK6PCY
        RW7mPDhTElvXaggAJM/QF5W19g==
X-Google-Smtp-Source: ABdhPJxF41GfivsXMDQfqC1DXXz60qhvtndPKA1Nj3+m/4k5rkP2AyYYalAZGfzGFq0SCDm8Zu6iug==
X-Received: by 2002:a1c:9a8e:: with SMTP id c136mr184845wme.103.1623691736129;
        Mon, 14 Jun 2021 10:28:56 -0700 (PDT)
Received: from ?IPv6:2a01:e34:ed2f:f020:9d56:9c35:8a63:312c? ([2a01:e34:ed2f:f020:9d56:9c35:8a63:312c])
        by smtp.googlemail.com with ESMTPSA id z10sm11106879wmp.39.2021.06.14.10.28.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 14 Jun 2021 10:28:55 -0700 (PDT)
Subject: Re: [RESEND PATCH 2/2] thermal: sprd: add missing of_node_put for
 loop iteration
To:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Zhang Rui <rui.zhang@intel.com>,
        Amit Kucheria <amitk@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Orson Zhai <orsonzhai@gmail.com>,
        Baolin Wang <baolin.wang7@gmail.com>,
        Chunyan Zhang <zhang.lyra@gmail.com>, linux-pm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20210528115036.18222-1-krzysztof.kozlowski@canonical.com>
 <20210528115036.18222-2-krzysztof.kozlowski@canonical.com>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
Message-ID: <9d4b9827-74fb-43ea-bcc0-5c780296e6c0@linaro.org>
Date:   Mon, 14 Jun 2021 19:28:53 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20210528115036.18222-2-krzysztof.kozlowski@canonical.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 28/05/2021 13:50, Krzysztof Kozlowski wrote:
> Early exits from for_each_available_child_of_node() should decrement the
> node reference counter.  Reported by Coccinelle:
> 
>   drivers/thermal/sprd_thermal.c:387:1-23: WARNING:
>     Function "for_each_child_of_node" should have of_node_put() before goto around lines 391.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
> Acked-by: Chunyan Zhang <zhang.lyra@gmail.com>
> ---
>  drivers/thermal/sprd_thermal.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/drivers/thermal/sprd_thermal.c b/drivers/thermal/sprd_thermal.c
> index 3682edb2f466..2778971aaf03 100644
> --- a/drivers/thermal/sprd_thermal.c
> +++ b/drivers/thermal/sprd_thermal.c
> @@ -388,6 +388,7 @@ static int sprd_thm_probe(struct platform_device *pdev)
>  		sen = devm_kzalloc(&pdev->dev, sizeof(*sen), GFP_KERNEL);
>  		if (!sen) {
>  			ret = -ENOMEM;
> +			of_node_put(sen_child);

Why not a new label for the rollback routine?

eg. goto out_of_node_put;

Or a new function devm_for_each_available_child_of_node() ?

>  			goto disable_clk;
>  		}
>  
> @@ -397,12 +398,14 @@ static int sprd_thm_probe(struct platform_device *pdev)
>  		ret = of_property_read_u32(sen_child, "reg", &sen->id);
>  		if (ret) {
>  			dev_err(&pdev->dev, "get sensor reg failed");
> +			of_node_put(sen_child);
>  			goto disable_clk;
>  		}
>  
>  		ret = sprd_thm_sensor_calibration(sen_child, thm, sen);
>  		if (ret) {
>  			dev_err(&pdev->dev, "efuse cal analysis failed");
> +			of_node_put(sen_child);
>  			goto disable_clk;
>  		}
>  
> @@ -416,6 +419,7 @@ static int sprd_thm_probe(struct platform_device *pdev)
>  			dev_err(&pdev->dev, "register thermal zone failed %d\n",
>  				sen->id);
>  			ret = PTR_ERR(sen->tzd);
> +			of_node_put(sen_child);
>  			goto disable_clk;
>  		}
>  
> 


-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
