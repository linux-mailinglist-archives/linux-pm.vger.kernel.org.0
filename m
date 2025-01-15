Return-Path: <linux-pm+bounces-20516-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 266DBA12E0D
	for <lists+linux-pm@lfdr.de>; Wed, 15 Jan 2025 23:02:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7A78E188A04F
	for <lists+linux-pm@lfdr.de>; Wed, 15 Jan 2025 22:02:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE5181DC075;
	Wed, 15 Jan 2025 22:02:42 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA38C14B959;
	Wed, 15 Jan 2025 22:02:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736978562; cv=none; b=i1IZTNZmx4Stz6Z/lOyWvOgqMuMXRgc4uEssA1d7UetuVsIb/vi+b7gp7Mvj+KylgwQPOqeeSwaXv02UznEvhr+ybJjiuHNtLKKt1c6wpt9bIYX+qVHM3PNo83eE0i2YPyOtuej9LpRBJyOwXW7kZbK1zzu2pjUWeaUrP6kG3Tc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736978562; c=relaxed/simple;
	bh=A4PUHxlZxbgltzbwqR8CeeZ9He115kcOxNe9Yg0dm4o=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=JAJtjGxGakhlfT4cZYNj2D6FMkvIO0yf9kElzTF1gBqHtA1JqpV6JO4iDJIZ5RBS2i8hp90LcBShnSZZOArUG4tsjRfKXsV1q/ySx2dpNYblSvGvIIf1wjns/UH5fa1UPbC9E1BLmGijWYyuekAxgQsRZ55COmowgly9dCy6afM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2FA92C4CED1;
	Wed, 15 Jan 2025 22:02:42 +0000 (UTC)
Received: by mercury (Postfix, from userid 1000)
	id E54491060351; Wed, 15 Jan 2025 23:02:39 +0100 (CET)
From: Sebastian Reichel <sebastian.reichel@collabora.com>
To: Sebastian Reichel <sre@kernel.org>, 
 Chanwoo Choi <cw00.choi@samsung.com>, Krzysztof Kozlowski <krzk@kernel.org>, 
 Lee Jones <lee@kernel.org>, Rob Herring <robh@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Dmitry Torokhov <dmitry.torokhov@gmail.com>, Pavel Machek <pavel@ucw.cz>, 
 Hans de Goede <hdegoede@redhat.com>, 
 Marek Szyprowski <m.szyprowski@samsung.com>, 
 Sebastian Krzyszkowiak <sebastian.krzyszkowiak@puri.sm>, 
 Purism Kernel Team <kernel@puri.sm>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Dzmitry Sankouski <dsankouski@gmail.com>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-input@vger.kernel.org, 
 linux-leds@vger.kernel.org, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20250108-starqltechn_integration_upstream-v14-0-f6e84ec20d96@gmail.com>
References: <20250108-starqltechn_integration_upstream-v14-0-f6e84ec20d96@gmail.com>
Subject: Re: (subset) [PATCH v14 00/10] Add support for Maxim Integrated
 MAX77705 PMIC
Message-Id: <173697855993.458200.2775823826977053864.b4-ty@collabora.com>
Date: Wed, 15 Jan 2025 23:02:39 +0100
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.14.2


On Wed, 08 Jan 2025 17:13:44 +0300, Dzmitry Sankouski wrote:
> The Maxim MAX77705 is a Companion Power Management and Type-C
> interface IC which includes charger, fuelgauge, LED, haptic motor driver and
> Type-C management IC. It's used in Samsung S series smart phones
> starting from S9 model.
> 
> Add features:
>   - charger
>   - fuelgauge
>   - haptic
>   - led
> 
> [...]

Applied, thanks!

[01/10] power: supply: add undervoltage health status property
        commit: df998c22321dde3f70cd3cf8c183dfd6bf64c759
[02/10] dt-bindings: power: supply: max17042: add max77705 support
        commit: 4519e13aef44269b0f8b6694a7adeb13d7d66b14
[05/10] power: supply: max17042: add max77705 fuel gauge support
        commit: 260d7c5e5392ac41c94152005d416172ba0a906d

Best regards,
-- 
Sebastian Reichel <sebastian.reichel@collabora.com>


