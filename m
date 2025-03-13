Return-Path: <linux-pm+bounces-23963-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4EB0FA5EDD4
	for <lists+linux-pm@lfdr.de>; Thu, 13 Mar 2025 09:19:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 29A171895C8D
	for <lists+linux-pm@lfdr.de>; Thu, 13 Mar 2025 08:19:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A501425FA13;
	Thu, 13 Mar 2025 08:19:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pdp7-com.20230601.gappssmtp.com header.i=@pdp7-com.20230601.gappssmtp.com header.b="kE5HyMZX"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01C7F225A23
	for <linux-pm@vger.kernel.org>; Thu, 13 Mar 2025 08:19:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741853972; cv=none; b=tE+N247mxJCuVb0WMPBYudOPGklpsc4by7T08UwoboprRxzLPSv2g21Q2EqO4Of49Gb1raeIUiwJsHtOMsly+vU98znWKbDHj9RePuZkk8uHD8i/aFa1r7bg4zfIqgJpirIp3jZGJkx+j4BIdvSty6IVI4H7E7xGC/uSXpxjCIs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741853972; c=relaxed/simple;
	bh=KoEEv/IQr2Nh7rqjmNfTP2da2uHnnyRE8EbB3JuJLT0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=J5ZsOlxutNTXVuUIbhDIZ0dj55p6vYtgg1aSRp0xxqAHiKwF+dyyilKUSn9rdxR99PHIJf69O1zG5sK0q6xvUILppfNRJHnAoDyqIfxHUAHSfnUQ4DEXTy/hjJ2jr3EMXuHOpQbLshYrtoLMwHHDbWOYGp7UhmaWtzCoNl9XIrE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pdp7.com; spf=none smtp.mailfrom=pdp7.com; dkim=pass (2048-bit key) header.d=pdp7-com.20230601.gappssmtp.com header.i=@pdp7-com.20230601.gappssmtp.com header.b=kE5HyMZX; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pdp7.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=pdp7.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-2232aead377so13981445ad.0
        for <linux-pm@vger.kernel.org>; Thu, 13 Mar 2025 01:19:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=pdp7-com.20230601.gappssmtp.com; s=20230601; t=1741853970; x=1742458770; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ZWEt0i+2shFRFdfbZiPgVihU5WzfabKYy6Z4Ak51Ze4=;
        b=kE5HyMZXx7dXAQGAGkl7HAvH1gsMoLM6R3W0gZpLuut8lxc5hS3f3DJNtAWIXR1fCi
         j5fqdQouyghvkog/+75mrCDmb4euBa9DTx+yrMPgZdBx5+4m44Z1lfuwhUcQymQGBD5K
         fPamU0PH22XUL2fT2CUi9fBlzdCq4Dd8jgpivMxAidSyy7wHAeg9lph49AcF5gHNwrTA
         BLb2m4z9eV1h3i+pgtbGQsPKJTH61ixBWfxG3Kxm6Pznv3nlHdxhNDuzY4Co59CoGvLx
         SB7p1dIFAjUdWSMOVWEUkY5PnbCyeIRVJKQ/VcsIep9IVeWcI9TfBYtS41yisDCpweUl
         qZJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741853970; x=1742458770;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZWEt0i+2shFRFdfbZiPgVihU5WzfabKYy6Z4Ak51Ze4=;
        b=KsVj8dNqLMAInJsGsmPvl7woAU0IC0vd8QDdMGIp4BarxWaAFuqXt6mNGxlkw8rOYx
         0LXyrFGUfmKqoAOR58mXjyNhYE2LQJimMWHJ8A6KxmvD/l5UmddPVRYMlYyIgYGej8Ns
         Vfhc3MPWVu+DeoqGTYvcOr+S9HkWczoba9xIHKnFlTz/XFBtZya+1urgZ0nSLJFrgLAy
         J8w1ik5O2XL2tDBrSj+Mfud5PuUKKv7Y17Vix7QYYwHrRB0cJ2+CAHTEMA6LkVEEM3Wd
         7seADJxjpoNf7MzhMzCLJmleEZ/CB5lkHhNDpEowvf83OchHiJxrY5NE4TVeI33fNeoO
         kJIw==
