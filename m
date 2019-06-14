Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 29D5A457DC
	for <lists+linux-pm@lfdr.de>; Fri, 14 Jun 2019 10:50:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726575AbfFNIu1 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 14 Jun 2019 04:50:27 -0400
Received: from mailout1.w1.samsung.com ([210.118.77.11]:42564 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725859AbfFNIu1 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 14 Jun 2019 04:50:27 -0400
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20190614085023euoutp016e0eb883988a5c47565a842894ff5a21~oBIEhee-K0769207692euoutp01D
        for <linux-pm@vger.kernel.org>; Fri, 14 Jun 2019 08:50:23 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20190614085023euoutp016e0eb883988a5c47565a842894ff5a21~oBIEhee-K0769207692euoutp01D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1560502223;
        bh=iw69xWGrEDzd6kQc72slduKlGfkg0GvEU2aINsokIJQ=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=NO5yUNM123Pav9iRsVsSKEraOyoEOFxXNezV/KMhGuYNwn/QPgwdus/DtErn/DRpl
         oFCbzxqKu/zr5I1iKWSBItiNVv6R5LTKzbw0NB5eZYMnQX2VxgibxBjqJSZdOuShai
         3pTnftbj3QY+/D42vF4hmxxD9WOJ5GrG0v827aEA=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20190614085022eucas1p2f8426082971818ceae9b91cfc40c5b9b~oBIDlwqzf1418714187eucas1p28;
        Fri, 14 Jun 2019 08:50:22 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges2new.samsung.com (EUCPMTA) with SMTP id 3A.F6.04377.ECF530D5; Fri, 14
        Jun 2019 09:50:22 +0100 (BST)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20190614085021eucas1p2ab5681c242a14f22e3bc7494a5884f75~oBICw_zlV2692926929eucas1p2H;
        Fri, 14 Jun 2019 08:50:21 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20190614085021eusmtrp29828bbdae6956daecb6f35f1e7b2fb34~oBIChGDRi1742017420eusmtrp2Y;
        Fri, 14 Jun 2019 08:50:21 +0000 (GMT)
X-AuditID: cbfec7f4-113ff70000001119-60-5d035fce040b
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id 54.21.04140.DCF530D5; Fri, 14
        Jun 2019 09:50:21 +0100 (BST)
Received: from [106.120.51.20] (unknown [106.120.51.20]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20190614085020eusmtip1fbf314d3e6b1e736d0c82b2803a6ce61~oBIBqRJkp1761917619eusmtip1I;
        Fri, 14 Jun 2019 08:50:20 +0000 (GMT)
Subject: Re: [PATCH v9 08/13] drivers: memory: add DMC driver for Exynos5422
To:     Krzysztof Kozlowski <krzk@kernel.org>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org,
        "linux-samsung-soc@vger.kernel.org" 
        <linux-samsung-soc@vger.kernel.org>, linux-clk@vger.kernel.org,
        mturquette@baylibre.com, sboyd@kernel.org,
        =?UTF-8?Q?Bart=c5=82omiej_=c5=bbo=c5=82nierkiewicz?= 
        <b.zolnierkie@samsung.com>, kgene@kernel.org,
        Chanwoo Choi <cw00.choi@samsung.com>,
        kyungmin.park@samsung.com,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        s.nawrocki@samsung.com, myungjoo.ham@samsung.com,
        keescook@chromium.org, tony@atomide.com, jroedel@suse.de,
        treding@nvidia.com, digetx@gmail.com, gregkh@linuxfoundation.org,
        willy.mh.wolff.ml@gmail.com
From:   Lukasz Luba <l.luba@partner.samsung.com>
Message-ID: <4a88b188-eee9-2a16-82cf-ead94a3c24da@partner.samsung.com>
Date:   Fri, 14 Jun 2019 10:50:18 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
        Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <CAJKOXPdKGG25T46d+SmES7wyQ=kAMj2jdT3GCYa+z87wpYKNEQ@mail.gmail.com>
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA02Se0hTYRjG+3aujrZO87KXioJFokbrQsGXXejOSSrqjygysaUnjdyynbTs
        QiuzMjNr3WxpSxSsZS0vmZuloday0imFllKU2l27uZTo6jxG/vfwPL/vfd8HPpZQpdAj2I2G
        rYLRoIvT0HKy9O5394T6SCJiUknvMFyYaadws+cNha019RS+/KUd4eRcO41P3M+W4YdpepzR
        /oHAbvc1Btft62TwlyPPKfzImUXj7vQahDPdFTJ8peYZgxvvL8Stey/SuLrzIIV/NxWSuPJx
        GG79ocQ999rQnAC+55uZ5D89SWH4c6ZGkndYnjF8kS2V5iuzCxg+PfkjzR8tsSG++MFOvrto
        9HL5GvnMaCFuY6JgnDh7nTzWYVHGH5i1vfhaIW1CdSGHkQ8L3FTIMucRh5GcVXEXEbSZDiFv
        oOI8CMxNtBR0I0g+foX49yLzayolQfkIXE9jJagLwTtbA+0NfLklkFfazHi1HxcMzb96KS9E
        cKcouNlb3wexLM1pocy2xcsouEWQUpDWP5TkxkHq3aekV/tzq8HjKEISMxxqz3b0+z7cCnA4
        y/vnE5waWjqsMkmPgRtdWQOH3mah/rRe0gugp/KmTNK+8N5Vwkh6FPxxWAd8EUzpOUjSu6A9
        I3uAmQHVrkbKezLR18XunCjZc+FVRQbptYFTwpOu4dIFSjCXniEkWwGHDqgkOghKjjQMLAqA
        /ILTzDGksQzqZRnUxTKoi+X/3guItCG1kCDqYwRxikHYphV1ejHBEKON2qwvQn2f88Fvl6cM
        OX+ur0IcizRDFbdDZREqSpcoJumrELCExk9xfgYRoVJE65J2CMbNkcaEOEGsQiNZUqNW7Bzy
        IlzFxei2CpsEIV4w/ktlrM8IE9JOGJ+0b3y4JTB5rTHtpb0hAKnLl1Z82xM27k+8MsC42C90
        oWXDu+7J21tiPK7Pi6zV2ulXrzuWhapPtqmU1lXzo9Aa+cOOU7ecfu6V/mN3mfYHx9cO4fa+
        fx3WqX9rjmu6lJubGDJ3WuDu8I/RyqY7hW3Pc4IMduJgXeSJ8sR5l0UNKcbqJocQRlH3F5YJ
        bSuYAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprNKsWRmVeSWpSXmKPExsVy+t/xu7pn45ljDRbvFrHYOGM9q8X1L89Z
        LeYfOcdqsfrjY0aL5sXr2Swmn5rLZHGmO9ei//FrZovz5zewW5xtesNu8bHnHqvF5V1z2Cw+
        9x5htJhxfh+Txdojd9ktLp5ytbjduILN4vCbdlaLf9c2sljsv+Jlcfs3n8W3E48YHcQ8vn2d
        xOLx/kYru8fshossHjtn3WX32LSqk81j/9w17B69ze/YPPq2rGL02Hy62uPzJrkArig9m6L8
        0pJUhYz84hJbpWhDCyM9Q0sLPSMTSz1DY/NYKyNTJX07m5TUnMyy1CJ9uwS9jJ2z+ArabCs2
        b9jI1sB4VquLkZNDQsBEYsanTtYuRi4OIYGljBK73yxghkiISUzat50dwhaW+HOtiw2i6DWj
        xKuXZ8GKhAV8JJZsuw5WJCKgKXH973ewScwCU1klJjw/DZYQEpjAJHHrLE8XIwcHm4CexI5V
        hSBhXgE3idY13awgNouAqkTnsZssILaoQITE7F0NLBA1ghInZz4BszkFAiV27toNNpJZwExi
        3uaHzBC2uMStJ/OZIGx5ie1v5zBPYBSahaR9FpKWWUhaZiFpWcDIsopRJLW0ODc9t9hIrzgx
        t7g0L10vOT93EyMwYWw79nPLDsaud8GHGAU4GJV4eA9YMcUKsSaWFVfmHmKU4GBWEuGdZ80c
        K8SbklhZlVqUH19UmpNafIjRFOi5icxSosn5wGSWVxJvaGpobmFpaG5sbmxmoSTO2yFwMEZI
        ID2xJDU7NbUgtQimj4mDU6qBsXbCyY+9ex5GR39gLGB4Xzuhvp6Ll8nfZ9LtoP/9dxIlzUOD
        X9rfSfvD7mOTu2CaQ4/ky0/dUdELuR2MFpmdjIlNqDpS7LdSLq9JyMVee/E/AU6LY+FObZNO
        CE7x03sU5mDgpMmp+mRqQEBT6tHvTWeCnu5o1LmnprhWZlnHzJhqq38fao4rsRRnJBpqMRcV
        JwIAnQ4s0y4DAAA=
X-CMS-MailID: 20190614085021eucas1p2ab5681c242a14f22e3bc7494a5884f75
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20190607143531eucas1p11f6b3a63068d529dae8be16abaa60ed0
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20190607143531eucas1p11f6b3a63068d529dae8be16abaa60ed0
References: <CGME20190607143531eucas1p11f6b3a63068d529dae8be16abaa60ed0@eucas1p1.samsung.com>
        <20190607143507.30286-1-l.luba@partner.samsung.com>
        <20190607143507.30286-9-l.luba@partner.samsung.com>
        <CAJKOXPdKGG25T46d+SmES7wyQ=kAMj2jdT3GCYa+z87wpYKNEQ@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Krzysztof,

On 6/11/19 8:18 AM, Krzysztof Kozlowski wrote:
> On Fri, 7 Jun 2019 at 16:35, Lukasz Luba <l.luba@partner.samsung.com> wrote:
>>
>> This patch adds driver for Exynos5422 Dynamic Memory Controller.
>> The driver provides support for dynamic frequency and voltage scaling for
>> DMC and DRAM. It supports changing timings of DRAM running with different
>> frequency. There is also an algorithm to calculate timigns based on
>> memory description provided in DT.
>> The patch also contains needed MAINTAINERS file update.
>>
>> Signed-off-by: Lukasz Luba <l.luba@partner.samsung.com>
>> ---
>>   MAINTAINERS                             |    8 +
>>   drivers/memory/samsung/Kconfig          |   17 +
>>   drivers/memory/samsung/Makefile         |    1 +
>>   drivers/memory/samsung/exynos5422-dmc.c | 1261 +++++++++++++++++++++++
>>   4 files changed, 1287 insertions(+)
>>   create mode 100644 drivers/memory/samsung/exynos5422-dmc.c
> 
> (...)
> 
>> +
>> +/**
>> + * exynos5_performance_counters_init() - Initializes performance DMC's counters
>> + * @dmc:       DMC for which it does the setup
>> + *
>> + * Initialization of performance counters in DMC for estimating usage.
>> + * The counter's values are used for calculation of a memory bandwidth and based
>> + * on that the governor changes the frequency.
>> + * The counters are not used when the governor is GOVERNOR_USERSPACE.
>> + */
>> +static int exynos5_performance_counters_init(struct exynos5_dmc *dmc)
>> +{
>> +       int counters_size;
>> +       int ret, i;
>> +
>> +       dmc->num_counters = devfreq_event_get_edev_count(dmc->dev);
>> +       if (dmc->num_counters < 0) {
>> +               dev_err(dmc->dev, "could not get devfreq-event counters\n");
>> +               return dmc->num_counters;
>> +       }
>> +
>> +       counters_size = sizeof(struct devfreq_event_dev) * dmc->num_counters;
>> +       dmc->counter = devm_kzalloc(dmc->dev, counters_size, GFP_KERNEL);
>> +       if (!dmc->counter)
>> +               return -ENOMEM;
>> +
>> +       for (i = 0; i < dmc->num_counters; i++) {
>> +               dmc->counter[i] =
>> +                       devfreq_event_get_edev_by_phandle(dmc->dev, i);
>> +               if (IS_ERR_OR_NULL(dmc->counter[i]))
>> +                       return -EPROBE_DEFER;
>> +       }
>> +
>> +       ret = exynos5_counters_enable_edev(dmc);
>> +       if (ret < 0) {
>> +               dev_err(dmc->dev, "could not enable event counter\n");
>> +               return ret;
>> +       }
>> +
>> +       ret = exynos5_counters_set_event(dmc);
>> +       if (ret < 0) {
>> +               dev_err(dmc->dev, "counld not set event counter\n");
> 
> Missing cleanup - edev counters disable.
right
> 
>> +               return ret;
>> +       }
>> +
>> +       return 0;
>> +}
>> +
>> +/**
>> + * exynos5_dmc_set_pause_on_switching() - Controls a pause feature in DMC
>> + * @dmc:       device which is used for changing this feature
>> + * @set:       a boolean state passing enable/disable request
>> + *
>> + * There is a need of pausing DREX DMC when divider or MUX in clock tree
>> + * changes its configuration. In such situation access to the memory is blocked
>> + * in DMC automatically. This feature is used when clock frequency change
>> + * request appears and touches clock tree.
>> + */
>> +static inline int exynos5_dmc_set_pause_on_switching(struct exynos5_dmc *dmc)
>> +{
>> +       unsigned int val;
>> +       int ret;
>> +
>> +       ret = regmap_read(dmc->clk_regmap, CDREX_PAUSE, &val);
>> +       if (ret)
>> +               return ret;
>> +
>> +       val |= 1UL;
>> +       regmap_write(dmc->clk_regmap, CDREX_PAUSE, val);
>> +
>> +       return 0;
>> +}
>> +
>> +/**
>> + * exynos5_dmc_probe() - Probe function for the DMC driver
>> + * @pdev:      platform device for which the driver is going to be initialized
>> + *
>> + * Initialize basic components: clocks, regulators, performance counters, etc.
>> + * Read out product version and based on the information setup
>> + * internal structures for the controller (frequency and voltage) and for DRAM
>> + * memory parameters: timings for each operating frequency.
>> + * Register new devfreq device for controlling DVFS of the DMC.
>> + */
>> +static int exynos5_dmc_probe(struct platform_device *pdev)
>> +{
>> +       int ret = 0;
>> +       struct device *dev = &pdev->dev;
>> +       struct device_node *np = dev->of_node;
>> +       struct exynos5_dmc *dmc;
>> +       struct resource *res;
>> +
>> +       dmc = devm_kzalloc(dev, sizeof(*dmc), GFP_KERNEL);
>> +       if (!dmc)
>> +               return -ENOMEM;
>> +
>> +       mutex_init(&dmc->lock);
>> +
>> +       dmc->dev = dev;
>> +       platform_set_drvdata(pdev, dmc);
>> +
>> +       res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
>> +       dmc->base_drexi0 = devm_ioremap_resource(dev, res);
>> +       if (IS_ERR(dmc->base_drexi0))
>> +               return PTR_ERR(dmc->base_drexi0);
>> +
>> +       res = platform_get_resource(pdev, IORESOURCE_MEM, 1);
>> +       dmc->base_drexi1 = devm_ioremap_resource(dev, res);
>> +       if (IS_ERR(dmc->base_drexi1))
>> +               return PTR_ERR(dmc->base_drexi1);
>> +
>> +       dmc->clk_regmap = syscon_regmap_lookup_by_phandle(np,
>> +                               "samsung,syscon-clk");
>> +       if (IS_ERR(dmc->clk_regmap))
>> +               return PTR_ERR(dmc->clk_regmap);
>> +
>> +       ret = exynos5_init_freq_table(dmc, &exynos5_dmc_df_profile);
>> +       if (ret) {
>> +               dev_warn(dev, "couldn't initialize frequency settings\n");
>> +               return ret;
>> +       }
>> +
>> +       dmc->vdd_mif = devm_regulator_get(dev, "vdd");
>> +       if (IS_ERR(dmc->vdd_mif)) {
>> +               ret = PTR_ERR(dmc->vdd_mif);
>> +               return ret;
>> +       }
>> +
>> +       ret = exynos5_dmc_init_clks(dmc);
>> +       if (ret)
>> +               return ret;
>> +
>> +       ret = of_get_dram_timings(dmc);
>> +       if (ret) {
>> +               dev_warn(dev, "couldn't initialize timings settings\n");
> 
> goto remove_clocks;
OK
> 
>> +               return ret;
>> +       }
>> +
>> +       ret = exynos5_performance_counters_init(dmc);
>> +       if (ret) {
>> +               dev_warn(dev, "couldn't probe performance counters\n");
>> +               goto remove_clocks;
>> +       }
>> +
>> +       ret = exynos5_dmc_set_pause_on_switching(dmc);
>> +       if (ret) {
>> +               dev_warn(dev, "couldn't get access to PAUSE register\n");
>> +               goto remove_clocks;
> 
> goto err_devfreq_add;
Agree.

Thank you for the review.

Regards,
Lukasz

> Best regards,
> Krzysztof
> 
>> +       }
>> +
>> +       /*
>> +        * Setup default thresholds for the devfreq governor.
>> +        * The values are chosen based on experiments.
>> +        */
>> +       dmc->gov_data.upthreshold = 30;
>> +       dmc->gov_data.downdifferential = 5;
>> +
>> +       dmc->df = devm_devfreq_add_device(dev, &exynos5_dmc_df_profile,
>> +                                         DEVFREQ_GOV_USERSPACE,
>> +                                         &dmc->gov_data);
>> +
>> +       if (IS_ERR(dmc->df)) {
>> +               ret = PTR_ERR(dmc->df);
>> +               goto err_devfreq_add;
>> +       }
>> +
>> +       dev_info(dev, "DMC initialized\n");
>> +
>> +       return 0;
>> +
>> +err_devfreq_add:
>> +       exynos5_counters_disable_edev(dmc);
>> +remove_clocks:
>> +       clk_disable_unprepare(dmc->mout_bpll);
>> +       clk_disable_unprepare(dmc->fout_bpll);
>> +
>> +       return ret;
>> +}
>> +
>>
> 
> 
