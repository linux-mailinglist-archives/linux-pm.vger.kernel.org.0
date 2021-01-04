Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A84A42E97CD
	for <lists+linux-pm@lfdr.de>; Mon,  4 Jan 2021 15:57:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727380AbhADO5C (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 4 Jan 2021 09:57:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727047AbhADO5C (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 4 Jan 2021 09:57:02 -0500
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F01EC061798
        for <linux-pm@vger.kernel.org>; Mon,  4 Jan 2021 06:55:47 -0800 (PST)
Received: by mail-wr1-x42d.google.com with SMTP id t16so32464058wra.3
        for <linux-pm@vger.kernel.org>; Mon, 04 Jan 2021 06:55:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=to:cc:references:from:subject:message-id:date:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=spZiulz5vjIZKQGtmvUTqdX4a9LlbwiYNkUKafbbP1A=;
        b=MX3x3t6aW5+9FTyLKWPjyQkoDzorLzEjkkO0RIRIUXOjYAwfquJVnsF1+16eaRDjp+
         yU7wxbCFqT+dyVgOKYEsZZmbHlVFIWZM3dDWUaA5YhDpA0fLYTQwArvinzboJl0NQS6p
         bv2SFD38cgQZhu/T2AQU0XuuVRJVcqHna4PTHh8viT4CwKWXT/+EpCPkFN/hkSSg1MLJ
         /jGZJtiPhHpSGqJiXLMYyBCsH6O9uIJb6WDAawq5JipHwEkdlnyCPB5OaNlDqeK++jkH
         u6stU3siocFeLOVwpVrHN7M7wPD3kfEeeJX8uL+Lvpo3u/IUw0hEPVt+BokOnSRvaBpz
         2ayg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:cc:references:from:subject:message-id:date
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=spZiulz5vjIZKQGtmvUTqdX4a9LlbwiYNkUKafbbP1A=;
        b=BqCxg+5d/94d1xzdcHILaRmoHp43nRojlSpqbfIhivXl+F+FpF7NMVq/zhz98HDDRq
         XBtbF0640o4LHwuWocOwybiLVGolwjVQX1ui3AC0pQesWRr0wAdv1peBr94vSClY8If6
         PVjzsMF1Zf6LOG59r3rRR7KJxIPhPS5ZSXQQ27WTRE/Km3KhXKA4sgowWMERbot/boqD
         837UAYcdj0rPz1H2D8RfUa7tJYU/rgRJKJgHuJS4mg2nvxiSaw0zRyzsd5AWzA00b3Yq
         VkxNqlNgqvYX1D5zUEGIWRcMWabw+3gq9dTUItSb8S/vfniGFDSlw2xd0RshwHSptyF6
         F1Ug==
X-Gm-Message-State: AOAM5329RAUkNDtau6p61WrAQy7YZ1me0IuddI59PpRV4uCbNvzU7MYT
        yyN/bg9p9jzJFjtA7Xr+pYKvGy2QQTkP6w==
X-Google-Smtp-Source: ABdhPJyx0l3teJNfd54KuUkWZsf8gyMx59sKUuHgRVfJeRc3X6RsVeUOH47cJL5XLpikGV1l3LK9Jw==
X-Received: by 2002:adf:e552:: with SMTP id z18mr83249897wrm.29.1609772145956;
        Mon, 04 Jan 2021 06:55:45 -0800 (PST)
Received: from [10.44.66.8] ([212.45.67.2])
        by smtp.googlemail.com with ESMTPSA id v1sm33258615wmj.31.2021.01.04.06.55.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 04 Jan 2021 06:55:45 -0800 (PST)
To:     Martin Kepplinger <martin.kepplinger@puri.sm>, robh@kernel.org,
        shawnguo@kernel.org, festevam@gmail.com, catalin.marinas@arm.com,
        will@kernel.org, cdleonard@gmail.com
Cc:     kernel@pengutronix.de, linux-imx@nxp.com, kernel@puri.sm,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
References: <20201210100906.18205-1-martin.kepplinger@puri.sm>
 <20201210100906.18205-7-martin.kepplinger@puri.sm>
From:   Georgi Djakov <georgi.djakov@linaro.org>
Subject: Re: [PATCH v3 6/6] arm64: defconfig: Enable interconnect for imx8mq
Message-ID: <14b3f927-cfe7-67bd-93a4-e869a68cdbfb@linaro.org>
Date:   Mon, 4 Jan 2021 16:55:47 +0200
MIME-Version: 1.0
In-Reply-To: <20201210100906.18205-7-martin.kepplinger@puri.sm>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 12/10/20 12:09, Martin Kepplinger wrote:
> Enable INTERCONNECT_IMX8MQ in order to make interconnect more widely
> available.
> 
> Signed-off-by: Martin Kepplinger <martin.kepplinger@puri.sm>

Acked-by: Georgi Djakov <georgi.djakov@linaro.org>

> ---
>   arch/arm64/configs/defconfig | 2 ++
>   1 file changed, 2 insertions(+)
> 
> diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
> index c8ca76751a34..f25748b0fa95 100644
> --- a/arch/arm64/configs/defconfig
> +++ b/arch/arm64/configs/defconfig
> @@ -1074,6 +1074,8 @@ CONFIG_SLIM_QCOM_CTRL=m
>   CONFIG_SLIM_QCOM_NGD_CTRL=m
>   CONFIG_MUX_MMIO=y
>   CONFIG_INTERCONNECT=y
> +CONFIG_INTERCONNECT_IMX=m
> +CONFIG_INTERCONNECT_IMX8MQ=m
>   CONFIG_INTERCONNECT_QCOM=y
>   CONFIG_INTERCONNECT_QCOM_MSM8916=m
>   CONFIG_INTERCONNECT_QCOM_OSM_L3=m
> 
