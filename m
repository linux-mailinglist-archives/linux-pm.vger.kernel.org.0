Return-Path: <linux-pm+bounces-33087-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id D2100B3553B
	for <lists+linux-pm@lfdr.de>; Tue, 26 Aug 2025 09:19:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id BB7904E25D1
	for <lists+linux-pm@lfdr.de>; Tue, 26 Aug 2025 07:19:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B9442F83D7;
	Tue, 26 Aug 2025 07:18:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uNIkFdiH"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 062492F657E;
	Tue, 26 Aug 2025 07:18:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756192718; cv=none; b=LLUMnHv9XzShXXQVC6I7tQ09fYNkXxuf2wvRyqNynrXImAZKYBij5/9m2lmsKwj3PM42Iq1uLB8VL/xtnP8OLXrntvPRTdhib4yposiWpTnNO2Wxb8I4ka+tdiyfa4He9bkRx6LWLrj0VUsBf3IZWR9dGZxBs89z3DwMuX/jCdE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756192718; c=relaxed/simple;
	bh=c9FpxhMbO0dHJY+8IwcerSUUGg4XtosdvIRtqr24ytw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=st8zRdlz7Qty4C+2Bqllypbla2Wv1riw0/B4G0UQ+rFVmuPRydOvUXm3+JZpSY3I15AtLiDc0I3kvDbWo2T6iL6SHhinnAdWBelrloEieFtMjQuJ9gK+QPG4dexXmPQjxf6MHJOFMP1pyH/OXe5O+eP45Ma9FoYsUAcclWaHcMk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uNIkFdiH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 80F54C2BCB4;
	Tue, 26 Aug 2025 07:18:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756192717;
	bh=c9FpxhMbO0dHJY+8IwcerSUUGg4XtosdvIRtqr24ytw=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=uNIkFdiHoF3Dq4lRSIfAawSrqom1FSmEVkQHS6tKlI/rzfQiBEqFSueUQhEaMQf/j
	 eP15kYpgfHtQUA8T72f8n59D9N4cdQH1e421F8KsxJn3YsTn4glKqUx8KXD1uKq80h
	 zoxgjGR64QQJo3ZKQBCx6iPqfkxyq/LRe/pullaq5czU/9b4KhGKNWrKG3aHvgyWWO
	 x85amhZb1IFqsY5qb0stcgms0pJ+heByC606ZAv1iBAX64qLVAS8kGIs4qKRyrtG7G
	 QEWV1M8Nk8jbuoTJr1CpBmk6A6ufxtLnz8fCGmVcFShVN+3Vh+hUlS6ETjiDqmkDTb
	 OYskWxFa+DgPA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75FB1CA0EFA;
	Tue, 26 Aug 2025 07:18:37 +0000 (UTC)
From: Fenglin Wu via B4 Relay <devnull+fenglin.wu.oss.qualcomm.com@kernel.org>
Date: Tue, 26 Aug 2025 15:18:33 +0800
Subject: [PATCH v3 6/8] dt-bindings: soc: qcom,pmic-glink: Add charge limit
 nvmem properties
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250826-qcom_battmgr_update-v3-6-74ea410ef146@oss.qualcomm.com>
References: <20250826-qcom_battmgr_update-v3-0-74ea410ef146@oss.qualcomm.com>
In-Reply-To: <20250826-qcom_battmgr_update-v3-0-74ea410ef146@oss.qualcomm.com>
To: Sebastian Reichel <sre@kernel.org>, 
 Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Heikki Krogerus <heikki.krogerus@linux.intel.com>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>, 
 Bryan O'Donoghue <bryan.odonoghue@linaro.org>, 
 Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Cc: Subbaraman Narayanamurthy <subbaraman.narayanamurthy@oss.qualcomm.com>, 
 David Collins <david.collins@oss.qualcomm.com>, 
 =?utf-8?q?Gy=C3=B6rgy_Kurucz?= <me@kuruczgy.com>, linux-pm@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org, 
 kernel@oss.qualcomm.com, devicetree@vger.kernel.org, 
 linux-usb@vger.kernel.org, Fenglin Wu <fenglin.wu@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1756192715; l=1445;
 i=fenglin.wu@oss.qualcomm.com; s=20240327; h=from:subject:message-id;
 bh=ORlAVczHQEA0etBKQz2CENwDXUZXd+9EuSntaMi9ZEE=;
 b=h48ys0f+qEB7+0uoFBLr92/XOO7t0htNP1CHWOiYkdaL5AJMU/ZtZxF0qrfgA+gMUrD7lbn/O
 p92TpiOpK2QAiirfCQsuKD8nqztmnaapvAua+H64T17OyqHbnXYXVgc
X-Developer-Key: i=fenglin.wu@oss.qualcomm.com; a=ed25519;
 pk=BF8SA4IVDk8/EBCwlBehKtn2hp6kipuuAuDAHh9s+K4=
X-Endpoint-Received: by B4 Relay for fenglin.wu@oss.qualcomm.com/20240327
 with auth_id=406
X-Original-From: Fenglin Wu <fenglin.wu@oss.qualcomm.com>
Reply-To: fenglin.wu@oss.qualcomm.com

From: Fenglin Wu <fenglin.wu@oss.qualcomm.com>

Add nvmem properties to retrieve charge control configurations
from the PMIC SDAM registers.

Signed-off-by: Fenglin Wu <fenglin.wu@oss.qualcomm.com>
---
 .../devicetree/bindings/soc/qcom/qcom,pmic-glink.yaml      | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/Documentation/devicetree/bindings/soc/qcom/qcom,pmic-glink.yaml b/Documentation/devicetree/bindings/soc/qcom/qcom,pmic-glink.yaml
index 4c9e78f29523e3d77aacb4299f64ab96f9b1a831..9d6db4825da389aa14d77f653d2f8a3442e22162 100644
--- a/Documentation/devicetree/bindings/soc/qcom/qcom,pmic-glink.yaml
+++ b/Documentation/devicetree/bindings/soc/qcom/qcom,pmic-glink.yaml
@@ -55,6 +55,20 @@ properties:
       The array should contain a gpio entry for each PMIC Glink connector, in reg order.
       It is defined that GPIO active level means "CC2" or Reversed/Flipped orientation.
 
+  nvmem-cells:
+    minItems: 3
+    maxItems: 3
+    description:
+      The nvmem cells contain the charge control settings, including the charge control
+      enable status, the battery state of charge (SoC) threshold for stopping charging,
+      and the battery SoC delta required to restart charging.
+
+  nvmem-cell-names:
+    items:
+      - const: charge_limit_en
+      - const: charge_limit_end
+      - const: charge_limit_delta
+
 patternProperties:
   '^connector@\d$':
     $ref: /schemas/connector/usb-connector.yaml#

-- 
2.34.1



