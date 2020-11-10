Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E12612AD01A
	for <lists+linux-pm@lfdr.de>; Tue, 10 Nov 2020 07:57:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726849AbgKJG5X (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 10 Nov 2020 01:57:23 -0500
Received: from mailout1.w1.samsung.com ([210.118.77.11]:33219 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726467AbgKJG5X (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 10 Nov 2020 01:57:23 -0500
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20201110065710euoutp01a5cc94847a895895cf00d4c03a3c1799~GEzPu-52r1269012690euoutp01A
        for <linux-pm@vger.kernel.org>; Tue, 10 Nov 2020 06:57:10 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20201110065710euoutp01a5cc94847a895895cf00d4c03a3c1799~GEzPu-52r1269012690euoutp01A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1604991431;
        bh=GuXoIHxsCa9fwMsSr0iq1ozcYJ8sP/0sWgu6bH/hBlM=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=bYTxPt/HnsNFVM7/1A0vu7+Co9O2iu36Cw9lzPUn57bnCVf5xYqbLlViZuixI3Seb
         gUJC8nSFF5uaF90+S6pibdkejNercRqvrkVs4fS1cnzGF6zbr2AwgyGkCH4zUkiCev
         kxJom3L/uiAPa9E6snifdXCT1Y43w3ApTcp1LAwo=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20201110065702eucas1p246444066d57e704bf6eed9d5c1fc6794~GEzIGaeLg1532415324eucas1p2T;
        Tue, 10 Nov 2020 06:57:02 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges2new.samsung.com (EUCPMTA) with SMTP id C2.5E.05997.EB93AAF5; Tue, 10
        Nov 2020 06:57:02 +0000 (GMT)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20201110065702eucas1p2712c2d2220b4ea622468b616d4440349~GEzHuFndT2242822428eucas1p2u;
        Tue, 10 Nov 2020 06:57:02 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20201110065702eusmtrp23adf7e87f514e2c93c2755ccfa8bf7cb~GEzHtWojB1720717207eusmtrp2U;
        Tue, 10 Nov 2020 06:57:02 +0000 (GMT)
X-AuditID: cbfec7f4-65dff7000000176d-6f-5faa39bec96e
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id 1D.A1.06314.EB93AAF5; Tue, 10
        Nov 2020 06:57:02 +0000 (GMT)
Received: from [106.210.88.143] (unknown [106.210.88.143]) by
        eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20201110065701eusmtip24ae5154da5ca3dcd9c458bdd4e8b5c2e~GEzHHaE1x1016110161eusmtip2T;
        Tue, 10 Nov 2020 06:57:01 +0000 (GMT)
Subject: Re: [PATCH 1/2] cpufreq: dt: Don't (ab)use
 dev_pm_opp_get_opp_table() to create OPP table
To:     Viresh Kumar <viresh.kumar@linaro.org>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-pm@vger.kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Stephen Boyd <sboyd@kernel.org>, Nishanth Menon <nm@ti.com>,
        digetx@gmail.com, Stephan Gerhold <stephan@gerhold.net>,
        linux-kernel@vger.kernel.org,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
From:   Marek Szyprowski <m.szyprowski@samsung.com>
Message-ID: <525e0552-0faf-44c0-9f74-c651a70bebb6@samsung.com>
Date:   Tue, 10 Nov 2020 07:57:01 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0)
        Gecko/20100101 Thunderbird/78.4.0
MIME-Version: 1.0
In-Reply-To: <20201110060011.7unghpidbzobqhq7@vireshk-i7>
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Brightmail-Tracker: H4sIAAAAAAAAA02SfyyUcRzH973n7rnH6fR1mE/Sj90qY4vIH48yySrP5h//WJutdHiGcsfu
        QdFqUkN+xGoWFzlsamfC7SI/Soku+c2YjD8sazFmfhN3cp6U/16f9+f9+X4+7+1LEbIOkRMV
        o0pg1SpFrJyUCOu/bPSd/uCjCztjeuBO1xXWiOiqhR+IHmoqJuml3HZEz673COjurkERbR6p
        E9KjJd50ZvsqQdetMP4SJl17gWnUTIgZve4xyYyPtJCMYThDyDwx6BBjHG0QMEv6o8FUqMQ3
        ko2NSWLVHn43JNFljc9QfA6+8yLfJEpFK9ZZyIoC7A09uRqxhWX4NQLzmm8WkuzwMoLFijaC
        L5YQ6OoeEXsT77cnSb7xCkHXglnAF/MIhvOmkMVlhyOhOS91hynKHrvB9HfWIhO4QwDZAy4W
        JrEnZM1lkRaWYj+obd3cPUOIT8LnzW2hhR1wOJiWtgjeYwudRVO7uhX2Af2vCTH/5jFomCsm
        eHaEsanS3XsAj4khtbz679WXwNj9UsSzHcwYDWKenWG7cW/gIYLJ3moxX+QgGEorRLzrPIz3
        /iYtaQjsCjVNHrx8EaZXq3dlwDYwOmfLH2EDT+ufE7wshcx0Ge8+BRrjm39rP/UPEvlIrtkX
        TbMvjmZfHM3/vVok1CFHNpFTRrGcl4q97c4plFyiKso9Ik6pRzufq8tsXH6HmrbC2xCmkPyA
        9ONWZZhMpEjikpVtCChCbi8N6Om6LpNGKpJTWHVcmDoxluXa0GFKKHeUni2fvibDUYoE9hbL
        xrPqva6AsnJKRc71UwX+05Gcq0MwLtUuurmsua3cH5AFHOkpbi37OSP+WjVMZtRGHDx+ZaPQ
        SlkgJ0L7gwYGTUiqbb5rDj8eN6YtKTqUcdU6qml+dJ3zcOhT6WorskPeLtwLaTnRaQix39K3
        VKhsVr6V+c8G3gyoH24s9QqKuFwZnHIu0JQWZpALuWiFpxuh5hR/AGK99o1YAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrBIsWRmVeSWpSXmKPExsVy+t/xe7r7LFfFG6y4KGyxccZ6VovVHx8z
        WlzeNYfN4nPvEUaLNz/OMlmcOX2J1eLftY0sFjfmmlh0HPnGbLHxq4cDl0fbAnuPnbPusnts
        WtXJ5nHn2h42jy1X21k8+rasYvQ4fmM7k8fnTXIBHFF6NkX5pSWpChn5xSW2StGGFkZ6hpYW
        ekYmlnqGxuaxVkamSvp2NimpOZllqUX6dgl6GQt3TmYs6BGomD3hL2sD41fuLkZODgkBE4m9
        /x+ydTFycQgJLGWU+HnxKQtEQkbi5LQGVghbWOLPtS42EFtI4C2jxP3WTBBbWCBF4sHTs0D1
        HBwiAloSL2+mgsxhFjjKJPFkz1ImiKFTmSQWfr8JNohNwFCi6y3EIF4BO4kN+3+zg9gsAqoS
        h3//B1ssKpAk8fLCVCaIGkGJkzOfgMU5BSwlNr24C1bPLGAmMW/zQ2YIW15i+9s5ULa4xK0n
        85kmMArNQtI+C0nLLCQts5C0LGBkWcUoklpanJueW2yoV5yYW1yal66XnJ+7iREYq9uO/dy8
        g/HSxuBDjAIcjEo8vAf+LIsXYk0sK67MPcQowcGsJMLrdPZ0nBBvSmJlVWpRfnxRaU5q8SFG
        U6DnJjJLiSbnA9NIXkm8oamhuYWlobmxubGZhZI4b4fAwRghgfTEktTs1NSC1CKYPiYOTqkG
        Ri/HDTc4zzpOvBbGsUzN9NUku4bJocFNLFNerF5ak8MTFhF78yvjvCl5DVtzki/EVUoLnfGd
        Zdu0RCcg4OF7m/y+H09Yjy8qj/xdOVNklu2Okx+4lsUEP8sTfa1W5PpMSdZZ8c9vcW1xfr2n
        9+Idnra6lT19ZjTR1u2lFvfD4pAJ4gWSn3vPK7EUZyQaajEXFScCALue99rrAgAA
X-CMS-MailID: 20201110065702eucas1p2712c2d2220b4ea622468b616d4440349
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20201109124218eucas1p1b8948a9bf2cf107b17b500b1603905e8
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20201109124218eucas1p1b8948a9bf2cf107b17b500b1603905e8
References: <684ff01900180c0a40ec307dacc673b24eab593b.1604643714.git.viresh.kumar@linaro.org>
        <CGME20201109124218eucas1p1b8948a9bf2cf107b17b500b1603905e8@eucas1p1.samsung.com>
        <2924bddd-d237-aa57-abb1-a67723770e97@samsung.com>
        <20201110060011.7unghpidbzobqhq7@vireshk-i7>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Viresh,

On 10.11.2020 07:00, Viresh Kumar wrote:
> On 09-11-20, 13:42, Marek Szyprowski wrote:
>> This patch landed in linux next-20201109 as commit e8f7703f8fe5
>> ("cpufreq: dt: Don't (ab)use dev_pm_opp_get_opp_table() to create OPP
>> table"). Sadly it causes regression on some Samsung Exynos based boards:
>>
>> 8<--- cut here ---
>> Unable to handle kernel paging request at virtual address ffffff37
>> pgd = (ptrval)
>> [ffffff37] *pgd=4ffff841, *pte=00000000, *ppte=00000000
>> Internal error: Oops: 27 [#1] PREEMPT SMP ARM
>> Modules linked in:
>> usb 3-1: New USB device strings: Mfr=1, Product=2, SerialNumber=3
>> CPU: 3 PID: 1 Comm: swapper/0 Not tainted 5.10.0-rc1-00007-ge8f7703f8fe5
>> #1908
>> Hardware name: Samsung Exynos (Flattened Device Tree)
>> PC is at dev_pm_opp_put_regulators+0x8/0xf0
>> LR is at dt_cpufreq_probe+0x19c/0x3fc
> Does this fix it for you ?

Yes, thanks!

Reported-by: Marek Szyprowski <m.szyprowski@samsung.com>

Tested-by: Marek Szyprowski <m.szyprowski@samsung.com>

> diff --git a/drivers/cpufreq/cpufreq-dt.c b/drivers/cpufreq/cpufreq-dt.c
> index 66b3db5efb53..5aa3d4e3140d 100644
> --- a/drivers/cpufreq/cpufreq-dt.c
> +++ b/drivers/cpufreq/cpufreq-dt.c
> @@ -228,7 +228,7 @@ static int dt_cpufreq_early_init(struct device *dev, int cpu)
>                          if (ret != -EPROBE_DEFER)
>                                  dev_err(cpu_dev, "failed to set regulators: %d\n",
>                                          ret);
> -                       goto out;
> +                       goto free_cpumask;
>                  }
>          }
>   
> @@ -293,6 +293,7 @@ static int dt_cpufreq_early_init(struct device *dev, int cpu)
>                  dev_pm_opp_of_cpumask_remove_table(priv->cpus);
>          if (priv->opp_table)
>                  dev_pm_opp_put_regulators(priv->opp_table);
> +free_cpumask:
>          free_cpumask_var(priv->cpus);
>          return ret;
>   }
>
>
Best regards
-- 
Marek Szyprowski, PhD
Samsung R&D Institute Poland

