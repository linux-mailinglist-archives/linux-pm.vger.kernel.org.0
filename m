Return-Path: <linux-pm+bounces-19631-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B87109FA171
	for <lists+linux-pm@lfdr.de>; Sat, 21 Dec 2024 16:54:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1DB681664B6
	for <lists+linux-pm@lfdr.de>; Sat, 21 Dec 2024 15:54:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD5C413B288;
	Sat, 21 Dec 2024 15:54:05 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 882EFEAD0;
	Sat, 21 Dec 2024 15:54:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734796445; cv=none; b=rtD7cydpUE/de5d6UuUAWycnSRRg+72tk7YTP2UY3uAl5jYKh/iRB5EGbiG2s88eVV0nyOrJZ9vqFvUcKMKftZpULbEI/UDbCUmTVmJtxsvGxeSMM2taNpYgQkjHMjM5U8QyXanLSPhdHcII9VV9e1GKv7gAn8coZ/O0eAR0apE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734796445; c=relaxed/simple;
	bh=vyRtMFDT4geHX0qT5WzyKhX2e4X3f8X3jT0FAttjmlE=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=FQjt4BYnrh04ZhhA1FL5ntcvi8RrBy9FK6Fwb+SMVkYGVe9lIx6sqxLVRGX110BbVOSVkUNYpH6CBBTIswV6HKCKj83gK+HrOvMAxWP/CG2W1Kji0JaGd9s3dQ7+a3hjQg+5Ao/KBmxkzt+yZhG5BYe3WHDq10uY8C757TcIp9I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F1653C4CECE;
	Sat, 21 Dec 2024 15:54:04 +0000 (UTC)
Received: by mercury (Postfix, from userid 1000)
	id 93B621060349; Sat, 21 Dec 2024 16:54:02 +0100 (CET)
From: Sebastian Reichel <sebastian.reichel@collabora.com>
To: Sebastian Reichel <sre@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Dimitri Fedrau <dimitri.fedrau@liebherr.com>
Cc: linux-pm@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Dimitri Fedrau <dima.fedrau@gmail.com>, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20241218-default-charge-current-limit-v3-0-b26118cf06b5@liebherr.com>
References: <20241218-default-charge-current-limit-v3-0-b26118cf06b5@liebherr.com>
Subject: Re: [PATCH v3 0/2] power: supply: gpio-charger: add support for
 default charge current limit
Message-Id: <173479644258.3359498.1738381706387831556.b4-ty@collabora.com>
Date: Sat, 21 Dec 2024 16:54:02 +0100
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.2


On Wed, 18 Dec 2024 09:34:59 +0100, Dimitri Fedrau wrote:
> With DT properties charge-current-limit-gpios and
> charge-current-limit-mapping one can define charge current limits in uA
> using up to 32 GPIOs. At the moment the driver defaults to smallest charge
> current limitation for safety reasons. When disabling charging is
> supported, which should be common, the driver defaults to non charging on
> probe. By having a default, charging can be enabled on probe for such
> devices.
> 
> [...]

Applied, thanks!

[1/2] dt-bindings: power: supply: gpio-charger: add support for default charge current limit
      commit: 0a219d6fd7ab89177a6fa49539def43694154d50
[2/2] power: supply: gpio-charger: add support for default charge current limit
      commit: de68987480cb92702eab14cf62ec2aa1bae5c867

Best regards,
-- 
Sebastian Reichel <sebastian.reichel@collabora.com>


