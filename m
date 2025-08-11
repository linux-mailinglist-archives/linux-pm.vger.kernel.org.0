Return-Path: <linux-pm+bounces-32138-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3736CB20162
	for <lists+linux-pm@lfdr.de>; Mon, 11 Aug 2025 10:08:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 743CA7A032B
	for <lists+linux-pm@lfdr.de>; Mon, 11 Aug 2025 08:06:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 445B42DA750;
	Mon, 11 Aug 2025 08:08:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Os/5BV6t"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A01651DF977;
	Mon, 11 Aug 2025 08:08:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754899701; cv=none; b=ar1xTndU9X8lQ1OyBTqLs76FgWB5N7pknjQrPtk0wMda0lDneXxrUNFPflu1SXcoP9BL+/oP+SlAl75/bQf+AhmQH9FtpCNoe3BgxW5QWu9MqbObH1hWCMDfoA05eDYK8slLxZFgO+2nmIbHWTs74Aoi+GI9iFlDwkadWvLSsp4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754899701; c=relaxed/simple;
	bh=oTajOSV4WD49or58jFFQKgPCdX5azB7+7ubfHvm6hdk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=A8Noy4bD0v71iDev7VodhEj5frNaeYFX2tVBNZ1G44x25uFdJiKGUWwLxG6qojv1NHjLNPlJIpN+e4g2R28Q/vPkdXN4GuBowb0RgWxEGxEurlxovagDX3rW4FF2Qq8RRsN8ESVVsEeaFBRgI4Jb8C3vGW3ywpO3UHm75UA7e4c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Os/5BV6t; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-3b7862bd22bso2513504f8f.1;
        Mon, 11 Aug 2025 01:08:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754899698; x=1755504498; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oTajOSV4WD49or58jFFQKgPCdX5azB7+7ubfHvm6hdk=;
        b=Os/5BV6tl7pdbXbcQvR9Qmqgd9wtWXmaa2lKknOSnKQZ42hS3XQ98bRvwosM2147tr
         YSqarj8MPyOciXHzJ36HGjMUc0qrG83eG/s8PoauLEHEgWw1gLwNlBbib3X1ImR/5gyC
         wz3pm4JlslTICT2RdG9ZcMvaR+K3Ieir9MXjiKtM3b+0/cU8ZFPgRJga4WkYsjVuG8Dn
         jR4HaP2cObuu+oRjns5ae2OQ0AfWgxew2pLxqtihu6Pi9KQJssLlX62YGujy/QK9JAnN
         udVyYPIAeXY7iOM0p+Y9NoP+JHuTF2BJ3JH750G35/5MF0FEMBqpLbNn3exDCpAMfaHu
         QxJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754899698; x=1755504498;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oTajOSV4WD49or58jFFQKgPCdX5azB7+7ubfHvm6hdk=;
        b=l8exdwSgPJ7qJ7NNPArFGrilPTPhYofLliM66dYF5/2+GeX97pNSCehAm0+lhbw1Mw
         5AsxRMnTiWq27EWIsyS2PJKv60HMl1zXMK/DS3fIB3nGlwBaQGdYtcY/eVt8wbYpllu0
         VvGZK3JgiZogXAb5SCNfbgLQEdnSRkLS5MmR6x7wTaAi0dQGi0gv4oNBftP5FW3b1o1b
         V8pBqiU3Gr0HzcT8Id5N8hEpPr1vQnO/lcFsf81lt2s644yNkih+VvLObX+eT6Lxkwpm
         ceEw+fH4A9JnfnNYvwvPygsjqfNNuu4MUBUUq//wzUvsFajna94FRvrGuhSaGeisbFHf
         nIhA==
