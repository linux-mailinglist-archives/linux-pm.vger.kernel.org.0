Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF2145BFD1B
	for <lists+linux-pm@lfdr.de>; Wed, 21 Sep 2022 13:44:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229667AbiIULoY (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 21 Sep 2022 07:44:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229519AbiIULoW (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 21 Sep 2022 07:44:22 -0400
Received: from mx1.tq-group.com (mx1.tq-group.com [93.104.207.81])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 214308F97D
        for <linux-pm@vger.kernel.org>; Wed, 21 Sep 2022 04:44:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1663760661; x=1695296661;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=vUihO/ZAT9LYk2mkbZM6lyiElbZkhBiSGqEmjPJTLfI=;
  b=Ipip4u/V8MpShggywhe3eNULMmMsga2e5euMmVhOW0Am+9iIFhkGlcIS
   unKV3Qy5uOEdStgm32h3Idt7e1fK/t4lELOP9mJQx8sfKXY1iZ4LoKI3b
   FNQL39TKiBGSyznrj5JcCi4yejfUE5xODfgW/cpPktn7ympxsqfe0Hqpl
   LZ74YMVcdFA1k1G7yeWOsYRNCJyP8nBENvj/HPn2ocGAj7wb+6ofJEauQ
   CkBWd/beEpTe39Fghh1tmTDKpUJc5L812i/kmiCAbMg7bpVlTRdC4aH0n
   KRnFk9FgA6Ra8sQqg42S6lZYkMlKZti4riviQLhEeVzGetgHHR3FH3yvb
   g==;
X-IronPort-AV: E=Sophos;i="5.93,333,1654552800"; 
   d="scan'208";a="26310236"
Received: from unknown (HELO tq-pgp-pr1.tq-net.de) ([192.168.6.15])
  by mx1-pgp.tq-group.com with ESMTP; 21 Sep 2022 13:44:19 +0200
Received: from mx1.tq-group.com ([192.168.6.7])
  by tq-pgp-pr1.tq-net.de (PGP Universal service);
  Wed, 21 Sep 2022 13:44:19 +0200
X-PGP-Universal: processed;
        by tq-pgp-pr1.tq-net.de on Wed, 21 Sep 2022 13:44:19 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1663760659; x=1695296659;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=vUihO/ZAT9LYk2mkbZM6lyiElbZkhBiSGqEmjPJTLfI=;
  b=gWybAWMTUM5dua9RM9x/8apoIYXUnJk6DadUx56GDebIDY5Yfp5UFrtD
   xz2NSvSI3AX6YeAcmOfeEPlV1x2gOpaIml8hnnjWmLg0xbzBIRCHbBNTe
   v14UjsgAPeKc52jf+cFfp0Ldfxb8VZneL90bE+NgqumEdRJNZsNuBnSkw
   h708t7CGExfF3aTkQLZwHpaUldLLL8RbAoV46hq80M5ZhFkHHPAVfwq44
   iw7z5ajC0MduMSV5OMtS5O7s30tLmyZgAYqaS8bVRvlPCyrfJL9j9GURr
   YCScWfAwMn6+VpkiIlDQg0Xw32zl7nAAg3B/76gwUF+BvaB85LCbcDmIM
   g==;
X-IronPort-AV: E=Sophos;i="5.93,333,1654552800"; 
   d="scan'208";a="26310235"
Received: from vtuxmail01.tq-net.de ([10.115.0.20])
  by mx1.tq-group.com with ESMTP; 21 Sep 2022 13:44:19 +0200
Received: from steina-w.localnet (unknown [10.123.49.11])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by vtuxmail01.tq-net.de (Postfix) with ESMTPSA id F2766280056;
        Wed, 21 Sep 2022 13:44:18 +0200 (CEST)
From:   Alexander Stein <alexander.stein@ew.tq-group.com>
To:     "Rafael J . Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Amit Kucheria <amitk@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>
Cc:     linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v2 1/1] thermal: imx8mm: Add hwmon support
Date:   Wed, 21 Sep 2022 13:44:18 +0200
Message-ID: <5863241.lOV4Wx5bFT@steina-w>
Organization: TQ-Systems GmbH
In-Reply-To: <20220726122331.323093-1-alexander.stein@ew.tq-group.com>
References: <20220726122331.323093-1-alexander.stein@ew.tq-group.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Gentle ping

Am Dienstag, 26. Juli 2022, 14:23:31 CEST schrieb Alexander Stein:
> Expose thermal sensors as HWMON devices.
> 
> Signed-off-by: Alexander Stein <alexander.stein@ew.tq-group.com>
> ---
> Changes in v2:
> * Split from thermal_helpers patch
> * No change otherwise
> 
> The helper patch need some additional work, but this can go as it is.
> 
>  drivers/thermal/imx8mm_thermal.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/drivers/thermal/imx8mm_thermal.c
> b/drivers/thermal/imx8mm_thermal.c index af666bd9e8d4..ca8e2c393030 100644
> --- a/drivers/thermal/imx8mm_thermal.c
> +++ b/drivers/thermal/imx8mm_thermal.c
> @@ -16,6 +16,7 @@
>  #include <linux/thermal.h>
> 
>  #include "thermal_core.h"
> +#include "thermal_hwmon.h"
> 
>  #define TER			0x0	/* TMU enable */
>  #define TPS			0x4
> @@ -176,6 +177,9 @@ static int imx8mm_tmu_probe(struct platform_device
> *pdev) goto disable_clk;
>  		}
>  		tmu->sensors[i].hw_id = i;
> +
> +		if (devm_thermal_add_hwmon_sysfs(tmu->sensors[i].tzd))
> +			dev_warn(&pdev->dev, "failed to add hwmon 
sysfs attributes\n");
>  	}
> 
>  	platform_set_drvdata(pdev, tmu);




