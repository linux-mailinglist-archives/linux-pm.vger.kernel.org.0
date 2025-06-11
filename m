Return-Path: <linux-pm+bounces-28427-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E624AD48C6
	for <lists+linux-pm@lfdr.de>; Wed, 11 Jun 2025 04:19:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ADAEB17731E
	for <lists+linux-pm@lfdr.de>; Wed, 11 Jun 2025 02:18:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4322187858;
	Wed, 11 Jun 2025 02:18:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="WrwnM+C5"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BFFF16D4E6
	for <linux-pm@vger.kernel.org>; Wed, 11 Jun 2025 02:18:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749608313; cv=none; b=S+rIARV74OvPho+yUKgAog09TEHmS0iRNRIouAG/We201CdTDbyTvD0jXTmdJH0lhXLTQa1/JvDezqsXTu2xXZKGMQL3lI15KTUN0EBmzx+gIqrfDnCayDylXNxYaZiLbZWphjcuIa39oBWqcPLLczeOUosHSb8rTmphcL456yM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749608313; c=relaxed/simple;
	bh=A1VFeAvhgOC1yMtN7yIyjPHN3d7Ti6ibq7gtPR6jl6U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UURn4pO0dW4im/CTHF91GSDmFC274KYKnXh1ABDz6nGaUsNpgqfInbhrGhWXDPvVb1VCuFwu/XwvwOfupBH8tryyczwTcctKbUFvFrKgIVVijSNbkkZ0H42q7CxHuaa/ciKlYTrnOAsE/R4SB6tWiGHgpL9IMwLeboZCCE0N5Ro=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=WrwnM+C5; arc=none smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-3137c20213cso3450807a91.3
        for <linux-pm@vger.kernel.org>; Tue, 10 Jun 2025 19:18:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1749608311; x=1750213111; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=BVzPT+QBa+W+93Jw6CnS8ATXdFQx76rd+QJAPEuwELM=;
        b=WrwnM+C5gS3K6h39OPo0xbroKtmYSKvrQTB8inA/cHMPjFxA3/Xck8+dz0nAQEJcpj
         nGH9hzS50hH1T+xQSupeRsZYD8+oIRHJs4vPOGiDwBfgU1GMR/EyUj6IW5MuvruIRqIm
         20y4n4U1P2yHs3FgcMTKFEqEjgyXAOVVb+AxKcGPM8CXffSCTYXvlmcoO6XjtXhhTxjk
         o3ZaAvX57KMGbHD6WwSZicKwQlExmARUZ2inZLRABHBV/KnhOjJlOAmakrD5ruhlXpPt
         0Qi09WfF6G2hrRkqAX13zrpxstKI+Sii3ilY5p4X9Kk7GftAWgvb5K6jx6muolQUQlhj
         hFgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749608311; x=1750213111;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=BVzPT+QBa+W+93Jw6CnS8ATXdFQx76rd+QJAPEuwELM=;
        b=BY9T/qK1yvYHwam2rg340oSlTH6mkH4Sne9cih7/ytAfeZz0ljmjtp2uA41/Y/fHAm
         xarxxCl5CCicvthkvQhJ6tRKkp/3TFAiXR4WPD/IgpLO4XO3Om5TRbKSVXG5K3PZHnTJ
         E5IiO6HNOVz8fSbIXiyFQAgXD7L8hPlN5s/2Mw1jO9/R162L7V+MIBukMV/zkl2ikp3E
         hBVNPLAAmipRbB3uV7pN1F3/KhxqqYylKd7DWn0e1I18wILDrMX1ofzcCFCItDx6MFvI
         iJkkQqcQ0c8OWx63eRVny3+MXPf+kpR6nifTCKVCa8WRmUcVsGN2QARJKogi8dAao3pA
         lG7g==
