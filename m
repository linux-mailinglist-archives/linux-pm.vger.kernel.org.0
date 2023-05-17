Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B1D41707191
	for <lists+linux-pm@lfdr.de>; Wed, 17 May 2023 21:11:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229574AbjEQTK7 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 17 May 2023 15:10:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229894AbjEQTK6 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 17 May 2023 15:10:58 -0400
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82C746A5E
        for <linux-pm@vger.kernel.org>; Wed, 17 May 2023 12:10:46 -0700 (PDT)
Received: by mail-ed1-x52f.google.com with SMTP id 4fb4d7f45d1cf-50c8d87c775so1713434a12.3
        for <linux-pm@vger.kernel.org>; Wed, 17 May 2023 12:10:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684350645; x=1686942645;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=exkz4WEX/EMrMSRxhL/HARW3Kg6zds+887Xkx40PuQc=;
        b=pZANGuF9uY0DC8FbPnFceToiTydnjbxjV8Gy5dsKOJBKywchTOrNauycsOJ2kBhHas
         IxgHc4m24iopRv+9g0L9UFBidSRmWW3bWdpDnDkdbnHZAUiRVEcTbq2lnmZFyojmr/u9
         TXDmb60iRFYwUayi6cDN+8Zco+S+jS2euTyEsTTRw/XIkBYFmiZjaXQMLPBUUpi7kp/S
         B5hYFoqL59oTX5oB5uoHFNjha9VAfmbjr7ANEwZ+fwXrLluUC2LbNMm/8Dn4bMFMiIEd
         cRUnQ1fxQl53r6g5WHj+dT3fN+/10LVM54iC+IicmPQZpVYRjKX3x2s7vif7tZf1WGQR
         jdkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684350645; x=1686942645;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=exkz4WEX/EMrMSRxhL/HARW3Kg6zds+887Xkx40PuQc=;
        b=dLrjEoNK1IqCqNnd+v8JJYPd1yEN/wHiCKRhYSWRMKruNqDlhRPkBbYndgjR+U3Rfb
         F+1FbvTpObC9cGkMVitflca9xj8XYv89F7haE6Vk5wWrG7oXfKsdFrNzeWEGcUEzkY5b
         ForYLTiLO8N1T2fsaoSecTs+BFXGCV5/+roWbo4tDl77RI7+zK0mfZqRkQF9A4y0B10H
         lArAffAdk+BgbqIacln9sPgSRv0+mk0k1MvhSl/p0NznByzaKwRQDeYayq7TixdkpXkh
         ItViNAllBGeCS2WbUKVaRHTQlhSN1aKum28AP/ZT0x9Ur6gOocST6lRRBwT3XMaYBBCA
         i4GA==
X-Gm-Message-State: AC+VfDykgDmfcgbY5AVbbKfGOd/YDd97/15v/lda5yH/vrWjrIEiIvXv
        q6By55/7CoqnkAfcxH/JUFI=
X-Google-Smtp-Source: ACHHUZ4qF9o9vNdeLBB6ODqhyEXodPRkH5GhlZmkChc7E+oSdXS5nOrl9ToMzO7iVOSYTK1QHRKZsQ==
X-Received: by 2002:a17:907:7d91:b0:969:e304:7a1d with SMTP id oz17-20020a1709077d9100b00969e3047a1dmr29722423ejc.50.1684350644702;
        Wed, 17 May 2023 12:10:44 -0700 (PDT)
Received: from eldamar.lan (c-82-192-242-114.customer.ggaweb.ch. [82.192.242.114])
        by smtp.gmail.com with ESMTPSA id c69-20020a509fcb000000b00510d110db58sm908397edf.80.2023.05.17.12.10.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 May 2023 12:10:43 -0700 (PDT)
Sender: Salvatore Bonaccorso <salvatore.bonaccorso@gmail.com>
Received: by eldamar.lan (Postfix, from userid 1000)
        id 6E457BE2DE0; Wed, 17 May 2023 21:10:42 +0200 (CEST)
From:   Salvatore Bonaccorso <carnil@debian.org>
To:     Shuah Khan <skhan@linuxfoundation.org>,
        Thomas Renninger <trenn@suse.com>
Cc:     linux-pm@vger.kernel.org, Ben Hutchings <ben@decadent.org.uk>,
        Shuah Khan <shuah@kernel.org>,
        Salvatore Bonaccorso <carnil@debian.org>
Subject: [PATCH RESEND] cpupower: Bump soname version
Date:   Wed, 17 May 2023 21:10:20 +0200
Message-Id: <20230517191019.643031-1-carnil@debian.org>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

From: Ben Hutchings <ben@decadent.org.uk>

Several functions in the libcpupower API are renamed or removed in
Linux 4.7.  This is an backward-incompatible ABI change, so the
library soname should change from libcpupower.so.0 to
libcpupower.so.1.

Fixes: ac5a181d065d ("cpupower: Add cpuidle parts into library")
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
Signed-off-by: Salvatore Bonaccorso <carnil@debian.org>
---
 tools/power/cpupower/Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/power/cpupower/Makefile b/tools/power/cpupower/Makefile
index 59bfa05dec5d..dc531805a570 100644
--- a/tools/power/cpupower/Makefile
+++ b/tools/power/cpupower/Makefile
@@ -53,7 +53,7 @@ DESTDIR ?=
 
 VERSION:=			$(shell ./utils/version-gen.sh)
 LIB_MAJ=			0.0.1
-LIB_MIN=			0
+LIB_MIN=			1
 
 PACKAGE =			cpupower
 PACKAGE_BUGREPORT =		linux-pm@vger.kernel.org
-- 
2.40.1

