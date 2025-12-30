Return-Path: <linux-pm+bounces-40041-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A735CE97C4
	for <lists+linux-pm@lfdr.de>; Tue, 30 Dec 2025 11:55:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C1B0230194EC
	for <lists+linux-pm@lfdr.de>; Tue, 30 Dec 2025 10:54:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83A972D8378;
	Tue, 30 Dec 2025 10:54:32 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-vs1-f46.google.com (mail-vs1-f46.google.com [209.85.217.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E75B613957E
	for <linux-pm@vger.kernel.org>; Tue, 30 Dec 2025 10:54:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767092072; cv=none; b=FccbCRUXcjMtXNzAS6+a+UglIFVHzG3iO24qsmZrUKEEd+QkCkfF8+2zrKcnx3axvs83v/gsIZGz2q+rMe2Cozt/KkSHbecoRKfCItlSYD8RhtO5riFbayJQlZSA6e6l0YpD5SJgVcIlXQYolVoIY2wvmc5ev0ItaY+7A2dmwWQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767092072; c=relaxed/simple;
	bh=n+dXJoOKZeBbPUciWDQkGiNgkFZrYi7IYQf5OWjWcCw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tcPI8TiN227I4BDustMgoBLBWgKTkFFT9LWRlMSkPMPqGM6azyUn4S7JmS/JyNrUF6edl5NJoEfZf2AvkYeMeNgHBogO/Tn3HPm3F4/Qt+Dp1+3ruiykuHb1kVawSUE0Byc1Rc9xI9tfaYEtdSz94CPiNHPzkQWQmmMmX6fFIVw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.217.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vs1-f46.google.com with SMTP id ada2fe7eead31-5e186858102so3505159137.0
        for <linux-pm@vger.kernel.org>; Tue, 30 Dec 2025 02:54:30 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767092070; x=1767696870;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tzvD8u2a9iQw7SPbPh5M/gD9i8/QWB7pr8kaxpQDqVY=;
        b=NEltQC5zzZbWJdpxLiAnB+todKXMx+4JarDp2Z5XljubP2jwqkLZ0ez+b9zdiQWf2e
         4/QOOfpWgbb9vmjehS1pG69S7dAkQZ7GI4Z/QOph52zscZF9cX0C0i2/0L0qXuI+DzMw
         YddeAiCIcRUT1AdzZYSSwv5lo13wbbtQXINJqc3AEVD95mrXAXtePO2nYYof6aqvAN4q
         zq6GE19qxwleeIUlxSSyW3/YQ3a1M76qiEhiTxAYbH1qDPf/pBz4sCo4pg8iDN3HnsN7
         EQ8zSgEdcBV7LNTvZcRB2sx+PIyLu2nyInUbeQbNVbBZQkfDkv8WgTZn3OigDQQv5qBz
         acWw==
X-Gm-Message-State: AOJu0Yz95N8KGhG+d7nITuSOaYwFzL1vkO/iLQOS5jXIhYWK9UL1msW4
	C1DHqWsWZK8Z+ZOZqBk9vCrAfkNEY+nlAxt3wAQu9ddmz6BQjpQpxXR5UjjTKnf8
X-Gm-Gg: AY/fxX5GcpffaXIqS/k7lDHDzXwzWjZG2wqz+/ljvTh6EbIcDJdd29OBEUQzbOGxUT8
	w8HL+SXyU6DtlwAyBySM3UMWrKVUOu7WFrbpt0sgviP6yrNa6jX9DM4cpUHLzdlP7f5z8mZQmyW
	VnKh8EoAHwmmmnOXcmzWc1qYzpCZqp767ruHSuqz26QprIxdsWZRJvcLlzmrU1R5GqjYh2NIiSk
	HWFa88wvofSDqcZB7kRXqHFtjLyon027VcBD6XL0e0DKGOhK3XhaoxR3y2VmPxRjlZdCmGEoz9v
	C5UZ+/IHHQp/PQ6IXhaVnkAbGaoi7PS3SlwwBImpQUumQXPZ6zWypsqmQksprX3bMt219uQ6ZeW
	BiGeH0qSvwclQxczrb3a1Ff2ps7iC9qQLBNKlTvdlGjoy9U5yNOfmp4DVGwRl8w/5LHNvM3xeJ/
	yfWCpwWjVQlQqAGAQ8qvA5/DsQrl1AoOe6fE0N+8SI92o633J2
X-Google-Smtp-Source: AGHT+IGgBgPZsi9BTWIgh0FSk+LqbBNY8vXZfVgatKXRqIynhTLDMOJzj8rnZdvJXnMUJ4Xjsyu+rQ==
X-Received: by 2002:a05:6102:4a84:b0:5df:c228:288d with SMTP id ada2fe7eead31-5eb1a625997mr9697558137.8.1767092069735;
        Tue, 30 Dec 2025 02:54:29 -0800 (PST)
Received: from mail-vs1-f46.google.com (mail-vs1-f46.google.com. [209.85.217.46])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-943562c3339sm7844484241.3.2025.12.30.02.54.29
        for <linux-pm@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 30 Dec 2025 02:54:29 -0800 (PST)
Received: by mail-vs1-f46.google.com with SMTP id ada2fe7eead31-5dfd0101905so3051952137.3
        for <linux-pm@vger.kernel.org>; Tue, 30 Dec 2025 02:54:29 -0800 (PST)
X-Received: by 2002:a05:6102:4a84:b0:5df:c228:288d with SMTP id
 ada2fe7eead31-5eb1a625997mr9697546137.8.1767092068698; Tue, 30 Dec 2025
 02:54:28 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <6245770.lOV4Wx5bFT@rafael.j.wysocki> <2556645.jE0xQCEvom@rafael.j.wysocki>
 <CAMuHMdVMFQebA43FJ53PBnd67C8fxWAC21cr4jWTGDwg-HV53w@mail.gmail.com>
In-Reply-To: <CAMuHMdVMFQebA43FJ53PBnd67C8fxWAC21cr4jWTGDwg-HV53w@mail.gmail.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Tue, 30 Dec 2025 11:54:17 +0100
X-Gmail-Original-Message-ID: <CAMuHMdWshJOjzD5DGzyRUG66jvPC6PPVBgaT=UdWy+XOk_T5Pw@mail.gmail.com>
X-Gm-Features: AQt7F2oPjvLlnFjiHoVfcNoEi_edNjmSUdAxY2W0zN_askdkWJqScjAbdJ5aP4k
Message-ID: <CAMuHMdWshJOjzD5DGzyRUG66jvPC6PPVBgaT=UdWy+XOk_T5Pw@mail.gmail.com>
Subject: Re: [PATCH v1 15/23] phy: core: Discard pm_runtime_put() return values
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Linux PM <linux-pm@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, 
	Ulf Hansson <ulf.hansson@linaro.org>, Brian Norris <briannorris@chromium.org>, 
	Vinod Koul <vkoul@kernel.org>, Neil Armstrong <neil.armstrong@linaro.org>, 
	linux-phy@lists.infradead.org, 
	Linux-Renesas <linux-renesas-soc@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Tue, 30 Dec 2025 at 11:34, Geert Uytterhoeven <geert@linux-m68k.org> wrote:
> On Mon, 22 Dec 2025 at 21:40, Rafael J. Wysocki <rafael@kernel.org> wrote:
> > From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> >
> > The PHY core defines phy_pm_runtime_put() to return an int, but that
> > return value is never used.  It also passes the return value of
> > pm_runtime_put() to the caller which is not very useful.
> >
> > Returning an error code from pm_runtime_put() merely means that it has
> > not queued up a work item to check whether or not the device can be
> > suspended and there are many perfectly valid situations in which that
> > can happen, like after writing "on" to the devices' runtime PM "control"
> > attribute in sysfs for one example.
> >
> > Modify phy_pm_runtime_put() to discard the pm_runtime_put() return
> > value and change its return type to void.  Also drop the redundant
> > pm_runtime_enabled() call from there.
> >
> > No intentional functional impact.
> >
> > This will facilitate a planned change of the pm_runtime_put() return
> > type to void in the future.
> >
> > Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
>
> Thanks for your patch, which is now commit caad07ae07e3fb17 ("phy:
> core: Discard pm_runtime_put() return values") in phy/next.
>
> This is causing several messages like
>
>     phy phy-e6590100.usb-phy-controller.2: Runtime PM usage count underflow!
>
> during boot, and s2ram on Koelsch (R-Car M2-W).

On R-Car Gen3, there are no such messages, as e.g.
drivers/phy/renesas/phy-rcar-gen3-usb2.c does support Runtime PM.
R-Car Gen2 uses drivers/phy/renesas/phy-rcar-gen2.c, which does not
use Runtime PM yet, but still relies on explicit clock management.

> > --- a/drivers/phy/phy-core.c
> > +++ b/drivers/phy/phy-core.c
> > @@ -190,15 +190,12 @@ int phy_pm_runtime_get_sync(struct phy *
> >  }
> >  EXPORT_SYMBOL_GPL(phy_pm_runtime_get_sync);
> >
> > -int phy_pm_runtime_put(struct phy *phy)
> > +void phy_pm_runtime_put(struct phy *phy)
> >  {
> >         if (!phy)
> > -               return 0;
> > +               return;
> >
> > -       if (!pm_runtime_enabled(&phy->dev))
> > -               return -ENOTSUPP;
>
> Adding some instrumentation shows that this branch was taken before,
> thus skipping the call to pm_runtime_put().
>
> Can I just put the check back, or is there an underlying problem that
> should be fixed instead?

I assume the PHY core should support both drivers that do and do not
support Runtime PM.

> Thanks!
>
> > -
> > -       return pm_runtime_put(&phy->dev);
> > +       pm_runtime_put(&phy->dev);
> >  }
> >  EXPORT_SYMBOL_GPL(phy_pm_runtime_put);

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

