Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 453C8EBE32
	for <lists+linux-pm@lfdr.de>; Fri,  1 Nov 2019 07:55:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730054AbfKAGzj (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 1 Nov 2019 02:55:39 -0400
Received: from mailout3.samsung.com ([203.254.224.33]:64569 "EHLO
        mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729476AbfKAGzj (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 1 Nov 2019 02:55:39 -0400
Received: from epcas1p2.samsung.com (unknown [182.195.41.46])
        by mailout3.samsung.com (KnoxPortal) with ESMTP id 20191101065537epoutp03519285964e53faf3dfd13482dd582b5e~S931cwU1x0795507955epoutp03q
        for <linux-pm@vger.kernel.org>; Fri,  1 Nov 2019 06:55:37 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20191101065537epoutp03519285964e53faf3dfd13482dd582b5e~S931cwU1x0795507955epoutp03q
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1572591337;
        bh=6y5zp92aW7WyXIDBavkDiN5CumCyAgaC0bAZLoSm1yw=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=CJ2q7aZ1IB0XeQ7zBJ5isJU65mkxJEVnXiLqlNtFF8pK7yAFfyg2d/43f16WAOUtU
         FeGCEDHpmlxvIQf+FvJlakXdimDlREtbx9eUep0qIlOluThP+5+9Kpn7W3n3186WGt
         V5J7JxdFQBvzJSpC2ouFUAjVsg26N37t82ObFKZ4=
Received: from epsnrtp1.localdomain (unknown [182.195.42.162]) by
        epcas1p2.samsung.com (KnoxPortal) with ESMTP id
        20191101065537epcas1p20269cbb96d68c66c22a6b7333ec9eb2a~S931BNrMI1271412714epcas1p2U;
        Fri,  1 Nov 2019 06:55:37 +0000 (GMT)
Received: from epsmges1p5.samsung.com (unknown [182.195.40.153]) by
        epsnrtp1.localdomain (Postfix) with ESMTP id 474Cd26YCnzMqYlv; Fri,  1 Nov
        2019 06:55:34 +0000 (GMT)
Received: from epcas1p3.samsung.com ( [182.195.41.47]) by
        epsmges1p5.samsung.com (Symantec Messaging Gateway) with SMTP id
        3F.A8.04068.6E6DBBD5; Fri,  1 Nov 2019 15:55:34 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas1p4.samsung.com (KnoxPortal) with ESMTPA id
        20191101065534epcas1p487ab18951c725c79495f546b8ff13bff~S93yl6a4I2361823618epcas1p4H;
        Fri,  1 Nov 2019 06:55:34 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20191101065534epsmtrp2df45c04e6aaa789ae1b25bf2be816d9e~S93ylHU4h0075400754epsmtrp2M;
        Fri,  1 Nov 2019 06:55:34 +0000 (GMT)
X-AuditID: b6c32a39-f47ff70000000fe4-a4-5dbbd6e69c6f
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        B4.59.24756.6E6DBBD5; Fri,  1 Nov 2019 15:55:34 +0900 (KST)
Received: from [10.113.221.102] (unknown [10.113.221.102]) by
        epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20191101065534epsmtip232091287ef28c718a1de871fa0077dad~S93yV-Gt70302403024epsmtip22;
        Fri,  1 Nov 2019 06:55:34 +0000 (GMT)
Subject: Re: [PATCH v7 15/19] PM / devfreq: tegra30: Disable consecutive
 interrupts when appropriate
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
Message-ID: <1e363539-c9fb-0b1c-8cf7-b1cf320a2d28@samsung.com>
Date:   Fri, 1 Nov 2019 16:01:05 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
        Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20191029220019.26773-16-digetx@gmail.com>
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA01Sa1BMYRieb8/p7KmxfFbxyiCHGXTd07Y5IXIZdlxG4zY0kjPtsTXtbc7Z
        EH/cV5EhY6YWyW0o45JW2tTE5hbCCOOWCTEYckkuI8OeTkb/nu95nu993vf7XprQnqZC6Uyb
        UxBtvIWhgsjK+tExUa8fnE/VlTTFc8c/v0TcRvdBkmtc/17NNVXvpbj2/EuIy/3qprgn645R
        XOPrmdzP6mKS237iLpUUZKxqPoyMXnez2pi/oY0ybveUIWP7mSHJASlZ4zME3iSIYYIt3W7K
        tJkTmZnz0qakGeJ1bBSbwI1hwmy8VUhkps5KjpqWafE3xYSt4C3ZfiqZlyQmZsJ40Z7tFMIy
        7JIzkREcJosjwREt8VYp22aOTrdbx7I6XazBb1yWlXH9Vy3heKNd9fT5b7QWneyThwJpwHHQ
        4qkh8lAQrcVVCC48KkLK4QuC2w+3divfEDSW/ib+Xanc9IRUhFoEVwvWdbs+Ivje3tjl6oeX
        w4UPRylZCMYHVXDi8rkugcCLod57XCVjCodD3ZuHlIz74GFw/8dLfzhNa/AEKHclyTSJR8CN
        zg5CpkPwIrjRwcu0BveFhqJWUqYD8Rj448lRig+Ax637VQoeChvO7unu2aWGsvdxsh3wVOgs
        sSp0P3h31aNWcCi0t9VSCl4DpQ2XupoHvAWBp+5OgCLooe7ILpVch8Cj4VR1jEIPA++vfUiJ
        7Q1tHdsClCgNbNmsVSzDoamlWaXggXDIlUvtQIy7xyzuHgO4ewzg/h9Wgsgy1F9wSFazILEO
        Q8+vPoO6tjU8oQpduTXLhzCNmF6awrzzqdoAfoWUY/UhoAkmWHPupJ/SmPic1YJoTxOzLYLk
        Qwb/S+8kQkPS7f7dtznTWEOsXq/n4th4A8syAzSTjh5J1WIz7xSyBMEhiP/uqejA0LUo2FV0
        7+3c6SGqzfS2ZxPv5nzbr/N1+FCnON9VeGtcftKniIVi3oJRs+ckV9avLM01H9AENwyeXTCS
        rIgsLK9+1OKJ/Ci9q5kxNvLz5PW7L84oD7r/ovVO7CD7iKUH7N/Da2uKK1KuCaeO3Yx4vGQe
        fqH3biqepO9rim4exKobXqV45zKklMGz4YQo8X8BnnTgQsMDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprLIsWRmVeSWpSXmKPExsWy7bCSvO6za7tjDW5vkLdY/fExo0XLrEUs
        Fmeb3rBbXN41h83ic+8RRovOL7PYLG43rmCzOPvM2+LnrnksFn1rL7E5cHnsuLuE0WPnrLvs
        Hr3N79g8+rasYvT4vEkugDWKyyYlNSezLLVI3y6BK+PU773MBS+EKu48/MvYwLiOv4uRk0NC
        wERiW+ttli5GLg4hgd2MEufX/2SDSEhKTLt4lLmLkQPIFpY4fLgYouYto8TsdbdZQWqEBdIk
        DrxdzgaSEBFYwiRx9styZpAEs0CkRM/cLWwQHdsYJS71LQKbyiagJbH/xQ0wm19AUeLqj8eM
        IBt4BewkNrY7gIRZBFQkTv/5CjZHVCBC4vn2G4wgNq+AoMTJmU9YQMo5Bcwl/m+phFilLvFn
        3iWoteISt57MZ4Kw5SWat85mnsAoPAtJ9ywkLbOQtMxC0rKAkWUVo2RqQXFuem6xYYFhXmq5
        XnFibnFpXrpecn7uJkZwpGlp7mC8vCT+EKMAB6MSD++Mrt2xQqyJZcWVuYcYJTiYlUR4t68D
        CvGmJFZWpRblxxeV5qQWH2KU5mBREud9mncsUkggPbEkNTs1tSC1CCbLxMEp1cBYJuIjcdH/
        Wc6e1vSGbXVvzcqjdiexr/m0ZpaRmHjAWdY2y53s61RKZqblBKpJrInJvzx7WZh61qudNeYz
        Jq6SutHJulBrjn/grSNbd8vqOlyZkPk4VfnSJd+VWQExnreXzDy3pmzTkX9qC5SjP65zXTFJ
        vuve/lynZ1MLP95xfFiv9eOGzd3XSizFGYmGWsxFxYkApulOP7ACAAA=
X-CMS-MailID: 20191101065534epcas1p487ab18951c725c79495f546b8ff13bff
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20191029220657epcas3p42c1eccf4499f36a57cdbd89a750fb60b
References: <20191029220019.26773-1-digetx@gmail.com>
        <CGME20191029220657epcas3p42c1eccf4499f36a57cdbd89a750fb60b@epcas3p4.samsung.com>
        <20191029220019.26773-16-digetx@gmail.com>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 19. 10. 30. 오전 7:00, Dmitry Osipenko wrote:
> Consecutive interrupts should be disabled when boosting is completed.
> 
> Currently the disabling of "lower" interrupt happens only for MCCPU
> monitor that uses dependency threshold, but even in a case of MCCPU the
> interrupt isn't getting disabled if CPU's activity is above the threshold.
> This results in a lot of dummy interrupt requests. The boosting feature is
> used by both MCCPU and MCALL, boosting should be stopped once it reaches 0
> for both of the monitors and regardless of the activity level.
> 
> The boosting stops to grow once the maximum limit is hit and thus the
> "upper" interrupt needs to be disabled when the limit is reached.
> 
> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
> ---
>  drivers/devfreq/tegra30-devfreq.c | 15 ++++++---------
>  1 file changed, 6 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/devfreq/tegra30-devfreq.c b/drivers/devfreq/tegra30-devfreq.c
> index a9336cf4b37a..b745a973c35a 100644
> --- a/drivers/devfreq/tegra30-devfreq.c
> +++ b/drivers/devfreq/tegra30-devfreq.c
> @@ -259,8 +259,10 @@ static void actmon_isr_device(struct tegra_devfreq *tegra,
>  
>  		dev_ctrl |= ACTMON_DEV_CTRL_CONSECUTIVE_BELOW_WMARK_EN;
>  
> -		if (dev->boost_freq >= tegra->max_freq)
> +		if (dev->boost_freq >= tegra->max_freq) {
> +			dev_ctrl &= ~ACTMON_DEV_CTRL_CONSECUTIVE_ABOVE_WMARK_EN;
>  			dev->boost_freq = tegra->max_freq;
> +		}
>  	} else if (intr_status & ACTMON_DEV_INTR_CONSECUTIVE_LOWER) {
>  		/*
>  		 * new_boost = old_boost * down_coef
> @@ -271,15 +273,10 @@ static void actmon_isr_device(struct tegra_devfreq *tegra,
>  
>  		dev_ctrl |= ACTMON_DEV_CTRL_CONSECUTIVE_ABOVE_WMARK_EN;
>  
> -		if (dev->boost_freq < (ACTMON_BOOST_FREQ_STEP >> 1))
> -			dev->boost_freq = 0;
> -	}
> -
> -	if (dev->config->avg_dependency_threshold) {
> -		if (dev->avg_count >= dev->config->avg_dependency_threshold)
> -			dev_ctrl |= ACTMON_DEV_CTRL_CONSECUTIVE_BELOW_WMARK_EN;
> -		else if (dev->boost_freq == 0)
> +		if (dev->boost_freq < (ACTMON_BOOST_FREQ_STEP >> 1)) {
>  			dev_ctrl &= ~ACTMON_DEV_CTRL_CONSECUTIVE_BELOW_WMARK_EN;
> +			dev->boost_freq = 0;
> +		}
>  	}
>  
>  	device_writel(dev, dev_ctrl, ACTMON_DEV_CTRL);
> 

Reviewed-by: Chanwoo Choi <cw00.choi@samsung.com>

-- 
Best Regards,
Chanwoo Choi
Samsung Electronics
