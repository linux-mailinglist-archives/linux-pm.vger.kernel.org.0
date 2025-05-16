Return-Path: <linux-pm+bounces-27246-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 21FCDABA35B
	for <lists+linux-pm@lfdr.de>; Fri, 16 May 2025 21:01:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3D5EE7BA157
	for <lists+linux-pm@lfdr.de>; Fri, 16 May 2025 18:58:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3E7D27E7E3;
	Fri, 16 May 2025 18:59:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=savoirfairelinux.com header.i=@savoirfairelinux.com header.b="Csrpz0zK"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail.savoirfairelinux.com (mail.savoirfairelinux.com [208.88.110.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B606227877B;
	Fri, 16 May 2025 18:59:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=208.88.110.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747421990; cv=none; b=ZTLQWJoah0q3bYA0BpAegkZB6G799zcZNALY+0vXZTbx+hd9ptZT45hzxQM3RdFqbvUZLK0dQDWNALE0yTWqrjG9+VUBC7963qf1NI4Xmq4rR77bp0I9LXuZdoSjwDBQV959BfhnUJYTMEbVBbEVThYQVYIKStBG0KrWx2IN+IE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747421990; c=relaxed/simple;
	bh=swrCwTCJwdCf9VihlOAGGi4mfNGnvNmwyD5bSuDHA7Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jWwGXrSSXLE4E3W3QlHiSXq8OTO9WrYiR2/ZHfjasV2Zp/q1CmMRIO7TuOslQfAhzapzFCdujx0H/jo9/uVIb+CMWXu6Pm8pHttq071JSz8b6VE9iOSRvU9IfEYawotFxxBfoOdgTAqyYJYM1Vhf4fpImPgMb4s9O0iVeHMv+RI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=savoirfairelinux.com; spf=pass smtp.mailfrom=savoirfairelinux.com; dkim=pass (2048-bit key) header.d=savoirfairelinux.com header.i=@savoirfairelinux.com header.b=Csrpz0zK; arc=none smtp.client-ip=208.88.110.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=savoirfairelinux.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=savoirfairelinux.com
Received: from localhost (localhost [127.0.0.1])
	by mail.savoirfairelinux.com (Postfix) with ESMTP id 28B2F9C8F7E;
	Fri, 16 May 2025 14:59:48 -0400 (EDT)
Received: from mail.savoirfairelinux.com ([127.0.0.1])
 by localhost (mail.savoirfairelinux.com [127.0.0.1]) (amavis, port 10032)
 with ESMTP id 1reGsXikKs3U; Fri, 16 May 2025 14:59:47 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
	by mail.savoirfairelinux.com (Postfix) with ESMTP id D06059C9075;
	Fri, 16 May 2025 14:59:47 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.savoirfairelinux.com D06059C9075
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=savoirfairelinux.com; s=DFC430D2-D198-11EC-948E-34200CB392D2;
	t=1747421987; bh=9OoOy4dtOfG1lBzq2Yefv93xoOX5XO79MnGP7IoKEW8=;
	h=Date:From:To:Message-ID:MIME-Version;
	b=Csrpz0zK1jYdu6OrxeGn547O2vstEBYLQ+Njymdvlr1vvjHvtims1FM9vkUbxhw12
	 FplJAT32WC6KM0Jf9rIBmKdWKU86S1+NT3DcTQvuoGS67yWWaGSKrSCdDIwNu96rIA
	 X3uiFU9kHlZB7MUJkTS96FSKKpd6EHpNItRidoLja/1Z050yY0rQJ5oh1ae5BBq8U+
	 Yhi/AkUV6z1JvsmGAGh+PK3981acaVqpxzhOJbKACU7ULcfJB6e4cVjyxUbGacL6Ki
	 SvdjU6dy+c/Vffu1obQXaQwi/F6FRe7Q/7vRzlS/T2CbNbtvJXSWfo022GACHhTDcb
	 W51TU1SsWJtsA==
X-Virus-Scanned: amavis at mail.savoirfairelinux.com
Received: from mail.savoirfairelinux.com ([127.0.0.1])
 by localhost (mail.savoirfairelinux.com [127.0.0.1]) (amavis, port 10026)
 with ESMTP id 8Kb__3w9ZdtG; Fri, 16 May 2025 14:59:47 -0400 (EDT)
Received: from fedora (unknown [192.168.51.254])
	by mail.savoirfairelinux.com (Postfix) with ESMTPSA id B07589C9074;
	Fri, 16 May 2025 14:59:47 -0400 (EDT)
Date: Fri, 16 May 2025 14:59:46 -0400
From: Samuel Kayode <samuel.kayode@savoirfairelinux.com>
To: Lee Jones <lee@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Sebastian Reichel <sre@kernel.org>, Robin Gong <yibin.gong@nxp.com>
Cc: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
	linux-imx@nxp.com, linux-input@vger.kernel.org,
	Abel Vesa <abelvesa@linux.com>, Abel Vesa <abel.vesa@nxp.com>,
	Robin Gong <b38343@freescale.com>,
	Enric Balletbo Serra <eballetbo@gmail.com>
Subject: [PATCH v2 9/9] MAINTAINERS: add an entry for pf1550 mfd driver
Message-ID: <81134851dfaae350d15fe92ddddaf2c5c1bcb0b9.1747409892.git.samuel.kayode@savoirfairelinux.com>
References: <cover.1747409892.git.samuel.kayode@savoirfairelinux.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1747409892.git.samuel.kayode@savoirfairelinux.com>

Add MAINTAINERS entry for pf1550 PMIC.

Signed-off-by: Samuel Kayode <samuel.kayode@savoirfairelinux.com>
---
 MAINTAINERS | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 4084fb7c496b..62d121380f7f 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -17477,6 +17477,17 @@ F:	Documentation/devicetree/bindings/clock/imx*
 F:	drivers/clk/imx/
 F:	include/dt-bindings/clock/imx*
 
+NXP PF1550 PMIC MFD DRIVER
+M:	Samuel Kayode <samuel.kayode@savoirfairelinux.com>
+S:	Maintained
+F:	Documentation/devicetree/bindings/*/*pf1550.yaml
+F:	Documentation/devicetree/bindings/*/pf1550*.yaml
+F:	drivers/input/keyboard/pf1550_onkey.c
+F:	drivers/mfd/pf1550.c
+F:	drivers/power/supply/pf1550_charger.c
+F:	drivers/regulator/pf1550_regulator.c
+F:	include/linux/mfd/pfd1550.h
+
 NXP PF8100/PF8121A/PF8200 PMIC REGULATOR DEVICE DRIVER
 M:	Jagan Teki <jagan@amarulasolutions.com>
 S:	Maintained
-- 
2.49.0


