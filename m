Return-Path: <linux-pm+bounces-27471-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A793ABFE84
	for <lists+linux-pm@lfdr.de>; Wed, 21 May 2025 22:54:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8041B1689D6
	for <lists+linux-pm@lfdr.de>; Wed, 21 May 2025 20:54:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89C5F2C0303;
	Wed, 21 May 2025 20:49:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CeCANrss"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DB782BEC5B;
	Wed, 21 May 2025 20:49:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747860553; cv=none; b=OAIOi+mimEmF9HDVnasfMh4dwaP2hzI4sBMjfVYDj4xRpOVVXLOelYOQRNd3sjtWebV9ayuPIsY94lYA11d5Pk92XjMFdyYe2SeHh8ThkA0erIifmCAjq4pIZFgTWWpxrKSxXSxnZXgyX+jvjq/RuDJIeP8L71v6idQ+30sz3ns=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747860553; c=relaxed/simple;
	bh=mrTRctOtUcJ84jXnO+310QFcU1Kwrn6jVHOd5Jr/N04=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=eJCiJAFTGnHFDqIFJpXA0Ilx3EiWfP9Gp06i3ghUGK7dQt3GLiCHOc7U1DRjPCatNTnhJcHhhb0seGQ6+eLykQDsO1SJMFNiI1ywmggySC3o5t2pzOOOyhsxmPAIWK//n95Ep8mQNKwZvCJkKvme1u0Sew1umx/WPB9UqgzG/c0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CeCANrss; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3A2B8C4CEEF;
	Wed, 21 May 2025 20:49:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747860553;
	bh=mrTRctOtUcJ84jXnO+310QFcU1Kwrn6jVHOd5Jr/N04=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=CeCANrss13lMVCYBd303dahYRRcP3//oNIADAYeh5uCMFUZtTRhayH/Co0HajWv+D
	 u6iAXUucctnfWL5Hrl1fH0TmHgSt4WGZZhYenvzWRjJcDHtTvnUEG0Hi/CgxiJM3Rt
	 vno4OZKrpdmnKVQwYINlqMII4GBp/Nm8PWGMp2tHeyUnjoYuQfIFcqe/hPp4LIeG6V
	 psd8XVvba1B8XaNtK2/C1dzv2+y1/p9FT+pRyAhQOm4SagJAqv6Sz53LVgonXvoNuA
	 GvWAN/nGbGb01WHJaZCBMHtcVDZxYoaHfMJXc9n3WbWajoGT/HUpe8zG8ej/ReE+IM
	 1JhWbuYa0YJyg==
Received: by mail-oo1-f48.google.com with SMTP id 006d021491bc7-6060167af73so4591752eaf.2;
        Wed, 21 May 2025 13:49:13 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWtwlr9xGdnwJAn7MeGWZ+wPbriWqWdGbHav3CyWzfxS/ns8OoVL/eD3MxmfS7vEtjCE9pLt46jgM+213Y=@vger.kernel.org, AJvYcCXbaelE+1qFHiew9/NUr119HSJ7hyY0j2V/7C9CyeUFTIlIS1k94tfxlsd134YMsFnWtn//TBakDG8=@vger.kernel.org, AJvYcCXcrUHgrGM7mb7+YNpaesMas4DI2Xf7rghg5xJiI0Juu3Ld+XXiShBcFJ6VCsJY47fnZbk0X+PhW1oqm2Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YzR+pJNdTVxc/hfBZ7F1QXmopVj/rPp3yOetdT166IHvixqV6MK
	qft2qw0s45yd6/0Ow4LeURHOBAAIifcQXKww0y9jXmU3MXXIo6GqTqMsz6zCgchntmPdjyJ+G0X
	DdbAFxxkgfGyypJexDTs/SGWuch7T25s=
X-Google-Smtp-Source: AGHT+IEPkrPQfl18bWldZIboDlU0gNEGDMtQpM0dlHeO2zo12vGpxSU7I22tRnNIM6pQuZZbb4xC4aKhvh+4ma/DDkI=
X-Received: by 2002:a05:6820:1b09:b0:606:9ed9:c38 with SMTP id
 006d021491bc7-609f3615b68mr14252127eaf.0.1747860552552; Wed, 21 May 2025
 13:49:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250507031941.2812701-1-zhenglifeng1@huawei.com>
 <98c87824-2c77-4ae3-b466-badd8e8187ad@nvidia.com> <20250521104831.6a3qfhzrwf2mcnyu@vireshk-i7>
In-Reply-To: <20250521104831.6a3qfhzrwf2mcnyu@vireshk-i7>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Wed, 21 May 2025 22:49:01 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0jtar_refDoYQ0vFm1pWGu-DmFTaoHH-Rv+vGBvuMnL2g@mail.gmail.com>
X-Gm-Features: AX0GCFtWB6FomTG9jILgelbT-29sCuyvYJpoU4Cz84DNwUvy6rzN3Xu2B_ybQQE
Message-ID: <CAJZ5v0jtar_refDoYQ0vFm1pWGu-DmFTaoHH-Rv+vGBvuMnL2g@mail.gmail.com>
Subject: Re: [PATCH] cpufreq: CPPC: Support for autonomous selection in cppc_cpufreq
To: Viresh Kumar <viresh.kumar@linaro.org>, Lifeng Zheng <zhenglifeng1@huawei.com>
Cc: Sumit Gupta <sumitg@nvidia.com>, pierre.gondois@arm.com, linux-kernel@vger.kernel.org, 
	linux-pm@vger.kernel.org, linuxarm@huawei.com, mario.limonciello@amd.com, 
	yumpusamongus@gmail.com, srinivas.pandruvada@linux.intel.com, 
	jonathan.cameron@huawei.com, zhanjie9@hisilicon.com, lihuisong@huawei.com, 
	cenxinghai@h-partners.com, yubowen8@huawei.com, hepeng68@huawei.com, 
	linux-tegra <linux-tegra@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, May 21, 2025 at 12:48=E2=80=AFPM Viresh Kumar <viresh.kumar@linaro.=
org> wrote:
>
> On 21-05-25, 16:13, Sumit Gupta wrote:
> >
> >
> > On 07/05/25 08:49, Lifeng Zheng wrote:
> > > External email: Use caution opening links or attachments
> > >
> > >
> > > Add sysfs interfaces for CPPC autonomous selection in the cppc_cpufre=
q
> > > driver.
> > >
> > > Signed-off-by: Lifeng Zheng <zhenglifeng1@huawei.com>
> >
> > Looks good to me.
> >
> > Reviewed-by: Sumit Gupta <sumitg@nvidia.com>
>
> Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
>
> Rafael, since I have already sent the pull request, can you please
> take it directly ? Thanks.

Done, thanks!

