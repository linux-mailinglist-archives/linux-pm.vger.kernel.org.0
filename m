Return-Path: <linux-pm+bounces-3727-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F2618500AB
	for <lists+linux-pm@lfdr.de>; Sat, 10 Feb 2024 00:19:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 400811C2074C
	for <lists+linux-pm@lfdr.de>; Fri,  9 Feb 2024 23:19:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9C1636AFD;
	Fri,  9 Feb 2024 23:19:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MnSnwkFj"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-vk1-f175.google.com (mail-vk1-f175.google.com [209.85.221.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5437729D01
	for <linux-pm@vger.kernel.org>; Fri,  9 Feb 2024 23:19:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707520763; cv=none; b=uN+v+7nrUpnLvcIyDN+VpVGQP+rvLBzLVnWjdIHRTW3qOWACJyZ3RpbOdndY16P46bmFRpfV5S8AH9teLwjlmXBLLRsQ31InwlZdbG3iTtf2xecjpYJunM55hICAkS7wSraDS59BZEssR+ekxdBDIqgjX8ZQELV96XzosR7eI3I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707520763; c=relaxed/simple;
	bh=5cR/nBEnchKWix52noQCOqG1paqwl6ewCxKsI9bdAF8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=e8up40GowSl8rW655iYoGjZ29Mgh/KwUHbwGfzN3vdF7SZAHFP62W/XqTjNhdJE+ue1KTQAiiiSy+oZ0OsmsjoDM67xIsv/oMlIlWqJhxRC7FvmwmXnDf0UmLYHws/gFfmS73qy2rkVP7OCnPJ2EHzI+6AsgILS+Pba6jKSCAws=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MnSnwkFj; arc=none smtp.client-ip=209.85.221.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f175.google.com with SMTP id 71dfb90a1353d-4c009d2053fso431895e0c.3
        for <linux-pm@vger.kernel.org>; Fri, 09 Feb 2024 15:19:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707520761; x=1708125561; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=t5qKOv/sgTJRuERKTP+UqEfqa3l333yh9ZVS0CbYP7o=;
        b=MnSnwkFjfHoTYCyZQnfuEN3T8klOJ4UR6fGwv19MS3g52ZNwgOa/VUZ7TT659r7N9m
         CpLyOcBs3sn3NNqs2kI2sJGQLr67znofgWRJuEHrJjDMYGqJ9dAjDu8m/z6CRbR8BHWx
         Syfx73ErI2QeNB6yjOfFT91cWdAvidry5HYPN5dOgh7eTBvbULEqRbcdun9ZneK6F463
         P2zBnzIE21obix2WwyLG0MomugY5rluGwvfDb/WmYUO+WzWNqnASndMvwLOZn8MEOjh0
         oJfAAeFHAL0oe5mQimDxyyjWSBm0H+h9QXl5vVhkDNrILFqVs4tUMyxwc2wr/01/v2e0
         zZvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707520761; x=1708125561;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=t5qKOv/sgTJRuERKTP+UqEfqa3l333yh9ZVS0CbYP7o=;
        b=dVt+Lj5qYLzeEYcS7ZiX5950dNt54ITLpKI6tSGYhyDLQSQOSF19/TzY6O1LQEKsLD
         T63PDDGA2ioKWVZZYvl6x6C5a3o20Ci4AqzF6yuPruWUzvoJMpQU+51VaaTXblHWoeAF
         tkIYsSxYfVUH9CEEaoORcyKzWLR48A8HoPZzWPHyKR1aUhnNZcTwBdT4+iJLt/ctNoSE
         XXaRkRJ3JDSE0NbGZL3/Asb5/xSPftgoFbDSf3GQCIveR2QWLQXkn3/NvPgyx5ONyNui
         7kqU1Fu7dvIyKfTv7mOUdqO+PsZIwBprzmghkhkkixXeWdWh6ba8nuGgzB3CYh1JK7Ix
         5E5w==
X-Gm-Message-State: AOJu0Yx0EGpXW5HXstTmj4Jz/D2SKG3n0fCt81piE+sVJhQCTq/D/00N
	itG+NabwoT9ln/XbFCZ5Xc//obJkExPzmWscm0Rn5DJ1/X6kw/p3
X-Google-Smtp-Source: AGHT+IFQwFTV6zhFBw3zM/vKamXxn+/VCu7ar2E46ee1XRAK40d0j/Sz7dpQjBMNoe8rZggiaPvWdA==
X-Received: by 2002:a1f:e0c4:0:b0:4c0:1f44:6707 with SMTP id x187-20020a1fe0c4000000b004c01f446707mr826288vkg.11.1707520761086;
        Fri, 09 Feb 2024 15:19:21 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXPFjHFk9+H3TqG8NiUhEj1A1wEJPeE+h2Puus/KysSHvcizf5I7UvKG83caQi2Czl+o3WmENWvWin6TYlunIVkhl5bWm+1fSEPo/IAFvqYy6LwvuAognvHA3vTpFseUFsC
Received: from localhost ([2607:fea8:52a3:d200::42b6])
        by smtp.gmail.com with ESMTPSA id pj11-20020a0562144b0b00b0068cd7247806sm811036qvb.121.2024.02.09.15.19.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Feb 2024 15:19:20 -0800 (PST)
From: Richard Acayan <mailingradian@gmail.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>,
	Viresh Kumar <viresh.kumar@linaro.org>,
	linux-pm@vger.kernel.org
Cc: Richard Acayan <mailingradian@gmail.com>
Subject: [PATCH] cpufreq: dt-platdev: block SDM670 in cpufreq-dt-platdev
Date: Fri,  9 Feb 2024 18:19:15 -0500
Message-ID: <20240209231914.199235-2-mailingradian@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The Snapdragon 670 uses the Qualcomm driver for CPU frequency scaling.
Block this driver from loading on it so the driver does not pollute
dmesg with an error.

Signed-off-by: Richard Acayan <mailingradian@gmail.com>
---
 drivers/cpufreq/cpufreq-dt-platdev.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/cpufreq/cpufreq-dt-platdev.c b/drivers/cpufreq/cpufreq-dt-platdev.c
index bd1e1357cef8..b993a498084b 100644
--- a/drivers/cpufreq/cpufreq-dt-platdev.c
+++ b/drivers/cpufreq/cpufreq-dt-platdev.c
@@ -156,6 +156,7 @@ static const struct of_device_id blocklist[] __initconst = {
 	{ .compatible = "qcom,sc7280", },
 	{ .compatible = "qcom,sc8180x", },
 	{ .compatible = "qcom,sc8280xp", },
+	{ .compatible = "qcom,sdm670", },
 	{ .compatible = "qcom,sdm845", },
 	{ .compatible = "qcom,sdx75", },
 	{ .compatible = "qcom,sm6115", },
-- 
2.43.0


