Return-Path: <linux-pm+bounces-20439-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 828ADA11196
	for <lists+linux-pm@lfdr.de>; Tue, 14 Jan 2025 20:58:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F03E4188AB7D
	for <lists+linux-pm@lfdr.de>; Tue, 14 Jan 2025 19:58:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA27320AF7F;
	Tue, 14 Jan 2025 19:58:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XiEZAcSz"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81F3120ADDA;
	Tue, 14 Jan 2025 19:58:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736884682; cv=none; b=iGV2SKMrIHXBU8Um2vAzhG0Ri4+YptXPlhNAx7FQF+wGbtuxFWrPZY2/ZKO6vJfsMgbncOcvYB/qLhnVSI2KPf6GOU9krqPOTpd//VnfyGhgrHCaFYdgl5H0pqSTzbztCkf4zcnXEG/m6qV2IllfK2IIyOUwLLk7BdkWsaVplLA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736884682; c=relaxed/simple;
	bh=hIIYQp6fcNeBR0kzqTPjOpkDEp1CFcrYTpkr1lHTB68=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gvwBm+6wILME7q9Upe+vVgk08zwil/JrMTa2SwT9I+P4w4OIqwmkOv3J2nfSVqDCqH2Wqqz8YmXjzMnooSTSDtTbzWKNKLCwaMgF2s+ZtN5i4D/X9dwwMLxA2NoWDAw6nx0Dxsd9urfEsC08EEahaiaK6sfjNxeHfAj2UTC1p4k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XiEZAcSz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EFD27C4CEE3;
	Tue, 14 Jan 2025 19:58:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736884682;
	bh=hIIYQp6fcNeBR0kzqTPjOpkDEp1CFcrYTpkr1lHTB68=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=XiEZAcSzKg2AMr68hLxmb0BB1/OXCE8i5TLbxrIAymqRpyhihW34Rl1m3VauxUlsU
	 +EDcu3v+qGeLVdvLtvF77TQza5MntFaXgSnsauiOtGf7rMG2ywV4AfQglIrbcrVp3u
	 KEdqjQPNu19y1KgVHfNGSXIAXTLgDYUzdEK7l1+sA2tDhJSp5QpbhwJ/zG6svct3Nj
	 gAURsYDPoBfJ3R9LV7VUQ0LkvyBYypzKfqguTbWy8zpQV5dNy+tNcOJ1funZtK0eO4
	 /X0D25vouLBsMqgG1BzEKbUf2KX4WJ/oN/TKHBE/oT2g5a+q94rmp3V6C9A2oq5cZ/
	 Lao1ODBV05Nnw==
Received: by mail-oa1-f49.google.com with SMTP id 586e51a60fabf-29fe83208a4so87833fac.0;
        Tue, 14 Jan 2025 11:58:01 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCU3r/OnnTZgY5Ft/3VZ5lDgFGpIA68cwcAYxdNnfheDBeRhWVT6fIm8JV90Nmz1MRZOS7wTbGPW4jXNtF8=@vger.kernel.org, AJvYcCVwCnh5wIYIfKe1T2aI9k+i4gAtKWfUqfLUgmLzJayhMcFEF1m85O2ZT1uvzEQcqzhK9T/mxYUY37I=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyi72Wvl26UK0xe7TlDfVAoob2qUdPI9LORJyQqfWLectQYLSHG
	3KJxOPsYHZ1hcBSLGWQvWoiN1StDQV7W6n6ce4xgNI5kdrcOcb4+bFFy0UZ7kz6gN3h+b3b2SES
	Xf7s0GaiaHGl1SXIhU9TP+F/dYFs=
X-Google-Smtp-Source: AGHT+IHlQvRisQNxVZQehR+JgSmk3ttKtac+ozQpYYkGtc4Wr8guI88jx0jsKafwBzsJGv8cvg0GhPW2o9vohNWwduo=
X-Received: by 2002:a05:6871:549:b0:29e:7629:1466 with SMTP id
 586e51a60fabf-2b186a51398mr168520fac.7.1736884681271; Tue, 14 Jan 2025
 11:58:01 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <84ac7a8fa72a8fe20487bb0a350a758bce060965.1736488384.git.viresh.kumar@linaro.org>
 <Z4EyAQuuBSOV5Xwd@bogus>
In-Reply-To: <Z4EyAQuuBSOV5Xwd@bogus>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Tue, 14 Jan 2025 20:57:50 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0jnCVzdcQVCzR99bXp2-=1Cwo5Swz+OJ-x6SBCmM1N-3w@mail.gmail.com>
X-Gm-Features: AbW1kvbmKcgYixh7-NvFTwQtjetRlXLyQh5GsYcxaXfG7CpokFeSHBUUHMBCIOs
Message-ID: <CAJZ5v0jnCVzdcQVCzR99bXp2-=1Cwo5Swz+OJ-x6SBCmM1N-3w@mail.gmail.com>
Subject: Re: [PATCH] cpufreq: Move endif to the end of Kconfig file
To: Sudeep Holla <sudeep.holla@arm.com>, Viresh Kumar <viresh.kumar@linaro.org>
Cc: Sunil V L <sunilvl@ventanamicro.com>, Palmer Dabbelt <palmer@rivosinc.com>, 
	Pierre Gondois <pierre.gondois@arm.com>, linux-pm@vger.kernel.org, 
	Vincent Guittot <vincent.guittot@linaro.org>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 10, 2025 at 3:43=E2=80=AFPM Sudeep Holla <sudeep.holla@arm.com>=
 wrote:
>
> On Fri, Jan 10, 2025 at 11:23:10AM +0530, Viresh Kumar wrote:
> > It is possible to enable few cpufreq drivers, without the framework
> > being enabled. This happened due to a bug while moving the entries
> > earlier. Fix it.
> >
>
> Surprising to see how randconfigs has not managed to catch this so far.
>
> Anyways,
>
> Reviewed-by: Sudeep Holla <sudeep.holla@arm.com>

Applied as a fix for 6.13, thanks!

