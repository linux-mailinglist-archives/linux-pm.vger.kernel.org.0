Return-Path: <linux-pm+bounces-35860-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F14ABC9FF6
	for <lists+linux-pm@lfdr.de>; Thu, 09 Oct 2025 18:09:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 49EFA4FEC23
	for <lists+linux-pm@lfdr.de>; Thu,  9 Oct 2025 16:05:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC5F0226D00;
	Thu,  9 Oct 2025 15:59:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Te51cwza"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F5EA226D1F;
	Thu,  9 Oct 2025 15:59:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760025550; cv=none; b=f6XnzIbVYx3dLDsQmmQ2WmqpPElr62xtdS6T++J1HvliPhQuhu4QxyyuLm57li2K6HewjddBRGlbskOkHxdOC9NkpQfzbTfcdvunY3SFG/jqJ+OlSptrmG/6k4sR1j9N1L7LcVNTBRLdwLpIDsHlJ9k9nXIPwMmBFYmVA/LkPBE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760025550; c=relaxed/simple;
	bh=nq4hSRuc108cZ+gbbKt4dz8F1xQ/Lm6bx8p+H6MO4tI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=W4ZJDRgbf4QHIi59kYxDxqY/jAFJtQc/IQakkmBXLNY/MDB46A/goIlc9jDYTJanMz4WMsFPHr4PZf6S5FMkA1GF8JEFbEcXzsK+YR0h+TpBOqNzU4WZnxJGA9tOX2OpmPfYHZn7X6TZu1TDgnTUjmbEWJuQxSC8F+DRpmqduV0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Te51cwza; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7145BC4CEE7;
	Thu,  9 Oct 2025 15:59:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760025550;
	bh=nq4hSRuc108cZ+gbbKt4dz8F1xQ/Lm6bx8p+H6MO4tI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Te51cwzaWpuEMrWCMJYE4Kv1mt26a03bf3NuunZd3G83LQQn2v2m4MdeiyQm05TR/
	 aQEXS7jWSPV9wlIDi3ErynTusCPI2Zs5aU5qjv6jRF3YFBXl3l7MWCwwI75qhM4Xor
	 /wA1vhAtzC4h9jIAeZyRXZBD6C3APlSu8wQ6Hi5yaAQ4/59cF+fbLtbVQC/flPN3Yt
	 QeqVCPdB30jOf1lWoQS3B1POMvWQ67TVK/fRGGVDpbY3JkGsrHO76tRxHdW5PbTbk3
	 PTGUSvc9yCWRS2Lzv3dIki7x6ahuY3kD9173znTZafRfUzH8nslOzt2pRo6LGqX43M
	 uBxXivNlLVMVQ==
From: Sasha Levin <sashal@kernel.org>
To: patches@lists.linux.dev,
	stable@vger.kernel.org
Cc: Christopher Ruehl <chris.ruehl@gtsys.com.hk>,
	Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
	Sebastian Reichel <sebastian.reichel@collabora.com>,
	Sasha Levin <sashal@kernel.org>,
	sre@kernel.org,
	linux-arm-msm@vger.kernel.org,
	linux-pm@vger.kernel.org
Subject: [PATCH AUTOSEL 6.17-6.6] power: supply: qcom_battmgr: add OOI chemistry
Date: Thu,  9 Oct 2025 11:55:08 -0400
Message-ID: <20251009155752.773732-42-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251009155752.773732-1-sashal@kernel.org>
References: <20251009155752.773732-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.17.1
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Christopher Ruehl <chris.ruehl@gtsys.com.hk>

[ Upstream commit fee0904441325d83e7578ca457ec65a9d3f21264 ]

The ASUS S15 xElite model report the Li-ion battery with an OOI, hence this
update the detection and return the appropriate type.

Signed-off-by: Christopher Ruehl <chris.ruehl@gtsys.com.hk>
Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---

LLM Generated explanations, may be completely bogus:

YES – this patch is a focused bug fix that lets the Qualcomm battery
manager report the correct technology for hardware already supported by
stable kernels.

- `drivers/power/supply/qcom_battmgr.c:986` broadens the existing Li-ion
  match to accept the firmware string `OOI`, which the ASUS S15 xElite
  uses for its Li-ion pack; without this, the driver falls through to
  the error path.
- Because the fallback logs `pr_err("Unknown battery technology '%s'")`
  at `drivers/power/supply/qcom_battmgr.c:990`, affected systems
  currently emit misleading kernel errors and expose
  `POWER_SUPPLY_PROP_TECHNOLOGY` as `UNKNOWN`, confusing user space (see
  the assignment at `drivers/power/supply/qcom_battmgr.c:1039`).
- The change mirrors the earlier `LIP` support that was already accepted
  upstream for another device, touches only a single helper, and has no
  dependencies, so it is safe to integrate into older stable trees that
  already ship this driver.
- Risk is minimal: it simply recognizes an existing firmware identifier
  and maps it to the already-supported `POWER_SUPPLY_TECHNOLOGY_LION`
  value, with no architectural impact or behavioral change for other
  devices.

Natural next step: 1) Queue for the stable trees that include
`drivers/power/supply/qcom_battmgr.c` so ASUS S15 xElite users stop
seeing bogus error logs and get the correct battery technology reported.

 drivers/power/supply/qcom_battmgr.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/power/supply/qcom_battmgr.c b/drivers/power/supply/qcom_battmgr.c
index 99808ea9851f6..fdb2d1b883fc5 100644
--- a/drivers/power/supply/qcom_battmgr.c
+++ b/drivers/power/supply/qcom_battmgr.c
@@ -982,7 +982,8 @@ static void qcom_battmgr_sc8280xp_strcpy(char *dest, const char *src)
 
 static unsigned int qcom_battmgr_sc8280xp_parse_technology(const char *chemistry)
 {
-	if (!strncmp(chemistry, "LIO", BATTMGR_CHEMISTRY_LEN))
+	if ((!strncmp(chemistry, "LIO", BATTMGR_CHEMISTRY_LEN)) ||
+	    (!strncmp(chemistry, "OOI", BATTMGR_CHEMISTRY_LEN)))
 		return POWER_SUPPLY_TECHNOLOGY_LION;
 	if (!strncmp(chemistry, "LIP", BATTMGR_CHEMISTRY_LEN))
 		return POWER_SUPPLY_TECHNOLOGY_LIPO;
-- 
2.51.0


