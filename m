Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E86F505DDB
	for <lists+linux-pm@lfdr.de>; Mon, 18 Apr 2022 20:08:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347314AbiDRSLS (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 18 Apr 2022 14:11:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347312AbiDRSLR (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 18 Apr 2022 14:11:17 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 48BBA369F4
        for <linux-pm@vger.kernel.org>; Mon, 18 Apr 2022 11:08:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1650305316;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=7Z7LguSSdUkmUDE+Xsl0VnKJAhwrmGBK2tVju8AGU+Q=;
        b=XaeCjJk7miHr63QLBmLMA6E1qT3212/whcqkFwCUOi8DGa1WS+z3KxW3/Q/PfyWPnKN/8W
        RuvozIZrC7+Nyqqzj472KQGlevUahM1E5rgaYviTCEea81OtvOCDMUi8/SRhlkJvs2/2GL
        gnS6k7+qC6wGfyL+4Ov8CeM55yQ6RMQ=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-589-ZxgiR_ItNPypHAxKghmnRg-1; Mon, 18 Apr 2022 14:08:35 -0400
X-MC-Unique: ZxgiR_ItNPypHAxKghmnRg-1
Received: by mail-qk1-f197.google.com with SMTP id t3-20020a05620a034300b0069e60a0760cso5778554qkm.20
        for <linux-pm@vger.kernel.org>; Mon, 18 Apr 2022 11:08:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=7Z7LguSSdUkmUDE+Xsl0VnKJAhwrmGBK2tVju8AGU+Q=;
        b=Y3iyjHUHKp+2K94ODxtx6xV3FUrOPDeqz34540XD/Rt4VyYIHpinxy03PWBp1vJqMK
         G58KMleE5oy7egrCtXeFYHomob9epq740IiO1LWx49YaOhTIDcWxD0Jvw6b3RTShEbwu
         dQox0pcmKScy7sATmjCKr4RR+bRTMyAmgjJ7MxLmSvFOmp1/V+yvSUan93R8c6PX/lz/
         PEoA2ECE3hWoNCZCYJ6etM9eoOH0ov4yLKYogRdolOwvNNcUTD6Qbsvd8euEKL/5WdGY
         8NNgIkNe11jQP0VTk4OtMeBvwdSdIc2JiHP+zcBBw46sq/mHIeLgFgoUJ68KG94R1umJ
         t1KQ==
X-Gm-Message-State: AOAM5329qwFvqNotR9wezNTduYDz+cQrcZ0PRaUZSIgi+SESPzOmHOfi
        Krjh4M1XZ59Ym/a3as45t8vt9vmjMtbxuCW8Sk0aPCBgnonxM+i2sIialvbgK8rJLjp0uPLg17l
        B7JuLtbLyrnLMTBL6XUM=
X-Received: by 2002:a05:622a:178b:b0:2f1:fb71:4456 with SMTP id s11-20020a05622a178b00b002f1fb714456mr4753389qtk.249.1650305314583;
        Mon, 18 Apr 2022 11:08:34 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwSTDcKYc8PIPwuPzAzFmUtcKv5J+0wGZ++og45KyvKRBZ8y2tbTYvujBXqPCh5b7ux4jlAng==
X-Received: by 2002:a05:622a:178b:b0:2f1:fb71:4456 with SMTP id s11-20020a05622a178b00b002f1fb714456mr4753366qtk.249.1650305314308;
        Mon, 18 Apr 2022 11:08:34 -0700 (PDT)
Received: from dell-per740-01.7a2m.lab.eng.bos.redhat.com (nat-pool-bos-t.redhat.com. [66.187.233.206])
        by smtp.gmail.com with ESMTPSA id j12-20020ae9c20c000000b0067ec380b320sm6927149qkg.64.2022.04.18.11.08.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Apr 2022 11:08:33 -0700 (PDT)
From:   Tom Rix <trix@redhat.com>
To:     daniel.lezcano@kernel.org, rafael@kernel.org
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Tom Rix <trix@redhat.com>
Subject: [PATCH] powercap/dtpm: move dtpm_subsys definition to dtpm.c
Date:   Mon, 18 Apr 2022 14:08:14 -0400
Message-Id: <20220418180814.1811136-1-trix@redhat.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Smatch reports this issue
dtpm_devfreq.c:200:24: warning: symbol 'dtpm_devfreq_ops'
  was not declared. Should it be static?

dtpm_devfreq_ops is declared in dtpm_subsys.h where it
is also used

extern struct dtpm_subsys_ops dtpm_devfreq_ops;
struct dtpm_subsys_ops *dtpm_subsys[] = {
...
	&dtpm_devfreq_ops,

Global variables should not be defined in header files.
This only works because dtpm.c is the only includer
of dtpm_subsys.h and user of dtpm_susys[].

Move the definition of dtpm_subsys[] to dtpm.c and change
the storage-class specifier to static.

Signed-off-by: Tom Rix <trix@redhat.com>
---
 drivers/powercap/dtpm.c        | 9 +++++++++
 drivers/powercap/dtpm_subsys.h | 9 ---------
 2 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/drivers/powercap/dtpm.c b/drivers/powercap/dtpm.c
index ce920f17f45f..827a2509bec7 100644
--- a/drivers/powercap/dtpm.c
+++ b/drivers/powercap/dtpm.c
@@ -29,6 +29,15 @@
 
 #define DTPM_POWER_LIMIT_FLAG 0
 
+static struct dtpm_subsys_ops *dtpm_subsys[] = {
+#ifdef CONFIG_DTPM_CPU
+	&dtpm_cpu_ops,
+#endif
+#ifdef CONFIG_DTPM_DEVFREQ
+	&dtpm_devfreq_ops,
+#endif
+};
+
 static const char *constraint_name[] = {
 	"Instantaneous",
 };
diff --git a/drivers/powercap/dtpm_subsys.h b/drivers/powercap/dtpm_subsys.h
index db1712938a96..2db9a3efba93 100644
--- a/drivers/powercap/dtpm_subsys.h
+++ b/drivers/powercap/dtpm_subsys.h
@@ -10,13 +10,4 @@
 extern struct dtpm_subsys_ops dtpm_cpu_ops;
 extern struct dtpm_subsys_ops dtpm_devfreq_ops;
 
-struct dtpm_subsys_ops *dtpm_subsys[] = {
-#ifdef CONFIG_DTPM_CPU
-	&dtpm_cpu_ops,
-#endif
-#ifdef CONFIG_DTPM_DEVFREQ
-	&dtpm_devfreq_ops,
-#endif
-};
-
 #endif
-- 
2.27.0

