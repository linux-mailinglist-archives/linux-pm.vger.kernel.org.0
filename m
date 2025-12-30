Return-Path: <linux-pm+bounces-40049-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FB67CEA06A
	for <lists+linux-pm@lfdr.de>; Tue, 30 Dec 2025 16:10:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 11DCF3065796
	for <lists+linux-pm@lfdr.de>; Tue, 30 Dec 2025 15:05:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4DE6231A556;
	Tue, 30 Dec 2025 15:05:26 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-vk1-f179.google.com (mail-vk1-f179.google.com [209.85.221.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2402631A05E
	for <linux-pm@vger.kernel.org>; Tue, 30 Dec 2025 15:05:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767107126; cv=none; b=Ul3aQm2WFmWsBxit66zyDt6En5xWMP6xgFbYdULiDeVTYg76ooENy7dSV/UAz7UnEkpe/9VXKmt5qz+MC/ulW24sWaJse37VkLZoTMrQ9Cr7SOyTnaurZRHH1TXNwynYcATZZxX/3KpcD0Nu9sghNQwJoPQtJWJfVXa1qwQ1B/E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767107126; c=relaxed/simple;
	bh=dkjLK7cj8/C4JRusSr9IXX3Q+juZmbMwsVO/nZqCEKQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pOPjcDPAW50yaSbfe2+Z/jr6zGcEjAK9hmJnu2BgIWf85/GSFlHbHGp5MveJ8INNNMActk9bzngs9WhBMXtzWhWA2hXtqE37EgufNJdVx29h+HzRTaTgHK96/xXmyZoUhhxNSrgkSB87hM60nPwmVFUZkLb/z4XEBoD4YtWJ9jA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.221.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f179.google.com with SMTP id 71dfb90a1353d-55b26461e78so2609982e0c.3
        for <linux-pm@vger.kernel.org>; Tue, 30 Dec 2025 07:05:23 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767107123; x=1767711923;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=n3bghUu0vru4RrxnbMTcftVq/cqOVIrTFnZfWBS4mDw=;
        b=tf39sW7puEb3e4R95Acc99T3g3cJ6gZQorN2XgwylRr8mRuQfHHIy7vuMKSyU5U9fg
         lZSB15P4/KwPD4azb7xDI++ALtaZaV4QF6AQGH8wUQkniAk6N3jMPPvsHtdralXj08sc
         gcCCznJ6gqc7m0C+m3xTBOu/tQ6hrijqwPIINsrNaCNsWxygfR74mbXKuXqjHWFGf20M
         sMz1fIiabM87lMSzEkqcc62shKRu3qkuRhhepv/jmEdFdXvuA0UQ9hx5dU/j3zLzHko+
         tL2hPN+gm+BvBm4mKg39eoGf8STf3z6s3vQxOdvxVnHVGViKnEzNKOdjGPIAn01TdS8d
         oXAQ==
X-Gm-Message-State: AOJu0Yyp7Onk8FFBWxmLgBvAvF/w/pZJlOEv6bYWJFJvjXzbbTThtzPG
	11ifT9dMThS0HukxCpce6F0pKZVnPkhXbd84yq3jwWAp8ROjbEybfVIulwwxNBxg
X-Gm-Gg: AY/fxX7RbZ3Rc9esSQkxZ/GH6yZ3yAq1nd2W26TmIXAfaNCev1ThXnBqEB+HP6PLQA+
	V7ljIcMPOR1NyO9cEpV4teEjrBAGyus3VRSfQXzb3LA8e52TeQB0BftXmbwRnUvNspx9AJdVxc3
	h00YMpCPK+O8KmNIk7RAthQw4TqMYybRPOHb6+OqSxU+ucTF9a2yTgSw4ksNJjKySSe+49cIY1b
	4ZIsD/PKFdHZKEXxdThqKfPIOniMBSiynCH0U/fJDv0suJErvYWwo7B4CUWTXJovFmtk2cLC+Be
	KcAnk5Btv33fvt4B0TqClkqZj31aEhw+an0l8Xk4qJMFmRfpfocZWDNekBS4wiXWEJTG89NwrCc
	onZTqKvn9jEPLMm8KCL0aHjcj4D800kHlBHbvJSbJlhDbjWl/4SRmA+v0at7/FUDuQC8Ui5fMZ3
	YmxijktpZqL+7DNG2EkiamxtLjwXgn5mhogNwJQv+4eJ//vHalDy8W
X-Google-Smtp-Source: AGHT+IGzMZ7aM/NPXyHcPHX1jLwIN6hB+Kv8PYzJnCT8l+4FK4SLegSzftzKEZdhb1VfSbvpQ6X0nA==
X-Received: by 2002:a05:6122:32d5:b0:54a:a5ac:5107 with SMTP id 71dfb90a1353d-5615be84512mr8626402e0c.15.1767107123083;
        Tue, 30 Dec 2025 07:05:23 -0800 (PST)
Received: from mail-vk1-f174.google.com (mail-vk1-f174.google.com. [209.85.221.174])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-943417b7ba7sm9263436241.15.2025.12.30.07.05.22
        for <linux-pm@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 30 Dec 2025 07:05:22 -0800 (PST)
Received: by mail-vk1-f174.google.com with SMTP id 71dfb90a1353d-55b26461e78so2609944e0c.3
        for <linux-pm@vger.kernel.org>; Tue, 30 Dec 2025 07:05:22 -0800 (PST)
X-Received: by 2002:a05:6122:1354:b0:55b:305b:4e3b with SMTP id
 71dfb90a1353d-5615beb8214mr9695143e0c.17.1767107122056; Tue, 30 Dec 2025
 07:05:22 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <6245770.lOV4Wx5bFT@rafael.j.wysocki> <2556645.jE0xQCEvom@rafael.j.wysocki>
 <CAMuHMdVMFQebA43FJ53PBnd67C8fxWAC21cr4jWTGDwg-HV53w@mail.gmail.com> <CAMuHMdWshJOjzD5DGzyRUG66jvPC6PPVBgaT=UdWy+XOk_T5Pw@mail.gmail.com>
In-Reply-To: <CAMuHMdWshJOjzD5DGzyRUG66jvPC6PPVBgaT=UdWy+XOk_T5Pw@mail.gmail.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Tue, 30 Dec 2025 16:05:11 +0100
X-Gmail-Original-Message-ID: <CAMuHMdVeHY7+9Jz60OX521iaEorGOcrxuGC8iuzDRUA-tkEvLQ@mail.gmail.com>
X-Gm-Features: AQt7F2rwnAcC5lQxf8KDSlHqxdZgmhT_kPKehxVIuLLpkwUasjT0-vp_jZiOQQo
Message-ID: <CAMuHMdVeHY7+9Jz60OX521iaEorGOcrxuGC8iuzDRUA-tkEvLQ@mail.gmail.com>
Subject: Re: [PATCH v1 15/23] phy: core: Discard pm_runtime_put() return values
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Linux PM <linux-pm@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, 
	Ulf Hansson <ulf.hansson@linaro.org>, Brian Norris <briannorris@chromium.org>, 
	Vinod Koul <vkoul@kernel.org>, Neil Armstrong <neil.armstrong@linaro.org>, 
	linux-phy@lists.infradead.org, 
	Linux-Renesas <linux-renesas-soc@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Tue, 30 Dec 2025 at 11:54, Geert Uytterhoeven <geert@linux-m68k.org> wrote:
> On Tue, 30 Dec 2025 at 11:34, Geert Uytterhoeven <geert@linux-m68k.org> wrote:
> > On Mon, 22 Dec 2025 at 21:40, Rafael J. Wysocki <rafael@kernel.org> wrote:
> > > From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > >
> > > The PHY core defines phy_pm_runtime_put() to return an int, but that
> > > return value is never used.  It also passes the return value of
> > > pm_runtime_put() to the caller which is not very useful.
> > >
> > > Returning an error code from pm_runtime_put() merely means that it has
> > > not queued up a work item to check whether or not the device can be
> > > suspended and there are many perfectly valid situations in which that
> > > can happen, like after writing "on" to the devices' runtime PM "control"
> > > attribute in sysfs for one example.
> > >
> > > Modify phy_pm_runtime_put() to discard the pm_runtime_put() return
> > > value and change its return type to void.  Also drop the redundant
> > > pm_runtime_enabled() call from there.
> > >
> > > No intentional functional impact.
> > >
> > > This will facilitate a planned change of the pm_runtime_put() return
> > > type to void in the future.
> > >
> > > Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> >
> > Thanks for your patch, which is now commit caad07ae07e3fb17 ("phy:
> > core: Discard pm_runtime_put() return values") in phy/next.
> >
> > This is causing several messages like
> >
> >     phy phy-e6590100.usb-phy-controller.2: Runtime PM usage count underflow!
> >
> > during boot, and s2ram on Koelsch (R-Car M2-W).
>
> On R-Car Gen3, there are no such messages, as e.g.
> drivers/phy/renesas/phy-rcar-gen3-usb2.c does support Runtime PM.
> R-Car Gen2 uses drivers/phy/renesas/phy-rcar-gen2.c, which does not
> use Runtime PM yet, but still relies on explicit clock management.
>
> > > --- a/drivers/phy/phy-core.c
> > > +++ b/drivers/phy/phy-core.c
> > > @@ -190,15 +190,12 @@ int phy_pm_runtime_get_sync(struct phy *
> > >  }
> > >  EXPORT_SYMBOL_GPL(phy_pm_runtime_get_sync);
> > >
> > > -int phy_pm_runtime_put(struct phy *phy)
> > > +void phy_pm_runtime_put(struct phy *phy)
> > >  {
> > >         if (!phy)
> > > -               return 0;
> > > +               return;
> > >
> > > -       if (!pm_runtime_enabled(&phy->dev))
> > > -               return -ENOTSUPP;
> >
> > Adding some instrumentation shows that this branch was taken before,
> > thus skipping the call to pm_runtime_put().
> >
> > Can I just put the check back, or is there an underlying problem that
> > should be fixed instead?
>
> I assume the PHY core should support both drivers that do and do not
> support Runtime PM.

I have sent a patch:
https://lore.kernel.org/3ca9f8166d21685bfbf97535da30172f74822130.1767107014.git.geert+renesas@glider.be

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

