Return-Path: <linux-pm+bounces-4472-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F59F86A0EA
	for <lists+linux-pm@lfdr.de>; Tue, 27 Feb 2024 21:35:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AB99CB21D87
	for <lists+linux-pm@lfdr.de>; Tue, 27 Feb 2024 20:35:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 967F4149E1E;
	Tue, 27 Feb 2024 20:34:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dsmTT4EI"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F22848CFC;
	Tue, 27 Feb 2024 20:34:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709066098; cv=none; b=pk9tZyS35cOZGbnIhv98baQgMLe3V4Ucn7KzZEdM9VxkIYjzVX67DZG1SmwkTRTYE28iqWrpXDrb7wq4iIv/bBdrRaAG/0VJJDn/fPM4tHJ28ZcUaSjStBangBDFdUaE2Sti0F029Eu0lBHZ28DI1OPd31UZXrNqCUKJYKOm8yE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709066098; c=relaxed/simple;
	bh=fuq02LWYCcqx9kY7XnPY2NEh/6uK/l5LWBYzjkJwAYw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=fu+B1rmYPOcNqhLUT+rqiX7//sgcXZTCvUoHOMSmeFamanqtOA3aQaiculHGzTC0kKsTqx86oBgzuG2KFR5ihwJrKeEplrK0BfKH6KQeipeZPTCGFSCQM2ZlHcG51EgClNYb0BYITsmxBcOTYg1WOMP2nrJEOF/Jipl79ytIEvs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dsmTT4EI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 02ACDC43390;
	Tue, 27 Feb 2024 20:34:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709066098;
	bh=fuq02LWYCcqx9kY7XnPY2NEh/6uK/l5LWBYzjkJwAYw=;
	h=From:Date:Subject:To:Cc:From;
	b=dsmTT4EIpyPdG1+5343TOBeFvG/dFPZPrt1H5Ya+yVgUiYqWWbEZasdjqeAWCV0Uv
	 uo8Vo+VpwKPWROmYRDpAIigMPZWW4GCp82/a0ImBngGHEsYNIOxo45DYuSZnf02Jec
	 HDveawSLkYAbATnX7Z2phnmfUneuPB4kNqPRTo66tFxn0L5xU5hGEj21KigjhooexZ
	 xumEWQfxjtb6BdvmM2vBPCF+90rrUXvKiBnR7tnoKODV4pgJd2pVg58uxewLIGX7N5
	 etKgXyAEKGrcTbzkRqA0PCPNBy6G8VcYtaBgVpLBI1zI1NDwq4ayZM01/HQJSowvsI
	 Rg3rNJS9LRM6w==
From: Nathan Chancellor <nathan@kernel.org>
Date: Tue, 27 Feb 2024 13:34:42 -0700
Subject: [PATCH] power: supply: core: Fix power_supply_init_attrs() stub
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240227-fix-power_supply_init_attrs-stub-v1-1-43365e68d4b3@kernel.org>
X-B4-Tracking: v=1; b=H4sIAGFH3mUC/x2N0QrCMAwAf2Xk2UCNk4q/IlLWLWpAupJ06hj9d
 8se7+HuNjBWYYNrt4HyR0zm1OB46GB8DenJKFNjIEe9I/L4kB/m+csabMn5vQZJUsJQihpaWSL
 6yOcTXWLPnqBlsnJz9sXtXusfAwBZtHIAAAA=
To: sre@kernel.org, ricardo@marliere.net, linux-pm@vger.kernel.org, 
 patches@lists.linux.dev
Cc: Nathan Chancellor <nathan@kernel.org>
X-Mailer: b4 0.14-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=1790; i=nathan@kernel.org;
 h=from:subject:message-id; bh=fuq02LWYCcqx9kY7XnPY2NEh/6uK/l5LWBYzjkJwAYw=;
 b=owGbwMvMwCUmm602sfCA1DTG02pJDKn33AuVqy+aS3zZ+WXzttP8hivfVHuo1JjnP9ggoH+P8
 cvz6vSfHaUsDGJcDLJiiizVj1WPGxrOOct449QkmDmsTCBDGLg4BWAi57cz/DN9pp5/IMDn2qzs
 5Rs6jrcv+7Rk/+l0xdQ61Qff57w5L1DNyNB06rbJFnnbh14L9u9UldDS2f9soWtq+JRWw2/l3oK
 /BZkA
X-Developer-Key: i=nathan@kernel.org; a=openpgp;
 fpr=2437CB76E544CB6AB3D9DFD399739260CB6CB716

When building without CONFIG_SYSFS, there is an error because of a
recent refactoring that failed to update the stub of
power_supply_init_attrs():

  drivers/power/supply/power_supply_core.c: In function 'power_supply_class_init':
  drivers/power/supply/power_supply_core.c:1630:9: error: too few arguments to function 'power_supply_init_attrs'
   1630 |         power_supply_init_attrs();
        |         ^~~~~~~~~~~~~~~~~~~~~~~
  In file included from drivers/power/supply/power_supply_core.c:25:
  drivers/power/supply/power_supply.h:25:20: note: declared here
     25 | static inline void power_supply_init_attrs(struct device_type *dev_type) {}
        |                    ^~~~~~~~~~~~~~~~~~~~~~~

Update the stub function to take no parameters like the rest of the
refactoring, which resolves the build error.

Fixes: 7b46b60944d7 ("power: supply: core: constify the struct device_type usage")
Signed-off-by: Nathan Chancellor <nathan@kernel.org>
---
 drivers/power/supply/power_supply.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/power/supply/power_supply.h b/drivers/power/supply/power_supply.h
index 232fdd8c1212..7d05756398b9 100644
--- a/drivers/power/supply/power_supply.h
+++ b/drivers/power/supply/power_supply.h
@@ -22,7 +22,7 @@ extern int power_supply_uevent(const struct device *dev, struct kobj_uevent_env
 
 #else
 
-static inline void power_supply_init_attrs(struct device_type *dev_type) {}
+static inline void power_supply_init_attrs(void) {}
 #define power_supply_uevent NULL
 
 #endif /* CONFIG_SYSFS */

---
base-commit: 3da8d71754d3c1aa0b72d74c8a324a4bc7fab473
change-id: 20240227-fix-power_supply_init_attrs-stub-7be5328b4e72

Best regards,
-- 
Nathan Chancellor <nathan@kernel.org>


