Return-Path: <linux-pm+bounces-14489-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 46B2597CDBD
	for <lists+linux-pm@lfdr.de>; Thu, 19 Sep 2024 20:37:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7A38A1C22241
	for <lists+linux-pm@lfdr.de>; Thu, 19 Sep 2024 18:37:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31D70210E7;
	Thu, 19 Sep 2024 18:36:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=antheas.dev header.i=@antheas.dev header.b="ErCWqO9D"
X-Original-To: linux-pm@vger.kernel.org
Received: from linux1587.grserver.gr (linux1587.grserver.gr [185.138.42.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8426E1BDDB;
	Thu, 19 Sep 2024 18:36:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.138.42.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726770977; cv=none; b=f/Km9Zue8RVGUwrn3wmxnhNwmZC/DWZJ3kynrgbyaaHJl0LkoIbDAnCmudJxlixi+Cfm/2o2+nEf6HJKquTSCDGTFc/ln3qo0WqQRrJ342qjS/2+X6d8ru9/uk4GbX8Yo3tx9x4ZDsRdrCjj2OnSWDn9A/+6i17Co88Tc3Bonng=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726770977; c=relaxed/simple;
	bh=s+yF+li2j831a0ZBLYu9KANv2eyqLt5OF+PS5kwZbeo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UJf8Ydf+M4VsRz8qaaA6L10e8YK4smEAZ/dp3r743IIxLhX+eTMNmc0hNcMd48GUXOoVYQZrrRCteWhGvmsVdJKaSW2UvCVabKUBMmBXVro4iaCbU7v6funZ/KrePxlX0he8K2Od4PkGsIKrndK2RpJE15lu9tyhEy1BjA8H6ro=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=antheas.dev; spf=pass smtp.mailfrom=antheas.dev; dkim=pass (1024-bit key) header.d=antheas.dev header.i=@antheas.dev header.b=ErCWqO9D; arc=none smtp.client-ip=185.138.42.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=antheas.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=antheas.dev
Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com [209.85.208.178])
	by linux1587.grserver.gr (Postfix) with ESMTPSA id 6E8832E09C2A;
	Thu, 19 Sep 2024 21:36:11 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=antheas.dev;
	s=default; t=1726770972;
	bh=s+yF+li2j831a0ZBLYu9KANv2eyqLt5OF+PS5kwZbeo=;
	h=Received:From:Subject:To;
	b=ErCWqO9DvrDgJElXQTBQ+sJRsZMT9p367mIqc6Dapgk+R705B/3/G6EYlM1jIkbmL
	 DTjSdEpZ+GayYpaqetysi+wL4eq5b3K1GnGlDnB9A88JtpblIlMzH5XJZjwNSdjf1l
	 bSXRY2nSWbaY4ltMkf+0epbtr26ifrAbFJWPvJbI=
Authentication-Results: linux1587.grserver.gr;
        spf=pass (sender IP is 209.85.208.178) smtp.mailfrom=lkml@antheas.dev smtp.helo=mail-lj1-f178.google.com
Received-SPF: pass (linux1587.grserver.gr: connection is authenticated)
Received: by mail-lj1-f178.google.com with SMTP id
 38308e7fff4ca-2f75d044201so12386641fa.0;
        Thu, 19 Sep 2024 11:36:11 -0700 (PDT)
X-Forwarded-Encrypted: i=1;
 AJvYcCV7YhdOK0UweqGt5B7dcaudbeDezbjnbkGLxVrgPoi4qhubrk2GfYkMWRRFnt7hcOTqRMx1ecMBPKGpXQxtyGsw+5LgWA==@vger.kernel.org,
 AJvYcCVjLzr3BO3k3VNQ1HUSth5HVJTUjmZWXuDpt8Y51yTHZADtHLaP9p38Pz2yjHJGxnpaTjwLV0JVnw==@vger.kernel.org
X-Gm-Message-State: AOJu0YyuLN2yC/zULSCdlzSDc41PI4Dlemy2PyygMimdbH2ISjEDgomf
	zPcz5SLAlG0R/opelRKG4kb0M3DZgv3CoKxs++4cf7qCFU+jbR+5dMuONs1NWrXnziZNxmq4WjU
	R+YBiGvz0P3RMPmUga1QiSmQSe8Y=
X-Google-Smtp-Source: 
 AGHT+IHmNya4OPcOSlW1TjozX0vzXq3jKpe0VXQKwfXwNhht30gBxB456OdVxlYcQYq7rFNsvLLSWCiZGYtUBsg+xMM=
X-Received: by 2002:a05:651c:221e:b0:2f7:5ca2:6d10 with SMTP id
 38308e7fff4ca-2f7cb364489mr1808451fa.15.1726770970830; Thu, 19 Sep 2024
 11:36:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240919171952.403745-1-lkml@antheas.dev>
 <20240919171952.403745-3-lkml@antheas.dev>
 <1cbc0cda-549a-4333-9045-470c51981af5@amd.com>
 <CADnq5_N63ncHDdr+=xB5RqYZXnMjjrVCgqTDz0zmPdSP98ip-A@mail.gmail.com>
 <248d6066-bf38-43a5-bfb1-91ce855ea03b@amd.com>
In-Reply-To: <248d6066-bf38-43a5-bfb1-91ce855ea03b@amd.com>
From: Antheas Kapenekakis <lkml@antheas.dev>
Date: Thu, 19 Sep 2024 20:35:59 +0200
X-Gmail-Original-Message-ID: 
 <CAGwozwHy28hrZ1WxVEtd2cAB9YjrZZSoeA3QYity+Jks4Xr6Ug@mail.gmail.com>
Message-ID: 
 <CAGwozwHy28hrZ1WxVEtd2cAB9YjrZZSoeA3QYity+Jks4Xr6Ug@mail.gmail.com>
Subject: Re: [PATCH v1 2/4] acpi/x86: s2idle: handle screen off/on calls
 outside of suspend sequence
To: Mario Limonciello <mario.limonciello@amd.com>
Cc: Alex Deucher <alexdeucher@gmail.com>, "Luke D. Jones" <luke@ljones.dev>,
 linux-pm@vger.kernel.org,
	"dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
 platform-driver-x86@vger.kernel.org,
	me@kylegospodneti.ch
Content-Type: text/plain; charset="UTF-8"
X-PPP-Message-ID: 
 <172677097183.13658.10518942214368935288@linux1587.grserver.gr>
X-PPP-Vhost: antheas.dev
X-Virus-Scanned: clamav-milter 0.103.11 at linux1587.grserver.gr
X-Virus-Status: Clean

Hi,
as noted in the cover letter, I think the connection to DRM is a red herring.

The Display off callback in Windows is always called 5 seconds after
the screen turns off due to inactivity or instantly if the user
presses the power button. Likewise, Display on is called when the
display is about to turn on.

In fact, pressing the powerbutton in Windows no longer suspends the
device. It just locks the session and turns off the screen. Then
Windows can do whatever it wants for however long it wants before
suspending the device. It took me 2 days to realise this, as my dev
unit was updating and it stayed happily on for 10-20 minutes after
pressing the power button when connected to a charger.

I think "Screen Off" is what Microsoft decided to call their
background wakelock state (as it is called in Android). That means
that if there is ever a laptop with an Always On display, it will be
on the "Screen Off" state while the screen is on.

Antheas

