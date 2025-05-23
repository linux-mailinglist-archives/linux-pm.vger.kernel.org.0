Return-Path: <linux-pm+bounces-27572-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CAAA4AC2446
	for <lists+linux-pm@lfdr.de>; Fri, 23 May 2025 15:43:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D6A8AA45323
	for <lists+linux-pm@lfdr.de>; Fri, 23 May 2025 13:42:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0AF9296171;
	Fri, 23 May 2025 13:41:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="tA6Wkz71"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com [209.85.167.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3A49296149
	for <linux-pm@vger.kernel.org>; Fri, 23 May 2025 13:41:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748007662; cv=none; b=puXUguKWiU4x8svz/Geh+/NHONMHEgxWWfMNK9CEL2XA5EYWDl98ZK0PqddP3QshXm+cjQ2wPHYThgka14xoTmqYk2EGeLrWnh4Z/B4Fmxv0r6d6A6xYlTktcxHHLBSuCzX82aDKrZeCQo+d91+5coKf+R454fjdtmUssJBFCME=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748007662; c=relaxed/simple;
	bh=IbI4P7dKS7WQ0XrlPSF2t8HlO3jco/Xh1Hv9yYR/Iy4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eBfp6/686TU250lk//SzbIBxaLG2jOUxjIqjRkb+Es5LYnfkbNNsYyIP0L2G83UWhnKZMDzqIq3gXGteS29oEYdy2dwQN8A8NOi+sJ0A3dPgslRssDMxCZoAEEXLoPPvrbmXbQLfnhezB3YLm33Nm8RoflIwDanyqtYGUT6j1w4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=tA6Wkz71; arc=none smtp.client-ip=209.85.167.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-54d6f93316dso11146838e87.2
        for <linux-pm@vger.kernel.org>; Fri, 23 May 2025 06:41:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1748007659; x=1748612459; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=z5aEp/8JtU93ixaErAVWqgNJDOtLrawJ3jNzY/478Oc=;
        b=tA6Wkz71avfc9s5Q6WJ4IBmdOP3IlHKiAO9Lx4A+485OsgaL7fAMHfnT3OzDk7R5Mx
         XBmpc6H9loiev3lw6X/ZVj8hKXsVEBt9WJpATlBTwk2Yo2spWZt/Os2qPq0tb8MSt349
         0br6dXKpO0EOyT3j2TT3OI4UKew3tq+sxJo7nOLaaScTr4Mytl3BFhmk0UyKOCoUYvS8
         npIEGHSHKDhxiD//W2gT7k0ffNWV6DmTcCFY++/7UqHog49PU7sfwdVt2pr9fq86afV8
         yd8uKHYWb23sl75lNqXRV8Q9+YPDwW3D0OdQcZ1KAIC25xtvugiZVlaOhi3M5WIooJHG
         p0DA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748007659; x=1748612459;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=z5aEp/8JtU93ixaErAVWqgNJDOtLrawJ3jNzY/478Oc=;
        b=kXhlwvRoTTzX4odKDxF9lZo0pY3RmVXmNiy0OOcbyIWnc9wJ5C2mTkw5hGCYihCpOu
         H84XynZ0pgMOiw9dgO86uuW7e1EzgFUnJ7wYg1Wf5DuZtjy882Z1XYPxxc5p6/wcXZqp
         EGZKC6MtJXf4x+6ixXdWnNFt8iP4KvYL04mgNnx6525p5/JQJZO4qCzENHi5oXo8MJ4G
         6E5fMO2Yn9PGmIO9Icici1QhA2n5Tf4KmbJjZ9HpwZBHJwpLRQMe+RZ+L8OklBhhW4wj
         2HaN19ewQA9KImtwxICZE2Cb+h5eXieocML9oTuAicsMh3MQ6o0uMyA1mG3gTSAhDXrt
         03Kw==
X-Forwarded-Encrypted: i=1; AJvYcCV6a2CkE9MPtP/Pwwzh22IaZZOOYknAkj68TIf8IO17yR2LFpFoCkjhA9+fiP04GeXWeUrXwi/+RA==@vger.kernel.org
X-Gm-Message-State: AOJu0YyPXZdbzdAMA64nPjZxfWwX3lVjECuf0GMDZevReSEZPNy8w9Ou
	/S8x6ELuXVWPr9KrutE+gCt0sywkWsI6D72ycxNqrEsTFvfcfm9nqPr9E3+NPnzAP6a7jbsU+/F
	vSPK5EUQ=
X-Gm-Gg: ASbGncvB+bHqR4+boqnIqqbQnS9tk2lWohEI6IUK+dE/xctl6adK2cgbPsLShkQRcq9
	4S4+5+8MkSWlO5A+zCXponWwY3MIxnvyf65kVOE4vKsNiXK59iS/0nLUnR+5lmywsyacZkMkC1L
	D7byBIqPrWhANVKtUlM5EH6ZQAIsbjkCYlOfLMXvkD0kbNhYDIlzvoT2L4EXaqr1MPDdEfkWLzS
	3QE54F0A4mdC9bm0YHqtDsSXsqG54oIceISSRJphMU53VOcr2pfN2z48vMx76dReR+p/CdYkleK
	K0sya8otCekSiXlXwFbTJ5NE8tD2UlfVEu5jVncS+e7AtnrfA9ckHvfWnbM0pybn7muZrHhlvEw
	avyhQuoOewdeyPQt14ofhhXWzyz5M1w+wSOmX
X-Google-Smtp-Source: AGHT+IHew3rJAA3EL1rPz5CTB3uwQqlEQeWho80HyKc1TwZE2NDcF2OqAfkY0OELPgTm0zJ+F3OM6w==
X-Received: by 2002:a05:6512:1196:b0:550:e3de:63bc with SMTP id 2adb3069b0e04-55216e456acmr896941e87.25.1748007658748;
        Fri, 23 May 2025 06:40:58 -0700 (PDT)
Received: from uffe-tuxpro14.. (h-178-174-189-39.A498.priv.bahnhof.se. [178.174.189.39])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-551fc0d473bsm1950609e87.244.2025.05.23.06.40.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 May 2025 06:40:58 -0700 (PDT)
From: Ulf Hansson <ulf.hansson@linaro.org>
To: Saravana Kannan <saravanak@google.com>,
	Stephen Boyd <sboyd@kernel.org>,
	linux-pm@vger.kernel.org
Cc: "Rafael J . Wysocki" <rafael@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Michael Grzeschik <m.grzeschik@pengutronix.de>,
	Bjorn Andersson <andersson@kernel.org>,
	Abel Vesa <abel.vesa@linaro.org>,
	Peng Fan <peng.fan@oss.nxp.com>,
	Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>,
	Johan Hovold <johan@kernel.org>,
	Maulik Shah <maulik.shah@oss.qualcomm.com>,
	Michal Simek <michal.simek@amd.com>,
	Konrad Dybcio <konradybcio@kernel.org>,
	Thierry Reding <thierry.reding@gmail.com>,
	Jonathan Hunter <jonathanh@nvidia.com>,
	Ulf Hansson <ulf.hansson@linaro.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 12/21] firmware: xilinx: Don't share zynqmp_pm_init_finalize()
