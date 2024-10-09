Return-Path: <linux-pm+bounces-15395-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A7AEC996A3E
	for <lists+linux-pm@lfdr.de>; Wed,  9 Oct 2024 14:40:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1F3A1B23C27
	for <lists+linux-pm@lfdr.de>; Wed,  9 Oct 2024 12:40:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9EF99196450;
	Wed,  9 Oct 2024 12:40:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="X1znPr9U"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-yb1-f177.google.com (mail-yb1-f177.google.com [209.85.219.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB28A195381
	for <linux-pm@vger.kernel.org>; Wed,  9 Oct 2024 12:40:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728477630; cv=none; b=Aye03rsi6SpWAJ0oAv+faPD/mmkIZORXbDJbhd90JghdAygV2zM2R7D0CD/Ke46bHZJHiFptpWA7PCVLg4OAWAOkP7b+PH+M8YrBdu69Ab8+bs+x2tcH1t0OOzeUe3pSyk5btWNYTUtnFnuFLLLge3d34D1eMbbMaPvhQf7v8VA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728477630; c=relaxed/simple;
	bh=NX34IxOgzpU/58lP/IC+KEU7eNMZKOWaom9j0SKbKLs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hZkMFXDLrXqfYJGqJ6HoQz5d0nm1vdk8R7QCPBtElDW5rSXn+TpdH8Uae6Fn7mSgv7EQKD8JqiG2cK9gy0dUZGArVvrvSnBAVTPtmRQb/3ATaPOvHeFUsQdFv83pfejgRTKmRP6mYnSEdKPICRDxp4Fvu9I8Fg+cHjDypCHb0Hc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=X1znPr9U; arc=none smtp.client-ip=209.85.219.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yb1-f177.google.com with SMTP id 3f1490d57ef6-e28fd8cdfb8so857744276.3
        for <linux-pm@vger.kernel.org>; Wed, 09 Oct 2024 05:40:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1728477628; x=1729082428; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kPZfCYV/wy71ba4BSJvyuLIGj5SMt+aZjw2X+wMCyV4=;
        b=X1znPr9Ub7yckj/3cefLuGg/zu0ps3DGSjPhGaqjS8Yyj/aDEuPfXXJQReCX1DOlle
         qlbeEkEw3RI6gwQGWBzRqhVzdXkmH3K1LgKFu42871nuCrx0msDm394ZKvg8gmDKgUx3
         uxGCVXb91C9n2cYRSHsQ28vv1SV/UHndLJSz6uE2HoMrPb09GAIpxKyfi2x9quJZG1nj
         fXlhw42CqwdEOJCQFDgrIKUceLrb1dNsj/5h8kBnRm/aFBYImOMHm9n3AFqF3aKfHihx
         JJFKXWS7+mdG4pO789nd12yLIIUD3BWqPqWo45dszzqlcPNKZjkH6oCvS0OShYK6RT8h
         HCJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728477628; x=1729082428;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kPZfCYV/wy71ba4BSJvyuLIGj5SMt+aZjw2X+wMCyV4=;
        b=wD+l5TDpBUDfbLzQKcNBO70No2qdVmOJ4Fg5ERRZKdXcXWJRPtRxYXxhhysR/KeBcr
         0ZUV4I7l647G10SNQMit8c4XoZcN9c9snoX06ATNPPe/xtRD0vkkFkyNER6e+i7eI4iR
         2AWwr3J5sju6Em1n0VJGBTFoq7yNihW4p9nl74rJnzGZ1d3hebpGTNAwAugJghwPtaST
         ke30PpK5tT7g2f2VjhUBettToSFo0eU12gsqv9YtgcdaHPSjE111BE0OYcnFsk6XwOI9
         Joxd8s97I/SAQ3vTy/4Wh+/ALPV6eaYD4h6W6lZdwgAfaVrrJGZ4/GsgRzEDSJcMvEUq
         vscw==
X-Forwarded-Encrypted: i=1; AJvYcCUT/TWkT0nQd7u7A5K5qxUehNPweVr3S5vhD6YsMWS1CXKrXo2kmRjSa8nNzfoitnE97dDJzUptJQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Yxq5ijdJxxayYgBPeNlaVSGNmMnYJYtYcNI6KVtdb2g55AJTHp3
	+i0F8elNZiaTbaZWxLPtQuMC4GRhOrt6VyhL7O40DkMNqZvlVLuC9inx9LubmVzxBw4CXVjLPsO
	65smdhmmZKFw9wcBFED6oslIIzaVRnfkFqDAa5Q==
X-Google-Smtp-Source: AGHT+IFMhQJXg0E+KgtQQV2VTHLP9Hnj16lRLdW5+uaKNhSiRNc2pcvPFCL51GS0djemx0sYBfMwlHxGs+hepVq+tqM=
X-Received: by 2002:a05:6902:15cd:b0:e25:cdc2:ed93 with SMTP id
 3f1490d57ef6-e28fe43f401mr1818390276.30.1728477627975; Wed, 09 Oct 2024
 05:40:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241008-8250-omap-no-console-suspend-v1-0-e7f0365c02f0@bootlin.com>
 <20241008-8250-omap-no-console-suspend-v1-2-e7f0365c02f0@bootlin.com>
 <CAPDyKFpnsV-c4F7SNPQmLBSM1sUknr-3sTyiXMDt9n43UBQkNg@mail.gmail.com> <d879d544-4b1d-4b4a-bfd4-efb35b6a57c1@bootlin.com>
In-Reply-To: <d879d544-4b1d-4b4a-bfd4-efb35b6a57c1@bootlin.com>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Wed, 9 Oct 2024 14:39:51 +0200
Message-ID: <CAPDyKFoOV00JzQ=+j7FJzVb0Zb4j-qjR5YPT020TzyJKngeFMg@mail.gmail.com>
Subject: Re: [PATCH 2/2] serial: 8250_omap: mark the serial as on the wakeup
 path if no_console_suspend
To: Thomas Richard <thomas.richard@bootlin.com>
Cc: Nishanth Menon <nm@ti.com>, Tero Kristo <kristo@kernel.org>, 
	Santosh Shilimkar <ssantosh@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Jiri Slaby <jirislaby@kernel.org>, linux-arm-kernel@lists.infradead.org, 
	linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-serial@vger.kernel.org, u-kumar1@ti.com, tony@atomide.com, 
	khilman@kernel.org, gregory.clement@bootlin.com, thomas.petazzoni@bootlin.com, 
	theo.lebrun@bootlin.com, richard.genoud@bootlin.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, 9 Oct 2024 at 14:17, Thomas Richard <thomas.richard@bootlin.com> wr=
ote:
>
> On 10/9/24 12:50, Ulf Hansson wrote:
> > On Tue, 8 Oct 2024 at 11:34, Thomas Richard <thomas.richard@bootlin.com=
> wrote:
> >>
> >> If the console suspend is disabled, mark the serial as on the wakeup p=
ath
> >> to keep its PM domain powered on.
> >>
> >> Suggested-by: Th=C3=A9o Lebrun <theo.lebrun@bootlin.com>
> >> Signed-off-by: Thomas Richard <thomas.richard@bootlin.com>
> >> ---
> >>  drivers/tty/serial/8250/8250_omap.c | 8 ++++++--
> >>  1 file changed, 6 insertions(+), 2 deletions(-)
> >>
> >> diff --git a/drivers/tty/serial/8250/8250_omap.c b/drivers/tty/serial/=
8250/8250_omap.c
> >> index 88b58f44e4e9..6764fe2f9cad 100644
> >> --- a/drivers/tty/serial/8250/8250_omap.c
> >> +++ b/drivers/tty/serial/8250/8250_omap.c
> >> @@ -1660,8 +1660,12 @@ static int omap8250_suspend(struct device *dev)
> >>         if (!device_may_wakeup(dev))
> >>                 priv->wer =3D 0;
> >>         serial_out(up, UART_OMAP_WER, priv->wer);
> >> -       if (uart_console(&up->port) && console_suspend_enabled)
> >> -               err =3D pm_runtime_force_suspend(dev);
> >> +       if (uart_console(&up->port)) {
> >> +               if (console_suspend_enabled)
> >> +                       err =3D pm_runtime_force_suspend(dev);
> >> +               else
> >> +                       device_set_wakeup_path(dev);
> >> +       }
> >
> > Isn't this already managed by the serial core? See commit a47cf07f60dc
> > ("serial: core: Call device_set_awake_path() for console port")
>
> Yes you're right.
> So this patch is useless.

So patch 1/2 is all you need to get things working?

Kind regards
Uffe

