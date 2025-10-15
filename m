Return-Path: <linux-pm+bounces-36182-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id CB093BDE7AC
	for <lists+linux-pm@lfdr.de>; Wed, 15 Oct 2025 14:32:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 613D14FFBED
	for <lists+linux-pm@lfdr.de>; Wed, 15 Oct 2025 12:32:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1B2339FCE;
	Wed, 15 Oct 2025 12:31:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="V+ceJgAT"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EC337E0E4
	for <linux-pm@vger.kernel.org>; Wed, 15 Oct 2025 12:31:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760531517; cv=none; b=sMFq8ZqI7YkE3E9MOsaeHU/tmURWnRoRWi1vD5ZkGowaW+iut5JJbPvLKEuVLIFbzGa7bJFeyT9OJlcv5OakBrbUryPhmPQ2+MOVsIYCwy7/gagDhNr74usHo9SaRElw+fuCgUGwLeNsyIRo2GRl0/LMzBo7nn0BEfpgNAuUoqU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760531517; c=relaxed/simple;
	bh=Ds5tN1UgYbeLuv+voBo8qmhKTyrE2Us8S1vDEEh3mRc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uRX1KbIpf/spbB6S78u/V0ujcLaDhe/CKd+N0k6OgUrcHpjv0If9qfJ1XRNxwd1jrAmDFWT2sV/LKdeohqONnue9x441xKOxcfxQhtzd48Zp0p5ZtkW/IM3tdZfXpqr5ZXqRqTd5GHX4KcrHyVy7eq7dNr2DUUxo+zCWqkgLKAs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=V+ceJgAT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4A605C19425
	for <linux-pm@vger.kernel.org>; Wed, 15 Oct 2025 12:31:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760531517;
	bh=Ds5tN1UgYbeLuv+voBo8qmhKTyrE2Us8S1vDEEh3mRc=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=V+ceJgATycv2dcPg8aukzupgBj6hiyF82xtx/xXHAmQ7OAzNwwhYDFw13BQRqurFn
	 wt6KphkKf9GdzEuVA+d4Kf1bO9KprD0F8kAO34yuSfJMs7Ign18icenwKIbqIK5tZ8
	 tvd25w1Kn2vippSsoSbcy3LgHTpW6Wmh6TMQ/6qSBsSfODj3UXLaJux5Q+2TenSOSe
	 GDsPLheeh1X6FE/JVr2yL3G6A06lu+hWzdetbsW7/VRX+Jh8GTHB07gj0JEdk+S6PV
	 BpZ+rp9xhwuzYtg+RwEI2BbLrdyt6MF6PzW6fO3vxGYMVjBMjRKDILxf66USTJ0gRl
	 puQ8egtip6caw==
Received: by mail-oi1-f171.google.com with SMTP id 5614622812f47-43f5ec025d3so3138490b6e.1
        for <linux-pm@vger.kernel.org>; Wed, 15 Oct 2025 05:31:57 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVLWQC8Sr395JeSGaE38KMTKHAB8rss98qyOrh3oGPbfTzOYiRcU93GDCuM3O7/596/7AsIDaMdbg==@vger.kernel.org
X-Gm-Message-State: AOJu0YwRRAidg+5/MrD1qnL4nFzZTy4GqtZPMAidhTp1sp+lo2CCdb+q
	SlCDLsdnrrWyoNliSRZjNWoGC8uj8ujTS/6arpfyeXhKb3iD0ZXBvLi7uWdtYB4x0gvBdLTjQLN
	TFcPy58/diEw7Cf7B8PZW5CgiG7DCARw=
X-Google-Smtp-Source: AGHT+IFCWf7w81eYbGsWsAaAixXw9VKGwbQ6gP5dTyi4DiP0nYK4d0/SXD8oIGT6DGjz8WIu8OPi7YnvTwOjD4zro7A=
X-Received: by 2002:a05:6808:200f:b0:43c:afd4:646d with SMTP id
 5614622812f47-4417b36ff74mr13883499b6e.14.1760531516486; Wed, 15 Oct 2025
 05:31:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <36iykr223vmcfsoysexug6s274nq2oimcu55ybn6ww4il3g3cv@cohflgdbpnq7>
 <08529809-5ca1-4495-8160-15d8e85ad640@arm.com> <2zreguw4djctgcmvgticnm4dctcuja7yfnp3r6bxaqon3i2pxf@thee3p3qduoq>
 <8da42386-282e-4f97-af93-4715ae206361@arm.com> <nd64xabhbb53bbqoxsjkfvkmlpn5tkdlu3nb5ofwdhyauko35b@qv6in7biupgi>
 <49cf14a1-b96f-4413-a17e-599bc1c104cd@arm.com> <CAJZ5v0hGu-JdwR57cwKfB+a98Pv7e3y36X6xCo=PyGdD2hwkhQ@mail.gmail.com>
 <7ctfmyzpcogc5qug6u3jm2o32vy2ldo3ml5gsoxdm3gyr6l3fc@jo7inkr3otua>
In-Reply-To: <7ctfmyzpcogc5qug6u3jm2o32vy2ldo3ml5gsoxdm3gyr6l3fc@jo7inkr3otua>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Wed, 15 Oct 2025 14:31:45 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0ix7zdR0hJqN9OZPGp0oZMD_mzKU48HH1coqHTm7ucTDw@mail.gmail.com>
X-Gm-Features: AS18NWAYgH7eJ_Z6jWizwskkJNOvoxQftpz0yuYY6luTlZtoDjUyyg1fVOoplv8
Message-ID: <CAJZ5v0ix7zdR0hJqN9OZPGp0oZMD_mzKU48HH1coqHTm7ucTDw@mail.gmail.com>
Subject: Re: stable: commit "cpuidle: menu: Avoid discarding useful
 information" causes regressions
To: Sergey Senozhatsky <senozhatsky@chromium.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Christian Loehle <christian.loehle@arm.com>, 
	"Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Artem Bityutskiy <artem.bityutskiy@linux.intel.com>, Sasha Levin <sashal@kernel.org>, 
	Daniel Lezcano <daniel.lezcano@linaro.org>, linux-pm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Tomasz Figa <tfiga@chromium.org>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 15, 2025 at 3:30=E2=80=AFAM Sergey Senozhatsky
<senozhatsky@chromium.org> wrote:
>
> On (25/10/14 17:54), Rafael J. Wysocki wrote:
> > Sergey, can you please run the workload under turbostat on the base
> > 6.1.y and on 6.1.y with the problematic commit reverted and send the
> > turbostat output from both runs (note: turbostat needs to be run as
> > root)?
>
> Please find attached the turbostat logs for both cases.

Thanks!

First off, the CPUiD information reported by turbostat indicates that
the system is a Jasper Lake.  Is this correct?

Second, the overall picture I've got from the turbostat data indicates
that there is a correlation between Bzy_MHz and CPU%c7 (the more time
spent in C7, the higher the average "busy" frequency) which is
generally consistent with the hypothesis that using more C1 causes the
processor to drop the maximum frequency.

Something like this may be induced by RAPL power limits, presumably PL1.

Do you use thermald?

