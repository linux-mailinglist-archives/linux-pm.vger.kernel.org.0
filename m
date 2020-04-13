Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (unknown [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6662D1A6360
	for <lists+linux-pm@lfdr.de>; Mon, 13 Apr 2020 09:00:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729089AbgDMHAr (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 13 Apr 2020 03:00:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.18]:55952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727692AbgDMHAq (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 13 Apr 2020 03:00:46 -0400
Received: from mail-pj1-x1042.google.com (mail-pj1-x1042.google.com [IPv6:2607:f8b0:4864:20::1042])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 289F0C008651;
        Mon, 13 Apr 2020 00:00:45 -0700 (PDT)
Received: by mail-pj1-x1042.google.com with SMTP id kx8so3460980pjb.5;
        Mon, 13 Apr 2020 00:00:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=THa3uuzUyESJfKsLJUTlGFvBAq8eFxRN+Y2UL5CD7Ig=;
        b=f50F0ltuqNzOOHqS8RYFS+MQ6VS0c/B+x69gkHx4Aie70TX3m94EXgVhhAF73ov1nq
         anE5uOD9I9TYHU+tm9OEXEni/bM/EBfgtr53xW9OroQgPOIC/gRTaiJb/NMOyZe79W0J
         ON9hxgbDSPc/9CEdVig60SsbWhDOq/xmbkChbLaQX1G3ymn4Pb+TVxE3G53PKUwPV+sD
         DlFcZh+DO0yCTFttCless/re0FGLZVSqc5zHgGL1hwi3wh2Gt8jBEQfjklvpfv+a+jJM
         1Uri5cmHvTkkdEXpSH1v5hhsyx7I9Tqznjemi7qYiIGx8iaDpo2JNzExXyI8wOcxv8Cq
         4yXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=THa3uuzUyESJfKsLJUTlGFvBAq8eFxRN+Y2UL5CD7Ig=;
        b=Jrrq7pmKpZ+wuMYo9wX74ZxCRXoyRpiuKu7MI5ouhz547BSQm1Vrvi8AurmFrsjkKx
         tibdO7t+vtK9ZMBqLiMEGuXSzLJBpD576DRS5XrSIfp91Vmzk47kRYidz4A6Jy2dr42n
         NLuc9sYahDwXwA+5B9mS0q7ZjxKE02E56K0Z7AbHbdCMVeD1yiBE7oKCztFhKXLwps9J
         aZnO/1UgntbTMi/NH9PveJWm4hhihW/s3UUErxWgowYc9vdVYZbRQgpceUJCfNSfrKpT
         uf8jXCIre+pIYNn10ajtG1GYI5L9U3IGTt7yed0gaOH+FYtkD1vpXlHksPprCI76bkHI
         sHBQ==
X-Gm-Message-State: AGi0PubPGt4Qqzz1WI5Zv9pjfovWD7ZLFAQ/RdCb5tO3jv19WrTFKmfj
        d7CqF5NZ9bHvfW9jzOtiY4M=
X-Google-Smtp-Source: APiQypJGy3d9ELPOWjvXqvPdGyP++wGWc6BVBUtZTH7dM3BZztHeY8xv2exYdKms06RFP+jhwAhGvQ==
X-Received: by 2002:a17:90a:d085:: with SMTP id k5mr20942450pju.91.1586761244668;
        Mon, 13 Apr 2020 00:00:44 -0700 (PDT)
Received: from ubt.spreadtrum.com ([117.18.48.82])
        by smtp.gmail.com with ESMTPSA id p4sm7815670pfg.163.2020.04.13.00.00.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Apr 2020 00:00:44 -0700 (PDT)
From:   zhang.lyra@gmail.com
To:     "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Cc:     linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Chunyan Zhang <zhang.lyra@gmail.com>,
        Chunyan Zhang <chunyan.zhang@unisoc.com>
Subject: [RFC PATCH v1 1/2] cpuidle: allow idle state to be found as deepest state for s2idle only
Date:   Mon, 13 Apr 2020 15:00:13 +0800
Message-Id: <20200413070014.12960-2-zhang.lyra@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200413070014.12960-1-zhang.lyra@gmail.com>
References: <20200413070014.12960-1-zhang.lyra@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

From: Chunyan Zhang <chunyan.zhang@unisoc.com>

Add a new flag CPUIDLE_FLAG_S2IDLE to allow c-state to be found as
deepest state for s2idle only, so that users can add a new c-state
for using s2idle and don't worry disturbing other use cases such as
play_idle() which probably don't want to enter into so much deep
idle state since devices are not suspended for that kind of cases.

Signed-off-by: Chunyan Zhang <chunyan.zhang@unisoc.com>
---
 drivers/cpuidle/cpuidle.c        | 3 ++-
 drivers/cpuidle/dt_idle_states.c | 3 +++
 include/linux/cpuidle.h          | 1 +
 3 files changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/cpuidle/cpuidle.c b/drivers/cpuidle/cpuidle.c
index de81298051b3..bb61f0c271d2 100644
--- a/drivers/cpuidle/cpuidle.c
+++ b/drivers/cpuidle/cpuidle.c
@@ -89,7 +89,8 @@ static int find_deepest_state(struct cpuidle_driver *drv,
 		    s->exit_latency_ns <= latency_req ||
 		    s->exit_latency_ns > max_latency_ns ||
 		    (s->flags & forbidden_flags) ||
-		    (s2idle && !s->enter_s2idle))
+		    (s2idle && !s->enter_s2idle) ||
+		    (!s2idle && (s->flags & CPUIDLE_FLAG_S2ILDE)))
 			continue;
 
 		latency_req = s->exit_latency_ns;
diff --git a/drivers/cpuidle/dt_idle_states.c b/drivers/cpuidle/dt_idle_states.c
index 252f2a9686a6..530db2726c05 100644
--- a/drivers/cpuidle/dt_idle_states.c
+++ b/drivers/cpuidle/dt_idle_states.c
@@ -80,6 +80,9 @@ static int init_state_node(struct cpuidle_state *idle_state,
 	idle_state->flags = 0;
 	if (of_property_read_bool(state_node, "local-timer-stop"))
 		idle_state->flags |= CPUIDLE_FLAG_TIMER_STOP;
+
+	if (of_property_read_bool(state_node, "for-s2idle-only"))
+		idle_state->flags |= CPUIDLE_FLAG_S2ILDE;
 	/*
 	 * TODO:
 	 *	replace with kstrdup and pointer assignment when name
diff --git a/include/linux/cpuidle.h b/include/linux/cpuidle.h
index ec2ef63771f0..08da701f74cd 100644
--- a/include/linux/cpuidle.h
+++ b/include/linux/cpuidle.h
@@ -78,6 +78,7 @@ struct cpuidle_state {
 #define CPUIDLE_FLAG_TIMER_STOP BIT(2) /* timer is stopped on this state */
 #define CPUIDLE_FLAG_UNUSABLE	BIT(3) /* avoid using this state */
 #define CPUIDLE_FLAG_OFF	BIT(4) /* disable this state by default */
+#define CPUIDLE_FLAG_S2ILDE	BIT(5) /* state is used for s2idle only */
 
 struct cpuidle_device_kobj;
 struct cpuidle_state_kobj;
-- 
2.20.1

