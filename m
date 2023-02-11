Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BDFD6692F52
	for <lists+linux-pm@lfdr.de>; Sat, 11 Feb 2023 09:19:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229523AbjBKITs (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sat, 11 Feb 2023 03:19:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229455AbjBKITs (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sat, 11 Feb 2023 03:19:48 -0500
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68359311E0
        for <linux-pm@vger.kernel.org>; Sat, 11 Feb 2023 00:19:46 -0800 (PST)
Received: by mail-wr1-x429.google.com with SMTP id by3so6057261wrb.10
        for <linux-pm@vger.kernel.org>; Sat, 11 Feb 2023 00:19:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=mR4IwAvH2FxX7OwBcmYLz+RC12aKLqPbgGS8lJt+Wwc=;
        b=kf8zW0EiEwbzlJsjlJNGLVmutvyDjXYoqxddKHjIZQRke6Y/sk9aWsroO+yIV/WVm4
         J/vgn+o07MdUKi5ykYyrqNVEAx62x9V1gssCt3YlhzZ3gtCPT50C05E4StRnybavfDnN
         oNLrh7iOoZbpci55su5v84zCSqx0eYnnKC3NEmunN5ZlBIrcqFKENAr0u5sdKZVCQBxi
         l2NIfj6BREtCwWxTLmQV7rvPD+dIAN6Dt9Hi+EFu1RedgR+wLEO5JWlb7hCSMAzWCv7e
         EvvIevgj67UPkxVRNKOphmTYOruSZ3wNO2gpgVovvjhnMHcCGQbRM1KHV88M5cnXzR9q
         Uh4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mR4IwAvH2FxX7OwBcmYLz+RC12aKLqPbgGS8lJt+Wwc=;
        b=DCSATpWqFbfdB7dAVeWzuA1C2HH47Clz55ZZXi/HnRi10ms0VRY365/HccdIvH/Oc1
         wTpmnGm4CfTeoJNzD42U+TKAukDFU9h9MEcV/jaFMkiRiPZn8D7OAlPyKQmSxSsDYnDE
         RUjR6A7bzZhJq0kLObph+EX2qBCh1ySJxNsOUY/qi1frcQ3za+uvXBhA3mRTTOZAOm/C
         fn+xqa/Gqx9iRmwU48kPePxEzMHFewg+/fxcpW1l9m9A5JjVeGq5Es5jSq9ZDFCKaNA3
         PefIcjD4SH0NObngyN4GUl4njGBTcZYU8SsfAikP3n8ww225QazaEyzNx1rcHDA5NoJ8
         PIPQ==
X-Gm-Message-State: AO0yUKVMc0uq+PIrlyja4Bq9XkUq6z9h+6bnHFw2IUEVlxN7Y497oNyX
        9gBjPFRFmCPveDDNavCD+BSva/NgB6XJZhaB
X-Google-Smtp-Source: AK7set9WLm5Uuurx5EyrndG5kQzCj3rZkzyu2qDGmdC/3XlYtBmjC7ezBHkv1gXyQY8bWpEXJXD+PA==
X-Received: by 2002:adf:f151:0:b0:2c4:1ef:f3da with SMTP id y17-20020adff151000000b002c401eff3damr10744993wro.11.1676103584808;
        Sat, 11 Feb 2023 00:19:44 -0800 (PST)
Received: from vibhavp-mbp.. ([182.69.182.68])
        by smtp.gmail.com with ESMTPSA id x10-20020a5d54ca000000b002bfb5ebf8cfsm5349370wrv.21.2023.02.11.00.19.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 11 Feb 2023 00:19:44 -0800 (PST)
From:   Vibhav Pant <vibhavp@gmail.com>
To:     rafael@kernel.org
Cc:     daniel.lezcano@linaro.org, amitk@kernel.org, rui.zhang@intel.com,
        linux-pm@vger.kernel.org
Subject: [PATCH] tools/lib/thermal: Fix include path for libnl3 in pkg-config file.
Date:   Sat, 11 Feb 2023 13:49:35 +0530
Message-Id: <20230211081935.62690-1-vibhavp@gmail.com>
X-Mailer: git-send-email 2.39.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Fixes pkg-config returning malformed CFLAGS for libthermal.

Signed-off-by: Vibhav Pant <vibhavp@gmail.com>
---
 tools/lib/thermal/libthermal.pc.template | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/lib/thermal/libthermal.pc.template b/tools/lib/thermal/libthermal.pc.template
index 6f3769731b59..ac24d0ab17f5 100644
--- a/tools/lib/thermal/libthermal.pc.template
+++ b/tools/lib/thermal/libthermal.pc.template
@@ -9,4 +9,4 @@ Description: thermal library
 Requires: libnl-3.0 libnl-genl-3.0
 Version: @VERSION@
 Libs: -L${libdir} -lnl-genl-3 -lnl-3
-Cflags: -I${includedir} -I{include}/libnl3
+Cflags: -I${includedir} -I${include}/libnl3
-- 
2.39.1

