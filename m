Return-Path: <linux-pm+bounces-17516-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 50DDB9C7B49
	for <lists+linux-pm@lfdr.de>; Wed, 13 Nov 2024 19:35:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0298E1F23A07
	for <lists+linux-pm@lfdr.de>; Wed, 13 Nov 2024 18:35:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E6BE15ADA4;
	Wed, 13 Nov 2024 18:35:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XaE8uu4D"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-qv1-f54.google.com (mail-qv1-f54.google.com [209.85.219.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D7881FAC53
	for <linux-pm@vger.kernel.org>; Wed, 13 Nov 2024 18:35:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731522949; cv=none; b=tRNjQtTu9QCsHRK90i1jKwt2Mj7ywo/r1W8MInu5hDF4MYuhBwrI1U7lIzI5N40x50ULQdRIoN/xhZfs6tv8OrQbPs2jHVPOTVrv8k3pqsQVvN+aZOpkl6kHja9GCGviof9GeHHO3JK5FW8/eEmWfFUB53GWZyOneeqfm5jtNjk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731522949; c=relaxed/simple;
	bh=2ieX/nf5103zj+IxTmmYyPq/rZR5A9Dpq/DDcyvJPc4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=niwu4aYYdU8/RtqQciHZH4TJK06BslnnvjWKIlmZLHlE84Hbkf2aJ7LW58qX4CE1UvBHCeImFrvSx9Mvglg5wICD3KQNosMz3FVvadGOwNCaIDEZP+hGYgfapbnT+OqZ3Mba9hkYQjztQEBLtZ7PJjAjvgzPccMzZ5DHFZECbLQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XaE8uu4D; arc=none smtp.client-ip=209.85.219.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f54.google.com with SMTP id 6a1803df08f44-6cc1b20ce54so49539286d6.0
        for <linux-pm@vger.kernel.org>; Wed, 13 Nov 2024 10:35:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731522946; x=1732127746; darn=vger.kernel.org;
        h=content-transfer-encoding:organization:reply-to:mime-version
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tFfHfLPOeTgGZOrSgEI1FNXgVOvvg8WE6m0X/mw8zps=;
        b=XaE8uu4DwFsr0Zjd3ahLIba1YBg8I2BhRFciJZsh4ttblYlThdoK/DuiHyOuCVnd9D
         bd+fVRlb7zYB6gKemTGPIHKBDp+3jzg0oyyE9zDJV05cRpa6HP+QYRFJ47hxc/We5VJz
         lpValy/ftOpmgnKlxFIh4gEgWghyOo8Cn87k+ojkBd0N1IOIW0ZI22VBKh23J3fbswFm
         JuW5URuxcJa/zuvKUQuGIP27bBjRU9bd7C0rsrG2dVLra97wrpC3X8QAOZ9V43qhy8ys
         TShBZCaxu4dOD1BwH0+oyZpmRZ51eR5HYW31AAlcUPksFpJ4bqZ1fieqbg9j5r19wYTH
         e4qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731522946; x=1732127746;
        h=content-transfer-encoding:organization:reply-to:mime-version
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=tFfHfLPOeTgGZOrSgEI1FNXgVOvvg8WE6m0X/mw8zps=;
        b=Ud/td55m3RE6PH7D7C+O0GNZU5YGJp9OMUqG5nF0fCjsWVev0lSB1qHoxS8SpE6yR4
         F1VBxUhRSk7FiEZuEU0fuHhDzoLFG66u7WcTeCH7uO8K6LrxF35vEZVOhUrlKyzpRKA0
         XZ2vI069dEe+cTmcpMtFbvjYPAKwtYzLXasCTUNMZVx1uBcu698Jtanxe3vJZrCzhhaq
         epgYtm6yNrUWVGi4W3apdoWaU2h6r+LAXsXEgdR6xrThoLoY3FbWE6B4MWcx2uxrYxe8
         MwpMgv4/GIKWo0oQipcvjMS+f8FUUzcy4tTRqnuD7GNnH6mnJONN947sBnXeBOOajQYs
         nHpg==
