Return-Path: <linux-pm+bounces-33866-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 931CFB44390
	for <lists+linux-pm@lfdr.de>; Thu,  4 Sep 2025 18:50:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 894EC18872DE
	for <lists+linux-pm@lfdr.de>; Thu,  4 Sep 2025 16:48:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4447E225408;
	Thu,  4 Sep 2025 16:48:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BtOu0hc7"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com [209.85.167.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7418A1F5E6;
	Thu,  4 Sep 2025 16:48:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757004490; cv=none; b=simYKABK4zNZ8SaxYnZQJcr6wyHHkZM3LKrBtIFb/lyKk3SFDwhX0Zq3Vhy2E5x70tr/X0lDvvQ5aDnhoCbUgMrU/E3FsEoyyf1szPSkFFpO4JkhxPNp+hUICjN31+T8dYod3K39FNupsLWEjvBcKp4uIQZPJ+s5E8mPRGS8lWM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757004490; c=relaxed/simple;
	bh=aKlEsmb3gUg35aFO1hKP5pVn6VvRRI/bXaxmIEuQZoc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gayAXzrrdTLZs9ImG42fZOx24RrOlAzW8AgfaV7O3z2wETsZAlCygLHXjseT5J5MeidbQ6lEM6cIj0e7zdxCRoEt9/gor8q9+WlwfyFTDLpPB7oIoP28DQUhJ99ns/Bc4ms4Bd65vDvBjvulZSX5Sphb3oG9iU7cIBsHOtWGc/c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BtOu0hc7; arc=none smtp.client-ip=209.85.167.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-55f6f7edf45so1220510e87.2;
        Thu, 04 Sep 2025 09:48:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757004486; x=1757609286; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aKlEsmb3gUg35aFO1hKP5pVn6VvRRI/bXaxmIEuQZoc=;
        b=BtOu0hc7Kl1F3b0NTYrscb8e92ZvTyX0pfs4IR1nzQBCuuDYCngR25YUSlyPyB/CkZ
         J5ZUn+c/Xal2eJGmY2nu8y+z21ANZKjo9b/UFqPLeEUrQZ0Qa6vtpSB+tQ1KDB/wlqmX
         Z62vH7BDApx8sSiKQA2jKGeXsuSHAB7fpPaASYYp8QwBRHsabYtTYXn2fEx5TWqIH5g3
         4/9vQqIfF9PMsI6AckHmlr3JAUGmwoT2Z0Z6Y7tuv6jAWrIAFKLBmf9wyXLBZPeV4/+a
         Wi8OJNkdEFFES+tI28iLwr+6RfCItTbQKvLkXWuq+sagEt/DQVO93vZ27PjRyWHjdN4s
         T+Fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757004486; x=1757609286;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aKlEsmb3gUg35aFO1hKP5pVn6VvRRI/bXaxmIEuQZoc=;
        b=Y27Ko9USRnCLd7jrrzMtNZJaFN2xFlJ08a7Va6gc0YtweLhP0ZduimyanKo69uxKtn
         qGw56cv9Ze8mJIPX+H7aOYrefFcEOyHs0S3FicrLTgScbbEAZLSU21ywdQ0hl0Ih9afT
         5xeIdu8Z03xk4sgu4xOhcO+J4jSmFnqLI0F2tX7nqqtndKmsBfQoZiN7Vj4GiQT4Wbqn
         gF20ACcQIf5tveFn/hJwnZc4Uoh+kmdHjUmoxy7srfopovKUMG7UjikYZJxo3k/UGjov
         Woyk7RvuU0ri678EIKpKejnXrSBYT4uxw/2KD/rU0uF7WYb/N+1JVAwHWvhnNF7wJOgp
         sSqQ==
X-Forwarded-Encrypted: i=1; AJvYcCWbLQ8QCrHkIRFbIC9LCj7dpWa2GXzSxpZcftB3usNlp8X/7+oy0fDro096oJIZLhgbB35S3xbHcSs=@vger.kernel.org, AJvYcCWfGu9mTMGlTGITeZLi6JMltY7VKmE+7lbpGSWt+Fsd3sBi9oPCWWdrplyInIf0tyLkhQ4FxfD0vjc7@vger.kernel.org, AJvYcCX6DKCmmQgTpPaH2aCCh3s51tOkgMk7tCGRSmxuGlvCE/Iw38Aiggr8Km9Vf7weBvLIg+dc900Te9hxJZ3p@vger.kernel.org, AJvYcCXSFEh/HBI6LwW6amDq5qQ1fGyjG759mEodPz+CuX3AaSGdJvZrX7GNGu192rlaVuK/cppufr3b2WpKl/0=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywxp55HWJPE4cuqAi3XwEKy7m/4NXC2wpHVrZsT7MuMoegrR/hA
	QDJ5oMPUZbIEflWx6YJ7tATea27hdlvpEuBy+pl8EZtat2FlezN8uU+wPXVfnSIylgI5egJCRw6
	ihIplS+rNYgwkj3/iC5orTUYDMMx+XYeY7RZLBWs=
