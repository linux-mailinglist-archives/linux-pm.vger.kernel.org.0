Return-Path: <linux-pm+bounces-13900-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 109D3971F61
	for <lists+linux-pm@lfdr.de>; Mon,  9 Sep 2024 18:38:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 91D65288B50
	for <lists+linux-pm@lfdr.de>; Mon,  9 Sep 2024 16:38:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C654716A955;
	Mon,  9 Sep 2024 16:37:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QeDKCcdk"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E43E165F17;
	Mon,  9 Sep 2024 16:37:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725899878; cv=none; b=pHHOAloZ4vBvI2Iyp6a9goiCovNSt3Tt5xASc0LyamjYQB85GpA+9i5pMLJhDLuJx3gsDD2F9+4s8MDUyc7joqJLFRtiElGnc+enKqAPOfT9lfog8p/fbrYyorXb4LWR20O69JZ2gOv6lkod3a4HlAGLt2xqpDjdc7+2HSMRbSQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725899878; c=relaxed/simple;
	bh=S1Qm6BPgWOunHdvXSMLBaWuHO/At+FomiMoKcXHkOv8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FGImsF4QGtYazKtGI/AyMz1iorF3dUqGHade4EcPeOvzOCP0/rlqYaMDHZFEpBG9DFi8cmjrb+7hLDX1d3hKOMk4gfFo6F71og2xBve3U/+XALVmmYWZvQqzusqUOWEbdWGHoDbfWSXkZ8lL2IUP+1TNBRYwYW1Sm7dAHj0k9IU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QeDKCcdk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2092DC4CEC5;
	Mon,  9 Sep 2024 16:37:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725899878;
	bh=S1Qm6BPgWOunHdvXSMLBaWuHO/At+FomiMoKcXHkOv8=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=QeDKCcdkTHAxRi6IhDUphCs0uqhYJEmthgbg0MPIFy9gnqH4+fkaHZEU2v3nX/M/t
	 dzmFoloXbpTDzCTarEoU1lTe/suJNudcFOvmW9skuneoiTQQsIwX9+gB6U4vToYzyE
	 HWzd6kfmtDZDSKik9IsA/p0TappwXpH2Lr3GeW3pSx7Il0K3DmHobncCVi7/u/ZM7w
	 5sMRoV9TIVYaRf9ddC18c8VMSy5NVS6PSdSNT8L5ZNPx62BLXaTqJtVR6NE6AMDz0c
	 uPuVAISqG/5gR5sRiuchaxlD9gfxGocx3RddhI0cR5tr4XGn2ZVDkDBpwQpMnBBMHy
	 kIiH1oOiZJ08w==
Received: by mail-oi1-f169.google.com with SMTP id 5614622812f47-3df02c407e9so1552043b6e.1;
        Mon, 09 Sep 2024 09:37:58 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUV8lOAQo9Ih5tRjacJ6sgBqkHdIeYOfknbdnj2CMB1SndX5X5qMLJPyltYo7FDXafJTealjiiOfKA=@vger.kernel.org, AJvYcCV23+S05tClBI6zrnLEKpwfxWqEUZmstpEAPYTaaVv0WH7tAZj4tiytwWJiLvyU4zmEWJN+ZDFQuNhL5m4=@vger.kernel.org
X-Gm-Message-State: AOJu0YyWAH5/VEyezN13M/vBMiHk5QNracmD9HzqlyHc4DDqkaruit3X
	svjf3fYhNJrWRpA7BwqZtLw6iFmINDA6ySLRAELxtLxS+iSjpeyqoWJH+lGD3SW8tHuj+tdD5Lw
	4gRWtqwOwobjRxwLwFqs+IUT3mPY=
X-Google-Smtp-Source: AGHT+IHn4lH8SFxSj4C1XA47XQwNhlimHsawiAAO6K1+MJ0hTobUS6/qW/LTK2QnXtLd6O9vL0qZ9TF85nxppsn8RoQ=
X-Received: by 2002:a05:6808:1506:b0:3df:1ce7:d31e with SMTP id
 5614622812f47-3e04e2c205bmr96137b6e.15.1725899877427; Mon, 09 Sep 2024
 09:37:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <a9d9f0ec-1744-4543-a190-138facf8c552@kernel.org>
In-Reply-To: <a9d9f0ec-1744-4543-a190-138facf8c552@kernel.org>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Mon, 9 Sep 2024 18:37:42 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0iJgLR6Onb8nNRpNoXk09U3qWG4=xNYbCa3JJsTnENVDg@mail.gmail.com>
Message-ID: <CAJZ5v0iJgLR6Onb8nNRpNoXk09U3qWG4=xNYbCa3JJsTnENVDg@mail.gmail.com>
Subject: Re: GIT PULL] devfreq next for 6.12
To: Chanwoo Choi <chanwoo@kernel.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, 
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, 
	"open list:DEVICE FREQUENCY (DEVFREQ)" <linux-pm@vger.kernel.org>, Kyungmin Park <kyungmin.park@samsung.com>, 
	MyungJoo Ham <myungjoo.ham@samsung.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Chanwoo,

On Sun, Sep 8, 2024 at 4:42=E2=80=AFPM Chanwoo Choi <chanwoo@kernel.org> wr=
ote:
>
> Dear Rafael,
>
> This is devfreq-next pull request for v6.12. I add detailed description o=
f
> this pull request on the following tag. Please pull devfreq with
> following updates.
>
> Best Regards,
> Chanwoo Choi
>
> The following changes since commit 431c1646e1f86b949fa3685efc50b660a364c2=
b6:
>
>   Linux 6.11-rc6 (2024-09-01 19:46:02 +1200)
>
> are available in the Git repository at:
>
>   git://git.kernel.org/pub/scm/linux/kernel/git/chanwoo/linux.git tags/de=
vfreq-next-for-6.12
>
> for you to fetch changes up to d47552124bb0b9527da7a95357ae7d2e6046c4f6:
>
>   PM / devfreq: imx-bus: Use of_property_present() (2024-09-05 01:23:56 +=
0900)
>
> ----------------------------------------------------------------
> Update devfreq next for v6.12
>
> Detailed description for this pull request:
> - Add missing MODULE_DESCRIPTION() macros for devfreq governors.
> - Use Use devm_clk_get_enabled() helpers for exyns-bus devfreq driver.
> - Use of_property_present() instead of of_get_property() for imx-bus devf=
req driver.
> ----------------------------------------------------------------
> Anand Moon (1):
>       PM / devfreq: exynos: Use Use devm_clk_get_enabled() helpers
>
> Jeff Johnson (1):
>       PM/devfreq: governor: add missing MODULE_DESCRIPTION() macros
>
> Rob Herring (Arm) (1):
>       PM / devfreq: imx-bus: Use of_property_present()
>
>  drivers/devfreq/exynos-bus.c              | 22 +++++-----------------
>  drivers/devfreq/governor_performance.c    |  1 +
>  drivers/devfreq/governor_powersave.c      |  1 +
>  drivers/devfreq/governor_simpleondemand.c |  1 +
>  drivers/devfreq/governor_userspace.c      |  1 +
>  drivers/devfreq/imx-bus.c                 |  2 +-
>  6 files changed, 10 insertions(+), 18 deletions(-)

Pulled and added to the linux-next branch in linux-pm.git, thanks!

