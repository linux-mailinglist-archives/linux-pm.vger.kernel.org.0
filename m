Return-Path: <linux-pm+bounces-40529-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 639C7D08470
	for <lists+linux-pm@lfdr.de>; Fri, 09 Jan 2026 10:43:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id AEF2030B3707
	for <lists+linux-pm@lfdr.de>; Fri,  9 Jan 2026 09:38:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3AE4A3590DD;
	Fri,  9 Jan 2026 09:38:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="m/J/ZksX"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12BD5332EB8;
	Fri,  9 Jan 2026 09:38:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767951519; cv=none; b=hgEd1c3U4TEmn4q/gbhu79lztcqgISHU6RSVsJ+EtiLZy/b3eiQA/F8ChFKeguEItWzpvStWx1437pjZtz5wYenhUbeqnSYWcK9sS8KcCfS/3t3r1svCCZPjaQDV/dHC96LVfMPRGpIxiYPb7lsbEMDeNhouJTJ+OFnv3Sma3tw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767951519; c=relaxed/simple;
	bh=tegkIuDCR5AnbPfPf1lo3yVzsYelRzcYlX+qImnmmX0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=klQR4UYgq6Cx2ZnsM+W3gzJkoyzF4LY2OkvzwmFz0jZLkZWD336JirpQCYNYJxFpjXdNXHDQnLdIavWFYxVedFYMrHpfeyTlXDAtfZxmGB7NW0wAwDP6DaEbwr7GVzAMvXsNiwnPliDe1OJQzXajMgeAxrl4R4e2nyP+3UG2HxY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=m/J/ZksX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3AE24C4CEF1;
	Fri,  9 Jan 2026 09:38:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767951518;
	bh=tegkIuDCR5AnbPfPf1lo3yVzsYelRzcYlX+qImnmmX0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=m/J/ZksX1294b1CnoBjpds7r/vXco/NRKMCnf7lerTgIP6cy2wvdKzwS7836h6QgZ
	 ZdgbesgtSbRuCWD4fjPwlbGgojP40UsAR/AEDhc0kf4EX5rMGgsHSK5wt0A/QFBse1
	 DyA5Ts2PIexQTtS0tyu4OPecSGU4yw4IZ1JeRAuVjWxIvfOpgylsvmT689Wo6nDt2N
	 H7qdZXwBvPy/dCqTZc0yCl1pK7NWCman+vnA84Ns/jimniuopXQ1kNiaFyZzvTZIgV
	 8bGfwmtf5De9YE7yUQOjhXMRtF+8Qp2RTI0PkH2hSDZWIK9QcWm9xFZQQJuq9qi0Yr
	 uQ/hhpnz3xg1g==
Date: Fri, 9 Jan 2026 09:38:31 +0000
From: Lee Jones <lee@kernel.org>
To: Matti Vaittinen <mazziesaccount@gmail.com>
Cc: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
	Pavel Machek <pavel@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Sebastian Reichel <sre@kernel.org>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>, Linus Walleij <linusw@kernel.org>,
	Bartosz Golaszewski <brgl@kernel.org>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	linux-leds@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
	linux-clk@vger.kernel.org, linux-gpio@vger.kernel.org,
	linux-rtc@vger.kernel.org, Andreas Kemnade <andreas@kemnade.info>
Subject: Re: [PATCH RESEND v6 00/17] Support ROHM BD72720 PMIC
Message-ID: <20260109093831.GB1118061@google.com>
References: <cover.1765804226.git.mazziesaccount@gmail.com>
 <20260108172735.GK302752@google.com>
 <63bc889a-b97e-43c3-9f46-9ca444873b70@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <63bc889a-b97e-43c3-9f46-9ca444873b70@gmail.com>

Sebastian,

  Any thoughts?

Matti,

  If Sebastian doesn't reply, I can execute your plan next week.

