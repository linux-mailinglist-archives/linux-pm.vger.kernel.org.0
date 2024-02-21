Return-Path: <linux-pm+bounces-4199-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DF6885E3A5
	for <lists+linux-pm@lfdr.de>; Wed, 21 Feb 2024 17:44:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 752E1B220D4
	for <lists+linux-pm@lfdr.de>; Wed, 21 Feb 2024 16:44:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79B6882D97;
	Wed, 21 Feb 2024 16:42:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="1GAtX7yd"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0FA682D63
	for <linux-pm@vger.kernel.org>; Wed, 21 Feb 2024 16:42:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708533727; cv=none; b=K17Zvp05N9Zludvsad1CHwbk70+ZA3dowksmMvc7sY6G07dfQFLXY9iVSLq3Sr5EVBUoIa60SeKFm7gL6xb2ErDJWlncap1bfDypgvw85O3JK0PMyyvEOq+Q75Gjt58lYk4QsSSEuEXyNDGGoqoRRW0CuruNQz/mTMyG9WcrKRI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708533727; c=relaxed/simple;
	bh=5QvEqAnoo4+rJMB/03f8vFSvfBFHh/I8MNbKCyj6Q8s=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=lEWcgpMI6iDYHO4htES1cSDIegGCsLdhJf+B8pbb/GuvY5asJ+2OUBlXRAeoEBGwMZhdAlMa8WlLgszlaudE9CIFx5iM3EYebgN41/ieXHZvQyWyJ0/2n9PQv51YeHtVqLhEQZWaQfpyMEkghnjUoMXmr2klVaQnehtkrlW1v3s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--vilasbhat.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=1GAtX7yd; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--vilasbhat.bounces.google.com
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-dc64e0fc7c8so9511956276.2
        for <linux-pm@vger.kernel.org>; Wed, 21 Feb 2024 08:42:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1708533725; x=1709138525; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=KbnKqBJ3sCc2xkK0NDD9vN4I2lfLk3JwJvt5ev19VfU=;
        b=1GAtX7ydJCksB1JKmRt1pa/tIOc0QF5C9ZHBvQpOh4XSiRgneWacp5bTYCvJ1pHD94
         MzCfOEwsp1cok54wdoXCKBz7qhncpApABqogTpoKNIgGZGHlow8cjb7xwQe5LQiUgGm/
         JAcx7vI76+TEJtt3dp9YIuP6S5Uj0dWf0IZG0S1STQaaQi/P0XHHHOnNo9plwEemtv+A
         2Fo+2USg5aIIJ7xBHSvefR9vnXWlFxk6tDKwXWTZy+e9m9BvdOC4GziOeucv+sprVlFk
         PbjaKg0IYlOL3GFvfVc94bjVcpghZ6ImEEzWwTUQg86dGaUwMDbKiWcaIwoEJhbSKIPm
         W3ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708533725; x=1709138525;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=KbnKqBJ3sCc2xkK0NDD9vN4I2lfLk3JwJvt5ev19VfU=;
        b=wSG5o5QmN/5wGWQDNNH5J6Sm9U36L2UrDsQqn5/nfiZX7bL8WegOpzGiucfT1Q7ZxO
         LeizUFM/9fPQ0aWx+YeY/SbNqBtTL5at8d08IIhNt3FJk+mgXBrDxN9nWHVy2MRq9aJM
         60SbKl2ouklw9cy+04nkxgaudHdLc2/AsR83PHweR22cDm8y0JTzKdteDOo7yoK4F3SW
         mZK+B7VovGYgVDgE4K8YiNUn0oWXm4oMek0ZV9xZh79+kSFTsh83emT3Z6+5wvERbNm/
         6k5vHqxYu53A0nToBh8JMcwlvWOAvRsTdiiezSroCpMbOC1+3EjaOqdPZHErxjs3OmuM
         R9oQ==
X-Forwarded-Encrypted: i=1; AJvYcCUP10+lMQLwLZKF0yMDFP/7D5+F8aqIobDN6Szy4pw5Lz928uefKKF8Q7c818DNLMOq9/D93jjAEQMpFI4RbHD1TQn1IaIeBAI=
X-Gm-Message-State: AOJu0YyzLSOOb2HCGvpxPDWskHu07OVVRlb2oxU98Fit5a+LyAROZ5Et
	KUkYCRR8FLebiEn2dl8q/hyTNsXUaYPP3Gv8kNygwQeuwkW0hG+vk7F2Fj2MRAh6SanR+z571x9
	ddTCxFez+gllYNw==
