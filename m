Return-Path: <linux-pm+bounces-31982-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F3345B1C0FD
	for <lists+linux-pm@lfdr.de>; Wed,  6 Aug 2025 09:08:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 921DD3BD7DB
	for <lists+linux-pm@lfdr.de>; Wed,  6 Aug 2025 07:08:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D294215F42;
	Wed,  6 Aug 2025 07:08:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ngyw4Etq"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 110052E371D;
	Wed,  6 Aug 2025 07:08:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754464084; cv=none; b=CoPpg6Ihg4Ws1iZI6S5HUVLg6edhSwkMreRKDL7MR+ilVoEKgz17f9vnWUj7+3qbo2dNY/74VHCfMkyouviKQfBam1KaeCiVxpW210veR72u9YTmyZNs7hliN0OgehSuZ3HzUmLFEHjCDjg94QJvzQckKzQcVVVKlHsxX7/P2uI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754464084; c=relaxed/simple;
	bh=E6/eA5QeIe1HToq//I/2AQFAF8B2dylxKHP/BW4fym0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=AV5qulAld7/bPXs9jX4UBglwGKxPOsIzIw+rT+7tVHlaNxt2SuFnfizSu4c6iiaWHaOkUt9nr/c4IafNnM/qohCg2B0xDhOj0zTSQkvqboIk4jEO14blDfvLxHjhH4pfOuuffnE3RNqxb2GP/jHeYHANZskYrZkszftj7sNOnCw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ngyw4Etq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 9DE87C4CEE7;
	Wed,  6 Aug 2025 07:08:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754464083;
	bh=E6/eA5QeIe1HToq//I/2AQFAF8B2dylxKHP/BW4fym0=;
	h=From:Date:Subject:To:Cc:Reply-To:From;
	b=Ngyw4Etq96JE9IJ68fwHr+IQ7XgI9RBlajFr+tAGozBnpvJ3jhBNkBhiIMCLOAt2l
	 24nQg86mdjrTyY4rt9+1Ca7X4cIn6wjwVPORZbDq9snmpPNrVpkZs8lo5mOyS/50Bi
	 A0k/Jj4hj1fDg6WaghhGK0cD1P591+TFTny6UszlHxWsU1ENlcjmEg8nMYQUFFAC2V
	 Wy2STxX3lljNIwhpXgc2LDlVDAD2af6COPXOAzgCuI1TJPWBuqqNaBeUz878r8sG/s
	 eUTxgEU5kFfRQLp0ZOxgVmqmMxlb3cuOTkF53Efg1/EzYiXr0BnkL2EeJUshBAsmbB
	 01Q7ed4P6ulrg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88E30C87FCB;
	Wed,  6 Aug 2025 07:08:03 +0000 (UTC)
From: Cryolitia PukNgae via B4 Relay <devnull+cryolitia.uniontech.com@kernel.org>
Date: Wed, 06 Aug 2025 15:08:02 +0800
Subject: [PATCH] cpupower: repair mangled powercap comment
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250806-mangled_cpupower-v1-1-1a559130326b@uniontech.com>
X-B4-Tracking: v=1; b=H4sIAFH/kmgC/x2MWwqAIBAAryL7naBCZV0lIsq2WigVpQeEd0/6n
 IGZFyIGwggteyHgRZGczSALBmYb7Yqc5syghCqFFhU/stxxHow/vbsx8FLqqtbNoic1Qc58wIW
 ef9n1KX0jUQ8aYgAAAA==
X-Change-ID: 20250806-mangled_cpupower-5186789f8b2b
To: Thomas Renninger <trenn@suse.com>, Shuah Khan <shuah@kernel.org>, 
 "John B. Wyatt IV" <jwyatt@redhat.com>, John Kacur <jkacur@redhat.com>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Wangyuli@uniontech.com, Guanwentao@uniontech.com, Zhanjun@uniontech.com, 
 Cryolitia PukNgae <cryolitia@uniontech.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1754464082; l=1836;
 i=cryolitia@uniontech.com; s=20250730; h=from:subject:message-id;
 bh=z8rySj9NTsoDFQbVKMmerKhopsqj2e1f45A+CAKIILE=;
 b=EPWBB+fmsrLX1f39+XlFGZVEiToICCSR/A6CF96dUJ1/N3zHxAYwSC6iBslGKvtIxG0jSlxwe
 tufnSpkl2mHDyJnptQnHm/rwA0jmLlP31QewFSc0jEaQLddbEIWCX3v
X-Developer-Key: i=cryolitia@uniontech.com; a=ed25519;
 pk=tZ+U+kQkT45GRGewbMSB4VPmvpD+KkHC/Wv3rMOn/PU=
X-Endpoint-Received: by B4 Relay for cryolitia@uniontech.com/20250730 with
 auth_id=474
X-Original-From: Cryolitia PukNgae <cryolitia@uniontech.com>
Reply-To: cryolitia@uniontech.com

From: Cryolitia PukNgae <cryolitia@uniontech.com>

The current comment exhibits clear patch application artifacts:
1. A stray '-' prefix indicating failed line removal
2. Broken sentence structure from improper context patching

What appears to be version control residue has persisted since its
initial introduction and through the 2022 kernel submission[1]. While
my archaeological efforts only trace back to the 2017 openSUSE patch[2],
the corrupted syntax suggests even older origins that remain elusive -
perhaps maintainers with longer institutional memory could shed light
on its provenance.

Restore grammatical sanity by:
- Removing the redundant second line with its leading '-'
- Preserving only the primary statement about RAPL hardcoding
- Eliminating the fragmented "should show up" clause

The result reflects reality without speculative future-proofing.

1. https://lore.kernel.org/all/20221123111810.16017-2-trenn@suse.de/
2. https://build.opensuse.org/request/show/535512

Signed-off-by: Cryolitia PukNgae <cryolitia@uniontech.com>
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



