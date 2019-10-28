Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E5FE4E73BF
	for <lists+linux-pm@lfdr.de>; Mon, 28 Oct 2019 15:35:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390172AbfJ1Oei (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 28 Oct 2019 10:34:38 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:34838 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390130AbfJ1Oed (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 28 Oct 2019 10:34:33 -0400
Received: by mail-wr1-f65.google.com with SMTP id l10so10146870wrb.2
        for <linux-pm@vger.kernel.org>; Mon, 28 Oct 2019 07:34:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=jIb0znJW8mP39K4r84V/kqqf7AJDYmG+b4HzDQKU0ZQ=;
        b=TXQEWSsIxMhEel2/32mRMXyje9EVV48QhKGMmTjMsQ5lsi7y+YfS/jKhZ8RxLZ05wb
         pXtrqB2aTjtTnkduKY8R7WtD7Cttq4bWYFlICHLu9nKL4IVYq4DSURApuzhj63LqHkN1
         Rx0bva1eRDRZY+J0Hf2iUINh2p/aPPzb19R+FZpbPBZWI6kc5z6Rkr/SVS/72QJpTvln
         j8LRpMIjJNm1jlKwbM0wzfx27krdk8jiOhxqeO7pb5NmjFS0LpQtYgzpE5tQA5Xkj3rS
         px+7uXDWhBop4VZu0+dPCDLOTJeaeEntAljci9rFRXtsLkZpvYUrdqjkYQoaVLeQICHL
         9JUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=jIb0znJW8mP39K4r84V/kqqf7AJDYmG+b4HzDQKU0ZQ=;
        b=Jeig7RZStiBmFK/s9pG6cBw6EPC5A3arItJTNdd4K0r/MtCHbyR79YSnLdzD2yaoci
         j0HNLGK1afDZAFB2I5e8A0BJbsWiTfU9zOExmrBGkU93UhQebBZ43lUq9FSYEC+k+dtz
         6Wu3KzKEtgvF/6XWk2BJUpfEQaFgk1Cx0FHUFxHxsbjHujMxe/ppSu4E8kog2djQbhA7
         PeI6bD+SN8NguvWevAGWXoM8D9UIHMIXlfgNicC4hSDxBznt4BOrzdmD3F1R825MRgUx
         jJKiYeXP64jQCqA6BUH8cm7CnvuGHo/Rmg2mdzSVdutWb3J3VogGqBNdpRynP3voEE29
         UiqQ==
X-Gm-Message-State: APjAAAUniDu5XnpemyTO8p4WIb1r/nZtVyCOvPyd/hokiWBMPcBOYf2F
        zQ2T9QpfwqXYu/s9OAce73vp6w==
X-Google-Smtp-Source: APXvYqxpp/1GKFQaoddFzjPOeh5D5pudsLSOWKNgvPiu2elWA5y+RTACLTyjjBfpW6ZHoMDlWTtLJg==
X-Received: by 2002:a5d:44c5:: with SMTP id z5mr14560159wrr.252.1572273270013;
        Mon, 28 Oct 2019 07:34:30 -0700 (PDT)
Received: from localhost.localdomain ([2a01:e34:ed2f:f020:d48d:c917:1f3e:4a87])
        by smtp.gmail.com with ESMTPSA id g5sm14166144wmg.12.2019.10.28.07.34.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Oct 2019 07:34:29 -0700 (PDT)
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
To:     rjw@rjwysocki.net
Cc:     mathieu.poirier@linaro.org, mingo@redhat.com, peterz@infradead.org,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        ulf.hansson@linaro.org
Subject: [PATCH V5 3/3] powercap/drivers/idle_inject: Specify the idle state to inject
Date:   Mon, 28 Oct 2019 15:34:19 +0100
Message-Id: <20191028143419.16236-3-daniel.lezcano@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191028143419.16236-1-daniel.lezcano@linaro.org>
References: <20191028143419.16236-1-daniel.lezcano@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Currently the idle injection framework only allows to inject the
deepest idle state available on the system.

Give the opportunity to specify which idle state we want to inject by
adding a new function helper to set the state and use it when calling
play_idle().

Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
Acked-by: Mathieu Poirier <mathieu.poirier@linaro.org>
---
 drivers/powercap/idle_inject.c | 14 +++++++++++++-
 include/linux/idle_inject.h    |  3 +++
 2 files changed, 16 insertions(+), 1 deletion(-)

diff --git a/drivers/powercap/idle_inject.c b/drivers/powercap/idle_inject.c
index 233c878cbf46..5e1efc71ed1c 100644
--- a/drivers/powercap/idle_inject.c
+++ b/drivers/powercap/idle_inject.c
@@ -66,6 +66,7 @@ struct idle_inject_thread {
  */
 struct idle_inject_device {
 	struct hrtimer timer;
+	int state;
 	unsigned int idle_duration_us;
 	unsigned int run_duration_us;
 	unsigned long int cpumask[0];
@@ -140,7 +141,7 @@ static void idle_inject_fn(unsigned int cpu)
 	iit->should_run = 0;
 
 	play_idle(READ_ONCE(ii_dev->idle_duration_us),
-		  cpuidle_find_deepest_state());
+		  READ_ONCE(ii_dev->state));
 }
 
 /**
@@ -171,6 +172,16 @@ void idle_inject_get_duration(struct idle_inject_device *ii_dev,
 	*idle_duration_us = READ_ONCE(ii_dev->idle_duration_us);
 }
 
+/**
+ * idle_inject_set_state - set the idle state to inject
+ * @state: an integer for the idle state to inject
+ */
+void idle_inject_set_state(struct idle_inject_device *ii_dev, int state)
+{
+	if (state >= CPUIDLE_STATE_NOUSE && state < CPUIDLE_STATE_MAX)
+		WRITE_ONCE(ii_dev->state, state);
+}
+
 /**
  * idle_inject_start - start idle injections
  * @ii_dev: idle injection control device structure
@@ -299,6 +310,7 @@ struct idle_inject_device *idle_inject_register(struct cpumask *cpumask)
 	cpumask_copy(to_cpumask(ii_dev->cpumask), cpumask);
 	hrtimer_init(&ii_dev->timer, CLOCK_MONOTONIC, HRTIMER_MODE_REL);
 	ii_dev->timer.function = idle_inject_timer_fn;
+	ii_dev->state = 0;
 
 	for_each_cpu(cpu, to_cpumask(ii_dev->cpumask)) {
 
diff --git a/include/linux/idle_inject.h b/include/linux/idle_inject.h
index a445cd1a36c5..e2b26b9ccd34 100644
--- a/include/linux/idle_inject.h
+++ b/include/linux/idle_inject.h
@@ -26,4 +26,7 @@ void idle_inject_set_duration(struct idle_inject_device *ii_dev,
 void idle_inject_get_duration(struct idle_inject_device *ii_dev,
 				 unsigned int *run_duration_us,
 				 unsigned int *idle_duration_us);
+
+void idle_inject_set_state(struct idle_inject_device *ii_dev, int state);
+
 #endif /* __IDLE_INJECT_H__ */
-- 
2.17.1

