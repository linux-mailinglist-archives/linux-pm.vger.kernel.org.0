Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E8E17560A32
	for <lists+linux-pm@lfdr.de>; Wed, 29 Jun 2022 21:20:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229786AbiF2TUy (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 29 Jun 2022 15:20:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229780AbiF2TUx (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 29 Jun 2022 15:20:53 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id E8E322FFE7
        for <linux-pm@vger.kernel.org>; Wed, 29 Jun 2022 12:20:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1656530449;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=tFVPrpGIRVp0BLeI5a57lLi4ssxUxyA/yiqhXka4Vkw=;
        b=AU+w6iKf/BqViXJ7ajCMFlFHaVNYD1997hTFHIL0gsq/pPZ96hVAf13V9GgR6srVoBV4Fo
        JI4HsTaJY7B3DeIU/B+EPZWRd7uoHjmeUYkCPaU0HPL7CbM+CEZ7iBeIZei5tDECIfPZkV
        laakHI4ZsRgRo6nzTBS3dDcN7kkNWpE=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-640-8ukWQ1OsPV2FI_lw_qI1Eg-1; Wed, 29 Jun 2022 15:20:48 -0400
X-MC-Unique: 8ukWQ1OsPV2FI_lw_qI1Eg-1
Received: by mail-qv1-f72.google.com with SMTP id f6-20020a0cbec6000000b004728234508bso6704397qvj.8
        for <linux-pm@vger.kernel.org>; Wed, 29 Jun 2022 12:20:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=tFVPrpGIRVp0BLeI5a57lLi4ssxUxyA/yiqhXka4Vkw=;
        b=XGPuZDNafhB6kBKg5aymekPfn5mRGkV4/ApSRpNRDj9RZ+mdgLoGxzo0eRetkboUPc
         60nfONSwtl3t/aLEYtT6uPx/gI7TJpKpFkrcXHgp1ZQ+SN73byC0A6aGXzuZG3grQ2T0
         pqKJOyNxMiwR8nSlc6zHYrpk2oPFesjA9YYI3J4nopUqKfZ4JNiIpY+GSAfNiMvogil/
         WHxTCiOl5EHmNEZmlNokJ8K4zqoHKeUOf6AQ130y7CJoHSN4+4Rhn/kWV/9NiZ4GfIpc
         enDClNRr8u+H19qiZjHyqWTWar03cg3rCmL0r+3E0zFlA0aXWN2UT8I//NYjg1Q1kRIp
         iPIQ==
X-Gm-Message-State: AJIora8nq6wwVB7dUexzNMeMO6FyGrm9k3vFLG+HyJBpVD9x+Eddn03Q
        KYR76Wt1JOaxuCUGIcMrtR2/qv6mq68UaNJvO1+H65aS1a56mPqu+ltZyDsGfNTmLQ9QL6dkl+9
        Mu6itSyIoRX0kYapTAXc=
X-Received: by 2002:a05:6214:2506:b0:470:2c9c:65fa with SMTP id gf6-20020a056214250600b004702c9c65famr9081617qvb.117.1656530448110;
        Wed, 29 Jun 2022 12:20:48 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1u7udpbNcAAWo11I4FvtiEedeJXmYlurqXYJJkBdgJwBA1JJcxCuhkzAYOxK490sBhH4dUtfg==
X-Received: by 2002:a05:6214:2506:b0:470:2c9c:65fa with SMTP id gf6-20020a056214250600b004702c9c65famr9081595qvb.117.1656530447839;
        Wed, 29 Jun 2022 12:20:47 -0700 (PDT)
Received: from dell-per740-01.7a2m.lab.eng.bos.redhat.com (nat-pool-bos-t.redhat.com. [66.187.233.206])
        by smtp.gmail.com with ESMTPSA id r4-20020ac84244000000b00317ca023e33sm10799903qtm.80.2022.06.29.12.20.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Jun 2022 12:20:47 -0700 (PDT)
From:   Tom Rix <trix@redhat.com>
To:     sre@kernel.org, asmaa@nvidia.com
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Tom Rix <trix@redhat.com>
Subject: [PATCH] power: reset: pwr-mlxbf: change rst_pwr_hid and low_pwr_hid from global to local variables
Date:   Wed, 29 Jun 2022 15:20:45 -0400
Message-Id: <20220629192045.4107237-1-trix@redhat.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

sparse reports
drivers/power/reset/pwr-mlxbf.c:19:12: warning: symbol 'rst_pwr_hid' was not declared. Should it be static?
drivers/power/reset/pwr-mlxbf.c:20:12: warning: symbol 'low_pwr_hid' was not declared. Should it be static?

Both rst_pwr_hid and low_pwr_hid are only used in a single function
so they should be local variables.

Fixes: a4c0094fcf76 ("power: reset: pwr-mlxbf: add BlueField SoC power control driver")
Signed-off-by: Tom Rix <trix@redhat.com>
---
 drivers/power/reset/pwr-mlxbf.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/power/reset/pwr-mlxbf.c b/drivers/power/reset/pwr-mlxbf.c
index 1c4904c0e1f5..12dedf841a44 100644
--- a/drivers/power/reset/pwr-mlxbf.c
+++ b/drivers/power/reset/pwr-mlxbf.c
@@ -16,9 +16,6 @@
 #include <linux/reboot.h>
 #include <linux/types.h>
 
-const char *rst_pwr_hid = "MLNXBF24";
-const char *low_pwr_hid = "MLNXBF29";
-
 struct pwr_mlxbf {
 	struct work_struct send_work;
 	const char *hid;
@@ -31,6 +28,8 @@ static void pwr_mlxbf_send_work(struct work_struct *work)
 
 static irqreturn_t pwr_mlxbf_irq(int irq, void *ptr)
 {
+	const char *rst_pwr_hid = "MLNXBF24";
+	const char *low_pwr_hid = "MLNXBF29";
 	struct pwr_mlxbf *priv = ptr;
 
 	if (!strncmp(priv->hid, rst_pwr_hid, 8))
-- 
2.27.0

