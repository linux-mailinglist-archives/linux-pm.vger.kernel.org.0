Return-Path: <linux-pm+bounces-9434-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 61FDB90CD02
	for <lists+linux-pm@lfdr.de>; Tue, 18 Jun 2024 15:03:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D9B25B2B8B5
	for <lists+linux-pm@lfdr.de>; Tue, 18 Jun 2024 13:00:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 520541A072A;
	Tue, 18 Jun 2024 12:40:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rvjr+1GW"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29FA31A0726;
	Tue, 18 Jun 2024 12:40:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718714437; cv=none; b=A7+c8Sc1N/+9MfOMDEmHQanGCR58k2UjmKr/CuT/AmyhXJiVobRvpTAj/nfBZ7T9FzoDy+YRi5lZHhEW9LlrKSkzrUT5LNwp7Wqp5XAHnMEEvJ+B5KjewnyH6yqHvklKC/+hWliaMPQNmwKWzNuV3GzenNbRtjcAZqslJuGuydU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718714437; c=relaxed/simple;
	bh=Thyw0jk39ehSKVrWbpzk6z0cIctwuMcByciNbZ10WDs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UP7uuoHn6bjrgFTfeySqU20lbPBVDpCb4siIQ166Jc/2Iosfay6kZsn4vPs+wpMG9c8mtJe0AuL2n3yaz+4/xMIX8mqf3PDNECTwPGzHwFtprFTujw50M0i65Uko4aE5xMHkDlCoGDdmsCGPJDNQAtTO/GdWkC96E3Z+FfAacvE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rvjr+1GW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E8487C32786;
	Tue, 18 Jun 2024 12:40:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718714437;
	bh=Thyw0jk39ehSKVrWbpzk6z0cIctwuMcByciNbZ10WDs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=rvjr+1GWnp93jzhTvw1oSY4dTYId6hchUBQk1L+kJDAzOH7uVvK223tDgWheGVlct
	 +e2VezakFuXilDcRnWtNFZppg/bUiJOSu19aQLoiWdSrXMo/2Qi3XKNce1TPYZg43R
	 +8xImqb/nOXFr3oU418oGuigrI3blOaGkHsSu3PRFlMHs45GZfdA4b2DCHG9BD+aEb
	 D3/HEDWRjW+BZ4ZnEdQSjG1dCe+B4f0uXErevmtkhWfxJFlv3z/QJs33MSZO5EwoAA
	 WzbsevXExoe6xTw3JWhfLyLCwzYaBEZY7NAyiut6hdxB2OmlIoIRmrQeT5u95d4Q8L
	 Sl3vjGUEceQHQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Dhananjay Ugwekar <Dhananjay.Ugwekar@amd.com>,
	Ananth Narayan <Ananth.Narayan@amd.com>,
	Mario Limonciello <mario.limonciello@amd.com>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>,
	trenn@suse.com,
	shuah@kernel.org,
	linux-pm@vger.kernel.org
Subject: [PATCH AUTOSEL 6.1 10/29] tools/power/cpupower: Fix Pstate frequency reporting on AMD Family 1Ah CPUs
Date: Tue, 18 Jun 2024 08:39:36 -0400
Message-ID: <20240618124018.3303162-10-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240618124018.3303162-1-sashal@kernel.org>
References: <20240618124018.3303162-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.1.94
Content-Transfer-Encoding: 8bit

From: Dhananjay Ugwekar <Dhananjay.Ugwekar@amd.com>

[ Upstream commit 43cad521c6d228ea0c51e248f8e5b3a6295a2849 ]

Update cpupower's P-State frequency calculation and reporting with AMD
Family 1Ah+ processors, when using the acpi-cpufreq driver. This is due
to a change in the PStateDef MSR layout in AMD Family 1Ah+.

Tested on 4th and 5th Gen AMD EPYC system

Signed-off-by: Ananth Narayan <Ananth.Narayan@amd.com>
Signed-off-by: Dhananjay Ugwekar <Dhananjay.Ugwekar@amd.com>
Reviewed-by: Mario Limonciello <mario.limonciello@amd.com>
Signed-off-by: Shuah Khan <skhan@linuxfoundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 tools/power/cpupower/utils/helpers/amd.c | 26 +++++++++++++++++++++---
 1 file changed, 23 insertions(+), 3 deletions(-)

diff --git a/tools/power/cpupower/utils/helpers/amd.c b/tools/power/cpupower/utils/helpers/amd.c
index c519cc89c97f4..0a56e22240fc8 100644
--- a/tools/power/cpupower/utils/helpers/amd.c
+++ b/tools/power/cpupower/utils/helpers/amd.c
@@ -41,6 +41,16 @@ union core_pstate {
 		unsigned res1:31;
 		unsigned en:1;
 	} pstatedef;
+	/* since fam 1Ah: */
+	struct {
+		unsigned fid:12;
+		unsigned res1:2;
+		unsigned vid:8;
+		unsigned iddval:8;
+		unsigned idddiv:2;
+		unsigned res2:31;
+		unsigned en:1;
+	} pstatedef2;
 	unsigned long long val;
 };
 
@@ -48,6 +58,10 @@ static int get_did(union core_pstate pstate)
 {
 	int t;
 
+	/* Fam 1Ah onward do not use did */
+	if (cpupower_cpu_info.family >= 0x1A)
+		return 0;
+
 	if (cpupower_cpu_info.caps & CPUPOWER_CAP_AMD_PSTATEDEF)
 		t = pstate.pstatedef.did;
 	else if (cpupower_cpu_info.family == 0x12)
@@ -61,12 +75,18 @@ static int get_did(union core_pstate pstate)
 static int get_cof(union core_pstate pstate)
 {
 	int t;
-	int fid, did, cof;
+	int fid, did, cof = 0;
 
 	did = get_did(pstate);
 	if (cpupower_cpu_info.caps & CPUPOWER_CAP_AMD_PSTATEDEF) {
-		fid = pstate.pstatedef.fid;
-		cof = 200 * fid / did;
+		if (cpupower_cpu_info.family >= 0x1A) {
+			fid = pstate.pstatedef2.fid;
+			if (fid > 0x0f)
+				cof = (fid * 5);
+		} else {
+			fid = pstate.pstatedef.fid;
+			cof = 200 * fid / did;
+		}
 	} else {
 		t = 0x10;
 		fid = pstate.pstate.fid;
-- 
2.43.0


