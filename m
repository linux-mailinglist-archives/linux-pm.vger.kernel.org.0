Return-Path: <linux-pm+bounces-34038-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B7F58B4675C
	for <lists+linux-pm@lfdr.de>; Sat,  6 Sep 2025 01:59:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3D23F56573E
	for <lists+linux-pm@lfdr.de>; Fri,  5 Sep 2025 23:59:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B33C29D28E;
	Fri,  5 Sep 2025 23:59:39 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6336029ACF7
	for <linux-pm@vger.kernel.org>; Fri,  5 Sep 2025 23:59:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757116779; cv=none; b=RuDSxG9mVzuRu5Lz2XuwgfdhAUeSp3fnRRXGst9zCC+j5EVXFo+P8F4knH4GQx9GvDdb1PR/VIfqhbnmLnHeCtmduNwKg7XI9h64mGgD2WVG2BV+zpZiJQhp/GpFNiiXfJk9Ebw7wlnRh/GliZB0EdC7U2DzWCML9A02GKes+L0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757116779; c=relaxed/simple;
	bh=xIteAZGCpHzoSG0o3uyXBZR7H67glW00HHeW4A/v0Kw=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=hrvtTYev9M30QAEBjiXE7Y1ieHWmUkS259obo/QO4wKihAjLhE+EMzvUxJHUMCZixPQYMfMlBAmapZ1ghtTbxUs+8UUR9ZinU7NIZ270cLfgDS1GOJJU6Os8OpREvkMYr4NJlXa8OD84OCt9sAqRkLYCHdM4ihtmbRaBjMT6Wm0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 25568C4CEF1;
	Fri,  5 Sep 2025 23:59:39 +0000 (UTC)
Received: by venus (Postfix, from userid 1000)
	id 0D06C180B21; Sat, 06 Sep 2025 01:59:37 +0200 (CEST)
From: Sebastian Reichel <sebastian.reichel@collabora.com>
To: Sebastian Reichel <sre@kernel.org>, 
 Linus Walleij <linus.walleij@linaro.org>, Hans de Goede <hansg@kernel.org>
Cc: linux-pm@vger.kernel.org
In-Reply-To: <20250831122942.47875-1-hansg@kernel.org>
References: <20250831122942.47875-1-hansg@kernel.org>
Subject: Re: [PATCH v4 0/5] power: supply: Add adc-battery-helper lib and
 Intel Dollar Cove TI CC battery driver
Message-Id: <175711677703.112348.4451455425913970382.b4-ty@collabora.com>
Date: Sat, 06 Sep 2025 01:59:37 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.2


On Sun, 31 Aug 2025 14:29:36 +0200, Hans de Goede wrote:
> Here is a patch-series which primary goal is to add support for
> using the coulomb-counter in the Intel Dollar Cove TI PMIC as
> battery power-supply class device.
> 
> This PMIC used on some Intel Bay/Cherry Trail systems has some builtin
> fuel-gauge functionality which just like the UG3105 fuel-gauge is not
> a full featured autonomous fuel-gauge.
> 
> [...]

Applied, thanks!

[1/5] power: supply: Add adc-battery-helper
      commit: 6a93f54333979c2948e9c1e71ea0b377b486a3f5
[2/5] power: supply: ug3105_battery: Switch to adc-battery-helper
      commit: dcf1e7b73797399f8706226c7ff6ad8f18634db4
[3/5] power: supply: ug3105_battery: Put FG in standby on remove and shutdown
      commit: eede3f72a9658a3c82725ed36723d3189a91b3e5
[4/5] power: supply: adc-battery-helper: Add support for optional charge_finished GPIO
      commit: 926b144366c589a0c0c471d02a71590ed24284e0
[5/5] power: supply: Add new Intel Dollar Cove TI battery driver
      commit: 8c5795fe55278fa6a656bf4a0398fb22d5079298

Best regards,
-- 
Sebastian Reichel <sebastian.reichel@collabora.com>


