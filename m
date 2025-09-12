Return-Path: <linux-pm+bounces-34564-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A58C6B5563A
	for <lists+linux-pm@lfdr.de>; Fri, 12 Sep 2025 20:32:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 51BCA17D2A5
	for <lists+linux-pm@lfdr.de>; Fri, 12 Sep 2025 18:32:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DFD2314A94;
	Fri, 12 Sep 2025 18:32:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Uvi9D1ok"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-vs1-f48.google.com (mail-vs1-f48.google.com [209.85.217.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A959418E25
	for <linux-pm@vger.kernel.org>; Fri, 12 Sep 2025 18:32:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757701970; cv=none; b=ZC2LmkC64t7sB6OJO6W7JnftV0eQw7fi2eFiy0fDC2WQk9Ezr+k8Fkn3IcAF9X435m4OnFm8DqER3blOpjm+pLzqio5tI3U4I6+8OGsjKp67QJiVMtM6g2QXYwPKKIBFTCCC1mWhto9/VFtc53cvJguUMARvDV+0/3glBjI2/pU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757701970; c=relaxed/simple;
	bh=Fu2+9BFfJZbB2dakjky73YRJtJuOWWpMBpPThKctWDc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LtaOGXz8Suv6DUX0IueIUuWRA5fAJFR0U2ig5PkIoNhCpwIuQ4rzcqjH1faw9x8XkHpR2pceX2469w8sLwjlyRl83tmod5NejLdVq/WIxVn024yTLeT78ikmNw4qSM0BbzrWDxtoFahpzspRo3CA/222b0y6PCIO6LONUZEVI2g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Uvi9D1ok; arc=none smtp.client-ip=209.85.217.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-vs1-f48.google.com with SMTP id ada2fe7eead31-52dd67b03c8so1592379137.2
        for <linux-pm@vger.kernel.org>; Fri, 12 Sep 2025 11:32:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1757701967; x=1758306767; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MWAcV33ZMph2arQWUOu2bOKmt37CgEiSNgomNwsHgUE=;
        b=Uvi9D1oktl1wmvS0HJ6YERz9r8WmyMLQS1vULEePIjctnUU7IxnAwS0c/G0lwy1Y/R
         SHbPczr+yPR9k2T8s1I9yeFjcTCfJkH/Nip+M/sydPylQ68lPHnzwPRq1k74QA6Hd9UZ
         N0ak6Z5xgRnpGFG8dHe/687Ly6y9he/G0rBDw3caso3ieZAxQdAOOCi0WUlMknt0TM1p
         a8u6G7e2lLyMyCP6goDM97GjoVMdPJYFToLb0oDacAWwpoN+EsbzupEbTEXEjramJaAa
         SDcVltYsNSyvYh3FRXhsxDL2bDYPF4K4VF6fYU05KE9fCIqn8HlkaK8KohS3xc9EEBUj
         Yh8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757701967; x=1758306767;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MWAcV33ZMph2arQWUOu2bOKmt37CgEiSNgomNwsHgUE=;
        b=j0832Hb/gnBukNxPHQEnjIFAsxBkVzb+gWMtlthj53lB56yBBQ8jvYwr52yFfvOYmk
         FY9r+J7KCel/gWXzMYey11FSrWkvT2Tq3NyIC0AxYZABjB0x7oj6/wEGQnW/JfsQ0icb
         kn7Z0oA1F64/71hnZqqTHwTHo/QNRS0TI0+FqolXCSKaVbD7xCB5XFDoz5499LxU8fSO
         t8jui0dZ+5/8EOB05WRB2q3scS9H1nQE+4qeJxhLLyqjY4RBTLOyhPPLMRdq8EkIGR8T
         luy5GZ718IQSWFAUa27mqgAXviuq65+HcX7W+Ybpr1Ryg0J0RrOPT58WIKsUXwl1bhb7
         1A2w==
