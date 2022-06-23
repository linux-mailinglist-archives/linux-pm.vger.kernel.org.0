Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A687557DEE
	for <lists+linux-pm@lfdr.de>; Thu, 23 Jun 2022 16:34:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231446AbiFWOeE (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 23 Jun 2022 10:34:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229768AbiFWOeD (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 23 Jun 2022 10:34:03 -0400
Received: from mail-lj1-x229.google.com (mail-lj1-x229.google.com [IPv6:2a00:1450:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30F7F2494A
        for <linux-pm@vger.kernel.org>; Thu, 23 Jun 2022 07:34:02 -0700 (PDT)
Received: by mail-lj1-x229.google.com with SMTP id bn8so6209433ljb.2
        for <linux-pm@vger.kernel.org>; Thu, 23 Jun 2022 07:34:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=TTAzAj2aV5FghOX4usMcTo/mCNiCEsFYCJDjUhMP904=;
        b=Dx17jFgFMsavR4uFGagMNHBB6GKuixHyGCCyCIEkxfZVXtTy2TvleTG7Z1G9/l8MQ8
         zzox1/aBTXEsR0j4/jCPDKkp6MC+Ud6JOzItr179q/J7dGgevkEqQAiIRVnoF8nPgtj7
         EC2Ey0TRQfCfEXPSgQnruwJlYPqez94nM4ZpYi88ejsG8eM0cXyOGwXNsx/HxWdn6enJ
         dlIyxrcle9hY00KcrkOVYZ0rkU9bkfplbyXkCUbp3BZDtycBO1sU6eITDaLah78cDjY1
         /Nm6wgnXa+DQ/GXnXJjAdxNTBcRNlvyDovMczSvgO800EU7wrNLMThgm2vJQ7nC6Prsf
         XfYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=TTAzAj2aV5FghOX4usMcTo/mCNiCEsFYCJDjUhMP904=;
        b=49xtdc833VvVe7RIN7zXFpBrY0AQ3AYiK5NBQS9Jchbefn6LoqbuozfCpGPBZhYfo9
         ZWJxv8T1CUAVf9PdPFaFM/G2jSVZM5vY5jnCpqcpzd1a/6R8a/67l4YVH3RpJkyRedcm
         QG/w04hbehNNMLczJX3CXrkIKtKaqvcN5slXFh55mOKK4Xkcx9PfDsU1poNISv3/zVUu
         2a9TU+sdb03eeSr4swNeydxVT8u5X6KjFAdgxwKcmvyErwjRvbtavsdnhNq1HTMrD7SK
         ePe4+IomzMXA6HaNHORhpJOiRsxwky6HakHOlfOhM4Go+O4rdEn8ZShFewUAFhlsNj0Q
         ohgw==
X-Gm-Message-State: AJIora/4Tea7y2Ya94JGxNZUyOdXaG9duTs1ufPp/2AVuHgHI8r/JIWT
        +gCx3VjTsPnojWIACOht7ZWemg==
X-Google-Smtp-Source: AGRyM1sj7N6sZex/ygzvJTeE0H9xSM6fd/didRjMyt71FzsuZvS+BbCgBkR+2xI7HbfqTLyL+1MkBw==
X-Received: by 2002:a2e:a587:0:b0:25a:97d8:57ff with SMTP id m7-20020a2ea587000000b0025a97d857ffmr1030481ljp.69.1655994840523;
        Thu, 23 Jun 2022 07:34:00 -0700 (PDT)
Received: from localhost.localdomain (c-fdcc225c.014-348-6c756e10.bbcust.telenor.se. [92.34.204.253])
        by smtp.gmail.com with ESMTPSA id z7-20020a196507000000b0047255d211e2sm3017986lfb.273.2022.06.23.07.33.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Jun 2022 07:34:00 -0700 (PDT)
From:   Linus Walleij <linus.walleij@linaro.org>
To:     Sebastian Reichel <sre@kernel.org>,
        Marcus Cooper <codekipper@gmail.com>
Cc:     linux-pm@vger.kernel.org, Linus Walleij <linus.walleij@linaro.org>
Subject: [PATCH] power: supply: ab8500: Add MAINTAINERS entry
Date:   Thu, 23 Jun 2022 16:31:57 +0200
Message-Id: <20220623143157.1842024-1-linus.walleij@linaro.org>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

I am maintaining these drivers so add patterns to MAINTAINERS
for them.

Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 MAINTAINERS | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index a6d3bd9d2a8d..ffafa78732c5 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -260,6 +260,11 @@ W:	http://www.adaptec.com/
 F:	Documentation/scsi/aacraid.rst
 F:	drivers/scsi/aacraid/
 
+AB8500 BATTERY AND CHARGER DRIVERS
+M:	Linus Walleij <linus.walleij@linaro.org>
+F:	Documentation/devicetree/bindings/power/supply/*ab8500*
+F:	drivers/power/supply/*ab8500*
+
 ABI/API
 L:	linux-api@vger.kernel.org
 F:	include/linux/syscalls.h
-- 
2.36.1

