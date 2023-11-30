Return-Path: <linux-pm+bounces-573-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CDC47FF83C
	for <lists+linux-pm@lfdr.de>; Thu, 30 Nov 2023 18:29:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4DD0B1C20CED
	for <lists+linux-pm@lfdr.de>; Thu, 30 Nov 2023 17:29:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 189BC56769;
	Thu, 30 Nov 2023 17:29:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Rx7NvTbK"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAC2B47A5A;
	Thu, 30 Nov 2023 17:29:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C0780C433C7;
	Thu, 30 Nov 2023 17:29:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701365394;
	bh=CGVx+2n0YKD8TyrFO2KT/eMDvxvOB0hmUQofIVVG7Ws=;
	h=From:To:Cc:Subject:Date:From;
	b=Rx7NvTbK1mO8HwfIB1WJ7b93AOTeGFBOCM4I4tnu5zwYEdxILp+hJn2hBtbamMJ7C
	 i254P+xp9ooGvS/cG/8UA7HRgMqBxuWCaT59vwHwe+jbInaaXQTW7xdyoc9dLwszZO
	 5NaFW+gKn3Of96r2LDkMabQSPHk0v6fBfpFg2SV34ERiJej6dI/4YollrSrUySvEkb
	 C2ipD1kTjxbxCS+KdZ7ogNV9ESemFwEdrnMxVaPLtcpPHQQH9O+30BJ68y2jr1IxK5
	 UtjbH5uGT5mSPUCy3c81DgxUiEgzgcJU35pmfl3wcxxEmY8Jf7Z5ESAJGjT1fkZ8OT
	 kid9zSpQd8L8w==
Received: from johan by xi.lan with local (Exim 4.96.2)
	(envelope-from <johan+linaro@kernel.org>)
	id 1r8krs-0003JO-0X;
	Thu, 30 Nov 2023 18:30:28 +0100
From: Johan Hovold <johan+linaro@kernel.org>
To: Sebastian Reichel <sre@kernel.org>
Cc: Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Vinod Koul <vkoul@kernel.org>,
	linux-pm@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Johan Hovold <johan+linaro@kernel.org>
Subject: [PATCH] dt-bindings: power: reset: qcom-pon: fix inconsistent example
Date: Thu, 30 Nov 2023 18:30:17 +0100
Message-ID: <20231130173017.12723-1-johan+linaro@kernel.org>
X-Mailer: git-send-email 2.41.0
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The current PON example is a bit of a mess after converting the binding
document to yaml and in the process updating parts of the example to
match the pmk8350 binding while leaving parts from the older pm8998
example in place.

Clean up the example and make it consistent by adding some newline
separators; dropping labels; removing stray spaces; fixing the PON node
name; and fixing the unit address so that it matches the interrupt
specifiers (which re-encodes the PON base address, 0x800 => 0x8).

Fixes: 76ba1900cb67 ("dt-bindings: power: reset: qcom-pon: Convert qcom PON binding to yaml")
Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
---
 .../devicetree/bindings/power/reset/qcom,pon.yaml   | 13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

diff --git a/Documentation/devicetree/bindings/power/reset/qcom,pon.yaml b/Documentation/devicetree/bindings/power/reset/qcom,pon.yaml
index 5e460128b0d1..fc8105a7b9b2 100644
--- a/Documentation/devicetree/bindings/power/reset/qcom,pon.yaml
+++ b/Documentation/devicetree/bindings/power/reset/qcom,pon.yaml
@@ -111,21 +111,24 @@ examples:
    #include <dt-bindings/interrupt-controller/irq.h>
    #include <dt-bindings/input/linux-event-codes.h>
    #include <dt-bindings/spmi/spmi.h>
-   spmi_bus: spmi@c440000 {
+
+   spmi@c440000 {
      reg = <0x0c440000 0x1100>;
      #address-cells = <2>;
      #size-cells = <0>;
-     pmk8350: pmic@0 {
+
+     pmic@0 {
        reg = <0x0 SPMI_USID>;
        #address-cells = <1>;
        #size-cells = <0>;
-       pmk8350_pon: pon_hlos@1300 {
-         reg = <0x1300>;
+
+       pon@800 {
          compatible = "qcom,pm8998-pon";
+         reg = <0x800>;
 
          pwrkey {
             compatible = "qcom,pm8941-pwrkey";
-            interrupts = < 0x0 0x8 0 IRQ_TYPE_EDGE_BOTH >;
+            interrupts = <0x0 0x8 0 IRQ_TYPE_EDGE_BOTH>;
             debounce = <15625>;
             bias-pull-up;
             linux,code = <KEY_POWER>;
-- 
2.41.0


