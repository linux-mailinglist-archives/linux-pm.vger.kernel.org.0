Return-Path: <linux-pm+bounces-33571-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id ED35EB3E939
	for <lists+linux-pm@lfdr.de>; Mon,  1 Sep 2025 17:15:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 47F1E168B96
	for <lists+linux-pm@lfdr.de>; Mon,  1 Sep 2025 15:11:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B6D135FC2A;
	Mon,  1 Sep 2025 15:07:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NgkTCjTf"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75A613469F6;
	Mon,  1 Sep 2025 15:06:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756739220; cv=none; b=j92MXAVTnn3iSYmGx5sXfXyQF1BLFWHGjDgU6vA90p2c9FJGz4VhhofY7H8GXUnZTN+bLXGmP/WF9k9ZOT0DykeUwLkJlndtW928zGKN4PxZKAcXd/hLaKM7Ss5EWmzkKhpfKACt/jbiwvwJHLPLvlxGztsrvJ9h8aQYQCLzeug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756739220; c=relaxed/simple;
	bh=kjh5m9ENcO9Hi86ewMxMejx4Tal5b62aJq3jkDb1rKM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=u2xP84alSaMtLtweBBbmKgYHHqKJ2rBXwaMee3xceG4sTUqt2gyCzlqvhs0gPbjijsgu31N7y+kb23fNXqBUvIWnKdpDPm7YftssmVWNxct3lPFetoNr7lmVLqnlB87Y0wblFloxCoM8w92MI1OpJul2Rx3TkpoKFg6/+LNhkzI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NgkTCjTf; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-b0225483ca0so335916366b.2;
        Mon, 01 Sep 2025 08:06:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756739217; x=1757344017; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=gwLLHhAsjuOZ44ww25jflYPhn7E0Ibrm6VPCLuRVr1U=;
        b=NgkTCjTfMNmEjxoff+sWy5bS3FF2u1NNFM9weHA9I8TiSyzXA4+LnC/c6imZeuwoWz
         Q9UWOS+nqntvjuP+1F7Cq0s9IlEVRSNpD/qmbda0zSZNi5J8u/5pkLm4nZYkDGx4sw7V
         EvPBa2Bd1MSplFHRp3ZX0ZgLpYqrse//y+U6mmqjq+1OqtdVxNMvu1g27Kxze22Q/Ivh
         wNczassKpC5ZrR+l+gDX1WLhUKy3SmCm5bfvBrqdwehE0F9ZFR1a9VgvERraqcADxG6X
         NXLREhK0fWZ9Wvox95TMmXTHb+RiU/f/X9QXiYqfi2eiwmakY9dV4y4/Qa/t2WwWEBdw
         DQag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756739217; x=1757344017;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gwLLHhAsjuOZ44ww25jflYPhn7E0Ibrm6VPCLuRVr1U=;
        b=pUKso4vdvu8wgtq3piS2zo2pS11pb7InYeY2DoSXqG3jTE5+5cc8nMJSdFRrcrMJ3g
         KGfAImMNQXMeSNt1TSpIXdDCITvcOoFImhdQNVLGVHKYjUTp0Bh7xbH0Cwq2PA73VtQ9
         EKzRMgfGHgp7sw9IYxQHYP8jpTqfgjAPYZUpGl/WscKAWaH4mg64vug3czUt+zAuutPl
         BH3noF2vQakIBOfubqXdHeEYZnCtj+1V/+X9uFOGIDEnIxBTbTGbhehJue8Dbpboq92d
         ZpOROIVaaT8wjQu7iHP1YCyPrHh0Sd1G3PYfBdkq9FuNhrnTW4FN6zpvoHu6RAP1AL3w
         6Tgw==
X-Forwarded-Encrypted: i=1; AJvYcCUUSUGTW6D155gTh9g5YQP6gxtrUTiWHzUoGxzaddGeScrC9i65nw9WIm9I5CjENtaVvIXgW90H7liuULg=@vger.kernel.org
X-Gm-Message-State: AOJu0YwkoCY7Vismsf0qXzgVsnC6tBF2YsLOViYovgG38DwuIYwJLRUE
	DyTaoqWHmyTgYt0ikHTBZummXzjMxO7lwyXpeLUq0yec8WUQ3qcm9APb
X-Gm-Gg: ASbGncu8qRxc3haSk/qxiaqjhuAHrutNptRLHdBodM2P+j5PA4RTrtLmDC0g3soxdAb
	5Nnhv47cJlizGebfnyiDGsJdE2L2U4Pv2gki+fPG6mZydJLT+g1wCHOOGkSAjIhnhWTEeQ8VcbK
	ZilRmXc5pYzguCs6Jz6pmWfJgSLeBioVGJaCUG6fJdeCJ7MHz6cukZqdUyLBnPec4sjAEkGtOod
	zI6IvY52hRGU+8Qn73LtDAmUvtuTWwQNK0d7dhQvhYzuOzkmr/AHPW9NH8G6z/erv3hceSMaKkR
	yGbfi8mW07B7qL8xeVrtyRkURE2K6tTlPsu0/Bw/BGYdqQcFZm81xNE65gCTE7zeL7xsM5TTWOc
	FPOSVfVQwxrh+YcDfDSADxaK1Irg9uI0ccNwG+EXOWFBPY1uGRv4XNvFVqXjWA1Konr3itRUBN2
	TrJKz7
X-Google-Smtp-Source: AGHT+IGsvYS7IqWy79gnJFq5ZvsXSVjfLg83ejtTBYT+qACCxD4kQIoEYNiWs38owLy4Zu7DD51sIQ==
X-Received: by 2002:a17:906:9f8b:b0:b04:470b:64b0 with SMTP id a640c23a62f3a-b04470b6747mr48069366b.30.1756739216561;
        Mon, 01 Sep 2025 08:06:56 -0700 (PDT)
Received: from XPS.. ([2a02:908:1b0:afe0:811a:e584:2f56:9910])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b0413782b94sm454193066b.35.2025.09.01.08.06.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Sep 2025 08:06:55 -0700 (PDT)
From: Osama Abdelkader <osama.abdelkader@gmail.com>
To: rafael@kernel.org,
	daniel.lezcano@linaro.org,
	rui.zhang@intel.com,
	lukasz.luba@arm.com
Cc: linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Osama Abdelkader <osama.abdelkader@gmail.com>
Subject: [PATCH] thermal: hwmon: replace deprecated strcpy() with strscpy()
Date: Mon,  1 Sep 2025 17:06:53 +0200
Message-ID: <20250901150653.166978-1-osama.abdelkader@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

strcpy() is deprecated; use strscpy() instead.

Signed-off-by: Osama Abdelkader <osama.abdelkader@gmail.com>
---
 drivers/thermal/thermal_hwmon.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/thermal/thermal_hwmon.c b/drivers/thermal/thermal_hwmon.c
index 0ecccd4d8556..64cc3ab949fe 100644
--- a/drivers/thermal/thermal_hwmon.c
+++ b/drivers/thermal/thermal_hwmon.c
@@ -96,7 +96,7 @@ thermal_hwmon_lookup_by_type(const struct thermal_zone_device *tz)
 
 	mutex_lock(&thermal_hwmon_list_lock);
 	list_for_each_entry(hwmon, &thermal_hwmon_list, node) {
-		strcpy(type, tz->type);
+		strscpy(type, tz->type);
 		strreplace(type, '-', '_');
 		if (!strcmp(hwmon->type, type)) {
 			mutex_unlock(&thermal_hwmon_list_lock);
-- 
2.43.0


