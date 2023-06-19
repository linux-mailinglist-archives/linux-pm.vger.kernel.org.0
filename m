Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2CCDE734D38
	for <lists+linux-pm@lfdr.de>; Mon, 19 Jun 2023 10:11:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230053AbjFSIK6 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 19 Jun 2023 04:10:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230187AbjFSIKd (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 19 Jun 2023 04:10:33 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8905E7D
        for <linux-pm@vger.kernel.org>; Mon, 19 Jun 2023 01:10:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1687162226; x=1718698226;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=5RLQM3xUpr9GqCaneuDTYz/ymBlFLtLlT1OGK3DqPRw=;
  b=QET6SpDRjvFnUiFqz2nOvMmbr5cPVve0J3T0ocSsIz29FR8oGOPIDiuo
   bXgR5qXPKt95+l69all/NYyE0/K+4L2ceT+1czQNpl546tJinVgjsSi8v
   mA33eIAhfPhc5rKjSfwuiWYW6PIRUrxhpY07Z0pyLSbLkVkK/jjkwAGUW
   oIBll8r8hA4uH/XgkOuxzelJFjoHVoMvvbxryxK3Xyj2jWV5Qdn0A50Wu
   X4SdDgvNyzSd+xcJaI8je8yzQV3ZnhffjU9CHzFeAiv6qP3jXu1pc3nVl
   MlIQ2u/lnrENIjpDcHeJb+cl1MA9zb+VCgOz7WTEczyKQtBnpG9hei2sq
   Q==;
X-IronPort-AV: E=Sophos;i="6.00,254,1681196400"; 
   d="scan'208";a="220875485"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa2.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 19 Jun 2023 01:10:25 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Mon, 19 Jun 2023 01:10:25 -0700
Received: from [10.159.245.112] (10.10.115.15) by chn-vm-ex04.mchp-main.com
 (10.10.85.152) with Microsoft SMTP Server id 15.1.2507.21 via Frontend
 Transport; Mon, 19 Jun 2023 01:10:23 -0700
Message-ID: <9cb6cebf-80ff-7ca1-6acf-41f58fd831f8@microchip.com>
Date:   Mon, 19 Jun 2023 10:10:05 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v3 1/2] power: reset: at91-reset: change the power on
 reason prototype
Content-Language: en-US
To:     Miquel Raynal <miquel.raynal@bootlin.com>,
        Sebastian Reichel <sre@kernel.org>
CC:     Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Claudiu Beznea <claudiu.beznea@microchip.com>,
        <linux-pm@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>
References: <20230616135252.2787679-1-miquel.raynal@bootlin.com>
 <20230616135252.2787679-2-miquel.raynal@bootlin.com>
From:   Nicolas Ferre <nicolas.ferre@microchip.com>
Organization: microchip
In-Reply-To: <20230616135252.2787679-2-miquel.raynal@bootlin.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 16/06/2023 at 15:52, Miquel Raynal wrote:
> EXTERNAL EMAIL: Do not click links or open attachments unless you know the content is safe
> 
> It is quite uncommon to use a driver helper with parameters like *pdev
> and __iomem *base. It is much cleaner and close to today's standards to
> provide the per-device driver structure and then access its
> internals. Let's do this with the helper which returns the power on
> reason. While we change the parameters, we can as well rename the
> function from at91_reset_status() to at91_reset_reason() to be more
> accurate with what the helper actually does, and finally because we don't
> really need the pdev argument in this helper besides for printing the
> reset reason, we can move the dev_info() call into the probe.
> 
> All these modifications prepare the introduction of a sysfs entry to
> access this information. This way the diff will be much smaller. Thus,
> there is no intended functional change.
> 
> Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>

Thanks Miquel:
Acked-by: Nicolas Ferre <nicolas.ferre@microchip.com>

Best regards,
   Nicolas

> ---
>   drivers/power/reset/at91-reset.c | 9 ++++-----
>   1 file changed, 4 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/power/reset/at91-reset.c b/drivers/power/reset/at91-reset.c
> index 741e44a017c3..d6884841a6dc 100644
> --- a/drivers/power/reset/at91-reset.c
> +++ b/drivers/power/reset/at91-reset.c
> @@ -149,11 +149,10 @@ static int at91_reset(struct notifier_block *this, unsigned long mode,
>          return NOTIFY_DONE;
>   }
> 
> -static void __init at91_reset_status(struct platform_device *pdev,
> -                                    void __iomem *base)
> +static const char * __init at91_reset_reason(struct at91_reset *reset)
>   {
> +       u32 reg = readl(reset->rstc_base + AT91_RSTC_SR);
>          const char *reason;
> -       u32 reg = readl(base + AT91_RSTC_SR);
> 
>          switch ((reg & AT91_RSTC_RSTTYP) >> 8) {
>          case RESET_TYPE_GENERAL:
> @@ -185,7 +184,7 @@ static void __init at91_reset_status(struct platform_device *pdev,
>                  break;
>          }
> 
> -       dev_info(&pdev->dev, "Starting after %s\n", reason);
> +       return reason;
>   }
> 
>   static const struct of_device_id at91_ramc_of_match[] = {
> @@ -392,7 +391,7 @@ static int __init at91_reset_probe(struct platform_device *pdev)
>          if (ret)
>                  goto disable_clk;
> 
> -       at91_reset_status(pdev, reset->rstc_base);
> +       dev_info(&pdev->dev, "Starting after %s\n", at91_reset_reason(reset));
> 
>          return 0;
> 
> --
> 2.34.1
> 

-- 
Nicolas Ferre

