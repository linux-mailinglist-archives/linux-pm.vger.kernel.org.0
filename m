Return-Path: <linux-pm+bounces-30031-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 540F1AF71D8
	for <lists+linux-pm@lfdr.de>; Thu,  3 Jul 2025 13:13:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EAE9F482516
	for <lists+linux-pm@lfdr.de>; Thu,  3 Jul 2025 11:12:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 018CB1FBCAE;
	Thu,  3 Jul 2025 11:12:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="k1Wd59UB"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDFF872632;
	Thu,  3 Jul 2025 11:12:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751541148; cv=none; b=mCudIEZraeKNjKDezrd0Qj6EC5B6sqMzwzAUQcL1TZBFR2QmLxhgGrE98MPVu2HIsZeXPQaIoC59zoxw7LIa8G+G9u33tptMDC0JeMOyhZz1HtfE4t4C6XwepbmSN2JHafkXU9b/rwCuhjYyJxTi4WA6tx6ZRRpoi7z6/pBaIaU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751541148; c=relaxed/simple;
	bh=x1H/LJVni2QpyNRLeOu5Y609wueVH5cmiPU/fiF5jBo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Bwn6tPEEMHiBm3EyLTwkrqL5oKFH6T2YJd4EZkIkpAUO4QyP0XOF75K3hGmOnQb+kfiJL82Cr7il507u5dDzbSF+StyR5vy+cLA8hN+Dq9hka2vA/gNVpZvuPisQoL8RALl8c0FqIQSzbpwMpExyeOI/OrEt5bryX8PrhpLC4fU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=k1Wd59UB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 69029C4CEE3;
	Thu,  3 Jul 2025 11:12:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751541148;
	bh=x1H/LJVni2QpyNRLeOu5Y609wueVH5cmiPU/fiF5jBo=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=k1Wd59UB0IZEA91+BHb7t63Nh1bSGOI5TPt0hkZVA8rgdqPS7X9Byv8PvHf9pEots
	 a0+mzYi9P2Jf8hg/ioX6teNAHw3G14IqJKKg4w829s+aJXFivMGOHo3fFcWFYxyDUD
	 ms8g1ZaQh79djWZ5HShUWrlVLOfUry2mArm016GlzYSPFsU3HwURM/nOjTrPyh8P36
	 sUs6qXloI1VNlAztagY698UYRqHZ1c5IBOiAznMmO6ZgQu5/TJHHUe1kNs2baON4ob
	 YuUq2EnwFDOrPXDeOuIE5CnN+UylxW30KA6HD6KNtcQCZk+NyplbuYFASkWs9A+qX/
	 /va9V0zUCq+Uw==
Received: by mail-oo1-f42.google.com with SMTP id 006d021491bc7-6113e68da82so3135773eaf.1;
        Thu, 03 Jul 2025 04:12:28 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXC6VXHb1GRtUNPgXBtR9r6Dsqc2q/yN/1RR/blzmiixadieJvo+jV37kxUD3cXaI2Vog0qbp3eHQ==@vger.kernel.org, AJvYcCXXi6STPJeKMR/E+lGFpmoQtTrfdeP/xGL1xVwoAbXjylQ8jk5uHegMFUhrGfZsMJXuqWrBf2nfZtdbeoI=@vger.kernel.org
X-Gm-Message-State: AOJu0YyOXrh9By2C2da2xlcRT5+4nng0WEOs8QfTRxTUjRx5PAvr18z8
	MVmp30R1N/lT2lotnYb+i8k2HIoQeOip0vB9xBZf3QQYGDZLT3xTebn8prsr2QWoO+pziz58R24
	JINnN6jWsVDFUrp4faYNKfLuzY648o3s=
X-Google-Smtp-Source: AGHT+IEfdnhboU4n2/R077RhtD1Otv/SP8fZ3dMXlRneGldlg5mu/9PR8Jraj6CY4DRR0obpUxWAkOsMSMDyaRWTzKs=
X-Received: by 2002:a05:6820:2713:b0:611:bbad:7b62 with SMTP id
 006d021491bc7-6120112a218mr4411300eaf.3.1751541147647; Thu, 03 Jul 2025
 04:12:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <rlzpjdsg6cbgxc553j6m25ysb6tyldy4lnxsjjn4hdzv7rszpp@y6rfcrbjfook> <fbfc6bf9-d7c6-4df5-85d0-b1d357159d88@suse.com>
In-Reply-To: <fbfc6bf9-d7c6-4df5-85d0-b1d357159d88@suse.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Thu, 3 Jul 2025 13:12:15 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0hPh19h9uVRVHSXiLaHxm3PR9A3W5+j=2=-B-YCyBr=uw@mail.gmail.com>
X-Gm-Features: Ac12FXx58ZcYu75iGXYHPl0jrmN8qLhIg29N7RATyquq_k1ymybhva0tDayjTm4
Message-ID: <CAJZ5v0hPh19h9uVRVHSXiLaHxm3PR9A3W5+j=2=-B-YCyBr=uw@mail.gmail.com>
Subject: Re: Forcing devices into idle
To: Oliver Neukum <oneukum@suse.com>
Cc: Thierry Reding <thierry.reding@gmail.com>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-tegra@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 3, 2025 at 12:33=E2=80=AFPM Oliver Neukum <oneukum@suse.com> wr=
ote:
>
> On 03.07.25 12:08, Thierry Reding wrote:
>
> > Any thoughts on how to solve this? Is the pm_runtime_{put,get}_sync()
> > method acceptable? If not, are there other alternatives to achieve the
> > same thing that I'm not aware of? Would it be useful to add a new set o=
f
> > APIs to force devices into an idle state (which could be semantically
> > different from runtime suspend)? Or is this all too specific for any
> > kind of generic API?
>
> Basically what you need is what happens when the system prepares to
> do a snapshot for S4. However, if you just perform FREEZE and then THAW,
> devices will assume that user space has been frozen. You need a way
> to substitute for that assumption.

Well, you just need to freeze user space beforehand.

> Runtime power management is unlikely to be a fruitful approach to your
> needs.

Agreed.

