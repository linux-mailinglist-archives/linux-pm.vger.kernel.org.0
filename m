Return-Path: <linux-pm+bounces-34489-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C8DCB536CA
	for <lists+linux-pm@lfdr.de>; Thu, 11 Sep 2025 17:02:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 933331CC1036
	for <lists+linux-pm@lfdr.de>; Thu, 11 Sep 2025 15:00:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 967CF34DCDB;
	Thu, 11 Sep 2025 14:59:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Du6b4hpM"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E1FC3469E4;
	Thu, 11 Sep 2025 14:59:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757602780; cv=none; b=hbXmrrUgz3w75ffpSv5dH/jtUdFxDexJM0/hnxVEccWnEa8FqiojyvJNSBj/d7cTVz89XB4lJWmLRKYtPyt686Gto+QLXazYb6PKu9+O+LSWMk1WWj6lRFDPYIAzSZjik4OTyfeAhcTvcjfGYNzy+UkQaNxUflmtkCHDQZuNfV4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757602780; c=relaxed/simple;
	bh=dwdaLEAjnH3HKkai+U9OrOZJ12DWW8piJIVwD4P+moM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rpWAyjaMGUCoGE/SrjNwqMU5+zYxEtwaga6VpR4t2cOn0oz3yFuoYYJEMGy85Bd56PDxOvazI97LmIJfYmyZZqHk+lJXTu/tttXND0SwkT7bV3yVtyXa7qMgIfGufNOKQ76sNL82UeLwz6jF2Up5roKifnYaq1cUsHrK3AJzXvo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Du6b4hpM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 92A27C4CEF0;
	Thu, 11 Sep 2025 14:59:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757602780;
	bh=dwdaLEAjnH3HKkai+U9OrOZJ12DWW8piJIVwD4P+moM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Du6b4hpMRlqI1aCbon+AQJ+1kBXG0polcPvf4DE/LsKzWpmcSXdseI3XjfkKCa8Rd
	 z1ecYtkdWJImyg23H5zjxAdgId3n2wTRhGLvkva5WZ4vhWE/IieiCA23J/o7GOPAya
	 RwYCWFQhKuibfsYsz3Ia4bEEKFP0071HQx8CGachXhLqNnYcz+WvbREieI/6/pbOaI
	 SPe4qX+U5g658QNOPA6/VODmEcFBHbOVakJlO+dw2CikuFAYl4TKq6cnr+gpUD9yec
	 SgO44/dFz+vSnUKDQ1nPBJ54eWK+s/j6SNGkVYSCio0JnPoJjBVVpS0kFPYuzOXQly
	 kOBcatU2NbGgQ==
Date: Thu, 11 Sep 2025 15:59:34 +0100
From: Lee Jones <lee@kernel.org>
To: linux-rockchip@lists.infradead.org,
	Chris Morgan <macroalpha82@gmail.com>
Cc: linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
	broonie@kernel.org, lgirdwood@gmail.com, sre@kernel.org,
	heiko@sntech.de, conor+dt@kernel.org, krzk+dt@kernel.org,
	robh@kernel.org, Chris Morgan <macromorgan@hotmail.com>
Subject: Re: (subset) [PATCH v8 0/5] Add Texas Instruments BQ25703A Charger
Message-ID: <20250911145934.GP9224@google.com>
References: <20250904160530.66178-1-macroalpha82@gmail.com>
 <175760259503.1582479.14013409824773713781.b4-ty@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <175760259503.1582479.14013409824773713781.b4-ty@kernel.org>

On Thu, 11 Sep 2025, Lee Jones wrote:

> On Thu, 04 Sep 2025 11:05:25 -0500, Chris Morgan wrote:
> > From: Chris Morgan <macromorgan@hotmail.com>
> > 
> > Add support for the Texas Instruments BQ25703A charger manager. The
> > device integrates a boost converter with the charger manager. This
> > series adds the device as an MFD with separate regulator and power
> > supply drivers. This allows us to manage a circular dependency with
> > a type-c port manager which depends on the regulator for usb-otg
> > but supplies power to the BQ25703A charger.
> > 
> > [...]
> 
> Applied, thanks!
> 
> [1/5] dt-bindings: mfd: ti,bq25703a: Add TI BQ25703A Charger
>       commit: 76bc2203a46ef704a4cd8003986f6bd74139a367
> [2/5] mfd: bq257xx: Add support for BQ25703A core driver
>       commit: 3b1bbfb5fce3ca9fffc92ac1b053b0cfbb1f322b
> [3/5] power: supply: bq257xx: Add support for BQ257XX charger
>       commit: 1cc017b7f9c7b7cd86fdda4aee36b92d91cc2ad2
> [4/5] regulator: bq257xx: Add bq257xx boost regulator driver
>       commit: 981dd162b63578aee34b5c68795e246734b76d70

Send for build testing.  If successful, I'll ping out a PR shortly.

Note to self: ib-mfd-power-regulator-6.18

-- 
Lee Jones [李琼斯]

