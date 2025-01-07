Return-Path: <linux-pm+bounces-20055-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A2E04A0480E
	for <lists+linux-pm@lfdr.de>; Tue,  7 Jan 2025 18:20:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3DCB518871C2
	for <lists+linux-pm@lfdr.de>; Tue,  7 Jan 2025 17:20:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 869DC1E0DB0;
	Tue,  7 Jan 2025 17:20:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=antheas.dev header.i=@antheas.dev header.b="opdV9Kkp"
X-Original-To: linux-pm@vger.kernel.org
Received: from linux1587.grserver.gr (linux1587.grserver.gr [185.138.42.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A96B11CAF;
	Tue,  7 Jan 2025 17:19:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.138.42.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736270400; cv=none; b=L/KehSdbL/K0cQIvaOAUVZ5TV5tYP2PVf+62s57zdnFakgCSKQQ088qoWSQf91Ca5425ekxyDlNqgrH1WUq8TskO6kuARA+GKPO4heIeX/GAjww+nMv0qVvf99qzGfggxQTMNLN1YzlAhj88Q3LykKHbKYmjWqMInDWpQB+KbxU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736270400; c=relaxed/simple;
	bh=qMOhm2GsHjLQ5x3BK15QTCHIyEKm7u0/94UcAHG0qAs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=R8aIj3e3l8wka5izutQRXi2HmgnereHE39/oFpm9sBn4NiUm+WIJ8cYE0qnALsPgGSmYHvotAnGAGQbfpgPGCfBBdmuLRLQU3i+nJlGvzAPRDicATEuchp/pHO2ckDH0nNscoQ9K5pLAerNTYaLA32+P7T3CIR7BDXpbLLsAxk4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=antheas.dev; spf=pass smtp.mailfrom=antheas.dev; dkim=pass (1024-bit key) header.d=antheas.dev header.i=@antheas.dev header.b=opdV9Kkp; arc=none smtp.client-ip=185.138.42.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=antheas.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=antheas.dev
Received: from mail-lj1-f175.google.com (mail-lj1-f175.google.com [209.85.208.175])
	by linux1587.grserver.gr (Postfix) with ESMTPSA id EC54E2E0874A;
	Tue,  7 Jan 2025 19:19:46 +0200 (EET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=antheas.dev;
	s=default; t=1736270387;
	bh=qMOhm2GsHjLQ5x3BK15QTCHIyEKm7u0/94UcAHG0qAs=;
	h=Received:From:Subject:To;
	b=opdV9KkpjdsaDJpJW94tqPC1zd0/u1P/86wohlIuN5o80OLfMdGXzlmEX1bGjUNn0
	 68pTtkmz/1c+dVr6x0rxS9Cu3NzA1crWjR2sChsZB97iU7sKTvoToe/Lr+wq/lVhSK
	 kyuZiGZlFPai3BKgwr02xEw98cBvEve8esfJVwP0=
Authentication-Results: linux1587.grserver.gr;
        spf=pass (sender IP is 209.85.208.175) smtp.mailfrom=lkml@antheas.dev smtp.helo=mail-lj1-f175.google.com
Received-SPF: pass (linux1587.grserver.gr: connection is authenticated)
Received: by mail-lj1-f175.google.com with SMTP id
 38308e7fff4ca-304d760f118so41743341fa.0;
        Tue, 07 Jan 2025 09:19:46 -0800 (PST)
X-Forwarded-Encrypted: i=1;
 AJvYcCWxlt+XRazZB3j8+otaioFEuthCaJKInED7P/WvNQPTo/x7cTX5lHH0qcZurEQd5pB1mm2XY/FooWg=@vger.kernel.org,
 AJvYcCXSkccs21/3RY5NFzwCDqkckHNSsy+2sPsp6/3SKFrqPYr/TY3tr8Qikk6ICuUgZwBmoRE+YfPMLmQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzyIHg9Ivu7aqhYCjJwKZgcPnYJ/Bg1m9ombGHP2YBlVDAU32xR
	9CaMR8S/yxNaA5X4L9Es+HZcDjVkSagJtiv48ME88jSauLdkHh+9hEpMGqLdfQe7fxKM9BZBJ8s
	z++cBEr90JQNi+W34JAtjHC//xYE=
X-Google-Smtp-Source: 
 AGHT+IEsjm2sDhfFsRR8cU0AbUGsJ3d//SWN1Gi6lbHalQrEgtf0kr1cYevv7En1Dk1V8qwsAXj4XIb9ibm4eSMzvB8=
X-Received: by 2002:a05:651c:4ca:b0:300:7f87:a6a with SMTP id
 38308e7fff4ca-3046850a91emr166454291fa.7.1736270386206; Tue, 07 Jan 2025
 09:19:46 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241226112740.340804-1-lkml@antheas.dev>
 <20241226112740.340804-5-lkml@antheas.dev>
 <05cdd309-ec15-4236-ad4a-0a821a8eed76@roeck-us.net>
In-Reply-To: <05cdd309-ec15-4236-ad4a-0a821a8eed76@roeck-us.net>
From: Antheas Kapenekakis <lkml@antheas.dev>
Date: Tue, 7 Jan 2025 18:19:35 +0100
X-Gmail-Original-Message-ID: 
 <CAGwozwGgToJK16QAa4vityaP8g4UAHDXMFgV3xiLBKXnZqsQSw@mail.gmail.com>
X-Gm-Features: AbW1kvbEzpirYmLSvvjuMoJ_MfXhUwNL-BS0Ax4cNAPqYMqmwyh74bgbFtIqpbw
Message-ID: 
 <CAGwozwGgToJK16QAa4vityaP8g4UAHDXMFgV3xiLBKXnZqsQSw@mail.gmail.com>
Subject: Re: [PATCH 04/10] hwmon: (oxp-sensors) Add charge threshold and
 bypass to OneXPlayer
To: Guenter Roeck <linux@roeck-us.net>
Cc: linux-hwmon@vger.kernel.org, linux-doc@vger.kernel.org,
	linux-pm@vger.kernel.org, Jean Delvare <jdelvare@suse.com>,
	Jonathan Corbet <corbet@lwn.net>,
 Joaquin Ignacio Aramendia <samsagax@gmail.com>,
	Derek J Clark <derekjohn.clark@gmail.com>,
 Kevin Greenberg <kdgreenberg234@protonmail.com>,
	Joshua Tam <csinaction@pm.me>, Parth Menon <parthasarathymenon@gmail.com>,
	Eileen <eileen@one-netbook.com>
Content-Type: text/plain; charset="UTF-8"
X-PPP-Message-ID: 
 <173627038745.3081.3688794338518097143@linux1587.grserver.gr>
X-PPP-Vhost: antheas.dev
X-Virus-Scanned: clamav-milter 0.103.11 at linux1587.grserver.gr
X-Virus-Status: Clean

Do you suggest I do that in patch 3 so that the first two can be
cherry picked by LTS kernels?

Also, for the latter part of the series concerning the ABI break, can
you comment on that?

Antheas

