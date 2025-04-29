Return-Path: <linux-pm+bounces-26425-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CA910AA3D86
	for <lists+linux-pm@lfdr.de>; Wed, 30 Apr 2025 02:01:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BB27817010E
	for <lists+linux-pm@lfdr.de>; Wed, 30 Apr 2025 00:00:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0C6E255F55;
	Tue, 29 Apr 2025 23:51:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lDLGiDuX"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75D37289E36;
	Tue, 29 Apr 2025 23:51:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745970688; cv=none; b=A5Mtm0bJTBQjbFgBOtf/QS5lN47oxj5MPgUU3MgYCY4XSaIQmJEI/DM2k+Uz7sWTiUpIjXjDgYSDtbCPb/RFR6rWykYH9gIsrT2UjPj2wkU+jr3WjtfbWXfGxXP7iDhtfKQRuC9DsVKxhNh2/qOV2uSbJGp45vt0WpRC7kAn+yo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745970688; c=relaxed/simple;
	bh=zjSRx6SysfioPY3K1Prjqvm9ZdLjto2YOs0mwhoLir4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Pf9WPbMyExxHq03xButX/ibZh/KpBzmtF2SLxjAjAAqiidnmdEXTvM29RebMI4FSRfz5VF+gC8eizqqJIjNXU5q8q4Kh5GEu5a824oi9jh0mgBVi2C17WpiAF5BzM2ooc9EZ/vlUWs7EhclfzV9/TR2aPmiekEQvh+2pgK/kSgc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lDLGiDuX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0D0EAC4CEEE;
	Tue, 29 Apr 2025 23:51:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745970687;
	bh=zjSRx6SysfioPY3K1Prjqvm9ZdLjto2YOs0mwhoLir4=;
	h=From:To:Cc:Subject:Date:From;
	b=lDLGiDuX4XmaSoVx92ksrjmy0InamrhGV6P1x3xSDa9tS7//YlsTSjIECmONVM3HS
	 AZf1gBo4l/a+ZOuO17WHNwhsZSG/v8Uj6E86CsWcPT4kyNCpkqPjZ3yZxie8r/2sHC
	 uQ58eGxvn2G8mKNg/vPAd/aC7G5DhHzlfTvOfs92Z5aks5hk7jyWXE9bMJdHCPCzxh
	 d7BeNbvXgYsKTPqRO+cLuv9ByYFSvP1+jm0bXLzv2y78o0kUw3Lys37OseuCwoBIAU
	 bXobgBZ3+EklyXAmJsJggOpRMp2LyIwNFySjXdPVwNCmUnG3f8XDlnttbXCaFMhG2V
	 4/0MPGGuRdaUg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Pengyu Luo <mitltlatltl@gmail.com>,
	Viresh Kumar <viresh.kumar@linaro.org>,
	Sasha Levin <sashal@kernel.org>,
	rafael@kernel.org,
	linux-pm@vger.kernel.org
Subject: [PATCH AUTOSEL 6.12 01/37] cpufreq: Add SM8650 to cpufreq-dt-platdev blocklist
Date: Tue, 29 Apr 2025 19:50:46 -0400
Message-Id: <20250429235122.537321-1-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.12.25
Content-Transfer-Encoding: 8bit

From: Pengyu Luo <mitltlatltl@gmail.com>

[ Upstream commit fc5414a4774e14e51a93499a6adfdc45f2de82e0 ]

SM8650 have already been supported by qcom-cpufreq-hw driver, but
never been added to cpufreq-dt-platdev. This makes noise

[    0.388525] cpufreq-dt cpufreq-dt: failed register driver: -17
[    0.388537] cpufreq-dt cpufreq-dt: probe with driver cpufreq-dt failed with error -17

So adding it to the cpufreq-dt-platdev driver's blocklist to fix it.

Signed-off-by: Pengyu Luo <mitltlatltl@gmail.com>
Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/cpufreq/cpufreq-dt-platdev.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/cpufreq/cpufreq-dt-platdev.c b/drivers/cpufreq/cpufreq-dt-platdev.c
index 78ad3221fe077..67bac12d4d55b 100644
--- a/drivers/cpufreq/cpufreq-dt-platdev.c
+++ b/drivers/cpufreq/cpufreq-dt-platdev.c
@@ -172,6 +172,7 @@ static const struct of_device_id blocklist[] __initconst = {
 	{ .compatible = "qcom,sm8350", },
 	{ .compatible = "qcom,sm8450", },
 	{ .compatible = "qcom,sm8550", },
+	{ .compatible = "qcom,sm8650", },
 
 	{ .compatible = "st,stih407", },
 	{ .compatible = "st,stih410", },
-- 
2.39.5


