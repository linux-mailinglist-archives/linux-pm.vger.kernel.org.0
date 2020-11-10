Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 18BE42ADF2D
	for <lists+linux-pm@lfdr.de>; Tue, 10 Nov 2020 20:20:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726467AbgKJTUH (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 10 Nov 2020 14:20:07 -0500
Received: from mail-oi1-f195.google.com ([209.85.167.195]:39334 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726179AbgKJTUG (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 10 Nov 2020 14:20:06 -0500
Received: by mail-oi1-f195.google.com with SMTP id u127so15681133oib.6;
        Tue, 10 Nov 2020 11:20:06 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=NmKu8LmdNLL1UMVcN4Ruc1hGIKWMS8ijmGz0Gw6BRyk=;
        b=Ck4EFHLsgyR/K6QRcLhwjBoaUsjDrhOT/JwAPzeBiLITVJ4JRs7MCOtuigN5ab7QMX
         vVpwZHHvogHOr9tSwYSWWlODQlc1FLvhutjtuw26dki0E/IS8Opk/Ygue1qmQh6mnBGv
         ArIw+Kw54izD6Pq1uTQfqBBfKsgjFs58AOEMfhRqQbW2V07U5JGrLQfRMkgqs77ufE4M
         HxN59GMFeyFbur7ilaGBlvKh/GgfQn/2csa6AiIY0ZBzZVv6gU5AgHEG4t6M7iXQrhH5
         Czaoj3g5jg7Q3RgDJuEc/HDCg+JPsrPlBn/8IBEHcmyrii0R2hsTdGtEeNf7eXnBesQ8
         IpuQ==
X-Gm-Message-State: AOAM531vUNWyzZOqM15Utq5hxbmAoTQovolhmtiVA41RpMb6tDANgWd/
        ho5LXshrndZFYTHctKJIccZHUgROCblwP+mJc+E=
X-Google-Smtp-Source: ABdhPJxd1294o5myWUuqyAs3fbilZq4p8E/a0uJsGTnJKCGFxayUamF0ey+Gt7H1RHuNnILipL7Ypes/T51yPwAyMnQ=
X-Received: by 2002:aca:cf4b:: with SMTP id f72mr387905oig.157.1605036005779;
 Tue, 10 Nov 2020 11:20:05 -0800 (PST)
MIME-Version: 1.0
References: <20201109172452.6923-1-lukasz.luba@arm.com>
In-Reply-To: <20201109172452.6923-1-lukasz.luba@arm.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Tue, 10 Nov 2020 20:19:54 +0100
Message-ID: <CAJZ5v0gQj8cNHgXkgwGeNcegAmP2xxqPQXz1kGNqFFDDCgfX_w@mail.gmail.com>
Subject: Re: [PATCH] powercap: Adjust printing the constraint name with new line
To:     Lukasz Luba <lukasz.luba@arm.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Mon, Nov 9, 2020 at 6:25 PM Lukasz Luba <lukasz.luba@arm.com> wrote:
>
> The constraint name has limit of size 30, which sometimes might be hit.
> When this happens the new line might be lost. Prevent this and set the
> new line when the name string is too long."
>
> Signed-off-by: Lukasz Luba <lukasz.luba@arm.com>
> ---
>  drivers/powercap/powercap_sys.c | 4 ++++
>  1 file changed, 4 insertions(+)
>
> diff --git a/drivers/powercap/powercap_sys.c b/drivers/powercap/powercap_sys.c
> index f808c5fa9838..575f9fdb810e 100644
> --- a/drivers/powercap/powercap_sys.c
> +++ b/drivers/powercap/powercap_sys.c
> @@ -174,6 +174,10 @@ static ssize_t show_constraint_name(struct device *dev,
>                                                                 "%s\n", name);
>                         buf[POWERCAP_CONSTRAINT_NAME_LEN] = '\0';
>                         len = strlen(buf);
> +
> +                       /* When the 'name' is too long, don't lose new line */
> +                       if (strlen(name) >= POWERCAP_CONSTRAINT_NAME_LEN)
> +                               buf[POWERCAP_CONSTRAINT_NAME_LEN - 1] = '\n';

Wouldn't it be better to pass POWERCAP_CONSTRAINT_NAME_LEN - 1 to
snprintf() above?

>                 }
>         }
>
> --