On Fri, 09 Jan 2026, Matti Vaittinen wrote:
> On 08/01/2026 19:27, Lee Jones wrote:
> > On Mon, 15 Dec 2025, Matti Vaittinen wrote:
> > 
> > > Resending the v6
> > > 
> > > Series is same as v6 _except_ being rebased on v6.19-rc1 - and adding rb
> > > tags which were replied to v6.
> > > 
> > > The ROHM BD72720 is a new power management IC for portable, battery
> > > powered devices. It integrates 10 BUCKs and 11 LDOs, RTC, charger, LEDs,
> > > GPIOs and a clock gate. To me the BD72720 seems like a successor to the
> > > BD71828 and BD71815 PMICs.
> > > 
> > > This series depends on
> > > 5bff79dad20a ("power: supply: Add bd718(15/28/78) charger driver")
> > > which is in power-supply tree, for-next. Thus, the series is based on
> > > it.
> > > 
> > > The testing since v4 has suffered some hardware-issues after I
> > > accidentally enabled charging while the PMIC's battery pin was connected
> > > to the I/O domain. Some heat was generated, not terribly lot smoke
> > > though...
> > > 
> > > After the incident I've had occasional I2C failures. I, however, suspect
> > > the root cause is HW damage in I/O lines.
> > > 
> > > Revision history:
> > >    v6 resend:
> > >    - Rebased on v6.19-rc1 and collected rb-tags from v6.
> > > 
> > >    v5 => v6:
> > >    - MFD fixes as suggested by Lee
> > >      - Styling mostly
> > >      - New patch to Fix comment style for MFD driver
> > >    More accurate changelog in individual patches
> > > 
> > >    v4 => v5:
> > >    - dt-binding fixes as discussed in v4 reviews.
> > >      - Drop rohm,vdr-battery.yaml and add vdr properties to battery.yaml
> > >      - Drop 'rohm,' -vendor-prefix from vdr properties
> > >    - Link to v4:
> > >      https://lore.kernel.org/all/cover.1763022807.git.mazziesaccount@gmail.com/
> > >    More accurate changelog in individual patches
> > > 
> > >    v3 => v4:
> > >    - dt-binding fixes to the BD72720 MFD example and regulator bindings
> > >    More accurate changelog in individual patches
> > > 
> > >    v2 => v3:
> > >    - rebased to power-supply/for-next as dependencies are merged to there
> > >    - plenty of dt-binding changes as suggested by reviewers
> > >    - add new patch to better document existing 'trickle-charging' property
> > >    More accurate changelog in individual patches
> > > 
> > >    RFCv1 => v2:
> > >    - Drop RFC status
> > >    - Use stacked regmaps to hide secondary map from the sub-drivers
> > >    - Quite a few styling fixes and improvements as suggested by
> > >      reviewers. More accurate changelog in individual patches.
> > >    - Link to v1:
> > >      https://lore.kernel.org/all/cover.1759824376.git.mazziesaccount@gmail.com/
> > > 
> > > ---
> > > 
> > > Matti Vaittinen (17):
> > >    dt-bindings: regulator: ROHM BD72720
> > >    dt-bindings: battery: Clarify trickle-charge
> > >    dt-bindings: battery: Add trickle-charge upper limit
> > >    dt-bindings: battery: Voltage drop properties
> > >    dt-bindings: mfd: ROHM BD72720
> > >    dt-bindings: leds: bd72720: Add BD72720
> > >    mfd: rohm-bd71828: Use regmap_reg_range()
> > >    mfd: rohm-bd71828: Use standard file header format
> > >    mfd: rohm-bd71828: Support ROHM BD72720
> > >    regulator: bd71828: rename IC specific entities
> > >    regulator: bd71828: Support ROHM BD72720
> > >    gpio: Support ROHM BD72720 gpios
> > >    clk: clk-bd718x7: Support BD72720 clk gate
> > >    rtc: bd70528: Support BD72720 rtc
> > >    power: supply: bd71828: Support wider register addresses
> > >    power: supply: bd71828-power: Support ROHM BD72720
> > >    MAINTAINERS: Add ROHM BD72720 PMIC
> > > 
> > >   .../bindings/leds/rohm,bd71828-leds.yaml      |    7 +-
> > >   .../bindings/mfd/rohm,bd72720-pmic.yaml       |  339 ++++++
> > >   .../bindings/power/supply/battery.yaml        |   33 +-
> > >   .../regulator/rohm,bd72720-regulator.yaml     |  148 +++
> > >   MAINTAINERS                                   |    2 +
> > >   drivers/clk/Kconfig                           |    4 +-
> > >   drivers/clk/clk-bd718x7.c                     |   10 +-
> > >   drivers/gpio/Kconfig                          |    9 +
> > >   drivers/gpio/Makefile                         |    1 +
> > >   drivers/gpio/gpio-bd72720.c                   |  281 +++++
> > >   drivers/mfd/Kconfig                           |   18 +-
> > >   drivers/mfd/rohm-bd71828.c                    |  555 ++++++++-
> > >   drivers/power/supply/bd71828-power.c          |  160 ++-
> > >   drivers/regulator/Kconfig                     |    8 +-
> > >   drivers/regulator/bd71828-regulator.c         | 1025 ++++++++++++++++-
> > >   drivers/rtc/Kconfig                           |    3 +-
> > >   drivers/rtc/rtc-bd70528.c                     |   21 +-
> > >   include/linux/mfd/rohm-bd72720.h              |  634 ++++++++++
> > >   include/linux/mfd/rohm-generic.h              |    1 +
> > >   19 files changed, 3127 insertions(+), 132 deletions(-)
> > >   create mode 100644 Documentation/devicetree/bindings/mfd/rohm,bd72720-pmic.yaml
> > >   create mode 100644 Documentation/devicetree/bindings/regulator/rohm,bd72720-regulator.yaml
> > >   create mode 100644 drivers/gpio/gpio-bd72720.c
> > >   create mode 100644 include/linux/mfd/rohm-bd72720.h
> > 
> > The MFD parts LGTM.
> 
> Thanks Lee!
> 
> > What Acks are you waiting on?  What's the merge strategy?
> 
> I think everything else has been acked by maintainers, except the
> power-supply parts. I think those have only been looked at by Andreas and
> Linus W. Haven't heard anything from Sebastian :(
> 
> I would love to see the patches 1 - 14 and 17 to be merged (via MFD?). I
> could then re-spin the 15 and 16 to limited audience as I hope Sebastian had
> time to take a look at them. However, I don't think any of the other patches
> in the series depend on the last .
> 
> Yours,
>  -- Matti.
> 
> 
> ---
> Matti Vaittinen
> Linux kernel developer at ROHM Semiconductors
> Oulu Finland
> 
> ~~ When things go utterly wrong vim users can always type :help! ~~

-- 
Lee Jones [李琼斯]

