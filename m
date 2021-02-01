Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 93AF5309F9F
	for <lists+linux-pm@lfdr.de>; Mon,  1 Feb 2021 01:06:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229813AbhBAAGb (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 31 Jan 2021 19:06:31 -0500
Received: from mailout3.samsung.com ([203.254.224.33]:57951 "EHLO
        mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229495AbhBAAG0 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 31 Jan 2021 19:06:26 -0500
Received: from epcas1p2.samsung.com (unknown [182.195.41.46])
        by mailout3.samsung.com (KnoxPortal) with ESMTP id 20210201000540epoutp03e8ef7010bec2c76903d5415fde100589~fdup19PaW0886408864epoutp03_
        for <linux-pm@vger.kernel.org>; Mon,  1 Feb 2021 00:05:40 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20210201000540epoutp03e8ef7010bec2c76903d5415fde100589~fdup19PaW0886408864epoutp03_
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1612137941;
        bh=bEwtsacQFPBPaJXsD/yffm3iWGCOhx2GmyJ+elyD9oY=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=gX3uicwCn39Y6fX/tcvZubT+z+H9s1IGYf7gPv1n+KP2+D8w7FxhWo8TGl6OwWUuN
         BD3+i8BIQi5pK6Krqb4spIprsJvw345fMgqxLMY2M2iQyjH1FYHlF/Ebim1VGXTC6o
         i9n2HzpM6SWLazDIpJiEMLKlkYU2+EdY/0l0jrFw=
Received: from epsnrtp2.localdomain (unknown [182.195.42.163]) by
        epcas1p3.samsung.com (KnoxPortal) with ESMTP id
        20210201000540epcas1p35cf72e21ca8d175c0c81ec512fd065cb~fdupIKCDd0326003260epcas1p3T;
        Mon,  1 Feb 2021 00:05:40 +0000 (GMT)
Received: from epsmges1p5.samsung.com (unknown [182.195.40.156]) by
        epsnrtp2.localdomain (Postfix) with ESMTP id 4DTSrd69Ljz4x9Q7; Mon,  1 Feb
        2021 00:05:37 +0000 (GMT)
Received: from epcas1p2.samsung.com ( [182.195.41.46]) by
        epsmges1p5.samsung.com (Symantec Messaging Gateway) with SMTP id
        F1.3E.09577.1D547106; Mon,  1 Feb 2021 09:05:37 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas1p4.samsung.com (KnoxPortal) with ESMTPA id
        20210201000536epcas1p4ffb3d916c2966ed55da5f880566a131f~fdul24ClZ3010030100epcas1p4x;
        Mon,  1 Feb 2021 00:05:36 +0000 (GMT)
Received: from epsmgms1p2.samsung.com (unknown [182.195.42.42]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20210201000536epsmtrp1223f3e761185e317fb119f88d791d6d2~fdul2ACcu1721017210epsmtrp12;
        Mon,  1 Feb 2021 00:05:36 +0000 (GMT)
X-AuditID: b6c32a39-c13ff70000002569-f9-601745d1154d
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        16.7C.08745.0D547106; Mon,  1 Feb 2021 09:05:36 +0900 (KST)
Received: from [10.113.221.102] (unknown [10.113.221.102]) by
        epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20210201000536epsmtip1628d7fc8c8692867e21a29fed034c07f~fdulXhb4p1187311873epsmtip1h;
        Mon,  1 Feb 2021 00:05:36 +0000 (GMT)
Subject: Re: [PATCH V2 11/13] devfreq: tegra30: Migrate to
 dev_pm_opp_set_opp()
To:     Viresh Kumar <viresh.kumar@linaro.org>,
        Dmitry Osipenko <digetx@gmail.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>
Cc:     linux-pm@vger.kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Rafael Wysocki <rjw@rjwysocki.net>,
        Stephen Boyd <sboyd@kernel.org>, Nishanth Menon <nm@ti.com>,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
From:   Chanwoo Choi <cw00.choi@samsung.com>
Organization: Samsung Electronics
Message-ID: <756b5af0-2c80-9c39-242c-d9552f03bcd6@samsung.com>
Date:   Mon, 1 Feb 2021 09:21:31 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:59.0) Gecko/20100101
        Thunderbird/59.0
MIME-Version: 1.0
In-Reply-To: <f0341655361aa0107266ed9c838aa8bcfe50a3ed.1611738418.git.viresh.kumar@linaro.org>
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrKJsWRmVeSWpSXmKPExsWy7bCmnu5FV/EEgxd9hharPz5mtGiZtYjF
        4mzTG3aLy7vmsFl87j3CaNH5ZRabxe3GFWwWb36cZbI4c/oSq8W/axtZLH7umsdi0XHkG7PF
        xq8eDrweO2fdZffYtKqTzePOtT1sHr3N79g8tlxtZ/Ho27KK0eP4je1MHp83yQVwRGXbZKQm
        pqQWKaTmJeenZOal2yp5B8c7x5uaGRjqGlpamCsp5CXmptoqufgE6Lpl5gCdrKRQlphTChQK
        SCwuVtK3synKLy1JVcjILy6xVUotSMkpsCzQK07MLS7NS9dLzs+1MjQwMDIFKkzIzrjwbCpb
        wU2+igUTrjA3MC7g6WLk5JAQMJFY//Q+axcjF4eQwA5GiY5VZ1lAEkICnxglrl9LgbA/M0pM
        uxMH09C87RYbRMMuRolPq04xQTjvGSWmX98M1i0sECixqXkNM0hCROA3o8TBw5fBWpgF3jBK
        tPV+ZASpYhPQktj/4gYbiM0voChx9cdjsDivgJ3E+WlLwWwWARWJRccugE0VFQiTOLmtBapG
        UOLkzCdgcU6BOIkzkw+DxZkFxCVuPZnPBGHLS2x/OwfsCgmBOxwSL9sbWCGecJHo3nqUHcIW
        lnh1fAuULSXxsr8Nyq6WWHnyCBtEcwejxJb9F6CajSX2L50MtIEDaIOmxPpd+hBhRYmdv+dC
        HcEn8e5rDytIiYQAr0RHmxBEibLE5Qd3mSBsSYnF7Z1sExiVZiF5ZxaSF2YheWEWwrIFjCyr
        GMVSC4pz01OLDQtMkaN7EyM4PWtZ7mCc/vaD3iFGJg7GQ4wSHMxKIrynJoklCPGmJFZWpRbl
        xxeV5qQWH2I0BQbwRGYp0eR8YIbIK4k3NDUyNja2MDE0MzU0VBLnTTJ4EC8kkJ5YkpqdmlqQ
        WgTTx8TBKdXAxLJDPSo+5GlLxGqlZXUr2Np+cRx7W/Jhx+1vL/7aTXnw1LHA47Dysi1T+2Uk
        bbeanbsu93l/iamt6RRVm+7LWWeln3cE/ni2f8ayjSXbdDPU806fXy3+UvDUAzObf3/9VNZ+
        vVv5YK5Qle5vTev1PlWuq3PUrduYZx+cW7fKX/vQfrkdtR8NbaP9nV8059x3vMvwmlnhy3oB
        /pdB17cm/X67IfJho/ryLctPFUTq8Zn9/61W+fDlR5voZx6Oc5r/i8mG9b2YauIjcmLypWut
        WYyWd9+vM3SJtxPonHBJf0Oq4aXZSfOfM16+yLlct/0Wk9WVEnWDtVceNT+p4OGVOv+1cVXW
        86ViwV6vZXxSziqxFGckGmoxFxUnAgAQG+m8WAQAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrHIsWRmVeSWpSXmKPExsWy7bCSnO4FV/EEg+9NiharPz5mtGiZtYjF
        4mzTG3aLy7vmsFl87j3CaNH5ZRabxe3GFWwWb36cZbI4c/oSq8W/axtZLH7umsdi0XHkG7PF
        xq8eDrweO2fdZffYtKqTzePOtT1sHr3N79g8tlxtZ/Ho27KK0eP4je1MHp83yQVwRHHZpKTm
        ZJalFunbJXBlXHg2la3gJl/FgglXmBsYF/B0MXJySAiYSDRvu8UGYgsJ7GCU2Ls8GiIuKTHt
        4lHmLkYOIFtY4vDhYoiSt4wSH1tqQGxhgUCJTc1rgEq4OEQE/jJKHLi4jRkkwSzwhlHi/a0I
        kISQQCuTxK+HfewgCTYBLYn9L26ALeMXUJS4+uMxI4jNK2AncX7aUjCbRUBFYtGxCywgtqhA
        mMTOJY+ZIGoEJU7OfAIW5xSIkzgz+TAjxDJ1iT/zLkEtFpe49WQ+E4QtL7H97RzmCYzCs5C0
        z0LSMgtJyywkLQsYWVYxSqYWFOem5xYbFhjlpZbrFSfmFpfmpesl5+duYgRHqZbWDsY9qz7o
        HWJk4mA8xCjBwawkwntqkliCEG9KYmVValF+fFFpTmrxIUZpDhYlcd4LXSfjhQTSE0tSs1NT
        C1KLYLJMHJxSDUxn3Pxurphe3c0fHfyxInjTtW1vTu6a7RfLHrXn84PkJw9jmB+wLxA6Zy24
        61lsydbb5WKqaTwzHs3Y55bmvGqh90y5RJ7Gv7MNf/w4uP980h4rnmQOr/slom+079dsm78m
        /3rd2ZZpsm9Vky1X/+MNLZCwneci6q/tfunSd0aLj3lBOy/3C9Y12G25uP7TqxbdXcvS96y4
        xLkgty9289db2lr3JA6fMD4t5XbXjvNX3S5jbYsVu5i7LCc9Zy4umnz58eLJTo7+y3pUtm6P
        6cryC2B9f/2MTt3Z/SuOPsoyPP3pp+PkWa2+nJsvcb+QdNzqqc4bV/Rr+zQh84pDCu+cr14I
        4dp2I/QE6z+Xa56VSizFGYmGWsxFxYkABe3NbEEDAAA=
X-CMS-MailID: 20210201000536epcas1p4ffb3d916c2966ed55da5f880566a131f
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20210127091008epcas1p204716c6e5b0157c5bae7237300609210
References: <3345fd49f7987d022f4f61edb6c44f230f7354c4.1611227342.git.viresh.kumar@linaro.org>
        <CGME20210127091008epcas1p204716c6e5b0157c5bae7237300609210@epcas1p2.samsung.com>
        <f0341655361aa0107266ed9c838aa8bcfe50a3ed.1611738418.git.viresh.kumar@linaro.org>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 1/27/21 6:10 PM, Viresh Kumar wrote:
> dev_pm_opp_set_bw() is getting removed and dev_pm_opp_set_opp() should
> be used instead. Migrate to the new API.
> 
> We don't want the OPP core to manage the clk for this driver, migrate to
> dev_pm_opp_of_add_table_noclk() to make sure dev_pm_opp_set_opp()
> doesn't have any side effects.
> 
> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
> ---
> Dmitry,
> 
> This is based over the patches sent here:
> 
> https://protect2.fireeye.com/v1/url?k=72d88562-2d43bc78-72d90e2d-000babff24ad-e4764030101eaedc&q=1&e=a25b5db7-346b-47b2-9c0a-3945e579f389&u=https%3A%2F%2Flore.kernel.org%2Flkml%2F6c2160ff30a8f421563793020264cf9f533f293c.1611738228.git.viresh.kumar%40linaro.org%2F
> 
> This should fix the problem you mentioned earlier. Will push this for
> linux-next unless you have any issues with it.
> 
>  drivers/devfreq/tegra30-devfreq.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/devfreq/tegra30-devfreq.c b/drivers/devfreq/tegra30-devfreq.c
> index 117cad7968ab..31f7dec5990b 100644
> --- a/drivers/devfreq/tegra30-devfreq.c
> +++ b/drivers/devfreq/tegra30-devfreq.c
> @@ -647,7 +647,7 @@ static int tegra_devfreq_target(struct device *dev, unsigned long *freq,
>  		return PTR_ERR(opp);
>  	}
>  
> -	ret = dev_pm_opp_set_bw(dev, opp);
> +	ret = dev_pm_opp_set_opp(dev, opp);
>  	dev_pm_opp_put(opp);
>  
>  	return ret;
> @@ -849,7 +849,7 @@ static int tegra_devfreq_probe(struct platform_device *pdev)
>  		return err;
>  	}
>  
> -	err = dev_pm_opp_of_add_table(&pdev->dev);
> +	err = dev_pm_opp_of_add_table_noclk(&pdev->dev);
>  	if (err) {
>  		dev_err(&pdev->dev, "Failed to add OPP table: %d\n", err);
>  		goto put_hw;
> 

Acked-by: Chanwoo Choi <cw00.choi@samsung.com>

-- 
Best Regards,
Chanwoo Choi
Samsung Electronics
