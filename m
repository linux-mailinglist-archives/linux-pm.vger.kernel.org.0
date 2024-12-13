Return-Path: <linux-pm+bounces-19214-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5ED179F15DD
	for <lists+linux-pm@lfdr.de>; Fri, 13 Dec 2024 20:32:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B84C17A075D
	for <lists+linux-pm@lfdr.de>; Fri, 13 Dec 2024 19:32:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E91581EB9F9;
	Fri, 13 Dec 2024 19:32:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="I8YosRjS"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC3831E8839;
	Fri, 13 Dec 2024 19:32:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734118361; cv=none; b=ZeR2di/y3RtkwEcG+eDxkYSPu1C7+tvPc/MhPUDhg7jCxHP9jLVPUww9KsaZDy0h8GHofVCHI+Rl/eU8dEcPyhnNlwl+OYJ1zLSbjFbeocCvsRxNOfAWep/hgzK6fGZNcpXjGr9DpUga3GEULjIK+CsmG1PPdyt4dUm+w+yRQZs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734118361; c=relaxed/simple;
	bh=Ud2wCa8TSYVfpnac2gkRPt80w1+N1OzZr1JJXuVpSps=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=N8YBeG2GDc/oCBvinnKLvHHh6KgqGezjEdNOOAU6HyToAUgZeKlRHEJwztDrOw2+OEKrsT5jG5YetFuSG3e+0zlTpoldgwYyIh5B7AQPvds+BK1bejEEG5KIaHgCUeuB5ejdTWr049AMXLWA9KHUVJhJoik5KkA9C0n09SvmiiE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=I8YosRjS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 3B406C4CED0;
	Fri, 13 Dec 2024 19:32:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734118361;
	bh=Ud2wCa8TSYVfpnac2gkRPt80w1+N1OzZr1JJXuVpSps=;
	h=From:Subject:Date:To:Cc:Reply-To:From;
	b=I8YosRjSmtSF1NqjJRGjx4HiqAwMLfQOv+bXjq9C6lacXhXPo3fthoCo9UzsvSIYZ
	 EUMx18t5oPjh7WM2f3wJy/xZ0H5DUdgetoxmnf21bbQcKtF9PaX5rXfzZqS99vaCnr
	 E03AJBu6jgi8riXWr5HgEWWuQzmBy9WnDvNSSk0tNysFc5rln3K4rXJfrvf2UyOKhs
	 YM/rHDaW9gcuRNms4Lq7qIb25Vp6QX9JLELEGpxlzu5E1Okr74Qh7aoAdL24/5XaJX
	 X8z5gfEm+iHfXVsYJCaY/Do985TU4U4c6LH4JNwhotI9Q48vTa7VPr3GTcRL2a/n4V
	 Kg3HLlDq3ZwDw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 266E6E7717F;
	Fri, 13 Dec 2024 19:32:41 +0000 (UTC)
From: Dimitri Fedrau via B4 Relay <devnull+dimitri.fedrau.liebherr.com@kernel.org>
Subject: [PATCH v2 0/2] power: supply: gpio-charger: add support for
 default charge current limit
Date: Fri, 13 Dec 2024 20:32:32 +0100
Message-Id: <20241213-default-charge-current-limit-v2-0-45886fce905c@liebherr.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIANCLXGcC/32Nyw6CMBBFf8XM2jGdBsG68j8MiwKDTMLDTAvRE
 P7dSly7PPck564QWIUDXA8rKC8SZBoT2OMB6s6PD0ZpEoM1NiNrHDbc+rmPmKwmW8+qPEbsZZC
 IufNcuOxscvKQEk/lVl57/l4m7iTESd/720Lf9Rcm+h9eCA0WF3KVNzmz9bdeuOpY9VRPA5Tbt
 n0AJHglm8sAAAA=
X-Change-ID: 20241209-default-charge-current-limit-69ae7945061a
To: Sebastian Reichel <sre@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-pm@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Dimitri Fedrau <dimitri.fedrau@liebherr.com>, 
 Dimitri Fedrau <dima.fedrau@gmail.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1734118360; l=1474;
 i=dimitri.fedrau@liebherr.com; s=20241202; h=from:subject:message-id;
 bh=Ud2wCa8TSYVfpnac2gkRPt80w1+N1OzZr1JJXuVpSps=;
 b=zf9bjiGiLdqbtu5VANIqnr1BgtHuGTzqBJeXJABZGOjH1vn14TO6pLAItRzl13cm+iFqeMyXN
 pARni1WA2NiB/AmeCBXVFbGouit8cuSLzBriVeHs7EiBsgiuvyzmPeT
X-Developer-Key: i=dimitri.fedrau@liebherr.com; a=ed25519;
 pk=rT653x09JSQvotxIqQl4/XiI4AOiBZrdOGvxDUbb5m8=
X-Endpoint-Received: by B4 Relay for dimitri.fedrau@liebherr.com/20241202
 with auth_id=290
X-Original-From: Dimitri Fedrau <dimitri.fedrau@liebherr.com>
Reply-To: dimitri.fedrau@liebherr.com

With DT properties charge-current-limit-gpios and
charge-current-limit-mapping one can define charge current limits in uA
using up to 32 GPIOs. At the moment the driver defaults to smallest charge
current limitation for safety reasons. When disabling charging is
supported, which should be common, the driver defaults to non charging on
probe. By having a default, charging can be enabled on probe for such
devices.

Signed-off-by: Dimitri Fedrau <dimitri.fedrau@liebherr.com>
---
Changes in v2:
- renamed DT property charge-current-limit-default to
  charge-current-limit-default-microamp
- Added dependency on charge-current-limit-mapping
- Added intention and use case to commit descriptions
- Added charge-current-limit-default-microamp in bindings example
- Link to v1: https://lore.kernel.org/r/20241211-default-charge-current-limit-v1-0-7819ba06ee2a@liebherr.com

---
Dimitri Fedrau (2):
      dt-bindings: power: supply: gpio-charger: add support for default charge current limit
      power: supply: gpio-charger: add support for default charge current limit

 .../devicetree/bindings/power/supply/gpio-charger.yaml      |  6 ++++++
 drivers/power/supply/gpio-charger.c                         | 13 +++++++++++++
 2 files changed, 19 insertions(+)
---
base-commit: 57cb041f61d4abcf8dfa41259df27d081ab4cb6a
change-id: 20241209-default-charge-current-limit-69ae7945061a

Best regards,
-- 
Dimitri Fedrau <dimitri.fedrau@liebherr.com>



