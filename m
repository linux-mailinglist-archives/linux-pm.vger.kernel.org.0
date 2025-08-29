Return-Path: <linux-pm+bounces-33348-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 442FDB3AF8C
	for <lists+linux-pm@lfdr.de>; Fri, 29 Aug 2025 02:34:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F371D3A6330
	for <lists+linux-pm@lfdr.de>; Fri, 29 Aug 2025 00:34:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BA2A1ABED9;
	Fri, 29 Aug 2025 00:33:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="ME98KGoL"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65F7219EEC2
	for <linux-pm@vger.kernel.org>; Fri, 29 Aug 2025 00:33:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756427629; cv=none; b=sIaU5SOKExWL/rUKaA4tMgahV+EEAsj+XMqfRZBcH86N2m1Do2MlKX0ysjjafS1w9Lmd76F+lvKmBniqZjxTKZxE4Ab49+5tW6z4Ty5VJw1yJg1lriLSCdrq1SMnLUtFpuxDNZunckLAGdP9gCfNBxEozLXnm3v1WcfpcnXSO1c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756427629; c=relaxed/simple;
	bh=x1zBWlFybiOAQheFt5Db/dBD0R0Ga76R6bPpEVgMayA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IyWF7DAJ/Y2+jWP/WX7NP4LX3IysRa+qCx5krwQfwM7t/aXaUT++TL6piEfX+vUayN9YV3JR0dG/4MDUVB8RUte5trHLrE4amjnLcoMc6P3YNHHo2kOCRpCQ57ar602Tz4YiQYEDsTPoHGRBaL3JEqetCLzj0gcWqEmMLsFvwfE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=ME98KGoL; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-7704799d798so1316289b3a.3
        for <linux-pm@vger.kernel.org>; Thu, 28 Aug 2025 17:33:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1756427627; x=1757032427; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ayD+s5i6uiCJamBjIwzMbVAPmgJjmBpAgG8riCuTI7k=;
        b=ME98KGoLVWGWQBQ54JHD+G+kYafCDBGgqdqf5Ek44tvuhyw5tvjt2xGqucs5wdyg73
         rWjYLf533BMUzwTuw6oKQ1B18n7VS+mjBL51B98BER5m/eQyc527mE2WHiVZSEaGHHM0
         dFfoDNKvCxMSbR5zACX+X5RY8/hBw4+QfP2Rc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756427627; x=1757032427;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ayD+s5i6uiCJamBjIwzMbVAPmgJjmBpAgG8riCuTI7k=;
        b=lKHI3PqD2qBL9yGlz9Dd3a3WxTfKhRBLNVaz1HMTVfe+jN93bx0Y6ZT31Tqc4zk7qj
         PXE6JXJOSzRBR8Q7oBXGcZE9DLkwhTvjthmsv6qKqw7lOmcj9MRePafYQXFLiV3lxjq0
         6l6xXCXSYeycK7gZfsHjUELl90E9KA8Yg5sz8UbECvJRw/AQdi2FFhJkG5JdBlHBA2sa
         tGG5sR/LOzpUNB7UsuBSNwlhF16se8dUB+k6xLDwHYKK+hLu+vNkkNzi0WuiOllEGROh
         CtVpTeBG+1qkeUQNKM5SXORrW9T8Ku6vI1PaEfPObIV23mPbcZuu+WbOjvzQUd/xKzwh
         DHRg==
X-Forwarded-Encrypted: i=1; AJvYcCXBw/ZMCxE0ZoYgb792JPZLmdedYzODY84dQxc2AbZi3aoCFM+nbv/eucJXe+oaHet3nuxmsri9uA==@vger.kernel.org
X-Gm-Message-State: AOJu0YyXRKvJW7T09C38pr3D68LmCeXsfR0GruuJY3cjrGwlqgdiYHRv
	vvWFZ96Jc4Pb+UP3Sq4yI6C2XTF1Hv41WcfTZKlB4PZ+vJEAPeTufNb/BzAXfewuuA==
