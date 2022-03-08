Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A2AB4D22AD
	for <lists+linux-pm@lfdr.de>; Tue,  8 Mar 2022 21:34:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236834AbiCHUeq (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 8 Mar 2022 15:34:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350250AbiCHUep (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 8 Mar 2022 15:34:45 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA1333B561
        for <linux-pm@vger.kernel.org>; Tue,  8 Mar 2022 12:33:47 -0800 (PST)
Date:   Tue, 08 Mar 2022 20:33:42 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1646771625;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=5JUpBq+Xb3DFveqleXsNbrL/bV3/R3LbHDXBw/nAD3g=;
        b=xobGs1auk8oGfn3dcYn8ZurdEHyu5NZVpQJW5rGsTV7RIk6xqtIBXYanLRRweLd52LU+WN
        K3xAtfdhTpo6hOcDOQnR6QzQaXluz12sfDoJFXg1AK69sGXl+rNtUzMSdorTLpjKZHDh+c
        CrOPj8cibeJrfmD5r9izubEzVVhduSz9p4VoogI+WGhtc3f0ujlY23r757C9uwlR+b2dFM
        1pLOXrsLiICAZXVYdxElglEy5ahSlyqeSaGmfyqHrOLijoGVfLuF11gIGxwInyaQCW4iFk
        LugSf6rZP4Uy7WnHs2VhVCxqZoX6aYijbjh6QZHBkZox8YM07SeyvEruJtkupg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1646771625;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=5JUpBq+Xb3DFveqleXsNbrL/bV3/R3LbHDXBw/nAD3g=;
        b=B2Cjgi4jeQWhSKmrf3qZJUtD9ungvf2zwxKROJ5yuvGOvZg+dzwECvQB2FOqJhPCAYlnqh
        Q79ulHwDTEeL6iAw==
From:   "thermal-bot for Krzysztof Kozlowski" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-pm@vger.kernel.org
To:     linux-pm@vger.kernel.org
Subject: [thermal: thermal/next] MAINTAINERS: thermal: samsung: update
 Krzysztof Kozlowski's email
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        rui.zhang@intel.com, amitk@kernel.org
In-Reply-To: <20220308065648.6443-1-krzysztof.kozlowski@canonical.com>
References: <20220308065648.6443-1-krzysztof.kozlowski@canonical.com>
MIME-Version: 1.0
Message-ID: <164677162292.16921.7081685533348472454.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The following commit has been merged into the thermal/next branch of thermal:

Commit-ID:     a7da8a0955cbe81433afecad229d2a2ba60c3f0a
Gitweb:        https://git.kernel.org/pub/scm/linux/kernel/git/thermal/linux.git//a7da8a0955cbe81433afecad229d2a2ba60c3f0a
Author:        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
AuthorDate:    Tue, 08 Mar 2022 07:56:48 +01:00
Committer:     Daniel Lezcano <daniel.lezcano@linaro.org>
CommitterDate: Tue, 08 Mar 2022 21:26:09 +01:00

MAINTAINERS: thermal: samsung: update Krzysztof Kozlowski's email

Use Krzysztof Kozlowski's @kernel.org account in dt-bindings maintainer
entry.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Link: https://lore.kernel.org/r/20220308065648.6443-1-krzysztof.kozlowski@canonical.com
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 MAINTAINERS | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 82fe389..e82b6aa 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -17136,7 +17136,7 @@ F:	drivers/net/ethernet/samsung/sxgbe/
 
 SAMSUNG THERMAL DRIVER
 M:	Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
-M:	Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
+M:	Krzysztof Kozlowski <krzk@kernel.org>
 L:	linux-pm@vger.kernel.org
 L:	linux-samsung-soc@vger.kernel.org
 S:	Maintained
