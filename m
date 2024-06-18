Return-Path: <linux-pm+bounces-9432-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8029590CBE6
	for <lists+linux-pm@lfdr.de>; Tue, 18 Jun 2024 14:38:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A4E161C22199
	for <lists+linux-pm@lfdr.de>; Tue, 18 Jun 2024 12:38:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26E8E14F13E;
	Tue, 18 Jun 2024 12:36:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uq/gP46q"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE95E14F130;
	Tue, 18 Jun 2024 12:36:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718714193; cv=none; b=owqMYrY5Jl2/kAPB8am2sIitFkCMTjE2m4yhN4ubCJsLjhVvTwYfKtnP5nSAsw4wFpMgJioY13+8jsw3+4K2Ph+2AyPShnExwTjzp7SegjDSYedF4v+BxpWj+E8sv980zS0KqK6BXoPMjPAM/y+KbPIa1795EpqMKZ7ZINs66rE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718714193; c=relaxed/simple;
	bh=Thyw0jk39ehSKVrWbpzk6z0cIctwuMcByciNbZ10WDs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UDxvHuUc+RN6cBCN9sPyQYrs/rVdZrXpo7L/1dy6Q+p7+YU80wGuKeWJ2X53wirhYPN+ug1Awphnpt8IgUClF6GiHhHcZYCoMduL00bdhrTYyWvatRPJrqJ1kWsi+KyrKhaBzQBqD7pXXZNnYRUNExdtEsD89O5/t1fXvi20L8Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uq/gP46q; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6F571C32786;
	Tue, 18 Jun 2024 12:36:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718714192;
	bh=Thyw0jk39ehSKVrWbpzk6z0cIctwuMcByciNbZ10WDs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=uq/gP46qAx4Xs1K99GGZQX9JCtLgggsiVB5uhy/ZRl+q2rVYE+0+TSLoRvG1WxqEN
	 Q3OMb+foQXPhGQTwPa75FWH9hmF5uOApyxgg9PUv1SvttG7clWDpo5OC4lCN6claLu
	 bbMBV7DDpRtcB8bvRG1dj1tJI7RyiFXU3FxkzDqjqQTa0Fm9pbmFNRcw3k+AzDj7O4
	 jj3SZFKY537+JFh4mCuaSBVErr1D+LI8VyQuO0YpaghS2MkxtD6vDYnRL/fiPs2aZD
	 3AqNWE7JJG/ALvwPwjRQsMktYxT8WvkhbftuRXvoN0+oyScsCB4PwH8kD1D++OmtJS
	 RpGksL4Ulvn1w==
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
Subject: [PATCH AUTOSEL 6.9 11/44] tools/power/cpupower: Fix Pstate frequency reporting on AMD Family 1Ah CPUs
Date: Tue, 18 Jun 2024 08:34:52 -0400
Message-ID: <20240618123611.3301370-11-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240618123611.3301370-1-sashal@kernel.org>
References: <20240618123611.3301370-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.9.5
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


