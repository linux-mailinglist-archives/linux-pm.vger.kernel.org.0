Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5240B3DB4BA
	for <lists+linux-pm@lfdr.de>; Fri, 30 Jul 2021 09:54:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237864AbhG3HyO (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 30 Jul 2021 03:54:14 -0400
Received: from smtp-relay-canonical-0.canonical.com ([185.125.188.120]:43472
        "EHLO smtp-relay-canonical-0.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S237851AbhG3HyO (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 30 Jul 2021 03:54:14 -0400
Received: from localhost (1.general.cking.uk.vpn [10.172.193.212])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-canonical-0.canonical.com (Postfix) with ESMTPSA id CE3513F0FD;
        Fri, 30 Jul 2021 07:54:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1627631648;
        bh=G8dnFS/VJuY2eMdGcNAfSAELq2LIUnvG4Ahde4qXVcY=;
        h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type;
        b=nJNgyqQu1SjV/CA5seVDj4v87xbVHXsiUVbuIwuCVYPa9BzFYGQ37diHdLMkwSpgb
         +p1NrW/93SCZuSxlPyFP2qfhAmer2XXDYZbaLlfHS1aBNe3x5IYXk0yg1dLtaNT93V
         kSq9lUSOH9L6ywR/WFK+30wGwKsdA7FZCtgxFLLn2njmn0mtniVN2tKMuBVZQ61hjs
         if4wqcM5xZ/CCxtaVCF16rRD6T7o5rvWZvGTPQ3MDTDTkchWoLLl82CLcVhrDmutpq
         c6Oy57Foemkch1zfgIu+5IFBfQcPczr/5ueqzsdo480N4VSuhVxWD9CeXzOyKDLBZe
         +ygAPdj5d7dfQ==
From:   Colin King <colin.king@canonical.com>
To:     Georgi Djakov <djakov@kernel.org>,
        Akash Asthana <akashast@codeaurora.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        linux-pm@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] interconnect: Fix undersized devress_alloc allocation
Date:   Fri, 30 Jul 2021 08:54:08 +0100
Message-Id: <20210730075408.19945-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

The expression sizeof(**ptr) for the void **ptr is just 1 rather than
the size of a pointer. Fix this by using sizeof(*ptr).

Addresses-Coverity: ("Wrong sizeof argument")
Fixes: e145d9a184f2 ("interconnect: Add devm_of_icc_get() as exported API for users")
Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 drivers/interconnect/core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/interconnect/core.c b/drivers/interconnect/core.c
index 55aa8d108c6d..9050ca1f4285 100644
--- a/drivers/interconnect/core.c
+++ b/drivers/interconnect/core.c
@@ -403,7 +403,7 @@ struct icc_path *devm_of_icc_get(struct device *dev, const char *name)
 {
 	struct icc_path **ptr, *path;
 
-	ptr = devres_alloc(devm_icc_release, sizeof(**ptr), GFP_KERNEL);
+	ptr = devres_alloc(devm_icc_release, sizeof(*ptr), GFP_KERNEL);
 	if (!ptr)
 		return ERR_PTR(-ENOMEM);
 
-- 
2.31.1

