Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 17869272697
	for <lists+linux-pm@lfdr.de>; Mon, 21 Sep 2020 16:05:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726457AbgIUOFg convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-pm@lfdr.de>); Mon, 21 Sep 2020 10:05:36 -0400
Received: from mail-ot1-f65.google.com ([209.85.210.65]:36846 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726430AbgIUOFf (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 21 Sep 2020 10:05:35 -0400
Received: by mail-ot1-f65.google.com with SMTP id 60so12430101otw.3;
        Mon, 21 Sep 2020 07:05:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=m3af6KAALaFvlr4Q2RRafvRSlyPMyI1uJ+s7w7rbtg8=;
        b=p4fGwWZCv7VT1L4g2rMBnfkWosAurzhLuM5pPFKmh07NTJpaRW6r+DV5kMT7eXEwmm
         yJLZheWdf60KjYQXmvRpxzvXqbMYxrFpBwJ5WXhIi/mIsh86UWyn0DcEtCZSqLLYf9C0
         tMaf+DSq1DZulpN1poA3Zc3QJA4fc12zn3lH6EYmksSnkTFbRrQOac7DM0SorTpkfynr
         Az7p8x/k/gfbC7OooV0aKNcDw7apO1MYlZ8wDR2JpT8jxPQe2V03ItvPgYP0HbSiOhmT
         QFXUNfulCuI7h42DiHE9CnoM7aEOMGuzczqkqthgtlVNZKn/qz9o0cHPFlY/M4Luot1C
         +5Ew==
X-Gm-Message-State: AOAM53154JEMNP7L9cAe1VsdacnsXrWHlU4QQJWnTxgmHxVxUz0TyKvs
        kn11wfbo40G84F1GKrrs8tson7IMyZygdRpIAxafHiEX
X-Google-Smtp-Source: ABdhPJynamnm+QTlBdEB5AWXXyoTB1zIi3eWOv5yVneZU2nOyAvIMpDt8BoI5QXpH5zX+PdUADnDGgpN6UMdsoFSl2E=
X-Received: by 2002:a9d:6010:: with SMTP id h16mr31684732otj.262.1600697134575;
 Mon, 21 Sep 2020 07:05:34 -0700 (PDT)
MIME-Version: 1.0
References: <20200921070417.1121-1-hankinsea@gmail.com>
In-Reply-To: <20200921070417.1121-1-hankinsea@gmail.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Mon, 21 Sep 2020 16:05:19 +0200
Message-ID: <CAJZ5v0iZ+nJkd4HYCy0t4-8xBV0YHHnDdXsGXjyFG--orzmTYA@mail.gmail.com>
Subject: Re: [PATCH v2] powercap: include header to fix -Wmissing-prototypes
To:     Herrington <hankinsea@gmail.com>
Cc:     "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        shipujin.t@gmail.com, Pujin Shi <shipj@lemote.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Mon, Sep 21, 2020 at 9:04 AM Herrington <hankinsea@gmail.com> wrote:
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
> Signed-off-by: Herrington <hankinsea@gmail.com>
> Signed-off-by: Pujin Shi <shipujin.t@gmail.com>
> Signed-off-by: Pujin Shi <shipj@lemote.com>

First, who is the other person whose S-o-b is present here?  For a
co-author of the patch, a Co-developed-by tag should be present too.
Otherwise, a Reviewed-by tag should be used instead of the S-o-b.

Also, one S-o-b (or R-by) per developer would be sufficient.

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
> 2.25.4
>
