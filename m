Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9AE713B37EA
	for <lists+linux-pm@lfdr.de>; Thu, 24 Jun 2021 22:34:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229525AbhFXUgV (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 24 Jun 2021 16:36:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232578AbhFXUgV (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 24 Jun 2021 16:36:21 -0400
Received: from mail-oo1-xc29.google.com (mail-oo1-xc29.google.com [IPv6:2607:f8b0:4864:20::c29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71589C061756
        for <linux-pm@vger.kernel.org>; Thu, 24 Jun 2021 13:34:00 -0700 (PDT)
Received: by mail-oo1-xc29.google.com with SMTP id r14-20020a4ad4ce0000b029024b4146e2f5so1972084oos.1
        for <linux-pm@vger.kernel.org>; Thu, 24 Jun 2021 13:34:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:in-reply-to:references:from:user-agent:date:message-id
         :subject:to:cc;
        bh=LGVLOwTMQf02AApisXt8714vIkGSE5Hn9MHMhj7anOA=;
        b=XFxU9zrqgC9ofH8LrrvjQGG/EntrxKD1JQX2pAZoDRug3TJloNyZsdidjCNjNVJPcu
         lC7vtWp9bpY7SMCt1A+CCCEbfn+nMF/pKOSgdlfPhjk+4QedG+lqxPbPQDRNBsyJH6XX
         Ce0vEutBX2I90tb8y0dR9byyU5w5xfhMVcobM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from
         :user-agent:date:message-id:subject:to:cc;
        bh=LGVLOwTMQf02AApisXt8714vIkGSE5Hn9MHMhj7anOA=;
        b=ko3TI31pVUkFLxQZEGCSdTm1yXSn0wAPGoPemO42K/V2G7K8xctb73NM6ZUtZtLmIL
         n0Di7TKtw7+YcQvNh8jMyCA8kdaOh8F4S00rly7aYsJmp+G/BomqjHUssFscWRAo8JAu
         z4Y0YbVK4PFJE9BlepUwuI8X+VyVPPiTXSWWhKqtAVYTDjdrG2qrYqrG/YAkZAHXHaMa
         wz7sWDI9z28IGSaEaltKQGXANVt03k27uMDGijv+RJ8RmSI7xKP34np6tMjUQoY+XQA6
         ShmvDilPX54GuItpGfWYQdUgQqtgCR2hlZLI5TBgioMAqmLy7Jm0hFt7ToOwZAqlxq0R
         Xlxw==
X-Gm-Message-State: AOAM531S8KPMGDogqt0ha8hVC257T8rwCfD1qFp7y6YMY4BoLnAYSfEl
        xXgbAJcyBKx8GjvVInT+IkWQWXVZr5jyhVFvQeLcNQ==
X-Google-Smtp-Source: ABdhPJyGVI9vpTiB7DmD7vEDFP3PgX1RutuQHWzb5jNfz5eRMrVafr+ft2whOyQUjr4FN/VhH72pAeVGbFz7j6xSkBo=
X-Received: by 2002:a4a:3e0e:: with SMTP id t14mr6067704oot.16.1624566839749;
 Thu, 24 Jun 2021 13:33:59 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 24 Jun 2021 13:33:59 -0700
MIME-Version: 1.0
In-Reply-To: <CAPDyKFoxg0OhHUONm4dsOTyJperfM7bkkHpK0ikqP8u9mgi97w@mail.gmail.com>
References: <20210621201051.3211529-1-swboyd@chromium.org> <CAPDyKFr=sapFwgsDrZw5ZokcryGDpXDQTnv9kzAiijfuT6cw9g@mail.gmail.com>
 <CAE-0n53=AuYcBSTKkvDmNHpLMq7j4yTeMh5j80uN5dobqvC5ag@mail.gmail.com> <CAPDyKFoxg0OhHUONm4dsOTyJperfM7bkkHpK0ikqP8u9mgi97w@mail.gmail.com>
From:   Stephen Boyd <swboyd@chromium.org>
User-Agent: alot/0.9.1
Date:   Thu, 24 Jun 2021 13:33:59 -0700
Message-ID: <CAE-0n53d7_LeyyQv7OvxoMuvi6xz7NKtgCENN7Zp7fVUKSUNPA@mail.gmail.com>
Subject: Re: [PATCH] PM: domains: Shrink locking area of the gpd_list_lock
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Kevin Hilman <khilman@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linux PM <linux-pm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Quoting Ulf Hansson (2021-06-23 02:55:24)
> On Wed, 23 Jun 2021 at 10:31, Stephen Boyd <swboyd@chromium.org> wrote:
> > lock as far down as possible to fix the problem, which is holding it
> > over the calls into OPP.
>
> Yes, we don't want that.
>
> >
> > If I've read the code correctly it serves no purpose to grab the
> > gpd_list_lock here in genpd_add_provider() because we grab the
> > of_genpd_mutex and that is protecting the of_genpd_providers list
> > everywhere else. Is that right? Put another way, This hunk of the patch
> > can be dropped and then your concern will be addressed and there isn't
> > anything more to do.
>
> It certainly can be dropped from the $subject patch, please re-spin to
> update that.
>
> However, there are additional changes that deserve to be done to
> improve the behaviour around the locks. More precisely, the
> &gpd_list_lock and the &of_genpd_mutex should be completely decoupled,
> but there are some other related things as well.
>
> Probably it's easier if I post a patch, on top of yours, to try to
> further improve the behavior. I would appreciate it if you could help
> with the test/review then.

Sure no problem. I've sent v2 with this hunk dropped. I can test your
followup.
