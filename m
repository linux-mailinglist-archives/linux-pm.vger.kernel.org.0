Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D7A5E36816B
	for <lists+linux-pm@lfdr.de>; Thu, 22 Apr 2021 15:26:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234429AbhDVN1T (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 22 Apr 2021 09:27:19 -0400
Received: from mail-ot1-f47.google.com ([209.85.210.47]:43549 "EHLO
        mail-ot1-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230005AbhDVN1S (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 22 Apr 2021 09:27:18 -0400
Received: by mail-ot1-f47.google.com with SMTP id i26-20020a9d625a0000b02902a2119f7613so5305212otk.10;
        Thu, 22 Apr 2021 06:26:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=P6+9wENIjOSGm0rNZssrWwc+3q+P9ydCyEXK+E2E3rI=;
        b=Pqxwj7VlId/HEP6i185weLdxHDvpBKe1oJpRZS03j9HH3ULKjZSgFIvbCIjgYLv0Vp
         4C3KJWM4/XhbjP05pEFBda8BZ0/yyyuCvX+LEFbnbIP08Ytd5mjmpvyDiUWlLTsOw/eW
         oB2sXpm3us1TQPsT3Yocgq1VvXHENy/VjEAKBKLpjUz266jN6cVO8THf/FTzjs47Fv3N
         zPoSYcbNRczOgEp8HeyFV+Tkh8PEmDCYw8soXDs4auIikxjdIxCOjcId5c0WIixcCAJy
         YIB1OBr6J2Pw72guEqxxwnR7nfyR8CuYuaj0PjwGmFC5Qp0RBawwLmlzHrMSV6794bas
         4ABg==
X-Gm-Message-State: AOAM532WyU4H/2QSSP6gCOyZy9T3t9GJFrv5mYkGUzW8Y0eJKlChQ4Kc
        xDisISkrNqiGgE0ggrTbCUIdcyO0ba8BofqBTNs=
X-Google-Smtp-Source: ABdhPJyY6NJtdIXc773L+QTLvHiKMQ+H0AThT/TKlpZoEEWVZQ/ZvoW7JrMss8sej1qYm6BRJf07ULO6tX6Dg5ZjE7g=
X-Received: by 2002:a05:6830:55b:: with SMTP id l27mr2846251otb.260.1619098003827;
 Thu, 22 Apr 2021 06:26:43 -0700 (PDT)
MIME-Version: 1.0
References: <20210416124352.2049258-1-colin.king@canonical.com>
In-Reply-To: <20210416124352.2049258-1-colin.king@canonical.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Thu, 22 Apr 2021 15:26:32 +0200
Message-ID: <CAJZ5v0ge7e68vTB3vvcz9OThp32X0=+XaQPrPQCGf0xM9uCi0Q@mail.gmail.com>
Subject: Re: [PATCH] PM / wakeup: remove redundant assignment to variable retval
To:     Colin King <colin.king@canonical.com>
Cc:     "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        kernel-janitors@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Fri, Apr 16, 2021 at 2:44 PM Colin King <colin.king@canonical.com> wrote:
>
> From: Colin Ian King <colin.king@canonical.com>
>
> The variable retval is being initialized with a value that is
> never read and it is being updated later with a new value. The
> initialization is redundant and can be removed.
>
> Addresses-Coverity: ("Unused value")
> Signed-off-by: Colin Ian King <colin.king@canonical.com>
> ---
>  drivers/base/power/wakeup_stats.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/base/power/wakeup_stats.c b/drivers/base/power/wakeup_stats.c
> index 5ade7539ac02..924fac493c4f 100644
> --- a/drivers/base/power/wakeup_stats.c
> +++ b/drivers/base/power/wakeup_stats.c
> @@ -137,7 +137,7 @@ static struct device *wakeup_source_device_create(struct device *parent,
>                                                   struct wakeup_source *ws)
>  {
>         struct device *dev = NULL;
> -       int retval = -ENODEV;
> +       int retval;
>
>         dev = kzalloc(sizeof(*dev), GFP_KERNEL);
>         if (!dev) {
> --

Applied as 5.13 material, thanks!
