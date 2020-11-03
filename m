Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0A1FA2A4B39
	for <lists+linux-pm@lfdr.de>; Tue,  3 Nov 2020 17:24:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727857AbgKCQYb (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 3 Nov 2020 11:24:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728164AbgKCQYa (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 3 Nov 2020 11:24:30 -0500
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0101C061A47
        for <linux-pm@vger.kernel.org>; Tue,  3 Nov 2020 08:24:28 -0800 (PST)
Received: by mail-wr1-x441.google.com with SMTP id g12so19158228wrp.10
        for <linux-pm@vger.kernel.org>; Tue, 03 Nov 2020 08:24:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:autocrypt:message-id:date
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=TWMGG87FE9uxAtDy09w/VsVP9sl7tO1y2QmrppQSsaE=;
        b=IpbtN+UAsR8RU2BqqBRla23ltFM1COkP4gRGqcT5GOM8fNoEJ/7+Fex9YAGctIm1+c
         cu6th1RS9ruyiCKj+n96Bju2w8T3vmX33aQLPVJQH8oKa0PtHJb3YxnZk49NYIzTFO5l
         rRFTUgzc1a6dRkxSfVc5H4qXjOwDsBYyNG/3ge/bFHdJLMLgiZBisemjVAm+RMTX8ak2
         3yLLrMKMYjOiPa+bzCFeeTrVf1o2hlB/H2qPzr88Dk4q9VO4JT7HDrHI+MeA6+d+tkWo
         XtOc6ICOOjharPDlq1moJUkhnzGkw+d3YjNdtDqsdtTLfwimf/b9kS7ryBlZhvyUtFwH
         dloA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:autocrypt
         :message-id:date:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=TWMGG87FE9uxAtDy09w/VsVP9sl7tO1y2QmrppQSsaE=;
        b=gdd31FDZDK/SQBdGjtj7yhTy4bUWXe4pmIz/pTkMD7ERa71l6uFpMZiG6Oaivz1V6p
         cyBBrFnQf+6ELwWlQYXmeKQiSpfCnrkE8zMsGgfrR247Uuxen11gWeg8XAOP4GPlLPje
         VVzfYBDkqU4Mf1rnvGRIlrOIi27Qu+nLCyoBj+DQw2Bpm8SMitTOsEuwc4tgQJjkfvsm
         kuB/2Ic3QmHY0ZD6jRCJzsoceqAVgn9qRrk5DT38wUjjxV/rbCZrYuXEnZOo8XbAcAQN
         8ua32tmb99i1v8rJJb7zlM++LGO8D/YxWeyhE0/hzdTuFYIFwzbyOkR91STcYN80xo39
         a6OA==
X-Gm-Message-State: AOAM530hfx27JXvXt95jJ9xVy2FOkJU1eGQs/P9+tBr6gyl/dpM2evqW
        s0vRIrCrg6+JuA6v61da9nb6HA==
X-Google-Smtp-Source: ABdhPJy0oLpmlcWd27VCnlo6WCwvu/BBtbCPPJyhvx1h7cnN5MGLYbhvprlPg1+nexxBU9uS13F88A==
X-Received: by 2002:adf:e2c9:: with SMTP id d9mr26915653wrj.11.1604420667261;
        Tue, 03 Nov 2020 08:24:27 -0800 (PST)
Received: from [10.44.66.8] ([212.45.67.2])
        by smtp.googlemail.com with ESMTPSA id b136sm3286005wmb.21.2020.11.03.08.24.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 03 Nov 2020 08:24:26 -0800 (PST)
Subject: Re: [PATCH v4 2/2] interconnect: qcom: Add SDM660 interconnect
 provider driver
To:     kholk11@gmail.com
Cc:     bjorn.andersson@linaro.org, robh+dt@kernel.org, agross@kernel.org,
        marijns95@gmail.com, konradybcio@gmail.com,
        martin.botka1@gmail.com, linux-arm-msm@vger.kernel.org,
        phone-devel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20201017133718.31327-1-kholk11@gmail.com>
 <20201017133718.31327-3-kholk11@gmail.com>
From:   Georgi Djakov <georgi.djakov@linaro.org>
Autocrypt: addr=georgi.djakov@linaro.org; prefer-encrypt=mutual; keydata=
 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
 KEmKjLDvB0pePJkdTw==
Message-ID: <24ad51dd-ff54-35af-a7bc-92d8cfa30c48@linaro.org>
Date:   Tue, 3 Nov 2020 18:24:28 +0200
MIME-Version: 1.0
In-Reply-To: <20201017133718.31327-3-kholk11@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 10/17/20 16:37, kholk11@gmail.com wrote:
> From: AngeloGioacchino Del Regno <kholk11@gmail.com>
> 
> Introduce a driver for the Qualcomm interconnect busses found in
> the SDM630/SDM636/SDM660 SoCs.
> The topology consists of several NoCs that are controlled by a
> remote processor that collects the aggregated bandwidth for each
> master-slave pairs.
> 
> On a note, these chips are managing the "bus QoS" in a "hybrid"
> fashion: some of the paths in the topology are managed through
> (and by, of course) the RPM uC, while some others are "AP Owned",
> meaning that the AP shall do direct writes to the appropriate
> QoS registers for the specific paths and ports, instead of sending
> an indication to the RPM and leaving the job to that one.
> 
> Signed-off-by: AngeloGioacchino Del Regno <kholk11@gmail.com>
> ---
>  drivers/interconnect/qcom/Kconfig  |   9 +
>  drivers/interconnect/qcom/Makefile |   2 +
>  drivers/interconnect/qcom/sdm660.c | 922 +++++++++++++++++++++++++++++
>  3 files changed, 933 insertions(+)
>  create mode 100644 drivers/interconnect/qcom/sdm660.c
> 
[..]> +static const struct of_device_id sdm660_noc_of_match[] = {
> +	{ .compatible = "qcom,sdm660-a2noc", .data = &sdm660_a2noc },
> +	{ .compatible = "qcom,sdm660-bimc", .data = &sdm660_bimc },
> +	{ .compatible = "qcom,sdm660-cnoc", .data = &sdm660_cnoc },
> +	{ .compatible = "qcom,sdm660-gnoc", .data = &sdm660_gnoc },
> +	{ .compatible = "qcom,sdm660-mnoc", .data = &sdm660_mnoc },
> +	{ .compatible = "qcom,sdm660-snoc", .data = &sdm660_snoc },
> +	{ },
> +};
> +MODULE_DEVICE_TABLE(of, sdm660_noc_of_match);
> +
> +static struct platform_driver sdm660_noc_driver = {
> +	.probe = qnoc_probe,
> +	.remove = qnoc_remove,
> +	.driver = {
> +		.name = "qnoc-sdm660",
> +		.of_match_table = sdm660_noc_of_match,

Just noticed that here we should set the sync_state callback:
		.sync_state = icc_sync_state,

I will fix it up before applying. Are you planning to send a patch
that adds the DT nodes?

Thanks,
Georgi

> +	},
> +};
> +module_platform_driver(sdm660_noc_driver);
> +MODULE_DESCRIPTION("Qualcomm sdm660 NoC driver");
> +MODULE_LICENSE("GPL v2");
