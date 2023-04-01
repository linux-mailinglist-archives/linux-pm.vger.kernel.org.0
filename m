Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 72C516D303C
	for <lists+linux-pm@lfdr.de>; Sat,  1 Apr 2023 13:35:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229708AbjDALf1 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sat, 1 Apr 2023 07:35:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229682AbjDALfY (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sat, 1 Apr 2023 07:35:24 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38D1BB765
        for <linux-pm@vger.kernel.org>; Sat,  1 Apr 2023 04:34:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1680348877;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=J5VnVhbHSvcA014php78QLEnB2oArEoTP1K4/6SYEVc=;
        b=Dxre8NhMB+pJpgDxDYmvmJP5JD3Wu2mQzNLQ3SAHQh9MEbvA6m7hggrDoshVbanc0RRUHR
        YpHLyNIPZbgSVhIvJcKc5EaJDHKZv10lDPV3nLAH2JLTqR5gg+wlVJoGVOCMeX9pzK5JEu
        4htx79uT6/nWn5MXfJLs0b+qqEXVRho=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-640-JZmOpaX4Mg6xdiGaVEQtEw-1; Sat, 01 Apr 2023 07:34:36 -0400
X-MC-Unique: JZmOpaX4Mg6xdiGaVEQtEw-1
Received: by mail-qv1-f71.google.com with SMTP id r4-20020ad44044000000b005ad0ce58902so10916864qvp.5
        for <linux-pm@vger.kernel.org>; Sat, 01 Apr 2023 04:34:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680348876;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=J5VnVhbHSvcA014php78QLEnB2oArEoTP1K4/6SYEVc=;
        b=ppaF5cYNpd7Ei1lUkWnv3YheamgviUYu/DweZyu8yK0dMOyyUKCA8tAd8S/nd2IClk
         cTnV9CUHtwX5E1RTlshVeyrnr52MmW+LxzPBptb1iYgrTLx4ZhWXONZ8gg7895mmmsFf
         MgXXBsuBNNmCG37NW0YKAYxCBl8BW44Vt9SJa8G2mMFd5KVjOSJfuJHewhwcqcMVSIlU
         oSz+UTNs0x6t54qqGFyqOKlGwHCRP4+kX83NtuTgNrn8FFsDNySVkpCV1cCsIO3LdVnd
         qL6ljmX5q1WcMREF6G23xvwzWU4yCr3UXNA8ldwVcfDVIJyjaTBxNBOAz+gNmKXz+rLq
         c1Zg==
X-Gm-Message-State: AAQBX9fTiuhQSPulxiRFG8l+Jl0CufjqHVIX3oX72BqWKnfxRNn1uau9
        2F7EhqCUQk409SAuVdWM7Zc9KUCxtwjX4b5sAqyQnE+zxLOheQhUi8Z8w2lYlBjY0DX7tjoWj0q
        BfTbRF9WOiKbX4wX9b9c=
X-Received: by 2002:a05:6214:501e:b0:584:8c13:3041 with SMTP id jo30-20020a056214501e00b005848c133041mr18549532qvb.24.1680348875816;
        Sat, 01 Apr 2023 04:34:35 -0700 (PDT)
X-Google-Smtp-Source: AKy350ZH/PIz9aT1vkMeJPCy77zunA2Q4o1S573i0+gKG+HwMtgD6hdQufuIhPWM0rPxuQRAce5LcQ==
X-Received: by 2002:a05:6214:501e:b0:584:8c13:3041 with SMTP id jo30-20020a056214501e00b005848c133041mr18549509qvb.24.1680348875582;
        Sat, 01 Apr 2023 04:34:35 -0700 (PDT)
Received: from dell-per740-01.7a2m.lab.eng.bos.redhat.com (nat-pool-bos-t.redhat.com. [66.187.233.206])
        by smtp.gmail.com with ESMTPSA id s11-20020ad4524b000000b005dd8b9345d8sm1230100qvq.112.2023.04.01.04.34.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 01 Apr 2023 04:34:35 -0700 (PDT)
From:   Tom Rix <trix@redhat.com>
To:     sre@kernel.org, nathan@kernel.org, ndesaulniers@google.com
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev, Tom Rix <trix@redhat.com>
Subject: [PATCH] power: supply: twl4030-charger: remove unused cur_reg variable
Date:   Sat,  1 Apr 2023 07:34:32 -0400
Message-Id: <20230401113432.1873847-1-trix@redhat.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

clang with W=1 reports
drivers/power/supply/twl4030_charger.c:242:16: error: variable
  'cur_reg' set but not used [-Werror,-Wunused-but-set-variable]
        unsigned reg, cur_reg;
                      ^
This variable is not used so remove it.

Signed-off-by: Tom Rix <trix@redhat.com>
---
 drivers/power/supply/twl4030_charger.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/power/supply/twl4030_charger.c b/drivers/power/supply/twl4030_charger.c
index 7adfd69fe649..5fa5b2311330 100644
--- a/drivers/power/supply/twl4030_charger.c
+++ b/drivers/power/supply/twl4030_charger.c
@@ -239,7 +239,7 @@ static int twl4030_charger_update_current(struct twl4030_bci *bci)
 {
 	int status;
 	int cur;
-	unsigned reg, cur_reg;
+	unsigned reg;
 	u8 bcictl1, oldreg, fullreg;
 	bool cgain = false;
 	u8 boot_bci;
@@ -357,11 +357,9 @@ static int twl4030_charger_update_current(struct twl4030_bci *bci)
 	status = twl4030_bci_read(TWL4030_BCIIREF1, &oldreg);
 	if (status < 0)
 		return status;
-	cur_reg = oldreg;
 	status = twl4030_bci_read(TWL4030_BCIIREF2, &oldreg);
 	if (status < 0)
 		return status;
-	cur_reg |= oldreg << 8;
 	if (reg != oldreg) {
 		/* disable write protection for one write access for
 		 * BCIIREF */
-- 
2.27.0

