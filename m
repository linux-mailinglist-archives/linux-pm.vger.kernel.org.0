Return-Path: <linux-pm+bounces-14544-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C90D97E30A
	for <lists+linux-pm@lfdr.de>; Sun, 22 Sep 2024 21:40:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BACF72810B4
	for <lists+linux-pm@lfdr.de>; Sun, 22 Sep 2024 19:40:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C27F3D967;
	Sun, 22 Sep 2024 19:40:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=antheas.dev header.i=@antheas.dev header.b="IJMP7Muw"
X-Original-To: linux-pm@vger.kernel.org
Received: from linux1587.grserver.gr (linux1587.grserver.gr [185.138.42.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A28CCB64A
	for <linux-pm@vger.kernel.org>; Sun, 22 Sep 2024 19:40:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.138.42.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727034029; cv=none; b=m5e8ryoqqfjb7XyS1qlLBCgF7FPLGvyCV6b8f1YFd2RsK/OEQ6Q2noNWMCHnKfCk85PBRf8GXS8j5X+Eagcbmc/+Z+cIa1e+u5PTstT6vDAm7CzYS9/U8fFEUXRcmPgcW/aR/EY7NLZMJi/fz/nkTSnPnpCH92/fHuISNWV5Fb0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727034029; c=relaxed/simple;
	bh=Zn839mIpvFao3MXk27I+/xYAhwyMxNsHC8EIDyLbfPY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qpWNcVQC2LS/q0Ienqn8/Wj/aNrVTNOSwjz8yHXr6UrjRHUbi4UemTky9jnatWQvtV/vE1xbx2OUFoOZ14HvVEsEzpqmMbVXcfq3DnfzAnuVQe5xqyR8cJMlfZrvzH6DFTXnm8My8WqBSmE8kpQOa22xmLpEAbdNVld8X7jcCIc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=antheas.dev; spf=pass smtp.mailfrom=antheas.dev; dkim=pass (1024-bit key) header.d=antheas.dev header.i=@antheas.dev header.b=IJMP7Muw; arc=none smtp.client-ip=185.138.42.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=antheas.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=antheas.dev
Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com [209.85.208.178])
	by linux1587.grserver.gr (Postfix) with ESMTPSA id 9DBB82E096FC
	for <linux-pm@vger.kernel.org>; Sun, 22 Sep 2024 22:40:22 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=antheas.dev;
	s=default; t=1727034023;
	bh=Zn839mIpvFao3MXk27I+/xYAhwyMxNsHC8EIDyLbfPY=;
	h=Received:From:Subject:To;
	b=IJMP7Muw5sCOAIcytZj+ux59COD49pReug2ZmRBVEUxgifyLByausS5rnF81CQd/O
	 gOehi80rHD8AIzSKnCmJ1cUabPY+oDbTVD43EhEhfQ6eyW+LbXA68iC0THp3WF0FAA
	 e0xtmPIvCKF6ddwxY806eCajow8l+bl2M8qAOU6Y=
Authentication-Results: linux1587.grserver.gr;
        spf=pass (sender IP is 209.85.208.178) smtp.mailfrom=lkml@antheas.dev smtp.helo=mail-lj1-f178.google.com
Received-SPF: pass (linux1587.grserver.gr: connection is authenticated)
Received: by mail-lj1-f178.google.com with SMTP id
 38308e7fff4ca-2f74e468aa8so37475101fa.1
        for <linux-pm@vger.kernel.org>; Sun, 22 Sep 2024 12:40:22 -0700 (PDT)
X-Forwarded-Encrypted: i=1;
 AJvYcCUZ5zzJv4/uEDo40W7d8KS7bY19vOr75g/cCvN0a16NqhucyBx9tKkD9L5P/I2eQRjN2dhKHP8GvQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Yy49SdYESAD36arX7CoEY2bPoJmnO3n39zJ0++5AlL6HVnfV2s6
	1/ulYfBxE6TiDwdBJq+v3Ng+s1pWKfsZMnGxBBYoWSC0H6OTrGsHAPd1p9EcgJ62jKqp+XdTAN0
	+fJr5/4yzU4aM72l+I6BKUy/INeY=
X-Google-Smtp-Source: 
 AGHT+IFNg+UGdlv4GRrgPg2Ej+w5gyKk89eZa7Qml3qOdmio8VQBbU60Z0tkI4USzrkAaZhFniitDrIuLbBY6V79eyU=
X-Received: by 2002:a05:651c:210b:b0:2f5:2e2:eadf with SMTP id
 38308e7fff4ca-2f7cdc13d5bmr37131671fa.10.1727034021894; Sun, 22 Sep 2024
 12:40:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240922172258.48435-1-lkml@antheas.dev>
 <20240922181543.22988-1-derekjohn.clark@gmail.com>
In-Reply-To: <20240922181543.22988-1-derekjohn.clark@gmail.com>
From: Antheas Kapenekakis <lkml@antheas.dev>
Date: Sun, 22 Sep 2024 21:40:10 +0200
X-Gmail-Original-Message-ID: 
 <CAGwozwHqHbHNi53T87m36-OZ8suCEo1wgJ9fPPgPdcLnt_+S4g@mail.gmail.com>
Message-ID: 
 <CAGwozwHqHbHNi53T87m36-OZ8suCEo1wgJ9fPPgPdcLnt_+S4g@mail.gmail.com>
Subject: Re: [PATCH v2 0/5] acpi/x86: s2idle: move Display off/on calls
 outside suspend (fixes ROG Ally suspend)
To: "Derek J. Clark" <derekjohn.clark@gmail.com>
Cc: Mario Limonciello <mario.limonciello@amd.com>,
 Luke Jones <luke@ljones.dev>, me@kylegospodneti.ch,
	Denis Benato <benato.denis96@gmail.com>, linux-pm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-PPP-Message-ID: 
 <172703402301.14272.3674647076699053959@linux1587.grserver.gr>
X-PPP-Vhost: antheas.dev
X-Virus-Scanned: clamav-milter 0.103.11 at linux1587.grserver.gr
X-Virus-Status: Clean

Hi Derek,
It is ok you have upgraded both of your units. We have plenty of
contributors and users that are not on the experimental firmware you
are on and will provide ample testing for probably the next half year.
As the update will need 1-2 months of validation and it is very
difficult and painful to update firmware from linux.

As I am tired, allow me to quickly jot down some thoughts so I can
enjoy my evening.

I only got my Ally X unit 5 days ago, so I cannot say I spent
thousands of hours collectively but right now, I am pretty certain of
the issue that was happening in the Ally units.

It is the combination of three cascading issues:

1) Display On/Off calls are not part of the suspend sequence in
neither WIndows or Linux currently. In Windows, they are called before
suspend, and in Linux after. This is a large deviation that completely
breaks the controller of the Ally. The previous solution was to insert
a second call to those functions in the middle of the Linux suspend
sequence, and then collectively spend months fighting with random
racing conditions. Patches 1, 2, 4 refactor s2idle to make sure that
never happens again, for any device, including the Ally.

