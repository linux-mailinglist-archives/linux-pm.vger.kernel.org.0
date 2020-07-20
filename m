Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5657F22571F
	for <lists+linux-pm@lfdr.de>; Mon, 20 Jul 2020 07:40:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726419AbgGTFjk (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 20 Jul 2020 01:39:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726307AbgGTFjk (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 20 Jul 2020 01:39:40 -0400
Received: from mail-vk1-xa42.google.com (mail-vk1-xa42.google.com [IPv6:2607:f8b0:4864:20::a42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF75CC0619D4
        for <linux-pm@vger.kernel.org>; Sun, 19 Jul 2020 22:39:39 -0700 (PDT)
Received: by mail-vk1-xa42.google.com with SMTP id t187so3418680vke.5
        for <linux-pm@vger.kernel.org>; Sun, 19 Jul 2020 22:39:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=Mra/ak9D1+r3t7wzeEyhfxM6IMDYdP7DqDfcxJZ5WCA=;
        b=q/BeaS6UMn4+h7XAy10XUDWX0sTf0GOY6JjFrVVsyzaFn5scLjVx6NpXfZpbWZSW3I
         DhbYEXoJOV3WSsOZbdu44Z8teUBZNSupURzgAHu6Bo33JbJQxzj09w412BJ7xhhR5l4a
         cTk8QdN13dvQSeGgQjrHLmkCFaPls0hPoxsg7LvhjcuTLQob36unB9kWB6vcKnHm6o2j
         ibxieKxN6dl1NQopfoaCYTPmumk26LfNwtBAGWBAcQIXo9gTf9GFW1k1hkHsiRS9x649
         lBi4ja7HhiihDwb/8nSneVhtWisEX6G3seVWAq3J+OupTWiEqh3XrsheQmgVWAugC86L
         GQwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=Mra/ak9D1+r3t7wzeEyhfxM6IMDYdP7DqDfcxJZ5WCA=;
        b=me1PiSMwH/aaCWLQTsRQwcdIE0pZGRSB+Z2eecYJbrCgVF3XoAupVG99WzzwBr6t2I
         XyIzGG0Pc9E9pz4Ug0IFW3E9cci6UYl+CzZPjavg5GN1w++3xLWTzZqha4Hr4rtRoSv1
         vAJ2LcCst9Cr6PtGQJEUYhpRZLKX4fi+fIj2tZPwNyN1U/Z1SLV2QRNjyA645q9eUVpJ
         oPIM86VPiBZhmRjJhPEJIQGfAUQrywLFE1kFEt/DmMd+quYukr+6dlS0+CVAFWIExD3c
         zuiIDrRy5PjwiZ5ZAVgx5MXSZrJ3blZj9m0Bq7UxgDXayGK6vgifmY7SFIdaYU011j5g
         Na9A==
X-Gm-Message-State: AOAM532n973RSevGzdw6vMsgKhxQDaLmqIDgW2m1J8SNbW0Nhu7YsSlx
        P6SjZVbotF02lg4RA9QjIH01THVtRw3o53DCUKjUiCwE/YRpJQ==
X-Google-Smtp-Source: ABdhPJwSL6+wbKxKzMbtERU799L37vOP/8fRp8XD+9XcElsSqaL4bAmBMNeevdVdVjS+F17sPVX7xGuiPuIkJ6k33wg=
X-Received: by 2002:a1f:f848:: with SMTP id w69mr15006496vkh.86.1595223578965;
 Sun, 19 Jul 2020 22:39:38 -0700 (PDT)
MIME-Version: 1.0
References: <20200717164217.18819-1-daniel.lezcano@linaro.org> <20200717164217.18819-2-daniel.lezcano@linaro.org>
In-Reply-To: <20200717164217.18819-2-daniel.lezcano@linaro.org>
From:   Amit Kucheria <amit.kucheria@linaro.org>
Date:   Mon, 20 Jul 2020 11:09:26 +0530
Message-ID: <CAHLCerNbA+cQJB++xbSaKhANX3n0PhCwgBL8Qeg4ZPDaUOcBBQ@mail.gmail.com>
Subject: Re: [PATCH 2/2] thermal: core: Move initialization after core initcall
To:     Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     Zhang Rui <rui.zhang@intel.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux PM list <linux-pm@vger.kernel.org>,
        Marek Szyprowski <m.szyprowski@samsung.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Fri, Jul 17, 2020 at 10:12 PM Daniel Lezcano
<daniel.lezcano@linaro.org> wrote:
>
> The generic netlink is initialized at subsys_initcall, so far after
> the thermal init routine and the thermal generic netlink family
> initialization.
>
> On =C5=9Dome platforms, that leads to a memory corruption.
>
> The fix was sent to netdev@ to move the genetlink framework
> initialization at core_initcall.
>
> Move the thermal core initialization to postcore level which is very
> close to core level.
>
> Reported-by: Marek Szyprowski <m.szyprowski@samsung.com>
> Tested-by: Marek Szyprowski <m.szyprowski@samsung.com>
> Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
> ---
>  drivers/thermal/thermal_core.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/thermal/thermal_core.c b/drivers/thermal/thermal_cor=
e.c
> index c2e7d7aaa354..79551bb6cd4c 100644
> --- a/drivers/thermal/thermal_core.c
> +++ b/drivers/thermal/thermal_core.c
> @@ -1617,4 +1617,4 @@ static int __init thermal_init(void)
>         mutex_destroy(&poweroff_lock);
>         return result;
>  }
> -core_initcall(thermal_init);
> +postcore_initcall(thermal_init);

For posterity, we moved to core_initcall from fs_initcall since we had
removed netlink support from the thermal framework and we wanted to
initialise it as quickly as possible after cpufreq to allow early
mitigation possibility.

Given the addition of the new netlink-based API to thermal framework,
I think moving to postcore_initcall is an acceptable compromise.

Reviewed-by: Amit Kucheria <amit.kucheria@linaro.org>

> --
> 2.17.1
>