X-Forwarded-Encrypted: i=1; AJvYcCWUY4sofk+sr4IPy4QHTrLoi2xTGQLIXVFzkKtwXMm3lObhcuYdHktJXNlLQC90/A8vsfDG5aqdwA==@vger.kernel.org
X-Gm-Message-State: AOJu0Yzz1thwHVARrUZ9DsjQdxiBtNBVrMDgxJ2OqwJHnBVsXvjUBnaH
	fgL9Mbhb1SkDm/UwHzrnKVZPaCfEntE2RGEPHxxpwGwDyaSZcl77sbdgbS9Ron/3LpA=
X-Gm-Gg: ASbGncvo4nbL08WP1M8CF+m2RjcbmBzHuuU5TBx/x0D2bEURtv03SbF8abHLkKpYeY3
	+imdzJKy8m9N0/1miYMFcGUSOyAu+agDwrGcG59pLOSjPnuYmzo7Yd9keDQm5TNBUFzUhXkjX/c
	2sfiRc/9JAaeAZ5v7X42hL3NbTtxiScxu49gZ5M/0z6LB5d4NmnamtEjHw6aWkTc2LmLZEXv8QB
	1H3zGCco0vz9Cv3EGXSQHJd7t3IgsDEu8SCrI+WvWP29Vp1g6m+WjTdaOLKgTX626DHC/FFNHVU
	8RYbq+xsBxwFNxlcQDE59I+zV+1TKQhjjlB1DW890HSKciwVtXta1fyINWkJRmDS6xrUJMfkaA=
	=
X-Google-Smtp-Source: AGHT+IExhs5eYhf6tHwalRmCPZodGm+T8pYXC1tEHKyqqYin+EC/fkXPzgbCpRMDAYA8+l44SvhlXw==
X-Received: by 2002:a17:90b:1dcf:b0:311:d28a:73ef with SMTP id 98e67ed59e1d1-313b1ef5898mr1307915a91.10.1749608311204;
        Tue, 10 Jun 2025 19:18:31 -0700 (PDT)
Received: from localhost ([122.172.81.72])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-313b2141e6asm256489a91.42.2025.06.10.19.18.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Jun 2025 19:18:30 -0700 (PDT)
Date: Wed, 11 Jun 2025 07:48:28 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Cc: Boqun Feng <boqun.feng@gmail.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>,
	Alice Ryhl <aliceryhl@google.com>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Benno Lossin <lossin@kernel.org>,
	=?utf-8?B?QmrDtnJu?= Roy Baron <bjorn3_gh@protonmail.com>,
	Danilo Krummrich <dakr@kernel.org>, Gary Guo <gary@garyguo.net>,
	Miguel Ojeda <ojeda@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Trevor Gross <tmgross@umich.edu>, Yury Norov <yury.norov@gmail.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-pm@vger.kernel.org
Subject: Re: [PATCH V3 0/3] rust: Introduce CpuId and fix cpumask doctest
Message-ID: <20250611021828.fbdyugkxz4axz67b@vireshk-i7>
References: <cover.1749554685.git.viresh.kumar@linaro.org>
 <CANiq72mWAP5ZuOGTXZ1=zTOR_Y2YuqV2i8PberOeWOkx3VL0ew@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CANiq72mWAP5ZuOGTXZ1=zTOR_Y2YuqV2i8PberOeWOkx3VL0ew@mail.gmail.com>

On 10-06-25, 19:10, Miguel Ojeda wrote:
> On Tue, Jun 10, 2025 at 3:22 PM Viresh Kumar <viresh.kumar@linaro.org> wrote:
> >
> > Here is another attempt at fixing the cpumask doctest. This series creates a new
> > abstraction `CpuId`, which is used to write a cleaner cpumask example which
> > doesn't fail in those corner cases.
> >
> > Rebased over v6.16-rc1 + [1].
> 
> Given this is growing, should we apply something trivial right away as
> a fix meanwhile? Or are you planning to send this as a fix during the
> -rcs?

Yeah, I am planning to send this for rc2 or rc3.

-- 
viresh

