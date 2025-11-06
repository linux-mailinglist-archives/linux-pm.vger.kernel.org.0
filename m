Return-Path: <linux-pm+bounces-37495-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 43A33C391FC
	for <lists+linux-pm@lfdr.de>; Thu, 06 Nov 2025 05:55:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 79A3E1A26997
	for <lists+linux-pm@lfdr.de>; Thu,  6 Nov 2025 04:53:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A54BF2D73AB;
	Thu,  6 Nov 2025 04:52:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PPfpYWGT"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 707882D3EE5
	for <linux-pm@vger.kernel.org>; Thu,  6 Nov 2025 04:52:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762404734; cv=none; b=MmqmHSgUkJ7Bj6y6hsUZq/OMFTVJPPOIUY/fOKJgFPmBHVbiZachvquBY6ScseZqo1e50V6+ufxh5Q5CJUdaSMH115gJl2YuUPmnXc+LB7w84uXtd5vvbJkdoJ1JF0s866Dz16ZgDyFko858AOEm/RTb09MyPXHSPLqfZbAJfr4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762404734; c=relaxed/simple;
	bh=qbK2iIdmwUE2j02TKF7PZ5qSJu8MBprmviv6EO+0BZU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=V6A0muqjK/ezcWUaOOtX1jSjBJnzAqhZPOdHNwFWR1sGsOFruemUaOwkb8OVhpEcGbzcWlks/zDqKlLJE231VONiVMrgFWtxGSiu5iIX601m6ZhAZGFFk37/tpy6VciCVOO+kMmRFHzIys1BQYMTCuH57Rl6RyBK83SsAq+9sb4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PPfpYWGT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 405A1C116D0;
	Thu,  6 Nov 2025 04:52:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762404733;
	bh=qbK2iIdmwUE2j02TKF7PZ5qSJu8MBprmviv6EO+0BZU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=PPfpYWGTnFj2bC4/btNI/9jjEPRAmLbYphaDuQXghBkLGIr4pPvTyWJDA/5/i9k53
	 yDqWHjq4GeezjYhaEXZpXv2qkImfAc0orLJ5fjnvfvmWGLCn7MRcLljiiZWQm06Up6
	 LiIuYBAwcKWzUQ2zztsTXUmgXJyYXIxjN6A9Qh1uZKdwKMPaFS5rIydvZoGw4G0j/9
	 82iuCoAh3lkO2dIaVSlt/un1I/7wHJTseD1ijP1+qfD/KnxEBs5wVaKR9q/Jb+blXn
	 X7rEKEt8a6HVCDw+QiJwydsYfvkCCnHxzsfPe7pIPcYHZnrM3FSlh9WJYpvBgldC5d
	 0FVx/EWFo9hAQ==
From: "Mario Limonciello (AMD)" <superm1@kernel.org>
To: mario.limonciello@amd.com,
	lenb@kernel.org,
	pavel@kernel.org,
	rafael@kernel.org
Cc: "Mario Limonciello (AMD)" <superm1@kernel.org>,
	Askar Safin <safinaskar@gmail.com>,
	linux-pm@vger.kernel.org
Subject: [PATCH 1/3] PM: hibernate: Emit an error when image writing fails
Date: Wed,  5 Nov 2025 22:51:05 -0600
Message-ID: <20251106045158.3198061-2-superm1@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251106045158.3198061-1-superm1@kernel.org>
References: <20251106045158.3198061-1-superm1@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

If image writing fails a return code is passed up to the caller but
none of the callers log anything to the log and so the only record
of it is the return code that userspace gets.

Adjust the logging so that the image size and speed of writing is
only emitted on success and if there is an error it's saved the logs.

Reported-by: Askar Safin <safinaskar@gmail.com>
Closes: https://lore.kernel.org/linux-pm/20251105180506.137448-1-safinaskar@gmail.com/
Signed-off-by: Mario Limonciello (AMD) <superm1@kernel.org>
---
 kernel/power/swap.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/kernel/power/swap.c b/kernel/power/swap.c
index 0beff7eeaabaf..f9bf01f355189 100644
--- a/kernel/power/swap.c
+++ b/kernel/power/swap.c
@@ -877,11 +877,13 @@ static int save_compressed_image(struct swap_map_handle *handle,
 	stop = ktime_get();
 	if (!ret)
 		ret = err2;
-	if (!ret)
+	if (!ret) {
+		swsusp_show_speed(start, stop, nr_to_write, "Wrote");
+		pr_info("Image size after compression: %d kbytes\n",
+			(atomic_read(&compressed_size) / 1024));
 		pr_info("Image saving done\n");
-	swsusp_show_speed(start, stop, nr_to_write, "Wrote");
-	pr_info("Image size after compression: %d kbytes\n",
-		(atomic_read(&compressed_size) / 1024));
+	} else
+		pr_err("Image saving failed: %d\n", ret);
 
 out_clean:
 	hib_finish_batch(&hb);
-- 
2.43.0


