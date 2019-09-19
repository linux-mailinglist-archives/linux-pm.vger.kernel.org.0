Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BE6D5B804B
	for <lists+linux-pm@lfdr.de>; Thu, 19 Sep 2019 19:44:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388045AbfISRoc (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 19 Sep 2019 13:44:32 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:37489 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388143AbfISRoc (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 19 Sep 2019 13:44:32 -0400
Received: by mail-pg1-f196.google.com with SMTP id c17so2302400pgg.4
        for <linux-pm@vger.kernel.org>; Thu, 19 Sep 2019 10:44:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=3My5rPHh+xjcOd2l7pqQvZ2Y4vTncIcNiQ5r2gPD9Zs=;
        b=dvxGSeR8Ydg/dXnySlo3RetI39tG54muvsHUyHd7LFJKCB59cubtut29fvPNR+xy7z
         FpjXlSf7grkgv+cJYFmDlqdmgD3RzdNgNSyNj7od0wEFrnTQ9CXInAUt50ADRikLbnxx
         9ObXnDj1dVEdrT+KayscSK+rFgSJ55natJrXo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=3My5rPHh+xjcOd2l7pqQvZ2Y4vTncIcNiQ5r2gPD9Zs=;
        b=G0T90+VaaAdJn4Nw1xB03FOw+kaZfyOi6A5Uyv1IgikQuqgt0LHpkKXWcZyYiicBGp
         iYHXRhx/ojXkiBdNvoiMMNJeUYGy05mxsObzgQK+wypcMR5BO916iuTcQUsjGGvDP5gA
         fKT/6viF30jCHf6er8Z5RIuRqQdKoA4au3JepBq0SafGF8WEEhbasjryPbHDA14MUTrx
         UqWjhdCtc+Tahh31LxPqwagUIatUEEOVoczE2GzwRdYyd1xAnh+smS1yiSvXvCbIKWaU
         AlNlBmFvI3cUfrzpDuNUGZk3aFzhsjM3ycds/WHFBsDoVMD5iJ/Z4NhnCcX0IX2qXllv
         wUzg==
X-Gm-Message-State: APjAAAVkekJ7G+JL//KFdR2CRt05Gon8m3+fFakAyWndUuw/b17FeDpd
        WgV2uc13dFLynnJU+K+He0Me2Q==
X-Google-Smtp-Source: APXvYqyxoKXWC6PHbldInz20DTbKVvT5kKbs3tnLgXGeHJzM8Oj3iP1ra/anhoDfCzgz801+ueFjGg==
X-Received: by 2002:a17:90a:a6e:: with SMTP id o101mr5103405pjo.71.1568915072106;
        Thu, 19 Sep 2019 10:44:32 -0700 (PDT)
Received: from localhost ([2620:15c:202:1:75a:3f6e:21d:9374])
        by smtp.gmail.com with ESMTPSA id x68sm10451453pfd.183.2019.09.19.10.44.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 19 Sep 2019 10:44:31 -0700 (PDT)
From:   Matthias Kaehlcke <mka@chromium.org>
To:     MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Douglas Anderson <dianders@chromium.org>,
        Matthias Kaehlcke <mka@chromium.org>
Subject: [PATCH v2] devfreq: Add tracepoint for frequency changes
Date:   Thu, 19 Sep 2019 10:44:23 -0700
Message-Id: <20190919174423.105030-1-mka@chromium.org>
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
(sending v2 without much delay wrt v1, since the change in devfreq
 probably isn't controversial, and I'll be offline a few days)

Changes in v2:
- included trace_devfreq_frequency_enabled() in the condition
  to avoid unnecessary evaluation when the trace point is
  disabled
---
 drivers/devfreq/devfreq.c      |  3 +++
 include/trace/events/devfreq.h | 18 ++++++++++++++++++
 2 files changed, 21 insertions(+)

diff --git a/drivers/devfreq/devfreq.c b/drivers/devfreq/devfreq.c
index ab22bf8a12d6..e9f04dcafb01 100644
--- a/drivers/devfreq/devfreq.c
+++ b/drivers/devfreq/devfreq.c
@@ -317,6 +317,9 @@ static int devfreq_set_target(struct devfreq *devfreq, unsigned long new_freq,
 
 	devfreq->previous_freq = new_freq;
 
+	if (trace_devfreq_frequency_enabled() && new_freq != cur_freq)
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

