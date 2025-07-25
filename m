Return-Path: <linux-pm+bounces-31423-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F1E3B11F14
	for <lists+linux-pm@lfdr.de>; Fri, 25 Jul 2025 14:58:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C9225565801
	for <lists+linux-pm@lfdr.de>; Fri, 25 Jul 2025 12:58:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66FE32ED152;
	Fri, 25 Jul 2025 12:58:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.co.uk header.i=alex.dewar@gmx.co.uk header.b="Mw16jiEV"
X-Original-To: linux-pm@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD5C92ECEA0;
	Fri, 25 Jul 2025 12:58:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753448294; cv=none; b=LHW9MTGcxbJuJRraeetV2OHJNALr3f508jWdkR3C6mjO5jlo4yBa7kDGkkIMrdhggN7WfVPsPtKinLKC+RQWM/Ku2tX64rS4+5s4Jd4hlpxEXnayhlR4J01/6uYBUcFEjx9U9geDY8ONjk4Jx+yMQaE7uStptXrrxDdFLCMqtLA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753448294; c=relaxed/simple;
	bh=Ewbo8OyyELq9FpCF4mhFANUa5E4RG6vau0NG25J9gQI=;
	h=Message-ID:Subject:From:To:Cc:Date:Content-Type:MIME-Version; b=L1q7b4LSe0z3sZm5qkK9KxXjAUmtbsB0hEUOGxokTD1ybpJFKGDvR8HuwSqah7ZhfVY2H9uKHK47qQ1o7X0OoyZUC5K9zSXQ7nYSdFCjlBhl3LnibdqM0Xam1eRfqtikYmLkUI7cAz6+zYXTB82ZaP+J4ZBtqN3moff9fom35t8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.co.uk; spf=pass smtp.mailfrom=gmx.co.uk; dkim=pass (2048-bit key) header.d=gmx.co.uk header.i=alex.dewar@gmx.co.uk header.b=Mw16jiEV; arc=none smtp.client-ip=212.227.15.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.co.uk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.co.uk
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.co.uk;
	s=s31663417; t=1753448289; x=1754053089; i=alex.dewar@gmx.co.uk;
	bh=Ewbo8OyyELq9FpCF4mhFANUa5E4RG6vau0NG25J9gQI=;
	h=X-UI-Sender-Class:Message-ID:Subject:From:To:Cc:Date:
	 Content-Type:Content-Transfer-Encoding:MIME-Version:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=Mw16jiEVhgDV94sGN+5zbjezYrPs6tp/IzLey0LJOy3k3KRGHScMszmEX2ZH/ayI
	 4pJBVNmCZCShL3Gl6kWhuFsC7mKYduDDb7ySopB5D244vXAVzkVNMbOhNPwv8Ly48
	 v81vkRr+XggZI6BOtFsNP1x9gIH4eNeVlEPZAhcKI7qrxm8LkfNgfIAPiH60g7yf+
	 omV4cnbJiHX/IsBEwPXmRP0yTcNl0X0reyHwd8h+nun66v87GkDUc79vazSFcDwV7
	 SPTFeN1BO24LMbcg/sHa+857yR3oQz7YVyoiS/Y64z/cCRpMuvldpkMFoO7UcRkz5
	 chlGDoY7jAvmII1lpA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.1.123] ([51.9.245.27]) by mail.gmx.net (mrgmx004
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1MPokD-1v0NE2209r-00QbwQ; Fri, 25
 Jul 2025 14:58:09 +0200
Message-ID: <28505baeb52acbb6befc3091d198a8bd8a270493.camel@gmx.co.uk>
Subject: Failing to resume from suspend on AMD Zen 2 machine
From: Alex Dewar <alex.dewar@gmx.co.uk>
To: linux-pm@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Date: Fri, 25 Jul 2025 13:58:09 +0100
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Provags-ID: V03:K1:BF8mbN8S2qM1zFgflkQ0YoNB1lkkjnK1CI3wfzNDay7Mgm9ciim
 1q6NyrG9JL9+g8AuUWyPenPXpmmplxaRJ+aMnxwvYMxaf7gN3JEVfsPYDcHR6zPbSVy35ye
 frOAdinCFaMumWyJJ7POfSAyfrRjKzK3y8r5AhRJeW/CGIZocXKiDP9m1LRxmPG3HBhIFf3
 zZNdWhHO25hz9wBml0Efg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:qOZhrevXZzE=;5WRy6Rfc09RQYx4gPC5lwzTr+QH
 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
 qOZnpNqaXJddTrgtSEbkf+kvWAhCcnRo=

Hi,

I'm running an AMD desktop machine (Zen 2). At some point suspend and
resume worked fine, but a few releases ago, something broke and now it
fails to resume. I should probably have sent a message as soon as I
noticed, but I've been getting by without it and figured it might
resolve itself anyway.

What happens is that the system appears to suspend fine, but when I
press the power button it *seems* to briefly wake (the LED stops
flashing and the fans start) but then it goes back into a suspended
state (fans stop, LED starts blinking). If I then press the power
button again, it powers up and I can see my lockscreen, but the system
is not responsive to user input.

This problem happens *almost* every time I suspend, however, if I've
only recently booted the system and just have a few processes running
(i.e. my window manager and normal system services) then it suspends
and resumes fine. If I then open a browser etc. then it stops working.

What extra info can I provide you with to make this a useful bug
report? (I also have an AMD GPU -- maybe that's the culprit?)

I'm running the stock Arch Linux kernel (v6.15.7). I also tried the
latest commit on mainline (2942242dde89) but had the same result.

Best,
Alex

