Return-Path: <linux-pm+bounces-27293-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E5A19ABB440
	for <lists+linux-pm@lfdr.de>; Mon, 19 May 2025 07:00:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 818B9172B49
	for <lists+linux-pm@lfdr.de>; Mon, 19 May 2025 05:00:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B44A1E9B08;
	Mon, 19 May 2025 05:00:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="BujHbdjw"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73AE21DF75B
	for <linux-pm@vger.kernel.org>; Mon, 19 May 2025 05:00:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747630837; cv=none; b=Svf1cyOlb1rM88T5PYTL1R14oOt3Q+8JYe5qnuvuAlhB1r2Xql3iedDEcaKO7FsFjjW8fgi+SEOeNR/8K8yReX6eAHWgVnA6n9QpR/3p/m9p2ZYoBo6/rrWWRILNJdgCTL9AfjpZuuD+A2Oo0Kf3SiuvNRhQLLRbcuUFafHBu4M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747630837; c=relaxed/simple;
	bh=52xFP2yXmzdy76BSD3IQGcBieRU5x1c1JEIQJWBn5z0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RXtyU5mKkhpgr4U54k4NU5nXpoWKniiwaKrSSF4ahm59fIOBD13aANXzWejNXQfyoRCFxSuBatmHFKzaswJU2xkjNaqdis+gHmRe/Mh6RmRf85SZwJpFYuQ9q6q5CcmL1+vfpelNFQCOb4qZcrMc1lgKw+xyI12Y8tmJLRZeZkE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=BujHbdjw; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-231f6af929eso22803555ad.2
        for <linux-pm@vger.kernel.org>; Sun, 18 May 2025 22:00:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1747630835; x=1748235635; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=82v/sx1Sw6y7WKPsyPlbe0lUzCp5MKII3VW5cqIabiM=;
        b=BujHbdjwz+ibS/qq5qTUi7Kf3A2x+VhVDYQNsDpQhJ3ScvbNjK19LtOnDczuX8bzeM
         piabifgBhTbmIOb+QHftgYm1EOKsYv8CCfXiaWxfYE1PwGYACUlvdIRzG65IrtBlqnB0
         mBVHzvrJoYz6zmcf3saFZDNOoEmx93+XwqydK4PmFXdVhGDgAyoQBQkvFOYW3e/1VOHI
         V04RAzMeKJLbt433/29SD/hPzLJm/B1x06p/M1B7kVGtJrTG3KUsuOtVH+izueTLYi5M
         +6ro7mGpskuIyLJGHkeWk3hRB3YL40fG/bpo83iJUWlF4wmsHabid9Gr1W3AnAjj0CAV
         pRAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747630835; x=1748235635;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=82v/sx1Sw6y7WKPsyPlbe0lUzCp5MKII3VW5cqIabiM=;
        b=GznizNp3eEDt/9al6ot+5af/AqVV85Vzw6BxLZPM/yz6tWfyfqObV2fb4zAPBzE51F
         E1ozCj1H7N3ilKBLlPm2S8DwiSpZiJhkUVEQ0rJXAgxmCxaXLdosld8iLyW4EEx2bFwX
         CWiGMdS5iTDwKRm9ZBwEopzojrJGcjsMWz0jmw34EiQdD3KIgkY+9G9Ldy5/zSfMU7QX
         xos4/QBl8cbL+uLhjY/bbZFfRbV677id7gbcEDlv0lYG/rk7TZrDHVHZ8sNSEVvJZN9M
         ov+0/T3l7HCj0eklpe3T0u3snxcIoqtiIFEdsYe+GW750cWH3l2vgNDWnWnZY+912vTl
         HGEw==
X-Forwarded-Encrypted: i=1; AJvYcCU+y1k27lpW7kVazGH/imceASDP/oswc0VtnXh04s+Toce0IVRHetjpHOCok8ZEXvdchchdS1tjmQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YxXAPinA5X4MdfGYapOOOZ5pI4ehBeM4yMQRY6k3uygl1S+kC1/
	t+y4Aa2lKsPkoGWCMLBBHF4IVdvbME7F52q0IFUBdojy/A+c3KF7tU3tadVjLBMK34w=
