Return-Path: <linux-pm+bounces-30503-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 87998AFEF78
	for <lists+linux-pm@lfdr.de>; Wed,  9 Jul 2025 19:13:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7A7801C44330
	for <lists+linux-pm@lfdr.de>; Wed,  9 Jul 2025 17:13:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE4FC22425E;
	Wed,  9 Jul 2025 17:12:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Uxml2aPa"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 942FF1F0E50;
	Wed,  9 Jul 2025 17:12:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752081177; cv=none; b=rVbJL7b96j6hPKADWYeaifzTACWxtI8LgY2UiekbWwZOs0rGCGsvdBkl8SFJKsIZGBqactSQBLG5vfuAMhKYNz+sN8Y1GXanz/Xlx09mrSCjOrVMYH6hyLt0/oaCY9ujUFeR2TJyt8Crasr28ekcr88A5v3j/cLInnKLIiVo/XE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752081177; c=relaxed/simple;
	bh=s4xgQFWfqOGsMAYXKhUvxzJT+bBNVYZkFEGG6DruuVs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=LYoOjyyMh3nWW0xbA2BR1crdJfx8r8DGf93DTe1A9iA9Y6VgMXBCPbANDR2MoYfqsccCPwPgQYzGBuVBYvTD5rY/1laZip4HytxG/2//N8KaJM17dUANQa4H2IkbSnjNjPYAOItfm6yjJkIiH+WPJMKSLeaNZdrKd8jXrqKi1BM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Uxml2aPa; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1BA56C4CEEF;
	Wed,  9 Jul 2025 17:12:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752081177;
	bh=s4xgQFWfqOGsMAYXKhUvxzJT+bBNVYZkFEGG6DruuVs=;
	h=From:To:Cc:Subject:Date:From;
	b=Uxml2aPaR2k2BPpasv5uaHERpkSqJpu4dr3eAQmE/JQO4r1gXFPdE1fWf0d0zBJsu
	 7NpGn71Cy//2bITr6DQxBexoJ3Rq8y/JwjzyEOaUrjCIM2aA4izDgmvXytl/B64QsQ
	 pUb1Xg2o/W3j9uslQrvoSC7r7+CA2WFemChfs0uK5zGH7zOyR+QTsclMFy8Q1mqcC9
	 SqUQmZewl7RoiXevt8UPhZUITRlUoUM5rp6UUyDNBnHJwd+W0NccQdL93RG+k1MwWw
	 JPiSgj7bn+aZQE6/KwN1wIgO8fdzXzOORgJ8k0jXy1kPiaCdCb69SgdkL+pCucpwQ3
	 ujBUsz3l+n5MA==
From: "Rafael J. Wysocki" <rafael@kernel.org>
To: Linux PM <linux-pm@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
 Mario Limonciello <mario.limonciello@amd.com>
Subject: [PATCH v1] PM: sleep: Call pm_restore_gfp_mask() after dpm_resume()
Date: Wed, 09 Jul 2025 19:12:47 +0200
Message-ID: <2797018.mvXUDI8C0e@rjwysocki.net>
Organization: Linux Kernel Development
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="UTF-8"

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Commit 12ffc3b1513e ("PM: Restrict swap use to later in the suspend
sequence") changed two pm_restore_gfp_mask() calls in enter_state()
and hibernation_restore() into one pm_restore_gfp_mask() call in
dpm_resume_end(), but it put that call before the dpm_resume()
invocation which is too early (some swap-backing devices may not be
ready at that point).

Moreover, this code ordering change was not even mentioned in the
changelog of the commit mentioned above.

Address this by moving that call after the dpm_resume() one.

Fixes: 12ffc3b1513e ("PM: Restrict swap use to later in the suspend sequence")
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/base/power/main.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/base/power/main.c
+++ b/drivers/base/power/main.c
@@ -1254,8 +1254,8 @@
  */
 void dpm_resume_end(pm_message_t state)
 {
-	pm_restore_gfp_mask();
 	dpm_resume(state);
+	pm_restore_gfp_mask();
 	dpm_complete(state);
 }
 EXPORT_SYMBOL_GPL(dpm_resume_end);




