Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB48E63A34F
	for <lists+linux-pm@lfdr.de>; Mon, 28 Nov 2022 09:43:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229947AbiK1InU (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 28 Nov 2022 03:43:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229899AbiK1InP (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 28 Nov 2022 03:43:15 -0500
Received: from mx1.tq-group.com (mx1.tq-group.com [93.104.207.81])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D328F11C1C
        for <linux-pm@vger.kernel.org>; Mon, 28 Nov 2022 00:43:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1669624992; x=1701160992;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=aPqs6bUfvCCU3X46JRSYAS78DbNztu8LeR89gALA0kc=;
  b=b55hjGmtbIu4aOlKrFPaNZ0bTUwiqetThdwF0v+39LBKLl1OVt7mzfer
   lI9dwIa4XcCrVs9Nrviuzt8oPOnfIeTxGhi9aqyYDsy62mwJp8Y5OCi1Q
   HJnhDJpDaqlMbK+2EupB+GP8/5IgN1kmHjPQii851Zpq8Vseeymh2ThFG
   k+fzt4DoFNCYUe9mhciMjaH2H/nCVXdTAxZ1ZSArrAKdtKxbOGK9aFSha
   Sr6nJAdPInGWtlvoFvTg4cxBRgVv/4db2K+/oIek+0ujqrR2ljO7nBcK/
   xXkPUXnKO57irynZ9J8N1priYjiQT9vB3OR/3J+9gHDcEcPFYu/znQFsG
   w==;
X-IronPort-AV: E=Sophos;i="5.96,199,1665439200"; 
   d="scan'208";a="27607862"
Received: from unknown (HELO tq-pgp-pr1.tq-net.de) ([192.168.6.15])
  by mx1-pgp.tq-group.com with ESMTP; 28 Nov 2022 09:43:10 +0100
Received: from mx1.tq-group.com ([192.168.6.7])
  by tq-pgp-pr1.tq-net.de (PGP Universal service);
  Mon, 28 Nov 2022 09:43:10 +0100
X-PGP-Universal: processed;
        by tq-pgp-pr1.tq-net.de on Mon, 28 Nov 2022 09:43:10 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1669624990; x=1701160990;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=aPqs6bUfvCCU3X46JRSYAS78DbNztu8LeR89gALA0kc=;
  b=A8Gr/PO2+o4lavuFVLN0XGc4BiovTdIU/cQsRB6Zw8HSPAnSIaKX9wZR
   oG6FlRCohlzyScrk2zpdqh5+28GkQK+x6Z74vAbUmap38vnUe0FQZSAcb
   haevfAvFCdswi0X7dS5RhZ6F94HLJU3KPgXCvZbm9fJ8ItAzX5ojTgrog
   8aFXhTryP9mTkLJEdLRTpjswXvQazznkOFHoG+0QW3PIS2Vc7SD/ioUd3
   iRSoIkKN1Jcd34xYj1sV4EjsFP5dDe/Gh2pvhoD/7o64OG7xwmgPOwLCX
   gartW5kkUh7f9RhR+Ds4lYu257Zki5W9E5G5gygyKB8/NYU3jhkiP2laq
   g==;
X-IronPort-AV: E=Sophos;i="5.96,199,1665439200"; 
   d="scan'208";a="27607861"
Received: from vtuxmail01.tq-net.de ([10.115.0.20])
  by mx1.tq-group.com with ESMTP; 28 Nov 2022 09:43:10 +0100
Received: from steina-w.localnet (unknown [10.123.53.21])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by vtuxmail01.tq-net.de (Postfix) with ESMTPSA id 11295280056;
        Mon, 28 Nov 2022 09:43:10 +0100 (CET)
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
Date:   Mon, 28 Nov 2022 09:43:11 +0100
Message-ID: <5883255.lOV4Wx5bFT@steina-w>
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

Hello,

gentle ping. Any feedback on this?

Thanks
Alexander

Am Dienstag, 26. Juli 2022, 14:23:31 CET schrieb Alexander Stein:
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
> +			dev_warn(&pdev->dev, "failed to add hwmon sysfs 
attributes\n");
>  	}
> 
>  	platform_set_drvdata(pdev, tmu);