X-Gm-Gg: ASbGncuSukdC0ezfYqh0JYXll1I/wBrwd+E5223Elw9jAAeTn7xKx0+Nhyy8IY15gIm
	jnwjfPfQvzS8c0iP+MbglSBbvnOQRCTZ1+cuq8yLZGSB7HMQjLhJVdXuFerplk0cjIDEEqmHdzg
	DTjJZ7fNLH3kbwTMf8XTp7+8hkp/IRchupeb/ME7q40DraXNRm9FpR6Ayf+ikKAHkXDoLv6+lae
	KIcLpU30S3ejB3UMIdddybLh94B2dqdcp6EDi4BN0HuCmj9i3mD0U1AZxeyj5En2XZh3WIjBjtV
	/nSWrmLBS4mdJp+NW4MuKHdExMdCc01dFlwjvjOT+vxKmXQ7kQpm
X-Google-Smtp-Source: AGHT+IHY0g16rfbp5zZDSXcf+iHzCxEm729X3u6FpJ10x26f8ry1SAGnoYpao17zGAVNjZkMWFdSFw==
X-Received: by 2002:a17:903:3d07:b0:224:a96:e39 with SMTP id d9443c01a7336-231d438b420mr168488495ad.9.1747630834666;
        Sun, 18 May 2025 22:00:34 -0700 (PDT)
Received: from localhost ([122.172.81.72])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-231d4ac9256sm51112355ad.35.2025.05.18.22.00.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 18 May 2025 22:00:33 -0700 (PDT)
Date: Mon, 19 May 2025 10:30:31 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
	Philip Li <philip.li@intel.com>, kbuild test robot <lkp@intel.com>
Cc: Andrew Ballance <andrewjballance@gmail.com>, a.hindborg@kernel.org,
	alex.bennee@linaro.org, alex.gaynor@gmail.com, aliceryhl@google.com,
	anisse@astier.eu, benno.lossin@proton.me, bjorn3_gh@protonmail.com,
	boqun.feng@gmail.com, bqe@google.com, dakr@kernel.org,
	dakr@redhat.com, daniel.almeida@collabora.com, gary@garyguo.net,
	joakim.bech@linaro.org, linux-clk@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
	linux@armlinux.org.uk, linux@rasmusvillemoes.dk,
	manos.pitsidianakis@linaro.org, mturquette@baylibre.com, nm@ti.com,
	ojeda@kernel.org, peterz@infradead.org, rafael@kernel.org,
	robh@kernel.org, rust-for-linux@vger.kernel.org, sboyd@kernel.org,
	tglx@linutronix.de, tmgross@umich.edu, vincent.guittot@linaro.org,
	vireshk@kernel.org, yury.norov@gmail.com
Subject: Re: [PATCH V11 00/15] Rust abstractions for clk, cpumask, cpufreq,
 OPP
Message-ID: <20250519050031.ubtfvbzjuyhc3bab@vireshk-i7>
References: <20250502070109.inpes2ou3rxx2fxp@vireshk-i7>
 <20250506101311.142475-1-andrewjballance@gmail.com>
 <CANiq72k3ozKkLMinTLQwvkyg9K=BeRxs1oYZSKhJHY-veEyZdg@mail.gmail.com>
 <CAKohponbEEP4_weUuKkOGLRj5-1oOsoL_Zu_7W_SxB61hjsSCw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKohponbEEP4_weUuKkOGLRj5-1oOsoL_Zu_7W_SxB61hjsSCw@mail.gmail.com>

On 08-05-25, 07:40, Viresh Kumar wrote:
> Thanks for the report Andrew. I was expecting to get
> these from LKP (for my branch [1]) but I didn't. Even if
> my branch isn't getting tested for Rust currently (please
> enable that Philip), I should have received these for
> linux-next ? Philip ?
> 
> Anyway, I have prepared a branch with a fix for this, but
> facing issues with pushing my branch on git.kernel.org
> currently (Don't have my regular work setup while traveling).

Andrew, I have pushed the branch today, should be fixed in linux-next soon.
Thanks.

-- 
viresh

