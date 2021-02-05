Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C9B3731133D
	for <lists+linux-pm@lfdr.de>; Fri,  5 Feb 2021 22:16:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233081AbhBEVQI (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 5 Feb 2021 16:16:08 -0500
Received: from mail-ot1-f51.google.com ([209.85.210.51]:39240 "EHLO
        mail-ot1-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231991AbhBETDa (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 5 Feb 2021 14:03:30 -0500
Received: by mail-ot1-f51.google.com with SMTP id d7so5913676otq.6;
        Fri, 05 Feb 2021 12:45:41 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=RxzEdNszjTydBwDSiQ0N+rau9/NOvPsbDlp/JE7iLN0=;
        b=p6uWFssBq00/blcUVa8YG8EjBQo3eXfgMkyhmnJZ4JzdRmIkBg1tHFoxEza0nDemhj
         LyA1yZy2yvvF49QYtV1howgIKVRhk/i8lhmSHBPqL6WBtuz8ecs1X1QgGgmukWvko4ty
         HokKj9KQWrzd6ZzUeP2TkjMWXVu+aW6DsjmD/xHcJlzncWRregJy3uqf0U2KFAQmw5+9
         bS4jXpoN86awgrnF1irYQgxIb7jDqfTC/s8qoyvqhh+qYEpVpl/UZEtUuNl7M3cdn/rV
         9I69UP2hGHaJQQpFPQGz/IV6OD2thCn3d13irHWTPuhxzjR9/lGhOuNfPQ2x1VZm9vXJ
         ekKg==
X-Gm-Message-State: AOAM531C0zop+441RO8TvwfrJHanE1W3A1d7qCDmDhdima8gxCYJ7qTL
        loO1v9pHnfFX8vdbI7JbUg==
X-Google-Smtp-Source: ABdhPJzfyXuv5KitjkYvUCOHm9SE0/bJEvB60Jlm+gmbAsXJSv2oKsk5L7zAmYSGo2BXBz+hxYi2rw==
X-Received: by 2002:a9d:a77:: with SMTP id 110mr4776175otg.74.1612557914909;
        Fri, 05 Feb 2021 12:45:14 -0800 (PST)
Received: from robh.at.kernel.org (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id l4sm1989602oou.8.2021.02.05.12.45.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Feb 2021 12:45:13 -0800 (PST)
Received: (nullmailer pid 3700636 invoked by uid 1000);
        Fri, 05 Feb 2021 20:45:12 -0000
Date:   Fri, 5 Feb 2021 14:45:12 -0600
From:   Rob Herring <robh@kernel.org>
To:     Henry Chen <henryc.chen@mediatek.com>
Cc:     Georgi Djakov <georgi.djakov@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Stephen Boyd <swboyd@chromium.org>,
        Ryan Case <ryandcase@chromium.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Nicolas Boichat <drinkcat@google.com>,
        Fan Chen <fan.chen@mediatek.com>,
        James Liao <jamesjj.liao@mediatek.com>,
        Arvin Wang <arvin.wang@mediatek.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org
Subject: Re: [PATCH V8 07/12] dt-bindings: interconnect: add MT6873
 interconnect dt-bindings
Message-ID: <20210205204512.GA3697049@robh.at.kernel.org>
References: <1611648234-15043-1-git-send-email-henryc.chen@mediatek.com>
 <1611648234-15043-8-git-send-email-henryc.chen@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1611648234-15043-8-git-send-email-henryc.chen@mediatek.com>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Tue, Jan 26, 2021 at 04:03:49PM +0800, Henry Chen wrote:
> Add interconnect provider dt-bindings for MT6873.
> 
> Signed-off-by: Henry Chen <henryc.chen@mediatek.com>
> ---
>  include/dt-bindings/interconnect/mtk,mt6873-emi.h | 41 +++++++++++++++++++++++
>  1 file changed, 41 insertions(+)
>  create mode 100644 include/dt-bindings/interconnect/mtk,mt6873-emi.h

Odd that you put one header in patch 1 and this one separate.

> 
> diff --git a/include/dt-bindings/interconnect/mtk,mt6873-emi.h b/include/dt-bindings/interconnect/mtk,mt6873-emi.h
> new file mode 100644
> index 0000000..0b20011
> --- /dev/null
> +++ b/include/dt-bindings/interconnect/mtk,mt6873-emi.h
> @@ -0,0 +1,41 @@
> +/* SPDX-License-Identifier: GPL-2.0

Don't care about non-GPL users?

> + *
> + * Copyright (c) 2021 MediaTek Inc.
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
> -- 
> 1.9.1
> 
