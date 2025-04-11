Return-Path: <linux-pm+bounces-25191-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A277A85083
	for <lists+linux-pm@lfdr.de>; Fri, 11 Apr 2025 02:30:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6BD301BA303B
	for <lists+linux-pm@lfdr.de>; Fri, 11 Apr 2025 00:30:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 055175223;
	Fri, 11 Apr 2025 00:30:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="Vz0rCi3K"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 454F49476
	for <linux-pm@vger.kernel.org>; Fri, 11 Apr 2025 00:30:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744331423; cv=none; b=nO4HakOZuc17iicgawhyIvPohJuRWOkuVp8fMBHRbBObqfbb4N1eGReUibe/DoZourk2cFjFBViEQTLPrcjw1+DHoU31LE/3H0bpeP6bU8lBoMELuZit0Qym+8MHfdDk8aXAsTIAVQLrtTKIAuUC3hMfPxXU00sIvvUcrmhGNXM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744331423; c=relaxed/simple;
	bh=iCBIHlgYqBmRae+sv1JEgK6hpnqzk+F+c41u/4PRRSk=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=RuIqKzLiEu0RZA3qwdeWEJx5khoKG6nwJ845zKe8eJV3+bIxuXM3O7gUpukOOSUxxKaDDuO0AcFoFauWFvIcH9ZgxMM3mzLXnQcjF41bOjj0R4697SlQPfgvvD7pzOxSKh14p2MGj3JnwtlIQuKok1TOKWrrBjWroGQkVveV/cw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=Vz0rCi3K; arc=none smtp.client-ip=209.85.216.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-3015001f862so993285a91.3
        for <linux-pm@vger.kernel.org>; Thu, 10 Apr 2025 17:30:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1744331421; x=1744936221; darn=vger.kernel.org;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=LEj/TlILN37TPKrS4vVDvJow8Rh350Q5eqqNTt+HqJQ=;
        b=Vz0rCi3KjFp/uGhfKUxc3lTYusrqq9XTdoQLvG9waZT1/aiqpct5HdhhY+llKZLynx
         bTKPC6+l4u71ZNTO2Vn9dZsvXaBQt4kBKlcCY4L4DcoVUwLVw8R9tawuDSxzzWIjmKeK
         /+rRPJZs/P+LasovyIU+TXIYxJvWVBGO546hkDWf27CFYpfczqxPLmTrDTNjwX62nSDB
         UxaydnJULZQ8N4XJ8JOHzC6otQftEMjQ5NL8oTMLDWGBD9sMR7/5/Eeor96xrcd13jg5
         zQjbCqpWUKU5lTyHUJZvf3J5/n1FVr4/lXcPdAG5/ykzKC0vUIyQ9priBo3yhgh5I1AC
         289g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744331421; x=1744936221;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=LEj/TlILN37TPKrS4vVDvJow8Rh350Q5eqqNTt+HqJQ=;
        b=aYUmuIC5ON6OlLuzKw17jYCQzFqNv6RKQ4+qBd6Qz9vbj1loetyNXVaHP+p1C9NSkZ
         HeP9Ox3b29Vx4y2GrTOSgGS5NjuaSe7tQhBuKygzJxC5DkG8t7+cN5S7Pn4i3wKXc2kp
         N4Q3DD39oX6Pylel6rhM8tGkRAPkmMQy93BsoLjS0aTYKE4h1PfzbHdC60Rbewfm7G8t
         KO01ZYncpMekayOae5ib4l/MBCQDxKnSxXnUEj7a3I1UUdTDaT7ddR1HsW3r0Hxeh3w+
         0xGzjYd5ju1V2sztPu5aZ/+Ty0FlcIxpU/GbMj+mPItStYwfZKWhiHDX9nmCfYIiCsvF
         N8kg==
