Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 102062427E5
	for <lists+linux-pm@lfdr.de>; Wed, 12 Aug 2020 11:49:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726601AbgHLJt0 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 12 Aug 2020 05:49:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726572AbgHLJt0 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 12 Aug 2020 05:49:26 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22F8BC06174A
        for <linux-pm@vger.kernel.org>; Wed, 12 Aug 2020 02:49:26 -0700 (PDT)
From:   Martin Kaistra <martin.kaistra@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1597225763;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=d9B5wRKcMTUcm7mKpDxWYv/osTHA3QQ1pzbQZX39MTo=;
        b=Cj6fHMwvbgMKvduTAnKYM4AMuiPNU8XXohzbqwwMWRbyX878RfO2PemszFdYfm4jmPBcSN
        ZrmPaeBkJ4o/InOWieA8Oy5+us5akS90FItFlN63zu6ZF68ymKKA93A5X9xXCX21DFKjwU
        7Ep6Yw0yGFxwLoGDaYIAdlHiqvwkPxDgURVfINqxoKGyJCpVpa9dPXwm442lueQ2MzQ6wR
        2XtOsDMMhRWSRavIo9b1C7V656ZC0rO+3Bhtf4EAsWRMAREAWiEHEnv625PxHmYpNBuV0q
        /dt+9rZc6/0hNkmMWsmz+Xkglma5AHcjULGrdRsmxYXRbqJGoykeJ/9NikmVXA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1597225763;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=d9B5wRKcMTUcm7mKpDxWYv/osTHA3QQ1pzbQZX39MTo=;
        b=tePhsYnLMhOUh7Ae6Rq2FC4AyKaIFrn1ybMxakMCbZl6DuMd6d/XthPxvW+7fU4miuQnug
        AFhSOEy7s8Cs4UCw==
To:     shuah@kernel.org, trenn@suse.com
Cc:     linux-pm@vger.kernel.org,
        Martin Kaistra <martin.kaistra@linutronix.de>
Subject: [PATCH] cpupower: speed up generating git version string
Date:   Wed, 12 Aug 2020 11:49:12 +0200
Message-Id: <20200812094912.2648-1-martin.kaistra@linutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The variable VERSION is expanded for every use of CFLAGS. This causes
"git describe" to get called multiple times on the kernel tree, which
can be quite slow.

The git revision does not change during build, so we can use simple
variable expansion to set VERSION.

Signed-off-by: Martin Kaistra <martin.kaistra@linutronix.de>
---
 tools/power/cpupower/Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/power/cpupower/Makefile b/tools/power/cpupower/Makefile
index c8622497ef23..c7bcddbd486d 100644
--- a/tools/power/cpupower/Makefile
+++ b/tools/power/cpupower/Makefile
@@ -51,7 +51,7 @@ DESTDIR ?=
 # Package-related definitions. Distributions can modify the version
 # and _should_ modify the PACKAGE_BUGREPORT definition
 
-VERSION=			$(shell ./utils/version-gen.sh)
+VERSION:=			$(shell ./utils/version-gen.sh)
 LIB_MAJ=			0.0.1
 LIB_MIN=			0
 
-- 
2.20.1

