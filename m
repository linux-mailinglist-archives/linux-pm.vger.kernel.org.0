Return-Path: <linux-pm+bounces-27199-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 21B4FAB897D
	for <lists+linux-pm@lfdr.de>; Thu, 15 May 2025 16:31:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AC1E13A4244
	for <lists+linux-pm@lfdr.de>; Thu, 15 May 2025 14:31:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0F4D1F3FE3;
	Thu, 15 May 2025 14:31:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uJ30zQ1h"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9899B1F0E20;
	Thu, 15 May 2025 14:31:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747319469; cv=none; b=QbYTOeHcbQJXd3lS8u8VX45Y3nanZXJyatUvhYPiHh7N4iD4tYS9m0O+cAeJEeWqaJc8K1ZMJqtchCcF8v9RpFUTrkBQEHhMwwh/SH7AbvmRTtrTlsIldqQCnwD0T8JbL/nT/Wlt89d/Wf6SPNBVyfOLvl2NFE5jS7VpdhlrC+g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747319469; c=relaxed/simple;
	bh=ivbyIHB40a8ivA9nLcvidBfuu5tWNCiFWjlhmGLDUWE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=d/OqHfPdU/oFwZVSgekcPm858/6QpyHzZLxxEPcHEIoV2J1gDEeIEEg87rJm6MQ+qnyDX8Mlst27xLHatu3JOcps4Pt8Hv+OA/3w4s+oWjZaFXANZRwYf54wKNdMwAPW61qVwi5LCqizgLW6hbCx22AbDBkNt4airZ3m1p4aUK4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uJ30zQ1h; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5766DC4CEF1;
	Thu, 15 May 2025 14:31:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747319469;
	bh=ivbyIHB40a8ivA9nLcvidBfuu5tWNCiFWjlhmGLDUWE=;
	h=From:To:Cc:Subject:Date:From;
	b=uJ30zQ1hYH+IXvDxofc8kjksEiYyD6XryLyPhCVP2FjKsVNaLY09KpwZcvLx0pnXy
	 r7D9BYbi9bSkAg+DlPn4RHMnJ7+AHLBDeqnD7YuN/EL9w6GKY1x28zjRRKw7P54gbe
	 2PQbgL3cOKOF9EIMY16xQNlkyisg8z1OhZUupp3Q0VqnQcIPwbZi5KP+Qmyiju/Vdy
	 mFof63Sm2kLqzrcPdNkUk01Y0zVldelpxeaDqFfxkedEh2aXuR9IxS4biCFZ2yQ7MN
	 /bAkMb4H99mSYcgmUgROtAOfkFlPIZAdI18JB0NrNWYxa82Dx8SBCfWqrCt2tta3k8
	 l2zjWwFP6MLVw==
From: chanwoo@kernel.org
To: linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: cw00.choi@samsung.com,
	myungjoo.ham@samsung.com,
	kyungmin.park@samsung.com,
	pls <pleasurefish@126.com>
Subject: [PATCH] PM / devfreq: Fix a index typo in trans_stat
Date: Thu, 15 May 2025 23:31:00 +0900
Message-Id: <20250515143100.17849-1-chanwoo@kernel.org>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Chanwoo Choi <cw00.choi@samsung.com>

Fixes: 4920ee6dcfaf ("PM / devfreq: Convert to use sysfs_emit_at() API")
Signed-off-by: pls <pleasurefish@126.com>
Signed-off-by: Chanwoo Choi <cw00.choi@samsung.com>
---
 drivers/devfreq/devfreq.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/devfreq/devfreq.c b/drivers/devfreq/devfreq.c
index 46f3a8053197..c5f5960e643b 100644
--- a/drivers/devfreq/devfreq.c
+++ b/drivers/devfreq/devfreq.c
@@ -1733,7 +1733,7 @@ static ssize_t trans_stat_show(struct device *dev,
 	for (i = 0; i < max_state; i++) {
 		if (len >= PAGE_SIZE - 1)
 			break;
-		if (df->freq_table[2] == df->previous_freq)
+		if (df->freq_table[i] == df->previous_freq)
 			len += sysfs_emit_at(buf, len, "*");
 		else
 			len += sysfs_emit_at(buf, len, " ");
-- 
2.25.1


