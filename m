Return-Path: <linux-pm+bounces-10880-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3070892BDB3
	for <lists+linux-pm@lfdr.de>; Tue,  9 Jul 2024 17:03:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 42D551C23D1E
	for <lists+linux-pm@lfdr.de>; Tue,  9 Jul 2024 15:03:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DD6619D07B;
	Tue,  9 Jul 2024 15:02:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Po51Gkls"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC05F15B999;
	Tue,  9 Jul 2024 15:02:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720537338; cv=none; b=tpRqFEzs5GlMPhl7z2rn5SHLxX6kxNewce7iIgU9VpKGwOQ7vBgggCihWTKidr9Bk5BexzNjd2PrLkQs6eclYvuRWk/Dv3qsLCfDq9FV67JBy/308/VjayeAa5bcVl7995+6jkXIWLnhP/8opVPVDLadV9VCVDWL1VNQpk5zgo4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720537338; c=relaxed/simple;
	bh=QOu4N1gVL/EoBAJAI5M5R2AXSz6SIL6j6PhrzKJo5Y0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=J5OUZtpu1YMe8a9zase9dVbPxF+/U6xfWz/bM7YdPVkzh7palwVruHqWs8n2Yei3tJ7lJ8vhHfpIqgM5F77XES9Cj2+OGuxT902kXiz/VztECnbGqVT56JdhMB6NcxlvKXg7TAWbbGGZkUsIkwmAGSdR8UDieMp1ECf+Enk28UE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Po51Gkls; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4C70EC4AF0A;
	Tue,  9 Jul 2024 15:02:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720537337;
	bh=QOu4N1gVL/EoBAJAI5M5R2AXSz6SIL6j6PhrzKJo5Y0=;
	h=From:To:Cc:Subject:Date:From;
	b=Po51GklsoR8R61E7m9xF6gajCVJcicZzBpxe4bmXdWpQHu88m2D5dYh1h0vQOOVuZ
	 XK2WesGh54zzOEAAm2etTV2F0inUC+v1suMw24lqvtym8o5GHwkpsq5rgJM0kcFIGb
	 YdzJGFbtkVmnXZP7FGBv8b2uTvcwrWUpbBlC3YWPy5vhpM2C1/ZksILJGsGETuR4si
	 HUga+rZ8quDKpvig+6jJEXciOozKhsZFA+dem8xUL+7B3JDv/pnG5+P+7FTbHOjkzO
	 7kXSQ2FuWyb6zszjrenCP95UGlfj1ba8kpA7Dm2CKJzVCJuwYXYqoUgZY/gX6PPdv+
	 y+vnBzdRvVNuw==
From: "Rob Herring (Arm)" <robh@kernel.org>
To: "Rafael J. Wysocki" <rafael@kernel.org>,
	Daniel Lezcano <daniel.lezcano@linaro.org>,
	Zhang Rui <rui.zhang@intel.com>,
	Lukasz Luba <lukasz.luba@arm.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>
Cc: linux-pm@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] dt-bindings: thermal: Drop 'trips' node as required
Date: Tue,  9 Jul 2024 09:01:53 -0600
Message-ID: <20240709150154.3272825-1-robh@kernel.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

It is possible to have thermal zones which don't have any trip points.
These zones in effect simply represent a temperature sensor without any
action associated with it. While the schema has always required a
'trips' node, users have existed for a long time without it. Update the
schema to match reality.

Signed-off-by: Rob Herring (Arm) <robh@kernel.org>
---
 Documentation/devicetree/bindings/thermal/thermal-zones.yaml | 1 -
 1 file changed, 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/thermal/thermal-zones.yaml b/Documentation/devicetree/bindings/thermal/thermal-zones.yaml
index 68398e7e8655..8315ab4b00eb 100644
--- a/Documentation/devicetree/bindings/thermal/thermal-zones.yaml
+++ b/Documentation/devicetree/bindings/thermal/thermal-zones.yaml
@@ -229,7 +229,6 @@ patternProperties:
 
     required:
       - thermal-sensors
-      - trips
 
     additionalProperties: false
 
-- 
2.43.0


