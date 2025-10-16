Return-Path: <linux-pm+bounces-36238-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id D38FFBE2ACF
	for <lists+linux-pm@lfdr.de>; Thu, 16 Oct 2025 12:12:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id DFDF25042F9
	for <lists+linux-pm@lfdr.de>; Thu, 16 Oct 2025 10:10:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07D1332D7D5;
	Thu, 16 Oct 2025 10:06:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="c2YzU8pK"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D668C319611
	for <linux-pm@vger.kernel.org>; Thu, 16 Oct 2025 10:06:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760609173; cv=none; b=umLoOaswb9TCrwrnKHqsZXiYRXjmp8KUdW+bTGffic+d3/cPdEfKnrvH/l+iMzjgQI2mef01sG/FHp7nN64CXBoy7SXDK6Pli4Yx6f1y+XKHR7gwN9xA7y4859BpsAZ5JU5eeEdd/a7zhM1jmH41DRvYlRjee1V4bB5n4JMoPRA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760609173; c=relaxed/simple;
	bh=0bN7P+gtpbAg1qEU7iDnh8GWbGACYzseXtB9zCSy3tM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jhtZ3E+oyu84TdEkEtlNJap0N90/dKCNrjIusO5nty9O1w9rWpSXe2cznSt+aNQjtSqid3HVFR5/o9XthhCQT+5FQiTBOW95w9TFcBnuteMEmC/a3kbZsqCumr5vpL2VRH6BrLg0Tm4TeyhSjZemXSGfhwJ4rjsxkYFpnp0Mw0U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=c2YzU8pK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4D686C4AF09
	for <linux-pm@vger.kernel.org>; Thu, 16 Oct 2025 10:06:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760609170;
	bh=0bN7P+gtpbAg1qEU7iDnh8GWbGACYzseXtB9zCSy3tM=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=c2YzU8pKwKpCZ7OkJZmRM1/0XGCmpM9sf812vOMN4oJC/fLuRYG5wfHfxFru3UkvA
	 ld9DlOU+vEXG/gVr7rvOwRVq8cBHMLu9jSnl8xEU82HdPkaliVzH/jvFN0ady/YbZT
	 1hIhtZcOIjeElT2D+CF9teDnaYKqnWi6EaiTF3/i8jdONENCP/9U/B+PYcPJV2ncyJ
	 kcSTKzjFl1JFDQoHuURhHGLnZ3oAufPVnaHDahs1M01DEcacWae9Qwb+GYHAElpwUL
	 4jkuVnHhqxSLUyGafps7+O+TDj06J9Z/y+5PIRq2xHPLUg/rmZyfvbEOm//re7Tuv5
	 /iA2yUmpovYCA==
Received: by mail-oi1-f182.google.com with SMTP id 5614622812f47-43f715b18caso301829b6e.2
        for <linux-pm@vger.kernel.org>; Thu, 16 Oct 2025 03:06:10 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXn7WQxU8hu5G1ZPgGiJCkh4PeMSK1ymsemVu+TfrFeSrV2WdElF2uIWAamjI3tFvRnvuxI+J1+8A==@vger.kernel.org
X-Gm-Message-State: AOJu0YzwYIFAOWEmbrY8EXFz+WHt+CdandKIaYmEOBF5LRxx6kLmsE5p
	mKw9nrtSv2MQ13TCG7CSgi6hKnROuzyXJ+KWwwRzm5OGqW3Ix5KTSw+BU+3eutIOa5nDecQIhWm
	O6LdRFH1cBjyfxu74pAG5H8Vek4imJBI=
