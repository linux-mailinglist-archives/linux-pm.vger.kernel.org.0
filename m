Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A38DC394DB6
	for <lists+linux-pm@lfdr.de>; Sat, 29 May 2021 20:43:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229756AbhE2Spa (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sat, 29 May 2021 14:45:30 -0400
Received: from [94.230.151.217] ([94.230.151.217]:37342 "EHLO ixit.cz"
        rhost-flags-FAIL-FAIL-OK-OK) by vger.kernel.org with ESMTP
        id S229726AbhE2Spa (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Sat, 29 May 2021 14:45:30 -0400
X-Greylist: delayed 513 seconds by postgrey-1.27 at vger.kernel.org; Sat, 29 May 2021 14:45:29 EDT
Received: from [192.168.1.138] (unknown [94.230.151.217])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by ixit.cz (Postfix) with ESMTPSA id 7D90F2391A;
        Sat, 29 May 2021 20:35:17 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ixit.cz; s=dkim;
        t=1622313317;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=yK52KSN1s/wKgo1n+2unPKH1b+jUpi39Qbcn2626kVM=;
        b=CTsMTD/ulF6LTuD6KYsZe7ZGsBetwa6KjxaYgrmHIWT7T7Z00SsFDqkIVAS3wP2x7OPeQ/
        Z+wPYXVvGio6NK+TzJjlKH6O+e9t+cjgy4BVdNjp+xjGKrFQwMiMEr4RgFVJapQH6JnNqe
        n9rHPNk+XqIyQs/rMkN53QodKAqK/sQ=
Date:   Sat, 29 May 2021 20:34:43 +0200
From:   David Heidelberg <david@ixit.cz>
Subject: Re: [PATCH] power: supply: smb347-charger: Drop unused include
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     Sebastian Reichel <sre@kernel.org>, linux-pm@vger.kernel.org,
        Dmitry Osipenko <digetx@gmail.com>
Message-Id: <VXSVTQ.38WWSB60JWLG@ixit.cz>
In-Reply-To: <20210529001902.468060-1-linus.walleij@linaro.org>
References: <20210529001902.468060-1-linus.walleij@linaro.org>
X-Mailer: geary/40.0
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Acked-by: David Heidelberg <david@ixit.cz>
Best regards
David Heidelberg

On Sat, May 29 2021 at 02:19:02 +0200, Linus Walleij 
<linus.walleij@linaro.org> wrote:
> This driver is including the legacy GPIO header <linux/gpio.h>
> but not using any symbols from it. Delete the include.
> 
> Cc: David Heidelberg <david@ixit.cz>
> Cc: Dmitry Osipenko <digetx@gmail.com>
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
> ---
>  drivers/power/supply/smb347-charger.c | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/drivers/power/supply/smb347-charger.c 
> b/drivers/power/supply/smb347-charger.c
> index 3376f42d46c3..df240420f2de 100644
> --- a/drivers/power/supply/smb347-charger.c
> +++ b/drivers/power/supply/smb347-charger.c
> @@ -10,7 +10,6 @@
> 
>  #include <linux/delay.h>
>  #include <linux/err.h>
> -#include <linux/gpio.h>
>  #include <linux/kernel.h>
>  #include <linux/module.h>
>  #include <linux/init.h>
> --
> 2.31.1
> 


