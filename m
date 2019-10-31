Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3451BEA9EF
	for <lists+linux-pm@lfdr.de>; Thu, 31 Oct 2019 05:39:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726312AbfJaEj0 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 31 Oct 2019 00:39:26 -0400
Received: from mailout4.samsung.com ([203.254.224.34]:63811 "EHLO
        mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725816AbfJaEjY (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 31 Oct 2019 00:39:24 -0400
Received: from epcas1p4.samsung.com (unknown [182.195.41.48])
        by mailout4.samsung.com (KnoxPortal) with ESMTP id 20191031043920epoutp04fc29a43df80688faeb6f2bd3464bb1f0~SoXjmF7ym0550705507epoutp04X
        for <linux-pm@vger.kernel.org>; Thu, 31 Oct 2019 04:39:20 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20191031043920epoutp04fc29a43df80688faeb6f2bd3464bb1f0~SoXjmF7ym0550705507epoutp04X
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1572496760;
        bh=7D/E2evKGNTOcwIHpd5yyFb70AgXZ30JTIlKfDQrge8=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=aSuVD/U6h57H05IughONWjI9XknSleNU3LT7d+qIbNzdEmedBrY6BfIAT5SOBxJki
         YvU0td666CiblK6GZfwOB2J0xpegeBmlysfr1RTF5rVThNcDQK9t2oH6l3B8PeTdGK
         jXJuMoeV+9ZQ1fHK1UEuAPqeRbh840ae76WMPf0c=
Received: from epsnrtp5.localdomain (unknown [182.195.42.166]) by
        epcas1p4.samsung.com (KnoxPortal) with ESMTP id
        20191031043920epcas1p460f22d8962c47eea8b1ecfc9b1d40697~SoXjKeG2C2856328563epcas1p4f;
        Thu, 31 Oct 2019 04:39:20 +0000 (GMT)
Received: from epsmges1p1.samsung.com (unknown [182.195.40.152]) by
        epsnrtp5.localdomain (Postfix) with ESMTP id 473XfF4pYSzMqYkc; Thu, 31 Oct
        2019 04:39:17 +0000 (GMT)
Received: from epcas1p3.samsung.com ( [182.195.41.47]) by
        epsmges1p1.samsung.com (Symantec Messaging Gateway) with SMTP id
        57.D3.04144.5756ABD5; Thu, 31 Oct 2019 13:39:17 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas1p3.samsung.com (KnoxPortal) with ESMTPA id
        20191031043917epcas1p3775b7eae1e78c3c71ffa3b466d15d3af~SoXghQswe2202222022epcas1p3q;
        Thu, 31 Oct 2019 04:39:17 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20191031043917epsmtrp1f837205a237fc04b5e66a3bc8aa2bf84~SoXggehZU2301423014epsmtrp1W;
        Thu, 31 Oct 2019 04:39:17 +0000 (GMT)
X-AuditID: b6c32a35-2dfff70000001030-6f-5dba657540d9
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        96.B4.24756.5756ABD5; Thu, 31 Oct 2019 13:39:17 +0900 (KST)
Received: from [10.113.221.102] (unknown [10.113.221.102]) by
        epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20191031043916epsmtip14c38954253779d0b380cb603882bfeb7~SoXgJ9CQ_1042710427epsmtip1B;
        Thu, 31 Oct 2019 04:39:16 +0000 (GMT)
Subject: Re: [PATCH v7 06/19] PM / devfreq: tegra30: Use kHz units uniformly
 in the code
To:     Dmitry Osipenko <digetx@gmail.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Tomeu Vizoso <tomeu.vizoso@collabora.com>,
        Peter Geis <pgwipeout@gmail.com>
Cc:     linux-pm@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
From:   Chanwoo Choi <cw00.choi@samsung.com>
Organization: Samsung Electronics
Message-ID: <a8ce6d98-26aa-b6eb-56ea-4bf960fc533d@samsung.com>
Date:   Thu, 31 Oct 2019 13:44:48 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
        Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20191029220019.26773-7-digetx@gmail.com>
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA01Sa0gUURjl7szOjNLatGp9SQ+b3pa5k61NodG7BSOW6kcJYsPusCvui51d
        SeuHbWGbpRkF1WhWWmpWZGLlbtaSFhFSWVZEIRRKtRXay9Aia8cp8t/5vu+ce75z76Uw7WUi
        gcp1eAS3g7cxRDR+tX1uSrJXCGbrfEdnc+c/9yBuj1SNc/d9H0muK1hJcF9LbyNu3zeJ4F7u
        qie4+28yuaFgFc6VXXxMLI82tHSfQYaA1E0aSnf3EYay5gZk+No0xajOyku3CrxZcCcKDpPT
        nOuwZDCZm3JW5ejTdGwyu4RbzCQ6eLuQwaxeb0xem2uLLMUk5vM2b6Rl5EWRSVmW7nZ6PUKi
        1Sl6MhjBZba5lrgWiLxd9DosC0xO+1JWp1uojxC35VnPNUi460Ls9kdt/WQR6hhbgqIooBfB
        cMkddQmKprR0C4IK3y1SKb4gqL1UhCvFdwRDvp5IQY1IHkt2Wa2lbyC4WzVf4fQj6Hz7ViUP
        YuksqGz9PCKOo6tVcPHONUweYPRWaA+cHyERdBKE3j0nZDyWngZPB3uQjDX0Mmgta1DLGKdn
        Qu9AKyYbx9NboGOAVyjj4N7xXlzGUXQaVIWvk8rxE+BF70mVgqfC7isVmLwD0HtJ+HaiF1MC
        rIbTPpUSPxbe320mFZwA4YPFf/EOOHfvNqFo/QiaQ51qZZAKobOHVfI5GD0XLgVTlPY0CPw8
        gRTfGOgbOKBWrDTgL9YqlOnQ9ar7r+1EqNm7jyhHjDQqjTQqgTQqgfTf7BTCG9B4wSXaLYLI
        utjRb92ERr5rkr4FHXmwvg3RFGLGaMrzA9laNZ8vFtjbEFAYE6f5nh5pacx8QaHgdua4vTZB
        bEP6yF0fwhLiTc7I53d4clj9wtTUVG4Rm6ZnWWaCZkXd2WwtbeE9Qp4guAT3P52KikooQpvr
        TdX1j3Z+iK/45Mha9+vY1JvDSeFG9+Qnepd/0pqwRXfV2K/Zn2t9UfujkDzQFIotWBsVNzDc
        7o8vzdxQadYGM01D8z5gVMyMYHFj1+CsUEx4MDRLXTFnfuNNf+HWldbl5LqA8cqa4o19NUfq
        Dj3Y8Pvh9ZSa189KO175O8v1RQwuWnk2CXOL/B/bEjroxAMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprLIsWRmVeSWpSXmKPExsWy7bCSnG5p6q5Yg72zWSxWf3zMaNEyaxGL
        xdmmN+wWl3fNYbP43HuE0aLzyyw2i9uNK9gszj7ztvi5ax6LRd/aS2wOXB477i5h9Ng56y67
        R2/zOzaPvi2rGD0+b5ILYI3isklJzcksSy3St0vgyli5ahZLwRrhiouH3rM3MJ7m72Lk4JAQ
        MJG4NCu3i5GLQ0hgN6PE1WO3WboYOYHikhLTLh5lhqgRljh8uBgkLCTwllHiwhFBEFtYIEpi
        zp6PLCC9IgJLmCTOflnODJJgFoiU6Jm7hQ1i6FZGicNXl7CDJNgEtCT2v7jBBmLzCyhKXP3x
        mBHE5hWwk9jTt4oVxGYRUJV48nUP2CBRgQiJ59tvQNUISpyc+QTsOE4BM4l5L3ezQyxTl/gz
        7xLUYnGJW0/mM0HY8hLNW2czT2AUnoWkfRaSlllIWmYhaVnAyLKKUTK1oDg3PbfYsMAwL7Vc
        rzgxt7g0L10vOT93EyM40rQ0dzBeXhJ/iFGAg1GJh3dC2c5YIdbEsuLK3EOMEhzMSiK832yA
        QrwpiZVVqUX58UWlOanFhxilOViUxHmf5h2LFBJITyxJzU5NLUgtgskycXBKNTAa2K6xZXsa
        p1YySeldhwBry/xWe0lDgbdKXOy3lv6622nmlL37w6l/otbT17wMiYh8cq7uJp+fWdWzkw4L
        5FW3GHodZTshu/BHjQyH/p/a8Otql09xvZTVjDDomVMgKzRtFsMHKyF1CWYeUQnDK09+L9aP
        jqnQkHj6feJqpg8T2wwvpOru/a/EUpyRaKjFXFScCABE8DEZsAIAAA==
X-CMS-MailID: 20191031043917epcas1p3775b7eae1e78c3c71ffa3b466d15d3af
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20191029220734epcas1p42b635ee1c85a9480cecbaf7a1a41db25
References: <20191029220019.26773-1-digetx@gmail.com>
        <CGME20191029220734epcas1p42b635ee1c85a9480cecbaf7a1a41db25@epcas1p4.samsung.com>
        <20191029220019.26773-7-digetx@gmail.com>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 19. 10. 30. 오전 7:00, Dmitry Osipenko wrote:
> Part of the code uses Hz units and the other kHz, let's switch to kHz
> everywhere for consistency. A small benefit from this change (besides
> code's cleanup) is that now powertop utility correctly displays devfreq's
> stats, for some reason it expects them to be in kHz.
> 
> Tested-by: Peter Geis <pgwipeout@gmail.com>
> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
> ---
>  drivers/devfreq/tegra30-devfreq.c | 11 ++++++-----
>  1 file changed, 6 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/devfreq/tegra30-devfreq.c b/drivers/devfreq/tegra30-devfreq.c
> index 1d22f5239cd5..06c5376a7201 100644
> --- a/drivers/devfreq/tegra30-devfreq.c
> +++ b/drivers/devfreq/tegra30-devfreq.c
> @@ -448,7 +448,7 @@ static int tegra_devfreq_target(struct device *dev, unsigned long *freq,
>  	rate = dev_pm_opp_get_freq(opp);
>  	dev_pm_opp_put(opp);
>  
> -	err = clk_set_min_rate(tegra->emc_clock, rate);
> +	err = clk_set_min_rate(tegra->emc_clock, rate * KHZ);
>  	if (err)
>  		return err;
>  
> @@ -477,7 +477,7 @@ static int tegra_devfreq_get_dev_status(struct device *dev,
>  	stat->private_data = tegra;
>  
>  	/* The below are to be used by the other governors */
> -	stat->current_frequency = cur_freq * KHZ;
> +	stat->current_frequency = cur_freq;
>  
>  	actmon_dev = &tegra->devices[MCALL];
>  
> @@ -527,7 +527,7 @@ static int tegra_governor_get_target(struct devfreq *devfreq,
>  		target_freq = max(target_freq, dev->target_freq);
>  	}
>  
> -	*freq = target_freq * KHZ;
> +	*freq = target_freq;
>  
>  	return 0;
>  }
> @@ -663,7 +663,7 @@ static int tegra_devfreq_probe(struct platform_device *pdev)
>  			goto remove_opps;
>  		}
>  
> -		err = dev_pm_opp_add(&pdev->dev, rate, 0);
> +		err = dev_pm_opp_add(&pdev->dev, rate / KHZ, 0);
>  		if (err) {
>  			dev_err(&pdev->dev, "Failed to add OPP: %d\n", err);
>  			goto remove_opps;
> @@ -686,7 +686,8 @@ static int tegra_devfreq_probe(struct platform_device *pdev)
>  		goto unreg_notifier;
>  	}
>  
> -	tegra_devfreq_profile.initial_freq = clk_get_rate(tegra->emc_clock);
> +	tegra_devfreq_profile.initial_freq = tegra->cur_freq;
> +
>  	devfreq = devfreq_add_device(&pdev->dev, &tegra_devfreq_profile,
>  				     "tegra_actmon", NULL);
>  	if (IS_ERR(devfreq)) {
> 

Reviewed-by: Chanwoo Choi <cw00.choi@samsung.com>

-- 
Best Regards,
Chanwoo Choi
Samsung Electronics
