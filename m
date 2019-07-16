Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0FC336A89F
	for <lists+linux-pm@lfdr.de>; Tue, 16 Jul 2019 14:23:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727849AbfGPMXe (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 16 Jul 2019 08:23:34 -0400
Received: from mailout1.samsung.com ([203.254.224.24]:61423 "EHLO
        mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730520AbfGPMXd (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 16 Jul 2019 08:23:33 -0400
Received: from epcas1p2.samsung.com (unknown [182.195.41.46])
        by mailout1.samsung.com (KnoxPortal) with ESMTP id 20190716122330epoutp01a982724aeecb5b45415dbaf549f5d2a4~x4rR2efpr2473324733epoutp01N
        for <linux-pm@vger.kernel.org>; Tue, 16 Jul 2019 12:23:30 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20190716122330epoutp01a982724aeecb5b45415dbaf549f5d2a4~x4rR2efpr2473324733epoutp01N
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1563279810;
        bh=MjpXzluys5pJrbN9UUwkqRdKLhXnJW/pzhYrTp2wnAg=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=deMcgvKvvciwzIfLbITxdATZez1/sn/vfjz8I0lMz/84aaWIB3KKK4K7uQzQ+9SQV
         MJD1TDlu5BFZEQLzCuudZRYk7aqjI8iujHQ4G4P5bgGSfgKobtrjs91cDRpdnbc7i9
         CnT+AmeMsxmP5/LUgBLnQcspruotoFiaVhYKJ8Bo=
Received: from epsnrtp2.localdomain (unknown [182.195.42.163]) by
        epcas1p3.samsung.com (KnoxPortal) with ESMTP id
        20190716122329epcas1p352f0c248de2c0d65ebae9e6638681f2c~x4rRS4GZ32472024720epcas1p3H;
        Tue, 16 Jul 2019 12:23:29 +0000 (GMT)
Received: from epsmges1p5.samsung.com (unknown [182.195.40.156]) by
        epsnrtp2.localdomain (Postfix) with ESMTP id 45p01D39s1zMqYkR; Tue, 16 Jul
        2019 12:23:28 +0000 (GMT)
Received: from epcas1p4.samsung.com ( [182.195.41.48]) by
        epsmges1p5.samsung.com (Symantec Messaging Gateway) with SMTP id
        0F.4F.04085.0C1CD2D5; Tue, 16 Jul 2019 21:23:28 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas1p4.samsung.com (KnoxPortal) with ESMTPA id
        20190716122327epcas1p40cbcdaec8eedf94a7e17bb1e71743038~x4rPmA2Ej0941309413epcas1p47;
        Tue, 16 Jul 2019 12:23:27 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20190716122327epsmtrp1c0d40bfdf956e3f0bd596a5fc02230f6~x4rPlJvXw0818508185epsmtrp1G;
        Tue, 16 Jul 2019 12:23:27 +0000 (GMT)
X-AuditID: b6c32a39-d03ff70000000ff5-4e-5d2dc1c03403
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        3F.3E.03706.FB1CD2D5; Tue, 16 Jul 2019 21:23:27 +0900 (KST)
Received: from [10.113.221.102] (unknown [10.113.221.102]) by
        epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20190716122327epsmtip1a900aa861bf3835f30f41c64a21e28ba~x4rPXqTME1145611456epsmtip1w;
        Tue, 16 Jul 2019 12:23:27 +0000 (GMT)
Subject: Re: [PATCH v4 13/24] PM / devfreq: tegra30: Constify structs
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
Message-ID: <e53762a4-3637-b667-ad7d-e078a2284cac@samsung.com>
Date:   Tue, 16 Jul 2019 21:26:34 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
        Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <20190707223303.6755-14-digetx@gmail.com>
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA01SWUwTURTNa6fDQKyOFfTaD4UxRkCBjlgcjCUmbjWQ2EQ/XFJxAi9Q6Wan
        NaCJokU2BRc+1EERBSKCipKiLBq0EBEXXNC4AhqNQWM0ihqJC7YdjPyde+85997z3qXkqgZS
        TZmsTuyw8maGDCEudkRpYq5eizFqfg+EcvWfXyMuTzxJcHd2fQjieluPktxQSSfiir6KJPd8
        Zy3JDbdWEFzp2QfkomB9c1810reIfUH6EvdHUl/qqUP6ocZpBsW6rIWZmE/HjnBsTbOlm6wZ
        OiZ5VeriVG2Cho1hE7n5TLiVt2AdsyTFELPMZPYtxIRv4c0uX8rACwITl7TQYXM5cXimTXDq
        GGxPN9sT7bECbxFc1ozYNJtlAavRzNX6iBuzMn969sjt/eOyu4dic1FjSDEKpoCeB8fbfsuK
        UQilopsR3O19GyQFXxB4a+4TUvAdgfvzAPlP8vVmHikVriB47K1FUvAJQcenUoWfNYleCrfe
        vwjIQ+k/CIqG3QG5nF4LHS31Mj8m6WhoH3wSyE+gI+DRj9fIj5V0EnS33Qpggp4JuQUDgaZh
        9Bq42VlBSJyJ0H3kjQ9TVDCdAM8O6aT2U+DZm+MyCU8Hd1O53L8D0CMknKluk0kWlsBBb9uo
        nUnwvssTJGE1vNuXP4q3wenuTlISFyLwtN9TSIV4aK8pk/kHy+koaGiNk9IR0PLzGJIGj4eP
        3/Yq/BSglVCYr5IoM6D3Zd/oClOhqqCI3I8YcYwbcYwFcYwF8f+wSkTUocnYLlgysMDatWN/
        uxEFjjU6sRld70nxIppCzDjljctzjCoFv0XIsXgRUHImVKn7NtuoUqbzOVuxw5bqcJmx4EVa
        32MfkKvD0my+07c6U1nt3Pj4eG4em6BlWWaKsuJXlFFFZ/BOnIWxHTv+6WRUsDoXeWYZTXUp
        e4rX5R2oLljx6m3+vuVfJoSMPFQtbkyq6+rrGelxN+XEESUX3hlOlB2uqsS964e3J244l3ep
        Ul1ye5Np8FD9SvN5w4b+lZ6IQUv5fXE3zo60tkS294vlGxsq7iWnTUNrdqzuT17alP10V+Hm
        gw0vXWuVRTZU9uLM+c2nrjGEkMmz0XKHwP8FcuVyLMIDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprJIsWRmVeSWpSXmKPExsWy7bCSnO7+g7qxBitbjS1Wf3zMaNEyaxGL
        xdmmN+wWl3fNYbP43HuE0aLzyyw2i9uNK9gsfu6ax2LRt/YSmwOnx467Sxg9ds66y+7R2/yO
        zaNvyypGj8+b5AJYo7hsUlJzMstSi/TtErgyfm/pZi64x1Nx8rNeA+Mmri5GTg4JAROJL6da
        2LoYuTiEBHYzSrQfuckKkZCUmHbxKHMXIweQLSxx+HAxRM1bRol1jY0sIDXCAq4Sp1/dYQFJ
        iAg0MUls6r3ADpJgFoiU6Jm7BWrqFkaJ+f9Xg01lE9CS2P/iBhuIzS+gKHH1x2NGEJtXwE7i
        5O7TYDaLgKpEQ/t9sHpRgQiJSdd2skDUCEqcnPmEBeQiTgEziVvTbSF2qUv8mXeJGcIWl7j1
        ZD4ThC0v0bx1NvMERuFZSLpnIWmZhaRlFpKWBYwsqxglUwuKc9Nziw0LDPNSy/WKE3OLS/PS
        9ZLzczcxgiNMS3MH4+Ul8YcYBTgYlXh4PxzQjRViTSwrrsw9xCjBwawkwmv7VTtWiDclsbIq
        tSg/vqg0J7X4EKM0B4uSOO/TvGORQgLpiSWp2ampBalFMFkmDk6pBsb4pgD3zW87HqbuXnB4
        24U/1uemsU0UcxK4uKJg54c9GeuKf3DYqly9knxPYq/N74Ki8BO9x9l6BA/fb/j9a3fH+rmX
        VaauubJux/I5CmvfinA7bzly8dXXhfXK/+WubdjpnHMg2t0kRk67U887w0JYWso89rKMVdqM
        u2cepV7kmsHP+9aDXa9DiaU4I9FQi7moOBEA0YUSK6wCAAA=
X-CMS-MailID: 20190716122327epcas1p40cbcdaec8eedf94a7e17bb1e71743038
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20190707223543epcas1p359a8a56ca04649c2b5f064c639246694
References: <20190707223303.6755-1-digetx@gmail.com>
        <CGME20190707223543epcas1p359a8a56ca04649c2b5f064c639246694@epcas1p3.samsung.com>
        <20190707223303.6755-14-digetx@gmail.com>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 19. 7. 8. 오전 7:32, Dmitry Osipenko wrote:
> Constify unmodifiable structs for consistency.
> 
> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
> ---
>  drivers/devfreq/tegra30-devfreq.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/devfreq/tegra30-devfreq.c b/drivers/devfreq/tegra30-devfreq.c
> index 1a10df5dbbed..2f59c78930bd 100644
> --- a/drivers/devfreq/tegra30-devfreq.c
> +++ b/drivers/devfreq/tegra30-devfreq.c
> @@ -106,7 +106,7 @@ enum tegra_actmon_device {
>  	MCCPU,
>  };
>  
> -static struct tegra_devfreq_device_config actmon_device_configs[] = {
> +static const struct tegra_devfreq_device_config actmon_device_configs[] = {
>  	{
>  		/* MCALL: All memory accesses (including from the CPUs) */
>  		.offset = 0x1c0,
> @@ -171,7 +171,7 @@ struct tegra_actmon_emc_ratio {
>  	unsigned long emc_freq;
>  };
>  
> -static struct tegra_actmon_emc_ratio actmon_emc_ratios[] = {
> +static const struct tegra_actmon_emc_ratio actmon_emc_ratios[] = {
>  	{ 1400000, ULONG_MAX },
>  	{ 1200000,    750000 },
>  	{ 1100000,    600000 },
> @@ -210,7 +210,7 @@ static inline unsigned long do_percent(unsigned long val, unsigned int pct)
>  
>  static unsigned long actmon_cpu_to_emc_rate(struct tegra_devfreq *tegra)
>  {
> -	struct tegra_actmon_emc_ratio *ratio = actmon_emc_ratios;
> +	const struct tegra_actmon_emc_ratio *ratio = actmon_emc_ratios;
>  	unsigned int cpu_freq = cpufreq_get(0);
>  	unsigned int i;
>  
> 

Reviewed-by: Chanwoo Choi <cw00.choi@samsung.com>

-- 
Best Regards,
Chanwoo Choi
Samsung Electronics
