Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 91832278B3B
	for <lists+linux-pm@lfdr.de>; Fri, 25 Sep 2020 16:50:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728693AbgIYOuK convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-pm@lfdr.de>); Fri, 25 Sep 2020 10:50:10 -0400
Received: from mail-ot1-f67.google.com ([209.85.210.67]:33712 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726368AbgIYOuK (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 25 Sep 2020 10:50:10 -0400
Received: by mail-ot1-f67.google.com with SMTP id m12so2559979otr.0;
        Fri, 25 Sep 2020 07:50:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=DD9KHkrgEjO85INACg+anC10SVaoGdHKojOeKrOBrvY=;
        b=sZfRJyCOWwXR43jrtJK+Edk4UkiU6vWAeYuyL8DGSuUrJUYX1wZMmnzBaEOKQ6lWxk
         Ba7zr5v9Wr0i8hDx/2pFE4hxYT9FVawfBOIP7ni/2ku6wcSIxjXhhgvnpjuTq4to5MYe
         ByvYZdAoqZ/bs0uL+izonl5nP8L+eaFcjNrN/Tj1WtZlBF38TKT09IZmDpIcC59TlS+U
         89FNS5Z2SL1v3yni9FvFQpUqCUjI1rzql/Y+s8X3XC3tQ5N0Mf21+apAsj56LG8/bQDN
         NIT6xuMmF61oStIFrUZfZIpCHfJZo9UvpMoLv/KRWM5tlwrBWi5WTDBM8xHinlZVgAcB
         dfDg==
X-Gm-Message-State: AOAM531vqOYdcmMCW3pCU4znbRjY+GF7lyl3da7e4NH4za8kulNbTjBs
        wmSNk3pR9r+yk5pBn/pdHaDZ5ZYsWimmIeBmbJo=
X-Google-Smtp-Source: ABdhPJwINyIYzDim36xJW+5JE9oDdqbLJasat6dwpV5QHJe5jdfFOktYMTv728/Kh2NwTXjGPU/VyyQEmm8Oq08rmC8=
X-Received: by 2002:a05:6830:150a:: with SMTP id k10mr502542otp.167.1601045409451;
 Fri, 25 Sep 2020 07:50:09 -0700 (PDT)
MIME-Version: 1.0
References: <20200922044652.3393-1-shipujin.t@gmail.com>
In-Reply-To: <20200922044652.3393-1-shipujin.t@gmail.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Fri, 25 Sep 2020 16:49:58 +0200
Message-ID: <CAJZ5v0jdcbpOosEgHnc+6FOjJxcH0jCk+GDeh3umfZsrP5JVtw@mail.gmail.com>
Subject: Re: [PATCH v4] powercap: include header to fix -Wmissing-prototypes
To:     Pujin Shi <shipujin.t@gmail.com>
Cc:     "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Herrington <hankinsea@gmail.com>, Pujin Shi <shipj@lemote.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Tue, Sep 22, 2020 at 6:47 AM Pujin Shi <shipujin.t@gmail.com> wrote:
>
> Include the linux/idle_inject.h header to fix W=1 build warning:
>
>     drivers/powercap/idle_inject.c:152:6: warning: no previous prototype for ‘idle_inject_set_duration’ [-Wmissing-prototypes]
>     drivers/powercap/idle_inject.c:167:6: warning: no previous prototype for ‘idle_inject_get_duration’ [-Wmissing-prototypes]
>     drivers/powercap/idle_inject.c:179:6: warning: no previous prototype for ‘idle_inject_set_latency’ [-Wmissing-prototypes]
>     drivers/powercap/idle_inject.c:195:5: warning: no previous prototype for ‘idle_inject_start’ [-Wmissing-prototypes]
>     drivers/powercap/idle_inject.c:227:6: warning: no previous prototype for ‘idle_inject_stop’ [-Wmissing-prototypes]
>     drivers/powercap/idle_inject.c:299:28: warning: no previous prototype for ‘idle_inject_register’ [-Wmissing-prototypes]
>     drivers/powercap/idle_inject.c:345:6: warning: no previous prototype for ‘idle_inject_unregister’ [-Wmissing-prototypes]
>
> Signed-off-by: Pujin Shi <shipj@lemote.com>
> ---
>  drivers/powercap/idle_inject.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/drivers/powercap/idle_inject.c b/drivers/powercap/idle_inject.c
> index 4310901a074e..6e1a0043c411 100644
> --- a/drivers/powercap/idle_inject.c
> +++ b/drivers/powercap/idle_inject.c
> @@ -43,6 +43,7 @@
>  #include <linux/sched.h>
>  #include <linux/slab.h>
>  #include <linux/smpboot.h>
> +#include <linux/idle_inject.h>
>
>  #include <uapi/linux/sched/types.h>
>
> --

Note that the contact information in the S-o-b tag should match the
From: header exactly.

I've fixed that up manually this time and applied the patch (as 5.10
material), but please be more careful about it in the future.

Thanks!
