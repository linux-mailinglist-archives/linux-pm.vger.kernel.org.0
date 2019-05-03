Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5BD111258A
	for <lists+linux-pm@lfdr.de>; Fri,  3 May 2019 02:35:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726327AbfECAfe (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 2 May 2019 20:35:34 -0400
Received: from mailout4.samsung.com ([203.254.224.34]:36586 "EHLO
        mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726128AbfECAfe (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 2 May 2019 20:35:34 -0400
Received: from epcas1p2.samsung.com (unknown [182.195.41.46])
        by mailout4.samsung.com (KnoxPortal) with ESMTP id 20190503003530epoutp047eab94386f647ed6469a216e1eda7c99~bBR-ZUk9-0606306063epoutp04B
        for <linux-pm@vger.kernel.org>; Fri,  3 May 2019 00:35:30 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20190503003530epoutp047eab94386f647ed6469a216e1eda7c99~bBR-ZUk9-0606306063epoutp04B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1556843730;
        bh=cDQEru1Tw2z50+9t//LrLBZsWuKsegv3LHRxivmR64o=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=dd7Cf36r3IntTas7/on7JysY/MmLMIxMY6s4CrnRvAIfjtiKARH/hiqaJYORZjg1P
         CuB7Yay+CogQJoszmJGGdoNIipIigKpaoqmxD2dQI/NU7XGsG6VgOENOpM2dbd9Gx9
         5KuXu4yqWOM61McZL40j+Mbe4VFmoOj3UwrAsVWI=
Received: from epsmges1p1.samsung.com (unknown [182.195.40.156]) by
        epcas1p4.samsung.com (KnoxPortal) with ESMTP id
        20190503003526epcas1p4008bb96b5e6415e24524e6da35425c6a~bBR71WaWe2374923749epcas1p4o;
        Fri,  3 May 2019 00:35:26 +0000 (GMT)
Received: from epcas1p3.samsung.com ( [182.195.41.47]) by
        epsmges1p1.samsung.com (Symantec Messaging Gateway) with SMTP id
        30.5C.04139.ECC8BCC5; Fri,  3 May 2019 09:35:26 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20190503003526epcas1p2d654d5c22d134d92a12fb920fcdfb74e~bBR7LnBA42529225292epcas1p2a;
        Fri,  3 May 2019 00:35:26 +0000 (GMT)
Received: from epsmgms1p2new.samsung.com (unknown [182.195.42.42]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20190503003525epsmtrp1c2cc8c3e9ce3eb6673d8a5d7c8352ee8~bBR7KYy6H0451104511epsmtrp1C;
        Fri,  3 May 2019 00:35:25 +0000 (GMT)
X-AuditID: b6c32a35-98bff7000000102b-cc-5ccb8ccefce9
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
        2C.C6.03662.DCC8BCC5; Fri,  3 May 2019 09:35:25 +0900 (KST)
Received: from [10.113.221.102] (unknown [10.113.221.102]) by
        epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20190503003525epsmtip1b9fbc6243bc8cc7fc0726d76f3f3443c~bBR63FE4f1682516825epsmtip1S;
        Fri,  3 May 2019 00:35:25 +0000 (GMT)
Subject: Re: [PATCH v5 1/6] devfreq: rockchip-dfi: Move GRF definitions to a
 common place.
To:     =?UTF-8?Q?Ga=c3=abl_PORTAY?= <gael.portay@collabora.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Rob Herring <robh+dt@kernel.org>,
        Heiko Stuebner <heiko@sntech.de>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Lin Huang <hl@rock-chips.com>,
        Brian Norris <briannorris@chromium.org>,
        Douglas Anderson <dianders@chromium.org>,
        Klaus Goger <klaus.goger@theobroma-systems.com>,
        Derek Basehore <dbasehore@chromium.org>,
        Randy Li <ayaka@soulik.info>, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org
Cc:     Mark Rutland <mark.rutland@arm.com>, kernel@collabora.com
From:   Chanwoo Choi <cw00.choi@samsung.com>
Organization: Samsung Electronics
Message-ID: <1f5cbebb-811d-d181-6d7f-83be6954514f@samsung.com>
Date:   Fri, 3 May 2019 09:36:44 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
        Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190502175820.25382-2-gael.portay@collabora.com>
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA02Te0xTdxTH8+t99ILrdimCZ2zZ8O6RQIJwwcKPRdCkztxkbGNZsmyEjF3h
        piX0ZW8xuieIOmTgdLKwFaZDYDpkwNrOIUq6leoGahUb0eDKiDKDQKZAMG5qXMuFjP8+5/s7
        39855/dgCO1DOoEptTgku0U0cXQ0ebw/KTUlUHu2MK2zPglPhv5F2DVzm8KT7lM0PuQPUPj8
        d7/SuOOaD+HW3mkaP7o+ReF73YMEdgdqKTx/4IgKn98xrcauG8MUDvY20Xiuzo/w7NgjArdd
        GVLha5VHabyrz6/eECt0HOxAQmPFECn0hFqR4GrfQwvu1k+Eh04vKez1tCPh5+GDhFAVaqCE
        H653k8Kc65n8FQVl64ySWCLZEyVLsbWk1GLI4V55s0hfpMtM41P4bJzFJVpEs5TDbczLT9lU
        agrPxyVuFU3lYSlflGUuNXed3VrukBKNVtmRw0m2EpMt27ZGFs1yucWwpthqfolPS0vXhRPf
        KzNOdLaQth3cttE7HnUFmnuqBkUxwK6FMdccUYOiGS3bg8D3zzlKCWYRjAVHSCW4i2Dfrfvk
        kqX65ChSFvoQ/FIxtOi/jaCpyh8OGCaWLYT+OykRfSV7hIJjl3pRxE2wOVD5431VhGk2GbwT
        V+kIP8Guhsv3bizkaNhcaG/uV0X2IdnnIeDbFpHj2LfhzzPdlJISAwNfjy80FMWuh77Jpe1X
        wcj4IZXCz0LVT42E0vS8Gjr3Riu8ER5cdFIKx8Lkbx61wglw6/Pdi/wBfD/gpyP9A1uNwOO9
        uGjIAG/bgYXeCDYJunpTlVqPw9/ztVREBlYD1bu1SvZzEBwLqRR+Elo+3UMrLECo7ktqH1rt
        XDaNc9kEzmUTOP8v9i0i21G8ZJPNBknmbfzyy3ahhaefrOtB9YE8H2IZxD2mgdHBQi0lbpW3
        m30IGIJbqXl3JixpSsTt70t2a5G93CTJPqQLn/V+IiGu2Br+SBZHEa9Lz8jIwGv5TB3Pc6s0
        XRv0hVrWIDqkMkmySfYln4qJSqhALxcUwPxgne5k5Udxo5m73tn0V9OxLc03N+u55t8/nHDz
        8Zs/fnG4tCM+9/iZYNbrMacvzMa92nlly4On6zUt2fqb5m+G968vqBkIXjKcxhPuqS8+o8an
        2w43CC9k3fVP+T0zh6O8huq39K/F/GFMf2NnV2Vj/UhD/FcnDEdVxXk7nZYAR8pGkU8m7LL4
        H5+3en8QBAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrBIsWRmVeSWpSXmKPExsWy7bCSnO7ZntMxBm0Nphav7v5itNj08T2r
        xavNe9gs5h85x2pxdtlBNos1tw8xWizZ9YbN4v+j16wWPzacYrbYfK6H1eLr5OVMFmeb3rBb
        bHp8jdXi8q45bBafe48wWnx68J/ZYun1i0wWtxtXsFm07j3C7iDssWbeGkaP2Q0XWTx23F3C
        6LFpVSebx+Yl9R5/Z+1n8ejbsorRY/u1ecwezXens3qsfbSBxePzJrkA7igum5TUnMyy1CJ9
        uwSujBfrFrMUNClV3Puwhb2B8bN0FyMnh4SAiUTH7nuMXYxcHEICuxklPj29ww6RkJSYdvEo
        cxcjB5AtLHH4cDFEzVtGia7ta9hA4sICMRKHP+iCxEUEVrJKTJ21FqyXWcBWonHjbyaIhuOM
        EovnrmMGSbAJaEnsf3GDDcTmF1CUuPrjMSOIzStgJ7Fq4WEmkKEsAioS5w5VgIRFBSIkzrxf
        wQJRIihxcuYTMJtTwF5i76tdjBC71CX+zLvEDGGLS9x6Mp8JwpaXaN46m3kCo/AsJO2zkLTM
        QtIyC0nLAkaWVYySqQXFuem5xYYFRnmp5XrFibnFpXnpesn5uZsYwfGvpbWD8cSJ+EOMAhyM
        Sjy8EvdOxQixJpYVV+YeYpTgYFYS4Y37CBTiTUmsrEotyo8vKs1JLT7EKM3BoiTOK59/LFJI
        ID2xJDU7NbUgtQgmy8TBKdXA2NY4dbKW8m/eR8f3vTweVltxVN8v5dg15pKZDLuCVt0M4ms+
        NsVvtYL/yiIF6f7G6Re+5rq2KR32Egy+srLEq9RFYP+dY9XGL8wN0+Kn/lribzrnZPTkIJb4
        F7sbl153PzjFZXt4VX2B5haHd4tepD1/cU931504pgrZ1Q13pQs+Xn5Y6DaVT4mlOCPRUIu5
        qDgRABZ8luf7AgAA
X-CMS-MailID: 20190503003526epcas1p2d654d5c22d134d92a12fb920fcdfb74e
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20190502175826epcas1p43c82151e13a9d7708d46ad78c113ba76
References: <20190502175820.25382-1-gael.portay@collabora.com>
        <CGME20190502175826epcas1p43c82151e13a9d7708d46ad78c113ba76@epcas1p4.samsung.com>
        <20190502175820.25382-2-gael.portay@collabora.com>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Gaël,

The patch1 was already applied to devfreq.git
and then it was applied to linux-pm.git through
pull request of devfreq.

[1] https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git/commit/?h=bleeding-edge&id=adfe3b76608ffe547af5a74415f15499b798f32a

On 19. 5. 3. 오전 2:58, Gaël PORTAY wrote:
> From: Enric Balletbo i Serra <enric.balletbo@collabora.com>
> 
> Some rk3399 GRF (Generic Register Files) definitions can be used for
> different drivers. Move these definitions to a common include so we
> don't need to duplicate these definitions.
> 
> Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
> Acked-by: Chanwoo Choi <cw00.choi@samsung.com>
> Signed-off-by: Gaël PORTAY <gael.portay@collabora.com>
> Acked-by: MyungJoo Ham <myungjoo.ham@samsung.com>
> ---
> 
> Changes in v5: None
> 
> Changes in v4:
> - [PATCH v3 1/5] Add Acked-by: MyungJoo Ham <myungjoo.ham@samsung.com>.
> 
> Changes in v3:
> - [PATCH v2 1/5] Add Signed-off-by: Gaël PORTAY <gael.portay@collabora.com>.
> 
> Changes in v2:
> - [PATCH 1/8] Really add Acked-by: Chanwoo Choi <cw00.choi@samsung.com>.
> 
> Changes in v1:
> - [RFC 1/10] Add Acked-by: Chanwoo Choi <cw00.choi@samsung.com>
> - [RFC 1/10] s/Generic/General/ (Robin Murphy)
> - [RFC 4/10] Removed from the series. I did not found a use case where not holding the mutex causes the issue.
> - [RFC 7/10] Removed from the series. I did not found a use case where this matters.
> 
>  drivers/devfreq/event/rockchip-dfi.c | 23 +++++++----------------
>  include/soc/rockchip/rk3399_grf.h    | 21 +++++++++++++++++++++
>  2 files changed, 28 insertions(+), 16 deletions(-)
>  create mode 100644 include/soc/rockchip/rk3399_grf.h
> 
> diff --git a/drivers/devfreq/event/rockchip-dfi.c b/drivers/devfreq/event/rockchip-dfi.c
> index 22b113363ffc..2fbbcbeb644f 100644
> --- a/drivers/devfreq/event/rockchip-dfi.c
> +++ b/drivers/devfreq/event/rockchip-dfi.c
> @@ -26,6 +26,8 @@
>  #include <linux/list.h>
>  #include <linux/of.h>
>  
> +#include <soc/rockchip/rk3399_grf.h>
> +
>  #define RK3399_DMC_NUM_CH	2
>  
>  /* DDRMON_CTRL */
> @@ -43,18 +45,6 @@
>  #define DDRMON_CH1_COUNT_NUM		0x3c
>  #define DDRMON_CH1_DFI_ACCESS_NUM	0x40
>  
> -/* pmu grf */
> -#define PMUGRF_OS_REG2	0x308
> -#define DDRTYPE_SHIFT	13
> -#define DDRTYPE_MASK	7
> -
> -enum {
> -	DDR3 = 3,
> -	LPDDR3 = 6,
> -	LPDDR4 = 7,
> -	UNUSED = 0xFF
> -};
> -
>  struct dmc_usage {
>  	u32 access;
>  	u32 total;
> @@ -83,16 +73,17 @@ static void rockchip_dfi_start_hardware_counter(struct devfreq_event_dev *edev)
>  	u32 ddr_type;
>  
>  	/* get ddr type */
> -	regmap_read(info->regmap_pmu, PMUGRF_OS_REG2, &val);
> -	ddr_type = (val >> DDRTYPE_SHIFT) & DDRTYPE_MASK;
> +	regmap_read(info->regmap_pmu, RK3399_PMUGRF_OS_REG2, &val);
> +	ddr_type = (val >> RK3399_PMUGRF_DDRTYPE_SHIFT) &
> +		    RK3399_PMUGRF_DDRTYPE_MASK;
>  
>  	/* clear DDRMON_CTRL setting */
>  	writel_relaxed(CLR_DDRMON_CTRL, dfi_regs + DDRMON_CTRL);
>  
>  	/* set ddr type to dfi */
> -	if (ddr_type == LPDDR3)
> +	if (ddr_type == RK3399_PMUGRF_DDRTYPE_LPDDR3)
>  		writel_relaxed(LPDDR3_EN, dfi_regs + DDRMON_CTRL);
> -	else if (ddr_type == LPDDR4)
> +	else if (ddr_type == RK3399_PMUGRF_DDRTYPE_LPDDR4)
>  		writel_relaxed(LPDDR4_EN, dfi_regs + DDRMON_CTRL);
>  
>  	/* enable count, use software mode */
> diff --git a/include/soc/rockchip/rk3399_grf.h b/include/soc/rockchip/rk3399_grf.h
> new file mode 100644
> index 000000000000..3eebabcb2812
> --- /dev/null
> +++ b/include/soc/rockchip/rk3399_grf.h
> @@ -0,0 +1,21 @@
> +/* SPDX-License-Identifier: GPL-2.0+ */
> +/*
> + * Rockchip General Register Files definitions
> + *
> + * Copyright (c) 2018, Collabora Ltd.
> + * Author: Enric Balletbo i Serra <enric.balletbo@collabora.com>
> + */
> +
> +#ifndef __SOC_RK3399_GRF_H
> +#define __SOC_RK3399_GRF_H
> +
> +/* PMU GRF Registers */
> +#define RK3399_PMUGRF_OS_REG2		0x308
> +#define RK3399_PMUGRF_DDRTYPE_SHIFT	13
> +#define RK3399_PMUGRF_DDRTYPE_MASK	7
> +#define RK3399_PMUGRF_DDRTYPE_DDR3	3
> +#define RK3399_PMUGRF_DDRTYPE_LPDDR2	5
> +#define RK3399_PMUGRF_DDRTYPE_LPDDR3	6
> +#define RK3399_PMUGRF_DDRTYPE_LPDDR4	7
> +
> +#endif
> 


-- 
Best Regards,
Chanwoo Choi
Samsung Electronics
