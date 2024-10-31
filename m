Return-Path: <linux-pm+bounces-16815-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B89D9B789E
	for <lists+linux-pm@lfdr.de>; Thu, 31 Oct 2024 11:26:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3B12C2825DC
	for <lists+linux-pm@lfdr.de>; Thu, 31 Oct 2024 10:26:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39DD71991CB;
	Thu, 31 Oct 2024 10:26:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="blljDZwE"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-yw1-f179.google.com (mail-yw1-f179.google.com [209.85.128.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCC531990AE
	for <linux-pm@vger.kernel.org>; Thu, 31 Oct 2024 10:26:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730370368; cv=none; b=R6yDnoTABdFP/y8niE54kPyhMtuPdasQUoMdgDHzFfXuC1lgtsNgTNwYJAJgsSSLT5vN91C0Zg8lKsjxAkn90momvq/CIiChi+mGu8kd56EVGNcDR8XluALnHPkofselRoqPVoFJYCnDKSncxUCtTUHP2fafKBlmMkYKEghZuO4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730370368; c=relaxed/simple;
	bh=jdoVubndjXT0Snb1ihqLSb57sLn8R4s6WkzBF1b6vKI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LDnjsGvdwiCzixEIsbIZdRN45+27adYURBzaX+Kppw65igberixLTL25L1SRvtvoFxBkW5YfOqztudsKWYx33hgCfpLmzNRP4hXTbSaKKY6LSYCfSr2bU6wsgMdltUbFkmupriBiFT9+tSflwyTl+DKBPb4joEBAK5UTSJltLKY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=blljDZwE; arc=none smtp.client-ip=209.85.128.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yw1-f179.google.com with SMTP id 00721157ae682-6ea5003deccso7838587b3.0
        for <linux-pm@vger.kernel.org>; Thu, 31 Oct 2024 03:26:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1730370365; x=1730975165; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=f5+EavlWdyO9mIBzplaKVzqRvhj0odhaF59om4fXhNI=;
        b=blljDZwEPjGoCVN0iCMZW3JXX7J9vEQRSpsUHwysbX4xH76il89q0odMAr3DvO1C0d
         dRHtMJiaNVhNZTksQnXAUsya6Ly6MSep2WsN+wLEHKPF2TQyj0jPyRGIWrmRSPJcW4yN
         wAWFqzBGYm9e1eiqwOICJHERyaHkQYl+vtZWuAu8m/vuf5dRvrsm4tVEnvceXeLHues0
         B8IQjvZydJoFpnwcwoXGYrPov0O6Ki8pW/ph9mchLfyD5pnl7qJnb8+F4Lwehq1EaIVe
         UflVT7CnTr0Q/vARvlGSo6wigFtqAZAtLRddrYNgLQm8ZYUtI3OCgyP/s2qwFDVwMl2y
         /7EQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730370365; x=1730975165;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=f5+EavlWdyO9mIBzplaKVzqRvhj0odhaF59om4fXhNI=;
        b=WxnGdPjUsbCrC1ck4BNn8JZu3H2I9TvVAOWnytUpTIwRqZSDBknUi0bGDjw33UDdEx
         jd0mj5GLyzgu2ZcKmqlhMFHv6cpVdWefToVVWyk42GSe9sVZdTCATqEDwkvZqX2l5+we
         +bedeqrbmw2CIkPy0YfAVwTCAQOaOfXUvWVkFN4bVA50Z4zgJ4HWq6Mr+T33it1SaRxY
         F3KUBFeqUw+QIcQC/UWPOFwL4XfwUj4uS1pOq5Cgn14LsuMG8RaMWatzsR9dAcl+N307
         O8Bh+9YqxjkcrgordIDBBYngl2azZhd5aGjZ1Cy9i3vPmBn/kU2mq2stfXZ5h7ZhvucO
         hJlw==
X-Forwarded-Encrypted: i=1; AJvYcCWHu2Th+KWCe30Iu9xbNHDfwY60DV8/esuoudnua+2ubGLGbTDmv/ccQRYB6GJOxjzAfra/MdRNKA==@vger.kernel.org
X-Gm-Message-State: AOJu0YyOqzGD8yIu/aUmEkeGATDj+esxr02+npsr+UflfLSuPnJ8vKn2
	dtjfS2IICqZEGgwAic/M6cJH7+7O8nE1Bn8BI0iwF/KWDZbsS0OlZs0MEN5gesQNxLpAbtJheS7
	tl0rqgYuigmnX1Y4qjVeVxehXJTuHnbwqDimMhA==
X-Google-Smtp-Source: AGHT+IED7ORvK8ZV2gzBVmXLObiKch/Cqk/NhnIXHt1YeB2LkWDkoQQR0h/2v8YDvtpi/KE6By4guMk7YscOzcSA2Kk=
X-Received: by 2002:a05:690c:6a0a:b0:6e2:1b8c:ad28 with SMTP id
 00721157ae682-6e9d897c900mr199964757b3.24.1730370364810; Thu, 31 Oct 2024
 03:26:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241022-tisci-pd-boot-state-v1-1-849a6384131b@ideasonboard.com>
 <7hmsilqrw3.fsf@baylibre.com> <0f027b8e-9c41-4754-923b-2a285fb9593a@ideasonboard.com>
In-Reply-To: <0f027b8e-9c41-4754-923b-2a285fb9593a@ideasonboard.com>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Thu, 31 Oct 2024 11:25:29 +0100
Message-ID: <CAPDyKFqoXfooy-ipo_aE91TwFQOaj=Z5SZJ4G_4Hh7jCvkyTVQ@mail.gmail.com>
Subject: Re: [PATCH RFC] pmdomain: ti-sci: Set PD on/off state according to
 the HW state
To: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
Cc: Kevin Hilman <khilman@baylibre.com>, Nishanth Menon <nm@ti.com>, Tero Kristo <kristo@kernel.org>, 
	Santosh Shilimkar <ssantosh@kernel.org>, linux-arm-kernel@lists.infradead.org, 
	linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, vishalm@ti.com, 
	sebin.francis@ti.com, d-gole@ti.com, Devarsh Thakkar <devarsht@ti.com>, 
	Vignesh Raghavendra <vigneshr@ti.com>
Content-Type: text/plain; charset="UTF-8"

On Thu, 31 Oct 2024 at 08:39, Tomi Valkeinen
<tomi.valkeinen@ideasonboard.com> wrote:
>
> Hi,
>
> On 30/10/2024 22:04, Kevin Hilman wrote:
> > Tomi Valkeinen <tomi.valkeinen@ideasonboard.com> writes:
> >
> >> At the moment the driver sets the power state of all the PDs it creates
> >> to off, regardless of the actual HW state. This has two drawbacks:
> >>
> >> 1) The kernel cannot disable unused PDs automatically for power saving,
> >>     as it thinks they are off already
> >>
> >> 2) A more specific case (but perhaps applicable to other scenarios
> >>     also): bootloader enabled splash-screen cannot be kept on the screen.
> >>
> >> The issue in 2) is that the driver framework automatically enables the
> >> device's PD before calling probe() and disables it after the probe().
> >> This means that when the display subsystem (DSS) driver probes, but e.g.
> >> fails due to deferred probing, the DSS PD gets turned off and the driver
> >> cannot do anything to affect that.
> >>
> >> Solving the 2) requires more changes to actually keep the PD on during
> >> the boot, but a prerequisite for it is to have the correct power state
> >> for the PD.
> >>
> >> The downside with this patch is that it takes time to call the 'is_on'
> >> op, and we need to call it for each PD. In my tests with AM62 SK, using
> >> defconfig, I see an increase from ~3.5ms to ~7ms. However, the added
> >> feature is valuable, so in my opinion it's worth it.
> >>
> >> The performance could probably be improved with a new firmware API which
> >> returns the power states of all the PDs.
> >
> > Agreed.  I think we have to pay this performance price for correctness,
> > and we can optimizie it later with improvements to the SCI firmware and
> > a new API.
> >
> >> There's also a related HW issue at play here: if the DSS IP is enabled
> >> and active, and its PD is turned off without first disabling the DSS
> >> display outputs, the DSS IP will hang and causes the kernel to halt if
> >> and when the DSS driver accesses the DSS registers the next time.
> >
> > Ouch.
> >
> >> With the current upstream kernel, with this patch applied, this means
> >> that if the bootloader enables the display, and the DSS driver is
> >> compiled as a module, the kernel will at some point disable unused PDs,
> >> including the DSS PD. When the DSS module is later loaded, it will hang
> >> the kernel.
> >>
> >> The same issue is already there, even without this patch, as the DSS
> >> driver may hit deferred probing, which causes the PD to be turned off,
> >> and leading to kernel halt when the DSS driver is probed again. This
> >> issue has been made quite rare with some arrangements in the DSS
> >> driver's probe, but it's still there.
> >>
> >> So, because of the DSS hang issues, I think this patch is still an RFC.
> >
> > Like you said, I think that DSS hang is an issue independently of this
> > patch, so it shouldn't hold this up IMO.
>
> In current upstream, if the bootloader has enabled the display, we most
> likely won't hit the DSS hang issue as the PD will stay on until the DSS
> driver has had a chance to probe, and the driver takes actions to avoid
> the hang issue.
>
> With this patch applied, the PD may be turned off before the DSS driver
> has had a chance to probe, causing the board to hang when the DSS driver
> probes the first time.
>
> That's why I'm a bit hesitant to apply this. It could mean that for some
> people their board stops booting.
>
> I'm not even sure what would be the perfect fix for this hang problem...
>
> We could have some built-in early boot code which checks if the DSS is
> enabled, and disables it, so that the hang issue won't happen. But
> that's not good if we try to keep the boot splash on the screen until
> the userspace takes over.
>
> Alternatively we could, somehow, mark the DSS powerdomain to be handled
> in a special way: if the PD is enabled at boot time, it will be kept
> enabled until the DSS driver (somehow) changes the PD back to normal
> operation (and if DSS driver is never loaded, PD will stay on).

This option is kind of what I am working on. Although, the goal is to
keep the code generic, so ideally we should not need any changes in
the DSS driver to make this work. Let's see.

That said, it sounds like we should defer $subject patch until we have
a solution for the above, right?

[...]

Kind regards
Uffe

