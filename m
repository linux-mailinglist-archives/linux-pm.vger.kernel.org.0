Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9951A3DF6C0
	for <lists+linux-pm@lfdr.de>; Tue,  3 Aug 2021 23:16:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231852AbhHCVQN (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 3 Aug 2021 17:16:13 -0400
Received: from mail.kernel.org ([198.145.29.99]:40846 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231519AbhHCVQN (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Tue, 3 Aug 2021 17:16:13 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id E3A1A60F0F;
        Tue,  3 Aug 2021 21:15:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1628025361;
        bh=hzGVYpSoT4c8eD9xIvtVELfHC2qZ9qRppSvQ6vReMyk=;
        h=From:To:Cc:Subject:Date:From;
        b=D7Z+CKbg2Z3xrAEjI8SCn68xBlte0yJcYGNFV212KyjPRdf6vuWbwxSE61SEMRw9j
         nc7Z8FpXxEVtIA4kNg+PkGkHfaCJRVhJlzKo8RXJGXeSlpUK9G8LpwBNZkYcGVoB11
         BmIzYXXJlKoop/0GwA1/d7+ryoouWpOw1UtZcbyF8hslz+LigrSBt3dNRYdZqaa6NR
         MAwDjI/q1THimh2Tl7OA2Qim/0t9BEGOzcqyiSF72T6HczXbExcnGHyYbfmaGuieLf
         tGQDP1cdDZVVPmc2zVukorqiqIAH1Ek9cpMjBENGR7t/aCJo6qYy1wTrZgWz67jhYP
         WHi0dVrOKTg+Q==
From:   Nathan Chancellor <nathan@kernel.org>
To:     Michael Ellerman <mpe@ellerman.id.au>
Cc:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        "Gautham R. Shenoy" <ego@linux.vnet.ibm.com>,
        linux-pm@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org, clang-built-linux@googlegroups.com,
        Nathan Chancellor <nathan@kernel.org>
Subject: [PATCH] cpuidle: pseries: Mark pseries_idle_proble() as __init
Date:   Tue,  3 Aug 2021 14:15:47 -0700
Message-Id: <20210803211547.1093820-1-nathan@kernel.org>
X-Mailer: git-send-email 2.33.0.rc0
MIME-Version: 1.0
X-Patchwork-Bot: notify
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

After commit 7cbd631d4dec ("cpuidle: pseries: Fixup CEDE0 latency only
for POWER10 onwards"), pseries_idle_probe() is no longer inlined when
compiling with clang, which causes a modpost warning:

WARNING: modpost: vmlinux.o(.text+0xc86a54): Section mismatch in
reference from the function pseries_idle_probe() to the function
.init.text:fixup_cede0_latency()
The function pseries_idle_probe() references
the function __init fixup_cede0_latency().
This is often because pseries_idle_probe lacks a __init
annotation or the annotation of fixup_cede0_latency is wrong.

pseries_idle_probe() is a non-init function, which calls
fixup_cede0_latency(), which is an init function, explaining the
mismatch. pseries_idle_probe() is only called from
pseries_processor_idle_init(), which is an init function, so mark
pseries_idle_probe() as __init so there is no more warning.

Fixes: 054e44ba99ae ("cpuidle: pseries: Add function to parse extended CEDE records")
Signed-off-by: Nathan Chancellor <nathan@kernel.org>
---
 drivers/cpuidle/cpuidle-pseries.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/cpuidle/cpuidle-pseries.c b/drivers/cpuidle/cpuidle-pseries.c
index bba449b77641..7e7ab5597d7a 100644
--- a/drivers/cpuidle/cpuidle-pseries.c
+++ b/drivers/cpuidle/cpuidle-pseries.c
@@ -403,7 +403,7 @@ static void __init fixup_cede0_latency(void)
  * pseries_idle_probe()
  * Choose state table for shared versus dedicated partition
  */
-static int pseries_idle_probe(void)
+static int __init pseries_idle_probe(void)
 {
 
 	if (cpuidle_disable != IDLE_NO_OVERRIDE)

base-commit: a6cae77f1bc89368a4e2822afcddc45c3062d499
-- 
2.33.0.rc0

