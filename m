Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EF4712A904F
	for <lists+linux-pm@lfdr.de>; Fri,  6 Nov 2020 08:28:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726248AbgKFH2v (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 6 Nov 2020 02:28:51 -0500
Received: from mailout3.samsung.com ([203.254.224.33]:32141 "EHLO
        mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726242AbgKFH2v (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 6 Nov 2020 02:28:51 -0500
Received: from epcas1p3.samsung.com (unknown [182.195.41.47])
        by mailout3.samsung.com (KnoxPortal) with ESMTP id 20201106072849epoutp03053c804944ed8372486078869c00bb31~E2pujQmW40230302303epoutp03H
        for <linux-pm@vger.kernel.org>; Fri,  6 Nov 2020 07:28:49 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20201106072849epoutp03053c804944ed8372486078869c00bb31~E2pujQmW40230302303epoutp03H
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1604647729;
        bh=5/qqwH9lz2fJ4CK+IIaPz8iZs4p3JF2FWcTePVeoljs=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=A0lNYRssmnjPWyPwDAykDvmidH6p+gJDv6QudrO8WfvJ9M2+vuhjykRqT51pA5KcX
         M6ljwcWpBuc1LwZ8LJCnKmXeMeVKqQe1Xpb8xJ7QujtH5tywDu+ZStIT4glXDeF4IX
         Mcg3Qe/3mcxGGO7L+O5tFgHVLljzk8fAR4PuEtZU=
Received: from epsnrtp3.localdomain (unknown [182.195.42.164]) by
        epcas1p1.samsung.com (KnoxPortal) with ESMTP id
        20201106072848epcas1p1b8a53dbded4895b2380f61c581cf15ee~E2puA3cNg2051320513epcas1p1M;
        Fri,  6 Nov 2020 07:28:48 +0000 (GMT)
Received: from epsmges1p4.samsung.com (unknown [182.195.40.156]) by
        epsnrtp3.localdomain (Postfix) with ESMTP id 4CSBp53BvxzMqYkV; Fri,  6 Nov
        2020 07:28:45 +0000 (GMT)
Received: from epcas1p3.samsung.com ( [182.195.41.47]) by
        epsmges1p4.samsung.com (Symantec Messaging Gateway) with SMTP id
        6A.6F.10463.D2BF4AF5; Fri,  6 Nov 2020 16:28:45 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20201106072844epcas1p1741b3f377101ef795aae1bdeeb1c9fa3~E2pqU4Xc01248012480epcas1p1w;
        Fri,  6 Nov 2020 07:28:44 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20201106072844epsmtrp185c8c64febe1ce5710a29e258017fb7c~E2pqT8t083160231602epsmtrp1_;
        Fri,  6 Nov 2020 07:28:44 +0000 (GMT)
X-AuditID: b6c32a38-efbff700000028df-3c-5fa4fb2d9c06
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        C2.52.13470.C2BF4AF5; Fri,  6 Nov 2020 16:28:44 +0900 (KST)
Received: from [10.113.221.102] (unknown [10.113.221.102]) by
        epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20201106072844epsmtip2a685b9a135988235f32fecce9b7c8643~E2pp86tK82512325123epsmtip2T;
        Fri,  6 Nov 2020 07:28:44 +0000 (GMT)
Subject: Re: [PATCH 4/7] devfreq: exynos: dev_pm_opp_put_*() accepts NULL
 argument
To:     Viresh Kumar <viresh.kumar@linaro.org>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Kukjin Kim <kgene@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>
Cc:     linux-pm@vger.kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Rafael Wysocki <rjw@rjwysocki.net>,
        Stephen Boyd <sboyd@kernel.org>, Nishanth Menon <nm@ti.com>,
        digetx@gmail.com, linux-samsung-soc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
From:   Chanwoo Choi <cw00.choi@samsung.com>
Organization: Samsung Electronics
Message-ID: <a2f9dbba-1c07-8b60-fda5-737843be92e0@samsung.com>
Date:   Fri, 6 Nov 2020 16:42:39 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:59.0) Gecko/20100101
        Thunderbird/59.0
MIME-Version: 1.0
In-Reply-To: <b3c936d862b8c81ab568f38bd7acc438cb7efac8.1604646059.git.viresh.kumar@linaro.org>
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrJJsWRmVeSWpSXmKPExsWy7bCmvq7u7yXxBh8uiVqs/viY0aL/8Wtm
        i/PnN7BbnG16w26x6fE1VovLu+awWXzuPcJoMeP8PiaL240r2Cze/DjLZHHm9CVWi3/XNrJY
        dBz5xmyx8auHA5/Hzll32T02repk87hzbQ+bx+Yl9R5brrazePRtWcXocfzGdiaPz5vkAjii
        sm0yUhNTUosUUvOS81My89JtlbyD453jTc0MDHUNLS3MlRTyEnNTbZVcfAJ03TJzgM5WUihL
        zCkFCgUkFhcr6dvZFOWXlqQqZOQXl9gqpRak5BRYFugVJ+YWl+al6yXn51oZGhgYmQIVJmRn
        dE0TLVjIXfFpllkD4zzOLkZODgkBE4mdX3awdDFycQgJ7GCU2HHjJRuE84lRov3OF0YI5xuj
        xKFTzSwwLT+mHoZq2cso8eLjMSYI5z2jxIpJ3WBVwgIhEg3vj4JViQicYJSY1f8NrIpZYA2T
        RP+a10wgVWwCWhL7X9xgA7H5BRQlrv54zAhi8wrYSdx+9h9sEouAisTy08vBbFGBMImT21qg
        agQlTs58AhbnFIiTWPfgIyuIzSwgLnHryXwmCFteYvvbOcwgiyUEHnBIrF+2gwniCReJ/qVP
        WSFsYYlXx7ewQ9hSEi/726DsaomVJ4+wQTR3MEps2X8BqsFYYv/SyUCDOIA2aEqs36UPEVaU
        2Pl7LiPEYj6Jd197WEFKJAR4JTrahCBKlCUuP7gLdYKkxOL2TrYJjEqzkLwzC8kLs5C8MAth
        2QJGllWMYqkFxbnpqcWGBSbI0b2JEZymtSx2MM59+0HvECMTB+MhRgkOZiUR3gt+i+KFeFMS
        K6tSi/Lji0pzUosPMZoCA3gis5Rocj4wU+SVxBuaGhkbG1uYGJqZGhoqifP+0e6IFxJITyxJ
        zU5NLUgtgulj4uCUamDyYPw1W1j3ov7+s/MWrlAxPtvxzf3NP5f9m1ytJVxXCcs/8Do7sz/i
        cd2WJ4VslXza+2dPU9uyrmn7NBVlfp1nx68qeEmsObRhyqx0FcEt0ruelRx8ZxttMLW95YR5
        nfauh1M/nDL5tuBvv3j8DP1I/4Jip9+ltjNl31hWPnyirHqoWZbDUyrlnLiWDfs6bh3vcBcV
        +ejvJ5ZGF89kSdjxc2N50bEJDvp2Otn35589MYvP5tjjSPNFCbJvbl18yNn9c2Hm9OdVChPd
        zRnuG1/g/uPaEGPjsqnoqnPCBm6uTgnZpIuJVae5Pa43KSSy9r/TSdrZcccsrW7CRQ6+537L
        7zCwbtRcNJGh7KG3uIYSS3FGoqEWc1FxIgAHJ9mjXAQAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrMIsWRmVeSWpSXmKPExsWy7bCSvK7O7yXxBttOqFis/viY0aL/8Wtm
        i/PnN7BbnG16w26x6fE1VovLu+awWXzuPcJoMeP8PiaL240r2Cze/DjLZHHm9CVWi3/XNrJY
        dBz5xmyx8auHA5/Hzll32T02repk87hzbQ+bx+Yl9R5brrazePRtWcXocfzGdiaPz5vkAjii
        uGxSUnMyy1KL9O0SuDK6pokWLOSu+DTLrIFxHmcXIyeHhICJxI+ph1m6GLk4hAR2M0osff6f
        DSIhKTHt4lHmLkYOIFtY4vDhYoiat4wSy8/dAasRFgiRaHh/FKxZROAUo8TNF/3sIA6zwBom
        iSunFrBBtDxilNi26QQLSAubgJbE/hc3wNr5BRQlrv54zAhi8wrYSdx+9h+shkVARWL56eVg
        tqhAmMTOJY+ZIGoEJU7OfAIW5xSIk1j34CMriM0soC7xZ94lZghbXOLWk/lMELa8xPa3c5gn
        MArPQtI+C0nLLCQts5C0LGBkWcUomVpQnJueW2xYYJiXWq5XnJhbXJqXrpecn7uJERyvWpo7
        GLev+qB3iJGJg/EQowQHs5II7wW/RfFCvCmJlVWpRfnxRaU5qcWHGKU5WJTEeW8ULowTEkhP
        LEnNTk0tSC2CyTJxcEo1MF195CHyevGupJ5/3w7PWqxlUX1xX6Jh76LyjD1BBzkVVCy7Y1lY
        BW+9kP1ppDn/cUqYs5bh9Wu/p6VL3rCVll6zvVbWpvtIiYKXyx0jNc0HSevSVhwMK127Q1Xf
        8/gGv0tTb5v7GtycsnlaSttT4+seEbXe4ZFHN247IvNw5WSGOS8CmWReeN+J0f997LBzv/ia
        rM+7QyIvTDtnlii8YqW56v87/jY6mk518gmRekvXpwv3bS2STj/zwNV+piKj07I1AR15JXVC
        Lz/9UlE7WfaEKV12X1vb27/v7Y4b30sucvSS//7r8sUqhcriN6+PXT4vnnD5Cu9uxs+LbqcZ
        /nQ6+NEqeNFEV/GpxyNKGZRYijMSDbWYi4oTAQXg8tdGAwAA
X-CMS-MailID: 20201106072844epcas1p1741b3f377101ef795aae1bdeeb1c9fa3
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20201106070533epcas1p480406659e38528d1263641612fcff8bb
References: <cover.1604646059.git.viresh.kumar@linaro.org>
        <CGME20201106070533epcas1p480406659e38528d1263641612fcff8bb@epcas1p4.samsung.com>
        <b3c936d862b8c81ab568f38bd7acc438cb7efac8.1604646059.git.viresh.kumar@linaro.org>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Viresh,

On 11/6/20 4:03 PM, Viresh Kumar wrote:
> The dev_pm_opp_put_*() APIs now accepts a NULL opp_table pointer and so
> there is no need for us to carry the extra check. Drop them.
> 
> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
> ---
>  drivers/devfreq/exynos-bus.c | 12 ++++--------
>  1 file changed, 4 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/devfreq/exynos-bus.c b/drivers/devfreq/exynos-bus.c
> index 1e684a448c9e..143fd58ec3dc 100644
> --- a/drivers/devfreq/exynos-bus.c
> +++ b/drivers/devfreq/exynos-bus.c
> @@ -158,10 +158,8 @@ static void exynos_bus_exit(struct device *dev)
>  
>  	dev_pm_opp_of_remove_table(dev);
>  	clk_disable_unprepare(bus->clk);
> -	if (bus->opp_table) {
> -		dev_pm_opp_put_regulators(bus->opp_table);
> -		bus->opp_table = NULL;
> -	}
> +	dev_pm_opp_put_regulators(bus->opp_table);
> +	bus->opp_table = NULL;
>  }
>  
>  static void exynos_bus_passive_exit(struct device *dev)
> @@ -444,10 +442,8 @@ static int exynos_bus_probe(struct platform_device *pdev)
>  	dev_pm_opp_of_remove_table(dev);
>  	clk_disable_unprepare(bus->clk);
>  err_reg:
> -	if (!passive) {
> -		dev_pm_opp_put_regulators(bus->opp_table);
> -		bus->opp_table = NULL;
> -	}
> +	dev_pm_opp_put_regulators(bus->opp_table);
> +	bus->opp_table = NULL;
>  
>  	return ret;
>  }
> 

Applied it. Thanks.

-- 
Best Regards,
Chanwoo Choi
Samsung Electronics
