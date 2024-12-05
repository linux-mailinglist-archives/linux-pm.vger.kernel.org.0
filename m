Return-Path: <linux-pm+bounces-18615-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 20B4C9E5384
	for <lists+linux-pm@lfdr.de>; Thu,  5 Dec 2024 12:17:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CF661169B70
	for <lists+linux-pm@lfdr.de>; Thu,  5 Dec 2024 11:17:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FBFF1DFE24;
	Thu,  5 Dec 2024 11:17:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AcUIGFex"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 657731DFE0B;
	Thu,  5 Dec 2024 11:17:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733397439; cv=none; b=IT7Ss0PbDoWKH7Xg2cPGcx6WVBSbFZKcU7o38FNsPFPSQspabR54KWNu3PzHAbP3tsyVjGz8voKo4sEBMN9oYGde5Y6Z7nKGatbEbSzTtBz7fb3VIXeGfhoNuyzXdNAkgChIVMaQcmiwncqoRv5Zjuhd/kOq7BBzUeCqDMS8B6U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733397439; c=relaxed/simple;
	bh=VXpDjM1VqY1LIrSBPFB2UJGmFIt6TeDyjyXjSNJsbp8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WugpNLs6dJBXZKXuOqDMd+Au3sFAPtPmDw/Ds08Gk5LcRcipa0nm3l4pmWyF9l4BtC1OJcO+bvJghrdlf0gVufeEIoZ5OirFahU7tIGdACQ30gRsnXdlpHMQpybDkvTmnJL4yw+/xZvEcv+NwUuM6Th/n496bHg971dxS1+snhY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AcUIGFex; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 129DBC4CEE1;
	Thu,  5 Dec 2024 11:17:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733397438;
	bh=VXpDjM1VqY1LIrSBPFB2UJGmFIt6TeDyjyXjSNJsbp8=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=AcUIGFexUNylnCBHqA4G3e5Dg1eluZJ4C6aq5Fr2qHIWHQfwaRqd6AAf61aCnrOlE
	 3XmDMjshRYLu5xdKx94tyM7GyIw75qNybheex0fYJl/m8ZTHnJL3xPOuD0qPgq1xLk
	 GaXQSBwv/KvSsSOkVuZ0Dhm6fdWI5oy2Pi8qkyO8ibCL3KKwgtqcAOTREuj0as6L0i
	 U7s3nZ+sfvAKelxRugOBCs4+LC2fQ5As8KO2hTYvEOdiptZ/K/tLQlDcWtJZc/+GjJ
	 PHU0Kd8I9l7eIHnZj3uQbLTdbZgcBVXKYjAZGuhbm6T4Yl14l6niTJ9zrLAi0AUWAs
	 IsRd0cnncBEMg==
Received: by mail-oa1-f46.google.com with SMTP id 586e51a60fabf-29666708da7so493412fac.0;
        Thu, 05 Dec 2024 03:17:18 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXVAqr+/b/LZSFXhS9oJDS8xuDVj7dR9u0FEM27havHlxEWQNlnMfytlf016z/ce7blpfq+vNyv3A==@vger.kernel.org
X-Gm-Message-State: AOJu0YzOr6GMQYMH34k+4JHxxrS6cNG8qAwgHrJKCkF/UmJtCr8AEWtL
	9/SBMFyUkfPaPZkrdfKhzxM+DCoYwR7i6Glpxk7Q1v4SyzrQr/GsRIPlbjgPUg0UhOjGwcE+xgn
	ny3VMZtU5MAuLTfwhjWllG1Cp3XY=
X-Google-Smtp-Source: AGHT+IHaKBGapowTMBsgUIPXWRL0Kkbg7j+XrCMrYujh36wMNOH3lH31PXJ1ephWlelVuoFMgDsyDu+MzigqhXPhv7U=
X-Received: by 2002:a05:6870:46a6:b0:29d:c85f:bc8c with SMTP id
 586e51a60fabf-29e9b3a4f22mr4629344fac.36.1733397437278; Thu, 05 Dec 2024
 03:17:17 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241118072917.3853-1-wsa+renesas@sang-engineering.com> <20241118072917.3853-16-wsa+renesas@sang-engineering.com>
In-Reply-To: <20241118072917.3853-16-wsa+renesas@sang-engineering.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Thu, 5 Dec 2024 12:17:06 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0jk-vzE0EwFQf2aLqhC8FzYYwNCmD-1mX5_C34YGET+Vg@mail.gmail.com>
Message-ID: <CAJZ5v0jk-vzE0EwFQf2aLqhC8FzYYwNCmD-1mX5_C34YGET+Vg@mail.gmail.com>
Subject: Re: [PATCH 15/15] PM / Sleep: don't include 'pm_wakeup.h' directly
To: Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc: linux-kernel@vger.kernel.org, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Pavel Machek <pavel@ucw.cz>, Len Brown <len.brown@intel.com>, linux-pm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 18, 2024 at 8:30=E2=80=AFAM Wolfram Sang
<wsa+renesas@sang-engineering.com> wrote:
>
> The header clearly states that it does not want to be included directly,
> only via 'device.h'. 'platform_device.h' works equally well. Remove the
> direct inclusion.
>
> Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
> ---
>  kernel/power/autosleep.c | 1 -
>  1 file changed, 1 deletion(-)
>
> diff --git a/kernel/power/autosleep.c b/kernel/power/autosleep.c
> index b29c8aca7486..865df641b97c 100644
> --- a/kernel/power/autosleep.c
> +++ b/kernel/power/autosleep.c
> @@ -9,7 +9,6 @@
>
>  #include <linux/device.h>
>  #include <linux/mutex.h>
> -#include <linux/pm_wakeup.h>
>
>  #include "power.h"
>
> --

Applied as 6.14 material, thanks!

