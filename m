Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4CE1146C304
	for <lists+linux-pm@lfdr.de>; Tue,  7 Dec 2021 19:41:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240646AbhLGSpH (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 7 Dec 2021 13:45:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240634AbhLGSpH (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 7 Dec 2021 13:45:07 -0500
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0CD1C061574
        for <linux-pm@vger.kernel.org>; Tue,  7 Dec 2021 10:41:36 -0800 (PST)
Received: by mail-lf1-x129.google.com with SMTP id b1so326977lfs.13
        for <linux-pm@vger.kernel.org>; Tue, 07 Dec 2021 10:41:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=sNKguMW+u5SvzONn4ivanKXtsjFVQkC6LMddUtJSEUk=;
        b=aDIAN17BKGq0GIN+YPIlQpFEpU4IUGBEknSlUTURp1gnh6I71NueXG/IAR3kdGGdnb
         LXMkE3sM3iS1y3vT4KBCqNdcAzBh0GwpFSY5BZemA+TV9dieQBcMWd4/UUeLInNlkuQW
         Bf+QMp2p6J6HDkVKgrVYIl6fLaEjWgoqLxuWNHZp7QGVxyaXHU2M2pLj7KRcT6w9jvpe
         O5LW/kXKV27CBR25kEBseIpFQxdPcpxkMwlMKja49bqU9dOWidyseQGcyzsz6F4R1qO8
         wHM04ZWGdvFpC4HyJWrMHKaz3QULjsP6DkWcM+Q/H1pkgRGltpi1JaMR6nA+D/q3r45P
         tNuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=sNKguMW+u5SvzONn4ivanKXtsjFVQkC6LMddUtJSEUk=;
        b=bY8PqvGrAaV7r+5hFFUb1qjsddkFXqQRGiKeLevkr3F1/oZ/jprzCTRwmseYg/hunV
         dLmE4NE2fQKMxyhIUFrMFtsO7mWMEGNOz9w+c7pNdGVZ9edn8Div+1zqCkw4LZjWo8pO
         /rwVohYKWM2/+sHncwee9mrZUo8KMi3onUY1wriLjkgO3yvBot+P3Jq0F5928AbXGrTM
         VjcCG3J2+o+9Ppl2RbF6Oprq22aTZkxxgPvEwJdfRTMyqpF0gv7kTBAndzaBEjI9lzTw
         wBWnGKBeyTr7fM0/We3Z9uECkDBn0WQjenVQWCThCTM9NitbCA28bLc/P0wynMCNxZcx
         JGPg==
X-Gm-Message-State: AOAM5334CIJfmNVe1BRbULLXMEqQL07i30a5WCOesLhwunK1MCRnliPO
        igYA9co5aChPdyGhUV5bmxeWrhXA0JNgIx1CswPMNZ32jkwltw==
X-Google-Smtp-Source: ABdhPJyeHj3lrlUlDby3ennl3ufCpDgdCUvs6c7j5SLDxK90H6tLe6REyxb4vxCtSTv4FGgP01zjRMahD5LyaHn+DeQ=
X-Received: by 2002:a05:6512:3d16:: with SMTP id d22mr41550500lfv.523.1638902494780;
 Tue, 07 Dec 2021 10:41:34 -0800 (PST)
MIME-Version: 1.0
References: <20211204220249.591482-1-arnd@kernel.org>
In-Reply-To: <20211204220249.591482-1-arnd@kernel.org>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Tue, 7 Dec 2021 10:41:24 -0800
Message-ID: <CAKwvOdnZSyfZaa1crQ15DGNNj8JBspnM0xxOF3D2mTt96Ftfgw@mail.gmail.com>
Subject: Re: [PATCH] power: reset: ltc2952: fix float conversion error
To:     Arnd Bergmann <arnd@kernel.org>
Cc:     Sebastian Reichel <sre@kernel.org>,
        =?UTF-8?Q?Ren=C3=A9_Moll?= <Rene.Moll@xsens.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Nathan Chancellor <nathan@kernel.org>,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Sat, Dec 4, 2021 at 2:02 PM Arnd Bergmann <arnd@kernel.org> wrote:
>
> From: Arnd Bergmann <arnd@arndb.de>
>
> clang-14 does not like the way this driver converts a 'long double'
> to an integer when the target architecture disables floating point
> support:
>
> drivers/power/reset/ltc2952-poweroff.c:162:28: error: expression requires  'long double' type support, but target 'x86_64-unknown-linux' does not support it
>         data->wde_interval = 300L * 1E6L;
>                                   ^
>
> Turn this into pure integer math and make it more readable at the
> same time using the NSEC_PER_MSEC macro instead.
>
> Fixes: 6647156c00cc ("power: reset: add LTC2952 poweroff driver")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Thanks for the patch! The change in clang-14 (ToT) that triggered this
has had another patch on top reverting these diagnostics.
https://reviews.llvm.org/D114162

That said, this change is still worthwhile for the improved semantics, IMO.

Link: https://github.com/ClangBuiltLinux/linux/issues/1497
Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>

> ---
>  drivers/power/reset/ltc2952-poweroff.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/power/reset/ltc2952-poweroff.c b/drivers/power/reset/ltc2952-poweroff.c
> index fbb344353fe4..9fc88a9f244c 100644
> --- a/drivers/power/reset/ltc2952-poweroff.c
> +++ b/drivers/power/reset/ltc2952-poweroff.c
> @@ -159,8 +159,8 @@ static void ltc2952_poweroff_kill(void)
>
>  static void ltc2952_poweroff_default(struct ltc2952_poweroff *data)
>  {
> -       data->wde_interval = 300L * 1E6L;
> -       data->trigger_delay = ktime_set(2, 500L*1E6L);
> +       data->wde_interval = 300 * NSEC_PER_MSEC;
> +       data->trigger_delay = ktime_set(2, 500 * NSEC_PER_MSEC);
>
>         hrtimer_init(&data->timer_trigger, CLOCK_MONOTONIC, HRTIMER_MODE_REL);
>         data->timer_trigger.function = ltc2952_poweroff_timer_trigger;
> --
> 2.29.2
>


-- 
Thanks,
~Nick Desaulniers