X-Forwarded-Encrypted: i=1; AJvYcCUmXfqB8ZO0xqKyKyyBsE0Y42aBXT1/5XlUlGXmWeuYIE9AGyrrIhsDJOK8a3APauBiFSD1TrnvJg==@vger.kernel.org
X-Gm-Message-State: AOJu0Yzw0k+B0ENcYUa76vZJOca879hTxS5gGXRthqN82t9kWaqzWkcK
	rXFcxLKaJAcSKL8JaO4UQ6qHo0X8hTantEPf7tK3u7yiWIJquMIEq177c4X9xcI=
X-Gm-Gg: ASbGncsyxjA6zn+hQ9zOF0wV9oAVuXOhnKdkdm/hf4+jeyyxcbESZ5u0Z4hDdfWnCmF
	MQcCErm2iSlQjwkwbo+J6BIh9giTCtcyimWyzWJjLsI4rACjHdzBq8Wq9Ek2FWVPnwpIzfINF5n
	wHLmoY3c5oDLRVEsxbFgsGfZ81cbLZ9Oj+WUvJQbXo7QStBj/7Uq+FlLf5pB9rpqtQqRKQYuFAH
	BpvQz42b/fyS3bdWsiF5IUvnkbGqEVOWgtOSIUIYSsA//l+Hl/p9TxlSVSPrQCVgm5UejLiRrYF
	4dBImm1CPGAwNXJibqWlfqtAHg==
X-Google-Smtp-Source: AGHT+IGvY/QZ39O2R90TZNOtRAufIJfxJ4YdpteHqgXktgzR2lShse5uenWthjfQWslvwJsLPVd98A==
X-Received: by 2002:a17:902:ec92:b0:220:e9ef:ec98 with SMTP id d9443c01a7336-22428896a74mr388719455ad.19.1741853969936;
        Thu, 13 Mar 2025 01:19:29 -0700 (PDT)
Received: from x1 ([97.115.231.194])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-225c6bd3c59sm7843595ad.218.2025.03.13.01.19.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Mar 2025 01:19:29 -0700 (PDT)
Date: Thu, 13 Mar 2025 01:19:27 -0700
From: Drew Fustini <drew@pdp7.com>
To: Conor Dooley <conor.dooley@microchip.com>
Cc: Ulf Hansson <ulf.hansson@linaro.org>,
	Michal Wilczynski <m.wilczynski@samsung.com>, guoren@kernel.org,
	wefu@redhat.com, robh@kernel.org, krzk+dt@kernel.org,
	conor+dt@kernel.org, paul.walmsley@sifive.com, palmer@dabbelt.com,
	aou@eecs.berkeley.edu, alex@ghiti.fr, jszhang@kernel.org,
	m.szyprowski@samsung.com, linux-pm@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org
Subject: Re: [PATCH v8 0/5] TH1520 SoC: Add AON firmware & power-domain
 support
Message-ID: <Z9KVD1GKGKPwMR+9@x1>
References: <CGME20250311172030eucas1p12dda42760f751174e774b8d1a3d3f4cd@eucas1p1.samsung.com>
 <20250311171900.1549916-1-m.wilczynski@samsung.com>
 <CAPDyKFqeaq5xVNA=0CpMWSt_78qXJsY6+mpE1CSmLrVMQazAjg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPDyKFqeaq5xVNA=0CpMWSt_78qXJsY6+mpE1CSmLrVMQazAjg@mail.gmail.com>

On Wed, Mar 12, 2025 at 02:40:05PM +0100, Ulf Hansson wrote:
> On Tue, 11 Mar 2025 at 18:20, Michal Wilczynski
> <m.wilczynski@samsung.com> wrote:
> >
> > This patch series introduces and documents power management (PM) support and
> > the AON firmware driver for the T-Head TH1520 SoC, as used on the LicheePi 4A
> > board. While part of a larger effort to enable the Imagination BXM-4-64 GPU
> > upstream, these patches can merge independently.
> >
> > Bigger series cover letter:
> > https://lore.kernel.org/all/20250219140239.1378758-1-m.wilczynski@samsung.com/
> >
> > This series is versioned to maintain continuity with the bigger patchset it is
> > a subseries of. Please find below a changelog for the AON & power-domain:
> 
> I can pick up patch1 -> patch4 via my pmdomain tree, assuming I can
> get an ack from some of the thead-SoC maintainers.
> 
> Patch5 is probably better to be routed through the SoC maintainers
> tree, but let me know if you prefer me to take this one too.
> 
> Kind regards
> Uffe

Conor - would you be able to take the arch/riscv/Kconfig.socs patch?

Thanks,
Drew

