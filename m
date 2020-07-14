Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0130B21EA73
	for <lists+linux-pm@lfdr.de>; Tue, 14 Jul 2020 09:42:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726450AbgGNHmJ (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 14 Jul 2020 03:42:09 -0400
Received: from mailout1.w1.samsung.com ([210.118.77.11]:42696 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725821AbgGNHmI (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 14 Jul 2020 03:42:08 -0400
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20200714074206euoutp01982b12c03d6265482ddc572cb50c0685~hjpgTB2QZ3055630556euoutp01f
        for <linux-pm@vger.kernel.org>; Tue, 14 Jul 2020 07:42:06 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20200714074206euoutp01982b12c03d6265482ddc572cb50c0685~hjpgTB2QZ3055630556euoutp01f
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1594712526;
        bh=y+ZhhNn1wQp4ZmdBdTKuuKIZtB5kY5SMp0XXF2kRDdc=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=mpm6h+YPWtBwWRbG/P/p+PWC025kqKzQbRlQDI05xze46LfUJHMnpRJ/7+WRavKs4
         Yd8no+u4mNBgohS3F1SsgwARjIeQcLhEipm3tkyQFCvwzluUhgPP3jV/WWtPYmskOw
         c4v8rd//6PqyWAJT4fbhYqNAgfPOThctt48UGHFU=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20200714074206eucas1p1fb143778d8f74c8194a76244d671d3dc~hjpf3ywWJ1881818818eucas1p1x;
        Tue, 14 Jul 2020 07:42:06 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges2new.samsung.com (EUCPMTA) with SMTP id 48.1C.05997.EC16D0F5; Tue, 14
        Jul 2020 08:42:06 +0100 (BST)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20200714074206eucas1p29046b2f20810b8cbbfb4bc04a1ed603a~hjpflSqS31637716377eucas1p2K;
        Tue, 14 Jul 2020 07:42:06 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20200714074206eusmtrp20b47ce0fc6167d9723fb0c7b7a09a586~hjpfkdKAG2603726037eusmtrp2d;
        Tue, 14 Jul 2020 07:42:06 +0000 (GMT)
X-AuditID: cbfec7f4-65dff7000000176d-c8-5f0d61cebeba
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id 88.EE.06017.EC16D0F5; Tue, 14
        Jul 2020 08:42:06 +0100 (BST)
Received: from [106.120.51.71] (unknown [106.120.51.71]) by
        eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20200714074205eusmtip2be77319dfa565188d67ac4e705add0a1~hjpe-MF4h1609116091eusmtip2y;
        Tue, 14 Jul 2020 07:42:05 +0000 (GMT)
Subject: Re: [PATCH v2 2/2] memory: samsung: exynos5422-dmc: Add module
 param to control IRQ mode
To:     Lukasz Luba <lukasz.luba@arm.com>
Cc:     linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, willy.mh.wolff.ml@gmail.com,
        k.konieczny@samsung.com, cw00.choi@samsung.com, krzk@kernel.org,
        chanwoo@kernel.org, myungjoo.ham@samsung.com,
        kyungmin.park@samsung.com, s.nawrocki@samsung.com, kgene@kernel.org
From:   Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Message-ID: <1a389137-cab5-124a-e198-8be3bc2ca841@samsung.com>
Date:   Tue, 14 Jul 2020 09:42:05 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
        Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20200710191122.11029-3-lukasz.luba@arm.com>
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrEKsWRmVeSWpSXmKPExsWy7djPc7rnEnnjDT6tFreYeOMKi8X1L89Z
        LRZ8msFq0f/4NbPF+fMb2C3ONr1ht9j0+BqrxeVdc9gsPvceYbSYcX4fk8XCphZ2i9uNK9gs
        Dr9pZ7X4duIRowOfx5p5axg9ds66y+6xaVUnm8fmJfUefVtWMXp83iQXwBbFZZOSmpNZllqk
        b5fAlTF3QSNLwXaxip7vaxgbGNcIdTFyckgImEgcn9PD0sXIxSEksIJRYv/Ru2wQzhdGib6X
        m9ghnM+MEg9aLzPCtEy/+xvMFhJYziixdmoWRNFbRom/914zgSSEBZIlWne/YAOxRQRUJa5d
        uAu2g1ngDpPEzuf9YAk2ASuJie2rwCbxCthJtL5oBmtmAWo4cuU2WI2oQITEpweHWSFqBCVO
        znzCAmJzClhKXL+yBqyXWUBc4taT+UwQtrzE9rdzmEGWSQh8ZJd4/OQrC8TZLhJdM16zQ9jC
        Eq+Ob4GyZST+7wRpBmlYB/RCxwuo7u2MEssn/2ODqLKWuHPuF5DNAbRCU2L9Ln0QU0LAUeLf
        t3IIk0/ixltBiBv4JCZtm84MEeaV6GiDhrWaxIZlG9hgtnbtXMk8gVFpFpLPZiH5ZhaSb2Yh
        rF3AyLKKUTy1tDg3PbXYKC+1XK84Mbe4NC9dLzk/dxMjMKWd/nf8yw7GXX+SDjEKcDAq8fBK
        +PPEC7EmlhVX5h5ilOBgVhLhdTp7Ok6INyWxsiq1KD++qDQntfgQozQHi5I4r/Gil7FCAumJ
        JanZqakFqUUwWSYOTqkGxuKiJzN1DEIadrUdtuQV+m6cZSht6rHo56v22oobHkU/H37RcAyX
        sRUUXi1Sf6zqUviL3e8mNXk81/mkqLOyYfdRHeuH3aY50ScnTt2YUT3/+5JVboslXgS2CW04
        UDbjwKc6RxWlQ7eSi3JZuWZJ1pX/FxQ46vyiaMWnDXsZRZ7t/fjo3fKjakosxRmJhlrMRcWJ
        AAHQfK1lAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrCIsWRmVeSWpSXmKPExsVy+t/xe7rnEnnjDTY1M1tMvHGFxeL6l+es
        Fgs+zWC16H/8mtni/PkN7BZnm96wW2x6fI3V4vKuOWwWn3uPMFrMOL+PyWJhUwu7xe3GFWwW
        h9+0s1p8O/GI0YHPY828NYweO2fdZffYtKqTzWPzknqPvi2rGD0+b5ILYIvSsynKLy1JVcjI
        Ly6xVYo2tDDSM7S00DMysdQzNDaPtTIyVdK3s0lJzcksSy3St0vQy5i7oJGlYLtYRc/3NYwN
        jGuEuhg5OSQETCSm3/3NCGILCSxllJg8WbWLkQMoLiNxfH0ZRImwxJ9rXWxdjFxAJa8ZJVo3
        /WMCSQgLJEv82XGKDcQWEVCVuHbhLgtIEbPAHSaJ1wcXMUJ07GaUWLTwAgtIFZuAlcTE9lVg
        23gF7CRaXzSDTWIB6j5y5TbYJFGBCInDO2ZB1QhKnJz5BKyXU8BS4vqVNWBxZgF1iT/zLjFD
        2OISt57MZ4Kw5SW2v53DPIFRaBaS9llIWmYhaZmFpGUBI8sqRpHU0uLc9NxiI73ixNzi0rx0
        veT83E2MwBjeduznlh2MXe+CDzEKcDAq8fBK+PPEC7EmlhVX5h5ilOBgVhLhdTp7Ok6INyWx
        siq1KD++qDQntfgQoynQcxOZpUST84HpJa8k3tDU0NzC0tDc2NzYzEJJnLdD4GCMkEB6Yklq
        dmpqQWoRTB8TB6dUA6Pl3bvPt4Zyl7Ot25k5TXdni2bbwm87It/XvfK8O/O/rP9WuUUvn818
        uz/F0iGo4uUbCcauJZ77ppior5O6JPT90loe45+KKRyLbQQi7//1E5+vbOK3xv2x1jZure0R
        618E2Xdu731lsKVxX0Nlr/Sm93eDvv9RFp+xtDGj3jwopfpNgAPrfg8lluKMREMt5qLiRABL
        d4c99wIAAA==
X-CMS-MailID: 20200714074206eucas1p29046b2f20810b8cbbfb4bc04a1ed603a
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20200710191148eucas1p2552537bb911bde44c783d98808efa07f
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20200710191148eucas1p2552537bb911bde44c783d98808efa07f
References: <20200710191122.11029-1-lukasz.luba@arm.com>
        <CGME20200710191148eucas1p2552537bb911bde44c783d98808efa07f@eucas1p2.samsung.com>
        <20200710191122.11029-3-lukasz.luba@arm.com>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


Hi,

On 7/10/20 9:11 PM, Lukasz Luba wrote:
> The driver can operate in two modes relaying on devfreq monitoring
> mechanism which periodically checks the device status or it can use
> interrupts when they are provided by loaded Device Tree. The newly
> introduced module parameter can be used to choose between devfreq
> monitoring and internal interrupts without modifying the Device Tree.
> It also sets devfreq monitoring as default when the parameter is not set
> (also the case for default when the driver is not built as a module).

Could you please explain why should we leave the IRQ mode
support in the dmc driver?

What are the advantages over the polling mode?

In what scenarios it should be used?

[ If this is only for documentation purposes then it should be
  removed as it would stay in (easily accessible) git history
  anyway.. ]

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics

> Reported-by: Willy Wolff <willy.mh.wolff.ml@gmail.com>
> Signed-off-by: Lukasz Luba <lukasz.luba@arm.com>
> ---
>  drivers/memory/samsung/exynos5422-dmc.c | 9 +++++++--
>  1 file changed, 7 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/memory/samsung/exynos5422-dmc.c b/drivers/memory/samsung/exynos5422-dmc.c
> index e03ee35f0ab5..53bfe6b7b703 100644
> --- a/drivers/memory/samsung/exynos5422-dmc.c
> +++ b/drivers/memory/samsung/exynos5422-dmc.c
> @@ -12,6 +12,7 @@
>  #include <linux/io.h>
>  #include <linux/mfd/syscon.h>
>  #include <linux/module.h>
> +#include <linux/moduleparam.h>
>  #include <linux/of_device.h>
>  #include <linux/pm_opp.h>
>  #include <linux/platform_device.h>
> @@ -21,6 +22,10 @@
>  #include "../jedec_ddr.h"
>  #include "../of_memory.h"
>  
> +static int irqmode;
> +module_param(irqmode, int, 0644);
> +MODULE_PARM_DESC(irqmode, "Enable IRQ mode (0=off [default], 1=on)");
> +
>  #define EXYNOS5_DREXI_TIMINGAREF		(0x0030)
>  #define EXYNOS5_DREXI_TIMINGROW0		(0x0034)
>  #define EXYNOS5_DREXI_TIMINGDATA0		(0x0038)
> @@ -1428,7 +1433,7 @@ static int exynos5_dmc_probe(struct platform_device *pdev)
>  	/* There is two modes in which the driver works: polling or IRQ */
>  	irq[0] = platform_get_irq_byname(pdev, "drex_0");
>  	irq[1] = platform_get_irq_byname(pdev, "drex_1");
> -	if (irq[0] > 0 && irq[1] > 0) {
> +	if (irq[0] > 0 && irq[1] > 0 && irqmode) {
>  		ret = devm_request_threaded_irq(dev, irq[0], NULL,
>  						dmc_irq_thread, IRQF_ONESHOT,
>  						dev_name(dev), dmc);
> @@ -1485,7 +1490,7 @@ static int exynos5_dmc_probe(struct platform_device *pdev)
>  	if (dmc->in_irq_mode)
>  		exynos5_dmc_start_perf_events(dmc, PERF_COUNTER_START_VALUE);
>  
> -	dev_info(dev, "DMC initialized\n");
> +	dev_info(dev, "DMC initialized, in irq mode: %d\n", dmc->in_irq_mode);
>  
>  	return 0;
>  
> 

