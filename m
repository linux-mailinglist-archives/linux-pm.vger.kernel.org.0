Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C1035790D5
	for <lists+linux-pm@lfdr.de>; Tue, 19 Jul 2022 04:27:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236713AbiGSC1y (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 18 Jul 2022 22:27:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236695AbiGSC1y (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 18 Jul 2022 22:27:54 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 653B83B96F
        for <linux-pm@vger.kernel.org>; Mon, 18 Jul 2022 19:27:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1658197672;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=1KL4MutqoRxmcuscCUXm8t63mCy8nNQ4Lfka4AKoNx0=;
        b=DBoDOR9/wOsIYvY1xaLj47v3eD1xJ0CatW39udGtBDvw7uPk4mnQirVchUelDoc85RLyKA
        ePg6YSiyZmpUGFTSgA8Mk20wGAJsoDYcW5CUxr9XgXR66ResL2dIPgBqvqePIiu4rNO5iA
        iIDMY5U0VGsT5ckaoffWgmUyqVHwpJg=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-163-nbHL9cgZMrOFccEAyPkjiw-1; Mon, 18 Jul 2022 22:27:50 -0400
X-MC-Unique: nbHL9cgZMrOFccEAyPkjiw-1
Received: by mail-qk1-f199.google.com with SMTP id n15-20020a05620a294f00b006b5768a0ed0so10643713qkp.7
        for <linux-pm@vger.kernel.org>; Mon, 18 Jul 2022 19:27:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=1KL4MutqoRxmcuscCUXm8t63mCy8nNQ4Lfka4AKoNx0=;
        b=jMqjvbAHhtCRLVX2RZZ5PX9Ocn7KOJigEzNIO3KHr0ozXrnywHRrfGNFZbQ63C7r+o
         7E/Qvus9DF9eYFaHD8AdgseOEKasTZ7r15l1MU30f2pTVSz2Q2EB89QB8Ivy/Hwd6dCh
         AXgo3L883mXZWU2bVSkIjaUD7YenTib3yr/cZcYrFbLKP2J3GRlmmEEgsvua/s8Il5/b
         1FdvwHx73sS+F9gdJf+5T7swPDFc68o6s8na/SohDOB9F+Hs8JnulYclGX/HRo2PQK4H
         kBbnsfVnqyVeNySGGSf75RZzCHc1iBfykNMm0u/RWAZMryHTMlJQutKafednlnipsiL/
         YnBA==
X-Gm-Message-State: AJIora9k3foFoKapaeBNO/ED5jbUCGFgC3JoefMPfJOuhlSWLP9K0ISJ
        ViCCyu0E2OZhUpNTuRoSxoKKED4PXs1mUVR2P+j6q/AdGhaEm7mQIxMkrDNLbchZVIx+f3bs0b/
        SdtNojEFYtVzLj+cFcpY=
X-Received: by 2002:a05:620a:1709:b0:6b5:ea99:472 with SMTP id az9-20020a05620a170900b006b5ea990472mr5057297qkb.486.1658197670161;
        Mon, 18 Jul 2022 19:27:50 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1ty8pdYwfjbYzRjWEOQJipds9y50FEPqRin97qcIsTsIGvs6byCrwYyZCr+0bFlBiC/FlTvCg==
X-Received: by 2002:a05:620a:1709:b0:6b5:ea99:472 with SMTP id az9-20020a05620a170900b006b5ea990472mr5057291qkb.486.1658197669972;
        Mon, 18 Jul 2022 19:27:49 -0700 (PDT)
Received: from dell-per740-01.7a2m.lab.eng.bos.redhat.com (nat-pool-bos-t.redhat.com. [66.187.233.206])
        by smtp.gmail.com with ESMTPSA id g14-20020a05620a40ce00b006af3bc9c6bbsm14304615qko.52.2022.07.18.19.27.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Jul 2022 19:27:49 -0700 (PDT)
From:   Tom Rix <trix@redhat.com>
To:     linus.walleij@linaro.org, sre@kernel.org
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Tom Rix <trix@redhat.com>
Subject: [PATCH] power: supply: ab8500: remove unused static local variable
Date:   Mon, 18 Jul 2022 22:27:43 -0400
Message-Id: <20220719022743.305189-1-trix@redhat.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

cpp_check reports
[drivers/power/supply/ab8500_chargalg.c:493]: (style) Variable 'ab8500_chargalg_ex_ac_enable_toggle' is assigned a value that is never used.

From inspection, this variable is never used. So remove it.

Fixes: 6c50a08d9dd3 ("power: supply: ab8500: Drop external charger leftovers")
Signed-off-by: Tom Rix <trix@redhat.com>
---
 drivers/power/supply/ab8500_chargalg.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/power/supply/ab8500_chargalg.c b/drivers/power/supply/ab8500_chargalg.c
index ae4be553f424..05146d436a6a 100644
--- a/drivers/power/supply/ab8500_chargalg.c
+++ b/drivers/power/supply/ab8500_chargalg.c
@@ -490,8 +490,6 @@ static int ab8500_chargalg_kick_watchdog(struct ab8500_chargalg *di)
 static int ab8500_chargalg_ac_en(struct ab8500_chargalg *di, int enable,
 	int vset_uv, int iset_ua)
 {
-	static int ab8500_chargalg_ex_ac_enable_toggle;
-
 	if (!di->ac_chg || !di->ac_chg->ops.enable)
 		return -ENXIO;
 
-- 
2.27.0

