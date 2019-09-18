Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B33B7B6BDE
	for <lists+linux-pm@lfdr.de>; Wed, 18 Sep 2019 21:15:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725909AbfIRTPn (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 18 Sep 2019 15:15:43 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:46790 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728274AbfIRTPn (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 18 Sep 2019 15:15:43 -0400
Received: by mail-pf1-f196.google.com with SMTP id q5so595650pfg.13
        for <linux-pm@vger.kernel.org>; Wed, 18 Sep 2019 12:15:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=QznQIsPmRQMTWr3DobEVwSUb3hfFyooPIqDVOigxW3s=;
        b=jIJuwHz8AdTaWAM5jnpAzJ02psVnIIc4slG2c/uH5RccAy8CfRpIJanIH4RBdZ/+Si
         Mn/wuxFm/JTNz/xOGFzK/qKIcQD8/JL+6H1BN+qdGp7HFiclukD7wuyDMwkZSOXb6DmR
         7PQ8sZ0wrD8g2jvaht5ukMjhTk/YXFwZz+Tp0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=QznQIsPmRQMTWr3DobEVwSUb3hfFyooPIqDVOigxW3s=;
        b=J3xu928sm0wON6bmcke2DQmgbrz/3KUezr70yQ2GjkTxC/e/rlW4Yw4KHqEPRyfyb0
         donYZTuuWPE4cR0Q/neoCOmnc4yoGD//X6RdwTy84e222zgISRhhREnL/L7t8BoYdUUr
         FYVVLLwBBV/bItL16Nw4JfvgPjOAsKu/lGj1o9CFtoyzlz2gJqdfyzWpiZQ2e7A8TtLF
         BdyzS3ED/5eOGaAtPD8miDZ16o3Mne/Lwv8EUvPrL3FSW5DDAfUOj9cgAFkJkuabZYYV
         3NeJhgAhjGZRUEt+5VwbLnqo/K5quwlG4s3lw66V+ezybyHIfP/6OzxNdE80wzsBXkta
         BFdQ==
X-Gm-Message-State: APjAAAWywJHNL4Ik1r4wFCQjabDYM74qRdaUzwO6kfg/0SBZH3dF/Prs
        G182Ghdc2eDwhJtEjeTxo1USLA==
X-Google-Smtp-Source: APXvYqzIQRCO49+6U77cxewbCNKEeb29tgMkR0EvOQ6K/XWN59+iP3LwRtrnuP6dmDLPhgjsXewdGw==
X-Received: by 2002:a62:7646:: with SMTP id r67mr5940551pfc.116.1568834143043;
        Wed, 18 Sep 2019 12:15:43 -0700 (PDT)
Received: from localhost ([2620:15c:202:1:75a:3f6e:21d:9374])
        by smtp.gmail.com with ESMTPSA id 195sm8847705pfz.103.2019.09.18.12.15.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 18 Sep 2019 12:15:42 -0700 (PDT)
From:   Matthias Kaehlcke <mka@chromium.org>
To:     MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Douglas Anderson <dianders@chromium.org>,
        Matthias Kaehlcke <mka@chromium.org>
Subject: [PATCH] devfreq: Add tracepoint for frequency changes
Date:   Wed, 18 Sep 2019 12:15:37 -0700
Message-Id: <20190918191537.48837-1-mka@chromium.org>
X-Mailer: git-send-email 2.23.0.237.gc6a4ce50a0-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Add a tracepoint for frequency changes of devfreq devices and
use it.

Signed-off-by: Matthias Kaehlcke <mka@chromium.org>
---
 drivers/devfreq/devfreq.c      |  3 +++
 include/trace/events/devfreq.h | 18 ++++++++++++++++++
 2 files changed, 21 insertions(+)

diff --git a/drivers/devfreq/devfreq.c b/drivers/devfreq/devfreq.c
index ab22bf8a12d6..32de1f6ac776 100644
--- a/drivers/devfreq/devfreq.c
+++ b/drivers/devfreq/devfreq.c
@@ -317,6 +317,9 @@ static int devfreq_set_target(struct devfreq *devfreq, unsigned long new_freq,
 
 	devfreq->previous_freq = new_freq;
 
+	if (new_freq != cur_freq)
+		trace_devfreq_frequency(devfreq, new_freq);
+
 	if (devfreq->suspend_freq)
 		devfreq->resume_freq = cur_freq;
 
diff --git a/include/trace/events/devfreq.h b/include/trace/events/devfreq.h
index cf5b8772175d..a62d32fe3c33 100644
--- a/include/trace/events/devfreq.h
+++ b/include/trace/events/devfreq.h
@@ -8,6 +8,24 @@
 #include <linux/devfreq.h>
 #include <linux/tracepoint.h>
 
+TRACE_EVENT(devfreq_frequency,
+	TP_PROTO(struct devfreq *devfreq, unsigned long freq),
+
+	TP_ARGS(devfreq, freq),
+
+	TP_STRUCT__entry(
+		__string(dev_name, dev_name(&devfreq->dev))
+		__field(unsigned long, freq)
+	),
+
+	TP_fast_assign(
+		__assign_str(dev_name, dev_name(&devfreq->dev));
+		__entry->freq = freq;
+	),
+
+	TP_printk("dev_name=%s freq=%lu", __get_str(dev_name), __entry->freq)
+);
+
 TRACE_EVENT(devfreq_monitor,
 	TP_PROTO(struct devfreq *devfreq),
 
-- 
2.23.0.237.gc6a4ce50a0-goog