X-Gm-Gg: ASbGncsqqMCQl61bzWaV5cyq59vLNasgd5XE4CDRRfMYcqePeOHLm0umRN2w78GvQ5E
	EnBg03xpk4PEp6h8QH9VlOLn7w2mlU/ngiUq6TWasOzo9LHNmRm4aXYVY1ECjDv0YtdB3NfGht1
	rnu/nshMfXks6GtEg2UU3egLAXr0/YW0QoF+J7f9KmkrKP+vQIV59tLRwmf86hdDIooWxp7Ka3Y
	UI5mP9Aslt5WZOVyM4Nrd7viZxYFmzU7wnsbge6/CjFFL3QUkLwSQTX48kDbkbZyV+4xrwvYqQG
	DrFv6zrESoYnzONXb9CyZyiu5R/fd/RxJWR8/DADuttJalZuZjTRISDJBIfGjyjP3J9vgp/NZ86
	lSmokdQzidbIgd9jyjyPFXUbukSJgSHKqUadpw+rLpbqhR+nYg3+knWkh8yNx
X-Google-Smtp-Source: AGHT+IGkKUfCZ2+bkV3tp6s/OO8uoomnv0g43SFyv3xks+UdEIq+zZvB4/ZdXm93ynYkw7hUtPuGbA==
X-Received: by 2002:a05:6a20:7d9f:b0:21f:ee3f:8ad5 with SMTP id adf61e73a8af0-24340b27e92mr36792352637.20.1756427626554;
        Thu, 28 Aug 2025 17:33:46 -0700 (PDT)
Received: from localhost ([2a00:79e0:2e14:7:2893:df0f:26ec:df00])
        by smtp.gmail.com with UTF8SMTPSA id 41be03b00d2f7-b4cd38610edsm563984a12.54.2025.08.28.17.33.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 28 Aug 2025 17:33:46 -0700 (PDT)
From: Brian Norris <briannorris@chromium.org>
To: "Rafael J. Wysocki" <rafael@kernel.org>,
	Pavel Machek <pavel@kernel.org>
Cc: "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
	kunit-dev@googlegroups.com,
	Len Brown <lenb@kernel.org>,
	Sakari Ailus <sakari.ailus@linux.intel.com>,
	linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Brian Norris <briannorris@chromium.org>
Subject: [PATCH 3/3] PM: runtime: Update kerneldoc return codes
Date: Thu, 28 Aug 2025 17:28:28 -0700
Message-ID: <20250829003319.2785282-3-briannorris@chromium.org>
X-Mailer: git-send-email 2.51.0.318.gd7df087d1a-goog
In-Reply-To: <20250829003319.2785282-1-briannorris@chromium.org>
References: <20250829003319.2785282-1-briannorris@chromium.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

APIs based on __pm_runtime_idle() (pm_runtime_idle(), pm_request_idle())
do not return 1 when already suspended. They return -EAGAIN. This is
already covered in the docs, so the entry for "1" is redundant and
conflicting.

(pm_runtime_put() and pm_runtime_put_sync() were previously incorrect,
but that's fixed in "PM: runtime: pm_runtime_put{,_sync}() returns 1
when already suspended", to ensure consistency with APIs like
pm_runtime_put_autosuspend().)

RPM_GET_PUT APIs based on __pm_runtime_suspend() do return 1 when
already suspended, but the language is a little unclear -- it's not
really an "error", so it seems better to list as a clarification before
the 0/success case. Additionally, they only actually return 1 when the
refcount makes it to 0; if the usage_count is still non-zero, we return
0.

pm_runtime_put(), etc., also don't appear at first like they can ever
see "-EAGAIN: Runtime PM usage_count non-zero", because in non-racy
conditions, pm_runtime_put() would drop its reference count, see it's
non-zero, and return early (in __pm_runtime_idle()). However, it's
possible to race with another actor that increments the usage_count
afterward, since rpm_idle() is protected by a separate lock; in such a
case, we may see -EAGAIN.

