Return-Path: <linux-pm+bounces-7565-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B4BEC8BDD1A
	for <lists+linux-pm@lfdr.de>; Tue,  7 May 2024 10:25:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6FB04285374
	for <lists+linux-pm@lfdr.de>; Tue,  7 May 2024 08:25:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB6EE13C9C6;
	Tue,  7 May 2024 08:25:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SXHdNnfi"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C98D13C906;
	Tue,  7 May 2024 08:25:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715070320; cv=none; b=nQFgfwPYlijHqZ0jiUIqu5aTLCBrUkKMhJmz2km9McyPLGDe15ejeBxHRXHULwAV8Sk+eDMaVU1uoJwXbAi+TNsFpeFaFBxRADmx9aQyMfAhWd3sQwHTLrW4kh2nR2+rg3bclOxGbtRQINBnB8hsoPBCo5T/xJrLiEbnG27P6D8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715070320; c=relaxed/simple;
	bh=RcBA2s21AzE7oMqOdlHU19eeBPj8PCXsQETJXQClDlk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Pce0eF7CbwaJAPWyjefftbevGTxbdfBr41ekx175NIPqCe3RTsl+SdP+Ixs1U6BEr4mo7T2pjzUJ80eFGlVr2Oco6664l5WbSt7ZmXbregHMwsEjjlYfgwpg20ZeL8x9DrtS3RbsfYVIk6YBhgkVrh19j3bE25ncmNCZ43ExkS8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SXHdNnfi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EF9CCC2BBFC;
	Tue,  7 May 2024 08:25:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715070320;
	bh=RcBA2s21AzE7oMqOdlHU19eeBPj8PCXsQETJXQClDlk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=SXHdNnfidtX3vASoxnFmDut6vxkdddskEoNThYrIVkyn8/nuGan068oLCq9q9xb/j
	 Ptjj8L7hCIUBaT5qgGuEihlF86lrxHDulOPehluN8qzq2jUJw/PDh/DqbkjE/JNbKm
	 IdIDo5q1o88OknvR4s8UuKaDqTTy4pjOYMWzr6QQxkBAH3pQIieIOI4SGCJTH7yrbX
	 5IbVocEjiXhv+spWbHIj+A2v2TGIfIJ9mAz/0jI0YM/6G9P6FSGx0xn14zG4G/QEqu
	 6bC1ZTYCEnoUlunghj2hw+wA5KvfacRyDEt3CRxu9UjZ0q+FNmyTs0XFOnOsPPDgFT
	 Co7LTDy8zidBA==
Date: Tue, 7 May 2024 09:25:14 +0100
From: Lee Jones <lee@kernel.org>
To: Thomas =?iso-8859-1?Q?Wei=DFschuh?= <linux@weissschuh.net>
Cc: Benson Leung <bleung@chromium.org>, Guenter Roeck <groeck@chromium.org>,
	Tzung-Bi Shih <tzungbi@kernel.org>, linux-kernel@vger.kernel.org,
	chrome-platform@lists.linux.dev,
	Mario Limonciello <mario.limonciello@amd.com>,
	"Dustin L. Howett" <dustin@howett.net>,
	Sebastian Reichel <sre@kernel.org>, linux-pm@vger.kernel.org
Subject: Re: [PATCH 1/2] platform/chrome: cros_ec_framework_laptop: introduce
 driver
Message-ID: <20240507082514.GT1227636@google.com>
References: <20240505-cros_ec-framework-v1-0-402662d6276b@weissschuh.net>
 <20240505-cros_ec-framework-v1-1-402662d6276b@weissschuh.net>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240505-cros_ec-framework-v1-1-402662d6276b@weissschuh.net>

On Sun, 05 May 2024, Thomas Weißschuh wrote:

> Framework Laptops are using embedded controller firmware based on the
> ChromeOS EC project.
> In addition to the standard upstream commands, some vendor-specific
> ones are implemented.
> 
> Add a driver for those custom EC commands.
> 
> At first, provide an empty driver that only takes care of scaffolding and
> device binding.
> Further patches will add functionality to the driver.
> 
> Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
> ---
>  MAINTAINERS                                        |  5 ++
>  drivers/mfd/cros_ec_dev.c                          | 13 ++++++

I do not see any build-time deps here.

Please split this change out.

>  drivers/platform/chrome/Kconfig                    | 11 +++++
>  drivers/platform/chrome/Makefile                   |  1 +
>  drivers/platform/chrome/cros_ec_framework_laptop.c | 53 ++++++++++++++++++++++
>  5 files changed, 83 insertions(+)

-- 
Lee Jones [李琼斯]

