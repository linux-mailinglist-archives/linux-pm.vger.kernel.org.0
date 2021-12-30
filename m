Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B9CB3481DBF
	for <lists+linux-pm@lfdr.de>; Thu, 30 Dec 2021 16:37:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234936AbhL3Phc convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-pm@lfdr.de>); Thu, 30 Dec 2021 10:37:32 -0500
Received: from mail-qv1-f48.google.com ([209.85.219.48]:43895 "EHLO
        mail-qv1-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233176AbhL3Phc (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 30 Dec 2021 10:37:32 -0500
Received: by mail-qv1-f48.google.com with SMTP id fq10so22383377qvb.10
        for <linux-pm@vger.kernel.org>; Thu, 30 Dec 2021 07:37:31 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=eQnoNOmsZKy/dAmyzh07xfQRr2pNe7Li+DIe+eUk4RM=;
        b=chCg5yOwL8hs/OFGMprkdoBILMqm8p3FygJUVhvyZZFcPnUWFe8EG3SJll9+0PQCVK
         G+LWikGv+m4I5jSswFujI2+W1QMXaGJYZpnXm9FxTsKxZdt7IugmgAnTSiy5mAaA3cRp
         kHLh3qUp3qweRuAQ4dfJhnNIUiOzocPK7kug2GJwzb2EWVwaRqgVLZ2Qqu6LxiTlNovr
         rAr1vBnuMMFXKdRgQw4nAzvSPO3PZtKw52KZxH2O5RGt5D4OYg3Qmr3Y85tkM94MNbHQ
         XScV4inuOfdRdyP1JDMxgUbGWKkSYso7fgFS41AedsVdmKkIxou5oEz11ndsvckOz/OI
         XKnw==
X-Gm-Message-State: AOAM531zLjEKgA+PH49fLvBqXpgtLlh4bo8fVZQCq4HHZtQeNaLXV46z
        Tb20bxQaW28NFTrQ4ZojHSJh8OioR2kKzLUvx6AZnxkn
X-Google-Smtp-Source: ABdhPJyDAuWTMonLbgmjLj80ka7JjOlLJs83TKCzYRjG28KQ94iT+7s3X/JlIJf+JnOXyE/IyZjRvQ7DDhlYuF/8UQc=
X-Received: by 2002:a05:6214:508f:: with SMTP id kk15mr27656328qvb.61.1640878651598;
 Thu, 30 Dec 2021 07:37:31 -0800 (PST)
MIME-Version: 1.0
References: <20211220215828.189814-1-u.kleine-koenig@pengutronix.de>
In-Reply-To: <20211220215828.189814-1-u.kleine-koenig@pengutronix.de>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Thu, 30 Dec 2021 16:37:20 +0100
Message-ID: <CAJZ5v0hWYJikZnt9NZHv+3GeMCLU-BtQciKcuazEDST_541nEw@mail.gmail.com>
Subject: Re: [PATCH] thermal: Kconfig: simplify dependency of THERMAL_HWMON
To:     =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Amit Kucheria <amitk@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Linux PM <linux-pm@vger.kernel.org>, alvin@alvinhc.com,
        Sascha Hauer <kernel@pengutronix.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Mon, Dec 20, 2021 at 10:58 PM Uwe Kleine-König
<u.kleine-koenig@pengutronix.de> wrote:
>
> THERMAL is bool (since commit 554b3529fe01 ("thermal/drivers/core:
> Remove the module Kconfig's option") in v5.2-rc1) and so cannot be
> configured as a module. As THERMAL_HWMON also depends on THERMAL (via a
> big if block in drivers/thermal/Kconfig) the condition
>
>         depends on HWMON=y || HWMON=THERMAL
>
> is equivalent to the simpler
>
>         depends on HWMON=y
>
> . Use the latter.
>
> Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>

The change looks reasonable to me, but 0-day is evidently unhappy with
it.  Can you have a look at its replies to this message, please?

> ---
> Hello,
>
> I want to use this patch as an opportunity to question if THERMAL being
> a bool and not a tristate is still considered the right thing to do.

IIRC there are correctness concerns regarding modular THERMAL.

> This dependency attracted attention in the context of the armel Debian
> kernel which has HWMON=m for binary size reason. When THERMAL was
> changed to bool this resulted in THERMAL_HWMON not being available any
> more.
>
> Best regards
> Uwe
>
>  drivers/thermal/Kconfig | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/thermal/Kconfig b/drivers/thermal/Kconfig
> index d7f44deab5b1..726bf396c8a9 100644
> --- a/drivers/thermal/Kconfig
> +++ b/drivers/thermal/Kconfig
> @@ -52,7 +52,7 @@ config THERMAL_EMERGENCY_POWEROFF_DELAY_MS
>  config THERMAL_HWMON
>         bool
>         prompt "Expose thermal sensors as hwmon device"
> -       depends on HWMON=y || HWMON=THERMAL
> +       depends on HWMON
>         default y
>         help
>           In case a sensor is registered with the thermal
> --
> 2.33.0
>
