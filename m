Return-Path: <linux-pm+bounces-36481-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B546BF28F5
	for <lists+linux-pm@lfdr.de>; Mon, 20 Oct 2025 18:56:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6750F3A7238
	for <lists+linux-pm@lfdr.de>; Mon, 20 Oct 2025 16:54:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D80733030B;
	Mon, 20 Oct 2025 16:53:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mt8x8Koh"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69352330304
	for <linux-pm@vger.kernel.org>; Mon, 20 Oct 2025 16:53:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760979211; cv=none; b=ZBCuITfxidWf/LM7ZgxNcgOBDZX5WDX2ClfCzdKCqZ+z5PNXdYkctBmiTaBUJf9j3HbqsnssK3I/zi92QGTgIv6DfCnFzcogLq7zZulbVVjKmCKGNawjfqUUqysaYs0HMpbrkcWl84uhR/CToD6rtUcbsNd/W+spMdTTssO1Jnk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760979211; c=relaxed/simple;
	bh=NTNN3wwtEyiPMnu+I2XHXc/XM3jyZiRd3TIIAscmDFQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CL7M3Yh7sXUJAZzeh2lRH9MfVK09ryGa9dEmYdav6yy7gXP8gekYf6Iej4Qdouft1PY5SYvza11PEI37TZNWCdOP5IJ46+wcXDl5slQqIPcHR7kUW5bjADYMSmu57/GcWC7bkmns/GouvRFvOBmGp4IavFnd59IktsZcgG2AWHU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mt8x8Koh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 942E3C4CEFE;
	Mon, 20 Oct 2025 16:53:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760979210;
	bh=NTNN3wwtEyiPMnu+I2XHXc/XM3jyZiRd3TIIAscmDFQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=mt8x8Koh/LvecZ6pnOUPt7IVv3IL40j30WXV7SP6/ghDJV3c8dBhgB8HqwLEemZZ9
	 G9DaMzfwssu2jnbRLmqgnH5+EslhalUMZ6jx3l/qN42h7hBmEx/e+Q7vHLh5/hhpad
	 UVhbfHzzW0DqboYrjnGxjLYzLWTqQiR777Ua+fO5Faju2UDIFBnFuDZHjDgGM/urnY
	 4S47ToqU6dsHIRRqD50hCt8YU1W2NlRBQQFNSGrxEk8gMV31pu86xYRee6hpbkV1FC
	 Ld+Qd8YKK3uOEurY7T5K06i5y9RsX94mex4zXwh8b0BUuxGHPbjDMnIkNlZEpT6rxp
	 ahO/lWoU/BrKw==
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
Subject: [RFC 1/3] PM: Mark device as suspended if it failed to resume
Date: Mon, 20 Oct 2025 11:50:47 -0500
Message-ID: <20251020165317.3992933-2-superm1@kernel.org>
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

If a device failed to resume the PM core treats it as though it
succeeded.  This could cause state machine problems.

Cc: Muhammad Usama Anjum <usama.anjum@collabora.com>
Signed-off-by: Mario Limonciello (AMD) <superm1@kernel.org>
---
 drivers/base/power/main.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/base/power/main.c b/drivers/base/power/main.c
index e83503bdc1fdb..bf9c3d79c455f 100644
--- a/drivers/base/power/main.c
+++ b/drivers/base/power/main.c
@@ -1104,6 +1104,9 @@ static void device_resume(struct device *dev, pm_message_t state, bool async)
 	device_unlock(dev);
 	dpm_watchdog_clear(&wd);
 
+	if (error)
+		dev->power.is_suspended = true;
+
  Complete:
 	complete_all(&dev->power.completion);
 
-- 
2.43.0


