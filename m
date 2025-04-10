Return-Path: <linux-pm+bounces-25149-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 52F7BA848D7
	for <lists+linux-pm@lfdr.de>; Thu, 10 Apr 2025 17:56:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C5A2B4E6EE1
	for <lists+linux-pm@lfdr.de>; Thu, 10 Apr 2025 15:52:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9423B296158;
	Thu, 10 Apr 2025 15:48:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NDuyjHuA"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A83B29614C;
	Thu, 10 Apr 2025 15:48:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744300089; cv=none; b=MlP9EMALdBVkOguGLvu8KsG6SeQjCSB+/Co0vjYfYhZsCO+53z6d7x6zZmzhhPOZMRFnJRa9ROTffZuAkFt1D0eBCd8+zpTA7oL+NBYJzk20G2vlKt7ab8gciZyXIq5wKsc+Qa9nFm+7Aw5uNEL8pqACOVuZ3HuTjkT+kz/4+fo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744300089; c=relaxed/simple;
	bh=HIIKA21HRG0UMoa6Z5akxw0Rd/PBeaBOvNKebLyM4Fo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=UWUXFqcSKmvRlRfGJzY90iCbczcmTin6UAPgr64u4BiPesLTdiPcTi4RbDOfu0NrJZOAwMz18+yV4dy4ehNQmK+y0xpmK7AUyOPIDrIACPYogBCf5ZdLF0/GmASS76VxzjB2Tt6MSON/0HULmFrEFdimsVtMOHn1KttuoT8dDnI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NDuyjHuA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DDA26C4CEDD;
	Thu, 10 Apr 2025 15:48:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744300089;
	bh=HIIKA21HRG0UMoa6Z5akxw0Rd/PBeaBOvNKebLyM4Fo=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=NDuyjHuAfA6KjGorxG2uu7aOlrv9cSAfO+afdA6IkAmxInucrHnIseovaP9t5II0m
	 WEz7WVg0CpzfebCU948awd0ZQYWGd26CUcmNyGgwMekzzuOjtl2t3erSWy0NrwsK01
	 O9aVDq1O5lzEvp118vPWAaGTJL2aZ0GRDYuY+0y+5BefpFipNwJU8SA3QbSmrtm16D
	 jtoVcxXu62TgBYgsFNxHw6DCt2wJ6lNKnJOiwoFw3rN4TOTSjFsxWqp/b7Lbb5pJ1q
	 vAHEgDd4YWmKnC9K7XAW3kppXIg3wtlTHcJIz56fq4wS/0dDVRJPw0M1gvO+6y6LdY
	 lPwe8Fo4bUENA==
From: "Rob Herring (Arm)" <robh@kernel.org>
Date: Thu, 10 Apr 2025 10:47:37 -0500
Subject: [PATCH v2 16/17] dt-bindings: arm/cpus: Add power-domains
 constraints
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250410-dt-cpu-schema-v2-16-63d7dc9ddd0a@kernel.org>
References: <20250410-dt-cpu-schema-v2-0-63d7dc9ddd0a@kernel.org>
In-Reply-To: <20250410-dt-cpu-schema-v2-0-63d7dc9ddd0a@kernel.org>
To: Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Chen-Yu Tsai <wens@csie.org>, 
 Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Samuel Holland <samuel@sholland.org>, Conor Dooley <conor@kernel.org>, 
 Nicolas Ferre <nicolas.ferre@microchip.com>, 
 Claudiu Beznea <claudiu.beznea@tuxon.dev>, 
 Steen Hegelund <Steen.Hegelund@microchip.com>, 
 Daniel Machon <daniel.machon@microchip.com>, UNGLinuxDriver@microchip.com, 
 Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konradybcio@kernel.org>, Shawn Guo <shawnguo@kernel.org>, 
 Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>, Heiko Stuebner <heiko@sntech.de>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Kevin Hilman <khilman@baylibre.com>, Jerome Brunet <jbrunet@baylibre.com>, 
 Martin Blumenstingl <martin.blumenstingl@googlemail.com>, 
 Geert Uytterhoeven <geert+renesas@glider.be>, 
 Magnus Damm <magnus.damm@gmail.com>, 
 Lorenzo Pieralisi <lpieralisi@kernel.org>, Andy Gross <agross@kernel.org>, 
 Thomas Bogendoerfer <tsbogend@alpha.franken.de>, 
 Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>, 
 Stephen Boyd <sboyd@kernel.org>, zhouyanjie@wanyeetech.com, 
 Matthias Brugger <matthias.bgg@gmail.com>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
 "Rafael J. Wysocki" <rafael@kernel.org>, 
 Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>, 
 Stephan Gerhold <stephan.gerhold@linaro.org>
Cc: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org, 
 linux-arm-msm@vger.kernel.org, imx@lists.linux.dev, 
 linux-rockchip@lists.infradead.org, linux-amlogic@lists.infradead.org, 
 linux-renesas-soc@vger.kernel.org, linux-mips@vger.kernel.org, 
 linux-pm@vger.kernel.org, linux-mediatek@lists.infradead.org, 
 Ulf Hansson <ulf.hansson@linaro.org>, Sudeep Holla <sudeep.holla@arm.com>
X-Mailer: b4 0.15-dev

The "power-domains" and "power-domains-names" properties are missing any
constraints. Add the constraints and drop the generic descriptions.

Signed-off-by: Rob Herring (Arm) <robh@kernel.org>
Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Reviewed-by: Ulf Hansson <ulf.hansson@linaro.org>
Reviewed-by: Sudeep Holla <sudeep.holla@arm.com>
---
 Documentation/devicetree/bindings/arm/cpus.yaml | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/Documentation/devicetree/bindings/arm/cpus.yaml b/Documentation/devicetree/bindings/arm/cpus.yaml
index 3846f13ded5b..3d61313ca00e 100644
--- a/Documentation/devicetree/bindings/arm/cpus.yaml
+++ b/Documentation/devicetree/bindings/arm/cpus.yaml
@@ -313,19 +313,15 @@ properties:
     maxItems: 1
 
   power-domains:
-    description:
-      List of phandles and PM domain specifiers, as defined by bindings of the
-      PM domain provider (see also ../power_domain.txt).
+    maxItems: 1
 
   power-domain-names:
     description:
-      A list of power domain name strings sorted in the same order as the
-      power-domains property.
-
       For PSCI based platforms, the name corresponding to the index of the PSCI
       PM domain provider, must be "psci". For SCMI based platforms, the name
       corresponding to the index of an SCMI performance domain provider, must be
       "perf".
+    enum: [ psci, perf, cpr ]
 
   resets:
     maxItems: 1

-- 
2.47.2


