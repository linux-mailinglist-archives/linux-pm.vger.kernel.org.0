Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2662D2D5150
	for <lists+linux-pm@lfdr.de>; Thu, 10 Dec 2020 04:26:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729550AbgLJD0J (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 9 Dec 2020 22:26:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729543AbgLJD0H (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 9 Dec 2020 22:26:07 -0500
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com [IPv6:2607:f8b0:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C941DC061793
        for <linux-pm@vger.kernel.org>; Wed,  9 Dec 2020 19:25:26 -0800 (PST)
Received: by mail-pf1-x441.google.com with SMTP id s21so2704301pfu.13
        for <linux-pm@vger.kernel.org>; Wed, 09 Dec 2020 19:25:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=endlessos.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=lIp6wsYHG9KhOZfxK1gkEGI1lm/R+pKgXsDrqb0v488=;
        b=e8f7oza94yLX3bSgrFQNu3jaD9zoDlCko8eeHhboeEGlUzUR09kTA4LWxmGbcu7Ljj
         ymD7ygtMgxq5Pe0dV23TGjjEX/zlGxvZu5Px6jLB0zAT9rspdUMYsO9xBZ98teKbATTZ
         5JHQm3LGV4vpzsqdZrGCefNeio/PVG50mYQDhDUw7V0fjFJqMHkScTW7SrpoIxi0k3b3
         bAIpBJEWUoPsEdEwKbCX9hMQE+rMACjKiGkKbgWeatJnr/lcdqRj1uMU+F6npNj+OZok
         jjH7r1tyxbsEEBSj/u0fugLYZW2Dvs5fJN++z0q1w892erkoAys/tDHPUOJ27jsHxZ7v
         S1ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=lIp6wsYHG9KhOZfxK1gkEGI1lm/R+pKgXsDrqb0v488=;
        b=EVJrUhtIvfTOWUDX3wiowMQE2b343Y1CPvru6790aIKQ4PEXGVppURfgMg4aitt2it
         PSqf/jRhaK8Aa1/8JledYsD0rtu4vzZk45IN0zWFAug2lSxq5BFbTvseG/2sTqzFEadL
         m1e/LwqkvVn3x3Rcr2SU2nYlgs5iNbMSFvuIXXhmnM93A8fZw//OkSF52D/WGKIq0swN
         4bhe7c8/iEN74mGXB9nIsDqa93bqLbP8y6JXMdeKaLhEQLq2IIsDCXW98zE56t2cC+S/
         bD3a3YZ8wBKxj8We8XQdnngI6oX7S13Mf+ACsPJiSWTjeFR3bTBwNFT8YU+arCi863IS
         g27g==
X-Gm-Message-State: AOAM532Wp3mtprNWY2jM4l7b2JG965yYWXkYjuJyMxZTQJj6SHreU/Pd
        kZsq6Dp4ZtEhTbwIELyzypLyzK+NOwh+un1Nv+d0iQ==
X-Google-Smtp-Source: ABdhPJwLKEnmxDK7F1N1xL76BCQ9/sFBqNCQKNBLaV6YzJiRhitNVuf/wHfdWCJNCy/6rfIrq8nw/EkpDL4jBLexe+Y=
X-Received: by 2002:a17:90a:510e:: with SMTP id t14mr5282761pjh.159.1607570726106;
 Wed, 09 Dec 2020 19:25:26 -0800 (PST)
MIME-Version: 1.0
References: <20201209045057.9509-1-chiu@endlessos.org> <d58351aa-14a9-2ea7-ee8b-946ba28a782e@redhat.com>
In-Reply-To: <d58351aa-14a9-2ea7-ee8b-946ba28a782e@redhat.com>
From:   Chris Chiu <chiu@endlessos.org>
Date:   Thu, 10 Dec 2020 11:25:15 +0800
Message-ID: <CAB4CAwcwrVEoYwPaVYo_TQ-v9qqEe1DrdqgBkm+wot9ehAT+xg@mail.gmail.com>
Subject: Re: [PATCH] power: supply: axp288_fuel_gauge: Add the ECS EF20EA to
 the blacklist
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     sre@kernel.org, wens@csie.org, Linux PM <linux-pm@vger.kernel.org>,
        Linux Kernel <linux-kernel@vger.kernel.org>,
        linux@endlessos.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Wed, Dec 9, 2020 at 10:57 PM Hans de Goede <hdegoede@redhat.com> wrote:
>
> Hi,
>
> On 12/9/20 5:50 AM, Chris Chiu wrote:
> > The ECS EF20EA laptop ships an AXP288 but it is actually using a
> > different, separate FG chip for AC and battery monitoring. On this
> > laptop we need to keep using the regular ACPI driver and disable the
> > AXP288 FG to avoid reporting two batteries to userspace.
> >
> > Signed-off-by: Chris Chiu <chiu@endlessos.org>
> > ---
> >  drivers/power/supply/axp288_fuel_gauge.c | 6 ++++++
> >  1 file changed, 6 insertions(+)
> >
> > diff --git a/drivers/power/supply/axp288_fuel_gauge.c b/drivers/power/supply/axp288_fuel_gauge.c
> > index 148eb8105803..a15c322c79ea 100644
> > --- a/drivers/power/supply/axp288_fuel_gauge.c
> > +++ b/drivers/power/supply/axp288_fuel_gauge.c
> > @@ -739,6 +739,12 @@ static const struct dmi_system_id axp288_fuel_gauge_blacklist[] = {
> >                       DMI_MATCH(DMI_PRODUCT_NAME, "Z83-4"),
> >               }
> >       },
> > +     {
> > +             /* ECS EF20 */
> > +             .matches = {
> > +                     DMI_MATCH(DMI_PRODUCT_NAME, "EF20"),
> > +             },
> > +     },
> >       {}
> >  };
>
> The axp288_fuel_gauge_blacklist already has the following entry:
>
>         {
>                 /* ECS EF20EA */
>                 .matches = {
>                         DMI_MATCH(DMI_PRODUCT_NAME, "EF20EA"),
>                 },
>         },
>
> So is this real entry really necessary? The existing entry
> matches the quirk for this in drivers/acpi/battery.c:
>
>         {
>                 /* ECS EF20EA, AXP288 PMIC but uses separate fuel-gauge */
>                 .callback = battery_do_not_check_pmic_quirk,
>                 .matches = {
>                         DMI_MATCH(DMI_PRODUCT_NAME, "EF20EA"),
>                 },
>         },
>
> And the one in drivers/acpi/ac.c:
>
>         {
>                 /* ECS EF20EA, AXP288 PMIC but uses separate fuel-gauge */
>                 .callback = ac_do_not_check_pmic_quirk,
>                 .matches = {
>                         DMI_MATCH(DMI_PRODUCT_NAME, "EF20EA"),
>                 },
>         },
>
> So I don't think that this patch is necessary...
>
> Regards,
>
> Hans
>
>

Thanks for pointing that out. We kept this downstreamly for a long time and
didn't notice it's already there.