X-Forwarded-Encrypted: i=1; AJvYcCXj4DJAgS9+ZXCm7E/kavZdjXWrNN8a8XhNtqW5WKnYSf+gS7LFQVFLRx7t1VT6SfBHoc5yd6jmEA==@vger.kernel.org
X-Gm-Message-State: AOJu0YwkFJet+3E4YVexCOKUFEGT5ryq7plnd4Tw6UBH0Llq86LlaWHc
	imPeIjdox3onF2cDjR3znWdDWIlAXAQtII8W2onYgmpUS4KcD+NF1mWYLq5Wq/2VaTLdURyxDxQ
	qm6L08Ava94L6omU0TrHvyyTnq2ASzO4B1C1GbumS
X-Gm-Gg: ASbGncs8DT1/i3HL1UlipPAFXvrl7SiJWr/br1CI8z9XpDSmrBHW0jynOdy2HPjWKUZ
	FJy0ECCLA5BBVnLkHDUuwXpqmnDzgkKKw7s8RepciFfziAwmGF/jbyLhyHt4KxrGBrNUL6RrTTR
	b5He0eHfxRUKA5rKmBvtXPLBXBkGro9KJi7k/Leo764SqkPgQ/cLXhJkl6R9ku022XpWiKnoneR
	9TstbY3Ztdpk94j7OrZBKU=
X-Google-Smtp-Source: AGHT+IEwuqGiSpqE4S73UrrBSfohWasHabBibycBkPxzV5dEA4Kg4RuWdEXXtxpvh+JdAFU3NQGylw9Qezmw4UR6T3M=
X-Received: by 2002:a05:6102:5092:b0:555:56e0:f357 with SMTP id
 ada2fe7eead31-556111a20c4mr2073158137.23.1757701967147; Fri, 12 Sep 2025
 11:32:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250909111130.132976-1-ulf.hansson@linaro.org>
 <DCPDDIZ3S1CM.3DJYY5U4T6V4U@cknow.org> <CAMuHMdVxjOLZsas4+nmAkZjbJsQjxdkZvZ8tTY9pq2zz3gvFNQ@mail.gmail.com>
 <DCPTTD0NKOE6.1HKQ87ESFOT6D@cknow.org>
In-Reply-To: <DCPTTD0NKOE6.1HKQ87ESFOT6D@cknow.org>
From: Saravana Kannan <saravanak@google.com>
Date: Fri, 12 Sep 2025 11:32:10 -0700
X-Gm-Features: AS18NWABs8fnzpFVCAtvwJwDtmgpdJSk1T67VpjW5fTH0mGJFK7ZtMdVqvXofIU
Message-ID: <CAGETcx-HnLZBZmP0CUhuYc8jtyAaP6Ax_h0oHubyaL9qw=dF3w@mail.gmail.com>
Subject: Re: [PATCH 0/5] pmdomain: Restore behaviour for disabling unused PM domains
To: Diederik de Haas <didi.debian@cknow.org>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>, Ulf Hansson <ulf.hansson@linaro.org>, 
	Heiko Stuebner <heiko@sntech.de>, "Rafael J . Wysocki" <rafael@kernel.org>, 
	Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>, Thierry Reding <thierry.reding@gmail.com>, 
	Sebastian Reichel <sebastian.reichel@collabora.com>, Jonathan Hunter <jonathanh@nvidia.com>, 
	linux-rockchip@lists.infradead.org, Konrad Dybcio <konradybcio@kernel.org>, 
	Peng Fan <peng.fan@oss.nxp.com>, linux-pm@vger.kernel.org, 
	Johan Hovold <johan@kernel.org>, Sebin Francis <sebin.francis@ti.com>, 
	Michal Simek <michal.simek@amd.com>, linux-arm-kernel@lists.infradead.org, 
	Maulik Shah <maulik.shah@oss.qualcomm.com>, Stephen Boyd <sboyd@kernel.org>, 
	Bjorn Andersson <andersson@kernel.org>, Christian Hewitt <christianshewitt@gmail.com>, 
	linux-kernel@vger.kernel.org, Abel Vesa <abel.vesa@linaro.org>, 
	Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 11, 2025 at 1:26=E2=80=AFAM Diederik de Haas <didi.debian@cknow=