X-Forwarded-Encrypted: i=1; AJvYcCW//AMxV6S3w711b9aLSLJP06aMFsEOqfF9dCVYBF3M1KEWSlfU7lzSulTmaS02coesDd2T74Mswf0=@vger.kernel.org, AJvYcCWJkjhg1YceI755cTEi5q0hu8BYjR7iS7VXfUvEL24WluBypl+e6fCIDniy6cmE3uW1wmExRTb4xCno8Eiw@vger.kernel.org, AJvYcCWLd/H0opB342JS1GMbFabtaOFHpF/fgkdpdNNVuWmH1hwITAmvHhnqcBwCW+3tgdW8etCbCrmYcD/PdAM=@vger.kernel.org, AJvYcCWt/IfVrpr3LQHP1iP9tZaOGeeQI2ZIKh7P/Dsyd3jHOcKYvYqr9i6WJ+qgaXt4xh/QH59uDS3iybY=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywme7huZrN2d0zQIBl+iEv6Qk3e/dk98nT/BjmIABsxpLNqAPQF
	dtfVyeLMUvs7GhH6GoP8GjkEskrEDUPh9mZomZnkc7m/A2Qac1nDiKZIku+sLDEQrtM/yuhr99U
	oku4J39xXVsC5AnmKQDuAcLn7vkG205s=
X-Gm-Gg: ASbGncsLgGixc/LXIbDzybZq/YHgZtbYYAb0F9CaFNJL1DSva8nZf2Raa19EGbKZ6SH
	U0UoVGDTK7Vq9AdQMUSnx8oB5a2gIX8RS3JeDHU3i72VYIIVww7spgqWtudnfu1fFBYv4XGsoiP
	DTdEdEOToqr99kQyveHk9bMlUhaQ1B9G+5+ceKSar4+QbjBFP0j583H4MC2ykKLa8cpsKfNTl19
	E1z+m2E
X-Google-Smtp-Source: AGHT+IFQYThriVYkG4l41Pm2m9DFlqkAsl8e3bqSyDSoX90aAt2MINDbXW1290ReIK6ddDx+CRDXeZBfKaC3t21oGiA=
X-Received: by 2002:adf:f8c6:0:b0:3b9:469:6b3b with SMTP id
 ffacd0b85a97d-3b904696caemr6356507f8f.6.1754899697803; Mon, 11 Aug 2025
 01:08:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250321095556.91425-1-clamor95@gmail.com> <20250321095556.91425-2-clamor95@gmail.com>
 <svbpvo5cpwonxae46wre7ar2w4yf5j2xbfkb4hek6xgnue3jpl@5v57pp4iz7uv>
In-Reply-To: <svbpvo5cpwonxae46wre7ar2w4yf5j2xbfkb4hek6xgnue3jpl@5v57pp4iz7uv>
From: Svyatoslav Ryhel <clamor95@gmail.com>
Date: Mon, 11 Aug 2025 11:08:06 +0300
X-Gm-Features: Ac12FXyu7jeVTLZAUsdCRGtClrszgFd-4CORCMHoBadETFSPKYo1vU9UwGhKTwo
Message-ID: <CAPVz0n18VGrY-dAAUPq4iZMX149hpSWshXPCf32ZxKUwrtHcbg@mail.gmail.com>
Subject: Re: [PATCH v1 1/3] drivers: cpufreq: add Tegra 4 support
To: Thierry Reding <thierry.reding@gmail.com>
Cc: Jonathan Hunter <jonathanh@nvidia.com>, Peter De Schrijver <pdeschrijver@nvidia.com>, 
	Prashant Gaikwad <pgaikwad@nvidia.com>, Michael Turquette <mturquette@baylibre.com>, 
	Stephen Boyd <sboyd@kernel.org>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Viresh Kumar <viresh.kumar@linaro.org>, Philipp Zabel <p.zabel@pengutronix.de>, 
	linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-clk@vger.kernel.org, linux-pm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

=D0=B2=D1=82, 10 =D1=87=D0=B5=D1=80=D0=B2. 2025=E2=80=AF=D1=80. =D0=BE 14:0=
9 Thierry Reding <thierry.reding@gmail.com> =D0=BF=D0=B8=D1=88=D0=B5:
>
> On Fri, Mar 21, 2025 at 11:55:54AM +0200, Svyatoslav Ryhel wrote:
> > Tegra 4 is fully compatible with existing Tegra K1 cpufreq driver.
>
> It might be confusing to refer to this as both Tegra 4 and Tegra114. I
> think it'd be better to stick with just Tegra114. Otherwise:
>
> Reviewed-by: Thierry Reding <treding@nvidia.com>

Your review applies only to this patch to to entire series?