X-Gm-Message-State: AOJu0YyvsUOEanPGXoRTsUG+MhEw+XWDW5xvptgaMldn73hyw5hGoihe
	NE2cEsAenQSvI318jqHHrdLqW0KK25nCXmaFwEnKFhycl39kpbHgD6tW+w==
X-Google-Smtp-Source: AGHT+IGQFlqMXOZ4PMWWCKXZND5Fk9YOFog1kwTincfvgADakYxvGNiYPe2jRyptv+fMOXaSreqtZg==
X-Received: by 2002:a05:6214:310e:b0:6d1:85a7:3cc0 with SMTP id 6a1803df08f44-6d39e112815mr309429166d6.12.1731522946296;
        Wed, 13 Nov 2024 10:35:46 -0800 (PST)
Received: from lenb-Thinkpad-T16-Gen-3.mynetworksettings.com ([2600:1006:a022:33ba:f867:9203:71bc:12b5])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6d3961df8edsm87888126d6.8.2024.11.13.10.35.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Nov 2024 10:35:45 -0800 (PST)
Sender: Len Brown <lenb417@gmail.com>
From: Len Brown <lenb@kernel.org>
To: rafael@kernel.org
Cc: linux-pm@vger.kernel.org
Subject: [RFC/RFT PATCH] PM: sleep: Ignore device driver suspend() callback return values
Date: Wed, 13 Nov 2024 13:35:35 -0500
Message-ID: <7e3092234617e8479d3020e5fed7ff47ac750014.1731522552.git.len.brown@intel.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Reply-To: Len Brown <lenb@kernel.org>
Organization: Intel Open Source Technology Center
Content-Transfer-Encoding: 8bit

From: Len Brown <len.brown@intel.com>

Drivers commonly return non-zero values from their suspend()
callbacks due to transient errors, not realizing that doing so
aborts system-wide suspend.

Ignore those return values.

Both before and after this patch, the correct method for a
device driver to abort system-wide suspend is to invoke
pm_system_wakeup() during the suspend flow.

Legacy behaviour can be restored by adding this line to your .config:
CONFIG_PM_SLEEP_LEGACY_CALLBACK_ABORT=y

Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/base/power/main.c |  4 ++++
 kernel/power/Kconfig      | 14 ++++++++++++++
 2 files changed, 18 insertions(+)

diff --git a/drivers/base/power/main.c b/drivers/base/power/main.c
index 4a67e83300e1..56b7c9c752b4 100644
--- a/drivers/base/power/main.c
+++ b/drivers/base/power/main.c
@@ -1678,7 +1678,11 @@ static int device_suspend(struct device *dev, pm_message_t state, bool async)
 		callback = pm_op(dev->driver->pm, state);
 	}
 
+#if CONFIG_PM_SLEEP_LEGACY_CALLBACK_ABORT
 	error = dpm_run_callback(callback, dev, state, info);
+#else
+	dpm_run_callback(callback, dev, state, info);
+#endif
 
  End:
 	if (!error) {
diff --git a/kernel/power/Kconfig b/kernel/power/Kconfig
index afce8130d8b9..51b5d6c9bf1a 100644
--- a/kernel/power/Kconfig
+++ b/kernel/power/Kconfig
@@ -141,6 +141,20 @@ config PM_SLEEP
 	depends on SUSPEND || HIBERNATE_CALLBACKS
 	select PM
 
+config PM_SLEEP_LEGACY_CALLBACK_ABORT
+	def_bool n
+	depends on PM_SLEEP
+	help
+	This option enables the legacy API for device .suspend() callbacks.
+	That API empowered any driver to abort system-wide suspend
+	by returning any non-zero value from its .suspend() callback.
+	In practice, these aborts are almost always spurious and unwanted.
+
+	Disabling this option (default) ignores .suspend() callback return values.
+
+	In both cases, any driver can abort system wide suspend by invoking
+	pm_system_wakeup() during the suspend flow.
+
 config PM_SLEEP_SMP
 	def_bool y
 	depends on SMP
-- 
2.43.0


