Return-Path: <linux-pm+bounces-10177-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6684F91BB66
	for <lists+linux-pm@lfdr.de>; Fri, 28 Jun 2024 11:25:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 21A3628164B
	for <lists+linux-pm@lfdr.de>; Fri, 28 Jun 2024 09:25:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CAF515252E;
	Fri, 28 Jun 2024 09:25:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b="P+TlT/a0"
X-Original-To: linux-pm@vger.kernel.org
Received: from layka.disroot.org (layka.disroot.org [178.21.23.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B5AF14F133;
	Fri, 28 Jun 2024 09:25:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.21.23.139
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719566747; cv=none; b=hrqUhxmC9N/gYfRjPDdNR+WL0H18Zsq8pXtSW+OF9xCpMpDZKumeO+/ot8Vs3uDoH3qc0dvc3paN6N+5v6M1DhmdbZILAgmru1+OzoKplxKdXQdUuaZgUkDtydJ4+79NLn9uMnhpRYZPw0WLnLCpGBx+3vKURnwBrHveXwQFaKo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719566747; c=relaxed/simple;
	bh=oWprNiLow2Z2p69ly3S4f0E+LYI4a0O8lDIvoP1gPGA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=p9Fcq4th47ZNFtZlqyCJhkIhnKrycol8LdLQpozLaTVFOx/CDHLG1+Ln5Baeg35BpIp/Xwt3BIFct5sIlsRNQviX/Qhe+wDZF0etIqiHevMb9qOWAwTaBhOl5Q8BQOhOcvlccJhEhHeC1xHWTZTPvxhZ+rrk3+w9ztTbBpTVEn8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org; spf=pass smtp.mailfrom=disroot.org; dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b=P+TlT/a0; arc=none smtp.client-ip=178.21.23.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=disroot.org
X-Virus-Scanned: SPAM Filter at disroot.org
From: Daniel Hejduk <danielhejduk@disroot.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=disroot.org; s=mail;
	t=1719566743; bh=oWprNiLow2Z2p69ly3S4f0E+LYI4a0O8lDIvoP1gPGA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=P+TlT/a0rso/51KipMV9TWrg1/iI2S3at0/G98Zk4F5O9lwr2J3fDwW/A5A1mBQBe
	 hCNjVr86/4VwJJ1/Z2qriB9ssHAN91Q0YRZsLcpgV9iW31byUt5NHTxEcKmDxJCxBh
	 RsO6ZLsvZqrGNT7ZV0HlHuPyBMeNsCkiq8s3njhdZp3r0FSKgUAG7e21LKxSfZEqRZ
	 e4SIgWEh3iLWpk3eIUVk8aev9XqofF0Iw27eCB6u7hL+qAajlWH07YmafYgnMt+Xhk
	 +ujeiuhx2lPzk/wwJhJ5s+L6yqbjuuety6o+4wzvbc7+ThzNaC2qlqV4CuZ96U+nkl
	 aV2TAf4DM0kIQ==
To: shuah@kernel.org,
	trenn@suse.com,
	linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Daniel Hejduk <danielhejduk@disroot.org>
Subject: [PATCH 4/4] Signed-off-by: Daniel Hejduk <danielhejduk@disroot.org>
Date: Fri, 28 Jun 2024 11:25:04 +0200
Message-ID: <20240628092508.3664-5-danielhejduk@disroot.org>
In-Reply-To: <20240627135437.2301-1-danielhejduk@disroot.org>
References: <20240627135437.2301-1-danielhejduk@disroot.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Adding ChangeLog
---
 tools/power/cpupower/ChangeLog | 4 ++++
 1 file changed, 4 insertions(+)
 create mode 100644 tools/power/cpupower/ChangeLog

diff --git a/tools/power/cpupower/ChangeLog b/tools/power/cpupower/ChangeLog
new file mode 100644
index 000000000..e05c8a21b
--- /dev/null
+++ b/tools/power/cpupower/ChangeLog
@@ -0,0 +1,4 @@
+2024-06-28  Daniel Hejduk <danielhejduk@disroot.org>
+		* Changing maintainer to Daniel Hejduk
+		* Fixing all needs work strings
+		* Adding some strings
-- 
2.45.2


