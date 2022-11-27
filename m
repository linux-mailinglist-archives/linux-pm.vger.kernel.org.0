Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 986DF639D58
	for <lists+linux-pm@lfdr.de>; Sun, 27 Nov 2022 22:36:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229726AbiK0VgL (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 27 Nov 2022 16:36:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229618AbiK0VgJ (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 27 Nov 2022 16:36:09 -0500
Received: from phobos.denx.de (phobos.denx.de [IPv6:2a01:238:438b:c500:173d:9f52:ddab:ee01])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75FD6DF61
        for <linux-pm@vger.kernel.org>; Sun, 27 Nov 2022 13:36:08 -0800 (PST)
Received: from [127.0.0.1] (p578adb1c.dip0.t-ipconnect.de [87.138.219.28])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: marex@denx.de)
        by phobos.denx.de (Postfix) with ESMTPSA id 4369F850EB;
        Sun, 27 Nov 2022 22:36:06 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
        s=phobos-20191101; t=1669584966;
        bh=pWp+xTFUYxzuz3AagOFcaKUWyKacgrfG32VP9Ps2ZMg=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=qvqpuynQ/3TOh8fc8ZcTfTA98qHGgRmMf09Rh0qzLiTUENGYfr0C1RbnjcMeK5cNH
         VGIJK81Viexc4g8dqGMOl4mMdSfudHD+f4e7jLGyoF5qqcHTBrsq2/G7G/rI3Iu5rp
         ga5EjijPzuBeG+a5CEaYS5S1msKV2nHVhbAjvn+pOdfvWibS1eeNcHXY/TRwaPUipO
         l+UntOn4dRzZC8IslQc2QPfy5l0/EgPYYlm612VP6qB58jAECv2n/j+6TZrANfTd/U
         YJ4Su+uKxbOgmUFtgsgzWMyOMCaDs1ewrYyhGdmd5UvIQh+UQ6uF/Pr6PTh5avq50X
         S/iyK6d8D4scA==
Message-ID: <37d21fd9-cd80-45c0-695b-bc121c43833b@denx.de>
Date:   Sun, 27 Nov 2022 22:19:37 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH 03/10] power: supply: bq25890: Fix usb-notifier probe and
 remove races
Content-Language: en-US
To:     Hans de Goede <hdegoede@redhat.com>,
        Sebastian Reichel <sre@kernel.org>
Cc:     linux-pm@vger.kernel.org
References: <20221127180233.103678-1-hdegoede@redhat.com>
 <20221127180233.103678-4-hdegoede@redhat.com>
From:   Marek Vasut <marex@denx.de>
In-Reply-To: <20221127180233.103678-4-hdegoede@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Virus-Scanned: clamav-milter 0.103.6 at phobos.denx.de
X-Virus-Status: Clean
X-Spam-Status: No, score=-4.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 11/27/22 19:02, Hans de Goede wrote:
> There are 2 races surrounding the usb-notifier:
> 
> 1. The notifier, and thus usb_work, may run before the bq->charger
>     power_supply class device is registered. But usb_work may call
>     power_supply_changed() which relies on the psy device being registered.
> 
> 2. usb_work may be pending/running at remove() time, so it needs to be
>     cancelled on remove after unregistering the usb-notifier.
> 
> Fix 1. by moving usb-notifier registration to after the power_supply
> registration.
> 
> Fix 2. by adding a cancel_work_sync() call directly after the usb-notifier
> unregistration.
> 
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
> ---
>   drivers/power/supply/bq25890_charger.c | 26 +++++++++++---------------
>   1 file changed, 11 insertions(+), 15 deletions(-)
> 
> diff --git a/drivers/power/supply/bq25890_charger.c b/drivers/power/supply/bq25890_charger.c
> index 30d77afab839..032a10a3877b 100644
> --- a/drivers/power/supply/bq25890_charger.c
> +++ b/drivers/power/supply/bq25890_charger.c
> @@ -1387,16 +1387,10 @@ static int bq25890_probe(struct i2c_client *client)
>   	if (ret)
>   		return ret;
>   
> -	if (!IS_ERR_OR_NULL(bq->usb_phy)) {
> -		INIT_WORK(&bq->usb_work, bq25890_usb_work);
> -		bq->usb_nb.notifier_call = bq25890_usb_notifier;
> -		usb_register_notifier(bq->usb_phy, &bq->usb_nb);
> -	}
> -
>   	ret = bq25890_power_supply_init(bq);
>   	if (ret < 0) {
>   		dev_err(dev, "Failed to register power supply\n");
> -		goto err_unregister_usb_notifier;
> +		return ret;

You can even use 'return dev_err_probe()' above ^ to simplify that piece 
of code now.

Reviewed-by: Marek Vasut <marex@denx.de>
