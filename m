Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8F9872CB73C
	for <lists+linux-pm@lfdr.de>; Wed,  2 Dec 2020 09:33:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729055AbgLBIbc (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 2 Dec 2020 03:31:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726961AbgLBIbc (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 2 Dec 2020 03:31:32 -0500
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9384C0613D6
        for <linux-pm@vger.kernel.org>; Wed,  2 Dec 2020 00:30:51 -0800 (PST)
Received: by mail-wr1-x442.google.com with SMTP id o1so2361911wrx.7
        for <linux-pm@vger.kernel.org>; Wed, 02 Dec 2020 00:30:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=Kv+7l2chK3BDjDnrtSuCO/Ck4S1sGg64eXnd1CzKhps=;
        b=AKiVlBIw7lV2r7P6+t8eXrk+RruD40E4KsMsjbXCT7d4yvmZeQELxlFvPGLWzXoNyB
         dXTIwrg8HCDixjPQHUVMZg2olQqxJqby+PVHSSp/Jdfv5H77LBui53/MjH1suRb8iTTn
         CXWkZWpEriGODimAugLGIXasU5fN8H69SwShT775YqYA031ZTxP61XD9U7bPkMsKjdAx
         S3djC5tqHqdMhbg4jdoVdxqEa/HYbRDzdapCYG9QtDcSV+tcP6dnmT6C6Jn93jNsCQ3Z
         KSAjADi0Kq+vnBdecB8pqkxEJPQy6OOFrLXp10YMgnf6JWFrTPG8PeOhQg73PEtq6i4V
         8PPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Kv+7l2chK3BDjDnrtSuCO/Ck4S1sGg64eXnd1CzKhps=;
        b=Qx6k8lea8nylhXAuVgjHmBhG3p+tz9t/l6xRplo7Od2MbAG5Lx1UQm8SO//oQJQEim
         J3YMX+wx6zuRTNCVlJHhDsAs06insIDxyml/XLL6trxpgCcBJNa6QQsmrGknP31K01pN
         fTI1aIDfkw9pDXjP9ven/mkjk7hITsROTZFizo2ocQ8aTEo8RlLHxhZpdzkbmt7GAT8i
         KigAuiLrN6DZ7LOwtESbdubTo+lTWfCPaYqrNBnOwnquB/YdUbA3mtfdSKQRLhH7lrm6
         txZ9yT12KvvtI++zQ8VyppgkyxqprGpM5bqm16vArqqzYZaj8hYLJaSRQcGEXuBJu1Bz
         SOmQ==
X-Gm-Message-State: AOAM530TNsTG/neVdKLJHVMPgkcYGkG6dYBGeUsDJ9BRU6JvwD6+a7Lh
        v/h6HS+TEzyCmSMQMkrMQyjQddsHVMMsjg==
X-Google-Smtp-Source: ABdhPJxUCOA7Ml/qtcsFPYTWfqTbF9TcbPWFseID+uwXx3JSyoZS/hh+UxfWNTvRJS1rhae6lp9RFg==
X-Received: by 2002:a5d:6150:: with SMTP id y16mr1867103wrt.107.1606897850296;
        Wed, 02 Dec 2020 00:30:50 -0800 (PST)
Received: from MacBook-Pro.local ([212.45.64.13])
        by smtp.googlemail.com with ESMTPSA id g25sm1108762wmk.5.2020.12.02.00.30.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 02 Dec 2020 00:30:49 -0800 (PST)
Subject: Re: [PATCH v2 6/7] arm64: defconfig: updates for 5.10
To:     Martin Kepplinger <martin.kepplinger@puri.sm>, robh@kernel.org,
        shawnguo@kernel.org, festevam@gmail.com, catalin.marinas@arm.com,
        will@kernel.org, cdleonard@gmail.com
Cc:     kernel@pengutronix.de, linux-imx@nxp.com, kernel@puri.sm,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
References: <20201201123932.12312-1-martin.kepplinger@puri.sm>
 <20201201123932.12312-7-martin.kepplinger@puri.sm>
From:   Georgi Djakov <georgi.djakov@linaro.org>
Message-ID: <fc53a7e0-c94a-b67a-38f3-cd5770159479@linaro.org>
Date:   Wed, 2 Dec 2020 10:30:48 +0200
MIME-Version: 1.0
In-Reply-To: <20201201123932.12312-7-martin.kepplinger@puri.sm>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Martin,

On 1.12.20 14:39, Martin Kepplinger wrote:
> Include the defconfig updates for v5.10 that shouldn't change the
> config itself at all.
 >
> Signed-off-by: Martin Kepplinger <martin.kepplinger@puri.sm>
> ---
>   arch/arm64/configs/defconfig | 82 +++++++++++-------------------------
>   1 file changed, 24 insertions(+), 58 deletions(-)
> 
> diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
> index 867cc4a5f00f..1fed16950a7c 100644
> --- a/arch/arm64/configs/defconfig
> +++ b/arch/arm64/configs/defconfig
[..]
>   CONFIG_INTERCONNECT=y
>   CONFIG_INTERCONNECT_QCOM=y
>   CONFIG_INTERCONNECT_QCOM_MSM8916=m
> -CONFIG_INTERCONNECT_QCOM_OSM_L3=m

Why are you removing this? Other boards are using it. I am actually
failing to understand this patch. Maybe it was meant to be sort of
cleanup, but such cleanups are usually done by the maintainers after
the merge window, as they lead to multiple conflicts with other patches.
I would suggest to just drop this patch.

Thanks,
Georgi

>   CONFIG_INTERCONNECT_QCOM_SDM845=m
>   CONFIG_INTERCONNECT_QCOM_SM8150=m
>   CONFIG_INTERCONNECT_QCOM_SM8250=m
> @@ -1075,7 +1043,6 @@ CONFIG_CUSE=m
>   CONFIG_OVERLAY_FS=m
>   CONFIG_VFAT_FS=y
>   CONFIG_HUGETLBFS=y
> -CONFIG_CONFIGFS_FS=y
>   CONFIG_EFIVAR_FS=y
>   CONFIG_SQUASHFS=y
>   CONFIG_NFS_FS=y
> @@ -1098,7 +1065,6 @@ CONFIG_CRYPTO_DEV_CCREE=m
>   CONFIG_CRYPTO_DEV_HISI_SEC2=m
>   CONFIG_CRYPTO_DEV_HISI_ZIP=m
>   CONFIG_CRYPTO_DEV_HISI_HPRE=m
> -CONFIG_CRYPTO_DEV_HISI_TRNG=m
>   CONFIG_CMA_SIZE_MBYTES=32
>   CONFIG_PRINTK_TIME=y
>   CONFIG_DEBUG_INFO=y
> 

