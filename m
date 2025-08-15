Return-Path: <linux-pm+bounces-32428-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CFED1B27CFD
	for <lists+linux-pm@lfdr.de>; Fri, 15 Aug 2025 11:25:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E917EB05A9A
	for <lists+linux-pm@lfdr.de>; Fri, 15 Aug 2025 09:17:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A31132D59E5;
	Fri, 15 Aug 2025 09:14:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="a8YFn/S3"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7ADF02D4B75;
	Fri, 15 Aug 2025 09:14:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755249280; cv=none; b=XH5/3Pti5Xxr5LEEqovOFOx3+ZM4CJPrfLnT7pqCQ+wC2UpUvZVX4e7JxX/nlPCkZUsncWGSJ98O+jjAsNDa9HG8lGegyWhE5xqBtnGZy2klzGwagn+d8dfDVczZ9sPXFgft/pp5MLMLALj3pLxTdS/c+1uNYObYI4XC0o0Cv2I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755249280; c=relaxed/simple;
	bh=QZjvCZwPx47dYvhGTHPDlNi0jae0uoi4YRRACk1E9qw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=E4UaVsSOaWpAoJz8q3bj2F6mnv5i0kXwxPPckY25Iq/ME/SRtUfiuuVKgRhz0SJeAHudYtL43LWyMYojpq3gny+UZerbDFgLWfljAGFgfcQqDOytF/12Z4xR1QSxgFRsPcg1wHX2+We2U4sW8p1oZZrJnekpaAOcL/xf14zpMIY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=a8YFn/S3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id E6E65C4CEEB;
	Fri, 15 Aug 2025 09:14:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755249279;
	bh=QZjvCZwPx47dYvhGTHPDlNi0jae0uoi4YRRACk1E9qw=;
	h=From:Date:Subject:To:Cc:Reply-To:From;
	b=a8YFn/S3P61J8sbJi4SrFh1yUqhu3tvXfSF9eG3PBFA3pNMcEOvVAgbYT3VuP85j8
	 p72KTPzXUro2zcJXh6pP+So83BZiff9iE7BOpGF+r6Eq1bMnd0Jy9yDjDfMDAXNgWS
	 /nD75tos7QJtj2E+QA1gBjtQ+GO1zIsQBycLRtKouu8Jdz9bugfpHg0nLl++OLmAn9
	 3X8uyAarvxuiaH6FdqZgqlYRjkU8jLwgQMcS/TxIRMIUA05vDjLwvluIY4XR9qM1G6
	 bf/62jQtZE/l1c/uJFEJGewIvnIB/bx7/IYs2bNmOXTohmW1eEY7cBn1rypz+HHHEV
	 Ryrys5xpV3qTA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0D4ACA0ED1;
	Fri, 15 Aug 2025 09:14:39 +0000 (UTC)
From: Cryolitia PukNgae via B4 Relay <devnull+cryolitia.uniontech.com@kernel.org>
Date: Fri, 15 Aug 2025 17:14:30 +0800
Subject: [PATCH v2] cpupower: fix mangled powercap comment
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250815-mangled_cpupower-v2-1-6ec877145c47@uniontech.com>
X-B4-Tracking: v=1; b=H4sIAHX6nmgC/32OTQ6CMBCFr0JmbU1bUiyuuIchBspgm0hLWkAN6
 d0dOYB5q+8l72eHhNFhgmuxQ8TNJRc8gTwVYGznH8jcQAySS8U1r9hE5hOHu5nXObwwMiV0ddH
 1qHvZA8XmiKN7H5W3lti6tIT4ORY28XP/lG2CkTqlalHyUlZ9s3p6tKCxZxMmaHPOX+9rdBC0A
 AAA
X-Change-ID: 20250806-mangled_cpupower-5186789f8b2b
To: Thomas Renninger <trenn@suse.com>, Shuah Khan <shuah@kernel.org>, 
 "John B. Wyatt IV" <jwyatt@redhat.com>, John Kacur <jkacur@redhat.com>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Wangyuli@uniontech.com, Guanwentao@uniontech.com, Zhanjun@uniontech.com, 
 Niecheng1@uniontech.com, Cryolitia PukNgae <cryolitia@uniontech.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1755249278; l=1825;
 i=cryolitia@uniontech.com; s=20250730; h=from:subject:message-id;
 bh=9ykgyTgoh2lTXbqw1zH4abC6aqqZU7uyOJ0J1/86iV8=;
 b=ifh4iMw6UDBi/MHxRQzpTQPSYx63sosgOtlReVx/ZxojPljMaonehGX2QF4yF/FLEpUHwMGnM
 3P9GbJMxTUDAwHUGvoQstp0otfJbvjTPQv53pMe0RsZ5AXS5LGrsrL+
X-Developer-Key: i=cryolitia@uniontech.com; a=ed25519;
 pk=tZ+U+kQkT45GRGewbMSB4VPmvpD+KkHC/Wv3rMOn/PU=
X-Endpoint-Received: by B4 Relay for cryolitia@uniontech.com/20250730 with
 auth_id=474
X-Original-From: Cryolitia PukNgae <cryolitia@uniontech.com>
Reply-To: cryolitia@uniontech.com

From: Cryolitia PukNgae <cryolitia@uniontech.com>

Remove leading dashes from current comments and clarify its semantics

Signed-off-by: Cryolitia PukNgae <cryolitia@uniontech.com>
---
The current comment exhibits a clear failed patch application artifact:
1. A stray '-' prefix indicating failed line removal
2. Broken sentence structure from improper context patching

For those interested in archaeology:

What appears to be version control residue has persisted since its
initial introduction and through the 2022 kernel submission[1]. While
my archaeological efforts only trace back to the 2017 openSUSE patch[2],
the corrupted syntax suggests even older origins that remain elusive -
perhaps maintainers with longer institutional memory could shed light
on its provenance.

1. https://lore.kernel.org/all/20221123111810.16017-2-trenn@suse.de/
2. https://build.opensuse.org/request/show/535512
---
Changes in v2:
- Simplify expression
- Link to v1: https://lore.kernel.org/r/20250806-mangled_cpupower-v1-1-1a559130326b@uniontech.com
---
 tools/power/cpupower/lib/powercap.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/tools/power/cpupower/lib/powercap.c b/tools/power/cpupower/lib/powercap.c
index 94a0c69e55ef5e4291b13a4218e706fa8d14e6a7..609943c829efce8045d97097b5f5e9ec86d0f519 100644
--- a/tools/power/cpupower/lib/powercap.c
+++ b/tools/power/cpupower/lib/powercap.c
@@ -87,8 +87,6 @@ int powercap_set_enabled(int mode)
 
 /*
  * Hardcoded, because rapl is the only powercap implementation
-- * this needs to get more generic if more powercap implementations
- * should show up
  */
 int powercap_get_driver(char *driver, int buflen)
 {

---
base-commit: 6bcdbd62bd56e6d7383f9e06d9d148935b3c9b73
change-id: 20250806-mangled_cpupower-5186789f8b2b

Best regards,
-- 
Cryolitia PukNgae <cryolitia@uniontech.com>



