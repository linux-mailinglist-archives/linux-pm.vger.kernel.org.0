Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 875722ED567
	for <lists+linux-pm@lfdr.de>; Thu,  7 Jan 2021 18:22:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728008AbhAGRVe convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-pm@lfdr.de>); Thu, 7 Jan 2021 12:21:34 -0500
Received: from mail-ot1-f47.google.com ([209.85.210.47]:35148 "EHLO
        mail-ot1-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727673AbhAGRVd (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 7 Jan 2021 12:21:33 -0500
Received: by mail-ot1-f47.google.com with SMTP id i6so7000060otr.2;
        Thu, 07 Jan 2021 09:21:18 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=aDD1oeOdt6WCsRMuQrT0XIoTvjcM6CZh8EOY1iIY8P0=;
        b=K9UkUHp4SvH17A/FOsvjStS/ofKIrzjfsDw81RSCqO58tMT2WxpolvN/llViH0SEaL
         9ma5HgwlgtJMiXTV0GlxWIQkOTLsLvZLjk1cyYQXnycAVlp4dvKJCEIWoLSIDpEklibl
         05lHBWqklW+tn6uMsgEkSG/y6cicwGN2rmxESjwgiPQSHkSIoth9pphM1397sPNIfL9f
         IrwdwIK+VtPMISR4Xqa7TSarKIZ775mY6VkbscMlG0Un9OmGaJS1a1dqMnnj9UqOCwi3
         PO4Q+I2EIWJXS4Pu7ZmgOy62Ptxz3oD02XH0XFPFcUqVyAJj90PN7+AaJodQ1vp9pjj+
         PBOQ==
X-Gm-Message-State: AOAM531zzdvJHWv0TVUiIP8EyJvVsGTgBplVPzAZT+UHfXwH1VotgR6T
        GPMIyChs3RlHnodn4GzFzqzA+nAKsszWdjm2iho=
X-Google-Smtp-Source: ABdhPJxY4A1eCcaxBjc0Hi1rvDXrQ6/yfWwTbppasrHAdg6eA6RNNH3yie3HKybYRQCxp7DlJiurGRDpW2XRKArv9Ag=
X-Received: by 2002:a9d:745a:: with SMTP id p26mr7561072otk.206.1610040052964;
 Thu, 07 Jan 2021 09:20:52 -0800 (PST)
MIME-Version: 1.0
References: <20210104121053.33210-1-colin.king@canonical.com> <ea95f420-2a2e-d0f9-9b34-e329d80bbd9d@linaro.org>
In-Reply-To: <ea95f420-2a2e-d0f9-9b34-e329d80bbd9d@linaro.org>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Thu, 7 Jan 2021 18:20:41 +0100
Message-ID: <CAJZ5v0j8ysg35Tq3GZO+Eb1jH4wKjMEGaQeGA=qADTMU59y4wA@mail.gmail.com>
Subject: Re: [PATCH][next] powercap/drivers/dtpm: Fix size of object being allocated
To:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        Colin King <colin.king@canonical.com>
Cc:     "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Lukasz Luba <lukasz.luba@arm.com>,
        Linux PM <linux-pm@vger.kernel.org>,
        kernel-janitors@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Mon, Jan 4, 2021 at 3:24 PM Daniel Lezcano <daniel.lezcano@linaro.org> wrote:
>
> On 04/01/2021 13:10, Colin King wrote:
> > From: Colin Ian King <colin.king@canonical.com>
> >
> > The kzalloc allocation for dtpm_cpu is currently allocating the size
> > of the pointer and not the size of the structure. Fix this by using
> > the correct sizeof argument.
> >
> > Addresses-Coverity: ("Wrong sizeof argument")
> > Fixes: 0e8f68d7f048 ("powercap/drivers/dtpm: Add CPU energy model based support")
> > Signed-off-by: Colin Ian King <colin.king@canonical.com>
>
> Good catch, thanks for fixing this
>
> Acked-by: Daniel Lezcano <daniel.lezcano@linaro.org>

Applied as 5.12 material, thanks!

> > ---
> >  drivers/powercap/dtpm_cpu.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/drivers/powercap/dtpm_cpu.c b/drivers/powercap/dtpm_cpu.c
> > index 6933c783c6b4..51c366938acd 100644
> > --- a/drivers/powercap/dtpm_cpu.c
> > +++ b/drivers/powercap/dtpm_cpu.c
> > @@ -200,7 +200,7 @@ static int cpuhp_dtpm_cpu_online(unsigned int cpu)
> >       if (!dtpm)
> >               return -EINVAL;
> >
> > -     dtpm_cpu = kzalloc(sizeof(dtpm_cpu), GFP_KERNEL);
> > +     dtpm_cpu = kzalloc(sizeof(*dtpm_cpu), GFP_KERNEL);
> >       if (!dtpm_cpu)
> >               goto out_kfree_dtpm;
> >
> >
>
>
> --
> <http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs
>
> Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
> <http://twitter.com/#!/linaroorg> Twitter |
> <http://www.linaro.org/linaro-blog/> Blog
