Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 923F56A4183
	for <lists+linux-pm@lfdr.de>; Mon, 27 Feb 2023 13:14:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229547AbjB0MO2 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 27 Feb 2023 07:14:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229792AbjB0MO1 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 27 Feb 2023 07:14:27 -0500
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39319359B
        for <linux-pm@vger.kernel.org>; Mon, 27 Feb 2023 04:14:26 -0800 (PST)
Received: by mail-ed1-x52b.google.com with SMTP id f13so24883609edz.6
        for <linux-pm@vger.kernel.org>; Mon, 27 Feb 2023 04:14:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5rJAxuMlPjJZMqCvi30xFBPB2bJ8cx+pfe4n1mvjMsE=;
        b=jPLIy+1s4DaCXyPplTPZMSGaqLBDHhCopAo8iOEKRlqtOFFUl48KktqZjSFEjIMgAY
         2pAUx3dZUitvQ8fUdoOCT1HudCMwfpbjjFvgO0Dy7GTCfcE0yMqxh+QiMbGegE/CuEM2
         2CbOCg2Ca0AXlSOAYPdbUhLf/iI1/G27exXh8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5rJAxuMlPjJZMqCvi30xFBPB2bJ8cx+pfe4n1mvjMsE=;
        b=0kgmy4lRDN5qw0Q5go9nNlbm9mWFDFgQ77gskY8IyrrrGlpoBMY8RsBckPzK3U0DN0
         1C7fYf4aokFpxsGvLWimZSH8FUTycp+hTI6OROvQf9Ugj5EomuuYdB+oalPJO5k9gORv
         G9RCKX2Dia+eTXWfyYRmA/wMnFmMwVs5NvaVKJPUHZSFYiF49G/RNjWGfUA6zX8V1elc
         Pf+KLk/BjVu1sqgkbcVCf1xdOUFxwmxkut/bwpYV8GMt+QWpshMm20r3U4nJvBGDusxR
         7irWrr1vJ8R/pBfBqkK2eA/3QUqOFJ7AhhxK9Ui2lcf0F3GsJkvIOoC3ciPEoFV8mf9H
         80Aw==
X-Gm-Message-State: AO0yUKXvRzvv6ddAXb25FrhKTlQU9jOCMNZcgBKtp2SyGx2WcDqP6wHD
        aWo6e+QUfdgx3nYMeKDIxZSPb2aKWKRBqDDksAo=
X-Google-Smtp-Source: AK7set9GwX2/GOLGwL/wygcmoD0GHLg7iQQ5pFrERs0+B9u2t+z2UF5TquzOkWAfx5Y2gm+U4BWoGg==
X-Received: by 2002:aa7:df15:0:b0:4ae:f496:ee2 with SMTP id c21-20020aa7df15000000b004aef4960ee2mr21223292edy.20.1677500064603;
        Mon, 27 Feb 2023 04:14:24 -0800 (PST)
Received: from md.corp.google.com (140.20.91.34.bc.googleusercontent.com. [34.91.20.140])
        by smtp.gmail.com with ESMTPSA id 30-20020a508e1e000000b00499b6b50419sm2994766edw.11.2023.02.27.04.14.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Feb 2023 04:14:24 -0800 (PST)
From:   Michal Dubiel <md@chromium.org>
To:     linux-pm@vger.kernel.org
Cc:     rafael@kernel.org, pavel@ucw.cz, Michal Dubiel <md@chromium.org>
Subject: [PATCH 2/2] kernel/freezer: Don't warn when thawing freezing cgroup processes
Date:   Mon, 27 Feb 2023 12:13:18 +0000
Message-Id: <20230227121318.2116638-3-md@chromium.org>
X-Mailer: git-send-email 2.39.2.722.g9855ee24e9-goog
In-Reply-To: <20230227121318.2116638-1-md@chromium.org>
References: <20230227121318.2116638-1-md@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Currently, kernel warns when __thaw_task is called on a task that is
freezing for whatever the reason.

However, this can produce unnecessary warning in situations when some
cgroup has been frozen by writing FREEZE to
/sys/fs/cgroup/freezer/*/freezer.state, system suspends and then resumes.

Such situation happens for example in ChromeOS, where we have daemon for
freezing cgroups in certain order before suspending the system and then
thawing them back after system resumes.

The freezing_reason() can be used to obtain the reason why the task is
freezing and don't warn for tasks explicitly requested to freeze by the
user.

Signed-off-by: Michal Dubiel <md@chromium.org>
---
 kernel/freezer.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/kernel/freezer.c b/kernel/freezer.c
index 2536054db60..8a4d315fcbc 100644
--- a/kernel/freezer.c
+++ b/kernel/freezer.c
@@ -203,9 +203,14 @@ static int __set_task_special(struct task_struct *p, void *arg)
 void __thaw_task(struct task_struct *p)
 {
 	unsigned long flags, flags2;
+	enum freezing_reason reason;
 
 	spin_lock_irqsave(&freezer_lock, flags);
-	if (WARN_ON_ONCE(freezing(p)))
+
+	reason = freezing_reason(p);
+	if (reason == FREEZING_CGROUP)
+		goto unlock;
+	else if (WARN_ON_ONCE(reason != FREEZING_NONE))
 		goto unlock;
 
 	if (lock_task_sighand(p, &flags2)) {
-- 
2.39.2.722.g9855ee24e9-goog

