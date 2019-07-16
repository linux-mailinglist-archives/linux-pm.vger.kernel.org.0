Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B7FA16A7A8
	for <lists+linux-pm@lfdr.de>; Tue, 16 Jul 2019 13:49:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731115AbfGPLsR (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 16 Jul 2019 07:48:17 -0400
Received: from mailout2.samsung.com ([203.254.224.25]:28470 "EHLO
        mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732234AbfGPLsR (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 16 Jul 2019 07:48:17 -0400
Received: from epcas1p4.samsung.com (unknown [182.195.41.48])
        by mailout2.samsung.com (KnoxPortal) with ESMTP id 20190716114815epoutp02b87e38575c9b3251b1d358e6be7c70b6~x4MgdIdTb2057820578epoutp02-
        for <linux-pm@vger.kernel.org>; Tue, 16 Jul 2019 11:48:15 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20190716114815epoutp02b87e38575c9b3251b1d358e6be7c70b6~x4MgdIdTb2057820578epoutp02-
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1563277695;
        bh=Dyv6w+uTWtVQSsv2ZPQrUY8BCpkig6DYkgOKhcfDw6s=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=LY0KetFm2iyDBY+PPn80tUUnjcA0AQNU3vFKlz0H8CdF37My2h+Q54F9bpO8x1jGM
         rwecmi5ntrFYwQmTVNDcgdfQz7/wQrNFBmabX5wOTwHOAK51SHED3/p4J67hzg28Hi
         ov+GtVhPq0iaWKykAvFh4PZcLRK8rKbSBUT+ORNE=
Received: from epsnrtp2.localdomain (unknown [182.195.42.163]) by
        epcas1p4.samsung.com (KnoxPortal) with ESMTP id
        20190716114815epcas1p481e6e589a9335446b2bd69e4f7bcb1a0~x4MgBmVGn1316613166epcas1p4q;
        Tue, 16 Jul 2019 11:48:15 +0000 (GMT)
Received: from epsmges1p3.samsung.com (unknown [182.195.40.156]) by
        epsnrtp2.localdomain (Postfix) with ESMTP id 45nzDY0zB6zMqYkY; Tue, 16 Jul
        2019 11:48:13 +0000 (GMT)
Received: from epcas1p4.samsung.com ( [182.195.41.48]) by
        epsmges1p3.samsung.com (Symantec Messaging Gateway) with SMTP id
        7F.4E.04066.C79BD2D5; Tue, 16 Jul 2019 20:48:13 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20190716114812epcas1p2b2b823e4c878060cfe751a094897fa0f~x4MdnSwMp1330913309epcas1p2L;
        Tue, 16 Jul 2019 11:48:12 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20190716114812epsmtrp18a2ecf280f01ebd8dd9bf7e0d629da33~x4Mdj_9c11911419114epsmtrp1r;
        Tue, 16 Jul 2019 11:48:12 +0000 (GMT)
X-AuditID: b6c32a37-e27ff70000000fe2-52-5d2db97ca1d5
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        A2.0D.03706.C79BD2D5; Tue, 16 Jul 2019 20:48:12 +0900 (KST)
Received: from [10.113.221.102] (unknown [10.113.221.102]) by
        epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20190716114812epsmtip1ab6e8f6885a4894f29421f436be0c765~x4MdYFEv81787417874epsmtip1g;
        Tue, 16 Jul 2019 11:48:12 +0000 (GMT)
Subject: Re: [PATCH v4 04/24] PM / devfreq: tegra30: Drop write-barrier
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
Message-ID: <1aaa2e01-dcb3-7499-61ef-0b5fe4b94e77@samsung.com>
Date:   Tue, 16 Jul 2019 20:51:19 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
        Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <20190707223303.6755-5-digetx@gmail.com>
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA02Se2xLURzHnfb29k7Ujs7jZwnmysLKrFdX7mQV8SwmW0K8YuZmu2lnfaW3
        EyNiVNDFY0yyKFrPGCJeQ9thUfNcbMz7MRZb4hEhw8Y2Ru/uxP77/L75/s75fc/5UXL1KTKW
        yrW5eKeNs9Bkb+Li9QRt4tpgYqb2aJ2MPdnciNiN3kMEe2/DJyX7MLSPZL9tq0Ks57uXZF+u
        LyPZtpCPYLefqiMnRxkD9UeQMeitVxq3uT+Txu3lJ5Dx27mhGYolealmnsvhnXG8Lduek2sz
        Geg587KmZunHa5lEJoWdQMfZOCtvoKelZSTOyLVEBqLjVnKW/IiUwQkCnTQp1WnPd/FxZrvg
        MtC8I8fiSHGMFTirkG8zjc22WycyWu04fcS4PM8cqmgkHKdjVl39oSlEb6OLUBQFOBl2NQWI
        ItSbUuMAgidl12RS8RXBwacVSqloRVDa+UTxr+VPwzulyGp8BUG7Z4XEXxBcaE0pQhQVg2dC
        aYdG7O2POxF42tyk6JHjxXA9eFImMok1UPn+WZcejYfD45+NSGQVngSH7h8kRCZwPJwPbO66
        dwBeBHerfITk6Qd39jR1cRTWQ/NzP5LOHwQvmvwyiYeB+8JeuTgE4D8k+F4/UEoBpkHH01ZS
        4hj4eKu8W4+FDzs2dfMaOH6nipSatyAor7zfnV4HlUdLZGJKOU6A06EkSR4OwY793UP0hc8t
        WxWiBbAKtmxSS5YR8LChXibxYDi82UMWI9rbI463RwRvjwje/5cdQMQJNJB3CFYTLzAOXc+/
        Poe6VlUzIYDO1KSFEaYQ3Ud1+/KYTLWCWykUWMMIKDndX2VoGZ2pVuVwBat5pz3LmW/hhTDS
        R157pzx2QLY9svg2VxajH6fT6dhkZryeYehBKt+vhEw1NnEuPo/nHbzzX5+MiootRAtTZdF7
        VKN26/L8r6YUezoXKGB2rX/prMKGN+3JBYKX14f33lpX0qduRK+pGxvnNuP45BLf4PQf+huT
        zQnm+uoQ1JbPTWtv25k0Pdx88dKyRYGrAw2GTw3Pz4ycv2+00n3DXxr/yPTbUeMeQp59lB1c
        U1FYfMyTWvvu5uWC9K3VLTQhmDlGI3cK3F90pMzFwAMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprJIsWRmVeSWpSXmKPExsWy7bCSnG7NTt1Yg6cHVSxWf3zMaNEyaxGL
        xdmmN+wWl3fNYbP43HuE0aLzyyw2i9uNK9gsfu6ax2LRt/YSmwOnx467Sxg9ds66y+7R2/yO
        zaNvyypGj8+b5AJYo7hsUlJzMstSi/TtErgydu1+zFKwXrhi33etBsZH/F2MnBwSAiYS/x88
        Z+9i5OIQEtjNKLHj/gZGiISkxLSLR5m7GDmAbGGJw4eLIWreMkrsOvucESQuLOAuMf23Fkhc
        RKCJSWJT7wV2kF5mgUiJnrlb2CAaNjNKXLm3iQkkwSagJbH/xQ02EJtfQFHi6o/HYMt4Bewk
        Fl1YyAJiswioSmze0c4KYosKREhMuraTBaJGUOLkzCdgNqeAqcTHm/MZIZapS/yZd4kZwhaX
        uPVkPhOELS/RvHU28wRG4VlI2mchaZmFpGUWkpYFjCyrGCVTC4pz03OLDQsM81LL9YoTc4tL
        89L1kvNzNzGCI0xLcwfj5SXxhxgFOBiVeHhP7NGJFWJNLCuuzD3EKMHBrCTCa/tVO1aINyWx
        siq1KD++qDQntfgQozQHi5I479O8Y5FCAumJJanZqakFqUUwWSYOTqkGxsDzE33WHZniq/K+
        ab+TVoJ4xGrWJkVh7/oqXsOqukMaTWe/+83PDCx7dGXObKHfLBWXv6aJCrmerZ9WWtXPvOV7
        jFbN+jvpp9NU1A1nm4Y4fo/1UYg9czQ7xtrV9/XKlV3SBp/YVKaVR3zvuNBle51v0WSZR+rb
        /1WvnzyVc2uOmt58814mJZbijERDLeai4kQAHCWz5KwCAAA=
X-CMS-MailID: 20190716114812epcas1p2b2b823e4c878060cfe751a094897fa0f
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20190707223727epcas4p450b911e20b59833cf68975099c7e4bfa
References: <20190707223303.6755-1-digetx@gmail.com>
        <CGME20190707223727epcas4p450b911e20b59833cf68975099c7e4bfa@epcas4p4.samsung.com>
        <20190707223303.6755-5-digetx@gmail.com>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Dmitry,

On 19. 7. 8. 오전 7:32, Dmitry Osipenko wrote:
> There is no need in a write-barrier now, given that interrupt masking is
> handled by CPU's GIC now. Hence we know exactly that interrupt won't fire
> after stopping the devfreq's governor. In other cases we don't care about
> potential buffering of the writes to hardware and thus there is no need to
> stall CPU.
> 
> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
> ---
>  drivers/devfreq/tegra30-devfreq.c | 14 --------------
>  1 file changed, 14 deletions(-)
> 
> diff --git a/drivers/devfreq/tegra30-devfreq.c b/drivers/devfreq/tegra30-devfreq.c
> index 5e606ae3f238..4be7858c33bc 100644
> --- a/drivers/devfreq/tegra30-devfreq.c
> +++ b/drivers/devfreq/tegra30-devfreq.c
> @@ -230,12 +230,6 @@ static void tegra_devfreq_update_wmark(struct tegra_devfreq *tegra,
>  		      ACTMON_DEV_LOWER_WMARK);
>  }
>  
> -static void actmon_write_barrier(struct tegra_devfreq *tegra)
> -{
> -	/* ensure the update has reached the ACTMON */
> -	readl(tegra->regs + ACTMON_GLB_STATUS);
> -}
> -
>  static void actmon_isr_device(struct tegra_devfreq *tegra,
>  			      struct tegra_devfreq_device *dev)
>  {
> @@ -287,8 +281,6 @@ static void actmon_isr_device(struct tegra_devfreq *tegra,
>  	device_writel(dev, dev_ctrl, ACTMON_DEV_CTRL);
>  
>  	device_writel(dev, ACTMON_INTR_STATUS_CLEAR, ACTMON_DEV_INTR_STATUS);
> -
> -	actmon_write_barrier(tegra);
>  }
>  
>  static unsigned long actmon_cpu_to_emc_rate(struct tegra_devfreq *tegra,
> @@ -376,8 +368,6 @@ static int tegra_actmon_rate_notify_cb(struct notifier_block *nb,
>  		tegra_devfreq_update_wmark(tegra, dev);
>  	}
>  
> -	actmon_write_barrier(tegra);
> -
>  	return NOTIFY_OK;
>  }
>  
> @@ -423,8 +413,6 @@ static void tegra_actmon_start(struct tegra_devfreq *tegra)
>  	for (i = 0; i < ARRAY_SIZE(tegra->devices); i++)
>  		tegra_actmon_configure_device(tegra, &tegra->devices[i]);
>  
> -	actmon_write_barrier(tegra);
> -
>  	enable_irq(tegra->irq);
>  }
>  
> @@ -439,8 +427,6 @@ static void tegra_actmon_stop(struct tegra_devfreq *tegra)
>  		device_writel(&tegra->devices[i], ACTMON_INTR_STATUS_CLEAR,
>  			      ACTMON_DEV_INTR_STATUS);
>  	}
> -
> -	actmon_write_barrier(tegra);
>  }
>  
>  static int tegra_devfreq_target(struct device *dev, unsigned long *freq,
> 

Reviewed-by: Chanwoo Choi <cw00.choi@samsung.com>

-- 
Best Regards,
Chanwoo Choi
Samsung Electronics
