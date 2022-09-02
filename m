Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D2DF75AA8D5
	for <lists+linux-pm@lfdr.de>; Fri,  2 Sep 2022 09:39:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231266AbiIBHjg (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 2 Sep 2022 03:39:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235344AbiIBHje (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 2 Sep 2022 03:39:34 -0400
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C9A0BA158
        for <linux-pm@vger.kernel.org>; Fri,  2 Sep 2022 00:39:22 -0700 (PDT)
Received: by mail-pl1-x62b.google.com with SMTP id d12so1090861plr.6
        for <linux-pm@vger.kernel.org>; Fri, 02 Sep 2022 00:39:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=wNDz/m+k0rmY0xmyC7oRNYzyqo8lp6wnwTdtifTQ9so=;
        b=apha703V8dhsgf/KeV6Fhjsz11QeNOtando5LLC9PWB8KSvVW2VGZErMnLFqy6UhCD
         +ghoiskYzPT3SNX+SkKjtscbI1q89E0FJpge21dqnR334ZBvsh7wgSw5Gb+8WJBb9WoP
         PyFzBi5gDvzbYChOZtyKoSzlQOo0pBq00OnJxYvAUFLBll+uxVou5O0jOlbvHbDDbGg6
         wFmX4AiBV3myzOZzSoTabaryQTvx14ifJT+ZYNsL3yCWYeFLDl7qJ1x4yzSIjmR8H3sW
         i1EbOQ5CQTxphYSP5PLaLiq6Sz1hQBXf6W7qBJQpGJox7A8DSPdWmgLr9Qhg/n0S236D
         v0gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=wNDz/m+k0rmY0xmyC7oRNYzyqo8lp6wnwTdtifTQ9so=;
        b=PdlyUMA3BydKp9nLtbXLpkrgoqOfJsuEy5BaNlORZ5cZIYvs7FUmB/IY3lzoR58g3L
         ujy891Z6AI2wqe4WsGDEAVXSMoiFPyJWeXlI55xr7dUYSUkCmJBmxOMZQASk2fWo327M
         87kTuBxxaOswxc2/x+r9u/p3t8eXE4wHNthwET1YlGYmDFniXWeo9lG4RJ4Q7gEx4/4Y
         7wEZR4Bi1qsEuy6EgV7zXAWj+MDl5Y42sA9WADEfkyRciORqiwRvV2lCy+Mxh0q1IFXe
         lKUs8l/+QRQbOyirw1OP++Rk/5OUSDL4Y16ruNeN251VVEn/sZXkM7pqziQOXT4UlKDf
         E6vg==
X-Gm-Message-State: ACgBeo3vGacoQtafaarL6Nok9dLp8L8kXOxYq7svPlgP+U3ImlhdHZUd
        /pHrxiq1Rp2AfRYRbR3KPk3wWA==
X-Google-Smtp-Source: AA6agR7apy39qMtkxwPATG2oo3z7xmYlnxoxluKt4TgnoJGOErMf2X2A2zSXwA6aaIy1apHVNTwuxw==
X-Received: by 2002:a17:903:1109:b0:170:a092:c881 with SMTP id n9-20020a170903110900b00170a092c881mr33600605plh.68.1662104361793;
        Fri, 02 Sep 2022 00:39:21 -0700 (PDT)
Received: from ?IPV6:2401:4900:1c60:5362:9d7f:2354:1d0a:78e3? ([2401:4900:1c60:5362:9d7f:2354:1d0a:78e3])
        by smtp.gmail.com with ESMTPSA id f7-20020a635547000000b0042b117e8bf8sm773930pgm.23.2022.09.02.00.39.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 02 Sep 2022 00:39:21 -0700 (PDT)
Message-ID: <fa80cfba-2417-ec04-936a-88bea0b2a8e0@linaro.org>
Date:   Fri, 2 Sep 2022 13:09:17 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [PATCH] thermal/drivers/qcom: Drop false build dependency of all
 QCOM drivers on QCOM_TSENS
Content-Language: en-US
To:     Jonathan Cameron <jic23@kernel.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     Amit Kucheria <amitk@kernel.org>,
        Thara Gopinath <thara.gopinath@gmail.com>,
        linux-pm@vger.kernel.org, Zhang Rui <rui.zhang@intel.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
References: <20220821160032.2206349-1-jic23@kernel.org>
From:   Bhupesh Sharma <bhupesh.sharma@linaro.org>
In-Reply-To: <20220821160032.2206349-1-jic23@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi,

On 8/21/22 9:30 PM, Jonathan Cameron wrote:
> From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> 
> The SPMI QCOM drivers have no dependency in Kconfig, but the Makefile
> will not be included without QCOM_TSENS. This unnecessarily reduces
> build coverage.
> 
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Cc: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> Cc: Bhupesh Sharma <bhupesh.sharma@linaro.org>
> ---
> 
> Run into whilst trying to build test a namespace move for the IIO
> interfaces used in these drivers.

Good catch. Actually, I am working on a detailed cleanup of the 
Makefile, Kconfig and Maintainers entries for qcom thermal driver 
entries as in the present form having all entries inside qcom/ directory 
dependent on CONFIG_QCOM_TSENS doesn't seem optimal (especially with new
driver files being added).

> Maintainers entry for TSENS should probably also be made more
> specific.
> ---
>   drivers/thermal/Makefile | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/thermal/Makefile b/drivers/thermal/Makefile
> index def8e1a0399c..2506c6c8ca83 100644
> --- a/drivers/thermal/Makefile
> +++ b/drivers/thermal/Makefile
> @@ -52,7 +52,7 @@ obj-$(CONFIG_DA9062_THERMAL)	+= da9062-thermal.o
>   obj-y				+= intel/
>   obj-$(CONFIG_TI_SOC_THERMAL)	+= ti-soc-thermal/
>   obj-y				+= st/
> -obj-$(CONFIG_QCOM_TSENS)	+= qcom/
> +obj-y				+= qcom/
>   obj-y				+= tegra/
>   obj-$(CONFIG_HISI_THERMAL)     += hisi_thermal.o
>   obj-$(CONFIG_MTK_THERMAL)	+= mtk_thermal.o

For now, this looks good to me, so:

Reviewed-by: Bhupesh Sharma <bhupesh.sharma@linaro.org>

Thanks.
