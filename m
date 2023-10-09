Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 75B6E7BE44A
	for <lists+linux-pm@lfdr.de>; Mon,  9 Oct 2023 17:14:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377742AbjJIPOb (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 9 Oct 2023 11:14:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376488AbjJIPOJ (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 9 Oct 2023 11:14:09 -0400
Received: from relay7-d.mail.gandi.net (relay7-d.mail.gandi.net [217.70.183.200])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3D4CE1;
        Mon,  9 Oct 2023 08:13:56 -0700 (PDT)
Received: by mail.gandi.net (Postfix) with ESMTPSA id 8696A20008;
        Mon,  9 Oct 2023 15:13:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1696864434;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=qXkxOiYSFneTGLhk5il+8SZPucsOCBsZOYZ/HrPz4DA=;
        b=odLtLQNAUf7WSgCe5nu+P4zzFmfpRimsiVBXhYJbezc11TiAcFzcjdOBJ5Z68HDQ2aqOCa
        Q8DbEb544MwpITwL1g5S9P2WrWhWgsODl4V9xkkdcz6SkJ0WD2AdjE4jm1EvvEX8gVswrh
        RGCKYRavraWFYQB6k2NSJ84WNMAyiUxoyFasL3gPj/UKbgjtdnp1r+t/tBesg9eaOWOvWW
        ZkZwJMkMbKxrr6Gb39k2UhwwkT7rlOzR2nrWMTfk5WCnf2Gcxu86ggjV+0YXsMm9LNNiWW
        j8TSEhaJ3HIaa0yU3ESkhQefQUBlzqlNfnngLtv0VrTQhyHNFQ0o6vvubRm+Ig==
Message-ID: <a5bee830-07af-426b-94ac-3574cba34bec@bootlin.com>
Date:   Mon, 9 Oct 2023 17:13:52 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
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
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
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

If I understand correctly, there are 2 solutions to keep the power
domain on through.
The first one is to set the flag GENPD_FLAG_ALWAYS_ON for the power domain.
The second one is to set the wakup_path of the device (using
device_set_wakeup_path) and set the flag GENPD_FLAG_ACTIVE_WAKEUP to the
power domain.

I didn't found any flag or option to say that the device is not
suspended, but it is not an error, so we don't want to poweroff the
power domain.

Regards,

Thomas

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
