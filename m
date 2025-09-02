Return-Path: <linux-pm+bounces-33645-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E188B4052A
	for <lists+linux-pm@lfdr.de>; Tue,  2 Sep 2025 15:50:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E532F16E16D
	for <lists+linux-pm@lfdr.de>; Tue,  2 Sep 2025 13:45:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0BDC324B09;
	Tue,  2 Sep 2025 13:41:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZwWBlnAw"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADFAD2D4B4E;
	Tue,  2 Sep 2025 13:41:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756820485; cv=none; b=PAroHw0YlzwWQwkKiyyEu6wL2y444E6oI+cLFKQe8CW1s4pw5S30GXjFXUfp132yFKh0OpvCWn/XIKPpnHQ/JLwCoZCyJB7lvkYvZSDrHiz9ImJVkBwAyWqg2sYWWy54Pj6ZT42sMHFmUGjGajE1UMeG9FGxNryUbbdxJDxeRbk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756820485; c=relaxed/simple;
	bh=ZVVlpLZtW001ia11Gv9DKuA1Yfy1spmGwT9D/HHzZoQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BZMi56pzJjlG7bkR0IYpS5DsbrI2q+VdnQ3kdtAp3axnEuuYEGN5kY+j8qe/geZl8S7xx7hQbb0BYcGyCXdP1up67ADewuEvOXFvOcMEMVbt1MnqPFkG3gsy/AH0IbUjv9JQQTeabDF3AWj2C3m2rc18/1BFq6tv6chrvyCNeCU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZwWBlnAw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8CD18C4CEFB;
	Tue,  2 Sep 2025 13:41:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756820485;
	bh=ZVVlpLZtW001ia11Gv9DKuA1Yfy1spmGwT9D/HHzZoQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ZwWBlnAwxUOSjTlgMlo3w+hpjeXp789p38pxg3MIVv/SyyuAuKaCsP2HtTYFPQbsw
	 ipI91tkwRXxx5v0GyencRIJ6MkFv5P19K+B3LE0Vm4Hg5FuK/63AVmU86O/ExS7rI2
	 MJJeyRBvBDhbvqH+XHEbxDOo3MWE2FCu8PpuinsrqurB/LmexmeYwCKa5oqVKpR1pv
	 sb4pvmADBKBbuEsmhW7C758YcnSXtO8cWz5qGDFyTb2cc/hH1cjcLUbRX2sONdxr8d
	 eLgLq30LcHJb7jUHQR/7f3+HJst8lWyDKdB5cWtbDiGeupGHw3ntvh6czNTJYy6JDI
	 14ROImnYnTqLw==
Date: Tue, 2 Sep 2025 14:41:18 +0100
From: Lee Jones <lee@kernel.org>
To: samuel.kayode@savoirfairelinux.com
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Sebastian Reichel <sre@kernel.org>, Frank Li <Frank.li@nxp.com>,
	imx@lists.linux.dev, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-input@vger.kernel.org,
	linux-pm@vger.kernel.org, Abel Vesa <abelvesa@kernel.org>,
	Abel Vesa <abelvesa@linux.com>, Robin Gong <b38343@freescale.com>,
	Robin Gong <yibin.gong@nxp.com>,
	Enric Balletbo i Serra <eballetbo@gmail.com>,
	Sean Nyekjaer <sean@geanix.com>,
	Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Subject: Re: [PATCH v10 5/6] power: supply: pf1550: add battery charger
 support
Message-ID: <20250902134118.GP2163762@google.com>
References: <20250820-pf1550-v10-0-4c0b6e4445e3@savoirfairelinux.com>
 <20250820-pf1550-v10-5-4c0b6e4445e3@savoirfairelinux.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250820-pf1550-v10-5-4c0b6e4445e3@savoirfairelinux.com>

Power:

> From: Samuel Kayode <samuel.kayode@savoirfairelinux.com>
> 
> Add support for the battery charger for pf1550 PMIC.
> 
> Reviewed-by: Frank Li <Frank.Li@nxp.com>
> Tested-by: Sean Nyekjaer <sean@geanix.com>
> Signed-off-by: Samuel Kayode <samuel.kayode@savoirfairelinux.com>
> ---
> v9:
> - Fix thermal regulation temperature ranges
> - Fix default thermal regulation temperature
> - Drop unused `data` variable in reg_init
> - Select charger operation mode based on application - suggested by Sean
> v8:
> - Drop PF1550_CHARGER_NAME
> - Drop unnecessary POWER_SUPPLY_STATUS_CHARGING s
> - Replace POWER_SUPPLY_HEALTH_DEAD with POWER_SUPPLY_HEALTH_NO_BATTERY
> - Drop check for charger in delayed_work s
> - Use dev_warn when battery is over-voltage
> - Define two power supplies: charger and battery
> - Use devm_delayed_work_autocancel to automate cleanup and fix race
>   condition
> v7:
> - Use reverse christmas tree order
> - Drop unecessary 0 in id table's driver data field
> - Store virqs to avoid reinvoking platform_get_irq in the interrupt
>   service routine
> - Drop manufacturer and model global variables
> v6:
> - Drop lock entirely
> - Reverse christmas tree order for variables defined in probe as
>   suggested by Frank
> - return pf1550_reg_init
> v5:
> - Drop lock for battery and charger delayed_work
> - More conservative locking in vbus delayed_work
> - Apply lock when setting power supply type during register initialization
> v4:
> - Finish handling of some interrupts in threaded irq handler
> - Use platform_get_irq
> v3:
> - Use struct power_supply_get_battery_info to get constant charge
>   voltage if specified
> - Use virqs mapped in MFD driver
> v2:
> - Address feedback from Enric Balletbo Serra
> ---
>  drivers/power/supply/Kconfig          |  11 +
>  drivers/power/supply/Makefile         |   1 +
>  drivers/power/supply/pf1550-charger.c | 636 ++++++++++++++++++++++++++++++++++
>  3 files changed, 648 insertions(+)

Once Sebastian takes this, I'll merge the set.

-- 
Lee Jones [李琼斯]

