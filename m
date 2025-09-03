Return-Path: <linux-pm+bounces-33682-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AE96BB4154B
	for <lists+linux-pm@lfdr.de>; Wed,  3 Sep 2025 08:38:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 527CF7A3F1F
	for <lists+linux-pm@lfdr.de>; Wed,  3 Sep 2025 06:36:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B14A2D7DFF;
	Wed,  3 Sep 2025 06:38:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="G81cDyZV"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com [209.85.167.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CFC42D6619;
	Wed,  3 Sep 2025 06:38:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756881485; cv=none; b=TZZ8QKtwArLNl5Zrs178a8geYVeaJLggBADIx+d4ZdZDQoMoJkIxmvwdOj2hdHgq6cj1BZ+I7loqxdrd5WXPRSS03hCz/UzpPjpJ5BA1WeBV+vVCu6SjcHYcLYvuhwtWhXLxCSnRYU4tEQ8vnS/ygRMBoSAdqmpSlarfeCCf7Qg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756881485; c=relaxed/simple;
	bh=Y3pUz7puYZn5vXM93xO5pLAOnHGGSS5XPsbzEiZNtpA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lBYsCkCEg2NeX/TSywkNzvmUZL6m9LlYpYX62vTZU1U48n0CDL3+MQNeU6q/xbTvlT+i5LVpFkiIU0DdeBwrkQfolo/NzKq5GBiLeRK+GW5xO06DYmVunjB+xHnltqI9gvl/tvh/q7rMuGwPVe8r7NBvnOT7cT61owJnz56cgNc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=G81cDyZV; arc=none smtp.client-ip=209.85.167.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-55ce508d4d6so5346016e87.0;
        Tue, 02 Sep 2025 23:38:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756881481; x=1757486281; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Y3pUz7puYZn5vXM93xO5pLAOnHGGSS5XPsbzEiZNtpA=;
        b=G81cDyZVVF6DDyHzmSLW6dPEMDnjNHlCzYjvw3nCtETKFT7D3cB5SdXBPAjNhwmHr4
         SmycHL8fXgXL/t2ogjvJ2NouauExLFecN2onC6G5Kjca2Pigtx8EZD8B8xWH6kxRTiW/
         ozWs8hujTb7eUfHD62Gf7LX6mCdNgIzD2h2XxhTeJCN4f704qqek4gzV00CypYFnWlD+
         eFgouHNbspsWbrY/kMElYaODuVYvwwzLHMmR8fTnPSz5CkxAZvUBxKZoJb1ZSsJd4Ioi
         gGM16q79ed78VzAhgvIhMwhR6a+3dIjuyK4ecL0g2G8dqxO5UzQPoandYoNcYCvFDKBs
         v8fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756881481; x=1757486281;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Y3pUz7puYZn5vXM93xO5pLAOnHGGSS5XPsbzEiZNtpA=;
        b=lKzMm8rbffeRAZ7LMU33amRd3F8pHjRTUZB6aLfXGKyl9ZMX29Nk9AGC7fs9Ukd3TK
         DFNyd2B7t1FKi/xcHjcqNswQknt++tB7q/xwOc13tAomB+g20FKbYXQaJQLFRrpOQLhN
         J3/xz1vQHcBzQ4H+ITqm3Z9NeB+ViivRm9Z7V6yCFgZ582ryBNjOp75hagfUtaiaEbX4
         o27BZEpKSImXfxJy7C8w8FeZo7/3uMxoH8DNNGlgd4TmvF6LyL5jRi25BCDxCcfIzIFY
         fW9sd6NMpEpUHNxr73CEfEBLKOHzBUN+pYqbL+neFygHIvQP1dQiNszKMyAcboRZAyM8
         1RLw==
X-Forwarded-Encrypted: i=1; AJvYcCUF3GMFoeV1GMBlGRinjAngzSxxzEfsJHrKF14Hpz1Rkr3nlet5oWcNnV4Y+ytpoB7pFa63q8og2os=@vger.kernel.org, AJvYcCUJWm/KWBY6XKbb7hvXWW7hx/R+uc0PCFP8xT0j9ha4bYEuqr1NSHdbxyaRidmcxkbysU2fK1ppmhmSb1sQ@vger.kernel.org, AJvYcCWpxLkEXON6Vc9Rc/ZE10N3L0fW/xxjeQTHYtZWlBKhpUR4tYpq8EGoVFU6AdZdIN6hqOItNOOm6OJ3@vger.kernel.org, AJvYcCXVwD4bAqQOBqT4SVDGUOUDjwcyVhJFMVarnVc+pSakOWP47Jyj3+mYqFp2ss3Ue44JYr2fA2gONZhuClw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzCgqvARrYYTO02jzfly38ldEqofZzxltnybRZ4OJ6J1AO0srnp
	H45HZIyQOAvLJgOkle+Wilub0rgDZyuA/I7s3lTvPSn1Z38/KZCQSsEmib8XU9v+3SaNYSG2ntS
	r+i8p+j4rygBTKLeQWB7Z2KhJ8CdeEhQ=
X-Gm-Gg: ASbGncsv9Ac9TlOO6LN0DaAjOckZlHBeXKksi/CngwPXflv7fii6hI6jwt8i96+AtZ+
	e6BlqDGbHv7YxbYXK0XJUsmmo5jNBmlqimamc83SYkgNGR3kKJzfRy79CpnW2FluceXtEJ8eAVt
	1yihbfst++qAiWgVf9JBCmHcB/eZs+znwLLdvcoF4nUev76HITEy2bbDu7yaS7QdAw5v5UV3V4C
	NRcpE4=
X-Google-Smtp-Source: AGHT+IEKN1+Lo8NnZYYjlzo3GJdkc2hqMBm+pjTMN94tnkzpUdXiZXD7skj3kXNaFycPRD8IBRiVfkIOZmqvy5QnNvg=
X-Received: by 2002:ac2:5684:0:b0:55f:4b01:30a6 with SMTP id
 2adb3069b0e04-55f70567c5fmr4843024e87.0.1756881481254; Tue, 02 Sep 2025
 23:38:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250831-tegra186-icc-v1-0-607ddc53b507@gmail.com>
 <20250902-glittering-toucan-of-feminism-95fd9f@kuoka> <CALHNRZ_CNvq_srzBZytrO6ZReg81Z6g_-Sa+=26kBEHx_c8WQA@mail.gmail.com>
 <47c7adc9-fa91-4d4e-9be4-912623c627d6@kernel.org>
In-Reply-To: <47c7adc9-fa91-4d4e-9be4-912623c627d6@kernel.org>
From: Aaron Kling <webgeek1234@gmail.com>
Date: Wed, 3 Sep 2025 01:37:49 -0500
X-Gm-Features: Ac12FXwnaVPc4M4VY-Ad8pNcphh6y4N-9lCi0_sBFEyFmOaMAtL952A2F-i6i6U
Message-ID: <CALHNRZ8rxyRvb1GCifeXRKjPkkBE+sK6VnPc2nS01iZV_NcjaQ@mail.gmail.com>
Subject: Re: [PATCH 0/8] Support dynamic EMC frequency scaling on Tegra186/Tegra194
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Rob Herring <robh@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Thierry Reding <thierry.reding@gmail.com>, Jonathan Hunter <jonathanh@nvidia.com>, 
	"Rafael J. Wysocki" <rafael@kernel.org>, Viresh Kumar <viresh.kumar@linaro.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, linux-kernel@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-tegra@vger.kernel.org, 
	linux-pm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 3, 2025 at 1:20=E2=80=AFAM Krzysztof Kozlowski <krzk@kernel.org=
> wrote:
>
> On 02/09/2025 18:51, Aaron Kling wrote:
> > On Tue, Sep 2, 2025 at 3:23=E2=80=AFAM Krzysztof Kozlowski <krzk@kernel=
.org> wrote:
> >>
> >> On Sun, Aug 31, 2025 at 10:33:48PM -0500, Aaron Kling wrote:
> >>> This series borrows the concept used on Tegra234 to scale EMC based o=
n
> >>> CPU frequency and applies it to Tegra186 and Tegra194. Except that th=
e
> >>> bpmp on those archs does not support bandwidth manager, so the scalin=
g
> >>> iteself is handled similar to how Tegra124 currently works.
> >>>
> >>
> >> Three different subsystems and no single explanation of dependencies a=
nd
> >> how this can be merged.
> >
> > The only cross-subsystem hard dependency is that patches 5 and 6 need
> > patches 1 and 2 respectively. Patch 5 logically needs patch 3 to
> > operate as expected, but there should not be compile compile or probe
> > failures if those are out of order. How would you expect this to be
> > presented in a cover letter?
>
> Also, placing cpufreq patch between two memory controller patches means
> you really make it more difficult to apply it for the maintainers.
> Really, think thoroughly how this patchset is supposed to be read.

This is making me more confused. My understanding was that a series
like this that has binding, driver, and dt changes would flow like
that: all bindings first, all driver changes in the middle, and all dt
changes last. Are you suggesting that this should be: cpufreq driver
-> bindings -> memory drivers -> dt? Are the bindings supposed to be
pulled with the driver changes? I had understood those to be managed
separately.

Aaron

