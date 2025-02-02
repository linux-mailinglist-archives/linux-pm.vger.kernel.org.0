Return-Path: <linux-pm+bounces-21224-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 679D3A24F17
	for <lists+linux-pm@lfdr.de>; Sun,  2 Feb 2025 18:13:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E0EB4162ED4
	for <lists+linux-pm@lfdr.de>; Sun,  2 Feb 2025 17:12:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A84001FAC33;
	Sun,  2 Feb 2025 17:12:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Hy4n8Ppl"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84CD41FB3
	for <linux-pm@vger.kernel.org>; Sun,  2 Feb 2025 17:12:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738516376; cv=none; b=eq2YrDI9Z1VnsjrTNb+V5FnikTSTRkNAul9tMkhw38Gj+VlwhaKQmXfCyx3rjOfWfp/hCwvDGvYODNGuOx30M/aMBxXpm4fyyGB9WbpEU4YGY2B0izjkyFIx9QMvagiAHlTT+h/PeVPm/Wo0CWeueum+LKNaGKhedMAWxPADgOQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738516376; c=relaxed/simple;
	bh=BuJLxNw1vz+OlyItJ3DDeI9tiugzhIX5h9AxN6MO3pE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=i8O+xpqGPz2E4JfADbGxGr1aECtik9xaY50+quyWALZuyAMiLUzAwIdOB3HKvJ+Xz3NNuZwkVeZU7ViLfaLKN+Sl4EjTKrH/GLokzSwdeoNDxTlExSTb3qla4ITd9k4Rtvk2kllBA48iqZ2nm7cO/XAobD4q5Xq/7TC1XIWazoE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Hy4n8Ppl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 61DBDC4CEE1;
	Sun,  2 Feb 2025 17:12:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738516376;
	bh=BuJLxNw1vz+OlyItJ3DDeI9tiugzhIX5h9AxN6MO3pE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:Reply-To:From;
	b=Hy4n8PpliOiXzZ6JC3I9UkAep6JAV7ejKt8adNHrJnMtoij4yagLrjTzwvjpZQtpz
	 u9QC4YSVBl5PVkv6ggbeJD0iaAk3Ag3qZ6mZA7kHdIVU3SAfhYWiG6b25oIkRjcj6T
	 7987lE2EuUtYJY4wESUUAiwPmXIADziHkq4b9yJO0TigrBieKAsHg1R4i3d6Mr/sPi
	 QJCf3uG8okksm0hcyS+sP+vCBlloIWEwfOnh1JCZUPLzTf6Ayih9mlnCDLl6uwrNE3
	 nj5wS3TQdcVYcUsbn3jnybJQimfKq8QE4F4RZY8vqr8H8FOOtAaA/LqTByYvOjukzI
	 9p3C670wYFywA==
From: Len Brown <lenb@kernel.org>
To: linux-pm@vger.kernel.org
Cc: Zhang Rui <rui.zhang@intel.com>,
	Len Brown <len.brown@intel.com>
Subject: [PATCH 01/25] tools/power turbostat: Add initial support for PantherLake
Date: Sun,  2 Feb 2025 11:09:17 -0600
Message-ID: <e8a99af68c068865dbac7f3330e97bf8e96edf33.1738515889.git.len.brown@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250202171249.402610-1-lenb@kernel.org>
References: <20250202171249.402610-1-lenb@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Reply-To: Len Brown <lenb@kernel.org>
Organization: Intel Open Source Technology Center
Content-Transfer-Encoding: 8bit

From: Zhang Rui <rui.zhang@intel.com>

Add initial support for PantherLake.
It shares the same features with Lunarlake.

Signed-off-by: Zhang Rui <rui.zhang@intel.com>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 tools/power/x86/turbostat/turbostat.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/power/x86/turbostat/turbostat.c b/tools/power/x86/turbostat/turbostat.c
index 58a487c225a7..540336138ce9 100644
--- a/tools/power/x86/turbostat/turbostat.c
+++ b/tools/power/x86/turbostat/turbostat.c
@@ -1024,6 +1024,7 @@ static const struct platform_data turbostat_pdata[] = {
 	{ INTEL_ARROWLAKE_U, &adl_features },
 	{ INTEL_ARROWLAKE, &adl_features },
 	{ INTEL_LUNARLAKE_M, &lnl_features },
+	{ INTEL_PANTHERLAKE_L, &lnl_features },
 	{ INTEL_ATOM_SILVERMONT, &slv_features },
 	{ INTEL_ATOM_SILVERMONT_D, &slvd_features },
 	{ INTEL_ATOM_AIRMONT, &amt_features },
-- 
2.43.0


