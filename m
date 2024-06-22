Return-Path: <linux-pm+bounces-9805-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C3BC39133CE
	for <lists+linux-pm@lfdr.de>; Sat, 22 Jun 2024 14:14:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7B2602838E1
	for <lists+linux-pm@lfdr.de>; Sat, 22 Jun 2024 12:14:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DBD2155CB0;
	Sat, 22 Jun 2024 12:14:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aOZtWY7G"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5226C5A788;
	Sat, 22 Jun 2024 12:14:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719058453; cv=none; b=K1HH2y46KaE9TdoOI0nAJNjpyIL/2tj9ztpmwS+npPWrEwQRk7r2KRY2lIXO3tj6BW0XjszmwfX1Oyku5444xchsZ/8lT7IuNDtvn8eUcxRMgpHRUvaT7/g5Iskjh27SP3lsjzUBA1gQ9zbFzXaLy/MzJ3b2EYQF1nWydXTI9hs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719058453; c=relaxed/simple;
	bh=nFEar/H1ZN1/zWunnaOalNbemcRjdkiL5as3UcmGtFI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=X52Wh+K7JsLwFe6Mly27aOlp3HPWAE06io1T6iHgKgXDoMq8p+JxjZ+j9kj37USATbbXx7KXX6eil99XRjPyjVT9/aPGjVHbU+NlLUvr5wUprLaOcc4AtCKY+HOvkLqIa2PnA25I4BGmQmwni/HD1oCA3L3XqFngM84sGPJl7Ns=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aOZtWY7G; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DAC06C4AF09;
	Sat, 22 Jun 2024 12:14:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719058452;
	bh=nFEar/H1ZN1/zWunnaOalNbemcRjdkiL5as3UcmGtFI=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=aOZtWY7GW9bc6Vt/vYB0Lml/d2QqA1Z3p7jgrjElL5OX3gJFjTRlADHDhWcWfNF5a
	 2GBV/9BRee2cX3jg6Hl/mJOdpruGMhvoyzVd36oZQJCOQzcJziOeKUBZqYBdoEW7xU
	 kTlT/DLFXiCW2kh/xGEUvvwGgLxWinj1rh/TiZBaGLXwr115gLvk3uYcn/K2k83+LE
	 RKC5/VZEVMXuWlKrDWSGM0DxKkVQ9OJc1tUGZRIWCbxSmYqw0bjZuHz7vLHjN5pPvt
	 /uOR1JB+tfKl9KwKurdnA7B335vh0DpufJznEsQIYZwlWKimNivjXLqZx553EFdVUl
	 t/ZnyDt8W5o4A==
Received: by mail-oa1-f43.google.com with SMTP id 586e51a60fabf-25075f3f472so222473fac.2;
        Sat, 22 Jun 2024 05:14:12 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVfYy/rd4WMTSdTaQ3r7nbBwkyL4MnN6+Qpqv74aEBDd11wUh7xNpfDY8/vTFBMpiBw1c/yFzhfcISl8e4JVAXr2VlcwU6j1xS+X8XU/Y2rxUxcPh6Z36fkItWp3gK/8pIDJkZwoI8=
X-Gm-Message-State: AOJu0Yyb/LgvG2TCjg+Mi77aupsYmywHoV70csJ3s/xc6PQPnRpS8/xY
	JQu4iopkDwmjG/LiclkT0Xr/oxpXHHchZlPfaTX2mkZ4WQTYxIlPoJ71HM54uEezKzeUWormo9t
	gE2WPA5hh0owduUXxA0oZS+uueBE=
X-Google-Smtp-Source: AGHT+IHvA+SR2Z7SVdXSx9hYFsGw9jTjmAxSyobABFDy0S4RJi6b0EZdjQedUoq2HUUGcjMfIpxuxuwoSnv7FIOc3Gg=
X-Received: by 2002:a05:6870:b623:b0:254:affe:5a08 with SMTP id
 586e51a60fabf-25cf000314bmr1872394fac.2.1719058452151; Sat, 22 Jun 2024
 05:14:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <ZmVfcEOxmjUHZTSX@hovoldconsulting.com> <CAJZ5v0gVnjVyd_O6KgXy2sXr3b3M3vyTLyUCasyxP0GrAXro4Q@mail.gmail.com>
 <CAJZ5v0iz7gwhpvT53CH0ZEA_q3U=dnn6XR8HdLk6LpP3ye4Zkg@mail.gmail.com>
 <6759ce9f-281d-4fcd-bb4c-b784a1cc5f6e@oldschoolsolutions.biz>
 <CAJZ5v0gueSnaci601OkVq9_Ui09k8EsByRL08tFkzDoDGJpp6g@mail.gmail.com> <ebb02ff6-e0d3-45d0-b78e-7785d763e01b@oldschoolsolutions.biz>
In-Reply-To: <ebb02ff6-e0d3-45d0-b78e-7785d763e01b@oldschoolsolutions.biz>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Sat, 22 Jun 2024 14:14:00 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0jLdvFO3h9AbWpuZzn3r3RgrWbN4jnvAq-p73AF9Z4a8w@mail.gmail.com>
Message-ID: <CAJZ5v0jLdvFO3h9AbWpuZzn3r3RgrWbN4jnvAq-p73AF9Z4a8w@mail.gmail.com>
Subject: Re: cpufreq/thermal regression in 6.10
To: Jens Glathe <jens.glathe@oldschoolsolutions.biz>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Johan Hovold <johan@kernel.org>, 
	"Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Daniel Lezcano <daniel.lezcano@linaro.org>, 
	Viresh Kumar <viresh.kumar@linaro.org>, Zhang Rui <rui.zhang@intel.com>, 
	Lukasz Luba <lukasz.luba@arm.com>, Steev Klimaszewski <steev@kali.org>, linux-pm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, regressions@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 21, 2024 at 10:00=E2=80=AFPM Jens Glathe
<jens.glathe@oldschoolsolutions.biz> wrote:
>
> Hi there,
>
> thank you for the fast fix. Applied, built, installed. Test is
> successful, performance core scaling up to 2995200 comes back when skin
> temp drops below 55=C2=B0C.
>
> Tested-by: Jens Glathe <jens.glathe@oldschoolsolutions.biz>

Great, thanks for testing!

I'll submit the patch shortly and it would be good if the others
affected by this issue could try it to confirm that it doesn't regress
anything.


> On 6/21/24 18:41, Rafael J. Wysocki wrote:
> > Hi,
> >
> > On Fri, Jun 21, 2024 at 5:53=E2=80=AFPM Jens Glathe
> > <jens.glathe@oldschoolsolutions.biz> wrote:
> >> Hi there,
> >>
> >> unfortunately I experienced the issue with the fix applied. I had to
> >> revert this and  the original commit to get back to normal behaviour. =
My
> >> system (also Lenovo Thinkpad X13s) uses the schedutil governor, the
> >> behaviour is as described from Steev and Johan. The full throttling
> >> happened during a package build and left the performance cores at 9408=
00.
> > So can you please test the attached patch, on top of the fix?
>