X-Gm-Gg: ASbGnct3iuO4kRwnt31kOYaOhZqri3z/KRpBFt1KkHcUqBBdUeMjyWi/nzgNRxBfHTw
	ZJccCLwPyFPg6DBVkSQ8OREuUk9ifQtUjgceLksj6thwxfG0EOZueOpflEsfKs0Tq1/k5Oqgrx8
	yAXS5AwcjaBd11koDKusDJtHEvXJbCSeoevqXCFruYniicMaoZIw7/WxV6YCbwV8Kkr6MQmnZFa
	Wm4dhLby9GRZ+blBg==
X-Google-Smtp-Source: AGHT+IGUXtao2giLvBNZSYyvfOW6A0wh9AUywf97mYfCeIlRNIoyGOKR/Rj7+FNpDc7Jkh9xwe76uHDoyTmTZ8JcDDk=
X-Received: by 2002:a05:6512:680b:b0:55f:3f00:a830 with SMTP id
 2adb3069b0e04-55f709b63acmr5069075e87.57.1757004486276; Thu, 04 Sep 2025
 09:48:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250831-tegra186-icc-v1-0-607ddc53b507@gmail.com> <cfffcabd-c33b-46f9-9b16-b6063ceee4c1@nvidia.com>
In-Reply-To: <cfffcabd-c33b-46f9-9b16-b6063ceee4c1@nvidia.com>
From: Aaron Kling <webgeek1234@gmail.com>
Date: Thu, 4 Sep 2025 11:47:54 -0500
X-Gm-Features: Ac12FXwfngil2eotOy06lxex9b0oCj_6ZTJzvZJmC_5pOBeZGrM9F6XfwKF2Ucs
Message-ID: <CALHNRZ_-V+tQCy8k-fh7g1Q5QF6rWKtTBMK9F4Ah6M5KjaZf3g@mail.gmail.com>
Subject: Re: [PATCH 0/8] Support dynamic EMC frequency scaling on Tegra186/Tegra194
To: Sumit Gupta <sumitg@nvidia.com>
Cc: Krzysztof Kozlowski <krzk@kernel.org>, Rob Herring <robh@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Thierry Reding <thierry.reding@gmail.com>, Jonathan Hunter <jonathanh@nvidia.com>, 
	"Rafael J. Wysocki" <rafael@kernel.org>, Viresh Kumar <viresh.kumar@linaro.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, bbasu@nvidia.com, linux-kernel@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-tegra@vger.kernel.org, 
	linux-pm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 4, 2025 at 6:47=E2=80=AFAM Sumit Gupta <sumitg@nvidia.com> wrot=
e:
>
>
> On 01/09/25 09:03, Aaron Kling via B4 Relay wrote:
> > External email: Use caution opening links or attachments
> >
> >
> > This series borrows the concept used on Tegra234 to scale EMC based on
> > CPU frequency and applies it to Tegra186 and Tegra194. Except that the
> > bpmp on those archs does not support bandwidth manager, so the scaling
> > iteself is handled similar to how Tegra124 currently works.
> >
> > Signed-off-by: Aaron Kling <webgeek1234@gmail.com>
> > ---
>
> Tegra186/194 had multiple drivers for BWMGR, ISOMGR and LA+PTSA configs
> on the CPU side. I am not sure how effective this patch series will be
> in absence
> of those components. In Tegra234, those were moved to BPMP-FW. So, Kernel
> forwards the BW request to BPMP (R5) who takes care of setting the final
> freq.

I know it's not ideal, but it seems to be working okay as a rough
approximation. When the cpu governor kicks up the cpu freq, the emc
freq scales to match. In my testing, this has been enough to keep aosp
from obviously lagging. Existing drivers for earlier archs, such as
tegra124-emc, stub out LA+PTSA as well. Does the lack of that handling
make things worse for Tegra186/194 than it would for
Tegra124/Tegra210? I'm trying to improve things across all these archs
small pieces at time. In several of my recent series, I'm just trying
to get any form of load based dfs to work, so I don't have to keep
everything pegged to max frequency with the associated thermals and
power usage.

Aaron

