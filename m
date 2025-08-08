Return-Path: <linux-pm+bounces-32073-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E0910B1EEF6
	for <lists+linux-pm@lfdr.de>; Fri,  8 Aug 2025 21:37:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DA62F1C202AF
	for <lists+linux-pm@lfdr.de>; Fri,  8 Aug 2025 19:38:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE27F2877FC;
	Fri,  8 Aug 2025 19:37:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="G2tTrkV6"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C53452877E3;
	Fri,  8 Aug 2025 19:37:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754681868; cv=none; b=UMk277LKOm/lb/XKxbPPDjCqGzRqQshQJXg0aIUCGWoppv+3565a3hzIMldsp/joEEJtM3X6ZM7BE9scRmT7TLyq5FKQ3qw5Abf2cBavsGnLCRyiEQXNQOGDWKyY5zSKx3Ik5Ma+OkfCMXK/XoNtnlSAG+9tiGw3clR85F/VGR4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754681868; c=relaxed/simple;
	bh=+sPyrRNmQmGvEQQbsqXAiqW7mrkXp+1FECvjK0+/Nhk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=V/Vha6aIZa4gyTrj9b7UdLlJiCjqyJBmBo8WJ/a7Xw5Khqt2300GnB6pTZk9ynJMkLaCXK5704f/uI200P4/xj66tZ4QWPCnPKR6LEJn0dSG8XaBDxlE4EjTqeIjtpttNDkKPte3qieJjqaUuNGCa9Kgstn4wZ2RsCIrp/SgA4k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=G2tTrkV6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 108A2C4CEED;
	Fri,  8 Aug 2025 19:37:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754681868;
	bh=+sPyrRNmQmGvEQQbsqXAiqW7mrkXp+1FECvjK0+/Nhk=;
	h=From:To:Cc:Subject:Date:Reply-To:From;
	b=G2tTrkV6GOPastvB2cGf74tfwXPjVhbLqIKAHI2Hzlu2RBXqbgGxErHwfR2Xl66Q2
	 KOXY0W/FNMMWlDolDdixTGDSCf7Aqe1HDztin5LG6OHiflO2oJ3mbDjKds7EspQapF
	 pXOQNpUAm6cHYTb/EkqImVQyaYnWa/e+hO30eMlUF2f9fb6Re+BCbzPHP7HuvHzIQv
	 oynQJBhAq9v0ByizS8nPOLyohCGrmQVSboo5ezhuPkFymHyA/BvENc9U3EhwfK2LMe
	 P5VPBvW8qc3vL5u+w4QHRDOoIp/moBAk49p4tl7JtrZVu9JBOz/bRUqqtNoPr816BU
	 Zxf/KbIpXQT/Q==
From: Len Brown <lenb@kernel.org>
To: linux-pm@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	Len Brown <len.brown@intel.com>
Subject: [PATCH 1/1] intel_idle: Allow loading ACPI tables for any family
Date: Fri,  8 Aug 2025 15:37:14 -0400
Message-ID: <06101aa4fe784e5b0be1cb2c0bdd9afcf16bd9d4.1754681697.git.len.brown@intel.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Reply-To: Len Brown <lenb@kernel.org>
Organization: Intel Open Source Technology Center
Content-Transfer-Encoding: 8bit

From: Len Brown <len.brown@intel.com>

There is no reason to limit intel_idle's loading of ACPI tables to
family 6.  Upcoming Intel processors are not in family 6.

Below "Fixes" really means "applies cleanly until".
That syntax commit didn't change the previous logic,
but shows this patch applies back 5-years.

Fixes: 4a9f45a0533f ("intel_idle: Convert to new X86 CPU match macros")
Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/idle/intel_idle.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/idle/intel_idle.c b/drivers/idle/intel_idle.c
index 73747d20df85..91a7b7e7c0c8 100644
--- a/drivers/idle/intel_idle.c
+++ b/drivers/idle/intel_idle.c
@@ -1679,7 +1679,7 @@ static const struct x86_cpu_id intel_idle_ids[] __initconst = {
 };
 
 static const struct x86_cpu_id intel_mwait_ids[] __initconst = {
-	X86_MATCH_VENDOR_FAM_FEATURE(INTEL, 6, X86_FEATURE_MWAIT, NULL),
+	X86_MATCH_VENDOR_FAM_FEATURE(INTEL, X86_FAMILY_ANY, X86_FEATURE_MWAIT, NULL),
 	{}
 };
 
-- 
2.45.2


