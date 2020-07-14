Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C203421ECE6
	for <lists+linux-pm@lfdr.de>; Tue, 14 Jul 2020 11:32:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726041AbgGNJcn (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 14 Jul 2020 05:32:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725952AbgGNJcm (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 14 Jul 2020 05:32:42 -0400
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 392E6C061755;
        Tue, 14 Jul 2020 02:32:42 -0700 (PDT)
Received: by mail-wr1-x441.google.com with SMTP id f2so20393810wrp.7;
        Tue, 14 Jul 2020 02:32:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=3ZJpSNrQG4Atc/mSgU3Bc/DW89b2tSDyonqVtLvIePg=;
        b=O35dMZty276VdJqNqrgMTd+4fbUsrCygRGdFjRlTdJHtdfalCEbRrxc9vWLk9TM/5R
         +sdDuMHU4xdgq81ZHI6JLW5vPOi/WQSnCvJHWZhorjIB28n0G62R0oTjmYZVY74wmYUX
         DZz8oMG/etZsTpkp+OU1ku0wDO34i+HwcBDazNsaXAM73AEdUifbQ1mVmycI2qs4n+FO
         /vdwqIXGUzksjTks6O3ipYDGSsVwwXyK03L7h8CPTawQTY0etycHZzmokfhBhWhEukqT
         j9u7qqdz4Vm5Ddy1tBlJJhQeD6HMVlnxJAHPhvsqyaKChotxxX+sz0yzvUuFstOKAs3p
         Rimw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=3ZJpSNrQG4Atc/mSgU3Bc/DW89b2tSDyonqVtLvIePg=;
        b=TKFLoGGeYL+FQfaYy8bH5MLy6dmCJlhENE//cVGuxIQ6qTQztFatutB32Pq19+rZOz
         F9lURt24OU/zxYhSA156DwvWTivj7l0N4bckHQbtK5YFNDT1J3F4BErO/SiItss7ig1Q
         bloy4vLjAPK35vCqcY7NaDe3KHzNjbNEOPuisAZ2eUnN4vVQh8vrm9OjUYoYxIzn7V/M
         /soF9cZIHhTlnbsWKBoN5n9R1nr8ip7hmoOJU2p3ue1UEfYdiU2y1OGzKVj9Yri6GqeV
         m3r2WsSc0FWhu8aoqBzy8vL0UbLVJFOoh0DhrKJhUBUNfl2nIlPdco+glTyrDD7/rByb
         Fz/g==
X-Gm-Message-State: AOAM532PpH6nsPTz0fllZUkglz8gGgy8kFK8Th0GW3hCL1vO+yxkKbLj
        w0zfddfbQ5wM1/tJchuvhJU=
X-Google-Smtp-Source: ABdhPJzRJyxKV2Nku5Zoe7kfjgysNqpYdZfL1L83vt00q76VlDKerkxLTJ1d2GTCMXG8DaQsDCOogw==
X-Received: by 2002:a5d:540d:: with SMTP id g13mr3843924wrv.380.1594719160785;
        Tue, 14 Jul 2020 02:32:40 -0700 (PDT)
Received: from macbook-pro.local (181.4.199.77.rev.sfr.net. [77.199.4.181])
        by smtp.gmail.com with ESMTPSA id l67sm4101008wml.13.2020.07.14.02.32.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jul 2020 02:32:40 -0700 (PDT)
Date:   Tue, 14 Jul 2020 11:32:39 +0200
From:   Willy Wolff <willy.mh.wolff.ml@gmail.com>
To:     Lukasz Luba <lukasz.luba@arm.com>
Cc:     Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, k.konieczny@samsung.com,
        cw00.choi@samsung.com, krzk@kernel.org, chanwoo@kernel.org,
        myungjoo.ham@samsung.com, kyungmin.park@samsung.com,
        s.nawrocki@samsung.com, kgene@kernel.org
Subject: Re: [PATCH v2 2/2] memory: samsung: exynos5422-dmc: Add module param
 to control IRQ mode
Message-ID: <20200714093239.4kvonvkwkdwobeia@macbook-pro.local>
References: <20200710191122.11029-1-lukasz.luba@arm.com>
 <CGME20200710191148eucas1p2552537bb911bde44c783d98808efa07f@eucas1p2.samsung.com>
 <20200710191122.11029-3-lukasz.luba@arm.com>
 <1a389137-cab5-124a-e198-8be3bc2ca841@samsung.com>
 <3154b8d2-1fa8-c69d-8a9d-05832e12fdd1@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <3154b8d2-1fa8-c69d-8a9d-05832e12fdd1@arm.com>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Lukasz and Bartek,

On 2020-07-14-10-01-16, Lukasz Luba wrote:
>Hi Bartek,
>
>On 7/14/20 8:42 AM, Bartlomiej Zolnierkiewicz wrote:
>>
>>Hi,
>>
>>On 7/10/20 9:11 PM, Lukasz Luba wrote:
>>>The driver can operate in two modes relaying on devfreq monitoring
>>>mechanism which periodically checks the device status or it can use
>>>interrupts when they are provided by loaded Device Tree. The newly
>>>introduced module parameter can be used to choose between devfreq
>>>monitoring and internal interrupts without modifying the Device Tree.
>>>It also sets devfreq monitoring as default when the parameter is not set
>>>(also the case for default when the driver is not built as a module).
>>
>>Could you please explain why should we leave the IRQ mode
>>support in the dmc driver?
>
>I am still experimenting with the IRQ mode in DMC, but have limited time
>for it and no TRM.
>The IRQ mode in memory controller or bus controller has one major
>advantage: is more interactive. In polling we have fixed period, i.e.
>100ms - that's a lot when we have a sudden, latency sensitive workload.
>There might be no check of the device load for i.e. 99ms, but the tasks
>with such workload started running. That's a long period of a few frames
>which are likely to be junked. Should we adjust polling interval to i.e.
>10ms, I don't think so. There is no easy way to address all of the
>scenarios.
>
>>
>>What are the advantages over the polling mode?
>
>As described above: more reactive to sudden workload, which might be
>latency sensitive and cause junk frames.
>Drawback: not best in benchmarks which are randomly jumping
>over the data set, causing low traffic on memory.
>It could be mitigated as Sylwester described with not only one type
>of interrupt, but another, which could 'observe' also other information
>type in the counters and fire.
>
>>
>>In what scenarios it should be used?
>
>System like Android with GUI, when there is this sudden workload
>quite often.
>
>I think the interconnect could help here and would adjust the DMC
>freq upfront. Although I don't know if interconnect on Exynos5422 is in
>your scope in near future. Of course the interconnect will not cover
>all scenarios either.
>

The interconnect (CCI-400) will not help much, you still have the same problem
of setting interrupts at the right threshold, or to poll it to see any activity
through it.

>
>>
>>[ If this is only for documentation purposes then it should be
>>   removed as it would stay in (easily accessible) git history
>>   anyway.. ]
>
>The current interrupt mode is definitely not perfect and switching
>to devfreq monitoring mode has more sense. On the other hand, it
>still has potential, until there is no interconnect for this SoC.
>I will continue experimenting with irq mode, so I would like to
>still have the code in the driver.
>
>Regards,
>Lukasz
>
>>
>>Best regards,
>>--
>>Bartlomiej Zolnierkiewicz
>>Samsung R&D Institute Poland
>>Samsung Electronics
>>
>>>Reported-by: Willy Wolff <willy.mh.wolff.ml@gmail.com>
>>>Signed-off-by: Lukasz Luba <lukasz.luba@arm.com>
>>>---
>>>  drivers/memory/samsung/exynos5422-dmc.c | 9 +++++++--
>>>  1 file changed, 7 insertions(+), 2 deletions(-)
>>>
>>>diff --git a/drivers/memory/samsung/exynos5422-dmc.c b/drivers/memory/samsung/exynos5422-dmc.c
>>>index e03ee35f0ab5..53bfe6b7b703 100644
>>>--- a/drivers/memory/samsung/exynos5422-dmc.c
>>>+++ b/drivers/memory/samsung/exynos5422-dmc.c
>>>@@ -12,6 +12,7 @@
>>>  #include <linux/io.h>
>>>  #include <linux/mfd/syscon.h>
>>>  #include <linux/module.h>
>>>+#include <linux/moduleparam.h>
>>>  #include <linux/of_device.h>
>>>  #include <linux/pm_opp.h>
>>>  #include <linux/platform_device.h>
>>>@@ -21,6 +22,10 @@
>>>  #include "../jedec_ddr.h"
>>>  #include "../of_memory.h"
>>>+static int irqmode;
>>>+module_param(irqmode, int, 0644);
>>>+MODULE_PARM_DESC(irqmode, "Enable IRQ mode (0=off [default], 1=on)");
>>>+
>>>  #define EXYNOS5_DREXI_TIMINGAREF		(0x0030)
>>>  #define EXYNOS5_DREXI_TIMINGROW0		(0x0034)
>>>  #define EXYNOS5_DREXI_TIMINGDATA0		(0x0038)
>>>@@ -1428,7 +1433,7 @@ static int exynos5_dmc_probe(struct platform_device *pdev)
>>>  	/* There is two modes in which the driver works: polling or IRQ */
>>>  	irq[0] = platform_get_irq_byname(pdev, "drex_0");
>>>  	irq[1] = platform_get_irq_byname(pdev, "drex_1");
>>>-	if (irq[0] > 0 && irq[1] > 0) {
>>>+	if (irq[0] > 0 && irq[1] > 0 && irqmode) {
>>>  		ret = devm_request_threaded_irq(dev, irq[0], NULL,
>>>  						dmc_irq_thread, IRQF_ONESHOT,
>>>  						dev_name(dev), dmc);
>>>@@ -1485,7 +1490,7 @@ static int exynos5_dmc_probe(struct platform_device *pdev)
>>>  	if (dmc->in_irq_mode)
>>>  		exynos5_dmc_start_perf_events(dmc, PERF_COUNTER_START_VALUE);
>>>-	dev_info(dev, "DMC initialized\n");
>>>+	dev_info(dev, "DMC initialized, in irq mode: %d\n", dmc->in_irq_mode);
>>>  	return 0;
>>>
>>
