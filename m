Return-Path: <linux-pm+bounces-37443-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E3A1C350EA
	for <lists+linux-pm@lfdr.de>; Wed, 05 Nov 2025 11:15:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 29F423B7CAA
	for <lists+linux-pm@lfdr.de>; Wed,  5 Nov 2025 10:12:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1764C2F6176;
	Wed,  5 Nov 2025 10:11:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qlRu5R3e"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEE3F2F28FB;
	Wed,  5 Nov 2025 10:11:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762337516; cv=none; b=HF7d5xXxgD50tpQ1+VeAwvyJychUkW/I/WJ+LY92vFvDZ29CFhIPKXB4p4BFevj3EqUsUn/UR3w5mzE/wAKhHw92WmGG2EoYhHeNeg+u0HQ12We+kN+ISz7M+KRhI+SGRX5WRkkg5VE566KmQsg0wlob7EK/8c41Dy7wCMs7cNc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762337516; c=relaxed/simple;
	bh=TYLyEsZW028QQNPW+jnT8umdzeFdblxH5eHQ+MnHmtU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=o9szaFbLjRlFos3Zbl6qEZVKZIpSegYr+TS+fgdak8EyxoV4BNWD7EivrKm+nFp8t0Cighq2xZWQzN7cMBlc9kyOqgFmUYSHj3US1etlAP9HD9hwnRwKDDiNAbxSQh2qX58ZLzA/TqF22tH8Jv5B5IFkTG7mT+YZmhurGxjYM7s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qlRu5R3e; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 35224C19421;
	Wed,  5 Nov 2025 10:11:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762337515;
	bh=TYLyEsZW028QQNPW+jnT8umdzeFdblxH5eHQ+MnHmtU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=qlRu5R3eFg5W/9sRgaBelrjZ58wK+S17lFMe3FRCKtFMneFa4ArxEX/SYkEQxLb8v
	 0S74KquyBevaWOsz9/rTsH7oE2zHALGDe8LQ4hfYRMehPC7TjOdLrLdI4u2Sk/4PgP
	 gptFeYjqulFgnMhNR8W62eb+HEyhTi2fpbTGc2SAWO2dD5JlzCVJ3y18QiyFMp2BZ/
	 MF6h5vKOTUAoQymbFRQZ6VD+/W99WNCLjte6oN3tAHKHomdZitLNMtykq3GZx80ayB
	 B4FX5Dify1oqE2RH+R8cWPEVc3IrrfZMv6NphZfh/e5+uBHcHmpfaYEvOUwrc3Dyjz
	 r5qA39nDUS54A==
Date: Wed, 5 Nov 2025 10:11:49 +0000
From: Lee Jones <lee@kernel.org>
To: Troy Mitchell <troy.mitchell@linux.spacemit.com>
Cc: Sebastian Reichel <sebastian.reichel@collabora.com>,
	linux-kernel@vger.kernel.org, Sebastian Reichel <sre@kernel.org>,
	Yixun Lan <dlan@gentoo.org>, Paul Walmsley <pjw@kernel.org>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>,
	linux-riscv@lists.infradead.org, spacemit@lists.linux.dev,
	Aurelien Jarno <aurelien@aurel32.net>, linux-pm@vger.kernel.org
Subject: Re: (subset) [PATCH v5 0/2] driver: reset: spacemit-p1: add driver
 for poweroff/reboot
Message-ID: <20251105101149.GH8064@google.com>
References: <20251102230352.914421-1-aurelien@aurel32.net>
 <176213091347.301408.11587695003687450479.b4-ty@collabora.com>
 <FA447DF1D2398A79+aQlVuEbrLMCiGMpc@kernel.org>
 <20251105093347.GD8064@google.com>
 <E205F88FB1EE06C5+aQscI0Uy7pgiMzEt@kernel.org>
 <20251105100856.GG8064@google.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20251105100856.GG8064@google.com>

On Wed, 05 Nov 2025, Lee Jones wrote:

> On Wed, 05 Nov 2025, Troy Mitchell wrote:
> 
> > On Wed, Nov 05, 2025 at 09:34:21AM +0000, Lee Jones wrote:
> > > On Tue, 04 Nov 2025, Troy Mitchell wrote:
> > > 
> > > > On Mon, Nov 03, 2025 at 01:48:33AM +0100, Sebastian Reichel wrote:
> > > > > 
> > > > > On Mon, 03 Nov 2025 00:01:58 +0100, Aurelien Jarno wrote:
> > > > > > This adds poweroff/reboot support for the SpacemiT P1 PMIC chip, which is
> > > > > > commonly paired with the SpacemiT K1 SoC.
> > > > > > 
> > > > > > Note: For reliable operation, this driver depends on a this patch that adds
> > > > > > atomic transfer support to the SpacemiT I2C controller driver:
> > > > > >   https://lore.kernel.org/spacemit/20251009-k1-i2c-atomic-v4-1-a89367870286@linux.spacemit.com/
> > ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
> > dependency is here.
> > > > > > 
> > > > > > [...]
> > > > > 
> > > > > Applied, thanks!
> > > > > 
> > > > > [1/2] driver: reset: spacemit-p1: add driver for poweroff/reboot
> > > > >       commit: 28124cc0fb8c7dc01a6834d227351e25d9a92c58
> > > > Should we apply it now? The dependency patch hasn’t been merged yet...
> > > 
> > > What is the dependency?
> > I point it out above.
> > Without this patch, reboot and shutdown would end up calling the non-atomic i2c_transfer.
> 
> Okay, thanks.  I was mostly checking that you weren't referring to the
> MFD patch, which doesn't represent a true dependency.

To save Sebastian some trouble, let's keep the reboot patch applied.

I'll hold off on the MFD one, which will ensure that reboot isn't probed.

Let me know when the dep is merged and I'll hoover up the rest of the set.

-- 
Lee Jones [李琼斯]