Because this case is only seen in the presence of concurrent actors, it
makes sense to clarify that this is when "usage_count **became**
non-zero", by way of some racing actor.

Lastly, pm_runtime_put_sync_suspend() duplicated some -EAGAIN language.
Fix that.

Fixes: 271ff96d6066 ("PM: runtime: Document return values of suspend-related API functions")
Link: https://lore.kernel.org/linux-pm/aJ5pkEJuixTaybV4@google.com/
Signed-off-by: Brian Norris <briannorris@chromium.org>
---

 include/linux/pm_runtime.h | 33 ++++++++++++++++++---------------
 1 file changed, 18 insertions(+), 15 deletions(-)

diff --git a/include/linux/pm_runtime.h b/include/linux/pm_runtime.h
index d88d6b6ccf5b..fd17ffe1bc79 100644
--- a/include/linux/pm_runtime.h
+++ b/include/linux/pm_runtime.h
@@ -356,7 +356,6 @@ static inline int pm_runtime_force_resume(struct device *dev) { return -ENXIO; }
  * * -EPERM: Device PM QoS resume latency 0.
  * * -EINPROGRESS: Suspend already in progress.
  * * -ENOSYS: CONFIG_PM not enabled.
- * * 1: Device already suspended.
  * Other values and conditions for the above values are possible as returned by
  * Runtime PM idle and suspend callbacks.
  */
@@ -439,7 +438,6 @@ static inline int pm_runtime_resume(struct device *dev)
  * * -EPERM: Device PM QoS resume latency 0.
  * * -EINPROGRESS: Suspend already in progress.
  * * -ENOSYS: CONFIG_PM not enabled.
