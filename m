Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 14DD411B9CB
	for <lists+linux-pm@lfdr.de>; Wed, 11 Dec 2019 18:13:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730711AbfLKRN0 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 11 Dec 2019 12:13:26 -0500
Received: from mo4-p01-ob.smtp.rzone.de ([85.215.255.54]:30558 "EHLO
        mo4-p01-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729512AbfLKRN0 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 11 Dec 2019 12:13:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1576084404;
        s=strato-dkim-0002; d=gerhold.net;
        h=In-Reply-To:References:Message-ID:Subject:Cc:To:From:Date:
        X-RZG-CLASS-ID:X-RZG-AUTH:From:Subject:Sender;
        bh=oFk4a1ZHaFS5On1Vtt+xS8rJo9fx0S1BmG+yU5jRxZQ=;
        b=bl9uGKdmv9SAMJzeUH7PDRCpYW4q4AqGgbTg+QC9NwCN3hGHJg9ei7KX8NkLHk1OlT
        Mgi+KjuiCZEZH8P7w3lDe6G9VMb9pSbLZ6RTku88IudI5rvxidPXZV3qGxyDTe9drbmO
        aXdhtLdbA556aYRcmQPgi0JYQ4Q2weXL+C/vOT0igEyckghKE4O7Lqhwnom1ma2tfDbM
        o/P+GeujuMMSs6CZyE42AhoceD23yPrxvWtfxO9INHIg18al9TxsQcek7+t9it1PPD6a
        +VLTSgddq339CwxVqNlPKVp+69OZFnuddm4bNdDDLw0LOMB3y6+dKjtzl3eW2olsO94J
        LYYg==
X-RZG-AUTH: ":P3gBZUipdd93FF5ZZvYFPugejmSTVR2nRPhVOQ/OcYgojyw4j34+u266EZF6ORJGV8vHxv6O"
X-RZG-CLASS-ID: mo00
Received: from gerhold.net
        by smtp.strato.de (RZmta 46.0.2 AUTH)
        with ESMTPSA id R01a59vBBHDJo9R
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
        Wed, 11 Dec 2019 18:13:19 +0100 (CET)
Date:   Wed, 11 Dec 2019 18:13:13 +0100
From:   Stephan Gerhold <stephan@gerhold.net>
To:     Amit Kucheria <amit.kucheria@linaro.org>
Cc:     linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        bjorn.andersson@linaro.org, agross@kernel.org, swboyd@chromium.org,
        olof@lixom.net, Daniel Lezcano <daniel.lezcano@linaro.org>,
        linux-pm@vger.kernel.org
Subject: Re: [PATCH] drivers: thermal: tsens: Work with old DTBs
Message-ID: <20191211171313.GA1530@gerhold.net>
References: <cover.1576058136.git.amit.kucheria@linaro.org>
 <39d6b8e4b2cc5836839cfae7cdf0ee3470653b64.1576058136.git.amit.kucheria@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <39d6b8e4b2cc5836839cfae7cdf0ee3470653b64.1576058136.git.amit.kucheria@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Amit,

Thanks for the patch!

On Wed, Dec 11, 2019 at 03:28:33PM +0530, Amit Kucheria wrote:
> In order for the old DTBs to continue working, the new interrupt code
> must not return an error if interrupts are not defined.
> 
> Fixes: 634e11d5b450a ("drivers: thermal: tsens: Add interrupt support")
> Signed-off-by: Amit Kucheria <amit.kucheria@linaro.org>
> ---
>  drivers/thermal/qcom/tsens.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/thermal/qcom/tsens.c b/drivers/thermal/qcom/tsens.c
> index 015e7d2015985..d8f51067ed411 100644
> --- a/drivers/thermal/qcom/tsens.c
> +++ b/drivers/thermal/qcom/tsens.c
> @@ -109,7 +109,7 @@ static int tsens_register(struct tsens_priv *priv)
>  
>  	irq = platform_get_irq_byname(pdev, "uplow");
>  	if (irq < 0) {
> -		ret = irq;
> +		dev_warn(&pdev->dev, "Missing uplow irq in DT\n");
>  		goto err_put_device;
>  	}

platform_get_irq_byname() already logs an error if the IRQ cannot be
found: qcom-tsens 4a9000.thermal-sensor: IRQ uplow not found

To replace that error with a warning (not sure if that is worth it),
we would need to replace the call with platform_get_irq_byname_optional().

>  
> @@ -118,7 +118,8 @@ static int tsens_register(struct tsens_priv *priv)
>  					IRQF_TRIGGER_HIGH | IRQF_ONESHOT,
>  					dev_name(&pdev->dev), priv);
>  	if (ret) {
> -		dev_err(&pdev->dev, "%s: failed to get irq\n", __func__);
> +		dev_warn(&pdev->dev, "%s: failed to get uplow irq\n", __func__);
> +		ret = 0;
>  		goto err_put_device;

In case of the old DT, platform_get_irq_byname() will return -ENXIO,
because no interrupt is specified in the device tree.
So we should have already run into the error earlier,
and jumped to "err_put_device".

Is this hunk really necessary?

In other words, wouldn't it be enough to do something like

@@ -110,6 +110,8 @@ static int tsens_register(struct tsens_priv *priv)
 	irq = platform_get_irq_byname(pdev, "uplow");
 	if (irq < 0) {
 		ret = irq;
+		if (ret == -ENXIO)
+			ret = 0;
 		goto err_put_device;
 	}

... to essentially ignore only the "IRQ does not exist" condition
for old device trees?

Thanks,
Stephan
