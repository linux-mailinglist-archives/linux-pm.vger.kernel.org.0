Return-Path: <linux-pm+bounces-36482-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D7B25BF28F8
	for <lists+linux-pm@lfdr.de>; Mon, 20 Oct 2025 18:56:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 585C34658F6
	for <lists+linux-pm@lfdr.de>; Mon, 20 Oct 2025 16:54:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 278BF330B1B;
	Mon, 20 Oct 2025 16:53:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="P5BPbzKT"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02DD8265296
	for <linux-pm@vger.kernel.org>; Mon, 20 Oct 2025 16:53:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760979213; cv=none; b=sxh2Li1q0gLBxPr6ATJbN6gSYXeFKX4uMKg+0lVEFVNH6McPE3fbG7V8kMlsi6jtBXeySdMS0CPDWJuRHfgJ2myXBEMPu/RYVpFVW+DDfaXKrsBtyO5lZNhFA3T15S3vLunED0nPU/MitXz9JqWA21YlUxYTih2MSc98WQAAVpw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760979213; c=relaxed/simple;
	bh=1jA9mRZr/xXEpElZQP1h8QlFxHjPmdmKv3OcE+yAbS8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=M+i62JLjk2M6QpAXyUgYiMMHxYemaY6tohY5IfQ8ijz9jFpxjWl9cuCL5hsEccCkPYjU9DNWzb8q3/g6sGr2nWFdlyP5C2ktktE+M/z1+MsfS/D1GL/+WGs1tLAY8Cv5Aj+iGX/ebC3OEa2uqZsf9Qxjs1JBE59hRNO6miHR1to=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=P5BPbzKT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3310AC4CEF9;
	Mon, 20 Oct 2025 16:53:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760979212;
	bh=1jA9mRZr/xXEpElZQP1h8QlFxHjPmdmKv3OcE+yAbS8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=P5BPbzKTtdf8ltLd6vsPjendOtYpNv+2vNL8tpUuiAQ2F9BC1wrODA+g3tHEXFL7o
	 XZ/tNKlvuqT+oivt+AUdp20dy0keXGArHwGWArXYFXX1pKajk5d81YuDZLSxMjOrzb
	 Wxc2iC5CyPuXFp87jMmSPRVsPvGf6FiX6LZ40G92jToZmid6VuJkGshE3SvpLRitM2
	 t8vIcP8WI5zFNJQxrcrvWBR46sY7FRLYFuk2CbR8Lxq8W9lwwBkCIUAa0hNsiDR3fZ
	 Xh+/AChcJGP4yfGKD5DyyWO++kuVXoICFPUeyjvJeBeWjLwunAlmnbZnLzpKgyGFWO
	 Uii3XVoKhx7Zw==
From: "Mario Limonciello (AMD)" <superm1@kernel.org>
To: mario.limonciello@amd.com,
	airlied@gmail.com,
	alexander.deucher@amd.com,
	christian.koenig@amd.com,
	dakr@kernel.org,
	gregkh@linuxfoundation.org,
	lenb@kernel.org,
	pavel@kernel.org,
	rafael@kernel.org,
	simona@ffwll.ch
Cc: Muhammad Usama Anjum <usama.anjum@collabora.com>,
	Mario Limonciello <superm1@kernel.org>,
	amd-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org,
	linux-pm@vger.kernel.org
Subject: [RFC 2/3] PM: Don't pass up device_resume() -EBUSY errors
Date: Mon, 20 Oct 2025 11:50:48 -0500
Message-ID: <20251020165317.3992933-3-superm1@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251020165317.3992933-1-superm1@kernel.org>
References: <20251020165317.3992933-1-superm1@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Mario Limonciello <mario.limonciello@amd.com>

If a device resume returns -EBUSY the device resume sequence has
been skipped. Don't show errors for this or pass it up to async
resume.  If resume is run again in another stage the device should
try again.

Cc: Muhammad Usama Anjum <usama.anjum@collabora.com>
Signed-off-by: Mario Limonciello (AMD) <superm1@kernel.org>
---
 drivers/base/power/main.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/base/power/main.c b/drivers/base/power/main.c
index bf9c3d79c455f..f6bc7ef9a8371 100644
--- a/drivers/base/power/main.c
+++ b/drivers/base/power/main.c
@@ -1112,7 +1112,9 @@ static void device_resume(struct device *dev, pm_message_t state, bool async)
 
 	TRACE_RESUME(error);
 
-	if (error) {
+	if (error == -EBUSY)
+		pm_dev_dbg(dev, state, async ? " async" : "");
+	else if (error) {
 		WRITE_ONCE(async_error, error);
 		dpm_save_failed_dev(dev_name(dev));
 		pm_dev_err(dev, state, async ? " async" : "", error);
-- 
2.43.0


