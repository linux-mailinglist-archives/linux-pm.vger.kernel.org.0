Return-Path: <linux-pm+bounces-10887-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 203F892BF09
	for <lists+linux-pm@lfdr.de>; Tue,  9 Jul 2024 18:04:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 50E591C2199D
	for <lists+linux-pm@lfdr.de>; Tue,  9 Jul 2024 16:04:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5AC04181D0D;
	Tue,  9 Jul 2024 16:03:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rq+3oCYi"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 362A74A02
	for <linux-pm@vger.kernel.org>; Tue,  9 Jul 2024 16:03:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720541039; cv=none; b=IhrVr/xOsgGTfmR3AhsqTLhr61s+fSYckk5qKVf8ql7pTvnHjtHzgBMfCDhHTCio9dGptN3xtvGDLYXtEjj7+l4CmrstcwBeQzxqHd4NjgnkO8AwMRCrbSI78fNqD0wSXRFmv2ShyCTw7bSn7REED1LIpj2FtrlnNxYrywC3z/s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720541039; c=relaxed/simple;
	bh=Ck721sAoczFrwR/3RAlb+lr96G0Kz0LPVJnKok5qARo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LVacfyZwmXXblhmVRtiyFmb76I+rbzRJ3MpVVFRbmwfB8lOUkXdXc72m0NZsmCpycToS4XXymB5BV1fzd5bEIXQOYs95732eoV2GeeC6Rs4+zYNwxiUEMjMpxIAO9zO4AbF3Vc69tHffxQZon8G5Qfcw3ZgYtrYdCvTGd+YHVs8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rq+3oCYi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A3849C4AF07
	for <linux-pm@vger.kernel.org>; Tue,  9 Jul 2024 16:03:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720541038;
	bh=Ck721sAoczFrwR/3RAlb+lr96G0Kz0LPVJnKok5qARo=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=rq+3oCYiqTr2GB5VS16Vs5FnhWfUT+G0Cmm05vuwTxpSZk8jTZXqklEFrKQTJ4Pkq
	 9/aDxfg+JajByI4296dnkS+ZNIon0XBiv2gJV9NDP+pCvI+JrTTRzIY67LakhEu6vA
	 qni17e7YPvZETNFn0DfF6iECqe0aU8SYLSftSfseQZOWO65QbOtRPs8bIMk8p9ZwCU
	 ew6079uSsq6FLja1obeUERDmRFIDoUjkKpk+qG0Kc7z5oxYv6B8Kwah7+gunzhjuap
	 G0f/1cnGeHIyU+8pMqJx4ySW6rTSrua/5y4pVM2BuBioF9i74h8Z03elpJd2ueHYOG
	 Co/eFpl/hZ1uQ==
Received: by mail-oo1-f45.google.com with SMTP id 006d021491bc7-5c7af5b5fbdso1907eaf.0
        for <linux-pm@vger.kernel.org>; Tue, 09 Jul 2024 09:03:58 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXOkEUdL1zjfc/FioS9FyZnPA3QRCOhT8a5D/X0cg7jBZJ1JcwgbzSrKm3IhdBUWT9jdBXd+DI1L/xLirExCK6ooKqstPnrgbM=
X-Gm-Message-State: AOJu0Yz4+w3BadZ9YM2svUEgih8KwzBUrwfpvY4i/NE6AYCjHKfo4Aoa
	puSfUALY3Sz43urbKyiGtUKPhsblQtNOFr7n3CcuCl/eW4LYluHX7X3+HHg5hHDYYlR6DVgJ+vW
	mEUF4c/cuntbYZ3tNNoEaNMBl0BM=
X-Google-Smtp-Source: AGHT+IGvW3AUooy2Uvkf0BbMfKWVObc3ybenrWBRGp3nMaHNXGvNauXwaA8UskBDOAlRQjnMFzIeSJp+8dwXls+v1zA=
X-Received: by 2002:a05:6820:1d99:b0:5c6:6029:1568 with SMTP id
 006d021491bc7-5c68dfe1f20mr2897534eaf.0.1720541037908; Tue, 09 Jul 2024
 09:03:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240709070434.lhqicz2px555sykz@vireshk-i7>
In-Reply-To: <20240709070434.lhqicz2px555sykz@vireshk-i7>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Tue, 9 Jul 2024 18:03:46 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0hxJXgOumrKz8GP5zq7Hya97SaMCsRNAJEjBkk_ur+RYg@mail.gmail.com>
Message-ID: <CAJZ5v0hxJXgOumrKz8GP5zq7Hya97SaMCsRNAJEjBkk_ur+RYg@mail.gmail.com>
Subject: Re: [GIT PULL] OPP updates for 6.11
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Linux PM <linux-pm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Viresh,

On Tue, Jul 9, 2024 at 9:04=E2=80=AFAM Viresh Kumar <viresh.kumar@linaro.or=
g> wrote:
>
> Hi Rafael,
>
> The following changes since commit 1613e604df0cd359cf2a7fbd9be7a0bcfacfab=
d0:
>
>   Linux 6.10-rc1 (2024-05-26 15:20:12 -0700)
>
> are available in the Git repository at:
>
>   git://git.kernel.org/pub/scm/linux/kernel/git/vireshk/pm.git tags/opp-u=
pdates-6.11
>
> for you to fetch changes up to e3943f00afdb71684c4f209f9d3a90d6b79771fc:
>
>   OPP: Introduce an OF helper function to inform if required-opps is used=
 (2024-06-26 11:17:20 +0530)
>
> ----------------------------------------------------------------
> OPP Updates for 6.11
>
> - Introduce an OF helper function to inform if required-opps is used (Ulf=
 Hansson).
> - Generic cleanus (Ulf Hansson and Viresh Kumar).
>
> ----------------------------------------------------------------
> Ulf Hansson (2):
>       OPP: Drop a redundant in-parameter to _set_opp_level()
>       OPP: Introduce an OF helper function to inform if required-opps is =
used
>
> Viresh Kumar (1):
>       OPP: Fix missing cleanup on error in _opp_attach_genpd()
>
>  drivers/opp/core.c     | 15 ++++++++-------
>  drivers/opp/of.c       | 32 ++++++++++++++++++++++++++++++++
>  include/linux/pm_opp.h |  6 ++++++
>  3 files changed, 46 insertions(+), 7 deletions(-)
>
> --

Pulled and added to linux-pm.git/linux-next, thanks!

