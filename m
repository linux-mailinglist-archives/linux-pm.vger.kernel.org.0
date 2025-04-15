Return-Path: <linux-pm+bounces-25464-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EC584A89A3E
	for <lists+linux-pm@lfdr.de>; Tue, 15 Apr 2025 12:32:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 584F43B221A
	for <lists+linux-pm@lfdr.de>; Tue, 15 Apr 2025 10:31:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 741A628F525;
	Tue, 15 Apr 2025 10:27:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AdXQISoA"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FA9628E5FF
	for <linux-pm@vger.kernel.org>; Tue, 15 Apr 2025 10:27:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744712857; cv=none; b=PWiPlUBiynWXq8AjwsvNkSmmVTe0ZiHbGh6Z9ueMM+uTriXivWMltakynd0YBhBEE+Yt7Ki95t8PHJV85LbHEAMewxTMRlFHyq+XrbACrTQOTIzsMkv+Yf2mWM33pZ0bqNUNe9JAEtogKHV1c9IWzVkUkMfIyRCxWuZ7wC9v7qw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744712857; c=relaxed/simple;
	bh=RhcTwcCCrLXw0YYVMXWW4hvuqkpyOrCfxFPhrEEKWo0=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=pFP+t4iz0iTQ8kfzVYnVkoTvz5kT13v66xtqL4SgrK3B61DxCx5YCRT/LoFRHbsyGcs22VbpXb7WuSxMNT3bBTGo2cdYT2jPs5maPSIh8UiWZJCCEANf2vMsjT9yF9s7eeHaF4SkM7XiMcc/sIe2Ho0w96gTIEcktzbf4EGt5pU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AdXQISoA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id C2E23C4CEEC
	for <linux-pm@vger.kernel.org>; Tue, 15 Apr 2025 10:27:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744712856;
	bh=RhcTwcCCrLXw0YYVMXWW4hvuqkpyOrCfxFPhrEEKWo0=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=AdXQISoAJC06U6FHI+111VcU6mGkV+Lp/4AWODwKE2FqbAVwwnUCKxRDtXFy5u23J
	 Kh0Sp3k2KvPMW7SseEH45KwS9zZQo2gBWmwZ/ILTo7MFsBSb31MkNKVkSECLkKF9fL
	 o0DOejiHrUrO6HpSE6tK9wE3j2b7MZWsYTINhPTjBxMBVSblsLI8aSxEb0D6vkWsbQ
	 rcaIhhdNinACtHek3UgS1Xd+pLFv+D5rjMr5+rBwDGIYezSp6ZeCL9unT+XPcoVsIu
	 KaFqwF2PcENcclbKoVAOddCqqMhHy2ZftXbNu0MdiO+mwRPKys5o33ERqxoDGj+1Zb
	 sWwXFL+GXcXrA==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id B0AFEC53BBF; Tue, 15 Apr 2025 10:27:36 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-pm@vger.kernel.org
Subject: [Bug 220013] [REGRESSION, BISECTED] acpi-cpufreq: Boost disablement
 not being restored after resume from suspend
Date: Tue, 15 Apr 2025 10:27:36 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Power Management
X-Bugzilla-Component: cpufreq
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: viresh.kumar@linaro.org
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: linux-pm@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-220013-137361-oQImUGqpEb@https.bugzilla.kernel.org/>
In-Reply-To: <bug-220013-137361@https.bugzilla.kernel.org/>
References: <bug-220013-137361@https.bugzilla.kernel.org/>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Bugzilla-URL: https://bugzilla.kernel.org/
Auto-Submitted: auto-generated
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

https://bugzilla.kernel.org/show_bug.cgi?id=3D220013

--- Comment #2 from Viresh Kumar (viresh.kumar@linaro.org) ---
diff --git a/drivers/cpufreq/acpi-cpufreq.c b/drivers/cpufreq/acpi-cpufreq.c
index 924314cdeebc..d8599ae7922f 100644
--- a/drivers/cpufreq/acpi-cpufreq.c
+++ b/drivers/cpufreq/acpi-cpufreq.c
@@ -538,6 +538,7 @@ static int cpufreq_boost_down_prep(unsigned int cpu)
         * Clear the boost-disable bit on the CPU_DOWN path so that
         * this cpu cannot block the remaining ones from boosting.
         */
+       policy->boost_enabled =3D true;
        return boost_set_msr(1);
 }

Can you try this change please ?

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=

