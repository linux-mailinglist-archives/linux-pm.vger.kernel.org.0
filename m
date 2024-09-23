Return-Path: <linux-pm+bounces-14592-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F88997EFF2
	for <lists+linux-pm@lfdr.de>; Mon, 23 Sep 2024 19:49:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 52FB41C212C1
	for <lists+linux-pm@lfdr.de>; Mon, 23 Sep 2024 17:49:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 738E419E990;
	Mon, 23 Sep 2024 17:49:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=antheas.dev header.i=@antheas.dev header.b="VEiXiiV2"
X-Original-To: linux-pm@vger.kernel.org
Received: from linux1587.grserver.gr (linux1587.grserver.gr [185.138.42.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08966101DE
	for <linux-pm@vger.kernel.org>; Mon, 23 Sep 2024 17:49:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.138.42.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727113754; cv=none; b=ILzp75hYBhyRwzXNp7XhpVFFwB+kCbfTiORH4WK7jhG5KnTzIHGG7pTNXP9q9xhq9M5bwYD1+ikqrbW3Q7cxL9WCyrC70+k2OomAoiMOkg3ti09+MUjt5hj7MvUNpVT3CZ7YSpqRx1XV1IgCkp5AdLvX/z13sO7szwirrCl/6j0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727113754; c=relaxed/simple;
	bh=mgVo3Ao6QAQukPpFI4gkBwKqQYbb5Wb+aTsANNGo2DM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UNKobGCKUXNeI0maXrlWNyC0vJdHw6FbkhCmIzPyJpDkGqpD7pvLsIaY9C5Vvx/+cpslFChqLhPk9/CuFDDjpnUsiD2xpCo7h7roEBnGgE+KRxUEK1ewWBOggRd3gsuNuUax6XkgbutoANFIgNzx40UWM9bbBq+bRyGf48WHLO0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=antheas.dev; spf=pass smtp.mailfrom=antheas.dev; dkim=pass (1024-bit key) header.d=antheas.dev header.i=@antheas.dev header.b=VEiXiiV2; arc=none smtp.client-ip=185.138.42.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=antheas.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=antheas.dev
Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com [209.85.208.170])
	by linux1587.grserver.gr (Postfix) with ESMTPSA id 50AE32E03761
	for <linux-pm@vger.kernel.org>; Mon, 23 Sep 2024 20:49:07 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=antheas.dev;
	s=default; t=1727113747;
	bh=int5kvgORBBWIo01uZK+ECy/IcTdMAr4gK/x5zB/C+E=;
	h=Received:From:Subject:To;
	b=VEiXiiV2/l90Cib16KXw7oE6l9DxeFPON9P++XHRJCrqPThrjjCoXiZvjAqoQJtpv
	 7jBOlFY3+rW+g++Rb5tH04EKOx/3n4rOE+nkgou+HFzV4jAZn/+zFo3dgQ5XGPHMMm
	 s3g6PncvYFuV1kob2LsrDLKlrE6+64rswCHgqS6U=
Authentication-Results: linux1587.grserver.gr;
        spf=pass (sender IP is 209.85.208.170) smtp.mailfrom=lkml@antheas.dev smtp.helo=mail-lj1-f170.google.com
Received-SPF: pass (linux1587.grserver.gr: connection is authenticated)
Received: by mail-lj1-f170.google.com with SMTP id
 38308e7fff4ca-2f7657f9f62so51523691fa.3
        for <linux-pm@vger.kernel.org>; Mon, 23 Sep 2024 10:49:07 -0700 (PDT)
X-Forwarded-Encrypted: i=1;
 AJvYcCUd3KePWzygXA+ohr+anvIYdM/W0GW6pzjLQRlFPIMvardMAXpeb44FsQL4dFVDmW6lzBII20t6XA==@vger.kernel.org
X-Gm-Message-State: AOJu0YyFmHBADeVS+uPODoLgWoFpWECrgIPfb9JkJ/9Hh9ZLVp3Xvpr9
	YwJ5R1K6skYFCmXP1B/Pt+om5NXvmbMWMZuLb48/MgslmWPWKr0rMHR53IZknIw09Spdc3i+X9E
	kUjAPZW4jVqCRX+7cRjiH4eYZ9gE=
X-Google-Smtp-Source: 
 AGHT+IHA19n6XyxnfzeIzBStuaOkGgtDV4ro+UqmMG9ZWzZYxGjbq1/ylKX0EqBp1ikWVf0EcU6JMWcNiZRqNZHSpY4=
X-Received: by 2002:a2e:b8cc:0:b0:2f4:50c:ab55 with SMTP id
 38308e7fff4ca-2f7cc371150mr53707561fa.16.1727113746699; Mon, 23 Sep 2024
 10:49:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: 
 <CAGwozwHqHbHNi53T87m36-OZ8suCEo1wgJ9fPPgPdcLnt_+S4g@mail.gmail.com>
 <20240923013657.7464-1-derekjohn.clark@gmail.com>
 <CAGwozwHmS-XjhzYayNvT07vesw4eOBh+ZjWi_NDa4xsOangYDQ@mail.gmail.com>
 <b43f9654-4dd7-4f3c-95b5-575473c3bcc1@app.fastmail.com>
 <CAGwozwE_MXuqreQvDFyVyodrzH5HFB=Nab9LfxD9DMB+HGkt3Q@mail.gmail.com>
 <fa1cb9c1-8b56-4fbf-89aa-86ffc6dc837b@amd.com>
 <CAGwozwHvXkG824xHcfnr6E+B6iLr6KJiLEjJhx4hEhieHYob8g@mail.gmail.com>
 <358ca905-ae53-4d2d-b09a-8e708d6fadd8@amd.com>
 <CAGwozwGsyebGE78SKMckkm2=8uqDTX+S-Jnxrn61X_UHVEDcDA@mail.gmail.com>
 <ea2232b7-fb29-429b-af9d-af43a2c0cacb@amd.com>
In-Reply-To: <ea2232b7-fb29-429b-af9d-af43a2c0cacb@amd.com>
From: Antheas Kapenekakis <lkml@antheas.dev>
Date: Mon, 23 Sep 2024 19:48:55 +0200
X-Gmail-Original-Message-ID: 
 <CAGwozwF13C6oq1zY9sYx4i-FB_FiWienXGdMzKZ4+mu-g3O6_w@mail.gmail.com>
Message-ID: 
 <CAGwozwF13C6oq1zY9sYx4i-FB_FiWienXGdMzKZ4+mu-g3O6_w@mail.gmail.com>
Subject: Re: [PATCH v2 0/5] acpi/x86: s2idle: move Display off/on calls
 outside suspend (fixes ROG Ally suspend)
To: Mario Limonciello <mario.limonciello@amd.com>
Cc: Luke Jones <luke@ljones.dev>,
 "Derek J. Clark" <derekjohn.clark@gmail.com>, me@kylegospodneti.ch,
	Denis Benato <benato.denis96@gmail.com>, linux-pm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-PPP-Message-ID: 
 <172711374763.16513.3432105973774603347@linux1587.grserver.gr>
X-PPP-Vhost: antheas.dev
X-Virus-Scanned: clamav-milter 0.103.11 at linux1587.grserver.gr
X-Virus-Status: Clean

> Considering the previous experience, maybe you can help to document
> their update protocol?  I'm happy to collaborate on the fwupd side if
> you can help push it along.

If I get the time I might try to, but if this patch works on the
original Ally, this fire is handled as far as I am concerned. Even if
it does not merge and even with the little reboot quirk.

So it moves back in the stack of priorities. I still think fw and bios
updates are important and I have been thinking about it too. More on
the GUI side though.

At least BIOS updates are kind of solved for both the Ally and the Go.
However, the Go half bricks itself in almost all updates from WIndows.
I had to power it off during a bios update twice and that's from
Windows. I am not going near it any time soon.

> AFAICT any need for this series goes away when you have an easy way to
> update a handheld that is running Linux already.  I would take a pile of
> userspace code over kernel quirks any day.

I cannot agree with you more on skipping the kernel when possible. It
is why most of my work is in userspace.

"Oh custom TDP/Fan on the legion go? Custom TDP is mode 4 that does
not map cleanly to a platform_profile, half of the BIOSes of the
legion go forget the custom TDP when changing TDP profile, and there
is a hw combo to change the TDP. Sniff the kernel net socket for ACPI
events to capture TDP mode changes, then if in Custom mode, wait 2
seconds, set the custom TDP the user saved previously, and then the
fan curve. Want to disable the custom fan curve? Pick a random TDP
profile, switch to it, and repeat."

However, with the kernel firing the _DSMs Display Off and Screen Entry
calls after the suspend sequence back to back with no delay when
WIndows calls them seconds apart before the suspend sequence, I can
personally see the eventuality.

Three talented OSS devs + the Asus engineering team had to work for 1
month on avoiding this table and now they have to move on to
validating the firmware, shipping it, etc. I also spent too much work
on making this upstreamable, but I plan to use this patch so it is
kind of OK, unless the Sleep _DSM does not do much.

Also, did I mention that the Ally gets stuck on 5W TDP semi randomly
after suspend and has a really nice and complex _DSM sleep entry? And
I am the only one that knows it because Handheld Daemon is the only
TDP solution that does not use ryzenadj to set TDP on the Ally. So
next step for me is doing the same series for the Sleep Entry/Exit and
expanding the quirk table. I am not waiting for a BIOS update.

Antheas

