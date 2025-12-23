Return-Path: <linux-pm+bounces-39832-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F198CD8C1F
	for <lists+linux-pm@lfdr.de>; Tue, 23 Dec 2025 11:18:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 97A8C3037B88
	for <lists+linux-pm@lfdr.de>; Tue, 23 Dec 2025 10:17:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B18E35294F;
	Tue, 23 Dec 2025 10:05:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="opKpWlM3"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1BAC3502B6;
	Tue, 23 Dec 2025 10:05:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766484326; cv=none; b=BIADqMPcAmkyirBs84gAJcDXSSJUpnYM3RnNaod+m2FOUNeI2EWtWNW9ML6+YTxBBEMiJ3w6s+OhIHDTAep+ryoKbCI3OKRcbwnpCghjL7Wc6LSrdXab9HNcRe/UOQvyLPcD67js27nJLss8YwshnIa3voJbodJv4L5ZqdQyLaA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766484326; c=relaxed/simple;
	bh=gqI9aLJ5vgEv/qPbuDXITGmQgMewjpAga/d828QbJvU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dEOInRb9ZyGkFRV/C5Q6wYyJLn6lwEU6jmDkFagdgHNiUeK4SLUTAEXPaUOn5AzMlsPIpgXq2P6mfL89vNtN/Yt5EbpwMxEwKhCoSABEyBTpjVGHRlWUEUC4c589nYpt+PzeFEtyRX8u5ywqB7Q9uSfyDAxAp/6AoWIH5QUnk78=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=opKpWlM3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AA110C19421;
	Tue, 23 Dec 2025 10:05:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1766484325;
	bh=gqI9aLJ5vgEv/qPbuDXITGmQgMewjpAga/d828QbJvU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=opKpWlM3qGE/sJfup6Cr7dzVmYrHbPINtm/LV/WLZr8l1WI2xrGS6QpD5PewlndAi
	 QYTcuCAV2mM6rDLiH1AIWl4BVzsUpgrSX0Hg4Y5WpvK7Te0jYyuRw/osEKC0mi4o/N
	 gjIc9rgEqxVqYvqh+aV0fgWoQTS/bmI1CKoj9yErdQWvLuHJexqHfkhoxe37eKKlwh
	 RnB1bQ3iddJ/k7dW0O2bimuCvo104jWaXcGsLOiRmcX6+KVoqKO/CLNd73GxFbuUG5
	 EYZYwrrvlhds+BVa9Lwkd23HO0//6xOhq2uSRwAsHDnBx02AsuKvYQnzNdPnPDKYJJ
	 gQ2mGOVbq0sVw==
From: Sasha Levin <sashal@kernel.org>
To: patches@lists.linux.dev,
	stable@vger.kernel.org
Cc: Sumeet Pawnikar <sumeet4linux@gmail.com>,
	"Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
	Sasha Levin <sashal@kernel.org>,
	rafael@kernel.org,
	linux-pm@vger.kernel.org
Subject: [PATCH AUTOSEL 6.18-5.10] powercap: fix race condition in register_control_type()
Date: Tue, 23 Dec 2025 05:05:09 -0500
Message-ID: <20251223100518.2383364-5-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251223100518.2383364-1-sashal@kernel.org>
References: <20251223100518.2383364-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.18.2
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Sumeet Pawnikar <sumeet4linux@gmail.com>

[ Upstream commit 7bda1910c4bccd4b8d4726620bb3d6bbfb62286e ]

The device becomes visible to userspace via device_register()
even before it fully initialized by idr_init(). If userspace
or another thread tries to register a zone immediately after
device_register(), the control_type_valid() will fail because
the control_type is not yet in the list. The IDR is not yet
initialized, so this race condition causes zone registration
failure.

Move idr_init() and list addition before device_register()
fix the race condition.

Signed-off-by: Sumeet Pawnikar <sumeet4linux@gmail.com>
[ rjw: Subject adjustment, empty line added ]
Link: https://patch.msgid.link/20251205190216.5032-1-sumeet4linux@gmail.com
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---

LLM Generated explanations, may be completely bogus:

This confirms the race condition mechanism:

1. `control_type_valid()` walks `powercap_cntrl_list` to validate
   control types (lines 329-345)
2. Called at `powercap_register_zone()` entry (line 497)
3. **Race window**: After `device_register()` but before
   `list_add_tail()`, any zone registration fails because the
   control_type isn't in the list yet

### 8. FINAL ASSESSMENT

| Criteria | Assessment |
|----------|------------|
| Fixes a real bug | ✅ Race condition causing zone registration failure
|
| Obviously correct | ✅ Classic init-before-publish pattern |
| Small and contained | ✅ ~20 lines in one function |
| No new features | ✅ Only reorders existing code |
| No new APIs | ✅ No userspace-visible changes |
| Low regression risk | ✅ Standard pattern, proper error handling |
| Affects stable users | ✅ Powercap used on many Intel systems |

**Why this matters to stable users:**
- Intel RAPL (Running Average Power Limit) uses powercap
- Common on laptops and servers for power management
- Race can cause power capping features to fail during boot/module load
- This is an existing bug that has been present since powercap was
  introduced

**Risk vs Benefit:**
- **Benefit**: Fixes a real race that causes functional failures
- **Risk**: Very low - the fix follows standard kernel patterns and adds
  proper cleanup
- **Trade-off**: Strongly favors backporting

**Concerns:**
- No dependencies on other commits
- The change is self-contained and should apply cleanly to stable trees
- The powercap subsystem has existed since kernel 3.11, so applicable to
  all current stable trees

The fix is small, surgical, obviously correct, and addresses a real race
condition that can cause user-visible failures. It meets all stable
kernel criteria.

**YES**

 drivers/powercap/powercap_sys.c | 16 +++++++++++-----
 1 file changed, 11 insertions(+), 5 deletions(-)

diff --git a/drivers/powercap/powercap_sys.c b/drivers/powercap/powercap_sys.c
index 4112a0097338..d14b36b75189 100644
--- a/drivers/powercap/powercap_sys.c
+++ b/drivers/powercap/powercap_sys.c
@@ -625,17 +625,23 @@ struct powercap_control_type *powercap_register_control_type(
 	INIT_LIST_HEAD(&control_type->node);
 	control_type->dev.class = &powercap_class;
 	dev_set_name(&control_type->dev, "%s", name);
-	result = device_register(&control_type->dev);
-	if (result) {
-		put_device(&control_type->dev);
-		return ERR_PTR(result);
-	}
 	idr_init(&control_type->idr);
 
 	mutex_lock(&powercap_cntrl_list_lock);
 	list_add_tail(&control_type->node, &powercap_cntrl_list);
 	mutex_unlock(&powercap_cntrl_list_lock);
 
+	result = device_register(&control_type->dev);
+	if (result) {
+		mutex_lock(&powercap_cntrl_list_lock);
+		list_del(&control_type->node);
+		mutex_unlock(&powercap_cntrl_list_lock);
+
+		idr_destroy(&control_type->idr);
+		put_device(&control_type->dev);
+		return ERR_PTR(result);
+	}
+
 	return control_type;
 }
 EXPORT_SYMBOL_GPL(powercap_register_control_type);
-- 
2.51.0


