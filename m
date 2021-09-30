Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4397441D20D
	for <lists+linux-pm@lfdr.de>; Thu, 30 Sep 2021 05:58:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229635AbhI3EAG (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 30 Sep 2021 00:00:06 -0400
Received: from mailout3.samsung.com ([203.254.224.33]:17127 "EHLO
        mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229500AbhI3EAF (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 30 Sep 2021 00:00:05 -0400
Received: from epcas1p4.samsung.com (unknown [182.195.41.48])
        by mailout3.samsung.com (KnoxPortal) with ESMTP id 20210930035820epoutp037c75313b47bd88b0c369e25e9da97b58~pfXlvpvrt0707707077epoutp030
        for <linux-pm@vger.kernel.org>; Thu, 30 Sep 2021 03:58:20 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20210930035820epoutp037c75313b47bd88b0c369e25e9da97b58~pfXlvpvrt0707707077epoutp030
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1632974300;
        bh=aUNsDQghva4RRo7dNSjRSqr0SbzqUKx7Dcs+8FFJkHE=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=SFa1HU7GpaHXbUZ/5RWnQfi7tCX0melPLb1PZWdhFpddbaw9hjgHwrVwWi4zF7rMj
         Mdel1LORl6HeBgQ0o6bQr0JXDjjjRBO3Jglo5IxUPBLnegS16C6s5nrzGQIoF7bxTW
         MLFEXrmXEOyL2+CnQ7rNtlIp2FxMRIeKv8fGX7RQ=
Received: from epsnrtp1.localdomain (unknown [182.195.42.162]) by
        epcas1p1.samsung.com (KnoxPortal) with ESMTP id
        20210930035819epcas1p194a6a4847de2f603997b00acf745e3b4~pfXlPyM0G2083320833epcas1p1j;
        Thu, 30 Sep 2021 03:58:19 +0000 (GMT)
Received: from epsmges1p1.samsung.com (unknown [182.195.38.232]) by
        epsnrtp1.localdomain (Postfix) with ESMTP id 4HKfbq3GQCz4x9Q5; Thu, 30 Sep
        2021 03:58:15 +0000 (GMT)
Received: from epcas1p2.samsung.com ( [182.195.41.46]) by
        epsmges1p1.samsung.com (Symantec Messaging Gateway) with SMTP id
        8B.AE.24398.6D535516; Thu, 30 Sep 2021 12:58:14 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas1p4.samsung.com (KnoxPortal) with ESMTPA id
        20210930035813epcas1p4dc07dff837bedb4c26be6e785d8ad49a~pfXffYjNt2028120281epcas1p4i;
        Thu, 30 Sep 2021 03:58:13 +0000 (GMT)
Received: from epsmgms1p2.samsung.com (unknown [182.195.42.42]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20210930035813epsmtrp141d835a97430af7b7c133dd62c4dc28e~pfXfek_7j0720107201epsmtrp17;
        Thu, 30 Sep 2021 03:58:13 +0000 (GMT)
X-AuditID: b6c32a35-0d7ff70000005f4e-22-615535d63b24
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        57.22.08750.5D535516; Thu, 30 Sep 2021 12:58:13 +0900 (KST)
Received: from [10.113.221.102] (unknown [10.113.221.102]) by
        epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20210930035813epsmtip1289f5c0fe6d31f770dfc7068bc0650c4~pfXfHbdDJ3114831148epsmtip1T;
        Thu, 30 Sep 2021 03:58:13 +0000 (GMT)
Subject: Re: [PATCH 02/10] PM / devfreq: Do not require devices to have OPPs
To:     Samuel Holland <samuel@sholland.org>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Maxime Ripard <mripard@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Rob Herring <robh+dt@kernel.org>
Cc:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org,
        linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org
From:   Chanwoo Choi <cw00.choi@samsung.com>
Organization: Samsung Electronics
Message-ID: <114afa7e-6218-6b1f-f87e-84690f10029c@samsung.com>
Date:   Thu, 30 Sep 2021 13:19:29 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:59.0) Gecko/20100101
        Thunderbird/59.0
MIME-Version: 1.0
In-Reply-To: <20210929044254.38301-3-samuel@sholland.org>
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA01TfUxbVRzN7Wtfy7Juby3YK1FkzzgzkpZ2o/C6wEICYzXAhjSauejwSZ/Q
        9dO+dmHqlCHUlQmsEaN0I4hVWyg6KV+liaKlKlXHHNsQhrjxoWwV3CJbhKmLbR8q/53fuef3
        O/fcDx4iGEWTeRqDhTIbSB2ObmD3D2+XiMflT5DSs30ioi00yiEW2j4GxLmaRS7hmxvnEBcD
        Z1BiuSEEiObPAihhs3/IIS58s4eYOu5BibpPQ1xiYdaOEvfGu9nEavA8K3eT8uZEHVf5yayX
        oxx0TnOVvk47qux5/1Xl9Z4WoGzs7QTKyJ1WoFz2pZQkHNRmV1KkmjKnUoZyo1pjqMjBC1Vl
        eWXyTKlMLFMQWXiqgdRTOXh+UYm4QKOL7h1PPULqrFGqhKRpPH13ttlotVCplUbakoNTJrXO
        JDdJaFJPWw0VEgNl2SWTSnfIo8JntZV3r0whpi8erLo2GOFWg7dgPUjgQSwDuld/YNeDDTwB
        5gew4ZcmlCl+BzDsbuUwxTKAb/cNI/WAF28JTxxm+ECU/87LYoqbADb3j4PYXCFWBCcjnvio
        RMzBgqevfh43QbAlANsDfiSmQrE0OHR9Ao3hzdhWeHllLt7Nx3bDuqGBOGZjj8CGni/ZMZyE
        PQnD/bVrmi0w3DIf5xMwBWy5PMmKYQQTwSvzbWv4ITiwdAaJGUNskQf9g3+zmAz5cG5UyJyA
        EEa+7uUyOBneaLKt4ZdgRziEMr0nAOwd+p7DLOyEQx+8GZ+DYNvh2UA6Q2+Fg3+2AsZ3E/zt
        zhscxooPT9gEjORhePHaNIvB90PX63b0FMCd69I41yVwrkvg/N/sXcDuBPdRJlpfQdEyk+y/
        6y436n0g/rDT5H7gWLolCQIWDwQB5CF4In9FpCIFfDV59EXKbCwzW3UUHQTy6Pk6kOSkcmP0
        ZxgsZbIMhTQjc8fODEKWKcNF/K9+VZACrIK0UFqKMlHmf/tYvITkalat8WpXKdJX+lz+QF63
        R/dM6OlVY+6My2wKGnVCf9e098BrYk/jt6X2G38VG4TubNErW36KqPbNjO55obFKX+Wy1ex9
        QFZ/dOQCEn6q9fF9Wdqmuy7VHz+OWPskt1yOsRrOtK1Q6+8Yy+kqwIo7BI9u3Og84Paq0jV+
        dT+rKrFnf1Z1SvGwo8QXyU9i5xwv/1nhsxrNpCUdywsteMSDdpXES79s3nwyYzZ38rb13rbn
        U96BkmPJ89rHGi7t8o3fdh0L6E8WrYiP5IGRWfzQRJfBO+YrOB2Y7J7an+Do++iSYpu4vffc
        e2kRe6E7NXi+Dtu7WDujaS5IOtR+UHcYZ9OVpCwNMdPkPzoqB8hhBAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrBIsWRmVeSWpSXmKPExsWy7bCSnO5V09BEgzVTlCzmHznHavF8/jpG
        i7NNb9gtNj2+xmpxedccNovPvUcYLabs28Vm0da5jNXi4ilXi9uNK9gsWvceYbd4/qiTzeLf
        tY0sFj8PnWdy4PN4f6OV3WPDo9WsHjtn3WX32LSqk81j85J6jxebZzJ69G1Zxejx6utcRo/P
        m+QCOKO4bFJSczLLUov07RK4Mn7dus1ccFC24sHOV+wNjFMluhg5OCQETCRO3sjqYuTiEBLY
        wSjR8vgNexcjJ1BcUmLaxaPMEDXCEocPF4OEhQTeMkrsO+YMYgsL+EjcfLWCDaRXRGAyk8TJ
        rceZQBxmkKJXF64zQkzdzSixte85C0gLm4CWxP4XN9hAbH4BRYmrPx4zgti8AnYSrfu3g9ks
        AqoSvZuPgtWLCoRJ7FzymAmiRlDi5MwnYHFOAUuJmVdvgsWZBdQl/sy7xAxhi0vcejIfKi4v
        sf3tHOYJjMKzkLTPQtIyC0nLLCQtCxhZVjFKphYU56bnFhsWGOWllusVJ+YWl+al6yXn525i
        BEeultYOxj2rPugdYmTiYDzEKMHBrCTC+0M8OFGINyWxsiq1KD++qDQntfgQozQHi5I474Wu
        k/FCAumJJanZqakFqUUwWSYOTqkGJhaXEnfGpcHHJGTYpq7tVI46k7x9z77oUEZuv7NmX549
        TXoY5PPtp0XXqY4857XvPCe+fjFDRGZZ9LelydtaXCcad4atdpv0kkMsi3XfrL2/tr4z/Oh+
        Ryrm0CUHHsE5M2qTD3m5iT+t+TCnMMxhWrrCDTvO6sf+xppmuWo/eJNPTl0myuXk96/SOLIm
        bnvY56aQ9WJTD654dEPWXP7Bba0zh/+frBfvmXdy7jdVb62DM3gLLi7u87q7Zt8Dh1PzkozV
        fp4p1r906ylL9gvPLe9j+DwOfWicYf2uUOzypb4VGXzX3i1eve3vw/lirwxOr7O+9CVob0VQ
        faVvdfH559/kvikVnXjxpGXz3hvRvW+VWIozEg21mIuKEwHnyNfnSwMAAA==
X-CMS-MailID: 20210930035813epcas1p4dc07dff837bedb4c26be6e785d8ad49a
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20210929044301epcas1p4d69083b46ca38d610981db6f01cfe9e4
References: <20210929044254.38301-1-samuel@sholland.org>
        <CGME20210929044301epcas1p4d69083b46ca38d610981db6f01cfe9e4@epcas1p4.samsung.com>
        <20210929044254.38301-3-samuel@sholland.org>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Samuel,


On 9/29/21 1:42 PM, Samuel Holland wrote:
> Since commit ea572f816032 ("PM / devfreq: Change return type of
> devfreq_set_freq_table()"), all devfreq devices are required to have a
> valid freq_table. If freq_table is not provided by the driver, it will
> be filled in by set_freq_table() from the OPPs; if that fails,
> devfreq_add_device() will return an error.
> 
> However, since commit ab8f58ad72c4 ("PM / devfreq: Set min/max_freq when
> adding the devfreq device"), devfreq devices are _also_ required to have
> an OPP table, even if they provide freq_table. devfreq_add_device()
> requires dev_pm_opp_find_freq_ceil() and dev_pm_opp_find_freq_floor() to
> return successfully, specifically to initialize scaling_min/max_freq.
> 
> Not all drivers need an OPP table. For example, a driver where all
> frequencies are determined dynamically could work by filling out only
> freq_table. But with the current code it must call dev_pm_opp_add() on
> every freq_table entry to probe successfully.

As you commented, if device has no opp table, it should call dev_pm_opp_add().
The devfreq have to use OPP for controlling the frequency/regulator.

Actually, I want that all devfreq driver uses the OPP as default way.
Are there any reason why don't use the OPP table?

> 
> The offending properties, scaling_min/max_freq, are only necessary if a
> device has OPPs; if no OPPs exist at all, OPPs cannot be dynamically
> enabled or disabled, so those values have no effect. Thus it is trivial
> to restore support for devices with freq_table only and not OPPs -- move
> those initializations behind the check for a valid OPP table.
> 
> Since get_freq_range() uses scaling_max_freq in a min() expression, it
> must be initialized to the maximum possible value. scaling_min_freq is
> initialized as well for consistency.
> 
> Fixes: ab8f58ad72c4 ("PM / devfreq: Set min/max_freq when adding the devfreq device")
> Signed-off-by: Samuel Holland <samuel@sholland.org>
> ---
>  drivers/devfreq/devfreq.c | 36 ++++++++++++++++++++----------------
>  1 file changed, 20 insertions(+), 16 deletions(-)
> 
> diff --git a/drivers/devfreq/devfreq.c b/drivers/devfreq/devfreq.c
> index 7a8b022ba456..426e31e6c448 100644
> --- a/drivers/devfreq/devfreq.c
> +++ b/drivers/devfreq/devfreq.c
> @@ -835,24 +835,28 @@ struct devfreq *devfreq_add_device(struct device *dev,
>  		mutex_lock(&devfreq->lock);
>  	}
>  
> -	devfreq->scaling_min_freq = find_available_min_freq(devfreq);
> -	if (!devfreq->scaling_min_freq) {
> -		mutex_unlock(&devfreq->lock);
> -		err = -EINVAL;
> -		goto err_dev;
> -	}
> -
> -	devfreq->scaling_max_freq = find_available_max_freq(devfreq);
> -	if (!devfreq->scaling_max_freq) {
> -		mutex_unlock(&devfreq->lock);
> -		err = -EINVAL;
> -		goto err_dev;
> -	}
> -
> -	devfreq->suspend_freq = dev_pm_opp_get_suspend_opp_freq(dev);
>  	devfreq->opp_table = dev_pm_opp_get_opp_table(dev);
> -	if (IS_ERR(devfreq->opp_table))
> +	if (IS_ERR(devfreq->opp_table)) {
>  		devfreq->opp_table = NULL;
> +		devfreq->scaling_min_freq = 0;
> +		devfreq->scaling_max_freq = ULONG_MAX;
> +	} else {
> +		devfreq->scaling_min_freq = find_available_min_freq(devfreq);
> +		if (!devfreq->scaling_min_freq) {
> +			mutex_unlock(&devfreq->lock);
> +			err = -EINVAL;
> +			goto err_dev;
> +		}
> +
> +		devfreq->scaling_max_freq = find_available_max_freq(devfreq);
> +		if (!devfreq->scaling_max_freq) {
> +			mutex_unlock(&devfreq->lock);
> +			err = -EINVAL;
> +			goto err_dev;
> +		}
> +
> +		devfreq->suspend_freq = dev_pm_opp_get_suspend_opp_freq(dev);
> +	}
>  
>  	atomic_set(&devfreq->suspend_count, 0);
>  
> 


-- 
Best Regards,
Chanwoo Choi
Samsung Electronics
