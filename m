Return-Path: <linux-pm+bounces-26209-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B448A9C752
	for <lists+linux-pm@lfdr.de>; Fri, 25 Apr 2025 13:22:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 765A91BC5596
	for <lists+linux-pm@lfdr.de>; Fri, 25 Apr 2025 11:22:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3682259C89;
	Fri, 25 Apr 2025 11:18:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=antheas.dev header.i=@antheas.dev header.b="YIE2x61x"
X-Original-To: linux-pm@vger.kernel.org
Received: from linux1587.grserver.gr (linux1587.grserver.gr [185.138.42.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F6F0258CE7;
	Fri, 25 Apr 2025 11:18:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.138.42.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745579931; cv=none; b=fFwkGZ94hPjnvMUqCCO0Lx967bOAwe5kw0OKfZPKKDcNGgM7S+7jVMG/xpdWr7vm4ZvINDQVGMZ2HCNsMRHF1YASFhZrSY9snV/cycH3m/d4Rs5RJE2tZVqA+UkAlTNTxFS8uY8XeG0u5GR4llZ5tZvRNjcWNK2hg+DCxFvqtJw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745579931; c=relaxed/simple;
	bh=pkeS98euH30dOGfG1+dOVA0/1dKYBGZgUZN07dZ0H+4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HTqPz2ODNOYuB0KJOpLyYCb61OF/ZWaaoGaJY29gH1av50Q8PyqdlX1Ot+ulXAPlIkkeGfPdMj/MS/aFmGm4qS5Au+tdd/XILXx6MoyP15R2w7Dl7C24U9auWfE7eKiwygDD126cgUaXOSfKWVE3kbnEWptYomkJe+eR8SdB1P0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=antheas.dev; spf=pass smtp.mailfrom=antheas.dev; dkim=pass (1024-bit key) header.d=antheas.dev header.i=@antheas.dev header.b=YIE2x61x; arc=none smtp.client-ip=185.138.42.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=antheas.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=antheas.dev
Received: from localhost.localdomain (unknown [IPv6:2a02:2149:8a3b:5a00:3490:6581:3910:8337])
	by linux1587.grserver.gr (Postfix) with ESMTPSA id E95A12E08E62;
	Fri, 25 Apr 2025 14:18:46 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=antheas.dev;
	s=default; t=1745579928;
	bh=DWjWW+uNRKRGl5pgiRex0CDUsiqQn/RmxukuWZy+SwA=; h=From:To:Subject;
	b=YIE2x61x0iYPVxSciPYml29JTIC4f8nxoD2Gd4HI+2UY9FNK+TZY83nXjFWxU1/5w
	 8ONx1PP/grLkNNfrKZH+e06L44CJkL62g8x9SuroUV/RW5pV8cjwXpuu9uDyRb4jZf
	 d3bxiR/HZuRaAZ4E2YJjrmXTqYB1Gw6aGDKTaAeU=
Authentication-Results: linux1587.grserver.gr;
	spf=pass (sender IP is 2a02:2149:8a3b:5a00:3490:6581:3910:8337) smtp.mailfrom=lkml@antheas.dev smtp.helo=localhost.localdomain
Received-SPF: pass (linux1587.grserver.gr: connection is authenticated)
From: Antheas Kapenekakis <lkml@antheas.dev>
To: platform-driver-x86@vger.kernel.org
Cc: linux-hwmon@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-pm@vger.kernel.org,
	Guenter Roeck <linux@roeck-us.net>,
	Jean Delvare <jdelvare@suse.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Joaquin Ignacio Aramendia <samsagax@gmail.com>,
	Derek J Clark <derekjohn.clark@gmail.com>,
	Kevin Greenberg <kdgreenberg234@protonmail.com>,
	Joshua Tam <csinaction@pm.me>,
	Parth Menon <parthasarathymenon@gmail.com>,
	Eileen <eileen@one-netbook.com>,
	linux-kernel@vger.kernel.org,
	sre@kernel.org,
	linux@weissschuh.net,
	ilpo.jarvinen@linux.intel.com,
	hdegoede@redhat.com,
	mario.limonciello@amd.com,
	Antheas Kapenekakis <lkml@antheas.dev>
Subject: [PATCH v10 15/16] platform/x86: oxpec: Rename rval to ret in
 tt_toggle
Date: Fri, 25 Apr 2025 13:18:20 +0200
Message-ID: <20250425111821.88746-16-lkml@antheas.dev>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250425111821.88746-1-lkml@antheas.dev>
References: <20250425111821.88746-1-lkml@antheas.dev>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-PPP-Message-ID: 
 <174557992781.23293.12127681747810270918@linux1587.grserver.gr>
X-PPP-Vhost: antheas.dev
X-Virus-Scanned: clamav-milter 0.103.11 at linux1587.grserver.gr
X-Virus-Status: Clean

Rename the variable `rval` to `ret` in the function for consistency.

Signed-off-by: Antheas Kapenekakis <lkml@antheas.dev>
---
 drivers/platform/x86/oxpec.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/platform/x86/oxpec.c b/drivers/platform/x86/oxpec.c
index d71ff189bafef..692a6d6d08316 100644
--- a/drivers/platform/x86/oxpec.c
+++ b/drivers/platform/x86/oxpec.c
@@ -406,19 +406,19 @@ static ssize_t tt_toggle_store(struct device *dev,
 			       size_t count)
 {
 	bool value;
-	int rval;
+	int ret;
 
-	rval = kstrtobool(buf, &value);
-	if (rval)
-		return rval;
+	ret = kstrtobool(buf, &value);
+	if (ret)
+		return ret;
 
 	if (value) {
-		rval = tt_toggle_enable();
+		ret = tt_toggle_enable();
 	} else {
-		rval = tt_toggle_disable();
+		ret = tt_toggle_disable();
 	}
-	if (rval)
-		return rval;
+	if (ret)
+		return ret;
 
 	return count;
 }
-- 
2.49.0


