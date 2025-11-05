Return-Path: <linux-pm+bounces-37488-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A1A6C3843A
	for <lists+linux-pm@lfdr.de>; Wed, 05 Nov 2025 23:52:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B31191890EC8
	for <lists+linux-pm@lfdr.de>; Wed,  5 Nov 2025 22:50:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2EC922D3739;
	Wed,  5 Nov 2025 22:49:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=aurel32.net header.i=@aurel32.net header.b="p9/HaLn8"
X-Original-To: linux-pm@vger.kernel.org
Received: from hall.aurel32.net (hall.aurel32.net [195.154.113.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EE372D2388;
	Wed,  5 Nov 2025 22:49:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.154.113.88
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762382986; cv=none; b=dwu+JAO51TLWKCIr386yXCmyGjcQMaOLnS4qehj0hVzSWadqFYvNggNETlpg7TansEWonMdzrNvFryY6Xd9y0qqUUylvSUHTxS0Zx7Lg6Xjvpc8S+PHx2VUsSU1XWaZn18TYerFVvIvDkNWLHNl4yIFA9AqnzH78flFsEP+xEOY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762382986; c=relaxed/simple;
	bh=9W+JZgh6zEumSbgA+u40BdlWRsUbWYl5s3WkNt9fkPo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PQ8iDy02U9OUkKfWloqoGf8xXCt6U8z7brzox9l++FfaYbaCQhEJrez/dlAqphAdGZkK2dxO/e/cp6jRVT6BLj/It1+aAbVOwsNr+6S/raTtx1ZUidV5Tg41TxWiwxakc5exvMNvhS7idS85dDXgE2jFCHFId0+0OasylzMEiL4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=aurel32.net; spf=pass smtp.mailfrom=aurel32.net; dkim=pass (2048-bit key) header.d=aurel32.net header.i=@aurel32.net header.b=p9/HaLn8; arc=none smtp.client-ip=195.154.113.88
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=aurel32.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aurel32.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=aurel32.net
	; s=202004.hall; h=In-Reply-To:Content-Transfer-Encoding:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:From:Reply-To:
	Subject:Content-ID:Content-Description:X-Debbugs-Cc;
	bh=7B7gYt+LYlqrQkECAw+Erqll5FdWOFdju69wPPGYGxM=; b=p9/HaLn80YendaEi5jpbR2NlAy
	mmLPxWqqxHK9lg4A6MmefTNtD17WB2gX1XXiiEEMjMwutwfEnpYic/hupIJwGxc7yBsM9ntzxsQ4D
	uC9d7qDgfARmpqYG+mB/lfWHr4w15x+D1OQuaW1GEqKY3vTaY+Ii+Fk/QSZxtpoF/mHIPi37dhJPW
	KexrSMMUp6GVBIfZj1YXqoyTDmj3dIYudXM3XwglXE9HOCJTjQyjUP7kmOD6iW/fqSBfJZbw/xxmz
	KHVCjFHztMyARI3qxDfDTkQGWhi6bh5+LKrd8JDv/osSeeHMMKyU9U++hj3iT1SHWCSrdiq2mgnsB
	rtgInH2g==;
Received: from [2a01:e34:ec5d:a741:1ee1:92ff:feb4:5ec0] (helo=ohm.rr44.fr)
	by hall.aurel32.net with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <aurelien@aurel32.net>)
	id 1vGmJt-0000000Ag2k-3AUR;
	Wed, 05 Nov 2025 23:49:37 +0100
Date: Wed, 5 Nov 2025 23:49:37 +0100
From: Aurelien Jarno <aurelien@aurel32.net>
To: Troy Mitchell <troy.mitchell@linux.spacemit.com>
Cc: Lee Jones <lee@kernel.org>,
	Sebastian Reichel <sebastian.reichel@collabora.com>,
	linux-kernel@vger.kernel.org, Sebastian Reichel <sre@kernel.org>,
	Yixun Lan <dlan@gentoo.org>, Paul Walmsley <pjw@kernel.org>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>,
	linux-riscv@lists.infradead.org, spacemit@lists.linux.dev,
	linux-pm@vger.kernel.org
Subject: Re: (subset) [PATCH v5 0/2] driver: reset: spacemit-p1: add driver
 for poweroff/reboot
Message-ID: <aQvUgQvM48LsSzei@aurel32.net>
Mail-Followup-To: Troy Mitchell <troy.mitchell@linux.spacemit.com>,
	Lee Jones <lee@kernel.org>,
	Sebastian Reichel <sebastian.reichel@collabora.com>,
	linux-kernel@vger.kernel.org, Sebastian Reichel <sre@kernel.org>,
	Yixun Lan <dlan@gentoo.org>, Paul Walmsley <pjw@kernel.org>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>,
	linux-riscv@lists.infradead.org, spacemit@lists.linux.dev,
	linux-pm@vger.kernel.org
References: <20251102230352.914421-1-aurelien@aurel32.net>
 <176213091347.301408.11587695003687450479.b4-ty@collabora.com>
 <FA447DF1D2398A79+aQlVuEbrLMCiGMpc@kernel.org>
 <20251105093347.GD8064@google.com>
 <E205F88FB1EE06C5+aQscI0Uy7pgiMzEt@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <E205F88FB1EE06C5+aQscI0Uy7pgiMzEt@kernel.org>
User-Agent: Mutt/2.2.13 (2024-03-09)

On 2025-11-05 17:42, Troy Mitchell wrote:
> On Wed, Nov 05, 2025 at 09:34:21AM +0000, Lee Jones wrote:
> > On Tue, 04 Nov 2025, Troy Mitchell wrote:
> >=20
> > > On Mon, Nov 03, 2025 at 01:48:33AM +0100, Sebastian Reichel wrote:
> > > >=20
> > > > On Mon, 03 Nov 2025 00:01:58 +0100, Aurelien Jarno wrote:
> > > > > This adds poweroff/reboot support for the SpacemiT P1 PMIC chip, =
which is
> > > > > commonly paired with the SpacemiT K1 SoC.
> > > > >=20
> > > > > Note: For reliable operation, this driver depends on a this patch=
 that adds
> > > > > atomic transfer support to the SpacemiT I2C controller driver:
> > > > >   https://lore.kernel.org/spacemit/20251009-k1-i2c-atomic-v4-1-a8=
9367870286@linux.spacemit.com/
> ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
> dependency is here.

Oh indeed, I have forgotten about this part.

> > > > >=20
> > > > > [...]
> > > >=20
> > > > Applied, thanks!
> > > >=20
> > > > [1/2] driver: reset: spacemit-p1: add driver for poweroff/reboot
> > > >       commit: 28124cc0fb8c7dc01a6834d227351e25d9a92c58
> > > Should we apply it now? The dependency patch hasn=E2=80=99t been merg=
ed yet...
> >=20
> > What is the dependency?
> I point it out above.
> Without this patch, reboot and shutdown would end up calling the non-atom=
ic i2c_transfer.

Note however this is not a strong dependency, it is needed to make the=20
reset or power off reliable. Calling non-atomic i2c_transfer lead to a=20
successful reset or power off a bit more than half of the time.

Regards
Aurelien

--=20
Aurelien Jarno                          GPG: 4096R/1DDD8C9B
aurelien@aurel32.net                     http://aurel32.net