X-Forwarded-Encrypted: i=1; AJvYcCX1wqyyH+HK5UMFWKsi2bYAViGBlPERwqjkW0JOwo64n5Y2f6ZgzeIcHPy6W2nahWUdxjuhkk0pcQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Ywk16Hm6DDdFDzGG7sl3yCpNORCO+kpayWBPC39pn3QomnQV8A/
	DSUf/+Wmsn71vmWKhSz8okA5zgJ/qPY7+r7EUIhwvWfMO07AMmQDUUlwwldYwMQ=
X-Gm-Gg: ASbGnct1fFOJRvPySJU1djIKQAZtorYjt6fwvxc3C+qLuO84hEMYxmHd8DgVKAFTWiL
	KZqcQvw8vB+rxFNu4IC9C40Bg47XJ38rsesSPJ5clwAXHdWwYU8WwVQEHxDUQOzm9QXY24FTl0J
	TXzATd4OfKht/TFwYzjkgORj+Fhy3TTFt+dup9HoOPd139do/O6gGUihtWupUGBq9TBNmuJZXs6
	fDfymbJuftfx05C8qq8k/MpsNLRQ7EAJkcNDnof6gE6VfX5psEcIh/6za9+x0acV/z7Rxfwbfa6
	nssBH2T+XRPpuQed34O0J3cIO+0hPlXhMuzAJK8=
X-Google-Smtp-Source: AGHT+IHK+hZPSxDXu+yULAA+P8ggs/de/t3JfqukjQr3W1pHmgkXMe4iexgqgEe5uUDhbixl0eakvA==
X-Received: by 2002:a17:90b:388c:b0:2ff:5a9d:937f with SMTP id 98e67ed59e1d1-308237e1b7emr1466823a91.24.1744331421495;
        Thu, 10 Apr 2025 17:30:21 -0700 (PDT)
Received: from localhost ([97.126.182.119])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-306dd11e666sm4395562a91.15.2025.04.10.17.30.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Apr 2025 17:30:20 -0700 (PDT)
From: Kevin Hilman <khilman@baylibre.com>
To: Sukrut Bellary <sbellary@baylibre.com>, Russell King
 <linux@armlinux.org.uk>, Rob Herring <robh@kernel.org>, Tony Lindgren
 <tony@atomide.com>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Nishanth
 Menon <nm@ti.com>, Ulf Hansson <ulf.hansson@linaro.org>
Cc: Sukrut Bellary <sbellary@baylibre.com>, Aaro Koskinen
 <aaro.koskinen@iki.fi>, Andreas Kemnade <andreas@kemnade.info>, Roger
 Quadros <rogerq@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Santosh
 Shilimkar <ssantosh@kernel.org>, Bajjuri Praneeth <praneeth@ti.com>,
 Raghavendra Vignesh <vigneshr@ti.com>, Bin Liu <b-liu@ti.com>,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-omap@vger.kernel.org, devicetree@vger.kernel.org,
 linux-pm@vger.kernel.org
Subject: Re: [PATCH 0/4] PM: TI: AM335x: PM STANDBY fixes
In-Reply-To: <20250318230042.3138542-1-sbellary@baylibre.com>
References: <20250318230042.3138542-1-sbellary@baylibre.com>
Date: Thu, 10 Apr 2025 17:30:20 -0700
Message-ID: <7h34efy1yb.fsf@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Sukrut Bellary <sbellary@baylibre.com> writes:

> This patch series fixes the Power management issues on TI's am335x soc.
>
> on AM335x, the wakeup doesn't work in the case of STANDBY.

This series is specifically targetted at the AM335x EVM (which I don't
have to test), so I'd appreciate getting any test reports for this
before I queue it up.

For AM335x, I currently only have the ICEv2 and Beaglebone Black,
neithor of which support suspend resume with RTC wake AFAICT.  If they
do, please enlighten me. :)

I was able to do a basic boot test on the 2 boards I have with this
series applied on top of v6.15-rc1 and basic boot still works, but I was
not able to test the PM path that's being changed here, so any tests on
AM3 platforms that actually use this path are appreciated.

Kevin

