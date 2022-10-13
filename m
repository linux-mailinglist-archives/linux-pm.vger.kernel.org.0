Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 842295FE467
	for <lists+linux-pm@lfdr.de>; Thu, 13 Oct 2022 23:49:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229967AbiJMVtd (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 13 Oct 2022 17:49:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229845AbiJMVtN (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 13 Oct 2022 17:49:13 -0400
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12CE336BC5
        for <linux-pm@vger.kernel.org>; Thu, 13 Oct 2022 14:49:05 -0700 (PDT)
Received: by mail-pj1-x1033.google.com with SMTP id t12-20020a17090a3b4c00b0020b04251529so3043071pjf.5
        for <linux-pm@vger.kernel.org>; Thu, 13 Oct 2022 14:49:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20210112.gappssmtp.com; s=20210112;
        h=to:from:cc:content-transfer-encoding:mime-version:message-id:date
         :subject:from:to:cc:subject:date:message-id:reply-to;
        bh=i3K43ojbMq8isMbqFxDt+PzOi1qTNmeGQ4/NX2/+N0s=;
        b=m4GpdrZWyUxvcdlQIiSLdarZ/8f06jvKA5NbPKwsGtQy8/PzXJLAdpV0Iqq8ic3i/+
         ALBxWhsGIv7/agd3mSgUwanDeWl+OwHsWOOmyV6ujoSPkONdtO9HicQ9mAiH0Bsjspow
         s90v2642xpaknJej8cUEg8abEalRdK4fRxcA0fyeiqu/7Tp7Uk+C7uAtbm47WyTkGr87
         YaBZAY0uBXSUTLc1BcQoW/RxlmQ48lOEkHlculPPDMH8mbstu/Z5q6gO1LQ5mioaKxOJ
         51ehanKyth51rAduNNDu6GYTh1hIpyWJaFt/XCybvEnWgLgEQRiNqJ0G+YCA8CsmCeb3
         uf0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:cc:content-transfer-encoding:mime-version:message-id:date
         :subject:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=i3K43ojbMq8isMbqFxDt+PzOi1qTNmeGQ4/NX2/+N0s=;
        b=vQ7IL4X/ZzbJ88Voj6C2dbTvK4rloHURHZO+/T7CHgFEIP9g7SNzw0AvJ0J2yaBxHn
         DQ6hK2QMnpGutIIepdRN+Ai7QQcnY+Dgsrxfr1KyOGoymMVj7ZwdwZYiD+bLH/aIJTtH
         e0U63j8fovRNnWNo/Lg8TfO6hV7CbZDFaINspXXgZ/XZiXzrAZiBwP9uxIs33eDg936Z
         VfyiPZcHS63Rywez+DCJ3QQL1bIveuxCjj6VCa0OXHU14DbjmtjALoHdbI9J1Nfqp7Yv
         mOs+pCgzF/5VWxWeacAf1sbexNXtI5BXzD/nQ09wXANgoyTkjnNeKoW1kGwD/1gMOj8X
         Xt3g==
X-Gm-Message-State: ACrzQf1qKy/hB9HGHY1vRWhOvqCdp/FNIoHsXroajfM/DzhuTVLHS4e4
        qW1KgdCzVaj+aMiYmR+SNhseuA==
X-Google-Smtp-Source: AMsMyM733KNeybflC+If1obbzWxANjLNj7Zgxv/5gM6kA2Oko04lczn0Q0lcUQrsWOwUH9yVmaymeQ==
X-Received: by 2002:a17:903:240d:b0:183:9bab:9c3 with SMTP id e13-20020a170903240d00b001839bab09c3mr1849051plo.48.1665697745345;
        Thu, 13 Oct 2022 14:49:05 -0700 (PDT)
Received: from localhost ([50.221.140.188])
        by smtp.gmail.com with ESMTPSA id m9-20020a170902db0900b00182d25a1e4bsm285318plx.259.2022.10.13.14.49.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Oct 2022 14:49:04 -0700 (PDT)
Subject: [PATCH] MAINTAINERS: git://github -> https://github.com for intel
Date:   Thu, 13 Oct 2022 14:46:37 -0700
Message-Id: <20221013214637.30873-1-palmer@rivosinc.com>
X-Mailer: git-send-email 2.38.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc:        linux-kernel@vger.kernel.org,
           Palmer Dabbelt <palmer@rivosinc.com>,
           Conor Dooley <conor.dooley@microchip.com>
From:   Palmer Dabbelt <palmer@rivosinc.com>
To:     todd.e.brandt@linux.intel.com, linux-pm@vger.kernel.org
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Github deprecated the git:// links about a year ago, so let's move to
the https:// URLs instead.

Reported-by: Conor Dooley <conor.dooley@microchip.com>
Link: https://github.blog/2021-09-01-improving-git-protocol-security-github/
Signed-off-by: Palmer Dabbelt <palmer@rivosinc.com>
---
I've split these up by github username so folks can take them
independently, as some of these repos have been renamed at github and
thus need more than just a sed to fix them.
---
 MAINTAINERS | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 9a9ca93b63fd..7b5e1953b718 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -16211,7 +16211,7 @@ L:	linux-pm@vger.kernel.org
 S:	Supported
 W:	https://01.org/pm-graph
 B:	https://bugzilla.kernel.org/buglist.cgi?component=pm-graph&product=Tools
-T:	git git://github.com/intel/pm-graph
+T:	git https://github.com/intel/pm-graph
 F:	tools/power/pm-graph
 
 PMBUS HARDWARE MONITORING DRIVERS
-- 
2.38.0

