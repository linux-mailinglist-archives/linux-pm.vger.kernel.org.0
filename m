Return-Path: <linux-pm+bounces-34836-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 874A7B7E51A
	for <lists+linux-pm@lfdr.de>; Wed, 17 Sep 2025 14:47:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2D7AE482839
	for <lists+linux-pm@lfdr.de>; Wed, 17 Sep 2025 10:15:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6E8B34AAF2;
	Wed, 17 Sep 2025 10:15:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="vN9ANTZ1"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABDCC3093AD;
	Wed, 17 Sep 2025 10:15:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758104130; cv=none; b=C9sAgWINyQbFQw1k0ACjqHi+0D5M6QwsmR7MPwbgQOpte0It1b3+ihWxoZ4D9K4tSUU3Ae5D6GHHyc9/yCMCHKqTeqJcLjD9jJUlMUUIouuRu+tjPVNRYTzUEYNto3ouhqIefdmNfyPf+wi0jogUyPuKy/FDm96iizeNhCfnphg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758104130; c=relaxed/simple;
	bh=bOLuaeiwyaO3na4NY19nw0P80kbguhGdX5YRCs3cCc0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=KNeOCkW4MIwjfx5Jt0Q9RhatNjqR+3R1fdpTMAgtgslpJQNizLczVHeGZrq5/ejQM6lKOlMe/qle0O7omzHrt8N7yXi7LMnbO2yH6hS2KrjE6vOeSezUj2ZGvFfHfR6Xd0kJ5rYzphv5Rmz7wpUwNQvuzoe4hifvJ5ANJNReh9I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=vN9ANTZ1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 713F4C116B1;
	Wed, 17 Sep 2025 10:15:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758104130;
	bh=bOLuaeiwyaO3na4NY19nw0P80kbguhGdX5YRCs3cCc0=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=vN9ANTZ14V7lWA/MHAzhiQpzlL8OP8lZwgZPImjeVxxSwSEaKyB6rd0Ur2rBx1yf4
	 a0zgQyYuQ2peKArSuCqG9B74J3WEKpdRdhkAF9KF6hen+BFldPFW8Zitl/+iF4Zp5B
	 aeWS/+GwFAkDuCxlafaifgb8CDiSBKnhHKGvkJHnLA1WkIg77HmAwUoa3LnekY5+6W
	 mOF0npLn2eua+Lbf/ov+CF5QtUP1Y7MmOB0yzhGQ3FtsAq728nJeZ+zNfIiaAduypD
	 x4Pgd3V8yCWG1LcBnKIwrmJypaOAf2SmNK5id22OrXRcDr7BE/qa1LSqETa20NkV2J
	 dxHXe6ixxQQvw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6788FCAC5A0;
	Wed, 17 Sep 2025 10:15:30 +0000 (UTC)
From: Fenglin Wu via B4 Relay <devnull+fenglin.wu.oss.qualcomm.com@kernel.org>
Date: Wed, 17 Sep 2025 18:15:19 +0800
Subject: [PATCH v5 6/9] dt-bindings: soc: qcom,pmic-glink: Add charge limit
 nvmem properties
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250917-qcom_battmgr_update-v5-6-270ade9ffe13@oss.qualcomm.com>
References: <20250917-qcom_battmgr_update-v5-0-270ade9ffe13@oss.qualcomm.com>
In-Reply-To: <20250917-qcom_battmgr_update-v5-0-270ade9ffe13@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1758104128; l=1492;
 i=fenglin.wu@oss.qualcomm.com; s=20240327; h=from:subject:message-id;
 bh=syVkWNhKr/v3G53QSZl0QAKviU7LNwqoaGefZ15M1Gg=;
 b=hk7aW7xod0FO652j9fJjiP6d0Lw8GRt3CSfWPkWAGFgEpHLEtYfJsVC78uaV+KPAicyalsQja
 9NxNTkqR9m9Acc4vbyNkahOLZ9e3qAflwx8pAiirfFU9jNtoFB3m019
X-Developer-Key: i=fenglin.wu@oss.qualcomm.com; a=ed25519;
 pk=BF8SA4IVDk8/EBCwlBehKtn2hp6kipuuAuDAHh9s+K4=
X-Endpoint-Received: by B4 Relay for fenglin.wu@oss.qualcomm.com/20240327
 with auth_id=406
X-Original-From: Fenglin Wu <fenglin.wu@oss.qualcomm.com>
Reply-To: fenglin.wu@oss.qualcomm.com

From: Fenglin Wu <fenglin.wu@oss.qualcomm.com>

Add nvmem properties to retrieve charge control configurations
from the PMIC SDAM registers.

Acked-by: Rob Herring (Arm) <robh@kernel.org>
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