.org> wrote:
>
> Hi Geert,
>
> On Thu Sep 11, 2025 at 9:18 AM CEST, Geert Uytterhoeven wrote:
> > On Wed, 10 Sept 2025 at 21:33, Diederik de Haas <didi.debian@cknow.org>=
 wrote:
> >> On Tue Sep 9, 2025 at 1:11 PM CEST, Ulf Hansson wrote:
> >> > Recent changes to genpd prevents those PM domains being powered-on d=
uring
> >> > initialization from being powered-off during the boot sequence. Base=
d upon
> >> > whether CONFIG_PM_CONFIG_PM_GENERIC_DOMAINS_OF is set of not, genpd =
relies
> >> > on the sync_state mechanism or the genpd_power_off_unused() (which i=
s a
> >> > late_initcall_sync), to understand when it's okay to allow these PM =
domains
> >> > to be powered-off.
> >> >
> >> > This new behaviour in genpd has lead to problems on different platfo=
rms [1].
> >> >
> >> > In this series, I am therefore suggesting to restore the behavior of
> >> > genpd_power_off_unused() along with introducing a new genpd config f=
lag,
> >> > GENPD_FLAG_NO_STAY_ON, to allow genpd OF providers to opt-out from t=
he new
> >> > behaviour.
> >>
> >> Is it expected that I'm still seeing this on a Rock64 (rk3328), just
> >> like before [1]?
> >>
> >>   [   17.124202] rockchip-pm-domain ff100000.syscon:power-controller: =
sync_state() pending due to ff300000.gpu
> >>   [   17.129799] rockchip-pm-domain ff100000.syscon:power-controller: =
sync_state() pending due to ff350000.video-codec
> >>   [   17.140003] rockchip-pm-domain ff100000.syscon:power-controller: =
sync_state() pending due to ff360000.video-codec
> >
> > Yes, as the sync state is still blocked on them.
> > Disabling unused PM Domains is done independently of sync state.
> >
> >> This is with a 6.17-rc5 kernel with this patch set applied.
> >> And it also has this patch from Christian Hewitt added, now in v3:
> >> https://lore.kernel.org/linux-rockchip/20250906120810.1833016-1-christ=
ianshewitt@gmail.com/
> >>
> >> When I boot into a 6.17-rc5 kernel without any patches applied, I do g=
et
> >> the 2 for ff350000.video-codec and ff360000.video-codec, but not the
> >> ff300000.gpu one.
> >>
> >> Interestingly:
> >> ff300000.gpu -> power-domains =3D <&power RK3328_PD_GPU>;
> >> ff350000.video-codec -> power-domains =3D <&power RK3328_PD_VPU>;
> >> ff360000.video-codec -> power-domains =3D <&power RK3328_PD_VIDEO>;
> >>
> >> I would be surprised if that was a coincidence.
> >
> > Fw_devlinks ignores the index cell (RK3328_PD_*), hence all links are
> > created pointing to the pmdomain controller (in case it has a platform
> > driver) or the first pmdomain (in case it has not). thus blocking the
> > sync state call and power-down for _all_ pmdomains managed by the
> > controller.
>
> I don't think I fully understand this (not your problem due to lack of
> knowledge on my part), but you mentioning 'fw_devlink' rang a bell.
>
> Some time ago Nicolas Frattaroli and I worked on an image for PINE64's
> *Quartz* devices and that added ``fw_devlink=3Doff`` to cmdline.
> I've been using it on all my Rockchip based devices, without
> understanding that parameter ... but (apparently) on my 'rock64-test'
> device, where I tested it with, I had removed that parameter.
> Putting that parameter back ... and those warnings are gone!
>
> Thanks a LOT for that hint!

Please don't just disable fw_devlink using fw_devlink=3Doff. We want to
fix any issues you are hitting with it. I might even delete this "off"
option sometime. It was meant as an early debug option.

Thanks,
Saravana

