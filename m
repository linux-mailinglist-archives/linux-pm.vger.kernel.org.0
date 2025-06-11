Return-Path: <linux-pm+bounces-28436-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6056FAD4A53
	for <lists+linux-pm@lfdr.de>; Wed, 11 Jun 2025 07:13:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 20A9618991EC
	for <lists+linux-pm@lfdr.de>; Wed, 11 Jun 2025 05:13:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 655F3224B08;
	Wed, 11 Jun 2025 05:13:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rqLSBeYZ"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 360CB8F5B;
	Wed, 11 Jun 2025 05:13:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749618785; cv=none; b=pxdrfjNR056UrjGSrVxxZ+fwjf9LBeMINYt8QKn6aWC6qwcYj1G1gkhymZyequsvdGRoQn+xJiA8XfBE1TmroZJ8O6oYEdSIzQ3MRYl34pBZSOL24NiwVvPSkKag/RWKIJGBBU6eHXBDu9z8Ydl1wbq1d50v2hwx7AjVLBs3tfs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749618785; c=relaxed/simple;
	bh=8GuIRQ9Dgb478ZUpPx26B9okqHcLmO2uZl+8HmTAeMY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=eHPrJVsKFW9/5P3xpn1vkHMd6uw2q5xhRf0GzqDtbcU8qyfeHumQsiY4FuPKXYFsaMLE4qSWzuqzCPox41A/fpOMVoUpIlOdBp1sqOQZKhuImvT4JOxcvVFOiJfkZxFSfNGVZ3dmXhh2E6eLDLNpDRAegakti9eRrjx+rbYJ0L8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rqLSBeYZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id B3EBAC4CEF0;
	Wed, 11 Jun 2025 05:13:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749618784;
	bh=8GuIRQ9Dgb478ZUpPx26B9okqHcLmO2uZl+8HmTAeMY=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=rqLSBeYZmUvEZLIKZed/tcC/XBJAd97cCrCkVe6S2W4SJT77KePY6Vp96cRnKm3pl
	 qSUHYFaKEJ7/XI337+uszimxh7H9drhrqzTO7HKisqPhhsp0+sEfUib9o79etc6FMm
	 R1cxVXYdz8WvGgBTGjDD+OTHa9NnTsDVgikeXjTNAMfgNnXllQJbQSfa4ipBBycfgb
	 604AML3YiI0tt5yGwwa9pEpwQOy6k1WsYxQni771LLdaFwY6yIWMKj7z0psDRrpi55
	 Ie8WVe213pUGlGpxmlx9npAnfsbbQUime57vb/eYGoOoCZl272zhtFcFkhP+Ld2FVV
	 QM8oTpEHjQNfQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2246C61CE7;
	Wed, 11 Jun 2025 05:13:04 +0000 (UTC)
From: George Moussalem via B4 Relay <devnull+george.moussalem.outlook.com@kernel.org>
Date: Wed, 11 Jun 2025 09:12:45 +0400
Subject: [PATCH v11 1/2] dt-bindings: thermal: qcom-tsens: make ipq5018
 tsens standalone compatible
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250611-ipq5018-tsens-v11-1-266566bfd16a@outlook.com>
References: <20250611-ipq5018-tsens-v11-0-266566bfd16a@outlook.com>
In-Reply-To: <20250611-ipq5018-tsens-v11-0-266566bfd16a@outlook.com>
To: Amit Kucheria <amitk@kernel.org>, 
 Thara Gopinath <thara.gopinath@gmail.com>, 
 "Rafael J. Wysocki" <rafael@kernel.org>, 
 Daniel Lezcano <daniel.lezcano@linaro.org>, Zhang Rui <rui.zhang@intel.com>, 
 Lukasz Luba <lukasz.luba@arm.com>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konradybcio@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 George Moussalem <george.moussalem@outlook.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1749618782; l=1207;
 i=george.moussalem@outlook.com; s=20250321; h=from:subject:message-id;
 bh=dHBmhXwIxbyNN1gtQFZSEd0dq6VfiMuKbDQhkACE3hE=;
 b=eOanNQKqA5mVLoWHxpGyHdTUExNDjlY5q6Cm6ZAM0bKV64d8K0VVhClEIjKjZ/X0LvfsDBHjw
 ITS+KWnt2q7COW7SuzxNoOw6/SBBd6hD3h04FMuTyCRxxVBOBijkHpT
X-Developer-Key: i=george.moussalem@outlook.com; a=ed25519;
 pk=/PuRTSI9iYiHwcc6Nrde8qF4ZDhJBlUgpHdhsIjnqIk=
X-Endpoint-Received: by B4 Relay for george.moussalem@outlook.com/20250321
 with auth_id=364
X-Original-From: George Moussalem <george.moussalem@outlook.com>
Reply-To: george.moussalem@outlook.com

From: George Moussalem <george.moussalem@outlook.com>

IPQ5018 tsens should not use qcom,tsens-v1 as fallback since it has no RPM
and, as such, deviates from the standard v1 init routine in the driver.
So let's make qcom,ipq5018-tsens a standalone compatible in the bindings.

Signed-off-by: George Moussalem <george.moussalem@outlook.com>
---
 Documentation/devicetree/bindings/thermal/qcom-tsens.yaml | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/thermal/qcom-tsens.yaml b/Documentation/devicetree/bindings/thermal/qcom-tsens.yaml
index 0e653bbe9884953b58c4d8569b8d096db47fd54f..73d722bda8adc2c930edfc3373e6011f19c7c491 100644
--- a/Documentation/devicetree/bindings/thermal/qcom-tsens.yaml
+++ b/Documentation/devicetree/bindings/thermal/qcom-tsens.yaml
@@ -36,10 +36,13 @@ properties:
               - qcom,msm8974-tsens
           - const: qcom,tsens-v0_1
 
+      - description: v1 of TSENS
+        enum:
+          - qcom,ipq5018-tsens
+
       - description: v1 of TSENS
         items:
           - enum:
-              - qcom,ipq5018-tsens
               - qcom,msm8937-tsens
               - qcom,msm8956-tsens
               - qcom,msm8976-tsens

-- 
2.49.0