X-Google-Smtp-Source: AGHT+IHfgDy+V/bvWWn9Fgz/trJVQRilHVaPhAXQ7+cCwduGIusWo/bnfDCrPq1eBxIcfcjZxfUu3pVX2vqrifOY8fI=
X-Received: by 2002:a05:6808:d4a:b0:441:8f74:fad with SMTP id
 5614622812f47-4418f74207dmr14024408b6e.58.1760609169586; Thu, 16 Oct 2025
 03:06:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <8da42386-282e-4f97-af93-4715ae206361@arm.com> <nd64xabhbb53bbqoxsjkfvkmlpn5tkdlu3nb5ofwdhyauko35b@qv6in7biupgi>
 <49cf14a1-b96f-4413-a17e-599bc1c104cd@arm.com> <CAJZ5v0hGu-JdwR57cwKfB+a98Pv7e3y36X6xCo=PyGdD2hwkhQ@mail.gmail.com>
 <7ctfmyzpcogc5qug6u3jm2o32vy2ldo3ml5gsoxdm3gyr6l3fc@jo7inkr3otua>
 <001601dc3d85$933dd540$b9b97fc0$@telus.net> <sw4p2hk4ofyyz3ncnwi3qs36yc2leailqmal5kksozodkak2ju@wfpqlwep7aid>
 <001601dc3ddd$a19f9850$e4dec8f0$@telus.net> <ewahdjfgiog4onnrd2i4vg4ucbrchesrkksrqqpr7apyy6b76p@uznmxhbcwctw>
 <CAJZ5v0inu-Ty-hh0owS0z0Q+d1Ck7KUR_kHQvUCVOc1SZFqyjw@mail.gmail.com> <ytv4w7uw23fwdkihbgrpegmco6yzkxmzjbakmxtricreou6p6k@rhwxcjq3jvnv>
In-Reply-To: <ytv4w7uw23fwdkihbgrpegmco6yzkxmzjbakmxtricreou6p6k@rhwxcjq3jvnv>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Thu, 16 Oct 2025 12:05:58 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0ii-pBMj2aQmH8no920wb_XO7ReOVQmy+V=CozmFm8HfA@mail.gmail.com>
X-Gm-Features: AS18NWAfKXsVHMgRaJMtGIOc7V03yC_KT5OmPpvqxdp79_xFs9amUoBgdY_JNMs
Message-ID: <CAJZ5v0ii-pBMj2aQmH8no920wb_XO7ReOVQmy+V=CozmFm8HfA@mail.gmail.com>
Subject: Re: stable: commit "cpuidle: menu: Avoid discarding useful
 information" causes regressions
To: Sergey Senozhatsky <senozhatsky@chromium.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Doug Smythies <dsmythies@telus.net>, 
	Christian Loehle <christian.loehle@arm.com>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Artem Bityutskiy <artem.bityutskiy@linux.intel.com>, Sasha Levin <sashal@kernel.org>, 
	Daniel Lezcano <daniel.lezcano@linaro.org>, linux-pm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Tomasz Figa <tfiga@chromium.org>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 16, 2025 at 12:00=E2=80=AFPM Sergey Senozhatsky
<senozhatsky@chromium.org> wrote:
>
> On (25/10/16 11:48), Rafael J. Wysocki wrote:
> > All right, let's see what RAPL on that system has to say.
> >
> > Please send the output of "grep .
> > /sys/class/powercap/intel-rapl/intel-rapl:0/constraint_*"
>
> /sys/class/powercap/intel-rapl/intel-rapl:0/constraint_0_max_power_uw:600=
0000
> /sys/class/powercap/intel-rapl/intel-rapl:0/constraint_0_name:long_term
> /sys/class/powercap/intel-rapl/intel-rapl:0/constraint_0_power_limit_uw:6=
000000
> /sys/class/powercap/intel-rapl/intel-rapl:0/constraint_0_time_window_us:2=
7983872
> /sys/class/powercap/intel-rapl/intel-rapl:0/constraint_1_max_power_uw:0
> /sys/class/powercap/intel-rapl/intel-rapl:0/constraint_1_name:short_term
> /sys/class/powercap/intel-rapl/intel-rapl:0/constraint_1_power_limit_uw:1=
2000000
> /sys/class/powercap/intel-rapl/intel-rapl:0/constraint_1_time_window_us:9=
76

This looks reasonable, so I'd rather not recommend playing with it.

