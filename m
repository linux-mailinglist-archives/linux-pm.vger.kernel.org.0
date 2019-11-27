Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 67E1610AE5E
	for <lists+linux-pm@lfdr.de>; Wed, 27 Nov 2019 12:00:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726240AbfK0LAV convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-pm@lfdr.de>); Wed, 27 Nov 2019 06:00:21 -0500
Received: from relay5-d.mail.gandi.net ([217.70.183.197]:46787 "EHLO
        relay5-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726149AbfK0LAV (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 27 Nov 2019 06:00:21 -0500
X-Originating-IP: 90.76.211.102
Received: from xps13 (lfbn-1-2154-102.w90-76.abo.wanadoo.fr [90.76.211.102])
        (Authenticated sender: miquel.raynal@bootlin.com)
        by relay5-d.mail.gandi.net (Postfix) with ESMTPSA id ED4AB1C001A;
        Wed, 27 Nov 2019 11:00:18 +0000 (UTC)
Date:   Wed, 27 Nov 2019 12:00:18 +0100
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Zak Hays <zak.hays@lexmark.com>
Cc:     Zhang Rui <rui.zhang@intel.com>,
        Eduardo Valentin <edubezval@gmail.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Amit Kucheria <amit.kucheria@verdurent.com>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/2] thermal: armada-thermal: clear reset in
 armadaxp_init
Message-ID: <20191127120018.679bf947@xps13>
In-Reply-To: <MWHPR10MB13435C92C02136EE4582B1218C450@MWHPR10MB1343.namprd10.prod.outlook.com>
References: <1574721077-29892-1-git-send-email-zhays@lexmark.com>
        <1574721077-29892-2-git-send-email-zhays@lexmark.com>
        <MWHPR10MB13435C92C02136EE4582B1218C450@MWHPR10MB1343.namprd10.prod.outlook.com>
Organization: Bootlin
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Zak,

Zak Hays <zak.hays@lexmark.com> wrote on Tue, 26 Nov 2019 14:54:11
+0000:

> The reset bit needs to be cleared in the init sequence otherwise it
> 
> holds the block in reset.

"thermal: armada: " is the right prefix for your title

Your Signed-off-by should be here (git commit --amend -s)

The format of your patch is strange, there are additional empty lines
which are problematic.

> 
> ---
> 
>  drivers/thermal/armada_thermal.c | 3 +++
> 
>  1 file changed, 3 insertions(+)
> 
> 
> 
> diff --git a/drivers/thermal/armada_thermal.c b/drivers/thermal/armada_thermal.c
> 
> index 88363812033c..8c4d1244ee7a 100644
> 
> --- a/drivers/thermal/armada_thermal.c
> 
> +++ b/drivers/thermal/armada_thermal.c
> 
> @@ -155,6 +155,9 @@ static void armadaxp_init(struct platform_device *pdev,
> 
>  
> 
>          regmap_write(priv->syscon, data->syscon_control1_off, reg);
> 
>  
> 
> +       reg &= ~PMU_TDC0_SW_RST_MASK;
> 
> +       regmap_write(priv->syscon, data->syscon_control1_off, reg);
> 
> +

Do you really want to write this register twice? Shouldn't you get rid
of the first regmap_write() above?

> 
>          /* Enable the sensor */
> 
>          regmap_read(priv->syscon, data->syscon_status_off, &reg);
> 
>          reg &= ~PMU_TM_DISABLE_MASK;
> 

In your next iteration, please use the '-v2' option with
git-format-patch to get titles starting with "[PATCH v2 x/2] ..."
automatically. Also write a changelog below the three dots '---'.

Thanks,
Miquèl
