Return-Path: <linux-pm+bounces-27481-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ABFA1AC0435
	for <lists+linux-pm@lfdr.de>; Thu, 22 May 2025 07:49:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EE3D99E777C
	for <lists+linux-pm@lfdr.de>; Thu, 22 May 2025 05:48:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB7FF1ACEC7;
	Thu, 22 May 2025 05:49:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MEXhqQZq"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE2F91A8404;
	Thu, 22 May 2025 05:49:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747892940; cv=none; b=RDlZz2Zw5gtDUUmwOicobwZo7q1rUi6ItQQL90kUt80t6u2aC5h7jFOm3hi7xVUG4/T0Sv9Y9WYqiDhSGYS1TLdxj9gbKtvgTwJKwCv2D3AJ5izpuWUWYCJDieDRbf9tYfmNgntUmbMiP+/LcsgYiZ4PXw3t458oa4MQIABYqHY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747892940; c=relaxed/simple;
	bh=D5JokSP59ASe1HGXnYivFqbn/bmgi/lDHm1iFZZIxEw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=KUyxcCGgHGyrV3rLo7UQywPz/FvqeYHBZ/DHrzbT5z+45ItbzAowYMlUrdDiwRRo4P5zBz0MjfEilWzxUx0zppKT0sBKAOnic0Ge51PGhgENUrIysYlfpLmoxj1y7A5cJTLaRwuJbI8wwTX5UnqPyAKIHYZYMEth0jB2ZQyuzEY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MEXhqQZq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 0DB94C4CEE4;
	Thu, 22 May 2025 05:49:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747892940;
	bh=D5JokSP59ASe1HGXnYivFqbn/bmgi/lDHm1iFZZIxEw=;
	h=From:Date:Subject:To:Cc:Reply-To:From;
	b=MEXhqQZqwLTecIz+atOI7cO121aErPesCfbxoyhjhnGvjmLrCtryF/Aknp4MSZixq
	 UJQJvuxxUeoWmwoPxIMj6gllAwHKa/y9i41rm2lCFsLSdymCxoMzWjvPXHE+9Z9Rre
	 zMoj9Gha4QEP8b7QS1bPPeCOmxKz2PV2xsW58IOHGFgTc4s4mS+tg0R0FIGxbPVnvO
	 CFtPWMA4st2SVaxDlgIXje9NE+xf+LS3jZRvqSCj6iKZVhZNdmYiDwBHB/PQUrsCfd
	 CCGvv1Qgn2N1NbjtErfI4OKqRyOjbxwPe/hCpeUS64Rh9WIE6Ax5u6QjO9tUEtgNEx
	 a/0VElIMZ4Pwg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9BBFC54756;
	Thu, 22 May 2025 05:48:59 +0000 (UTC)
From: George Moussalem via B4 Relay <devnull+george.moussalem.outlook.com@kernel.org>
Date: Thu, 22 May 2025 09:48:51 +0400
Subject: [PATCH] thermal: qcom: ipq5018: make ops_ipq5018 struct static
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250522-ipq5018-tsens-sparse-v1-1-97edaaaef27c@outlook.com>
X-B4-Tracking: v=1; b=H4sIAMK6LmgC/y3MywqDMBCF4VeRWXcgCY23VykuTDPqbNI4o1IQ3
 72h7fI7cP4TlIRJoa9OEDpY+ZUK7K2C5zKmmZBjMTjjvPHOIufVG9vippQUNY+ihPfQ1rFrYgi
 2gXLNQhO/v9nH8LPQupf69h+v6wMO8VuHewAAAA==
X-Change-ID: 20250521-ipq5018-tsens-sparse-4b86d97dbb17
To: Amit Kucheria <amitk@kernel.org>, 
 Thara Gopinath <thara.gopinath@gmail.com>, 
 "Rafael J. Wysocki" <rafael@kernel.org>, 
 Daniel Lezcano <daniel.lezcano@linaro.org>, Zhang Rui <rui.zhang@intel.com>, 
 Lukasz Luba <lukasz.luba@arm.com>
Cc: linux-pm@vger.kernel.org, linux-arm-msm@vger.kernel.org, 
 linux-kernel@vger.kernel.org, kernel test robot <lkp@intel.com>, 
 George Moussalem <george.moussalem@outlook.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1747892937; l=1603;
 i=george.moussalem@outlook.com; s=20250321; h=from:subject:message-id;
 bh=AQVbg0exLroJo2VR6NwKRBYnMgg5MIEpgmctdGB8598=;
 b=tpAJawEZhOFGF5BWQgBdrS2gQMZ2F7XTxy01rJUUbdTRqdR+Ohng0RJNl1KX+coo2+FtH90L8
 1/07OjPaxg5BM/HleCtxKQ0u3x0v+afA//+C80QZ8jZBxJYAmSVL7R5
X-Developer-Key: i=george.moussalem@outlook.com; a=ed25519;
 pk=/PuRTSI9iYiHwcc6Nrde8qF4ZDhJBlUgpHdhsIjnqIk=
X-Endpoint-Received: by B4 Relay for george.moussalem@outlook.com/20250321
 with auth_id=364
X-Original-From: George Moussalem <george.moussalem@outlook.com>
Reply-To: george.moussalem@outlook.com

From: George Moussalem <george.moussalem@outlook.com>

Fix a sparse warning by making the ops_ipq5018 struct static.

Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202505202356.S21Sc7bk-lkp@intel.com/
Signed-off-by: George Moussalem <george.moussalem@outlook.com>
---
Fix below sparse warning by making the ops_ipq5018 struct static.

sparse warnings: (new ones prefixed by >>)
>> drivers/thermal/qcom/tsens-v1.c:246:24: sparse: sparse: symbol 'ops_ipq5018' was not declared. Should it be static?

vim +/ops_ipq5018 +246 drivers/thermal/qcom/tsens-v1.c

   245	
 > 246	const struct tsens_ops ops_ipq5018 = {
   247		.init		= init_tsens_v1_no_rpm,
   248		.calibrate	= tsens_calibrate_common,
   249		.get_temp	= get_temp_tsens_valid,
   250	};
   251	
---
 drivers/thermal/qcom/tsens-v1.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/thermal/qcom/tsens-v1.c b/drivers/thermal/qcom/tsens-v1.c
index 27360e70d62a94e52e67f5aaa45457be165bfeb3..faa5d00788ca6fb29b367857d27596578218358e 100644
--- a/drivers/thermal/qcom/tsens-v1.c
+++ b/drivers/thermal/qcom/tsens-v1.c
@@ -243,7 +243,7 @@ struct tsens_plat_data data_8976 = {
 	.fields		= tsens_v1_regfields,
 };
 
-const struct tsens_ops ops_ipq5018 = {
+static const struct tsens_ops ops_ipq5018 = {
 	.init		= init_tsens_v1_no_rpm,
 	.calibrate	= tsens_calibrate_common,
 	.get_temp	= get_temp_tsens_valid,

---
base-commit: 54b982e44c486d604583efe8742557ab56c944e0
change-id: 20250521-ipq5018-tsens-sparse-4b86d97dbb17

Best regards,
-- 
George Moussalem <george.moussalem@outlook.com>



