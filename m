Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7F1667C3A4
	for <lists+linux-pm@lfdr.de>; Wed, 31 Jul 2019 15:33:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729604AbfGaNdt (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 31 Jul 2019 09:33:49 -0400
Received: from mo4-p01-ob.smtp.rzone.de ([85.215.255.53]:16005 "EHLO
        mo4-p01-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727809AbfGaNds (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 31 Jul 2019 09:33:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1564580026;
        s=strato-dkim-0002; d=fpond.eu;
        h=Subject:References:In-Reply-To:Message-ID:Cc:To:From:Date:
        X-RZG-CLASS-ID:X-RZG-AUTH:From:Subject:Sender;
        bh=vsqdssxoLg7iBeNDj9knGPs6ySoH0oA9fTal8KVdSQY=;
        b=eYzQrAVJyAhgUfobwzOO6AeVx235DGJAEkT7cWyoL3R3sb19W6mh1rNNNuFPHWPQVD
        MYxuEmUoH4U8G6DUGfRGiDgdKSXM96tLSp/m4P8zDEOXwHEE9/EWLb6SK7SGckneKChx
        GoVzMzU9weaIcC6xtKXiz0aVHA0tG2UcXO/hbAgWYL7bxXsMNEmRUToPcOKC6Hgg6tEM
        LS32nTC1W9TfE+kszANyEr3++DYKp0NB8PBmZmCgHO7nCgPPLcqMZaQxpc4dc4LUiwOw
        tzemuKYFfalVX6+xfcBHWW/zGbfdCTEqFi5RnDOBVVeru9zDsmytQmYcj8W9yJ7fU/Vg
        gdAA==
X-RZG-AUTH: ":OWANVUa4dPFUgKR/3dpvnYP0Np73amq+g13rqGzmt2bYDnKIKaws6YXTsc4="
X-RZG-CLASS-ID: mo00
Received: from oxapp06-03.back.ox.d0m.de
        by smtp-ox.front (RZmta 44.24 AUTH)
        with ESMTPSA id h0a328v6VDUiZTi
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (curve X9_62_prime256v1 with 256 ECDH bits, eq. 3072 bits RSA))
        (Client did not present a certificate);
        Wed, 31 Jul 2019 15:30:44 +0200 (CEST)
Date:   Wed, 31 Jul 2019 15:30:44 +0200 (CEST)
From:   Ulrich Hecht <uli@fpond.eu>
To:     Geert Uytterhoeven <geert+renesas@glider.be>,
        Zhang Rui <rui.zhang@intel.com>,
        Eduardo Valentin <edubezval@gmail.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     Marek Vasut <marek.vasut+renesas@gmail.com>,
        linux-pm@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Message-ID: <51684361.319230.1564579844450@webmail.strato.com>
In-Reply-To: <20190731125053.14750-1-geert+renesas@glider.be>
References: <20190731125053.14750-1-geert+renesas@glider.be>
Subject: Re: [PATCH] thermal: rcar_gen3_thermal: Use
 devm_add_action_or_reset() helper
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Priority: 3
Importance: Medium
X-Mailer: Open-Xchange Mailer v7.10.1-Rev16
X-Originating-IP: 85.212.153.30
X-Originating-Client: open-xchange-appsuite
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


> On July 31, 2019 at 2:50 PM Geert Uytterhoeven <geert+renesas@glider.be> wrote:
> 
> 
> Use the devm_add_action_or_reset() helper instead of open-coding the
> same operations.
> 
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> ---
>  drivers/thermal/rcar_gen3_thermal.c | 7 +++----
>  1 file changed, 3 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/thermal/rcar_gen3_thermal.c b/drivers/thermal/rcar_gen3_thermal.c
> index a56463308694e937..2db7e7f8baf939fd 100644
> --- a/drivers/thermal/rcar_gen3_thermal.c
> +++ b/drivers/thermal/rcar_gen3_thermal.c
> @@ -443,11 +443,10 @@ static int rcar_gen3_thermal_probe(struct platform_device *pdev)
>  		if (ret)
>  			goto error_unregister;
>  
> -		ret = devm_add_action(dev, rcar_gen3_hwmon_action, zone);
> -		if (ret) {
> -			rcar_gen3_hwmon_action(zone);
> +		ret = devm_add_action_or_reset(dev, rcar_gen3_hwmon_action,
> +					       zone);
> +		if (ret)
>  			goto error_unregister;
> -		}
>  
>  		ret = of_thermal_get_ntrips(tsc->zone);
>  		if (ret < 0)
> -- 
> 2.17.1
>

Reviewed-by: Ulrich Hecht <uli+renesas@fpond.eu>

CU
Uli
