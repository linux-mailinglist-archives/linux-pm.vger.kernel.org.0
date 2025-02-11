Return-Path: <linux-pm+bounces-21789-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A80CA3063D
	for <lists+linux-pm@lfdr.de>; Tue, 11 Feb 2025 09:48:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CA1D3188A14F
	for <lists+linux-pm@lfdr.de>; Tue, 11 Feb 2025 08:48:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D2B91F1508;
	Tue, 11 Feb 2025 08:47:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="J9/W9nvM"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 965E31F130B
	for <linux-pm@vger.kernel.org>; Tue, 11 Feb 2025 08:47:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739263649; cv=none; b=fKtY0U8FGL2lHUD+k9FsZ6uSATsbdR9XLfJaL9wCgcLA/NUyZHXgAn7rvvDURsQmVIiXVZNUjy1islF9jM9XDkIpMmV1m9BiISE8iSq05cdGzNLtK8u3tNlPEdUVD582ea//sPuwty95gA7oE45PPUdEcEFATWXunOM4hBPyrlU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739263649; c=relaxed/simple;
	bh=lsQsxt3jC7eSYnAHErAb9c4bvY2EszddZcM7R8tGZL4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=rhP1G3f6/0uv5D0OKLtCdnIgiZt76ei7zVVkKuKQpoKSZy0kZJXx56VgeTTZT63cMtribWMtGDbu13t77Atsd72hOrB4DtxqxmFsFFon5jycSsLGsqcryezRnagO55NkOeMXwL6+nCQclSF0eia3Yenw9T2d/Y6RDmgMMPGbs1o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=J9/W9nvM; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-38dd93a6f0aso1723838f8f.0
        for <linux-pm@vger.kernel.org>; Tue, 11 Feb 2025 00:47:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1739263646; x=1739868446; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Z3tPhQCrqohb5pEP4atj6WNboBz6QHyb9ufOc2FgGgE=;
        b=J9/W9nvMBMZ3KglbCvHjZkbgUzqzc/gKQraZhcE5ovZSg9pS+Zx08pPKnMQxWZ2bUz
         LW7iGvlg3YJqVSEEGONYf354d/3I7T5PpgAXewUtOmWn5Cx9JoXIHOpr5FMI/83+0Uc1
         96H0EgCkOSVBFeEvD1GRyD4Sm6F2DPUsC7RI2Rl0qa/8AoEvO+efYsxtWQBcUu7lMB8S
         C/gykDTaPLbPkqHKthZ3ZACjeJNcIn6h/E/fsdAiKxGMlrq5e2//IWePSEw9BFiSbEjV
         8AZrRrHXaGfmd02mFADkS5OGQswr/oWGk/ZbvKiGsd3XX0vcAme8HptLFvfNsh1sZywC
         Cy+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739263646; x=1739868446;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Z3tPhQCrqohb5pEP4atj6WNboBz6QHyb9ufOc2FgGgE=;
        b=YgG3tin+X9QdI94ixrgyLpOfJQ5cDBskomt4QP+u1DElW5EF9+x2KqQH0SW5WlIMbx
         U5n1W+5p+j/ddCJNSQjx9l6SS04DUNDdR+VbZ7bKsTBfM/+mEXH4lvwK4FnD7ZO1gPp/
         DVfEBf+sSKo3zUSsCwFNQyrw3ZD5DjPd6EZ9MBESC++GS53+4qBD4PFHgZsIL/UtT82G
         RA4G8FWm7xWJfFaRAOrFAat7ScIiyLKf0NBednXovFnltB+iuJhoPAe3AKNIYFr/MQeJ
         K2ugaqfwb0cYc0GQwSh9Eri+KbFRsNZV5UD2s365h5nrlC8Kwoy6R9+wXM3EQdCAfsFT
         vS0A==
X-Gm-Message-State: AOJu0Yz3LhHdQNrYMhcrN14sVQxL57cvWXSfYF9YPGMnVHFtgmtIKIp9
	VTRFzJFM9mhyZlm+WZVTokzV4kgV2OCbX+B/NriiIGTmnd/SpPp5VPn0aa1QdvU=
X-Gm-Gg: ASbGncvrqMatuUKooTS+f3ibEWn4kRX+L9xBsNIIp0zD5OdeHryrQAIsp5TQMmW/Ulv
	Laz77NB0ea9lG8njO8K0jYkURSTTkBut7Gnzf/Mq3/XHKx9fw2QRiBm2TkA1nMRlYqe0cLh5edT
	WcrU5+n+rRjqNXpoDo4/2uq90OMBz9XMQfLUvdcjZ1r4hxRcudfYnLwPNFeaL75wZ+ROiHyYtWJ
	PsMrrrmN3GFIQgwwuz6evoeM+tjFHp3HnjflwFak+VJYv6fRjePn+6RjCwU9GLOD0xqIMarCWin
	oTYNDWKQsv7eKXWRDRz57qh1jXH+ok4L+HY9Wa6viA==
X-Google-Smtp-Source: AGHT+IHzi4hXtgJoSboZKLN6rDPfc5Fnmu4EC3F+osoM8bpO9/QfCSsFAe4L/Q9uimeL0Q0hCKWSbQ==
X-Received: by 2002:a5d:5f83:0:b0:386:2d40:a192 with SMTP id ffacd0b85a97d-38dc9343f5bmr12570682f8f.34.1739263645843;
        Tue, 11 Feb 2025 00:47:25 -0800 (PST)
Received: from mai.. (146725694.box.freepro.com. [130.180.211.218])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38dbde1dfaesm14431779f8f.90.2025.02.11.00.47.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Feb 2025 00:47:25 -0800 (PST)
From: Daniel Lezcano <daniel.lezcano@linaro.org>
To: rjw@rjwysocki.net,
	daniel.lezcano@linaro.org
Cc: linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	kernel test robot <lkp@intel.com>,
	Amit Daniel Kachhap <amit.kachhap@gmail.com>,
	Viresh Kumar <viresh.kumar@linaro.org>,
	Lukasz Luba <lukasz.luba@arm.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Zhang Rui <rui.zhang@intel.com>
Subject: [PATCH] thermal/cpufreq_cooling: Remove structure member documentation
Date: Tue, 11 Feb 2025 09:47:11 +0100
Message-ID: <20250211084712.2746705-1-daniel.lezcano@linaro.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The structure member documentation refers to a member which does no
longer exist. Remove it.

Link: https://lore.kernel.org/all/202501220046.h3PMBCti-lkp@intel.com/
Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202501220046.h3PMBCti-lkp@intel.com/
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 drivers/thermal/cpufreq_cooling.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/thermal/cpufreq_cooling.c b/drivers/thermal/cpufreq_cooling.c
index 280071be30b1..6b7ab1814c12 100644
--- a/drivers/thermal/cpufreq_cooling.c
+++ b/drivers/thermal/cpufreq_cooling.c
@@ -57,8 +57,6 @@ struct time_in_idle {
  * @max_level: maximum cooling level. One less than total number of valid
  *	cpufreq frequencies.
  * @em: Reference on the Energy Model of the device
- * @cdev: thermal_cooling_device pointer to keep track of the
- *	registered cooling device.
  * @policy: cpufreq policy.
  * @cooling_ops: cpufreq callbacks to thermal cooling device ops
  * @idle_time: idle time stats
-- 
2.43.0