Date: Fri, 23 May 2025 15:40:09 +0200
Message-ID: <20250523134025.75130-13-ulf.hansson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250523134025.75130-1-ulf.hansson@linaro.org>
References: <20250523134025.75130-1-ulf.hansson@linaro.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

As there no longer any users outside the zynqmp firmware driver of
zynqmp_pm_init_finalize(), let's turn into a local static function.

Cc: Michal Simek <michal.simek@amd.com>
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---
 drivers/firmware/xilinx/zynqmp.c     | 3 +--
 include/linux/firmware/xlnx-zynqmp.h | 6 ------
 2 files changed, 1 insertion(+), 8 deletions(-)

diff --git a/drivers/firmware/xilinx/zynqmp.c b/drivers/firmware/xilinx/zynqmp.c
index a91a0191c689..87ddbb7d11c2 100644
--- a/drivers/firmware/xilinx/zynqmp.c
+++ b/drivers/firmware/xilinx/zynqmp.c
@@ -1299,11 +1299,10 @@ EXPORT_SYMBOL_GPL(zynqmp_pm_bootmode_write);
  * This API function is to be used for notify the power management controller
  * about the completed power management initialization.
  */
-int zynqmp_pm_init_finalize(void)
+static int zynqmp_pm_init_finalize(void)
 {
 	return zynqmp_pm_invoke_fn(PM_PM_INIT_FINALIZE, NULL, 0);
 }
-EXPORT_SYMBOL_GPL(zynqmp_pm_init_finalize);
 
 /**
  * zynqmp_pm_set_suspend_mode()	- Set system suspend mode
diff --git a/include/linux/firmware/xlnx-zynqmp.h b/include/linux/firmware/xlnx-zynqmp.h
index 6d4dbc196b93..ae48d619c4e0 100644
--- a/include/linux/firmware/xlnx-zynqmp.h
+++ b/include/linux/firmware/xlnx-zynqmp.h
@@ -585,7 +585,6 @@ int zynqmp_pm_reset_assert(const u32 reset,
 int zynqmp_pm_reset_get_status(const u32 reset, u32 *status);
 unsigned int zynqmp_pm_bootmode_read(u32 *ps_mode);
 int zynqmp_pm_bootmode_write(u32 ps_mode);
-int zynqmp_pm_init_finalize(void);
 int zynqmp_pm_set_suspend_mode(u32 mode);
 int zynqmp_pm_request_node(const u32 node, const u32 capabilities,
 			   const u32 qos, const enum zynqmp_pm_request_ack ack);
@@ -746,11 +745,6 @@ static inline int zynqmp_pm_bootmode_write(u32 ps_mode)
 	return -ENODEV;
 }
 
-static inline int zynqmp_pm_init_finalize(void)
-{
-	return -ENODEV;
-}
-
 static inline int zynqmp_pm_set_suspend_mode(u32 mode)
 {
 	return -ENODEV;
-- 
2.43.0