X-Google-Smtp-Source: AGHT+IHXWaPLyNfBDOUrupOCFt26TQxeRbB1i6NKLfWplBjOilufWplqhgM19MdKKwZATUX83JfPRq4Jh/dX/Vk=
X-Received: from vilasbhat-emu.c.googlers.com ([fda3:e722:ac3:cc00:dc:567e:c0a8:8f2])
 (user=vilasbhat job=sendgmr) by 2002:a25:1984:0:b0:dce:5218:c89b with SMTP id
 126-20020a251984000000b00dce5218c89bmr478937ybz.5.1708533724903; Wed, 21 Feb
 2024 08:42:04 -0800 (PST)
Date: Wed, 21 Feb 2024 16:41:10 +0000
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.44.0.rc0.258.g7320e95886-goog
Message-ID: <20240221164112.846409-1-vilasbhat@google.com>
Subject: [PATCH v1] PM: runtime: add tracepoint for runtime_status changes
From: Vilas Bhat <vilasbhat@google.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>, Pavel Machek <pavel@ucw.cz>, Len Brown <len.brown@intel.com>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Steven Rostedt <rostedt@goodmis.org>, 
	Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: Vilas Bhat <vilasbhat@google.com>, Saravana Kannan <saravanak@google.com>, kernel-team@android.com, 
	linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Existing runtime PM ftrace events (`rpm_suspend`, `rpm_resume`,
`rpm_return_int`) offer limited visibility into the exact timing of device
runtime power state transitions, particularly when asynchronous operations
are involved. When the `rpm_suspend` or `rpm_resume` functions are invoked
with the `RPM_ASYNC` flag, a return value of 0 i.e., success merely
indicates that the device power state request has been queued, not that
the device has yet transitioned.

A new ftrace event, `rpm_status`, is introduced. This event directly logs
the `power.runtime_status` value of a device whenever it changes providing
granular tracking of runtime power state transitions regardless of
synchronous or asynchronous `rpm_suspend` / `rpm_resume` usage.

Signed-off-by: Vilas Bhat <vilasbhat@google.com>
---
 drivers/base/power/runtime.c |  1 +
 include/trace/events/rpm.h   | 36 ++++++++++++++++++++++++++++++++++++
 2 files changed, 37 insertions(+)

diff --git a/drivers/base/power/runtime.c b/drivers/base/power/runtime.c
index 05793c9fbb84..d10354847878 100644
--- a/drivers/base/power/runtime.c
+++ b/drivers/base/power/runtime.c
@@ -94,6 +94,7 @@ static void update_pm_runtime_accounting(struct device *dev)
 static void __update_runtime_status(struct device *dev, enum rpm_status status)
 {
 	update_pm_runtime_accounting(dev);
+	trace_rpm_status(dev, status);
 	dev->power.runtime_status = status;
 }
 
diff --git a/include/trace/events/rpm.h b/include/trace/events/rpm.h
index 3c716214dab1..f1dc4e95dbce 100644
--- a/include/trace/events/rpm.h
+++ b/include/trace/events/rpm.h
@@ -101,6 +101,42 @@ TRACE_EVENT(rpm_return_int,
 		__entry->ret)
 );
 
+#define RPM_STATUS_STRINGS \
+	{ RPM_INVALID, "RPM_INVALID" }, \
+	{ RPM_ACTIVE, "RPM_ACTIVE" }, \
+	{ RPM_RESUMING, "RPM_RESUMING" }, \
+	{ RPM_SUSPENDED, "RPM_SUSPENDED" }, \
+	{ RPM_SUSPENDING, "RPM_SUSPENDING" }
+
+/*
+ * ftrace's __print_symbolic requires that all enum values be wrapped in the
+ * TRACE_DEFINE_ENUM macro so that the enum value can be encoded in the ftrace
+ * ring buffer.
+ */
+TRACE_DEFINE_ENUM(RPM_INVALID);
+TRACE_DEFINE_ENUM(RPM_ACTIVE);
+TRACE_DEFINE_ENUM(RPM_RESUMING);
+TRACE_DEFINE_ENUM(RPM_SUSPENDED);
+TRACE_DEFINE_ENUM(RPM_SUSPENDING);
+
+TRACE_EVENT(rpm_status,
+	TP_PROTO(struct device *dev, enum rpm_status status),
+	TP_ARGS(dev, status),
+
+	TP_STRUCT__entry(
+		__string(name,	dev_name(dev))
+		__field(int,	status)
+	),
+
+	TP_fast_assign(
+		__assign_str(name, dev_name(dev));
+		__entry->status = status;
+	),
+
+	TP_printk("%s status=%s", __get_str(name),
+		__print_symbolic(__entry->status, RPM_STATUS_STRINGS))
+);
+
 #endif /* _TRACE_RUNTIME_POWER_H */
 
 /* This part must be outside protection */
-- 
2.44.0.rc0.258.g7320e95886-goog


