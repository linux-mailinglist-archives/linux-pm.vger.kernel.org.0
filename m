Return-Path: <linux-pm+bounces-37496-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5EF64C391FF
	for <lists+linux-pm@lfdr.de>; Thu, 06 Nov 2025 05:55:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0312A1A26A3D
	for <lists+linux-pm@lfdr.de>; Thu,  6 Nov 2025 04:53:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 324062D46CE;
	Thu,  6 Nov 2025 04:52:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qbPrDwbK"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E6052D77FE
	for <linux-pm@vger.kernel.org>; Thu,  6 Nov 2025 04:52:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762404735; cv=none; b=O+VAQOJyoAkRQXxUYh9BVU3r6RpXcrpzitCPmsJig3ZIjLC3B+dNBQHmUEPSNpZHdX1bv5no6i7FI9ZjDlaz/f/2YM01eDAXCQKoPzV2rt3jsgNnpWqHjiiTZaadD2vgy/iylAo43O5jXwIs2Pyeq+g8jCR2+9HC9kNLJfbwEqk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762404735; c=relaxed/simple;
	bh=dZmTKMxTBIN95V63/igXlbe/6p0Vle2/FVNyScBsRdk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PzC6Vlq0b+o0f32BSPYsaQyoXwoPW8udxvZlrHhEUZ4V0/lIf3o0KBPz1/TPFcHEzQkewk4xZKDSZl13lXBuElc6OqRYXVr9iFHTW+mTZ7ozqy4E2VOEt7I3NipQyjdinvHIZw6IAIFRLGv/lYaLycUXnddK7RDqIxaAdg3Zqio=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qbPrDwbK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 35C9DC4CEF7;
	Thu,  6 Nov 2025 04:52:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762404734;
	bh=dZmTKMxTBIN95V63/igXlbe/6p0Vle2/FVNyScBsRdk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=qbPrDwbKYtHExsiiAJXq0rCt9gQlR3L3RsPoLGwl4x61r8co9MdXuIcXtkVEdzBZP
	 B65hzV+v+3EqUPtmfXTmunJ0pa+wU95MdH0UdHLZjHYhAkN5J5Qx6Kw5ujOffQOJsc
	 CA6ysSkaFDk9ro0QIm5m6025GiBqxaopGoDMXJWPlFidjzfIGZBqMN7Cl5tBnTaWkX
	 qfZ9qFydQpHFkqXGwSa35g81XENgqbHPNcRIwPJN+vuLEeiuIWNGNVjxQ7XNLxJvPw
	 fZ6AAe5HbB63SrZUOfjOHL9jAyy6Ec7i+Fp/PAb1/FKi7Rp3D4WCW/I9iU3uUabbc1
	 jakiZCfBlbF8w==
From: "Mario Limonciello (AMD)" <superm1@kernel.org>
To: mario.limonciello@amd.com,
	lenb@kernel.org,
	pavel@kernel.org,
	rafael@kernel.org
Cc: "Mario Limonciello (AMD)" <superm1@kernel.org>,
	Askar Safin <safinaskar@gmail.com>,
	linux-pm@vger.kernel.org
Subject: [PATCH 2/3] PM: hibernate: Use atomic64_t for compressed_size variable
Date: Wed,  5 Nov 2025 22:51:06 -0600
Message-ID: <20251106045158.3198061-3-superm1@kernel.org>
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

`compressed_size` can overflow, showing nonsensical values.
Change from `atomic_t` to `atomic64_t` to prevent overflow.

Reported-by: Askar Safin <safinaskar@gmail.com>
Closes: https://lore.kernel.org/linux-pm/20251105180506.137448-1-safinaskar@gmail.com/
Signed-off-by: Mario Limonciello (AMD) <superm1@kernel.org>
---
 kernel/power/swap.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/kernel/power/swap.c b/kernel/power/swap.c
index f9bf01f355189..37270fa5ea600 100644
--- a/kernel/power/swap.c
+++ b/kernel/power/swap.c
@@ -635,7 +635,7 @@ struct cmp_data {
 };
 
 /* Indicates the image size after compression */
-static atomic_t compressed_size = ATOMIC_INIT(0);
+static atomic64_t compressed_size = ATOMIC_INIT(0);
 
 /*
  * Compression function that runs in its own thread.
@@ -664,7 +664,7 @@ static int compress_threadfn(void *data)
 		d->ret = crypto_acomp_compress(d->cr);
 		d->cmp_len = d->cr->dlen;
 
-		atomic_set(&compressed_size, atomic_read(&compressed_size) + d->cmp_len);
+		atomic64_add(d->cmp_len, &compressed_size);
 		atomic_set_release(&d->stop, 1);
 		wake_up(&d->done);
 	}
@@ -696,7 +696,7 @@ static int save_compressed_image(struct swap_map_handle *handle,
 
 	hib_init_batch(&hb);
 
-	atomic_set(&compressed_size, 0);
+	atomic64_set(&compressed_size, 0);
 
 	/*
 	 * We'll limit the number of threads for compression to limit memory
@@ -879,8 +879,8 @@ static int save_compressed_image(struct swap_map_handle *handle,
 		ret = err2;
 	if (!ret) {
 		swsusp_show_speed(start, stop, nr_to_write, "Wrote");
-		pr_info("Image size after compression: %d kbytes\n",
-			(atomic_read(&compressed_size) / 1024));
+		pr_info("Image size after compression: %lld kbytes\n",
+			(atomic64_read(&compressed_size) / 1024));
 		pr_info("Image saving done\n");
 	} else
 		pr_err("Image saving failed: %d\n", ret);
-- 
2.43.0


