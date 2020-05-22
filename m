Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 11C7C1DEFBA
	for <lists+linux-pm@lfdr.de>; Fri, 22 May 2020 21:08:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730991AbgEVTI2 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 22 May 2020 15:08:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730922AbgEVTI1 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 22 May 2020 15:08:27 -0400
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EBBC3C08C5C0
        for <linux-pm@vger.kernel.org>; Fri, 22 May 2020 12:08:25 -0700 (PDT)
Received: by mail-wr1-x442.google.com with SMTP id l11so11222310wru.0
        for <linux-pm@vger.kernel.org>; Fri, 22 May 2020 12:08:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=x/MRQ96H6Az+pqXHXN01ej45PZoEed6u3UDYNQ8cdX4=;
        b=PzVhr2wPkOGE+YF9Q0Ja37GGyUsYVsZsJL57zig1z8BCa8Qep5Xti7/yjRJQ9/qJHf
         QDhZud1Tjjnao51/AdKATcPcGpgymDVv+DP9ZUqSC50m9yp8JxQN8GorUusIC61ibMSv
         1k8FLY7CEVJdEodNUo1gSa/Ok2XPUCBAfNjDQgh3VtgYCy+7aRuvD1jA2sTMTxseHFNX
         5b4RAQucgHzFF3CuwZClKX26YpFeJM4Lws5JWo+YousVNxXMo8Jn30LpR5IpK4yllbTW
         NaRfvW8DhcXmzGQolc7AgeOmKDxCXUMZiHJwyTrrD5tbM1QKlneKviK+VPWJImn3UQCW
         oIPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=x/MRQ96H6Az+pqXHXN01ej45PZoEed6u3UDYNQ8cdX4=;
        b=RF9AGQjKZeTOyso2u0trceKArh4NlL3jnm5I5hy7ntKr/p7dxHu8269lXNRB9iLL7u
         E3H7l9nNVnkt1w2liYqqSdikpYjwp8CRCVbgZ0xx+Wbs7FwplSmZrRHvCS7e4iSJo50P
         meNQhU3RQqajSyJzsje+GiKuRFxl/UNTbBVTFSRYaKVM34svAtm4N51obMXPtzuac7fQ
         Fk0f1qxUO1PDUP5acU7KjeHe4jphRO/b3byCz1iS2npiFc4eXL7Csvt4gPqelpAeB8b9
         z02mL9qpyTmNt2GzFOyAOmMRKGwPxanIBpI6Q5rJ5IW8QKwKIaUw4KROBNaJ3bmnbDmt
         z6jA==
X-Gm-Message-State: AOAM533AhMOpdtERvc8kwafIVWkd65eHqVFcwSaycvcdrF4SWeD+psZ9
        0+9HBbFUVFU6O+HlQLgqIk/aOA==
X-Google-Smtp-Source: ABdhPJyyCvXxzy7xLZ+QVT611FhNvs3cXyfNnYMd18QneEGfeQ/uinWi8SdNplS5akPuJufHz1nPQQ==
X-Received: by 2002:adf:e588:: with SMTP id l8mr1815032wrm.255.1590174504530;
        Fri, 22 May 2020 12:08:24 -0700 (PDT)
Received: from ?IPv6:2a01:e34:ed2f:f020:a82f:eaec:3c49:875a? ([2a01:e34:ed2f:f020:a82f:eaec:3c49:875a])
        by smtp.googlemail.com with ESMTPSA id z10sm10252695wmi.2.2020.05.22.12.08.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 22 May 2020 12:08:23 -0700 (PDT)
Subject: Re: [RESEND PATCH] thermal: mediatek: add suspend/resume callback
To:     Michael Kao <michael.kao@mediatek.com>,
        Zhang Rui <rui.zhang@intel.com>,
        Eduardo Valentin <edubezval@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Matthias Brugger <matthias.bgg@gmail.com>, hsinyi@chromium.org,
        linux-pm@vger.kernel.org, srv_heupstream@mediatek.com
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        Louis Yu <louis.yu@mediatek.com>
References: <20200408090558.12410-1-michael.kao@mediatek.com>
 <20200408090558.12410-2-michael.kao@mediatek.com>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
