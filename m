Return-Path: <linux-pm+bounces-35459-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 68D48BA3935
	for <lists+linux-pm@lfdr.de>; Fri, 26 Sep 2025 14:05:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 184AE171943
	for <lists+linux-pm@lfdr.de>; Fri, 26 Sep 2025 12:05:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E19FA2EA754;
	Fri, 26 Sep 2025 12:05:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="tUBqAgWV"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-yx1-f49.google.com (mail-yx1-f49.google.com [74.125.224.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1047D86353
	for <linux-pm@vger.kernel.org>; Fri, 26 Sep 2025 12:05:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758888344; cv=none; b=Wz3PkjzSWdSrHRyp9b5519xtCUDKrxKt3nZBvLhBxk5wSIVjbLmUe7nIkmCeuT4+1r/DWT/nYtoM32Sj8ilM42n+UUFmeE/TJbqWiliD63ONe8kucyKlhjfICo7f9YgsqEI2dj1orEPJsVcXMui1V0XkYosEEo8/Iz+teRrvKhg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758888344; c=relaxed/simple;
	bh=0TP+8hdoSAkERstQA78VRAN5sTgbvs3RBPr5mvjNn7k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fT1ZSG64H9egvdK8v/pWUBUe85xg+ptqJYv0faUxHq9eSDx786DTQKfTlxLuM5JK6gf243rpaGSNY0AQDcvkHhYSFz1bpV9Dn+ttYzeNra/sreNCOV4slO3ew/ZUleKuKUOgqsc64KqAS+2S10V0hHQk0dp7vH9+job9/g9wGII=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=tUBqAgWV; arc=none smtp.client-ip=74.125.224.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yx1-f49.google.com with SMTP id 956f58d0204a3-6348447d5easo979215d50.0
        for <linux-pm@vger.kernel.org>; Fri, 26 Sep 2025 05:05:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1758888342; x=1759493142; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0TP+8hdoSAkERstQA78VRAN5sTgbvs3RBPr5mvjNn7k=;
        b=tUBqAgWVxlyCqCpm2s4vXulsiXttNZW9/+Pw0MxPdv8G9ABdtyIp9L/vPX1yHpWg2f
         wdE4yJV6FL8fBbtV+v88Zf5GWKNx+TQQN/4H/EwaptqSXFXwAuLgd32guuUX5b8Cmjzh
         fYo5s/PwUsSAVdIIonho7S29BN1hRgkPVGUHfU3EQR0O6a6By8phAtUVrwYn1PmT9HDH
         E7LgBxtkuBh3+w99yeHegGGiSB5IzmnKki5WDzWLkFsKeX1OscljStduy4zlc2DHTXAH
         EVnaXHWRMpOqJ2Yp1G4tQWK9B2JgUJf/fVEWKeV3NGGrlgF/MvdJjSslNsoKInUV988T
         PiSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758888342; x=1759493142;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0TP+8hdoSAkERstQA78VRAN5sTgbvs3RBPr5mvjNn7k=;
        b=UV02jGu6gAOAG2+k8qCwtLQXpXlMxlEugqZYXrI7xUjnsKfAXg5hNh2WznPdWT4U5X
         rAkA/VkCZpz1a52cCeDNvybuOKxa3pJ8Dsslqcf/VLB3U0/LVdCD7+ajZIJbbWGndqL6
         YzLRTDlq+ztjTQP4HvGIisFojQUdebN2pASN7A0tS++UrDpSZ4qMeOiyr93nrtBxMufE
         CNqTAQ9KPDFRWvAd0r18llT7CpWs+s8EyFR3L2GiiTmOxIKYdgr1fE14wdUk411SC/s6
         dKBJl+Mfgs9tJf4K5/o+0pGxfR9QJZvhEOCI7JxCMmSggw73n8tyL6oFbBf8oZRA+FXb
         DicQ==
X-Forwarded-Encrypted: i=1; AJvYcCW5hZiEaizKemnuVdTZXLZU0Y8CJWhrLC16uLvCaDtidQoWmXfWHZkueppvOO2GkbzQ9je81r1vQA==@vger.kernel.org
X-Gm-Message-State: AOJu0YyXep5VMOlbtPzdKNTzYSKCv+k0sYwZSRIM1e0rvwg+o/SJAeC3
	/DNpsIx3+oEX/9BHJK993l0s0fb27mV8N+IIBSm+Fx/naxPyhRhmcV/h4oQ1uQvLdMO/P+HhSUW
	YIyeJGw2PX28BO5V1BBdmfXzp3IfcinH1fVM3NZsbJQ==
X-Gm-Gg: ASbGncugepx+uxFSt8HVI/sVYHw9jiafRfydpkMKKQx4UenLtVncU1Y8P9yIpteyZy/
	s7nCbUIYnxW0Kg7DYzueb6cceGHxjroy1gCf4DSS+KwvV5jzRSGnItgMT9Ey6PbB7K/pCWSCe1j
	x3jF3KQzekjgGZGfldiKV6haanUCl6nXUzxpq/2i6Rx86Hb3eck8I5UOVaVFtA7QWVW6P0PKdqW
	mcb7oLO
X-Google-Smtp-Source: AGHT+IFpst3LXzx1Tq4PLgIty1+eS+58cwQoh3HNSZyTfCuJz5+TvVyNnNmlTvzX9guzqldlM2Jv1pKgKvuJHT5Cmj4=
X-Received: by 2002:a05:690e:165a:b0:633:a95e:ef08 with SMTP id
 956f58d0204a3-6361a6e6c15mr5078517d50.5.1758888341664; Fri, 26 Sep 2025
 05:05:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250925115924.188257-1-ulf.hansson@linaro.org>
 <DD1XOHE6P5OC.2JUQRAGAE1KTU@cknow.org> <CAPDyKFrKP2bdpKTHzqDdhEpRAjYu+PFd2Bst=-WPddByxcAX_w@mail.gmail.com>
 <DD22MGF3HNLM.Q7S70RX4NZXS@cknow.org> <CAGETcx-WY1x_ud8Ef1jbpYQVtFv7MZHMpHfSVKA9R9tya0Lxjw@mail.gmail.com>
In-Reply-To: <CAGETcx-WY1x_ud8Ef1jbpYQVtFv7MZHMpHfSVKA9R9tya0Lxjw@mail.gmail.com>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Fri, 26 Sep 2025 14:05:05 +0200
X-Gm-Features: AS18NWAKTgOg0DoWt4DwiJMugagxp-PZXuEf5kMf0e6fNFZs94EGFqwIW10RP38
Message-ID: <CAPDyKFp0uV2WaQGjwsO8JG1zF_1oXj7-GVnaejih+dN9RAdykg@mail.gmail.com>
Subject: Re: [PATCH] driver core: fw_devlink: Don't warn in fw_devlink_dev_sync_state()
To: Saravana Kannan <saravanak@google.com>
Cc: Diederik de Haas <didi.debian@cknow.org>, "Rafael J . Wysocki" <rafael@kernel.org>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-pm@vger.kernel.org, 
	Geert Uytterhoeven <geert@linux-m68k.org>, 
	Nicolas Frattaroli <nicolas.frattaroli@collabora.com>, Heiko Stuebner <heiko@sntech.de>, 
	Sebastian Reichel <sebastian.reichel@collabora.com>, Sebin Francis <sebin.francis@ti.com>, 
	Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>, Jon Hunter <jonathanh@nvidia.com>, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, 25 Sept 2025 at 23:49, Saravana Kannan <saravanak@google.com> wrote=
:
>
> On Thu, Sep 25, 2025 at 10:52=E2=80=AFAM Diederik de Haas <didi.debian@ck=
now.org> wrote:
> >
> > On Thu Sep 25, 2025 at 4:26 PM CEST, Ulf Hansson wrote:
> > > On Thu, 25 Sept 2025 at 15:59, Diederik de Haas <didi.debian@cknow.or=
g> wrote:
> > >> On Thu Sep 25, 2025 at 1:59 PM CEST, Ulf Hansson wrote:
> > >> > Due to the wider deployment of the ->sync_state() support, for PM =
domains
> > >> > for example, we are receiving reports about the messages that are =
being
> > >> > logged in fw_devlink_dev_sync_state(). In particular as they are a=
t the
> > >> > warning level, which doesn't seem correct.
> > >> >
> > >> > Even if it certainly is useful to know that the ->sync_state() con=
dition
> > >> > could not be met, there may be nothing wrong with it. For example,=
 a driver
> > >> > may be built as module and are still waiting to be initialized/pro=
bed.
> > >>
> > >> "there may be nothing wrong with it" doesn't sound very convincing.
> > >> So there *can* be something wrong with it, so warning sounds
> > >> appropriate? If there is (certainly) something wrong with it, I expe=
ct
> > >> an error.
> > >
> > > Sorry if I was too vague. See more below.
> > >
> > >> FWIW: most of my drivers/modules are built as modules.
> > >> I do seem to run into 'problems' more then average because of that, =
but
> > >> to me it just signals there is something wrong ... which should be
> > >> fixed. Not silenced.
> > >
> > > Well, why is it wrong to have drivers being built as modules? They
>
> IIUC/Remember Kconfig correctly, FW_DEVLINK_SYNC_STATE_TIMEOUT should
> be off by default? (if I don't give any default, what ends up
> happening?)

As "FW_DEVLINK_SYNC_STATE_STRICT" is default, the "sync_state()
pending due..." print gets printed for a lot of consumer devices that
have not been probed yet.

>
> If we can assume, timeout won't happen by default, then the only
> people seeing this warning are people setting the flag or setting the
> command line param. So I'm okay with making it an info.

I think you got this wrong. It's the default behaviour that triggers
lots of prints.

>
> But the "sync_state() pending due to" is for the default behavior. I'm
> assuming without the sync_state() supported added to power domains,
> the ones getting this warning would have been powered off? But after
> the sync_state() support, it's not powered off anymore. That can cause
> increased power usage. Seems like something worth warning about.

Yes, I certainly agree, but...

To me, it kind of sounds like we should change to use
FW_DEVLINK_SYNC_STATE_TIMEOUT as the default behaviour. In that case,
I don't think there is a need to change the log-level for
"sync_state() pending due to..".

>
> Also, another thing I want to understand is, for all the reports you
> are getting for "sync_state() pending due to", is it actually correct
> to have them pending? Or can fw_devlink do better in those cases and
> turn them off? It could be a driver fix/fw_devlink fix depending on
> the issue.

There are some cases that we potentially could fix, in particular for
when a genpd-provider, provides multiple power-domains per device-node
(#power-domain-cells =3D <1>;). But let's discuss that separately.

>
> TL;DR:
> 1. For timeout messages, since timeout isn't default behavior, I'm
> okay making it an info. But
> 2. For pending sync state messages, I think it should remain as a warning=
.

See above.

This means drivers being built as modules will trigger a lot of
warnings, in the default behavior. Is this really what we want?

[...]

Kind regards
Uffe

