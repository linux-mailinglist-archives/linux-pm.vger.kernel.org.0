Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AA891382A17
	for <lists+linux-pm@lfdr.de>; Mon, 17 May 2021 12:47:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236448AbhEQKsT (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 17 May 2021 06:48:19 -0400
Received: from mo4-p02-ob.smtp.rzone.de ([81.169.146.170]:17064 "EHLO
        mo4-p02-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236428AbhEQKsT (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 17 May 2021 06:48:19 -0400
X-Greylist: delayed 346 seconds by postgrey-1.27 at vger.kernel.org; Mon, 17 May 2021 06:48:18 EDT
ARC-Seal: i=1; a=rsa-sha256; t=1621248417; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=blPaPw4cWrZzAIv/6IGKLWTffQ4OGNJm6mUWgTb+S+mEWCpU6gLgQPpYPhrg80IoGg
    zGfReD8M6RCPVvM4wLCcNPDdo1jcDMB1gmaI5Yns4HCYbW3BEkJPCzG/UWOzVR0mFi9M
    HnjKFtBUOY55blkBUflbVgSvz+aUoZr9HptyEoU65U9pXrfLezJnF3kQKiOO74rRaDQy
    SIQKwVTXJ+1u20E2VoqmayHqVRGW94rW3RMhKRnT0qV09ki90L2HKA1dmHH3rj+YMMFq
    8GM+5i9dcnzAMFvz6BrCmTP33+v9KC07hyONNfa67gJr6AxbMY0gvytb/U8B94vXGtfm
    mmvQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1621248417;
    s=strato-dkim-0002; d=strato.com;
    h=In-Reply-To:References:Message-ID:Subject:Cc:To:From:Date:Cc:Date:
    From:Subject:Sender;
    bh=xLtv022EjVVMZwh7VCsxd2EezEPBtYpPykabQ0EMh4Y=;
    b=ZezRGBOnRXXycL3/KtlylAcElsAVFbcPAGVnivfBw+b8cTxGLBgOv4YE33QGXsm16T
    o363Y/0cXTLmGAoAGOJQj6CQXMT5bRbYIIWRhKSe2l6udZaxjwQECgEkA2VyMBAFwaFJ
    aQsksM78Upy5uqNdmObuzEO4TBjRnCbySRecN89Yht1qR0z8G6FvBOZsBmXIHU9hzJYG
    1vGZlbq9coBGjvEsKHpsNRawim/odjUSprwsbUZ7JvFNvmbz8szTI3dO7V6cEK9ggCts
    NlgWC/ngIX2ICprxF/P9+O+QjjBsO6HIgxypV/x0dUztINQ8LehBNsDaz/tED7SPgkwd
    a15g==
ARC-Authentication-Results: i=1; strato.com;
    dkim=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1621248417;
    s=strato-dkim-0002; d=gerhold.net;
    h=In-Reply-To:References:Message-ID:Subject:Cc:To:From:Date:Cc:Date:
    From:Subject:Sender;
    bh=xLtv022EjVVMZwh7VCsxd2EezEPBtYpPykabQ0EMh4Y=;
    b=GDCT2co9EDslJ1rm54sWPJTUEeSXSz5JwQf/6sdBmjGgLnOikKmLaP2P3y1tu1eBHG
    kX9KizuYQuTmUW5xKGU1hgZZDi4BI0B8V7LqUCbHG/VOVHHzGnnsG5yUq+rINAVuWCrO
    /xsWC9G2IKWdLT+M+BE1/hcsB95bsyeLP0c8l1c++xPzuIttv7hXVGTmNsAHLr+OVhqg
    ByaHMxe6215HWOOI9EgNl5BW0FqFbavFYydzU+WryQ2M+3HILnbgEnSYZLLBHXDRWQWc
    16Q9Q8MU7BVlqVZMF2W/mBz6ClRhek5OvWya6x4HrVbHQPL5CfCeI/suMKOSPaa3Dcvw
    R72g==
Authentication-Results: strato.com;
    dkim=none
X-RZG-AUTH: ":P3gBZUipdd93FF5ZZvYFPugejmSTVR2nRPhVOQ/OcYgojyw4j34+u26zEodhPgRDZ8j9Ic/Da4o="
X-RZG-CLASS-ID: mo00
Received: from gerhold.net
    by smtp.strato.de (RZmta 47.26.0 DYNA|AUTH)
    with ESMTPSA id 50be75x4HAkv1T5
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
    Mon, 17 May 2021 12:46:57 +0200 (CEST)
Date:   Mon, 17 May 2021 12:46:53 +0200
From:   Stephan Gerhold <stephan@gerhold.net>
To:     Sebastian Reichel <sre@kernel.org>,
        Lee Jones <lee.jones@linaro.org>
Cc:     Rob Herring <robh+dt@kernel.org>, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Beomho Seo <beomho.seo@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>
Subject: Re: [PATCH 2/3] power: supply: rt5033_battery: Fix device tree
 enumeration
Message-ID: <YKJJnRI0Jt/OdMJv@gerhold.net>
References: <20210517103554.168159-1-stephan@gerhold.net>
 <20210517103554.168159-3-stephan@gerhold.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210517103554.168159-3-stephan@gerhold.net>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Mon, May 17, 2021 at 12:35:53PM +0200, Stephan Gerhold wrote:
> The fuel gauge in the RT5033 PMIC has its own I2C bus and interrupt
> line. Therefore, it is not actually part of the RT5033 MFD and needs
> its own of_match_table to probe properly.
> 
> Also, given that it's independent of the MFD, there is actually
> no need to make the Kconfig depend on MFD_RT5033. Although the driver
> uses the shared <linux/mfd/rt5033.h> header, there is no compile
> or runtime dependency on the RT5033 MFD driver.
> 
> Cc: Beomho Seo <beomho.seo@samsung.com>
> Cc: Chanwoo Choi <cw00.choi@samsung.com>
> Fixes: b847dd96e659 ("power: rt5033_battery: Add RT5033 Fuel gauge device driver")
> Signed-off-by: Stephan Gerhold <stephan@gerhold.net>
> ---
>  drivers/power/supply/Kconfig          | 3 ++-
>  drivers/power/supply/rt5033_battery.c | 7 +++++++
>  2 files changed, 9 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/power/supply/Kconfig b/drivers/power/supply/Kconfig
> index e696364126f1..20a2f93252f9 100644
> --- a/drivers/power/supply/Kconfig
> +++ b/drivers/power/supply/Kconfig
> @@ -712,7 +712,8 @@ config BATTERY_GOLDFISH
>  
>  config BATTERY_RT5033
>  	tristate "RT5033 fuel gauge support"
> -	depends on MFD_RT5033
> +	depends on I2C
> +	select REGMAP_I2C
>  	help
>  	  This adds support for battery fuel gauge in Richtek RT5033 PMIC.
>  	  The fuelgauge calculates and determines the battery state of charge
> diff --git a/drivers/power/supply/rt5033_battery.c b/drivers/power/supply/rt5033_battery.c
> index f330452341f0..11eb9ad66ea9 100644
> --- a/drivers/power/supply/rt5033_battery.c
> +++ b/drivers/power/supply/rt5033_battery.c
> @@ -164,9 +164,16 @@ static const struct i2c_device_id rt5033_battery_id[] = {
>  };
>  MODULE_DEVICE_TABLE(i2c, rt5033_battery_id);
>  
> +static const struct of_device_id rt5033_battery_of_match[] = {
> +	{ .compatible = "richtek,rt5033-battery", },
> +	{ }
> +};
> +MODULE_DEVICE_TABLE(of, rt5033_battery_dt_match);

s/dt_match/of_match

Ugh, I shouldn't do any last-minute renames and then only compile-test
with modules disabled. :(

Sorry, please ignore this one, will send a v2 shortly...

Stephan
