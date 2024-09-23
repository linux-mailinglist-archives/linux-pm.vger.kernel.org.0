Return-Path: <linux-pm+bounces-14581-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 03E8497EEF2
	for <lists+linux-pm@lfdr.de>; Mon, 23 Sep 2024 18:12:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A281A1F2321B
	for <lists+linux-pm@lfdr.de>; Mon, 23 Sep 2024 16:12:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E654719993C;
	Mon, 23 Sep 2024 16:12:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=antheas.dev header.i=@antheas.dev header.b="BFuRfF7C"
X-Original-To: linux-pm@vger.kernel.org
Received: from linux1587.grserver.gr (linux1587.grserver.gr [185.138.42.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AED6197A8A
	for <linux-pm@vger.kernel.org>; Mon, 23 Sep 2024 16:11:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.138.42.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727107920; cv=none; b=eZrmRx1IGYGjB4FNTlgObke5fnrx1XoUEa0TaQphAz83sozmtK6CzMmiTOLKlCS9czk0/dmAgYmiiyQuJYZlYpltJUs32LoJebMRdsX6B6RKWzXXQv6Y5LTpYfe20svJMjQDw+EvzPWKVwF5fUus8XT3EU5mosI9eBgYh4XSsXc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727107920; c=relaxed/simple;
	bh=/6o1pOmJfhZg8dV2ReKL++v56vOJZjHfOtUORNnncyA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OGMLcDP0Mv0Lj83qasPgjNYPdQJTYgJDTS53mPaZqevqrEVN5ZzoJq4jPJVQwXXbBNteuBNugj160iedADXqCUi87v03fLko7aEF1QCsLzqdWPhittKWhZJDEIumC9+pRCiGYaSiCjQIkvP+0X3mjVP2NekOuw5txJnBqKia4ps=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=antheas.dev; spf=pass smtp.mailfrom=antheas.dev; dkim=pass (1024-bit key) header.d=antheas.dev header.i=@antheas.dev header.b=BFuRfF7C; arc=none smtp.client-ip=185.138.42.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=antheas.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=antheas.dev
Received: from mail-lj1-f175.google.com (mail-lj1-f175.google.com [209.85.208.175])
	by linux1587.grserver.gr (Postfix) with ESMTPSA id 5B5792E09622
	for <linux-pm@vger.kernel.org>; Mon, 23 Sep 2024 19:11:54 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=antheas.dev;
	s=default; t=1727107914;
	bh=/6o1pOmJfhZg8dV2ReKL++v56vOJZjHfOtUORNnncyA=;
	h=Received:From:Subject:To;
	b=BFuRfF7CZWvniLDF8lSEeV8ZJYMZyPpzjs6SWoRd7zRQVKZTRklw8ywCG30rIIG2K
	 E1R0u20SqHzKgO7UqV5/cr0/w440DSkBpNS6/lB++5AHovMbTemd8LFNqd++AL7uLD
	 cN3zquMMnHKkO17x0Ki0VsnArY+o43eEI63oyFWY=
Authentication-Results: linux1587.grserver.gr;
        spf=pass (sender IP is 209.85.208.175) smtp.mailfrom=lkml@antheas.dev smtp.helo=mail-lj1-f175.google.com
Received-SPF: pass (linux1587.grserver.gr: connection is authenticated)
Received: by mail-lj1-f175.google.com with SMTP id
 38308e7fff4ca-2f75b13c2a8so48673201fa.3
        for <linux-pm@vger.kernel.org>; Mon, 23 Sep 2024 09:11:54 -0700 (PDT)
X-Forwarded-Encrypted: i=1;
 AJvYcCVvZCs8FGSLqAJnNWlJLGvlSf+WcG05KMCmLPdHhJoQpjApi/hnXZH8DgCTh1+cPVIJ7ueKa4beHw==@vger.kernel.org
X-Gm-Message-State: AOJu0YwgmjiF02t4ssMLpdAaP7df1i2MxKKK4/IbbFT6I/u/ihPr+WiI
	cphmZ7yq+pSeg1XrBbknUyh6t93JOCJW1ozWfnQEn+6qXrAPDUWdcvIaW5ICgff8IZfb5A4eJC0
	aJSaK3YhMxOP4Tl5XkEHmj6GyFvg=
X-Google-Smtp-Source: 
 AGHT+IHxhDtHBcWaPItsNShNwqAM9pqoNGMpLM/XDgKv5WFNyrsZVc6dddVOXhsz9TL7feyAEVsQ3BNttKFSrBev9lc=
X-Received: by 2002:a2e:934a:0:b0:2f6:5fa7:2626 with SMTP id
 38308e7fff4ca-2f7cb375d32mr45119131fa.39.1727107913719; Mon, 23 Sep 2024
 09:11:53 -0700 (PDT)
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
In-Reply-To: <fa1cb9c1-8b56-4fbf-89aa-86ffc6dc837b@amd.com>
From: Antheas Kapenekakis <lkml@antheas.dev>
Date: Mon, 23 Sep 2024 18:11:42 +0200
X-Gmail-Original-Message-ID: 
 <CAGwozwHvXkG824xHcfnr6E+B6iLr6KJiLEjJhx4hEhieHYob8g@mail.gmail.com>
Message-ID: 
 <CAGwozwHvXkG824xHcfnr6E+B6iLr6KJiLEjJhx4hEhieHYob8g@mail.gmail.com>
Subject: Re: [PATCH v2 0/5] acpi/x86: s2idle: move Display off/on calls
 outside suspend (fixes ROG Ally suspend)
To: Mario Limonciello <mario.limonciello@amd.com>
Cc: Luke Jones <luke@ljones.dev>,
 "Derek J. Clark" <derekjohn.clark@gmail.com>, me@kylegospodneti.ch,
	Denis Benato <benato.denis96@gmail.com>, linux-pm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-PPP-Message-ID: 
 <172710791475.19412.17319532649004629488@linux1587.grserver.gr>
X-PPP-Vhost: antheas.dev
X-Virus-Scanned: clamav-milter 0.103.11 at linux1587.grserver.gr
X-Virus-Status: Clean

> I don't think it's possible to have it both ways that the ordering is
> wrong AND the timing is wrong.

I think the current firmware manifests 2 issues on the Ally X: Display
On needed to be called once the kernel is ready otherwise it NOOPed
and Display Off needed to be called 1 second before suspend. Then,
there is the issue in my previous email that also exists in Windows.

I tried from 0 - 4000ms for Display off and 0 - 1500ms for Display on.
Display Off, as long as the RGB fades 100-200ms before, made no
difference. Display On likewise made no difference.

I am currently playing a bit with the calls in the Legion Go. Seems
like one of them turns off its controller as well.

I did not know fwupd could do microprocessors, if it is simple that
would be great.

Antheas

