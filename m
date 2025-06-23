Return-Path: <linux-pm+bounces-29351-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BCA5DAE47FA
	for <lists+linux-pm@lfdr.de>; Mon, 23 Jun 2025 17:10:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 739DD3B2358
	for <lists+linux-pm@lfdr.de>; Mon, 23 Jun 2025 15:06:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8158326FA70;
	Mon, 23 Jun 2025 15:07:02 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-qv1-f42.google.com (mail-qv1-f42.google.com [209.85.219.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F133272624;
	Mon, 23 Jun 2025 15:06:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750691222; cv=none; b=PFCYVh4srXaybyyf7rCY+KrRrqn7kVxR6mfxJPp+fKszAecI82+6qceccXUZ3oaTLSb5/P+hyqZnyVNJstynRpsVUXT/ljMNs+pa/LZTjsj0LQVyLdkZQYKPBhDT4eixNbVT2BV1ArggRdKNGG0ZUt6DWzoEhWhnR4wyi/G6v0U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750691222; c=relaxed/simple;
	bh=Z5wED7/qlRbrh+Qp7zPPEYCLFeGrd4A4BV2F3KdHedU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=P583aMUfV1yXNW4gRWH6JKc4uyTZY3IC/jCq/YdoXx9Is5Z0JfzbgRzSb7MtznnG82KDrXCeXpujmWCpLKdTfNvN9OunbI2jhVfLWp4EFsAx6fMs0l/cY5nevHizkzafBzVxIEg+mKug/AmSg3Qlwcw8c2w0XVHKaemeTLFwx98=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.219.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f42.google.com with SMTP id 6a1803df08f44-6faf66905adso24399016d6.2;
        Mon, 23 Jun 2025 08:06:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750691217; x=1751296017;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Lp76G6zSq2VEZ9aK70X+T0RQCLIqoSSA+Av6/Es2hYc=;
        b=Fbkz5tcL3G7UQFD5xhmWtu+jiJ6B9mX049VE02+kJf6r0exCDlOVGpQjvWCTV4hoFt
         qKj9Q8waUe4+sdHiCxunL1RlQUC+qlOxLYehnqwS/UIRFJvoPk6Nv/g6rjHMGOGBUBn3
         FMZx3YsrIDR0Kj4En3CNx9U6VqUSbXKuk1nOANtes9inpCgM/COLzEmFkcXosSLFVOXG
         G85g3xrkQFMT0rZ0fo33mn6LagEObmUlL3fXX4hyF3KVhGhhbFaoFymQoTOM2dqCDWPr
         UVOW099XNT/S/VmO68QdlHC6OxpuZuKmv7YsI+9dqd/RtHZnaVHZZQ0xIpDB0XYvWbB4
         DDfw==
X-Forwarded-Encrypted: i=1; AJvYcCVvt0fhu3RqkxK7YAXnTntucO3ldWNZJFrMmO2uHcI3Rl5INAe9CTz3CWUTJAUYBVUPm0yOKd/aJqY=@vger.kernel.org, AJvYcCWDRsx/ilrwCO2gBu+P2muLuCad5UZmqtWtxnKRj6mekkuqBrvtmHtKky0EmX+Ld6BcL3dxS+XH9Ic78Zw6X0TasqI=@vger.kernel.org, AJvYcCX7k3Xb+/XV3jG53/v+48WIA/PdOdgDVYycbHH5FimvvK9/bpsfB6qak0aAZSXsCeyXIPR8Qy7Dw7QsEeI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxyx/Mck7kuyE4qlW81eTEaMVcV0OCQ6LvidhAo0tYy4+fnuP87
	IWCSuLAKfYQLAEKbCUpRETVpQ6/eR1P4GjzSGxLwk8f1497tb/2T0grjA9o9+UzZ
X-Gm-Gg: ASbGncsQNhuuVyZD4JDPAsLBUnQt7FCqjzR1XBcUdbnQP8ALWB4jN7sPkdITr41bhMQ
	aZhdA97RZ2zRTopmzi9nSl5eFIKYqodVPdstYQZeExG2HHlEUk2qO/l54ZKLTBapZnlp8ofovpo
	t0fSkTcfveLOcFnIDGZa+UEFi7y563utKX3vKdZFWXHOCIZv3rVNiUV1vQPN6U8XNtqx8ZLz008
	X3HKASmJMbGOU+uhH1rFN+DH+fo/jdzpn/J/Yc30KoszIQFE/sC3/mSXJFOwFHRMegGI6mlmCWJ
	HK+pcUMSru+uMw7NYTud//6xwQfGiEvlFgZBij0Un+GGP46HH4BBFGo8SCKR9Jx2KRhuuY4nP6s
	pJhrYi3R+ytwbUhsk5InW0Fqrv0HH
X-Google-Smtp-Source: AGHT+IGaLADj805LkkuGmyFATfbaWgRlvHKjNfhxtULwkj0qu4iE2aHspKh0PauTr6dkvNIVxKCmFQ==
X-Received: by 2002:a05:6214:485:b0:6fb:5bb5:ccfb with SMTP id 6a1803df08f44-6fd0a5880e1mr235066446d6.34.1750691216510;
        Mon, 23 Jun 2025 08:06:56 -0700 (PDT)
Received: from mail-qk1-f171.google.com (mail-qk1-f171.google.com. [209.85.222.171])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6fd0953809fsm45505656d6.68.2025.06.23.08.06.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 23 Jun 2025 08:06:55 -0700 (PDT)
Received: by mail-qk1-f171.google.com with SMTP id af79cd13be357-7d3e5df4785so281075785a.0;
        Mon, 23 Jun 2025 08:06:54 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUiLTioRoEeYuvQKascM2prUYrxtV4T1HJAqqLmTnUf0nCr5ciFrJsJgJ0yEQrP9QEgCJHqk+kCqP4=@vger.kernel.org, AJvYcCVBIbTMoJlmf+v0NsPdqkQJaw7xAsRtapDYPMdq9J4Ca8mE6rmXIXUHW9AbTfEh6gOI8/mdKABfqBSJnEE=@vger.kernel.org, AJvYcCXi+h/Ixwe/L4OT/DNncLZBthyPJjwQp0pG9u5xZE/KGcwB1aqVpwN/A0MtyjYmOW4WkZDCRdNJVhhwxkhRN/FkMH8=@vger.kernel.org
X-Received: by 2002:a05:620a:298f:b0:7c5:9b12:f53c with SMTP id
 af79cd13be357-7d3f98c18f0mr1924690385a.5.1750691214368; Mon, 23 Jun 2025
 08:06:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250523134025.75130-1-ulf.hansson@linaro.org>
 <fd4cfe7a-e29b-4237-b82f-48354deead3b@ideasonboard.com> <CAPDyKFpprO=HGuiHX3MQ_+m1YRnaWG=XwCx8-fSdXak8VBDUbQ@mail.gmail.com>
 <CAPDyKFpXcpwkacnYqWz2vxaTd7pW5bSRa2F063BryFxVNEAmPA@mail.gmail.com>
In-Reply-To: <CAPDyKFpXcpwkacnYqWz2vxaTd7pW5bSRa2F063BryFxVNEAmPA@mail.gmail.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Mon, 23 Jun 2025 17:06:42 +0200
X-Gmail-Original-Message-ID: <CAMuHMdXGS+efbbQ_Pn1iYhQ1aWc_DuJ-CBN=jxfjwOWxTRx+9Q@mail.gmail.com>
X-Gm-Features: Ac12FXx7Xjfa_xE6RhCHr0iaDW4i79STg-K82k32jY3Xof1MYNIo6ZlgJY_vcl0
Message-ID: <CAMuHMdXGS+efbbQ_Pn1iYhQ1aWc_DuJ-CBN=jxfjwOWxTRx+9Q@mail.gmail.com>
Subject: Re: [PATCH v2 00/21] pmdomain: Add generic ->sync_state() support to genpd
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>, Saravana Kannan <saravanak@google.com>, 
	Stephen Boyd <sboyd@kernel.org>, linux-pm@vger.kernel.org, 
	"Rafael J . Wysocki" <rafael@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Michael Grzeschik <m.grzeschik@pengutronix.de>, Bjorn Andersson <andersson@kernel.org>, 
	Abel Vesa <abel.vesa@linaro.org>, Peng Fan <peng.fan@oss.nxp.com>, 
	Johan Hovold <johan@kernel.org>, Maulik Shah <maulik.shah@oss.qualcomm.com>, 
	Michal Simek <michal.simek@amd.com>, Konrad Dybcio <konradybcio@kernel.org>, 
	Thierry Reding <thierry.reding@gmail.com>, Jonathan Hunter <jonathanh@nvidia.com>, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	Linux-Renesas <linux-renesas-soc@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

Hi Ulf,

On Mon, 23 Jun 2025 at 16:21, Ulf Hansson <ulf.hansson@linaro.org> wrote:
> On Thu, 19 Jun 2025 at 13:40, Ulf Hansson <ulf.hansson@linaro.org> wrote:
> > On Fri, 13 Jun 2025 at 12:33, Tomi Valkeinen
> > <tomi.valkeinen@ideasonboard.com> wrote:
> > > On 23/05/2025 16:39, Ulf Hansson wrote:
> > > > Changes in v2:
> > > >       - Well, quite a lot as I discovered various problems when doing
> > > >       additional testing of corner-case. I suggest re-review from scratch,
> > > >       even if I decided to keep some reviewed-by tags.
> > > >       - Added patches to allow some drivers that needs to align or opt-out
> > > >       from the new common behaviour in genpd.
> > > >
> > > > If a PM domain (genpd) is powered-on during boot, there is probably a good
> > > > reason for it. Therefore it's known to be a bad idea to allow such genpd to be
> > > > powered-off before all of its consumer devices have been probed. This series
> > > > intends to fix this problem.
> > > >
> > > > We have been discussing these issues at LKML and at various Linux-conferences
> > > > in the past. I have therefore tried to include the people I can recall being
> > > > involved, but I may have forgotten some (my apologies), feel free to loop them
> > > > in.
> > > >
> > > > I have tested this with QEMU with a bunch of local test-drivers and DT nodes.
> > > > Let me know if you want me to share this code too.
> > > >
> > > > Please help review and test!
> > >
> > > I tested this Renesas white-hawk board, and it hangs at boot. With
> > > earlycon, I captured with/without boot logs, attached.
> > >
> > > The hang case doesn't look very healthy with all these: "kobject:
> > > '(null)' ((____ptrval____)): is not initialized, yet kobject_get() is
> > > being called."
> >
> > Tomi, thanks a lot for helping out with testing!
> >
> > rcar_gen4_sysc_pd_init() calls pm_genpd_init() and
> > of_genpd_add_provider_onecell().
> >
> > rcar_gen4_sysc_pd_init() is an early_initcall, which I guess is the
> > reason for these problems, as the genpd_provider_bus has not been
> > registered that early (it's done at core_initcall)
> >
> > Do you think it would be possible to move rcar_gen4_sysc_pd_init() to
> > a postcore/arch_initcall?
>
> I did some investigation around this and found that both
> drivers/pmdomain/renesas/rcar-gen4-sysc.c and
> drivers/pmdomain/renesas/rcar-sysc.c are registering their genpd
> providers at the early_initcall() level.
>
> I was trying to find (by browsing renesas DTSes and looking into
> drivers) if there is any consumers that actually relies on this, but
> so far the earliest consumer I have found is the
> drivers/irqchip/irq-renesas-irqc.c, but that's at postcore_initcall().
> Of course, it's difficult to say if my analysis is complete as there
> are a lot of platform variants and I didn't check them all.
>
> Maybe we should just give it a try and move both two drivers above to
> postcore_initcall and see if it works (assuming the irq-renesas-irqc
> supports -EPROBE_DEFER correctly too).
>
> If this doesn't work, I think we need to find a way to allow deferring
> the call to device_add() in of_genpd_provider_add*() for genpd
> provider's devices.

Commit dcc09fd143bb97c2 ("soc: renesas: rcar-sysc: Add DT support for
SYSC PM domains") explains:

   "Initialization is done from an early_initcall(), to make sure the PM
    Domains are initialized before secondary CPU bringup."

but that matters only for arm32 systems (R-Car Gen1 and Gen2).
Arm64 systems (R-Car Gen3 and Gen4) use PSCI for CPU PM Domain control.

While changing rcar-sysc.c to use a postcore_initcall indeed moves PM
Domain initialization after secondary CPU bringup, the second CPU core
on R-Car M2-W is still brought up fine.

For R-Car H1, there is a regression:

    smp: Bringing up secondary CPUs ...
    CPU1: failed to boot: -19
    CPU2: failed to boot: -19
    CPU3: failed to boot: -19
    smp: Brought up 1 node, 1 CPU
    SMP: Total of 1 processors activated (500.00 BogoMIPS).

CPU bringup/teardown in userspace using
/sys/devices/system/cpu/cpu*/online still works.
R-Car H1 was never converted to use "enable-method" in DT, and relies
on calling into the rcar-sysc driver directly (see [1]).  However,
that does not use any actual calls into the genpd core, so probably it
can be made to work by splitting rcar_sysc_pd_init() in two parts: an
early_initcall() that allocates all domain structures and populates the
internal hierarchy, and a postcore_initcall() that registers everything
with the genpd core.

As expected, there is no impact on R-Car H3 ES2.0.
I will test on R-Car V4M tomorrow, but expect no issues.

FTR, drivers/pmdomain/renesas/rmobile-sysc.c uses core_initcall().
Changing that to postcore_initcall does not seem to make a difference
(on R-Mobile A1).

[1] https://elixir.bootlin.com/linux/v6.15.3/source/drivers/pmdomain/renesas/rcar-sysc.c#L439

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

