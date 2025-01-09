Return-Path: <linux-pm+bounces-20133-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B8983A06E57
	for <lists+linux-pm@lfdr.de>; Thu,  9 Jan 2025 07:36:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A77113A4176
	for <lists+linux-pm@lfdr.de>; Thu,  9 Jan 2025 06:36:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D78B0202C26;
	Thu,  9 Jan 2025 06:36:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="du94z/Cb"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 452A519CC14
	for <linux-pm@vger.kernel.org>; Thu,  9 Jan 2025 06:36:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736404570; cv=none; b=AXa2NWvt3cu7Jd+tKUg4fMNAOgjzrs/gfYYmjiXt/eR0oW6pG/YntNMmdNBCrdqdf52/MtvLQRfWolUQjBPQyqKWz7j7zAYgkyIwdyQWV7YX3LicSFiXNBY21TDjiiYRB9KGCCTN/Vbd50ec0tEaxUupRZ2VFvSxnqdFuKQfCK0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736404570; c=relaxed/simple;
	bh=lMVxnnWkszZgoFiZ0m6NZLBkZHlM67uUzVc4GW4Mr+4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LkeGGuEgU0MJT4dCMz3zAXoIq1SDdxgFsH6Z14pvLW+V4fqDkSyrX/cK+uoqfgo018i8nu45bG3vW5xCS4Km3aOmiZVGmf2yqPaTY5tsS8eks0W1RSZhE6Qu62nzSlJ6GljtMaWYwZGn7bkcV6won+S6irkNcxB3Gpk1/G/Ytyw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=du94z/Cb; arc=none smtp.client-ip=209.85.216.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-2f441791e40so750228a91.3
        for <linux-pm@vger.kernel.org>; Wed, 08 Jan 2025 22:36:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1736404568; x=1737009368; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=vo8ZWmxiVMxPWb/ReRE2+R0SBytPF5o5EMz5YOhXmjc=;
        b=du94z/CbljSOXhBoxb4L6o3gm6Vd+VCTdO91hBbf0IZuL18uhTJD0FavDPCon+UKK5
         v4ZaKgi/6BY5PSZKkv4azvLK4orNmbX1yeEeSDsBE3nrU72+0Pb4qxNIFbpHj38Ak5zp
         VND1eopG8gL2TdeYMoWKk7H17JCZsurDMCPfuWjEXeoce7L/rQMYTjxiRk946WFNfkoL
         NwRxNKQajFZuNo6LQvhbQXs88p5XikLMOLduCDTdssL8fSc60lmvJlmRVu2FhgZpgWGN
         a2CsXbqn74visMfwU756Ez+i8jg/tu3vfy2JKWMBtPSG04SxSpAj19Ua3pRL9K4O6OZh
         TQ/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736404568; x=1737009368;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vo8ZWmxiVMxPWb/ReRE2+R0SBytPF5o5EMz5YOhXmjc=;
        b=CCjsxtnlHR9YATSMs67BHUXXn2MY7HEDDupaysjQiar9hh3sJgEJLGAU0PlKoGDwT0
         gJxCOdLOvRtPNvapHETamcgTNHdjOQnpCN/R3DbSqmjjz10ZlkuFA8nsY71+JoiidFSm
         bXjYppTRQXhzp4k6hk5Z8coHWutpBorJ1PKjTQtou+OHLNeUX6qC8N3y0I6XgIEUO8RG
         OzrfGRLpI/cjPleFWQMxGNaGXUA9jj+5BP3goFz8Kkx6ByNb6MPuNj/3wS+3Y04VZkXT
         zActhPGlJPcQISesW+HYgyqlxJNjuOSHKAnnFi800/yn3bfwCK2qEn4Zwm9Kv0FDnd9I
         +yEA==
X-Forwarded-Encrypted: i=1; AJvYcCVAHhv10TBqGBeKdTlbCGFY9f+I+y2NrRI8bgSFkwKdVwxupLi6KzLoIuqsvWhp/0sqrmEfIIQRGA==@vger.kernel.org
X-Gm-Message-State: AOJu0Yy0PBke+X79Gf7Xn0m5k74Uc+VV3OyR15H1aWoDYn/YW0dT4wls
	OeTWqqiUjjAdNoPMaP4pPdaLMO1Mlf8818Yo83iY0+ObDOFU4XDhRGQfM2/+zI8=