- * * 1: Device already suspended.
  */
 static inline int pm_request_idle(struct device *dev)
 {
@@ -540,15 +538,16 @@ static inline int pm_runtime_resume_and_get(struct device *dev)
  * equal to 0, queue up a work item for @dev like in pm_request_idle().
  *
  * Return:
+ * * 1: Usage counts dropped to zero, but device was already suspended.
  * * 0: Success.
  * * -EINVAL: Runtime PM error.
  * * -EACCES: Runtime PM disabled.
- * * -EAGAIN: Runtime PM usage_count non-zero or Runtime PM status change ongoing.
+ * * -EAGAIN: Runtime PM usage_count became non-zero or Runtime PM status
+ *            change ongoing.
  * * -EBUSY: Runtime PM child_count non-zero.
  * * -EPERM: Device PM QoS resume latency 0.
  * * -EINPROGRESS: Suspend already in progress.
  * * -ENOSYS: CONFIG_PM not enabled.
- * * 1: Device already suspended.
  */
 static inline int pm_runtime_put(struct device *dev)
 {
@@ -565,15 +564,16 @@ DEFINE_FREE(pm_runtime_put, struct device *, if (_T) pm_runtime_put(_T))
  * equal to 0, queue up a work item for @dev like in pm_request_autosuspend().
  *
  * Return:
+ * * 1: Usage counts dropped to zero, but device was already suspended.
  * * 0: Success.
  * * -EINVAL: Runtime PM error.
  * * -EACCES: Runtime PM disabled.
- * * -EAGAIN: Runtime PM usage_count non-zero or Runtime PM status change ongoing.
+ * * -EAGAIN: Runtime PM usage_count became non-zero or Runtime PM status
+ *            change ongoing.
  * * -EBUSY: Runtime PM child_count non-zero.
  * * -EPERM: Device PM QoS resume latency 0.
  * * -EINPROGRESS: Suspend already in progress.
  * * -ENOSYS: CONFIG_PM not enabled.
- * * 1: Device already suspended.
  */
 static inline int __pm_runtime_put_autosuspend(struct device *dev)
 {
@@ -590,15 +590,16 @@ static inline int __pm_runtime_put_autosuspend(struct device *dev)
  * in pm_request_autosuspend().
  *
  * Return:
+ * * 1: Usage counts dropped to zero, but device was already suspended.
  * * 0: Success.
  * * -EINVAL: Runtime PM error.
  * * -EACCES: Runtime PM disabled.
- * * -EAGAIN: Runtime PM usage_count non-zero or Runtime PM status change ongoing.
+ * * -EAGAIN: Runtime PM usage_count became non-zero or Runtime PM status
+ *            change ongoing.
  * * -EBUSY: Runtime PM child_count non-zero.
  * * -EPERM: Device PM QoS resume latency 0.
  * * -EINPROGRESS: Suspend already in progress.
  * * -ENOSYS: CONFIG_PM not enabled.
- * * 1: Device already suspended.
  */
 static inline int pm_runtime_put_autosuspend(struct device *dev)
 {
@@ -619,14 +620,15 @@ static inline int pm_runtime_put_autosuspend(struct device *dev)
  * if it returns an error code.
  *
  * Return:
+ * * 1: Usage counts dropped to zero, but device was already suspended.
  * * 0: Success.
  * * -EINVAL: Runtime PM error.
  * * -EACCES: Runtime PM disabled.
- * * -EAGAIN: Runtime PM usage_count non-zero or Runtime PM status change ongoing.
+ * * -EAGAIN: Runtime PM usage_count became non-zero or Runtime PM status
+ *            change ongoing.
  * * -EBUSY: Runtime PM child_count non-zero.
  * * -EPERM: Device PM QoS resume latency 0.
  * * -ENOSYS: CONFIG_PM not enabled.
- * * 1: Device already suspended.
  * Other values and conditions for the above values are possible as returned by
  * Runtime PM suspend callbacks.
  */
@@ -646,15 +648,15 @@ static inline int pm_runtime_put_sync(struct device *dev)
  * if it returns an error code.
  *
  * Return:
+ * * 1: Usage counts dropped to zero, but device was already suspended.
  * * 0: Success.
  * * -EINVAL: Runtime PM error.
  * * -EACCES: Runtime PM disabled.
- * * -EAGAIN: Runtime PM usage_count non-zero or Runtime PM status change ongoing.
- * * -EAGAIN: usage_count non-zero or Runtime PM status change ongoing.
+ * * -EAGAIN: Runtime PM usage_count became non-zero or Runtime PM status
+ *            change ongoing.
  * * -EBUSY: Runtime PM child_count non-zero.
  * * -EPERM: Device PM QoS resume latency 0.
  * * -ENOSYS: CONFIG_PM not enabled.
- * * 1: Device already suspended.
  * Other values and conditions for the above values are possible as returned by
  * Runtime PM suspend callbacks.
  */
@@ -677,15 +679,16 @@ static inline int pm_runtime_put_sync_suspend(struct device *dev)
  * if it returns an error code.
  *
  * Return:
+ * * 1: Usage counts dropped to zero, but device was already suspended.
  * * 0: Success.
  * * -EINVAL: Runtime PM error.
  * * -EACCES: Runtime PM disabled.
- * * -EAGAIN: Runtime PM usage_count non-zero or Runtime PM status change ongoing.
+ * * -EAGAIN: Runtime PM usage_count became non-zero or Runtime PM status
+ *            change ongoing.
  * * -EBUSY: Runtime PM child_count non-zero.
  * * -EPERM: Device PM QoS resume latency 0.
  * * -EINPROGRESS: Suspend already in progress.
  * * -ENOSYS: CONFIG_PM not enabled.
- * * 1: Device already suspended.
  * Other values and conditions for the above values are possible as returned by
  * Runtime PM suspend callbacks.
  */
-- 
2.51.0.318.gd7df087d1a-goog


