Return-Path: <linux-pm+bounces-36495-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E636BF2D1C
	for <lists+linux-pm@lfdr.de>; Mon, 20 Oct 2025 19:56:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 189424206D1
	for <lists+linux-pm@lfdr.de>; Mon, 20 Oct 2025 17:56:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9987321442;
	Mon, 20 Oct 2025 17:55:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Mo8NSVVj"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F5DF221DB5;
	Mon, 20 Oct 2025 17:55:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760982956; cv=none; b=HfCHVEue/NZi/3b2/3nluoCHoLH35FgABBfT3vOEZh9o10gZS9feNbbtNQJKWKlG4wWrmH8JQD1Ju/wlWqGWnpmNkPqrfoo5FgBMSbErlNPKC6/LNles+rkT1eh043TU02fqegzXr0cvA/Dhx4haNyYRamlc13pqBD+h0iBRlXY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760982956; c=relaxed/simple;
	bh=2ogP/70t6tGzuzL3B9RTLcdw87Cips2j3HOmINioEgE=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=r3xOAqBt6J62BsTfVAIdX/Qz7DSnhZPwShq4VnWrf5SgSKcZpQfS5oNGmCoV2T3F72lJoLLIu/l1xi16l9DmO12/Oeg3wlf+5YFrpkPmbKj4omvBjwC2UP5mitsLhwRgWzQ1jv+BCvVMeUAKtb7AQ7oRTJDcP65xRQtWfEIHK24=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Mo8NSVVj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 48771C4CEF9;
	Mon, 20 Oct 2025 17:55:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760982956;
	bh=2ogP/70t6tGzuzL3B9RTLcdw87Cips2j3HOmINioEgE=;
	h=Date:From:To:Cc:Subject:From;
	b=Mo8NSVVjeAIRpA6FHS/EbOrTJsEzTtz1AGOt31ZlFtZYxTFORtMRez9jFUN84yj1K
	 OVU44JAJfBCyuLcJ3Dg4u7iegRdiHY/aInNiBRIXrTxpKJ3ArcpUyOEbjVx138OE5/
	 YvxOnmJP9c1ramUvkKYf4Sv6kHt3hanzmvKyq+iZnWqZ+gLNQJ8sqNLYBo4rky8vlG
	 sHUmUdJhvhayKsozF5HmLf2kYHjO9niIibAM3DTQsGyRVljEF7QO6P8hiTcvxi0/Hg
	 PV+zVpeXvV8tmpUzTXpAkmkyjF9/SksIv9A0RtibmmhWc3A8aTv91Ep6HWJGUHiw/a
	 jRZZYtvKy1hjg==
Date: Mon, 20 Oct 2025 07:55:55 -1000
From: Tejun Heo <tj@kernel.org>
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Qu Wenruo <wqu@suse.com>, linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH PM/for-6.19] freezer: Clarify that only cgroup1 freezer uses
 PM freezer
Message-ID: <aPZ3q6Hm865NicBC@slm.duckdns.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

cgroup1 freezer piggybacks on the PM freezer, which inadvertently allowed
userspace to produce uninterruptible tasks at will. To avoid the issue,
cgroup2 freezer switched to a separate job control based mechanism. While
this happened a long time ago, the code and comment haven't been updated
making it confusing to people who aren't familiar with the history.

Rename cgroup_freezing() to cgroup1_freezing() and update comments on top of
freezing() and frozen() to clarify that cgroup2 freezer isn't covered by the
PM freezer mechanism.

Signed-off-by: Tejun Heo <tj@kernel.org>
Suggested-by: Qu Wenruo <wqu@suse.com>
---
 include/linux/freezer.h        |   12 ++++++++----
 kernel/cgroup/legacy_freezer.c |    2 +-
 kernel/freezer.c               |    2 +-
 3 files changed, 10 insertions(+), 6 deletions(-)

diff --git a/include/linux/freezer.h b/include/linux/freezer.h
index 32884c9721e5..0a8c6c4d1a82 100644
--- a/include/linux/freezer.h
+++ b/include/linux/freezer.h
@@ -22,14 +22,18 @@ extern bool pm_nosig_freezing;		/* PM nosig freezing in effect */
 extern unsigned int freeze_timeout_msecs;
 
 /*
- * Check if a process has been frozen
+ * Check if a process has been frozen for PM or cgroup1 freezer. Note that
+ * cgroup2 freezer uses the job control mechanism and does not interact with
+ * the PM freezer.
  */
 extern bool frozen(struct task_struct *p);
 
 extern bool freezing_slow_path(struct task_struct *p);
 
 /*
- * Check if there is a request to freeze a process
+ * Check if there is a request to freeze a task from PM or cgroup1 freezer.
+ * Note that cgroup2 freezer uses the job control mechanism and does not
+ * interact with the PM freezer.
  */
 static inline bool freezing(struct task_struct *p)
 {
@@ -63,9 +67,9 @@ extern bool freeze_task(struct task_struct *p);
 extern bool set_freezable(void);
 
 #ifdef CONFIG_CGROUP_FREEZER
-extern bool cgroup_freezing(struct task_struct *task);
+extern bool cgroup1_freezing(struct task_struct *task);
 #else /* !CONFIG_CGROUP_FREEZER */
-static inline bool cgroup_freezing(struct task_struct *task)
+static inline bool cgroup1_freezing(struct task_struct *task)
 {
 	return false;
 }
diff --git a/kernel/cgroup/legacy_freezer.c b/kernel/cgroup/legacy_freezer.c
index dd9417425d92..915b02f65980 100644
--- a/kernel/cgroup/legacy_freezer.c
+++ b/kernel/cgroup/legacy_freezer.c
@@ -63,7 +63,7 @@ static struct freezer *parent_freezer(struct freezer *freezer)
 	return css_freezer(freezer->css.parent);
 }
 
-bool cgroup_freezing(struct task_struct *task)
+bool cgroup1_freezing(struct task_struct *task)
 {
 	bool ret;
 
diff --git a/kernel/freezer.c b/kernel/freezer.c
index ddc11a8bd2ea..a76bf957fb32 100644
--- a/kernel/freezer.c
+++ b/kernel/freezer.c
@@ -44,7 +44,7 @@ bool freezing_slow_path(struct task_struct *p)
 	if (tsk_is_oom_victim(p))
 		return false;
 
-	if (pm_nosig_freezing || cgroup_freezing(p))
+	if (pm_nosig_freezing || cgroup1_freezing(p))
 		return true;
 
 	if (pm_freezing && !(p->flags & PF_KTHREAD))

