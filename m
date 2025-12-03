Return-Path: <linux-pm+bounces-39163-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id D402EC9F76A
	for <lists+linux-pm@lfdr.de>; Wed, 03 Dec 2025 16:31:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2B7483019891
	for <lists+linux-pm@lfdr.de>; Wed,  3 Dec 2025 15:25:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C86B630649B;
	Wed,  3 Dec 2025 15:24:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KOdhA1Xf"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 897A3305E37;
	Wed,  3 Dec 2025 15:24:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764775486; cv=none; b=GMPJ5nxpTL3CqIZdPSPsEuE6wqyCVBc1f2Mmo8p4FAVvl5DyemULN58w0DcqvhDD9zIGPFHlvcSoln0Yfd3+o33tIQ5NinL56FWKI6krEDUYxVRXftv9KT8nUFM2Vo0T0tXf+n10JGOyhOGhdBP98n7fBI9QnQsrJpcns3Ms2eU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764775486; c=relaxed/simple;
	bh=1A7HWYi12u0ByFTrLGTTwnpAXe7fC2zPDvsbAVbzY/g=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=E7NE9KUd+msS2ZfytuGLI360nJfL0JgSZlu0V3jnBQb4DZSDIkrmRawHLQGk3ytUw81iUhFfGzUCrNV/BvdfoTkdM3FjQMCAJrywauX2dD+ocKhsTD4HFKh4l82mkIoATbWt6lI74p01sCAc0gZIYTeMAVK700WlZHLoOB6H/FY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KOdhA1Xf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DA143C16AAE;
	Wed,  3 Dec 2025 15:24:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764775486;
	bh=1A7HWYi12u0ByFTrLGTTwnpAXe7fC2zPDvsbAVbzY/g=;
	h=From:To:Cc:Subject:Date:From;
	b=KOdhA1Xfik27NyKHYyJV2yG9y9ddt+S5JagagDqOY6iXJaEVp5B9ar49hpMbhLxqa
	 wPsKBhJzmXSZsfmyae2zkhfTmKJZSAsiVUJPTKfWvV6M6ca+7a07+AhqrxSCtYPOcH
	 22P/3eYe1kXZTkIi6xIcOfB9Oil9/eOHsahMChOeh8ohhPxBLNeXLhjoZwEu+J+GMk
	 96749z11QjollAQueGVXhkVawmusi+tNWoq8JurottXYKqKTWhBFDaWNZzvGmFPGWe
	 01o2cDrgZzOR9A5xYpwFAP18SlfbDhL2QfTseZzRxLNn5evGfcBCNeV9xZDhVISWTu
	 kzLTxk57dDCjQ==
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>,
	Amit Kucheria <amitk@kernel.org>,
	Thara Gopinath <thara.gopinath@gmail.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Daniel Lezcano <daniel.lezcano@linaro.org>,
	Zhang Rui <rui.zhang@intel.com>,
	Lukasz Luba <lukasz.luba@arm.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Akhil P Oommen <akhilpo@oss.qualcomm.com>,
	Bjorn Andersson <andersson@kernel.org>,
	Gaurav Kohli <quic_gkohli@quicinc.com>
Cc: linux-pm@vger.kernel.org,
	linux-arm-msm@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] dt-bindings: thermal: qcom-tsens: Remove invalid tab character
Date: Wed,  3 Dec 2025 09:24:36 -0600
Message-ID: <20251203152437.3751325-1-robh@kernel.org>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Commit 1ee90870ce79 ("dt-bindings: thermal: tsens: Add QCS8300
compatible") uses a tab character which is illegal in YAML (at the
beginning of a line). The original patch was correct, so this got
corrupted when applied.

Fixes: 1ee90870ce79 ("dt-bindings: thermal: tsens: Add QCS8300 compatible")
Signed-off-by: Rob Herring (Arm) <robh@kernel.org>
---
Linus, Can you please apply this directly as your tree and next are
broken and that breaks all my automated testing. I raised the issue with
Daniel on Mon, but haven't gotten any response.
---
 Documentation/devicetree/bindings/thermal/qcom-tsens.yaml | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/thermal/qcom-tsens.yaml b/Documentation/devicetree/bindings/thermal/qcom-tsens.yaml
index 921b6172d6f0..3c5256b0cd9f 100644
--- a/Documentation/devicetree/bindings/thermal/qcom-tsens.yaml
+++ b/Documentation/devicetree/bindings/thermal/qcom-tsens.yaml
@@ -61,7 +61,7 @@ properties:
               - qcom,msm8996-tsens
               - qcom,msm8998-tsens
               - qcom,qcm2290-tsens
-	      - qcom,qcs8300-tsens
+              - qcom,qcs8300-tsens
               - qcom,qcs615-tsens
               - qcom,sa8255p-tsens
               - qcom,sa8775p-tsens
-- 
2.51.0


