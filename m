Return-Path: <linux-pm+bounces-20481-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C4397A12248
	for <lists+linux-pm@lfdr.de>; Wed, 15 Jan 2025 12:15:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 55CAA3AD911
	for <lists+linux-pm@lfdr.de>; Wed, 15 Jan 2025 11:15:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28FF8236A7B;
	Wed, 15 Jan 2025 11:14:48 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1B4D2309A1;
	Wed, 15 Jan 2025 11:14:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736939688; cv=none; b=WaWdY6j+6s1PKDiMjRp8BhjZPYKTT73knFWUr9oTGwSb8cyb9AN9/12HFFNU6Zmuzq0Vb6Cczfzj+5GQ/61eTMczDfrx/RkTQf59SvxIKI6BjbeTsQdNXOTtVA3tXPXVObJk0GoIaiMjb3oO7Xr6Ec5P0buzesWEItAVFdcSD7M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736939688; c=relaxed/simple;
	bh=+3aBOFlgVygmAQiQ1HC7xJeQG6jYBCJ6dab2btOotA4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=SHLcU/LzqRhD13Qtrzhu4SIeKwK2msla5RMtfXrD7Wt/y/U8T16lGQ6EXo7bsqcSGXlWnJJ3lCJ/bdpyzq1EBruy6coCdvfvbLwp6fACOt182orBh92u51lNXaHKzlUltIt3ZnL4udS8rKywm6j0almVZ0wrc2yON45UZQugeNA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 5E38412FC;
	Wed, 15 Jan 2025 03:15:13 -0800 (PST)
Received: from donnerap.manchester.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 53F6F3F51B;
	Wed, 15 Jan 2025 03:14:43 -0800 (PST)
Date: Wed, 15 Jan 2025 11:14:38 +0000
From: Andre Przywara <andre.przywara@arm.com>
To: Lee Jones <lee@kernel.org>
Cc: Chen-Yu Tsai <wens@csie.org>, linux-sunxi@lists.linux.dev, Chris Morgan
 <macroalpha82@gmail.com>, Vasily Khoruzhick <anarsoul@gmail.com>, Jonathan
 Cameron <jic23@kernel.org>, Andrey Skvortsov <andrej.skvortzov@gmail.com>,
 linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: (subset) [PATCH v2] Revert "mfd: axp20x: Allow multiple
 regulators"
Message-ID: <20250115111438.5d0d47f3@donnerap.manchester.arm.com>
In-Reply-To: <173642272888.2620575.17634288216154119464.b4-ty@kernel.org>
References: <20250108164359.2609078-1-andre.przywara@arm.com>
	<173642272888.2620575.17634288216154119464.b4-ty@kernel.org>
Organization: ARM
X-Mailer: Claws Mail 3.18.0 (GTK+ 2.24.32; aarch64-unknown-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Thu, 09 Jan 2025 11:38:48 +0000
Lee Jones <lee@kernel.org> wrote:

Hi Lee,

> On Wed, 08 Jan 2025 16:43:59 +0000, Andre Przywara wrote:
> > As Chris and Vasily reported, the attempt to support multiple AXP PMICs
> > in one system [1] breaks some of the battery and charging functionality
> > on devices with AXP PMICs. The reason is that the drivers now fail to g=
et
> > the correct IIO channel for the ADC component, as the current code seems
> > to rely on the zero-based enumeration of the regulator devices.
> > A fix is possible, but not trivial, as it requires some rework in the A=
XP
> > MFD driver, which cannot be fully reviewed or tested in time for the
> > 6.13 release.
> >=20
> > [...] =20
>=20
> Applied, thanks!

Just checking, is this on route to reach Linus' tree this week still? I
don't see it in any of your kernel.org trees.
Since it's a regression introduced with 6.13-rc1, so I would very much
like to see this fixed before the release.
If I can help with anything, please let me know.

Cheers,
Andre

>=20
> [1/1] Revert "mfd: axp20x: Allow multiple regulators"
>       commit: b246bd32a34c1b0d80670e60e4e4102be6366191
>=20
> --
> Lee Jones [=E6=9D=8E=E7=90=BC=E6=96=AF]
>=20