Message-ID: <c95b1b31-b6c6-9b45-33f4-b3673ae27680@linaro.org>
Date:   Fri, 22 May 2020 21:08:22 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200408090558.12410-2-michael.kao@mediatek.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 08/04/2020 11:05, Michael Kao wrote:
> From: Louis Yu <louis.yu@mediatek.com>
> 
> Add suspend/resume callback to disable/enable Mediatek thermal sensor
> respectively. Since thermal power domain is off in suspend, thermal driver
> needs re-initialization during resume.
> 
> Signed-off-by: Louis Yu <louis.yu@mediatek.com>
> Signed-off-by: Michael Kao <michael.kao@mediatek.com>

[ ... ]

> +static int __maybe_unused mtk_thermal_suspend(struct device *dev)
> +{
> +	struct platform_device *pdev = to_platform_device(dev);
> +	struct mtk_thermal *mt = platform_get_drvdata(pdev);
> +	int i, ret;
> +

Why is there a multi-controller loop in the probe and resume functions
and not here?

> +	for (i = 0; i < mt->conf->num_banks; i++) {
> +		ret = mtk_thermal_disable_sensing(mt, i);
> +		if (ret)
> +			goto out;
> +	}
> +
> +	/* disable buffer */
> +	writel(readl(mt->apmixed_base + APMIXED_SYS_TS_CON1) |
> +	       APMIXED_SYS_TS_CON1_BUFFER_OFF,
> +	       mt->apmixed_base + APMIXED_SYS_TS_CON1);
> +
> +	clk_disable_unprepare(mt->clk_peri_therm);
> +	clk_disable_unprepare(mt->clk_auxadc);
> +
> +	return 0;
> +
> +out:
> +	dev_err(&pdev->dev, "Failed to wait until bus idle\n");
> +
> +	return ret;
> +}
> +
> +static int __maybe_unused mtk_thermal_resume(struct device *dev)
> +{
> +	struct platform_device *pdev = to_platform_device(dev);
> +	struct mtk_thermal *mt = platform_get_drvdata(pdev);
> +	int i, ret, ctrl_id;
> +
> +	ret = device_reset(&pdev->dev);
> +	if (ret)
> +		return ret;
> +
> +	ret = clk_prepare_enable(mt->clk_auxadc);
> +	if (ret) {
> +		dev_err(&pdev->dev, "Can't enable auxadc clk: %d\n", ret);
> +		goto err_disable_clk_auxadc;
> +	}
> +
> +	ret = clk_prepare_enable(mt->clk_peri_therm);
> +	if (ret) {
> +		dev_err(&pdev->dev, "Can't enable peri clk: %d\n", ret);
> +		goto err_disable_clk_peri_therm;
> +	}
> +
> +	for (ctrl_id = 0; ctrl_id < mt->conf->num_controller ; ctrl_id++)
> +		for (i = 0; i < mt->conf->num_banks; i++)
> +			mtk_thermal_init_bank(mt, i, mt->apmixed_phys_base,
> +					      mt->auxadc_phys_base, ctrl_id);
> +
> +	return 0;
> +
> +err_disable_clk_peri_therm:
> +	clk_disable_unprepare(mt->clk_peri_therm);
> +err_disable_clk_auxadc:
> +	clk_disable_unprepare(mt->clk_auxadc);
> +
> +	return ret;
> +}
> +
> +static SIMPLE_DEV_PM_OPS(mtk_thermal_pm_ops,
> +			 mtk_thermal_suspend, mtk_thermal_resume);
> +
>  static struct platform_driver mtk_thermal_driver = {
>  	.probe = mtk_thermal_probe,
>  	.remove = mtk_thermal_remove,
>  	.driver = {
>  		.name = "mtk-thermal",
> +		.pm = &mtk_thermal_pm_ops,
>  		.of_match_table = mtk_thermal_of_match,
>  	},
>  };
> 


-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
