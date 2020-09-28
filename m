Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AF23727A5A6
	for <lists+linux-pm@lfdr.de>; Mon, 28 Sep 2020 05:08:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726442AbgI1DIA (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 27 Sep 2020 23:08:00 -0400
Received: from mailout3.samsung.com ([203.254.224.33]:37930 "EHLO
        mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726409AbgI1DIA (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 27 Sep 2020 23:08:00 -0400
Received: from epcas1p2.samsung.com (unknown [182.195.41.46])
        by mailout3.samsung.com (KnoxPortal) with ESMTP id 20200928030757epoutp03bced80a958e8eeaa914938e1d4ccff7c~40705drvd1306713067epoutp03X
        for <linux-pm@vger.kernel.org>; Mon, 28 Sep 2020 03:07:57 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20200928030757epoutp03bced80a958e8eeaa914938e1d4ccff7c~40705drvd1306713067epoutp03X
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1601262477;
        bh=KWXE2fmpyB7eUfVgULX+azIPkRur1+l/RpTT+O8eZgA=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=qpdcyNuyMtrLNfc+GnaDCfWrD+3Y1wKxDurfVhUGDHFL83FoOvqj/nDP0T7qLJGLH
         JbNZ4PglyF2EuAK8qLQ5524qpJWHCdItERiFNQoxKrK2m/ddWidtmsA+KjNAWMGLiC
         GSwE974BLWeMEkugazsCMYrHXiXUjvvTIhLwtr68=
Received: from epsnrtp2.localdomain (unknown [182.195.42.163]) by
        epcas1p3.samsung.com (KnoxPortal) with ESMTP id
        20200928030756epcas1p3c8919f8bf3af455ba73cf5d67d6c8cf3~4070XsF9P2788527885epcas1p3Q;
        Mon, 28 Sep 2020 03:07:56 +0000 (GMT)
Received: from epsmges1p5.samsung.com (unknown [182.195.40.155]) by
        epsnrtp2.localdomain (Postfix) with ESMTP id 4C06s55CfxzMqYkn; Mon, 28 Sep
        2020 03:07:53 +0000 (GMT)
Received: from epcas1p2.samsung.com ( [182.195.41.46]) by
        epsmges1p5.samsung.com (Symantec Messaging Gateway) with SMTP id
        F9.05.09577.983517F5; Mon, 28 Sep 2020 12:07:53 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20200928030753epcas1p24a8a977126254c3e92a2c311ab76b5a9~407xKMJoW1106811068epcas1p2J;
        Mon, 28 Sep 2020 03:07:53 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20200928030753epsmtrp16e80df336ed3e1753bd196e86a8b1a88~407xJkSoC1510615106epsmtrp1F;
        Mon, 28 Sep 2020 03:07:53 +0000 (GMT)
X-AuditID: b6c32a39-bfdff70000002569-98-5f7153890bac
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        23.9D.08604.983517F5; Mon, 28 Sep 2020 12:07:53 +0900 (KST)
Received: from [10.113.221.102] (unknown [10.113.221.102]) by
        epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20200928030752epsmtip2951b7bc8c33be1d44441639f5a95fcb9~407w9b07K0205102051epsmtip26;
        Mon, 28 Sep 2020 03:07:52 +0000 (GMT)
Subject: Re: [PATCH v1] PM / devfreq: tegra30: Improve initial hardware
 resetting
To:     Dmitry Osipenko <digetx@gmail.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Jonathan Hunter <jonathanh@nvidia.com>
Cc:     linux-pm@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
From:   Chanwoo Choi <cw00.choi@samsung.com>
Organization: Samsung Electronics
Message-ID: <9cf563cc-fa74-4a98-c4e2-022dab675a9d@samsung.com>
Date:   Mon, 28 Sep 2020 12:20:59 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:59.0) Gecko/20100101
        Thunderbird/59.0
MIME-Version: 1.0
In-Reply-To: <20200927205139.19548-1-digetx@gmail.com>
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprBJsWRmVeSWpSXmKPExsWy7bCmnm5ncGG8wd+JGharPz5mtGiZtYjF
        4mzTG3aLy7vmsFl87j3CaNH5ZRabxe3GFWwWP3fNY3Hg8Ng56y67R2/zOzaPvi2rGD0+b5IL
        YInKtslITUxJLVJIzUvOT8nMS7dV8g6Od443NTMw1DW0tDBXUshLzE21VXLxCdB1y8wBOkNJ
        oSwxpxQoFJBYXKykb2dTlF9akqqQkV9cYquUWpCSU2BZoFecmFtcmpeul5yfa2VoYGBkClSY
        kJ2x/+UKpoJ7PBWXt5xgbmBcw9XFyMkhIWAi8exAN3sXIxeHkMAORonT/+6zQDifGCXWb/0C
        lfnGKNG3pZO1i5EDrOXJsUCQbiGBvYwS384HQtS8Z5Q4M7GJGSQhLBAssWBNMxNIQkTgMqPE
        0kWvmUASzAKREod3rgaz2QS0JPa/uMEGYvMLKEpc/fGYEcTmFbCT6JlyEmwQi4CqxL7FM8Hi
        ogJhEie3tUDVCEqcnPmEBcTmFDCT2NE7G2q+uMStJ/OhbHmJ7W/nMIMcISEwk0NiTu9cdoin
        XSQa11+GsoUlXh3fAmVLSbzsb4OyqyVWnjzCBtHcwSixZf8FVoiEscT+pZOZQEHBLKApsX6X
        PkRYUWLn77mMEIv5JN597YGGFq9ER5sQRImyxOUHd5kgbEmJxe2dbBMYlWYheWcWkhdmIXlh
        FsKyBYwsqxjFUguKc9NTiw0LTJFjexMjOIlqWe5gnP72g94hRiYOxkOMEhzMSiK8vjkF8UK8
        KYmVValF+fFFpTmpxYcYTYEBPJFZSjQ5H5jG80riDU2NjI2NLUwMzUwNDZXEeR/eUogXEkhP
        LEnNTk0tSC2C6WPi4JRqYGLw3aPw1Nci8bc591Nnix61jkVTja8LxXh+MrlsLlCrILGw02V6
        l+GOnK0PbH64ZhQU8Lc96v/9ouf0ywoVfb2bPI8XdbZahzatNDvqsnWN492VvX3745/f8Gk1
        9yzhNZJkiG/7yWSY0SnZVxMglHXYPva1+5npfD8Zc06lpfpN/hagvtzj3u1lsnlfv9vLX372
        WV+RyfygoEDMFX79dM0JL9zYvW1P5PFyujgced93qicgNHTfy8ayqvr77p8Ev3G+fJcjf9BV
        6q9lJTPH3/f6Kjuu3eTnPDTFhkUjny1k7QMrr/ltb+sCHtzX2Fe1eWd3RkdAhlrg/GXhzicf
        eidt8bt3f9FP202mHD5KLMUZiYZazEXFiQDXl3icKwQAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmpmkeLIzCtJLcpLzFFi42LZdlhJXrczuDDeoKuR1WL1x8eMFi2zFrFY
        nG16w25xedccNovPvUcYLTq/zGKzuN24gs3i5655LA4cHjtn3WX36G1+x+bRt2UVo8fnTXIB
        LFFcNimpOZllqUX6dglcGftfrmAquMdTcXnLCeYGxjVcXYwcHBICJhJPjgV2MXJxCAnsZpSY
        /qOZqYuREyguKTHt4lFmiBphicOHiyFq3jJKvGm7ygxSIywQLLFgDUg9F4eIwFVGiYWHLzKC
        JJgFIiV65m5hg+joBEo8/A3WwSagJbH/xQ02EJtfQFHi6o/HYA28AnYSPVNOgtWwCKhK7Fs8
        EywuKhAmsXPJYyaIGkGJkzOfsIDYnAJmEjt6ZzNBLFOX+DPvEjOELS5x68l8qLi8xPa3c5gn
        MArPQtI+C0nLLCQts5C0LGBkWcUomVpQnJueW2xYYJiXWq5XnJhbXJqXrpecn7uJERxPWpo7
        GLev+qB3iJGJg/EQowQHs5IIr29OQbwQb0piZVVqUX58UWlOavEhRmkOFiVx3huFC+OEBNIT
        S1KzU1MLUotgskwcnFINTCLh93aqXVA03rnQ6PjKc/xrNG9UpqSy1XPp5TSvOSFZMcO3vDFS
        z4L/VozgyXVnVgctdYqsXC5/2e64ynMZzZzKxUcm1s/5m/b444p77Qs/fRcQ3nJ+lS9f065D
        /SYKazUXnNuc79Nx5+zH+T06CcvWXLA7cX5NTldt1uwncufLrHcfE7Zd6Pz2i1LSzMplQTzq
        YhFzZJ/caXVlWe2yKelp5+ETD+oeFvu36E67mijfHmactObwqyd3D0Wu2zmbMWpu5owb2hNm
        rl3LtHeC9V8NJ+3Di+tOOStvS1T9eezt1D0rrazUf7+R4RaSSHQ3S/vMq28vFBYn7fMv/pbR
        ykWvfDK2LlV5e0R+btfEy6JKLMUZiYZazEXFiQBoCXTHFgMAAA==
X-CMS-MailID: 20200928030753epcas1p24a8a977126254c3e92a2c311ab76b5a9
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20200927205217epcas1p1f4fffea5e9df2ca3b6e3ac13d46156e3
References: <CGME20200927205217epcas1p1f4fffea5e9df2ca3b6e3ac13d46156e3@epcas1p1.samsung.com>
        <20200927205139.19548-1-digetx@gmail.com>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 9/28/20 5:51 AM, Dmitry Osipenko wrote:
> It's safe to enable the ACTMON clock at any time during driver probing,
> even if we don't know the state of hardware, because it's used only for
> collecting and processing stats, and interrupt is kept disabled. This
> allows us to slightly improve code which performs initial hardware
> resetting by making use of a single reset_control_reset() instead of
> assert/deassert pair. Secondly, a potential error of the reset-control
> API is handled nicely now.
> 
> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
> ---
>  drivers/devfreq/tegra30-devfreq.c | 8 +++++---
>  1 file changed, 5 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/devfreq/tegra30-devfreq.c b/drivers/devfreq/tegra30-devfreq.c
> index dedd39de7367..f5e74c2ede85 100644
> --- a/drivers/devfreq/tegra30-devfreq.c
> +++ b/drivers/devfreq/tegra30-devfreq.c
> @@ -822,8 +822,6 @@ static int tegra_devfreq_probe(struct platform_device *pdev)
>  		return err;
>  	}
>  
> -	reset_control_assert(tegra->reset);
> -
>  	err = clk_prepare_enable(tegra->clock);
>  	if (err) {
>  		dev_err(&pdev->dev,
> @@ -831,7 +829,11 @@ static int tegra_devfreq_probe(struct platform_device *pdev)
>  		return err;
>  	}
>  
> -	reset_control_deassert(tegra->reset);
> +	err = reset_control_reset(tegra->reset);
> +	if (err) {
> +		dev_err(&pdev->dev, "Failed to reset hardware: %d\n", err);
> +		goto disable_clk;
> +	}
>  
>  	rate = clk_round_rate(tegra->emc_clock, ULONG_MAX);
>  	if (rate < 0) {
> 

Applied it. Thanks.

-- 
Best Regards,
Chanwoo Choi
Samsung Electronics
