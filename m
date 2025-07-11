Return-Path: <linux-pm+bounces-30672-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C40EB01946
	for <lists+linux-pm@lfdr.de>; Fri, 11 Jul 2025 12:04:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2DD5F6417D1
	for <lists+linux-pm@lfdr.de>; Fri, 11 Jul 2025 10:04:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42CF827E1AC;
	Fri, 11 Jul 2025 10:04:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=geanix.com header.i=@geanix.com header.b="ExkwTmor"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-10626.protonmail.ch (mail-10626.protonmail.ch [79.135.106.26])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF4A427055F;
	Fri, 11 Jul 2025 10:04:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.135.106.26
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752228289; cv=none; b=NPQPee8dLabgngJ37cvKFhvdknEJZUkcOe12xihCoR3kss2FgLwRcrahTtzN1i0s7RBNCYzIJOlEQJSeO2PuO4E3MZGr20yeVBA/lGp6yiXJUUYAEi++7ti8el9+RcqpMXKZgZO2LF5CpjzT7Ak4CQAssXnNmh2snS+b/K5ZH9o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752228289; c=relaxed/simple;
	bh=y6SFqHAsZ+1U0g+VQ10xtYYL0E22g1zsauVndKyBnmI=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hU2oz+kjAFnyf0YwM7xUchnypFm4IxnJ8h8EPPaNBvxJHlqpSngQujNcZz7aTil4+d0ncxNyyf7RwZIl6/bPdrP7ww1f7SLABET7AaWBK7MOmL4/f75lbJMTp6TQuK+VKX3Qnefoq+FElXXR+v+yY/kL2tSpqzcurVC26Pkxz/I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=geanix.com; spf=pass smtp.mailfrom=geanix.com; dkim=pass (2048-bit key) header.d=geanix.com header.i=@geanix.com header.b=ExkwTmor; arc=none smtp.client-ip=79.135.106.26
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=geanix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=geanix.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=geanix.com;
	s=protonmail; t=1752228284; x=1752487484;
	bh=y6SFqHAsZ+1U0g+VQ10xtYYL0E22g1zsauVndKyBnmI=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=ExkwTmorolutl9yXI6Y6f121KdON4optTi7BFgVYWDpu1r8l4OzkcKMq1CtHCpZ1+
	 rerw/LMWyVY0Y4DQnGFG0LQVivfTYPS3XXO9p07v+SVtPKQuK9nNLhCzb7jgysy/In
	 ue6nnnZpSFangiLRpIFwkwdadR0EMUtZjm7vgPotf9MHP6IcF+eHOu8ZaoGdjcfbcu
	 YzQ41fk8WGap0SpyP4ayowPQVPJcnrurwpNnc5uzCKxL9fuULCDF8sqI+5hwAeiGZ1
	 tyidWHvtlpXo8aIqot37nGHQjVkIc0lEMFs7dwaSt/ryYnjzwZ4UdyCTppbbvNydol
	 BmYEGoZh8I/Ug==
Date: Fri, 11 Jul 2025 10:04:40 +0000
To: Samuel Kayode <samuel.kayode@savoirfairelinux.com>
From: Sean Nyekjaer <sean@geanix.com>
Cc: Lee Jones <lee@kernel.org>, Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Sebastian Reichel <sre@kernel.org>, Frank Li <Frank.li@nxp.com>, imx@lists.linux.dev, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-input@vger.kernel.org, linux-pm@vger.kernel.org, Abel Vesa <abelvesa@kernel.org>, Abel Vesa <abelvesa@linux.com>, Robin Gong <b38343@freescale.com>, Robin Gong <yibin.gong@nxp.com>, Enric Balletbo i Serra <eballetbo@gmail.com>
Subject: Re: [PATCH v8 3/6] regulator: pf1550: add support for regulator
Message-ID: <qnaduioo2qqt25k5zv5dpwne7s4a6zph6ma2dsnospex7fnrar@drnpfuel7ipe>
In-Reply-To: <20250707-pf1550-v8-3-6b6eb67c03a0@savoirfairelinux.com>
References: <20250707-pf1550-v8-0-6b6eb67c03a0@savoirfairelinux.com> <20250707-pf1550-v8-3-6b6eb67c03a0@savoirfairelinux.com>
Feedback-ID: 134068486:user:proton
X-Pm-Message-ID: 888c58051b555ccdfcba7c9369c9eab466ff9121
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 07, 2025 at 05:37:22PM +0100, Samuel Kayode wrote:
> Add regulator support for the pf1550 PMIC.
>=20
> Reviewed-by: Frank Li <Frank.Li@nxp.com>
> Reviewed-by: Mark Brown <broonie@kernel.org>
> Signed-off-by: Samuel Kayode <samuel.kayode@savoirfairelinux.com>
> ---

[...]

> +
> +struct pf1550_desc {
> +=09struct regulator_desc desc;
> +=09unsigned char stby_reg;
> +=09unsigned char stby_mask;
> +};
> +

I would suggest doing support for the stby voltages. We are using them
to lower consumption in suspend.

From the devicetree we configure:
regulator-suspend-min-microvolt, regulator-suspend-max-microvolt,
regulator-off-in-suspend and/or regulator-on-in-suspend

/Sean


