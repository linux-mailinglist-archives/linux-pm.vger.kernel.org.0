Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5BE3D7AA273
	for <lists+linux-pm@lfdr.de>; Thu, 21 Sep 2023 23:18:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232719AbjIUVRR (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 21 Sep 2023 17:17:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232453AbjIUVQO (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 21 Sep 2023 17:16:14 -0400
Received: from mslow1.mail.gandi.net (mslow1.mail.gandi.net [217.70.178.240])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7955A9C7;
        Thu, 21 Sep 2023 10:07:11 -0700 (PDT)
Received: from relay3-d.mail.gandi.net (unknown [217.70.183.195])
        by mslow1.mail.gandi.net (Postfix) with ESMTP id 55B3DCF277;
        Thu, 21 Sep 2023 07:59:00 +0000 (UTC)
Received: by mail.gandi.net (Postfix) with ESMTPSA id 29C1560006;
        Thu, 21 Sep 2023 07:58:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1695283116;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=yLvHllXACN1zA5CMjFMhPYxtctKNWOEMglwvg9CAAd4=;
        b=MCoTOXubAjcszgcr8Z1eKA3CjCCAjns8nCwCZRMm87VzMzY9OIneKFRDQZm+OuQ7Mz/sOg
        gkQAu/cYR4cKx6KEXeUuPw+1qXHyUxKzkRu01LcWujXOJ9K4hN49u04K+NQd5fRs8iet01
        lx5fbZwDi0ELe5u6knJySARn/hSM3aNy1ANYdnOumj66kkdxrRrzi65GNOdxlRX/3+sku4
        A/d0Sjta67pqepvC/gAxOp9ip1miqMG5k41mtUjYAEO/1tVTJ2uALgrtDYxEndHnfQPxDe
        DYTrhDTxuOtMRllc9Iff74S12+nlUEEAF+pbZDXYCEzfwMfvCDhUlrmaoWXu6w==
Message-ID: <332111c2-f3f5-3d7f-09ef-f3ebb3f48eb0@bootlin.com>
Date:   Thu, 21 Sep 2023 09:58:35 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
Subject: Re: serial: 8250_omap: suspend issue with console_suspend disabled
Content-Language: en-US
To:     Tony Lindgren <tony@atomide.com>
Cc:     linux-pm@vger.kernel.org, linux-serial@vger.kernel.org,
        Gregory CLEMENT <gregory.clement@bootlin.com>,
        Kumar Udit <u-kumar1@ti.com>, Dhruva Gole <d-gole@ti.com>
References: <59b13c93-6637-3050-c145-31be0d6c12c9@bootlin.com>
 <20230920053828.GD5282@atomide.com>
From:   Thomas Richard <thomas.richard@bootlin.com>
In-Reply-To: <20230920053828.GD5282@atomide.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-GND-Sasl: thomas.richard@bootlin.com
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 9/20/23 07:38, Tony Lindgren wrote:
> Hi,
> 
> * Thomas Richard <thomas.richard@bootlin.com> [230915 09:57]:
>> The regression was introduced in commit 20a41a62618d "serial: 8250_omap:
>> Use force_suspend and resume for system suspend"
> ...
> 
>> --- a/drivers/tty/serial/8250/8250_omap.c
>> +++ b/drivers/tty/serial/8250/8250_omap.c
>> @@ -1630,7 +1630,7 @@ static int omap8250_suspend(struct device *dev)
>>         err = pm_runtime_force_suspend(dev);
>>         flush_work(&priv->qos_work);
>>
>> -       return err;
>> +       return 0;
>>  }
> 
> Maybe we can now just simplify things a bit here with the patch below.
> Care to give it a try, it's compile tested only so far.
> 

I tested it, it works for me.

>> Once the omap8250_suspend doesn't return an error, the suspend sequence
>> can continue, but I get an other issue.
>> This issue is not related to commit 20a41a62618d, it has already been
>> present.
>> The power domain of the console is powered-off, so no more messages are
>> printed, and the SoC is stucked.
>> As the uart port is used as console, we don't want to power-off it.
>> My workaround is to set the corresponding power domain to
>> GENPD_FLAG_ALWAYS_ON, so the uart port is not powered-off.
> 
> The runtime PM usage count should keep the related power domain on though,
> sounds like this issue somewhere else if the power domains get force
> suspended with runtime PM usage count?
> 
> Regards,
> 
> Tony
> 
> 8< ------------------------------
> diff --git a/drivers/tty/serial/8250/8250_omap.c b/drivers/tty/serial/8250/8250_omap.c
> --- a/drivers/tty/serial/8250/8250_omap.c
> +++ b/drivers/tty/serial/8250/8250_omap.c
> @@ -1617,7 +1617,7 @@ static int omap8250_suspend(struct device *dev)
>  {
>  	struct omap8250_priv *priv = dev_get_drvdata(dev);
>  	struct uart_8250_port *up = serial8250_get_port(priv->line);
> -	int err;
> +	int err = 0;
>  
>  	serial8250_suspend_port(priv->line);
>  
> @@ -1627,7 +1627,8 @@ static int omap8250_suspend(struct device *dev)
>  	if (!device_may_wakeup(dev))
>  		priv->wer = 0;
>  	serial_out(up, UART_OMAP_WER, priv->wer);
> -	err = pm_runtime_force_suspend(dev);
> +	if (uart_console(&up->port) && console_suspend_enabled)
> +		err = pm_runtime_force_suspend(dev);
>  	flush_work(&priv->qos_work);
>  
>  	return err;
> @@ -1636,11 +1637,15 @@ static int omap8250_suspend(struct device *dev)
>  static int omap8250_resume(struct device *dev)
>  {
>  	struct omap8250_priv *priv = dev_get_drvdata(dev);
> +	struct uart_8250_port *up = serial8250_get_port(priv->line);
>  	int err;
>  
> -	err = pm_runtime_force_resume(dev);
> -	if (err)
> -		return err;
> +	if (uart_console(&up->port) && console_suspend_enabled) {
> +		err = pm_runtime_force_resume(dev);
> +		if (err)
> +			return err;
> +	}
> +
>  	serial8250_resume_port(priv->line);
>  	/* Paired with pm_runtime_resume_and_get() in omap8250_suspend() */
>  	pm_runtime_mark_last_busy(dev);
> @@ -1717,16 +1722,6 @@ static int omap8250_runtime_suspend(struct device *dev)
>  
>  	if (priv->line >= 0)
>  		up = serial8250_get_port(priv->line);
> -	/*
> -	 * When using 'no_console_suspend', the console UART must not be
> -	 * suspended. Since driver suspend is managed by runtime suspend,
> -	 * preventing runtime suspend (by returning error) will keep device
> -	 * active during suspend.
> -	 */
> -	if (priv->is_suspending && !console_suspend_enabled) {
> -		if (up && uart_console(&up->port))
> -			return -EBUSY;
> -	}
>  
>  	if (priv->habit & UART_ERRATA_CLOCK_DISABLE) {
>  		int ret;


