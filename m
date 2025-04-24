Return-Path: <linux-pm+bounces-26105-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B4F7EA9A955
	for <lists+linux-pm@lfdr.de>; Thu, 24 Apr 2025 12:04:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 45A243AAD53
	for <lists+linux-pm@lfdr.de>; Thu, 24 Apr 2025 10:04:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0F2A21CA13;
	Thu, 24 Apr 2025 10:04:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="jyWjnrK8"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-yw1-f175.google.com (mail-yw1-f175.google.com [209.85.128.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D208383
	for <linux-pm@vger.kernel.org>; Thu, 24 Apr 2025 10:04:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745489087; cv=none; b=X2uYAoliZIBjPcLiqxl9/dxWufUNdU0wdN8d/wVPyx0uLkC5Y8+cehnD2wvNbEwIl1aUUIrq/MT6HaDddRNTg0uiU+bMt4R1QmxQzznQR82IBWE1D7D2xUNGqhQlIctBf4VJBeVWW/xdqs3G5lMU8QrPVvj6Zn84QBAIALX/EqE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745489087; c=relaxed/simple;
	bh=zRK3bbAG3gBasDkhsvYPox8gR9dNStS01VlvA2H/3aE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TiPLrsbXzOao5EAFcBYj0ACDGmJDM+Pz5cVLHw4OifJtrcf1MQr8eAnAgJw/tJUh5MFmWIeopUS7oLUZkTIjsKtvyXHKGzgmR5iozZ4Zg/7LbpjkHP5O6ZaOOs7mMsEuSUQLa5qsdgP8VGr8zd2iU1puwNQ9xC+I6FGuPo/S4nQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=jyWjnrK8; arc=none smtp.client-ip=209.85.128.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yw1-f175.google.com with SMTP id 00721157ae682-7080dd5fe92so7589857b3.3
        for <linux-pm@vger.kernel.org>; Thu, 24 Apr 2025 03:04:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1745489085; x=1746093885; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=gAhE2hvzxTYkRTXNnlbXymQxLrf75SVoPXCltrmDJvs=;
        b=jyWjnrK8S8PiyEAcESmahfm+w6OCZcpQdVgbpZ02IHoQOgrxPs5mgtYf1eblYueZyK
         b5xjCtnjwt/OXlHfWCuOoRpyGivSHscHfZLyMfWqBQGNjUnJbNDY9PFl1kRGU/40x90e
         ZGnH/uFx3mu6Stq4kO21OpRIsx37E+gwfWgYw0wBlFDtNG3TjWiEswpWJMzWAsSZqdwa
         E9L+P9Z7hMTyFOJzP9i9Q6W+C6sUJA6o6ORXsqeBV4l30TXVuTOGNGUFhNwFizGGKFxX
         iLtaGP55Bbr/LQplqZ7eVYePACRFpTmPSedoDrGUWuyy9i4CddavUyupnQkMK8fk0kPq
         k9Zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745489085; x=1746093885;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gAhE2hvzxTYkRTXNnlbXymQxLrf75SVoPXCltrmDJvs=;
        b=NyiWWlKaDV6kRdCklj7vn5AnnoGQGxWIKE1U+dj28sLIyQguf9r4MVM/HvWoJOtsxR
         ZrpE4Vr0BQdo/i52b8B305r0m3t6XoN67KCzwlZYUp4aZrAkpQ9oYhgFBnMpRPgaHY5h
         Pq320tQ6GB0PgupqFB7F92vJ+ME+4sqhX39xYTxUoA3jTSFyzZeqFHxNXVC6XJPKkonj
         4mMm+f1yMkc/HyRbQnGGEeAG+8llkF5ru7O8SfBc4Stu/Odwfaw8j+sAoHw9VJU3ffDX
         KOenksLQPifAr2pJDyW57Io1Q/THpYnc5R6N414+bmbhevfcVwgXo//SFZ5WURH+1fEK
         GAxg==
X-Forwarded-Encrypted: i=1; AJvYcCXJOGayxQMFM++5zOCB5Hs4u1dOk6kzpliHTBDDyOZe8SIT8mMdTq8R1PHjA6tjs6FHW4j2oaFimQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YzzeLsQ6w8cA2VWOd8oCc/Zem5dvnH1Kea1dEYZN9Z4DKi7nGgF
	+bbEfK+d/gw795pLJK86Pw4YH5zImzOpnwezk/1AjURGCIFU1HbeORGH0LhUmVR3MmpNqkgrGR+
	CwR9rcftXg2aQ5N0kAMwRsDSbhw3pu90Kr2Pukw==
X-Gm-Gg: ASbGncsGoPoUxHqsdmFDvqSrm704sgMOiwRSWxOOv/Ca3cKoQuOQNeqW7ZaXDUuZ4vg
	NlbKNIxBi/PIVYLNDHtbYnWjur5RKhAmOLC6y7NbpxGWJWgmijLcgPM0ms0hS7bsAfeCOta1naX
	kAkoX8ernHvMUFFUzKaKkV/tF1Ex2WYGuzUA==
X-Google-Smtp-Source: AGHT+IHRN80V1KALg8QZOLapRyt4m3FJEY1PBgmKaeRU8QtTlcQsNpNO06R02rhYUFQKcspficc8vQEmJKzZwiZz8/c=
X-Received: by 2002:a05:690c:ed6:b0:703:c3ed:1f61 with SMTP id
 00721157ae682-7083ec82f04mr27461187b3.20.1745489085089; Thu, 24 Apr 2025
 03:04:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250318230042.3138542-1-sbellary@baylibre.com> <7h34efy1yb.fsf@baylibre.com>
In-Reply-To: <7h34efy1yb.fsf@baylibre.com>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Thu, 24 Apr 2025 12:04:08 +0200
X-Gm-Features: ATxdqUENVboYpckvehllaXvPNTBLeweZdKshsm3F8BsEr2O9Rx9nnzm5gOhifiU
Message-ID: <CAPDyKFrM7Qn2YtQKY+vCHP32Z_Ly-ECt=SU9EGojFu1ShktUpQ@mail.gmail.com>
Subject: Re: [PATCH 0/4] PM: TI: AM335x: PM STANDBY fixes
To: Sukrut Bellary <sbellary@baylibre.com>, Kevin Hilman <khilman@baylibre.com>
Cc: Russell King <linux@armlinux.org.uk>, Rob Herring <robh@kernel.org>, 
	Tony Lindgren <tony@atomide.com>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Nishanth Menon <nm@ti.com>, 
	Aaro Koskinen <aaro.koskinen@iki.fi>, Andreas Kemnade <andreas@kemnade.info>, 
	Roger Quadros <rogerq@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Santosh Shilimkar <ssantosh@kernel.org>, Bajjuri Praneeth <praneeth@ti.com>, 
	Raghavendra Vignesh <vigneshr@ti.com>, Bin Liu <b-liu@ti.com>, linux-kernel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-pm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Fri, 11 Apr 2025 at 02:30, Kevin Hilman <khilman@baylibre.com> wrote:
>
> Sukrut Bellary <sbellary@baylibre.com> writes:
>
> > This patch series fixes the Power management issues on TI's am335x soc.
> >
> > on AM335x, the wakeup doesn't work in the case of STANDBY.
>
> This series is specifically targetted at the AM335x EVM (which I don't
> have to test), so I'd appreciate getting any test reports for this
> before I queue it up.
>
> For AM335x, I currently only have the ICEv2 and Beaglebone Black,
> neithor of which support suspend resume with RTC wake AFAICT.  If they
> do, please enlighten me. :)
>
> I was able to do a basic boot test on the 2 boards I have with this
> series applied on top of v6.15-rc1 and basic boot still works, but I was
> not able to test the PM path that's being changed here, so any tests on
> AM3 platforms that actually use this path are appreciated.
>
> Kevin

Is the pmdomain patch(3) ready to be applied here? Please let me know
if you want me to pick it up.

Kind regards
Uffe

