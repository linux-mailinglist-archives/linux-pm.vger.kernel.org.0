Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E9BD784997
	for <lists+linux-pm@lfdr.de>; Tue, 22 Aug 2023 20:50:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229601AbjHVSuG (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 22 Aug 2023 14:50:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229765AbjHVSuE (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 22 Aug 2023 14:50:04 -0400
Received: from mail-qk1-x730.google.com (mail-qk1-x730.google.com [IPv6:2607:f8b0:4864:20::730])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D61E10B
        for <linux-pm@vger.kernel.org>; Tue, 22 Aug 2023 11:50:03 -0700 (PDT)
Received: by mail-qk1-x730.google.com with SMTP id af79cd13be357-76d8f2be749so306061185a.3
        for <linux-pm@vger.kernel.org>; Tue, 22 Aug 2023 11:50:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692730202; x=1693335002;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=UfpP3q9QbQ/9V8DIYX+5NYoCJ0g6gbyQdcSY95Lp5IM=;
        b=SD6aK9LGm3psw81R50iBb8SXKR1GkoxkK9BNNXiFYTPVVRy/FqRIWriDTEQ25cr3Ny
         Nn6UmbrIotKWSIWNmjU6eWa7GkN9SezDJAkcIqJhESVubahMYRe9f+datjpJsSKcy41o
         DpigTWW9+7gb+zgTVIkmtAmGreSpkSuzRKXAxp6/ne7Ydz/gVzqTC9h+HmtAElAbIp1a
         vZRbgHrSYSvdeMnV/Rcsz7Gs5qyMpwYa9upYi04qyR7iMhY/YXF9oJAVhhm3XcEVRtsm
         u/PYVkCNWUwPwK0vsRBBsihh4lENOYZ4egZlfnHgOXjHqEFYr73ohWiHdXayqdcoSIzt
         D4EA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692730202; x=1693335002;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UfpP3q9QbQ/9V8DIYX+5NYoCJ0g6gbyQdcSY95Lp5IM=;
        b=QSsGSMZeHxUzvdVWnqhyUWl9/UFFjNZowDu5C7hTBs1c5rxAwCESLqImA+7GuO4qbY
         e+dTYIkLoHQNJGEFjtMt8fexouHj7J0uTyrNYXCqc2b1c3FwBeiLkVdtxWCQ9cUXSERk
         Wjiz9H0/PkfDJI1SdyyV83OlxXH0pGnedWIIVOQqbpj48MApvwkuXskoZ0XVW2w1d2Sh
         QjC+FXAZpK20+TVdMGJ8gqmHCNUSc8oVh5GzabXik441AMqswPfaVPJV099ENiU6lARA
         anijSDVWZUXEoXGoqA5ZEsedRj4GZVEl52CYSr5bJ9ozVfwvjXMP2fqvG0K9Urckn1Kw
         Imag==
X-Gm-Message-State: AOJu0Yykv9CecNiS22v0ksF3C/e1mcGR/kAfQXUu8ML8fSJOEui1sBSP
        3gJJR1SR2h5nsnglfQDM/9kQmu6bYt8=
X-Google-Smtp-Source: AGHT+IGIV3yUNeZOLmOV98Yt2kQSEiuFnMcu0ibbOpIPKUfes5M3GdAJNEN5py35dzoWATyuE4yEnA==
X-Received: by 2002:a05:620a:1a84:b0:76d:a52a:fd74 with SMTP id bl4-20020a05620a1a8400b0076da52afd74mr1165636qkb.62.1692730201769;
        Tue, 22 Aug 2023 11:50:01 -0700 (PDT)
Received: from udipad-dell.. ([2607:fb91:de1:80c7:7185:95ab:794f:b3d9])
        by smtp.gmail.com with ESMTPSA id c19-20020a05620a165300b0076d9f2d4fabsm2343227qko.15.2023.08.22.11.50.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Aug 2023 11:50:01 -0700 (PDT)
From:   Meet Udeshi <mudeshi1209@gmail.com>
To:     linux-pm@vger.kernel.org
Cc:     Meet Udeshi <mudeshi1209@gmail.com>
Subject: [PATCH] tools/thermal: tmon: Fix sample data update in PID
Date:   Tue, 22 Aug 2023 14:49:40 -0400
Message-Id: <20230822184940.31316-1-mudeshi1209@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Fixed the order of update for `xk_1` and `xk_2` in the PID controller in
function `controller_handler()`.

The previous timestep data in the PID controller, `xk_1` and `xk_2`,
were updated in the wrong order. `xk_1` was overwritten before `xk_2`
was assigned. This caused both `xk_1` and `xk_2` to take the value of
`xk` when the function `controller_handler()` was called.
This means the D-term of the PID controller was simplified from
a second-order approximation using two previous timesteps to a
first-order approximation using one previous timestep.

    xk - 2 * xk_1 + xk_2 => xk - xk_1

This degraded the performance of the PID controller by making it more
noisy and less accurate.

This bug was found by reverse engineering the tmon binary using the
[REMaQE tool](https://arxiv.org/abs/2305.06902).

Signed-off-by: Meet Udeshi <mudeshi1209@gmail.com>
Fixes: 94f69966faf8 ("tools/thermal: Introduce tmon, a tool for thermal subsystem")
---
 tools/thermal/tmon/pid.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/thermal/tmon/pid.c b/tools/thermal/tmon/pid.c
index da20088285bd..1c02eb675088 100644
--- a/tools/thermal/tmon/pid.c
+++ b/tools/thermal/tmon/pid.c
@@ -103,8 +103,8 @@ void controller_handler(const double xk, double *yk)
 	/* compute output */
 	*yk += p_term + i_term + d_term;
 	/* update sample data */
-	xk_1 = xk;
 	xk_2 = xk_1;
+	xk_1 = xk;
 
 	/* clamp output adjustment range */
 	if (*yk < -LIMIT_HIGH)
-- 
2.34.1

