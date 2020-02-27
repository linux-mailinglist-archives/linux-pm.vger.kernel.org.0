Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9071B1729D2
	for <lists+linux-pm@lfdr.de>; Thu, 27 Feb 2020 22:00:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729534AbgB0VAn (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 27 Feb 2020 16:00:43 -0500
Received: from relay10.mail.gandi.net ([217.70.178.230]:54709 "EHLO
        relay10.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728059AbgB0VAm (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 27 Feb 2020 16:00:42 -0500
Received: from webmail.gandi.net (webmail15.sd4.0x35.net [10.200.201.15])
        (Authenticated sender: contact@artur-rojek.eu)
        by relay10.mail.gandi.net (Postfix) with ESMTPA id 4EB61240009;
        Thu, 27 Feb 2020 21:00:39 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Thu, 27 Feb 2020 22:00:39 +0100
From:   Artur Rojek <contact@artur-rojek.eu>
To:     Paul Cercueil <paul@crapouillou.net>
Cc:     Sebastian Reichel <sre@kernel.org>, od@zcrc.me,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] power/supply: ingenic-battery: Don't print error on
 -EPROBE_DEFER
In-Reply-To: <20200221005812.271187-1-paul@crapouillou.net>
References: <20200221005812.271187-1-paul@crapouillou.net>
Message-ID: <b90a4280727ee030fafb99a30a48c256@artur-rojek.eu>
X-Sender: contact@artur-rojek.eu
User-Agent: Roundcube Webmail/1.3.8
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 2020-02-21 01:58, Paul Cercueil wrote:
> Don't print an error message if devm_power_supply_register() returns
> -EPROBE_DEFER, since the driver will simply re-probe later.
Hi Paul.

This looks alright.

Acked-by: Artur Rojek <contact@artur-rojek.eu>
> 
> Signed-off-by: Paul Cercueil <paul@crapouillou.net>
> ---
>  drivers/power/supply/ingenic-battery.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/power/supply/ingenic-battery.c
> b/drivers/power/supply/ingenic-battery.c
> index 2748715c4c75..dd3d93dfe3eb 100644
> --- a/drivers/power/supply/ingenic-battery.c
> +++ b/drivers/power/supply/ingenic-battery.c
> @@ -148,7 +148,8 @@ static int ingenic_battery_probe(struct
> platform_device *pdev)
> 
>  	bat->battery = devm_power_supply_register(dev, desc, &psy_cfg);
>  	if (IS_ERR(bat->battery)) {
> -		dev_err(dev, "Unable to register battery\n");
> +		if (PTR_ERR(bat->battery) != -EPROBE_DEFER)
> +			dev_err(dev, "Unable to register battery\n");
>  		return PTR_ERR(bat->battery);
>  	}