2) The Ally Controller has a choreographed sequence with which it
fades its RGB during suspend. This happens during the Display Off
transition of Screen Off in Windows. In all of my testing in windows,
Screen Off lasts AT LEAST 10 seconds, if not more. I had to stand
around looking at that power light to turn off more than once. If
Linux cuts off its power supply before that, it gets confused and
restarts after suspend. If that restart happens during the resume
sequence, see (1,3). Patch 3 fixes this. This flourish is an important
part of user experience, so adding a delay here is required, even if
firmware updates.

3) Finally, the Ally Controller, when it boots up, is sensitive to
commands for 1-2 seconds, which will cause it to restart. Even with
this patch series, this remains an issue on my device with powersave
on, while the device initializes. asus_hid (or hhd) will instantly
send a command to the device on connection, which causes this issue
and then combines with 1 + 2. My patch series does not fix this.

1 and 2 will always be issues for the Ally, regardless of firmware
updates and probably for other devices too. N3 I will solve through
userspace + with distribution help, and it is not something that will
take that much time. Patch N5 adds too much delay unfortunately,
especially after resume. I would like to see it go, at least for my
users.

Your solution of making kernel changes for newer firmware + custom
firmware + kernel changes for newer firmware with quirks somehow seems
more convoluted to me than just cleaning up a bit of the s2idle
subsystem to benefit all devices, with a little, firmware agnostic
delay, for some flourish.

Antheas

