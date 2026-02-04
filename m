Return-Path: <linux-pm+bounces-42044-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aJkXGZoMg2k+hAMAu9opvQ
	(envelope-from <linux-pm+bounces-42044-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Wed, 04 Feb 2026 10:08:42 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id AE1F1E3975
	for <lists+linux-pm@lfdr.de>; Wed, 04 Feb 2026 10:08:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id F08FD300F1C9
	for <lists+linux-pm@lfdr.de>; Wed,  4 Feb 2026 09:04:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C307F1ADC7E;
	Wed,  4 Feb 2026 09:04:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ReW/SFcw"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pf1-f196.google.com (mail-pf1-f196.google.com [209.85.210.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F82B385500
	for <linux-pm@vger.kernel.org>; Wed,  4 Feb 2026 09:04:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770195888; cv=none; b=rtEec3yg8kdg4QGDTM+LWDBC1kDbZnHZOwcyOxMsJK03F5iDdszQeBjXQa+19XzOye3exnDwaIA/AMOjIF5cWVDkNjG9jdwhRqWo4EX7F6MtKnzMfm4cuznh4UTblMs9z3lSwepgdO0n/SPBprGoPTQcPDS8Aku/lUuymaaVk60=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770195888; c=relaxed/simple;
	bh=b7o9EGeczHhj0UnKFpJJndatUBCnTI8nb7udT0b939Q=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Y3GcqesL49foTABbiN/kdBpHSncHqrwT9uxrwAV06Kxxrc/3GJhGXpHhpD/gaQWI+yYqOSF6Q/HCn4sqfbC1B4LtSwQNZmGY5Fgh7tMD5YP+AmWFxZcJpeAPSoItSmABU9muafZgvEoy4WZFR7BW2UwemwQ43pBYlLRIPn8g4Ow=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ReW/SFcw; arc=none smtp.client-ip=209.85.210.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f196.google.com with SMTP id d2e1a72fcca58-82361bcbd8fso3872371b3a.0
        for <linux-pm@vger.kernel.org>; Wed, 04 Feb 2026 01:04:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770195888; x=1770800688; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=IKhgcQfzdWAm6MrQstZzClRw7NEMvrb/unRTCiXNDpU=;
        b=ReW/SFcwP6Y89Hn1gkKwU0LZ67pc14gru7qwpKG6/vjokyrZptvSb26CzM8qEaKQnW
         7JL3cO+Xeku9+nqc98afWNo6nsFtQYchfQim+F8bGpwwFZxaBBfXjpCWYjIF0mCHhw1B
         30IARAFkLDwK5a+/7KckswZIZMGdoW/qFYMy9nLk0vz+5c5pzfO7qVMNzarAw7hQokvR
         4i4CGNXtHuoQnYYV4yyTbxOsVaXC6ywNODBHed3z51dKu8UHrBToKz/fVHv7N0EHI9ss
         mwvOnr/aiml5xsVx3ld/PUVlao8mU4uR4197+H28lI6o9V8hFC8zfgPEH9gLUoXhNzAr
         AQQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770195888; x=1770800688;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IKhgcQfzdWAm6MrQstZzClRw7NEMvrb/unRTCiXNDpU=;
        b=XXDtvFZ0UWM/+YygcAQ5rfRWniwlj0Z6RnHQUFUpN1mkFFplyaCkXo5L5i7+4gViuO
         nUMJ4ck42lvcjSypdds+rz3Yldy3UjlfEUOYagoQhMjsjyaLEmqwqByEjHshQty8CgdH
         EAsK6APNGdB7b5i2UvINSCr+QzLt9dnndOn9NEhxuusyiQ5m0O5lnQf7yTrN8QJWi83T
         eT2eV36+o/QaNRjuo5h/BaSgVBtQr6LmJxCpZP+qf/BR5empi/NIXAz5Sx9m+Y9rg4ym
         tK8zdf756Gto/NsnGYlNLSz7x35DZy2Cey4EfWIe7eDyRHOZE/7PdHCbqPXvwSQnKFql
         9DRg==
X-Gm-Message-State: AOJu0YznscluXEAmabWmNrlUuTV6hul/kDzrarmVJqyz4rMY+2f7YL7R
	g22EOMH5QRUcHtA5s2zw4b9FTW8kza8ibmnbwIcDfiA4yXWjtFhd1Gjmvk+AWpjUWGP6Tg==
X-Gm-Gg: AZuq6aKgo8DpzgnPKvtinqdQk4PPqo6lZvWmsD3twlqJl7dHwJWakS0ETJhpLp5rGND
	czdvDSs9RoiSIlTHSM4wACxs7fsiKeQormFGNZXnah1h3/g3gaYjbJsZzccKEQBSc96RX4SwJLW
	AtLC03geTkvJzdJiYr9YOmAnfbHWjiju1Mxvd/UQ7YTXbAbPpd+jXA3U+Ej5bZAAmCO+Gc7cgb9
	r7JocWG3ljU9gLolMnHU7tjKXwiSe8brVQL4Fmp3NPn7PedgOdaXHYNCDYb1ZY4i6iiTA/FPwoI
	iQLZdhaiwzg0TRfRMTmxU3TpZ0+vNZYpXjdX1gMYsHisDBLQMeSWQoRtAECUfaxkto8J0Y3Hk5M
	NNhoqZOhfTuZ8Z7VR80Uo3GE9QuuAfOLLgQ2HxmyWEXUMYsVZkyT00rZ4Mg+/6GXjMQ8ufhfWgB
	T5xhjMP7gwDZjWsSh3Kz6Uhl76pi40qZuyyHTLKnH3cvMvMpueoUywG/Et6vYr9TbPduQ=
X-Received: by 2002:a05:6a00:bd10:b0:821:7d7e:41e0 with SMTP id d2e1a72fcca58-8241c19dabbmr2028417b3a.5.1770195887712;
        Wed, 04 Feb 2026 01:04:47 -0800 (PST)
Received: from eurus-Lenovo-Legion-Y70002021.. (n058152109156.netvigator.com. [58.152.109.156])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8241d163ce2sm2077923b3a.13.2026.02.04.01.04.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Feb 2026 01:04:47 -0800 (PST)
From: Wang Jiayue <akaieurus@gmail.com>
To: rafael@kernel.org,
	lenb@kernel.org,
	pavel@kernel.org,
	gregkh@linuxfoundation.org,
	dakr@kernel.org
Cc: linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Wang Jiayue <akaieurus@gmail.com>,
	Gui-Dong Han <hanguidong02@gmail.com>
Subject: [PATCH] PM: sleep: wakeirq: remove outdated comments
Date: Wed,  4 Feb 2026 17:04:31 +0800
Message-Id: <20260204090431.84978-1-akaieurus@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com];
	TAGGED_FROM(0.00)[bounces-42044-lists,linux-pm=lfdr.de];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[akaieurus@gmail.com,linux-pm@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[gmail.com:+];
	TAGGED_RCPT(0.00)[linux-pm];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: AE1F1E3975
X-Rspamd-Action: no action

Remove the stale documentations. The comments claiming that
dev_pm_*wake_irq*() helpers must be called with dev->power.lock held and
only from rpm_suspend/resume paths are no longer correct, since
pm_runtime_force_suspend/resume() call them lockless.

Reported-by: Gui-Dong Han <hanguidong02@gmail.com>
Closes: https://lore.kernel.org/all/CAJZ5v0jN9fU9NdWqc-+F5hiSEP4JkR=_qcdGzzHtk1i5tvCDbQ@mail.gmail.com/
Fixes: c46a0d5ae4f9 ("PM: runtime: Extend support for wakeirq for force_suspend|resume")
Signed-off-by: Wang Jiayue <akaieurus@gmail.com>
---
 drivers/base/power/wakeirq.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/drivers/base/power/wakeirq.c b/drivers/base/power/wakeirq.c
index 8aa28c08b289..4f57058f2148 100644
--- a/drivers/base/power/wakeirq.c
+++ b/drivers/base/power/wakeirq.c
@@ -269,9 +269,6 @@ EXPORT_SYMBOL_GPL(dev_pm_set_dedicated_wake_irq_reverse);
  * starts in RPM_SUSPENDED state, and the first pm_runtime_get() would
  * otherwise try to disable already disabled wakeirq. The wake-up interrupt
  * starts disabled with IRQ_NOAUTOEN set.
- *
- * Should be only called from rpm_suspend() and rpm_resume() path.
- * Caller must hold &dev->power.lock to change wirq->status
  */
 void dev_pm_enable_wake_irq_check(struct device *dev,
 				  bool can_change_status)
@@ -303,7 +300,6 @@ void dev_pm_enable_wake_irq_check(struct device *dev,
  * @cond_disable: if set, also check WAKE_IRQ_DEDICATED_REVERSE
  *
  * Disables wake-up interrupt conditionally based on status.
- * Should be only called from rpm_suspend() and rpm_resume() path.
  */
 void dev_pm_disable_wake_irq_check(struct device *dev, bool cond_disable)
 {
@@ -328,8 +324,6 @@ void dev_pm_disable_wake_irq_check(struct device *dev, bool cond_disable)
  * Enable wake IRQ conditionally based on status, mainly used if want to
  * enable wake IRQ after running ->runtime_suspend() which depends on
  * WAKE_IRQ_DEDICATED_REVERSE.
- *
- * Should be only called from rpm_suspend() path.
  */
 void dev_pm_enable_wake_irq_complete(struct device *dev)
 {
-- 
2.34.1