X-Gm-Gg: ASbGncvs1bQvl/6CBKVlbz0UNxmFd/EphVeThHkvpxR5rYXZZeZRI+yWKXKO9XdjMSm
	qQqqXCHUFXL3UZO6Hfzblbr03/snLvWWFoYA/u2CKufcjEXsZuXIhdgLtDG65vvChaUUFQkGeeR
	K5PbRj5S1Ug3V3SPfX2DIe2ynX2Ck+OTtHoXZXBpKNnz4QJIxibW0y/8TiMn/Y9pB3nNeZW9Dh3
	yFDE08SGUTPKsb4PV29AvqkELXC4yHZCmEeZ93TwFO7UUKCD6ig3kdcFjA=
X-Google-Smtp-Source: AGHT+IHDeZ/6AdnQUWhDrag/a2VFncVWjraJpakuoz3QPlCO69KlNtXITMl1QVuA/tTHp7vixFPj9Q==
X-Received: by 2002:a17:90b:2650:b0:2ee:d7d3:3008 with SMTP id 98e67ed59e1d1-2f548f33b37mr10299302a91.12.1736404568653;
        Wed, 08 Jan 2025 22:36:08 -0800 (PST)
Received: from localhost ([122.172.84.139])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2f5593d08a8sm598376a91.9.2025.01.08.22.36.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Jan 2025 22:36:07 -0800 (PST)
Date: Thu, 9 Jan 2025 12:06:05 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Danilo Krummrich <dakr@redhat.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
	Miguel Ojeda <ojeda@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>,
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
	=?utf-8?B?QmrDtnJu?= Roy Baron <bjorn3_gh@protonmail.com>,
	Benno Lossin <benno.lossin@proton.me>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>,
	Danilo Krummrich <dakr@kernel.org>, linux-pm@vger.kernel.org,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Stephen Boyd <sboyd@kernel.org>, Nishanth Menon <nm@ti.com>,
	rust-for-linux@vger.kernel.org,
	Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
	Erik Schilling <erik.schilling@linaro.org>,
	Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>,
	Joakim Bech <joakim.bech@linaro.org>, Rob Herring <robh@kernel.org>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH V6 04/15] rust: device: Add few helpers
Message-ID: <20250109063605.gmykltd6bnjaspwm@vireshk-i7>
References: <cover.1736248242.git.viresh.kumar@linaro.org>
 <429b7539f787ad360cd28fd1db6dc3d6c1fe289d.1736248242.git.viresh.kumar@linaro.org>
 <2025010734-march-cultivate-bd96@gregkh>
 <20250108110242.dwhdlwnyjloz6dwb@vireshk-i7>
 <2025010835-uncover-pamphlet-de5b@gregkh>
 <Z36A0g9g6qkRZSjh@pollux>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z36A0g9g6qkRZSjh@pollux>

On 08-01-25, 14:42, Danilo Krummrich wrote:
> I think that's really what is needed, otherwise it'll never work with the
> guarantees the Rust `Device` abstraction provides.

> The patch below is still not valid I think. It assumes that a CPU device never
> becomes invalid, but that isn't true.
> 
> There's a hotplug path [1] where the device is unregistered.

Right, though the device pointer always points to valid memory as the struct cpu
is never freed. Isn't that enough for a pointer passed over FFI ? All the
from_cpu() method returns is a reference, which will be used for a short period
only (yes it is about the possibility of something going wrong in that period
only and we need to ensure it doesn't break in such corner cases).

FWIW, the cpufreq framework is registered with CPU hotplug layer, and so
whenever a CPU disappears, the cpufreq core will stop using its device pointer
before the CPU is removed. So technically we shouldn't land in a situation where
the CPU is unregistered and cpufreq core is still using the CPU's device
pointer.

-- 
viresh

