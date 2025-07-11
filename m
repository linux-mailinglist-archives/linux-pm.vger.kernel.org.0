Return-Path: <linux-pm+bounces-30677-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 57AFEB019CD
	for <lists+linux-pm@lfdr.de>; Fri, 11 Jul 2025 12:30:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7B3F33A4206
	for <lists+linux-pm@lfdr.de>; Fri, 11 Jul 2025 10:29:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDC0B283FDE;
	Fri, 11 Jul 2025 10:30:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=geanix.com header.i=@geanix.com header.b="c3q3XBJM"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-4317.protonmail.ch (mail-4317.protonmail.ch [185.70.43.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA865283FD8;
	Fri, 11 Jul 2025 10:30:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.43.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752229806; cv=none; b=fgEK5fsteoNZTmxEgErFZNNQxQAuYyTA8yOl7O5aRHT/VyvmBkTdno/gsnCDjJGjBcGqJW3We4uO2kf9zSQgQ/XGwKRQDkuBJtpVKFiO2i7n/Bmo+lTMpfAEgIBx0uN7oEGx4aG1jhWYptYU70Vw+EUO+bQNKnkDzbTF5SozJWI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752229806; c=relaxed/simple;
	bh=BlZYGeLVk6sKZh/Cirv9qZuN+C8hZCxVFfQI+hk+eAk=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KHx37jREezjbjM0xaNPf4zj9Dhc3ONqZAiTC8pPyGEiZc7teQkGFnfUBbXasXpOnbjE76rpDkdVlsM7HeY3jYP5e4CPQ+RN8D3M1TZz0Jrg6TllnJivq8dDUC+0d3BXp/UWtSguGIuZdQPBnIBKu3z5BxGeARq3YjxtOz5R3ErM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=geanix.com; spf=pass smtp.mailfrom=geanix.com; dkim=pass (2048-bit key) header.d=geanix.com header.i=@geanix.com header.b=c3q3XBJM; arc=none smtp.client-ip=185.70.43.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=geanix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=geanix.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=geanix.com;
	s=protonmail; t=1752229800; x=1752489000;
	bh=drFRM/G04HIxCGh+rRvAHzr+XceHmwxYmN2UfeW7nY0=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=c3q3XBJM1keQo1n12nbNO1um3iFv2g3RXN8Y/MTH+qfFdPowVIVCjBeeejq7/fxL6
	 uz47R0YX9KGRNJ//4S7+C70G9hUjv2iAPdl6iO1xdMERBL7qnrjhpDwnsCoSACxNRd
	 Xjh+Ai/2yP6xZE1jz+MjxONQaC93WxOTe/WX9lnJdISlC16CyksWFPRp5nc0Ely6o5
	 FiKBM3sBE3Fnqev14euFnKm/uP36GcGDBmucVPQUVfvpXYaY8w4iJm3oZ41MzaJ3J/
	 Zr9FFhS2tQ6qxAWwQnzMJmeRkMEPcEjXyggRHXDP8iFTUTBbewiaCqCFusWUSZD0mT
	 ngDF90DzOpT1g==
Date: Fri, 11 Jul 2025 10:29:59 +0000
To: Samuel Kayode <samuel.kayode@savoirfairelinux.com>
From: Sean Nyekjaer <sean@geanix.com>
Cc: Lee Jones <lee@kernel.org>, Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Sebastian Reichel <sre@kernel.org>, Frank Li <Frank.li@nxp.com>, imx@lists.linux.dev, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-input@vger.kernel.org, linux-pm@vger.kernel.org, Abel Vesa <abelvesa@kernel.org>, Abel Vesa <abelvesa@linux.com>, Robin Gong <b38343@freescale.com>, Robin Gong <yibin.gong@nxp.com>, Enric Balletbo i Serra <eballetbo@gmail.com>
Subject: Re: [PATCH v8 4/6] input: pf1550: add onkey support
Message-ID: <wlbsl36wju4kehhqtoprrcdaqlgkrmapp5ecw44jcnfv4fy7wk@m3wrnbl7yoqq>
In-Reply-To: <20250707-pf1550-v8-4-6b6eb67c03a0@savoirfairelinux.com>
References: <20250707-pf1550-v8-0-6b6eb67c03a0@savoirfairelinux.com> <20250707-pf1550-v8-4-6b6eb67c03a0@savoirfairelinux.com>
Feedback-ID: 134068486:user:proton
X-Pm-Message-ID: 3c555c7164f1d3f06d86bcc31b47c53ec776aca3
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 07, 2025 at 05:37:23PM +0100, Samuel Kayode wrote:
> Add support for the onkey of the pf1550 PMIC.
>=20
> Acked-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
> Reviewed-by: Frank Li <Frank.Li@nxp.com>
> Signed-off-by: Samuel Kayode <samuel.kayode@savoirfairelinux.com>
> ---

[...]

> +
> +static int pf1550_onkey_probe(struct platform_device *pdev)
> +{
> +=09struct onkey_drv_data *onkey;
> +=09struct input_dev *input;
> +=09int i, irq, error;
> +
> +=09onkey =3D devm_kzalloc(&pdev->dev, sizeof(*onkey), GFP_KERNEL);
> +=09if (!onkey)
> +=09=09return -ENOMEM;
> +
> +=09onkey->dev =3D &pdev->dev;
> +
> +=09onkey->pf1550 =3D dev_get_drvdata(pdev->dev.parent);
> +=09if (!onkey->pf1550->regmap)
> +=09=09return dev_err_probe(&pdev->dev, -ENODEV,
> +=09=09=09=09     "failed to get regmap\n");
> +
> +=09onkey->wakeup =3D device_property_read_bool(pdev->dev.parent,
> +=09=09=09=09=09=09  "wakeup-source");
> +

I would like support for ONKEY_RST_EN enable or disable via a
devicetree option.

/Sean


