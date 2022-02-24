Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 96DF84C2ECB
	for <lists+linux-pm@lfdr.de>; Thu, 24 Feb 2022 15:59:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235674AbiBXO7U (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 24 Feb 2022 09:59:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235688AbiBXO7R (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 24 Feb 2022 09:59:17 -0500
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [46.235.227.227])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A723219D74F
        for <linux-pm@vger.kernel.org>; Thu, 24 Feb 2022 06:58:46 -0800 (PST)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: dmitry.osipenko)
        with ESMTPSA id 96D8E1F4540E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1645714724;
        bh=IeWAJ6+0kV9//YdeI9Wx/ykuYDS3fzJXrOZp0XCf7ng=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=Wrk1UmcknMlSSoonVZBEScxNZtmPMkeZAQk/Nhm0oisWUJZxXaI2i7XyA7WJZ2cqE
         A3aCYhddKnAJy8fx1DKzrNiHELaq8aXLg3jGMw8EtAaoGPvbz/bTcZqhqC3zyXOouB
         TlcGWtBOBkCNKL7RkeUQ/CaFHUBJ21h7XO9NJ9EZvBjIaFqlVzP7gIHWd7P0kQiwyc
         8yMUk3X01NPBw9pF6c85AAmiUQJ52o06FuIjaYWrAOrxyyVAizDSnZyjGvpGNotBts
         SGfg4hLzteqgKj//UbALBWEGZzdo/lOD2YduIRjBtTeNwveRZKvQTa9TKcF7sXizce
         PTzpAleFOqNkA==
Message-ID: <dc390e51-979f-95e4-d184-24e00879fc48@collabora.com>
Date:   Thu, 24 Feb 2022 17:58:41 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH] power: supply: Use an rbtree rather than flat register
 cache
Content-Language: en-US
To:     Mark Brown <broonie@kernel.org>,
        Dmitry Osipenko <digetx@gmail.com>,
        Sebastian Reichel <sre@kernel.org>
Cc:     linux-pm@vger.kernel.org
References: <20220222214331.1557723-1-broonie@kernel.org>
From:   Dmitry Osipenko <dmitry.osipenko@collabora.com>
In-Reply-To: <20220222214331.1557723-1-broonie@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 2/23/22 00:43, Mark Brown wrote:
> The smb347 has a very sparse register map (the maximum register is 0x3f but
> less than 10% of the possible registers appear to be defined) and doesn't
> have any hardware defaults specified so the sparser data structure of an
> rbtree is a better fit for it's needs than a flat cache. Since it uses I2C
> for the control interface there is no performance concern with the slightly
> more involved code so let's convert it.
> 
> This will mean we avoid any issues created by assuming that any previously
> unaccessed registers hold a value that doesn't match what's in the hardware
> (eg, an _update_bits() suppressing a write).
> 
> Signed-off-by: Mark Brown <broonie@kernel.org>
> ---
>  drivers/power/supply/smb347-charger.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/drivers/power/supply/smb347-charger.c b/drivers/power/supply/smb347-charger.c
> index d56e469043bb..1511f71f937c 100644
> --- a/drivers/power/supply/smb347-charger.c
> +++ b/drivers/power/supply/smb347-charger.c
> @@ -1488,8 +1488,7 @@ static const struct regmap_config smb347_regmap = {
>  	.max_register	= SMB347_MAX_REGISTER,
>  	.volatile_reg	= smb347_volatile_reg,
>  	.readable_reg	= smb347_readable_reg,
> -	.cache_type	= REGCACHE_FLAT,
> -	.num_reg_defaults_raw = SMB347_MAX_REGISTER,
> +	.cache_type	= REGCACHE_RBTREE,
>  };
>  
>  static const struct regulator_ops smb347_usb_vbus_regulator_ops = {

Tested-by: Dmitry Osipenko <dmitry.osipenko@collabora.com>
