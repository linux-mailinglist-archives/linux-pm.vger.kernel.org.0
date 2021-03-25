Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 614C0348AC7
	for <lists+linux-pm@lfdr.de>; Thu, 25 Mar 2021 08:55:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229533AbhCYHyh (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 25 Mar 2021 03:54:37 -0400
Received: from mailout3.samsung.com ([203.254.224.33]:40503 "EHLO
        mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229617AbhCYHyW (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 25 Mar 2021 03:54:22 -0400
Received: from epcas1p3.samsung.com (unknown [182.195.41.47])
        by mailout3.samsung.com (KnoxPortal) with ESMTP id 20210325075420epoutp03f06af8241e90061f9e8d483836c17835~vhqsCPzU70225702257epoutp03U
        for <linux-pm@vger.kernel.org>; Thu, 25 Mar 2021 07:54:20 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20210325075420epoutp03f06af8241e90061f9e8d483836c17835~vhqsCPzU70225702257epoutp03U
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1616658860;
        bh=EGyBSH8NZBTYbbk/1sMrOpaP/1IMDBXkBGpRs/amQ1Y=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=UalK5CGc6PQqIwhI57c6HMOz4wsPA3K/1y7JRdSvJTw53kfzEh1/FiXgBLsJxHxyV
         OMsWrm10mxf9Zm8ErJVkG6yVl9L4xikC7KwkvH+PDaESF9l0Na9/8h8bC5w4dWD9VF
         Ui+xYm+2gDr7sgwgC6PpqhUxPyJsJ3ICL/6fRTCE=
Received: from epsnrtp2.localdomain (unknown [182.195.42.163]) by
        epcas1p2.samsung.com (KnoxPortal) with ESMTP id
        20210325075419epcas1p27c0af01ce1945caa0447bfa300ae55a1~vhqrIiu1w1592515925epcas1p2M;
        Thu, 25 Mar 2021 07:54:19 +0000 (GMT)
Received: from epsmges1p2.samsung.com (unknown [182.195.40.152]) by
        epsnrtp2.localdomain (Postfix) with ESMTP id 4F5cnM2Y6xz4x9QC; Thu, 25 Mar
        2021 07:54:15 +0000 (GMT)
Received: from epcas1p4.samsung.com ( [182.195.41.48]) by
        epsmges1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        34.74.02277.7A14C506; Thu, 25 Mar 2021 16:54:15 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20210325075414epcas1p13b6c9d842bf53d230c010ca1499d6fd5~vhqmwIO_O1796117961epcas1p1n;
        Thu, 25 Mar 2021 07:54:14 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20210325075414epsmtrp16860517764eed4e4eea85aa4afaf019d~vhqmvCBlV2520325203epsmtrp1D;
        Thu, 25 Mar 2021 07:54:14 +0000 (GMT)
X-AuditID: b6c32a36-4d7ff700000108e5-73-605c41a73ba1
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        F5.10.33967.6A14C506; Thu, 25 Mar 2021 16:54:14 +0900 (KST)
Received: from [10.113.221.102] (unknown [10.113.221.102]) by
        epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20210325075414epsmtip239f47d0ca454637badb10dda42ce692c~vhqmZ9BCn2664326643epsmtip2d;
        Thu, 25 Mar 2021 07:54:14 +0000 (GMT)
Subject: Re: [PATCH V8 7/8] devfreq: mediatek: cci devfreq register opp
 notification for SVS support
To:     "Andrew-sh.Cheng" <andrew-sh.cheng@mediatek.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Nishanth Menon <nm@ti.com>, Stephen Boyd <sboyd@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>
Cc:     linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        srv_heupstream@mediatek.com
From:   Chanwoo Choi <cw00.choi@samsung.com>
Organization: Samsung Electronics
Message-ID: <6f1f7bf5-54b0-d3e2-e93c-fa4a837c9222@samsung.com>
Date:   Thu, 25 Mar 2021 17:11:14 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:59.0) Gecko/20100101
        Thunderbird/59.0
MIME-Version: 1.0
In-Reply-To: <1616499241-4906-8-git-send-email-andrew-sh.cheng@mediatek.com>
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrOJsWRmVeSWpSXmKPExsWy7bCmge5yx5gEg5WHBCy2r3/BajH14RM2
        i/lHzrFanG16w27x7UoHk8Wmx9dYLS7vmsNmcbn5IqPF594jjBZLr19ksmhqMba43biCzeLN
        j7NMFmdOX2K1aN17hN3i37WNLBbT7wpZbPzq4SDksWbeGkaPnbPusntsWtXJ5nHn2h42j81L
        6j1aTu5n8dhytZ3Fo2/LKkaP4ze2M3l83iQXwBWVbZORmpiSWqSQmpecn5KZl26r5B0c7xxv
        amZgqGtoaWGupJCXmJtqq+TiE6DrlpkD9JKSQlliTilQKCCxuFhJ386mKL+0JFUhI7+4xFYp
        tSAlp8CyQK84Mbe4NC9dLzk/18rQwMDIFKgwITuj/8srtoKDYhUnZjcxNjD+Fuxi5OSQEDCR
        2DdlO1MXIxeHkMAORomX3ROgnE+MEn9Xn2GHcL4xSjTP3cIK07Jy8Xmoqr2MEp8mPWGGcN4z
        Stx63MgGUiUskCbx4SNIBxeHiMAtZol9B+aDVTELHGSUmH7pIhNIFZuAlsT+FzfAOvgFFCWu
        /njMCGLzCthJ/FvxDayGRUBV4mXfMmYQW1QgTOLkthaoGkGJkzOfsIDYnAI+Ev0/zoHZzALi
        EreezGeCsOUltr+dA7ZYQqCfU2Ltu+mMEE+4SDR/u8oOYQtLvDq+BcqWknjZ3wZlV0usPHmE
        DaK5g1Fiy/4L0BAwlti/dDLQBg6gDZoS63fpQ4QVJXb+nssIsZhP4t3XHlaQEgkBXomONiGI
        EmWJyw/uMkHYkhKL2zvZJjAqzULyziwkL8xC8sIshGULGFlWMYqlFhTnpqcWGxYYIUf4JkZw
        itcy28E46e0HvUOMTByMhxglOJiVRHhbwiMShHhTEiurUovy44tKc1KLDzGaAgN4IrOUaHI+
        MMvklcQbmhoZGxtbmBiamRoaKonzJho8iBcSSE8sSc1OTS1ILYLpY+LglGpgst0b+5Fjnsbz
        rSx2nIbbdloLrz74TcDv/dEeo8Q9WxVabzWt53f0vrmtekHfY+29AvtL2Jrff+w3EDZ7mOh/
        qrvZ6PaktV/8BWM/LTsqOy/zqI7tCbcbyluMWjd8SOKbprbqpO/5X1+rRXl97ljWtNZddI18
        ueE+S9I6Zan4F2o1r+T3sK8UZv+1TTDl3QS23hsHZh+ztj58N+H/Os7l8tHzdj0IU/oyuSTj
        hsYxkQsHPsxrfJOhF3w3ZeZZl7VbFzFNviCyv9359qXj6w+WxMs6fjR+8ku8PetU5PsZhclc
        kUW9/0sOuhhu3axvNVvpeHhymx93t4s98824Uw+aWjY9yXp0nO9x/lRetVUBj5VYijMSDbWY
        i4oTAdXw3Lx6BAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrIIsWRmVeSWpSXmKPExsWy7bCSvO4yx5gEg8U75C22r3/BajH14RM2
        i/lHzrFanG16w27x7UoHk8Wmx9dYLS7vmsNmcbn5IqPF594jjBZLr19ksmhqMba43biCzeLN
        j7NMFmdOX2K1aN17hN3i37WNLBbT7wpZbPzq4SDksWbeGkaPnbPusntsWtXJ5nHn2h42j81L
        6j1aTu5n8dhytZ3Fo2/LKkaP4ze2M3l83iQXwBXFZZOSmpNZllqkb5fAldH/5RVbwUGxihOz
        mxgbGH8LdjFyckgImEisXHyeqYuRi0NIYDejxOb288wQCUmJaRePAtkcQLawxOHDxRA1bxkl
        3vU1soLUCAukSXz4uIUVJCEicI9Z4t2U38wgDrPAQUaJZ91/2CFaHjJKfFu6mQWkhU1AS2L/
        ixtsIDa/gKLE1R+PGUFsXgE7iX8rvjGB2CwCqhIv+5aBnSEqECaxc8ljJogaQYmTM5+AzeEU
        8JHo/3EOzGYWUJf4M+8SM4QtLnHryXwmCFteYvvbOcwTGIVnIWmfhaRlFpKWWUhaFjCyrGKU
        TC0ozk3PLTYsMMxLLdcrTswtLs1L10vOz93ECI51Lc0djNtXfdA7xMjEwXiIUYKDWUmEtyU8
        IkGINyWxsiq1KD++qDQntfgQozQHi5I474Wuk/FCAumJJanZqakFqUUwWSYOTqkGpsKyjPri
        VgPBO++WBkat2WrzjdHkl2XaxDqvaSEyZ3RXlgVqlTx7tMljo3PMf90FYZPadk5siPmb6Te5
        w0KEJWt66Pkoye0nU1tMO319vzBIHQ9z602s0hFNZo++b5PqJfPgr5/saeYDWnXPP1Ve51u4
        MnNBgt/JxPmuM8xrPsStLT8duOPoq4wD8fYHLy+v3/L3m8/ElTO73yvaTrr7/9D8KdP2XfuT
        4udqs55XJvWM/LQ7h2vDOm9ect3YpaRY8ztIb9eGhk3qXhOXMLUZ//dsFbT0NQhebfzw9umV
        bYUzrsyUVHq6tsDxrdj5wP5UVVHmeP5nN+uyn2qoyB4Nnnxllv75M68kAgXktGb3KrEUZyQa
        ajEXFScCANIkt+9kAwAA
X-CMS-MailID: 20210325075414epcas1p13b6c9d842bf53d230c010ca1499d6fd5
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20210323113413epcas1p1d3acc9ac2539da96b0757a0159bdcfc7
References: <1616499241-4906-1-git-send-email-andrew-sh.cheng@mediatek.com>
        <CGME20210323113413epcas1p1d3acc9ac2539da96b0757a0159bdcfc7@epcas1p1.samsung.com>
        <1616499241-4906-8-git-send-email-andrew-sh.cheng@mediatek.com>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi,

I think that you can squash this patch to patch4.

On 3/23/21 8:34 PM, Andrew-sh.Cheng wrote:
> From: "Andrew-sh.Cheng" <andrew-sh.cheng@mediatek.com>
> 
> SVS will change the voltage of opp item.

What it the full name of SVS?

> CCI devfreq need to react to change frequency.
> 
> Signed-off-by: Andrew-sh.Cheng <andrew-sh.cheng@mediatek.com>
> ---
>  drivers/devfreq/mt8183-cci-devfreq.c | 27 +++++++++++++++++++++++++++
>  1 file changed, 27 insertions(+)
> 
> diff --git a/drivers/devfreq/mt8183-cci-devfreq.c b/drivers/devfreq/mt8183-cci-devfreq.c
> index 018543db7bae..6942a48f3f4f 100644
> --- a/drivers/devfreq/mt8183-cci-devfreq.c
> +++ b/drivers/devfreq/mt8183-cci-devfreq.c
> @@ -21,6 +21,7 @@ struct cci_devfreq {
>  	struct clk *cci_clk;
>  	int old_vproc;
>  	unsigned long old_freq;
> +	struct notifier_block opp_nb;
>  };
>  
>  static int mtk_cci_set_voltage(struct cci_devfreq *cci_df, int vproc)
> @@ -89,6 +90,26 @@ static int mtk_cci_devfreq_target(struct device *dev, unsigned long *freq,
>  	return 0;
>  }
>  
> +static int ccidevfreq_opp_notifier(struct notifier_block *nb,

I think that you better to change the function name as following:
ccidevfreq_opp_notifier -> mtk_cci_devfreq_opp_notifier

> +				   unsigned long event, void *data)
> +{
> +	struct dev_pm_opp *opp = data;
> +	struct cci_devfreq *cci_df = container_of(nb, struct cci_devfreq,
> +						  opp_nb);
> +	unsigned long	freq, volt;
> +
> +	if (event == OPP_EVENT_ADJUST_VOLTAGE) {
> +		freq = dev_pm_opp_get_freq(opp);
> +		/* current opp item is changed */
> +		if (freq == cci_df->old_freq) {
> +			volt = dev_pm_opp_get_voltage(opp);
> +			mtk_cci_set_voltage(cci_df, volt);
> +		}
> +	}
> +
> +	return 0;
> +}
> +
>  static struct devfreq_dev_profile cci_devfreq_profile = {
>  	.target = mtk_cci_devfreq_target,
>  };
> @@ -98,12 +119,15 @@ static int mtk_cci_devfreq_probe(struct platform_device *pdev)
>  	struct device *cci_dev = &pdev->dev;
>  	struct cci_devfreq *cci_df;
>  	struct devfreq_passive_data *passive_data;
> +	struct notifier_block *opp_nb;
>  	int ret;
>  
>  	cci_df = devm_kzalloc(cci_dev, sizeof(*cci_df), GFP_KERNEL);
>  	if (!cci_df)
>  		return -ENOMEM;
>  
> +	opp_nb = &cci_df->opp_nb;

Just move this code at the neighborhood of 'opp_nb->notifier_call' init code.

> +
>  	cci_df->cci_clk = devm_clk_get(cci_dev, "cci_clock");
>  	ret = PTR_ERR_OR_ZERO(cci_df->cci_clk);
>  	if (ret) {
> @@ -152,6 +176,9 @@ static int mtk_cci_devfreq_probe(struct platform_device *pdev)
>  		goto err_opp;
>  	}
>  
> +	opp_nb->notifier_call = ccidevfreq_opp_notifier;
> +	dev_pm_opp_register_notifier(cci_dev, opp_nb);

Need to check whether return value is valid or not.

> +
>  	return 0;
>  
>  err_opp:
> 


-- 
Best Regards,
Chanwoo Choi
Samsung Electronics
