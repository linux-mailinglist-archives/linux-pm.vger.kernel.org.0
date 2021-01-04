Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6ED4A2E9D21
	for <lists+linux-pm@lfdr.de>; Mon,  4 Jan 2021 19:36:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727763AbhADSfL (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 4 Jan 2021 13:35:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727674AbhADSfL (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 4 Jan 2021 13:35:11 -0500
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C90FEC061794
        for <linux-pm@vger.kernel.org>; Mon,  4 Jan 2021 10:34:30 -0800 (PST)
Received: by mail-wm1-x331.google.com with SMTP id 3so169085wmg.4
        for <linux-pm@vger.kernel.org>; Mon, 04 Jan 2021 10:34:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=to:cc:references:from:subject:message-id:date:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=b3mdNXCCr+viQUHC/DPnqNgJo78Ga5nEbT7QXKoyiHA=;
        b=mJcGrH+CF7e3JLUi/6XdtHgMYZ05xDT4uKvH8qP6GKld3KbbCxzzrTReJoHQX0RRos
         z6he8w1AD7bgKoP7w1Ou9GEfIcM0qI50PfzdklX1exifUgOoJxcl+my40jj0NFyHuRr+
         eOO+6Ct4bbkEaXnW34IgnPcRJt2lDp+vcPG9v04pIcmIVVRHd4V37jm/5+e/LruGkdDs
         DbnUK+4AvSXaTxqpQm9HTsNR7FcIOn/uAKi+rnqPum2lVyXnZx1liZpKrLuYc5I9QCUZ
         vBCczjPJT8huRzKIvQC6Imx/iPGtTS7Z2tvxDigfcl0bbjGHA39H3hqnTJTf3Pm36iK1
         2cpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:cc:references:from:subject:message-id:date
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=b3mdNXCCr+viQUHC/DPnqNgJo78Ga5nEbT7QXKoyiHA=;
        b=SsQxQAhLY76BwIWTWROm8n8uCiYS20GD0gm3SfOwo6dZQD0sLfEQgGjvHowRlwmw75
         IInRBUw2fMDy3kcvhHRNdr5+CZEPq9BmRZJBMes7c92RSbdYBFHt0VzUlQVAVHNQn+Ze
         YrFAdRSRyeusgBXLctcIvdE0mrL1l8i9K9Ga8uUaMl2gjBrapzHoARa0CShJhhYnVrWc
         FxAm5o4Kilj7pMn1FEyemBA2BRBa0JsE5Sl4szvqs2tkykErJuWpDMmCyCx6+dxalCQD
         LJ+xcaUtCF6x++4X5fL56jfY1UwPzhjpKzYxJq8ny2z7GMgtTtj/j5D44vrVLmx5z0J+
         56vQ==
X-Gm-Message-State: AOAM533GgorRxO9SqhgwcnJz0QqOuxIgKHa1cOnq3Bfs0w3MOPH8amT+
        hn9yKc2iPnWgvL2vmmzQiOz+ySmL5+H1mg==
X-Google-Smtp-Source: ABdhPJwJYzGSd/ZPw+WDOq9k3YHFJGpNwRYCt7btmT6zdcFteWIZPoxAoFgw/VGVvxy40x8V6O0Sdg==
X-Received: by 2002:a1c:6144:: with SMTP id v65mr164151wmb.125.1609785269279;
        Mon, 04 Jan 2021 10:34:29 -0800 (PST)
Received: from [10.44.66.8] ([212.45.67.2])
        by smtp.googlemail.com with ESMTPSA id g78sm245217wme.33.2021.01.04.10.34.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 04 Jan 2021 10:34:28 -0800 (PST)
To:     Henry Chen <henryc.chen@mediatek.com>,
        Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Stephen Boyd <swboyd@chromium.org>,
        Ryan Case <ryandcase@chromium.org>,
        Mark Brown <broonie@kernel.org>
Cc:     Mark Rutland <mark.rutland@arm.com>,
        Nicolas Boichat <drinkcat@google.com>,
        Fan Chen <fan.chen@mediatek.com>,
        James Liao <jamesjj.liao@mediatek.com>,
        Arvin Wang <arvin.wang@mediatek.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org
References: <1608790134-27425-1-git-send-email-henryc.chen@mediatek.com>
 <1608790134-27425-8-git-send-email-henryc.chen@mediatek.com>
From:   Georgi Djakov <georgi.djakov@linaro.org>
Subject: Re: [PATCH V6 07/13] dt-bindings: interconnect: add MT6873
 interconnect dt-bindings
Message-ID: <f8951237-e236-aa99-5dbb-e92415752aa8@linaro.org>
Date:   Mon, 4 Jan 2021 20:34:30 +0200
MIME-Version: 1.0
In-Reply-To: <1608790134-27425-8-git-send-email-henryc.chen@mediatek.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 12/24/20 08:08, Henry Chen wrote:
> From: "henryc.chen" <henryc.chen@mediatek.com>
> 
> Add interconnect provider dt-bindings for MT6873.
> 
> Signed-off-by: Henry Chen <henryc.chen@mediatek.com>

checkpatch complains:

From:/Signed-off-by: email name mismatch:
'From: "henryc.chen" <henryc.chen@mediatek.com>' != 'Signed-off-by: Henry Chen 
<henryc.chen@mediatek.com>'

Thanks,
Georgi

> ---
>   include/dt-bindings/interconnect/mtk,mt6873-emi.h | 41 +++++++++++++++++++++++
>   1 file changed, 41 insertions(+)
>   create mode 100644 include/dt-bindings/interconnect/mtk,mt6873-emi.h
> 
> diff --git a/include/dt-bindings/interconnect/mtk,mt6873-emi.h b/include/dt-bindings/interconnect/mtk,mt6873-emi.h
> new file mode 100644
> index 0000000..7a0bbfb
> --- /dev/null
> +++ b/include/dt-bindings/interconnect/mtk,mt6873-emi.h
> @@ -0,0 +1,41 @@
> +/* SPDX-License-Identifier: GPL-2.0
> + *
> + * Copyright (c) 2020 MediaTek Inc.
> + */
> +
> +#ifndef __DT_BINDINGS_INTERCONNECT_MTK_MT6873_EMI_H
> +#define __DT_BINDINGS_INTERCONNECT_MTK_MT6873_EMI_H
> +
> +#define MT6873_SLAVE_DDR_EMI		0
> +#define MT6873_MASTER_MCUSYS		1
> +#define MT6873_MASTER_GPUSYS		2
> +#define MT6873_MASTER_MMSYS		3
> +#define MT6873_MASTER_MM_VPU		4
> +#define MT6873_MASTER_MM_DISP		5
> +#define MT6873_MASTER_MM_VDEC		6
> +#define MT6873_MASTER_MM_VENC		7
> +#define MT6873_MASTER_MM_CAM		8
> +#define MT6873_MASTER_MM_IMG		9
> +#define MT6873_MASTER_MM_MDP		10
> +#define MT6873_MASTER_VPUSYS		11
> +#define MT6873_MASTER_VPU_0		12
> +#define MT6873_MASTER_VPU_1		13
> +#define MT6873_MASTER_MDLASYS		14
> +#define MT6873_MASTER_MDLA_0		15
> +#define MT6873_MASTER_UFS		16
> +#define MT6873_MASTER_PCIE		17
> +#define MT6873_MASTER_USB		18
> +#define MT6873_MASTER_DBGIF		19
> +#define MT6873_SLAVE_HRT_DDR_EMI	20
> +#define MT6873_MASTER_HRT_MMSYS		21
> +#define MT6873_MASTER_HRT_MM_DISP	22
> +#define MT6873_MASTER_HRT_MM_VDEC	23
> +#define MT6873_MASTER_HRT_MM_VENC	24
> +#define MT6873_MASTER_HRT_MM_CAM	25
> +#define MT6873_MASTER_HRT_MM_IMG	26
> +#define MT6873_MASTER_HRT_MM_MDP	27
> +#define MT6873_MASTER_HRT_DBGIF		28
> +#define MT6873_MASTER_WIFI		29
> +#define MT6873_MASTER_BT		30
> +#define MT6873_MASTER_NETSYS		31
> +#endif
> 
