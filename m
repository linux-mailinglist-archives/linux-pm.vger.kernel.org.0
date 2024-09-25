Return-Path: <linux-pm+bounces-14727-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B9109865AE
	for <lists+linux-pm@lfdr.de>; Wed, 25 Sep 2024 19:34:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 39D3D285D9F
	for <lists+linux-pm@lfdr.de>; Wed, 25 Sep 2024 17:34:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CB3D77117;
	Wed, 25 Sep 2024 17:34:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NL7eKiQO"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DB2054656;
	Wed, 25 Sep 2024 17:34:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727285667; cv=none; b=S8NmwRoiaaXzpqgA5Unu1ZcNc7D9VGn060Y6kduD4cIeR9YZY6XPzy9byIS2C5MRyWG9kYxoHbdah1HJ079/cD6j5bnmJujoYOLJwySEnNFfVwr6jtQ7Jg03FNNO9QXbLpHxb9+dGgkz2peoY6aIiTvzkHdqd7FJG6NmPBkcd8M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727285667; c=relaxed/simple;
	bh=/GUi/JAtgQh0XBmu3TyIyIcGbvbxojf00i+E6upjXqE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=rdNhBFeVQmo74RHCfZtIwsfFndaJXiWYrQO1gzqpgEcELxZw987OBiPpjjEIhhk2S7kMDpzIUXMWXvzqGRUXebhnsk1xmCjPzCa9SVJhMX93/a5d3+Og9hIKD3LYWFDaZ57T1hU55aWStjZR3akk/NwT36CNC9UOeB5UKyH9b10=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NL7eKiQO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BF232C4CEC6;
	Wed, 25 Sep 2024 17:34:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727285666;
	bh=/GUi/JAtgQh0XBmu3TyIyIcGbvbxojf00i+E6upjXqE=;
	h=From:To:Cc:Subject:Date:From;
	b=NL7eKiQO+Xb/OieV9VBl/tRn5QLcn1ZkViYm07OGCKFCKKurfqYTcyz/mvjEb09jw
	 xiJoXWcGjZi1KjSaekw3V9vogWgYaXmd6k3lTLjwSUpIcJKslD/8GVLpleZKq4Eso0
	 5qRePl5MFWEz4GDj9IOdcNADTofr8amgHWNrUKtJDg2cInCLOp4o5UgUoy7yvwyi9q
	 i4dNEOBWwsuyoJ3yIVsHaj5+0Ys2SqLJ9YZvaKietxjNb8rWrCQNXsMrno6vMaGQ7I
	 bylbjH97OpC1fln+w/OttMR8QMUf8YGE06BVKLBmZJFIu+Ys4GBAMQKqjBCzcU6qvm
	 9yMx/o/TqIDgA==
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Sebastian Reichel <sre@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Caleb Connolly <caleb.connolly@linaro.org>
Cc: linux-pm@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] dt-bindings: power/supply: qcom,pmi8998-char: Add missing "interrupt-controller" to example
Date: Wed, 25 Sep 2024 12:34:12 -0500
Message-ID: <20240925173413.1905782-1-robh@kernel.org>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Enabling dtc interrupt_provider check reveals the example is missing
the "interrupt-controller" property as it is a dependency of
"#interrupt-cells".

Signed-off-by: Rob Herring (Arm) <robh@kernel.org>
---
 .../devicetree/bindings/power/supply/qcom,pmi8998-charger.yaml   | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/power/supply/qcom,pmi8998-charger.yaml b/Documentation/devicetree/bindings/power/supply/qcom,pmi8998-charger.yaml
index 277c47e048b6..a1b4926e7190 100644
--- a/Documentation/devicetree/bindings/power/supply/qcom,pmi8998-charger.yaml
+++ b/Documentation/devicetree/bindings/power/supply/qcom,pmi8998-charger.yaml
@@ -61,6 +61,7 @@ examples:
       #address-cells = <1>;
       #size-cells = <0>;
       #interrupt-cells = <4>;
+      interrupt-controller;
 
       charger@1000 {
         compatible = "qcom,pmi8998-charger";
-- 
2.45.2


