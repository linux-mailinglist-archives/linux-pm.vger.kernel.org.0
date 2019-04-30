Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EEA4EF154
	for <lists+linux-pm@lfdr.de>; Tue, 30 Apr 2019 09:33:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725938AbfD3HdX (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 30 Apr 2019 03:33:23 -0400
Received: from mailout2.samsung.com ([203.254.224.25]:25672 "EHLO
        mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726119AbfD3HdX (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 30 Apr 2019 03:33:23 -0400
Received: from epcas1p1.samsung.com (unknown [182.195.41.45])
        by mailout2.samsung.com (KnoxPortal) with ESMTP id 20190430073319epoutp0247272fef64b8dfbb5108d7871c2e86c1~aMC7vMTAo1098510985epoutp02C
        for <linux-pm@vger.kernel.org>; Tue, 30 Apr 2019 07:33:19 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20190430073319epoutp0247272fef64b8dfbb5108d7871c2e86c1~aMC7vMTAo1098510985epoutp02C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1556609599;
        bh=e34k/yVofLPdOOX6XLtJ1nlpeN11FL4odbRWUg/xKsE=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=C09iPBFtB/qBwwP9DqEKJ9SudDeEv6GjWNtohAVKHpEJ6GVl5nnPWW6ahJM7Aa4bZ
         XWpp4yeG0/tVgtlLp1OuEfRhafgUMbR4TGRnT1KC2KPKtRMux5cTV9J4wY1SpuffcU
         lldQbZrGFkFF2BmkCiyvnZEff4rta+W4z3fSHzdI=
Received: from epsmges1p5.samsung.com (unknown [182.195.40.153]) by
        epcas1p1.samsung.com (KnoxPortal) with ESMTP id
        20190430073316epcas1p115013adba89d57243ab2883855e9a86e~aMC4oH7Ue1033710337epcas1p13;
        Tue, 30 Apr 2019 07:33:16 +0000 (GMT)
Received: from epcas1p1.samsung.com ( [182.195.41.45]) by
        epsmges1p5.samsung.com (Symantec Messaging Gateway) with SMTP id
        32.37.04108.B3AF7CC5; Tue, 30 Apr 2019 16:33:15 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas1p3.samsung.com (KnoxPortal) with ESMTPA id
        20190430073315epcas1p362e81786c257ddeace6be27afa1332fd~aMC38Hk5a0610506105epcas1p3E;
        Tue, 30 Apr 2019 07:33:15 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20190430073315epsmtrp23a1daa0b667fdf7f0025e5ccb8be04fe~aMC37Mfwh2858628586epsmtrp2K;
        Tue, 30 Apr 2019 07:33:15 +0000 (GMT)
X-AuditID: b6c32a39-d0c179c00000100c-71-5cc7fa3b2f53
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        26.EA.03692.B3AF7CC5; Tue, 30 Apr 2019 16:33:15 +0900 (KST)
Received: from [10.113.221.102] (unknown [10.113.221.102]) by
        epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20190430073314epsmtip1c91c030ccb46c91972456cba60effb23~aMC3p85_71626316263epsmtip1V;
        Tue, 30 Apr 2019 07:33:14 +0000 (GMT)
Subject: Re: [PATCH v3 2/4] drivers: devfreq: events: extend events by type
 of counted data
To:     Lukasz Luba <l.luba@partner.samsung.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-samsung-soc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Cc:     b.zolnierkie@samsung.com, krzk@kernel.org, robh+dt@kernel.org,
        mark.rutland@arm.com, kyungmin.park@samsung.com,
        m.szyprowski@samsung.com, s.nawrocki@samsung.com,
        myungjoo.ham@samsung.com, kgene@kernel.org,
        willy.mh.wolff.ml@gmail.com
From:   Chanwoo Choi <cw00.choi@samsung.com>
Organization: Samsung Electronics
Message-ID: <3557d507-0463-89de-4025-fbeaaef78bed@samsung.com>
Date:   Tue, 30 Apr 2019 16:34:30 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
        Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <1555681688-19643-3-git-send-email-l.luba@partner.samsung.com>
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrNJsWRmVeSWpSXmKPExsWy7bCmrq71r+MxBt8+m1lsnLGe1WL+kXOs
        Fv2PXzNbnD+/gd3ibNMbdotbDTIWmx5fY7W4vGsOm8Xn3iOMFjPO72OyWHvkLrvF0usXmSxu
        N65gs2jde4Td4vCbdlaLbyceMToIeKyZt4bRY+esu+wem1Z1snlsXlLvcfDdHiaPvi2rGD0+
        b5ILYI/KtslITUxJLVJIzUvOT8nMS7dV8g6Od443NTMw1DW0tDBXUshLzE21VXLxCdB1y8wB
        ul1JoSwxpxQoFJBYXKykb2dTlF9akqqQkV9cYquUWpCSU2BZoFecmFtcmpeul5yfa2VoYGBk
        ClSYkJ3xZEcbY8Em84qmSdvZGhi3aXQxcnJICJhINH59y9TFyMUhJLCDUWLhvg9sEM4nRol7
        PYtZIJxvjBJ/1u5kgWn5e7+NGcQWEtjLKLH5oyxE0XtGiQk7PrOCJIQFYiVuTZjGCpIQETjL
        KPGgaRvYXGaBz4wSJx9cA6tiE9CS2P/iBhuIzS+gKHH1x2NGEJtXwE7iwpHfQDUcHCwCqhJb
        nruAhEUFIiTuH9vAClEiKHFy5hOwizgFvCWmv+4CG8MsIC5x68l8JghbXqJ562xmkL0SAsfY
        JZ782swM8YKLRE9zIyuELSzx6vgWdghbSuLzu71sEHa1xMqTR9ggmjsYJbbsvwDVYCyxf+lk
        JpDjmAU0Jdbv0odYxifx7msP2M0SArwSHW1CENXKEpcf3GWCsCUlFrd3Qo33kJh1egnTBEbF
        WUjemYXkhVlIXpiFsGwBI8sqRrHUguLc9NRiwwJT5OjexAhO2FqWOxiPnfM5xCjAwajEw+vx
        7liMEGtiWXFl7iFGCQ5mJRFej+NHY4R4UxIrq1KL8uOLSnNSiw8xmgIDeyKzlGhyPjCb5JXE
        G5oaGRsbW5gYmpkaGiqJ8653cI4REkhPLEnNTk0tSC2C6WPi4JRqYHRLu7ZHIcS+YV8ff6Dg
        tsvPCgsfaGVfkDnfqaQ2c77Voq6mzC0v+z/Lqa/zObgjeWP4o92zXJ4WM52+JNbKVJycPMHq
        Au/8KxMu8xzTv69/rHFT09Luvl+KXgxKGwtn6+kuYjQX2PpOYp5WppHARu+3bPMWpzH3LW3b
        p1DM8cTirEr8yr5Tm5VYijMSDbWYi4oTASvwA0DuAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrGIsWRmVeSWpSXmKPExsWy7bCSnK71r+MxBlMWc1hsnLGe1WL+kXOs
        Fv2PXzNbnD+/gd3ibNMbdotbDTIWmx5fY7W4vGsOm8Xn3iOMFjPO72OyWHvkLrvF0usXmSxu
        N65gs2jde4Td4vCbdlaLbyceMToIeKyZt4bRY+esu+wem1Z1snlsXlLvcfDdHiaPvi2rGD0+
        b5ILYI/isklJzcksSy3St0vgyniyo42xYJN5RdOk7WwNjNs0uhg5OSQETCT+3m9j7mLk4hAS
        2M0osXnBcnaIhKTEtItHgRIcQLawxOHDxRA1bxklrtycwAZSIywQKzF/8T5GkISIwFlGiUWT
        FrCDOMwCnxklpq+5DDX2PqPEo2ftTCAtbAJaEvtf3ABr5xdQlLj64zEjiM0rYCdx4chvVpB1
        LAKqElueu4CERQUiJM68X8ECUSIocXLmEzCbU8BbYvrrLrAxzALqEn/mXWKGsMUlbj2ZzwRh
        y0s0b53NPIFReBaS9llIWmYhaZmFpGUBI8sqRsnUguLc9NxiwwLDvNRyveLE3OLSvHS95Pzc
        TYzg2NXS3MF4eUn8IUYBDkYlHl6Pd8dihFgTy4orcw8xSnAwK4nwehw/GiPEm5JYWZValB9f
        VJqTWnyIUZqDRUmc92nesUghgfTEktTs1NSC1CKYLBMHp1QDo7/77AWrLefJL88Q/P5VKPlu
        QOAN5ycu79L6ly6cxn1vbdBF27oLDdqCRuzzPVy3nZnziNPHWEqDqUFOqJe/SuhHqNRpKYdP
        l2+vsPrx6GaM3ZfZix1cjhdnZaydeXXTtNUBc16+zJyz4YdVBc93jpB/mYuyLu+9+77uqK4r
        846dST+ftC1fb67EUpyRaKjFXFScCABR6hro2QIAAA==
X-CMS-MailID: 20190430073315epcas1p362e81786c257ddeace6be27afa1332fd
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20190419134821eucas1p2461a27e28387ff2b87c149f09582d2a0
References: <1555681688-19643-1-git-send-email-l.luba@partner.samsung.com>
        <CGME20190419134821eucas1p2461a27e28387ff2b87c149f09582d2a0@eucas1p2.samsung.com>
        <1555681688-19643-3-git-send-email-l.luba@partner.samsung.com>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Lukasz,

On 19. 4. 19. 오후 10:48, Lukasz Luba wrote:
> This patch adds posibility to choose what type of data should be counted
> by the PPMU counter. Now the type comes from DT where the event has been
> defined. When there is no 'event-data-type' the default value is used,
> which is 'read data in bytes'.
> It is needed when you want to know not only read+write data bytes but
> i.e. only write data in byte, or number of read requests, etc.
> 
> Signed-off-by: Lukasz Luba <l.luba@partner.samsung.com>
> ---
>  drivers/devfreq/event/exynos-ppmu.c | 61 +++++++++++++++++++++++++------------
>  include/linux/devfreq-event.h       |  6 ++++
>  2 files changed, 48 insertions(+), 19 deletions(-)
> 
> diff --git a/drivers/devfreq/event/exynos-ppmu.c b/drivers/devfreq/event/exynos-ppmu.c
> index c61de0b..073bf2c 100644
> --- a/drivers/devfreq/event/exynos-ppmu.c
> +++ b/drivers/devfreq/event/exynos-ppmu.c
> @@ -154,9 +154,9 @@ static int exynos_ppmu_set_event(struct devfreq_event_dev *edev)
>  	if (ret < 0)
>  		return ret;
>  
> -	/* Set the event of Read/Write data count  */
> +	/* Set the event of proper data type monitoring */
>  	ret = regmap_write(info->regmap, PPMU_BEVTxSEL(id),
> -				PPMU_RO_DATA_CNT | PPMU_WO_DATA_CNT);
> +			   edev->desc->data_type);
>  	if (ret < 0)
>  		return ret;
>  
> @@ -368,23 +368,11 @@ static int exynos_ppmu_v2_set_event(struct devfreq_event_dev *edev)
>  	if (ret < 0)
>  		return ret;
>  
> -	/* Set the event of Read/Write data count  */
> -	switch (id) {
> -	case PPMU_PMNCNT0:
> -	case PPMU_PMNCNT1:
> -	case PPMU_PMNCNT2:
> -		ret = regmap_write(info->regmap, PPMU_V2_CH_EVx_TYPE(id),
> -				PPMU_V2_RO_DATA_CNT | PPMU_V2_WO_DATA_CNT);
> -		if (ret < 0)
> -			return ret;
> -		break;
> -	case PPMU_PMNCNT3:
> -		ret = regmap_write(info->regmap, PPMU_V2_CH_EVx_TYPE(id),
> -				PPMU_V2_EVT3_RW_DATA_CNT);
> -		if (ret < 0)
> -			return ret;
> -		break;
> -	}
> +	/* Set the event of proper data type monitoring */
> +	ret = regmap_write(info->regmap, PPMU_V2_CH_EVx_TYPE(id),
> +			   edev->desc->data_type);
> +	if (ret < 0)
> +		return ret;
>  
>  	/* Reset cycle counter/performance counter and enable PPMU */
>  	ret = regmap_read(info->regmap, PPMU_V2_PMNC, &pmnc);
> @@ -508,6 +496,7 @@ static int of_get_devfreq_events(struct device_node *np,
>  	struct device *dev = info->dev;
>  	struct device_node *events_np, *node;
>  	int i, j, count;
> +	int ret;
>  
>  	events_np = of_get_child_by_name(np, "events");
>  	if (!events_np) {
> @@ -544,6 +533,40 @@ static int of_get_devfreq_events(struct device_node *np,
>  		desc[j].driver_data = info;
>  
>  		of_property_read_string(node, "event-name", &desc[j].name);
> +		ret = of_property_read_u32(node, "event-data-type",
> +					   &desc[j].data_type);
> +		if (ret) {
> +			/* Set the event of proper data type counting.
> +			 * Check if the data type has been defined in DT,
> +			 * use default if not.
> +			 */
> +			if (of_device_is_compatible(np,
> +					"samsung,exynos-ppmu-v2")) {

It is not proper to compare the compatible string again
in the device driver. Instead, you can define the ppmu device type
as following and then use 'struct of_device_id' in order to
identify the device type.

	enum exynos_ppmu_type {
		EXYNOS_TYPE_PPMU,
		EXYNOS_TYPE_PPMU_V2,
	};

 static const struct of_device_id exynos_ppmu_id_match[] = {
        {
                .compatible = "samsung,exynos-ppmu",
-               .data = (void *)&exynos_ppmu_ops,
+               .data = (void *)EXYNOS_TYPE_PPMU,
        }, {
                .compatible = "samsung,exynos-ppmu-v2",
-               .data = (void *)&exynos_ppmu_v2_ops,
+               .data = (void *)EXYNOS_TYPE_PPMU_V2,
        },


The many device drivers in the mainline uses this code
in order to get the device type. You can refer the example
in the drivers/mfd/max14577.c.

(snip)


Example, I add the example. but it is not tested. 

--- a/drivers/devfreq/event/exynos-ppmu.c
+++ b/drivers/devfreq/event/exynos-ppmu.c
@@ -16,6 +16,7 @@
 #include <linux/kernel.h>
 #include <linux/module.h>
 #include <linux/of_address.h>
+#include <linux/of_device.h>
 #include <linux/platform_device.h>
 #include <linux/regmap.h>
 #include <linux/suspend.h>
@@ -23,6 +24,11 @@
 
 #include "exynos-ppmu.h"
 
+enum exynos_ppmu_type {
+       EXYNOS_TYPE_PPMU,
+       EXYNOS_TYPE_PPMU_V2,
+};
+
 struct exynos_ppmu_data {
        struct clk *clk;
 };
@@ -36,6 +42,7 @@ struct exynos_ppmu {
        struct regmap *regmap;
 
        struct exynos_ppmu_data ppmu;
+       enum exynos_ppmu_type ppmu_type;
 };
 
 #define PPMU_EVENT(name)                       \
 
        /* Reset cycle counter/performance counter and enable PPMU */
        ret = regmap_read(info->regmap, PPMU_V2_PMNC, &pmnc);
@@ -483,31 +476,23 @@ static const struct devfreq_event_ops exynos_ppmu_v2_ops = {
 static const struct of_device_id exynos_ppmu_id_match[] = {
        {
                .compatible = "samsung,exynos-ppmu",
-               .data = (void *)&exynos_ppmu_ops,
+               .data = (void *)EXYNOS_TYPE_PPMU,
        }, {
                .compatible = "samsung,exynos-ppmu-v2",
-               .data = (void *)&exynos_ppmu_v2_ops,
+               .data = (void *)EXYNOS_TYPE_PPMU_V2,
        },
        { /* sentinel */ },
 };
 MODULE_DEVICE_TABLE(of, exynos_ppmu_id_match);
 
-static struct devfreq_event_ops *exynos_bus_get_ops(struct device_node *np)
-{
-       const struct of_device_id *match;
-
-       match = of_match_node(exynos_ppmu_id_match, np);
-       return (struct devfreq_event_ops *)match->data;
-}
-
 static int of_get_devfreq_events(struct device_node *np,
                                 struct exynos_ppmu *info)
 {
        struct devfreq_event_desc *desc;
-       struct devfreq_event_ops *event_ops;
        struct device *dev = info->dev;
        struct device_node *events_np, *node;
        int i, j, count;
 
        events_np = of_get_child_by_name(np, "events");
        if (!events_np) {
@@ -515,7 +500,6 @@ static int of_get_devfreq_events(struct device_node *np,
                        "failed to get child node of devfreq-event devices\n");
                return -EINVAL;
        }
-       event_ops = exynos_bus_get_ops(np);
 
        count = of_get_child_count(events_np);
        desc = devm_kcalloc(dev, count, sizeof(*desc), GFP_KERNEL);
@@ -540,11 +524,38 @@ static int of_get_devfreq_events(struct device_node *np,
                        continue;
                }
 
-               desc[j].ops = event_ops;
+               switch (info->ppmu_type) {
+               case EXYNOS_TYPE_PPMU:
+                       desc[j].ops = &exynos_ppmu_ops;
+                       break;
+               case EXYNOS_TYPE_PPMU_V2:
+                       desc[j].ops = &exynos_ppmu_v2_ops;
+                       break;
+               }
+


-- 
Best Regards,
Chanwoo Choi
Samsung Electronics
