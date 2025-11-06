Return-Path: <linux-pm+bounces-37497-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DA082C39202
	for <lists+linux-pm@lfdr.de>; Thu, 06 Nov 2025 05:55:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9D4D41A26B22
	for <lists+linux-pm@lfdr.de>; Thu,  6 Nov 2025 04:53:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C5FB2D7DCE;
	Thu,  6 Nov 2025 04:52:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HLl2mU1+"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC2F22D77FE
	for <linux-pm@vger.kernel.org>; Thu,  6 Nov 2025 04:52:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762404735; cv=none; b=gbj7b3HbJRVxZR61v12xvwVnZV5afKo1FlUnYRvLCOX9DzHe71dtoV2wcBDynDjoKoLhJwu1IktzGWBJxNpqnEiDfeeF19dsZ91PvJxpodOPtW80wi58gYpKo805Y5D4QI1+CUc1pR+pL2xc5NX80oR2Mry/QHSh6ExeetqtnFI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762404735; c=relaxed/simple;
	bh=Y63e7N5gItaYST/gq2e2ret60/YzNmzlwNoPJrzkJGc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YTSpVYB7jIQHkVwu48g1pfoUYmQlIHh5Hq/25jVsP/eYKWLQlZz5jAahggoX9/Iyn63Uuwmlq4oLv7B/jUrrUomhZScVb/joZnFPZntx4l6qt1ypYb1KYNMPhScTE6n7re9l9AUfImrqMdPFgQI7a7H9kOAqjMgXWOyo5VyRYpk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HLl2mU1+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 267EBC116C6;
	Thu,  6 Nov 2025 04:52:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762404735;
	bh=Y63e7N5gItaYST/gq2e2ret60/YzNmzlwNoPJrzkJGc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=HLl2mU1+OL1uvggsntczaAfZQh6EEGDx0ntBqHed9rCI+BNYjhjF0R2TDbumC7sRK
	 2nPJ3tA7C0vm0JE75QAueAgfjyw54WOxAfmIqTJ58XbgTEpy2HR5Ybi62A+4U0s2l7
	 FRyAT4Qr/ZVTaQcNm1hNfzGvtc8bHywITZAhtS10zFhyYYYcTPr67GLK9M0F3vN9bA
	 BFIonaz6TmJbl51G5gjHWVb2vx0l8WgVQ4ToJBuf9tCTNMvQ5qcFdKzgCQ58mBZC/G
	 2fghg3CqkNHGKEqOPYLRlFNgeAvZZThOQTXhmi2IIxOSpgiREF0ciTwMDxYhlvIZeX
	 12Adik+gTp9gA==
From: "Mario Limonciello (AMD)" <superm1@kernel.org>
To: mario.limonciello@amd.com,
	lenb@kernel.org,
	pavel@kernel.org,
	rafael@kernel.org
Cc: "Mario Limonciello (AMD)" <superm1@kernel.org>,
	linux-pm@vger.kernel.org
Subject: [PATCH 3/3] PM: hibernate: Fix style issues in save_compressed_image()
Date: Wed,  5 Nov 2025 22:51:07 -0600
Message-ID: <20251106045158.3198061-4-superm1@kernel.org>
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

Fix the two issues caught by checkpatch:
	Trailing statements should be on next line.
	Prefer 'unsigned int' to bare use of 'unsigned'

Signed-off-by: Mario Limonciello (AMD) <superm1@kernel.org>
---
 kernel/power/swap.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/kernel/power/swap.c b/kernel/power/swap.c
index 37270fa5ea600..488a74d2a56b8 100644
--- a/kernel/power/swap.c
+++ b/kernel/power/swap.c
@@ -689,7 +689,7 @@ static int save_compressed_image(struct swap_map_handle *handle,
 	ktime_t start;
 	ktime_t stop;
 	size_t off;
-	unsigned thr, run_threads, nr_threads;
+	unsigned int thr, run_threads, nr_threads;
 	unsigned char *page = NULL;
 	struct cmp_data *data = NULL;
 	struct crc_data *crc = NULL;
@@ -901,7 +901,8 @@ static int save_compressed_image(struct swap_map_handle *handle,
 		}
 		vfree(data);
 	}
-	if (page) free_page((unsigned long)page);
+	if (page)
+		free_page((unsigned long)page);
 
 	return ret;
 }
-- 
2.43.0


