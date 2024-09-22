Return-Path: <linux-pm+bounces-14533-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 050B597E077
	for <lists+linux-pm@lfdr.de>; Sun, 22 Sep 2024 09:49:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AFE7A1F21452
	for <lists+linux-pm@lfdr.de>; Sun, 22 Sep 2024 07:49:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 946F7192D9B;
	Sun, 22 Sep 2024 07:49:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=antheas.dev header.i=@antheas.dev header.b="mtiahVSf"
X-Original-To: linux-pm@vger.kernel.org
Received: from linux1587.grserver.gr (linux1587.grserver.gr [185.138.42.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59BF7193084;
	Sun, 22 Sep 2024 07:49:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.138.42.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726991349; cv=none; b=mPSBi5ugVGgtwYO5ettsxma3fSot7vU9Vj53GAMqj+Yiu7o1iMjjLNNEf6kRdfotv2e47oVY4dO5xv5HqZZtq47iUS2pHxDFK9FGACKGZkRUagb7kAZsHi+vbX/IEPM0ni6tkFcbJ7Tka5jgBQcEndcGwM9XJPr+xZmDbknJAlk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726991349; c=relaxed/simple;
	bh=xBBySDdoBqDylGunOMGl9Mt5dJRybJpuw6yWhvqCwFc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=coDBxQuGlm/YlddiWZP6d3giH3XRl+5pCpnf+wiSHW4ydrTnuhkKWHWeJMN4lbhlLMVOYdQOiYI8wv2LdLAF1FfcJUViM7bIzBqumDJaFGmBrB2io51KCHytwJRGSdhbo/k87DrNUoZ8kj/3DGVa7FyHisGv9/DyYMlFS5VDlNg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=antheas.dev; spf=pass smtp.mailfrom=antheas.dev; dkim=pass (1024-bit key) header.d=antheas.dev header.i=@antheas.dev header.b=mtiahVSf; arc=none smtp.client-ip=185.138.42.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=antheas.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=antheas.dev
Received: from mail-lj1-f182.google.com (mail-lj1-f182.google.com [209.85.208.182])
	by linux1587.grserver.gr (Postfix) with ESMTPSA id CF1742E03666;
	Sun, 22 Sep 2024 10:48:54 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=antheas.dev;
	s=default; t=1726991335;
	bh=xBBySDdoBqDylGunOMGl9Mt5dJRybJpuw6yWhvqCwFc=;
	h=Received:From:Subject:To;
	b=mtiahVSf7BgFI39v/UhqPGprdfvtYQBAKqgv6LyKV3UHVGcgd69wvyDsdT41aWs32
	 2ewM+Wl/5SAN0BpaWfHffS5H1HNpitq2klDjLeXGSp763DetNIaaswMm2wceWZVDEm
	 WYb0BTfOQZmyDSTzfpK6HdibT9EwLkl+iHie6Qm0=
Authentication-Results: linux1587.grserver.gr;
        spf=pass (sender IP is 209.85.208.182) smtp.mailfrom=lkml@antheas.dev smtp.helo=mail-lj1-f182.google.com
Received-SPF: pass (linux1587.grserver.gr: connection is authenticated)
Received: by mail-lj1-f182.google.com with SMTP id
 38308e7fff4ca-2f75428b9f8so44527991fa.3;
        Sun, 22 Sep 2024 00:48:54 -0700 (PDT)
X-Forwarded-Encrypted: i=1;
 AJvYcCU9az0KVrxBQ5ZOY2TuhFb0u7PE71EI0/3W0Fa5vbdQ9Ni+t7Y8GS99ZqydrSg4x6obzSJ4IdWQBBMEjCJqt8W2T/usNg==@vger.kernel.org,
 AJvYcCUr+isrQq5nk6FBHqup4nNMCyEJUdSb/2934Tcmsx5NuCSxle5jdHmA3G6GqEVTXM/9e9QU/WHTpQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Yych+1/N0JWbW8CVMOYi3rco3gCUpnB7xS0U9A8sw8ryCm5CkFF
	BK2FdNlhorAGloJ3BtQqfUtkUfkXE35+aCm4WqaEo2nFUgPZbGHy/0tQCH8aCuC51/il9R5xh21
	y9fwt9XSoXRdq7m84+Ns+yjROugU=
X-Google-Smtp-Source: 
 AGHT+IGKXLHpVXrNaP96vbaRAqtS74DggLHB/xpIQY7ojzhm6BxV8K72Y1waHhNetqZ+fiPEtLDItl/ZXTp+fDUBt+g=
X-Received: by 2002:a05:651c:1504:b0:2f6:6198:1cfa with SMTP id
 38308e7fff4ca-2f7cb371b63mr54965771fa.41.1726991334080; Sun, 22 Sep 2024
 00:48:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240919171952.403745-1-lkml@antheas.dev>
 <20240919171952.403745-4-lkml@antheas.dev>
 <7c604018-59a3-4b70-83d1-06f0ed858b73@amd.com>
 <CAGwozwGSVAExH_9zCCKreC88J0FRU4ZM3RkBk==HvRwCUuuqLw@mail.gmail.com>
 <25b14b4f-96b7-453c-b876-6a46c4f3789c@amd.com>
 <CAGwozwHmd8yHzjbutOd4T39h5CZRh2rOWYH4V4AnLN+RXrRRnQ@mail.gmail.com>
 <f164e172-0030-48d0-9c33-aaaa6d0cc6ff@gmail.com>
 <CAGwozwGNg8XZcY0AhfMfKXJo4P4Xmvn7e2Bt2gZ-emSAsn24qA@mail.gmail.com>
 <31eb2289-633d-47d8-8609-e9994d7f8353@gmail.com>
 <CAGwozwHDW_m7gx8Fb-CQUz_TtSA=G7hx37NCqntm-hYKhRf8WA@mail.gmail.com>
 <30b8c512-d76e-4acf-892e-fad7a6bb1127@gmail.com>
In-Reply-To: <30b8c512-d76e-4acf-892e-fad7a6bb1127@gmail.com>
From: Antheas Kapenekakis <lkml@antheas.dev>
Date: Sun, 22 Sep 2024 09:48:41 +0200
X-Gmail-Original-Message-ID: 
 <CAGwozwGPXJD1K321GW2Peqp3ukB4U2rbc8+TxnRFOFCe0rDMQQ@mail.gmail.com>
Message-ID: 
 <CAGwozwGPXJD1K321GW2Peqp3ukB4U2rbc8+TxnRFOFCe0rDMQQ@mail.gmail.com>
Subject: Re: [PATCH v1 3/4] acpi/x86: s2idle: call screen on and off as part
 of callbacks
To: Denis Benato <benato.denis96@gmail.com>
Cc: Mario Limonciello <mario.limonciello@amd.com>, linux-pm@vger.kernel.org,
	platform-driver-x86@vger.kernel.org, luke@ljones.dev, me@kylegospodneti.ch
Content-Type: text/plain; charset="UTF-8"
X-PPP-Message-ID: 
 <172699133516.31087.117513464842915206@linux1587.grserver.gr>
X-PPP-Vhost: antheas.dev
X-Virus-Scanned: clamav-milter 0.103.11 at linux1587.grserver.gr
X-Virus-Status: Clean

> I will be here waiting for the result, when you have identified the reason of regression I
documented, include me in CC or reach me out privately with the work
ready to test.

Hi Dennis, as I said yesterday I would continue testing and I did. You
were right, there are two pieces to this puzzle.

Let's make something clear. Asus is not the only one using _DSM 3,4
this way. Asus is just the case where the deviation in behavior is
more clear. I suspect OneXplayer is using it as well for the
controller (USBP variable). And Ayaneo is notorious for unreliable
S0ix to the point where people recommend bios mods to manually force
S3 through PBS.

First one is that calling Display Off/On while the kernel is partly
suspended prevents the controller from coming back online. My patch
fixes that, and I am sure you can attest.

Second one is that asus plays an RGB suspend animation before
suspending the controller, which lasts for over 1 second. If the
device suspends before that, when it wakes up, it keeps playing the
animation the disconnection happens then. Since XInput does not
support selective suspend, this might lead to higher battery draw and,
as you noticed, being able to wake up the device with the controller.
For the Ally X, it means the controller takes around 2s more to wake
up (in addition to the animation quirk).

Thank you for catching that. I will update the patch series to take
that into account. If you want I can add a Reported-by for you, and if
you test the next revision out-of-band, I can also add Tested-by. In
addition, if you give me some details about the next firmware asus is
preparing, I can make sure the (pre-suspend) delay only applies to the
older firmware. There is no need for a delay post-suspend. If Asus is
removing the CSEE call for backwards compatibility, this might also
work.

I still think there is value to this patch, as it tries to study
Modern Standby behavior further. And I would suspect Asus is not the
only manufacturer being creative.

> do a request for comment on a proposal,

Yes, that will come after some time as well, but it will build on this patch.

Antheas

