Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A5BEA6A89A
	for <lists+linux-pm@lfdr.de>; Tue, 16 Jul 2019 14:23:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728121AbfGPMXJ (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 16 Jul 2019 08:23:09 -0400
Received: from mailout4.samsung.com ([203.254.224.34]:45154 "EHLO
        mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726997AbfGPMXJ (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 16 Jul 2019 08:23:09 -0400
Received: from epcas1p2.samsung.com (unknown [182.195.41.46])
        by mailout4.samsung.com (KnoxPortal) with ESMTP id 20190716122308epoutp049e1d50ad2d88adc97d16d74b277bbbc3~x4q9B5arU0123501235epoutp04m
        for <linux-pm@vger.kernel.org>; Tue, 16 Jul 2019 12:23:08 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20190716122308epoutp049e1d50ad2d88adc97d16d74b277bbbc3~x4q9B5arU0123501235epoutp04m
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1563279788;
        bh=caBujU9xjDMLgE+1hzfA/JTx9d8apYiGmYT2HyxVy6w=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=XJodqTDho73Knn2dCLspO/AxazlKFmvHYbMUW8Y+WBOI6C1iR2Z5zDY2FbN7LX8vp
         PD+3mDUGWL6LTVI1WqzdvV9vBe37IpYV2THrupPaVg0/bUhnQM1x0PwDcTPwGZNGpx
         cC69JUAGnmoRVI4AyzT+yHSfDFu3GbVg/jLSVoOI=
Received: from epsnrtp2.localdomain (unknown [182.195.42.163]) by
        epcas1p3.samsung.com (KnoxPortal) with ESMTP id
        20190716122307epcas1p3f5331e4058955aa48e3fae7a35897901~x4q8khLgA2340023400epcas1p3f;
        Tue, 16 Jul 2019 12:23:07 +0000 (GMT)
Received: from epsmges1p2.samsung.com (unknown [182.195.40.157]) by
        epsnrtp2.localdomain (Postfix) with ESMTP id 45p00p014jzMqYkV; Tue, 16 Jul
        2019 12:23:06 +0000 (GMT)
Received: from epcas1p3.samsung.com ( [182.195.41.47]) by
        epsmges1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        77.8D.04075.9A1CD2D5; Tue, 16 Jul 2019 21:23:05 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas1p4.samsung.com (KnoxPortal) with ESMTPA id
        20190716122305epcas1p4b445490c0133939f2854177e0483f22c~x4q61ebKZ0941709417epcas1p4i;
        Tue, 16 Jul 2019 12:23:05 +0000 (GMT)
Received: from epsmgms1p2new.samsung.com (unknown [182.195.42.42]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20190716122305epsmtrp101f1e9c8b34af987717368f143f7bb46~x4q6tzQ0e0761907619epsmtrp1U;
        Tue, 16 Jul 2019 12:23:05 +0000 (GMT)
X-AuditID: b6c32a36-b49ff70000000feb-82-5d2dc1a9ac3a
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
        D3.7E.03638.9A1CD2D5; Tue, 16 Jul 2019 21:23:05 +0900 (KST)
Received: from [10.113.221.102] (unknown [10.113.221.102]) by
        epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20190716122305epsmtip12430698e29dba4e261a82c159900cbfc~x4q6gBidJ2151621516epsmtip1F;
        Tue, 16 Jul 2019 12:23:05 +0000 (GMT)
Subject: Re: [PATCH v4 12/24] PM / devfreq: tegra30: Inline all one-line
 functions
To:     Dmitry Osipenko <digetx@gmail.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Tomeu Vizoso <tomeu.vizoso@collabora.com>
Cc:     linux-pm@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
From:   Chanwoo Choi <cw00.choi@samsung.com>
Organization: Samsung Electronics
Message-ID: <b5634fbe-8bc1-0f04-e13b-6345dfbb5615@samsung.com>
Date:   Tue, 16 Jul 2019 21:26:11 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
        Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <20190707223303.6755-13-digetx@gmail.com>
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA01Se0hTYRTv2+7u7karz6V52h+1bgRpmV7n5u1hBD0YKSVl9BS7uesD92J3
        RmZBZaT2sBdE3XJFJZSrjLJwhlgmhoYprUBKRTArpexhT5Vq2zXyv9855/c75/y+71By7S1S
        R+Xa3bzLzllpUk3cexQVG3PtYUx63JGqRaz3cy9iD4iXCLZ1/3sl6689T7JDRxsRW/pVJNlX
        +66S7K9aD8GW3XhGLlWZa7quILNP7FKajxYNkuay6kpkHro9PVWxOW9xDs9ZeJeet2c6LLn2
        7CQ6eV3GsgyjKY6JYRawibTeztn4JHp5SmrMylxrYCFav4Oz5gdSqZwg0LFLFrsc+W5en+MQ
        3Ek077RYnQuc8wXOJuTbs+dnOmwLmbi4eGOAuC0vx3f9A+Hswjv9/j7lXlSnOYRUFOAE8N5p
        QoeQmtLiGgRnO2uUUvAFQdmFWpkUfEfwvNxL/pOc+9Idwlpch+DkcYdE+ojg8c9qebAwBadB
        z9VhRbAQjn8jKP1VFFLI8SZ45PPKgpjE0VD/riOUn4xnwoufvSiINXgJVBV3KIKYwLNBvFEW
        ahqBN0JLo4eQOGHQfPZ1CKuwCbwD1xVS/0h4+fqCTMIzoOjuOXlwCcB/SPB1npBJFpZDa4U4
        ZmcKDDyuVkpYB/3HDo7hQrjW3EhK4hIE1fXtCqlggPqKU4FGVGBCFFTVxkrpmeAbKUfS4Ekw
        +O2IIkgBrIGSg1qJMgv8PV1jK0yDy8Wl5HFEi+PsiOMsiOMsiP+HXUREJZrKOwVbNi8wzvjx
        330bha412lSDLj1NaUCYQvREjb5+XrpWwe0QCmwNCCg5Ha5J+jY3XauxcAW7eJcjw5Vv5YUG
        ZAy89gm5LiLTEbh9uzuDMcYbDAY2gTEZGYaO1HhGo9K1OJtz83k87+Rd/3QySqXbi7a+3T0v
        sXhGx+Gb996pJxT8uZ/VnZy2vi7c0P7kdN7hB0MRhV8vrlU2efiR/pfepi2R96O0WWFZvaoO
        IrFvp3q4IvLHqrCRN0rPCn+LSaNevcZU0JxCtaWUnPEeG7VsWPesvXvN6NIE2Z4Wdo5u0/bC
        RW3JfRvKL/enTjxtOfkpeZiiCSGHY6LlLoH7C0rSKLbDAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprNIsWRmVeSWpSXmKPExsWy7bCSnO7Kg7qxBns/SVus/viY0aJl1iIW
        i7NNb9gtLu+aw2bxufcIo0Xnl1lsFrcbV7BZ/Nw1j8Wib+0lNgdOjx13lzB67Jx1l92jt/kd
        m0ffllWMHp83yQWwRnHZpKTmZJalFunbJXBl7FzzlqXgrkDF5ctP2RsY9/J2MXJySAiYSMz+
        dI+ti5GLQ0hgN6PE06Vn2SESkhLTLh5l7mLkALKFJQ4fLoaoecsocXnaVbAaYYEQiQcrfrGC
        JEQEmpgkNvVeAEswC0RK9MzdAjV1C6PE9kcH2EASbAJaEvtf3ACz+QUUJa7+eMwIYvMK2Ems
        b7/BCmKzCKhKzFrbxwxiiwpESEy6tpMFokZQ4uTMJ2A2p4CZxOpXa1ghlqlL/Jl3iRnCFpe4
        9WQ+E4QtL9G8dTbzBEbhWUjaZyFpmYWkZRaSlgWMLKsYJVMLinPTc4sNC4zyUsv1ihNzi0vz
        0vWS83M3MYKjTEtrB+OJE/GHGAU4GJV4eE/s0YkVYk0sK67MPcQowcGsJMJr+1U7Vog3JbGy
        KrUoP76oNCe1+BCjNAeLkjivfP6xSCGB9MSS1OzU1ILUIpgsEwenVANju+nbSVdey05ozr+t
        3XXaWOjJjmuG/bNE982qiz6g9NpFLdV4r0rs6VkeS/uf/XDrmWu2J+LgxA8Fl25xHbomft4i
        MWBaXrpztnK4m99fxf1HGNiX/5WQENpyvaTi1uqHr4MC5oouvxQyRTQ59L3igk/Ofvsrbfdf
        /2qqq35IY9LahQ+fKFzTU2Ipzkg01GIuKk4EAHNk09SuAgAA
X-CMS-MailID: 20190716122305epcas1p4b445490c0133939f2854177e0483f22c
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20190707223633epcas4p3873704f3199126be0e8d5cb7454c7a51
References: <20190707223303.6755-1-digetx@gmail.com>
        <CGME20190707223633epcas4p3873704f3199126be0e8d5cb7454c7a51@epcas4p3.samsung.com>
        <20190707223303.6755-13-digetx@gmail.com>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Dmitry,

I'm not sure that it is necessary.
As I knew, usally, the 'inline' is used on header file
to define the empty functions.

Do we have to change it with 'inline' keyword?

On 19. 7. 8. 오전 7:32, Dmitry Osipenko wrote:
> Depending on a kernel's configuration, a single line functions may not be
> inlined by compiler (like enabled ftracing for example). Let's inline such
> functions explicitly for consistency.
> 
> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
> ---
>  drivers/devfreq/tegra30-devfreq.c | 13 +++++++------
>  1 file changed, 7 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/devfreq/tegra30-devfreq.c b/drivers/devfreq/tegra30-devfreq.c
> index c6c4a07d3e07..1a10df5dbbed 100644
> --- a/drivers/devfreq/tegra30-devfreq.c
> +++ b/drivers/devfreq/tegra30-devfreq.c
> @@ -181,28 +181,29 @@ static struct tegra_actmon_emc_ratio actmon_emc_ratios[] = {
>  	{  250000,    100000 },
>  };
>  
> -static u32 actmon_readl(struct tegra_devfreq *tegra, u32 offset)
> +static inline u32 actmon_readl(struct tegra_devfreq *tegra, u32 offset)
>  {
>  	return readl_relaxed(tegra->regs + offset);
>  }
>  
> -static void actmon_writel(struct tegra_devfreq *tegra, u32 val, u32 offset)
> +static inline void actmon_writel(struct tegra_devfreq *tegra,
> +				 u32 val, u32 offset)
>  {
>  	writel_relaxed(val, tegra->regs + offset);
>  }
>  
> -static u32 device_readl(struct tegra_devfreq_device *dev, u32 offset)
> +static inline u32 device_readl(struct tegra_devfreq_device *dev, u32 offset)
>  {
>  	return readl_relaxed(dev->regs + offset);
>  }
>  
> -static void device_writel(struct tegra_devfreq_device *dev, u32 val,
> -			  u32 offset)
> +static inline void device_writel(struct tegra_devfreq_device *dev,
> +				 u32 val, u32 offset)
>  {
>  	writel_relaxed(val, dev->regs + offset);
>  }
>  
> -static unsigned long do_percent(unsigned long val, unsigned int pct)
> +static inline unsigned long do_percent(unsigned long val, unsigned int pct)
>  {
>  	return val * pct / 100;
>  }
> 


-- 
Best Regards,
Chanwoo Choi
Samsung Electronics
