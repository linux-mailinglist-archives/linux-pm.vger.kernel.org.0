Return-Path: <linux-pm+bounces-4443-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DBF088697CB
	for <lists+linux-pm@lfdr.de>; Tue, 27 Feb 2024 15:25:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7DDA91F2B23D
	for <lists+linux-pm@lfdr.de>; Tue, 27 Feb 2024 14:25:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C216213A26F;
	Tue, 27 Feb 2024 14:25:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="TgziO8wi"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AB0613B2B8;
	Tue, 27 Feb 2024 14:25:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709043906; cv=none; b=Roq8ucT7CWae5Q/xJrd9f9ifhqCbO8sqOk1M+jPGOy+/9iSNdBImZYbwPkuGct1Px8F44an6nPmJlslvnlZL+W/lBnuQMPpG8HrmkoxCKRMtT7CtNkxjk7+T71Gr8NC8fy5G/u9ddOIyemSObOYxOI4LT4FnSvMaxAO+VgRa6Os=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709043906; c=relaxed/simple;
	bh=CKUCtjYyRgbPt2ohqgqJoET8BcdlH3+L17nxccHyu3U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hS2wU7yq1hOQ2cQRjNS9Z9RIm4yyx/xZhBV+F1q0n/qZtZd4GbiBJ99l3nlSZGQH4nxGAHI9ibnfGve8oAWjYzh/cMB4pCMO2Ag/Xz85v5gyE1EQUBaZ0WDCGv7nhAViSmUeEW1ifoyw8VUnq0Kts1LyK7g7YPMFg0xophyJkko=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=TgziO8wi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A60BDC433F1;
	Tue, 27 Feb 2024 14:25:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1709043906;
	bh=CKUCtjYyRgbPt2ohqgqJoET8BcdlH3+L17nxccHyu3U=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=TgziO8wimjYCM3DMUxWwv2loX0SuoX8K1tSSubX/MIPQNPvuSoiq+EpLvt4+jC6bt
	 u7eyAaISrF3/3KhNAtxA6oNeG/CLP8OqmBXbcAAJNLmrWVrbU4btvmotIAjdqoYnFS
	 Ai+2PmFIiFua/vhmOV3OWX4uqn0HKPJ7sOQKSmbc=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	linux-pm@vger.kernel.org,
	Linus Walleij <linus.walleij@linaro.org>,
	Thierry Reding <treding@nvidia.com>,
	Mark Brown <broonie@kernel.org>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Bjorn Andersson <bjorn.andersson@linaro.org>,
	Saravana Kannan <saravanak@google.com>,
	Todd Kjos <tkjos@google.com>,
	Len Brown <len.brown@intel.com>,
	Pavel Machek <pavel@ucw.cz>,
	Ulf Hansson <ulf.hansson@linaro.org>,
	Kevin Hilman <khilman@kernel.org>,
	"Rafael J. Wysocki" <rjw@rjwysocki.net>,
	Rob Herring <robh@kernel.org>,
	"Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
	John Stultz <john.stultz@linaro.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.4 39/84] driver core: Set deferred_probe_timeout to a longer default if CONFIG_MODULES is set
Date: Tue, 27 Feb 2024 14:27:06 +0100
Message-ID: <20240227131554.144760148@linuxfoundation.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240227131552.864701583@linuxfoundation.org>
References: <20240227131552.864701583@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

5.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: John Stultz <john.stultz@linaro.org>

[ Upstream commit e2cec7d6853712295cef5377762165a489b2957f ]

When using modules, its common for the modules not to be loaded
until quite late by userland. With the current code,
driver_deferred_probe_check_state() will stop returning
EPROBE_DEFER after late_initcall, which can cause module
dependency resolution to fail after that.

So allow a longer window of 30 seconds (picked somewhat
arbitrarily, but influenced by the similar regulator core
timeout value) in the case where modules are enabled.

Cc: linux-pm@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Linus Walleij <linus.walleij@linaro.org>
Cc: Thierry Reding <treding@nvidia.com>
Cc: Mark Brown <broonie@kernel.org>
Cc: Liam Girdwood <lgirdwood@gmail.com>
Cc: Bjorn Andersson <bjorn.andersson@linaro.org>
Cc: Saravana Kannan <saravanak@google.com>
Cc: Todd Kjos <tkjos@google.com>
Cc: Len Brown <len.brown@intel.com>
Cc: Pavel Machek <pavel@ucw.cz>
Cc: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Kevin Hilman <khilman@kernel.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Rob Herring <robh@kernel.org>
Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>
Reviewed-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Signed-off-by: John Stultz <john.stultz@linaro.org>
Link: https://lore.kernel.org/r/20200225050828.56458-3-john.stultz@linaro.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/base/dd.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/base/dd.c b/drivers/base/dd.c
index 7941a8fd22841..0b97a0c96baa3 100644
--- a/drivers/base/dd.c
+++ b/drivers/base/dd.c
@@ -224,7 +224,16 @@ static int deferred_devs_show(struct seq_file *s, void *data)
 }
 DEFINE_SHOW_ATTRIBUTE(deferred_devs);
 
+#ifdef CONFIG_MODULES
+/*
+ * In the case of modules, set the default probe timeout to
+ * 30 seconds to give userland some time to load needed modules
+ */
+static int deferred_probe_timeout = 30;
+#else
+/* In the case of !modules, no probe timeout needed */
 static int deferred_probe_timeout = -1;
+#endif
 static int __init deferred_probe_timeout_setup(char *str)
 {
 	int timeout;
-- 
2.43.0




