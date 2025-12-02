Return-Path: <linux-pm+bounces-39115-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 55F34C9D0C5
	for <lists+linux-pm@lfdr.de>; Tue, 02 Dec 2025 22:19:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AC88C3A3B24
	for <lists+linux-pm@lfdr.de>; Tue,  2 Dec 2025 21:19:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7799B2FA0F2;
	Tue,  2 Dec 2025 21:18:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Oo9ykNbc"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52CCD2FA0EE
	for <linux-pm@vger.kernel.org>; Tue,  2 Dec 2025 21:18:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764710321; cv=none; b=heovAMd+nf85VoTmIYuEa9vnPz5z4BiOkCmMVG4ueXZo9saqwkQ1Wtubqi87KsG/GIrgFU3Tvu4Gbznex5y1rWjUTwphWnYsqTKXW2gXViZKqnUk6lJwc0S9mPXVDjaZQMgow1o73Si+rxqtO36P/XeXqoKHnjS9hbuk3COCZHs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764710321; c=relaxed/simple;
	bh=E4WyY5qI43W6tfbgV/IeGAKEWHVr+rLQ7OH3zaQzIgE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pzqHw+rrMOIfyZezORNFtLZE+hvTiumjkJiy5bk90bD1Iubwl5XY+ZHFmmf06obFDWkdOtgLVn8uZ9+TRT+wePkTOrW93yM7K20JkRG/DUt9LFzgElkC2KniT3qY93HAw5yFZJ4mOLt3e0tds5wMaojmsjd9nALjE9Iy8lJT/Tc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Oo9ykNbc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 401D7C4CEF1;
	Tue,  2 Dec 2025 21:18:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764710321;
	bh=E4WyY5qI43W6tfbgV/IeGAKEWHVr+rLQ7OH3zaQzIgE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:Reply-To:From;
	b=Oo9ykNbcvYHXkKDqeENdi7U89dcmYpJgRexBs2lF9zw9ROVnsXx2FrLHKsRR4ZaOq
	 clsrRVl5kGTP1YtXkGdK4wPKR6urppsBNXMfxuWdf/3hwW1lk4DGetT5x47ALlVggO
	 vLu/OqwjBFsNc2RGGMnzSP7KkDtC1u1sCjd5jN0T4Ib24GqgwNEgcoDEiX+EYLS94Q
	 RAjAghslF2kavQnnxY7BomnMqo7Y+XqfIOqi8ZGOqRMvE3lTScqB7yYyCjZ5KI8nO2
	 +9YJ5YY2A2+5sieLRt82dPaARR8JKSIUZloCzFN+NcEhsxypX3IaQM3vTVbzlSpJdl
	 oqS5rOey0MZGQ==
From: Len Brown <lenb@kernel.org>
To: linux-pm@vger.kernel.org
Cc: Emily Ehlert <ehemily@amazon.com>,
	Len Brown <len.brown@intel.com>
Subject: [PATCH 09/21] tools/power turbostat: Set per_cpu_msr_sum to NULL after free
Date: Tue,  2 Dec 2025 16:13:27 -0500
Message-ID: <2313b97bc0ccedf951ffdd85ffd3629169cfd80b.1764710012.git.len.brown@intel.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <92664f2e6ab2228a3330734fc72dabeaf8a49ee1.1764710012.git.len.brown@intel.com>
References: <92664f2e6ab2228a3330734fc72dabeaf8a49ee1.1764710012.git.len.brown@intel.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Reply-To: Len Brown <lenb@kernel.org>
Organization: Intel Open Source Technology Center
Content-Transfer-Encoding: 8bit

From: Emily Ehlert <ehemily@amazon.com>

Set per_cpu_msr_sum to NULL after freeing it in the error path
of msr_sum_record() to prevent potential use-after-free issues.

Signed-off-by: Emily Ehlert <ehemily@amazon.com>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 tools/power/x86/turbostat/turbostat.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/power/x86/turbostat/turbostat.c b/tools/power/x86/turbostat/turbostat.c
index 2854b66eb748..8154d110dd07 100644
--- a/tools/power/x86/turbostat/turbostat.c
+++ b/tools/power/x86/turbostat/turbostat.c
@@ -6652,6 +6652,7 @@ void msr_sum_record(void)
 	timer_delete(timerid);
 release_msr:
 	free(per_cpu_msr_sum);
+	per_cpu_msr_sum = NULL;
 }
 
 /*
-- 
2.45.2


