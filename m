Return-Path: <linux-pm+bounces-9333-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 98C9390B292
	for <lists+linux-pm@lfdr.de>; Mon, 17 Jun 2024 16:42:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 13E7DB28A3C
	for <lists+linux-pm@lfdr.de>; Mon, 17 Jun 2024 13:56:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82B1D16CD03;
	Mon, 17 Jun 2024 13:25:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="APl9O4ji"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57C711990C4;
	Mon, 17 Jun 2024 13:25:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718630715; cv=none; b=DlO+4FrHs4en4+Tj2KqeW+uNbq8Ijd0PiGJ+chG5WJNwkKZuHQ8XFXz+oRHTWd9lLa7Hcq378wh500S69c7T1XfH7i81RgGbPOi6nIsw/URyCrsJLjIhgw7MR91wyY0G5GNiNTzMMlwAYx/pM4x9NojmX3fxjalhtbgqgZxBk+4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718630715; c=relaxed/simple;
	bh=Thyw0jk39ehSKVrWbpzk6z0cIctwuMcByciNbZ10WDs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SX4VhQ/PyQbZh4AwSm+yx1Td4LQAZwTLCJKarb+QIaf9wPJABRNzeACz8pofDmtnytVpJmKLWlRNeXGXNddXGjCtdvYpS+dTiba8fn1x561PzKAXkpEYEUtnL1ycegpm+yARr1PcU0pnPoiwgRSNQFdyuhfMGNSrr7Kmmd77Kc8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=APl9O4ji; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1EA8CC2BD10;
	Mon, 17 Jun 2024 13:25:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718630715;
	bh=Thyw0jk39ehSKVrWbpzk6z0cIctwuMcByciNbZ10WDs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=APl9O4jiYck33Fz2lbECXtnfU08LGQ54UbC8J3yz1+c8QqSCXSStARghy2Q9CcoPp
	 EMwh9RDK+Z1FNJy/3GEW59KxPhZgY7Nyij3tIJXukqNH8492UVJoZAAS26NkEsp7r0
	 pm8R3Sl4hNSJMS2JGVu6XPr5myFEqv96QpvSLAJp+m1QxaO2ZjWolpbisBYDFSbdoP
	 n/QnGg5s+nl0uCAjsRLkge+P/l5p2K7FoLj+RE4WU+M/cyQxtMaj81kf1Kx5o5M/o7
	 zD5Hz/sJiSVDNXOqLO3c2Ca6A1+p/YmOpJ6DsqV8+i0k3nEK5rM+jG07PJ6kUX+Ypl
	 CArIVdbedJBWw==
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
Date: Mon, 17 Jun 2024 09:24:14 -0400
Message-ID: <20240617132456.2588952-10-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240617132456.2588952-1-sashal@kernel.org>
References: <20240617132456.2588952-1-sashal@kernel.org>
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


