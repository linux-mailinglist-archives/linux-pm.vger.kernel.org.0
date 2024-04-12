Return-Path: <linux-pm+bounces-6307-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A9AD38A2981
	for <lists+linux-pm@lfdr.de>; Fri, 12 Apr 2024 10:42:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DA9031C22C12
	for <lists+linux-pm@lfdr.de>; Fri, 12 Apr 2024 08:42:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE7673EA98;
	Fri, 12 Apr 2024 08:41:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="B3Ux2N+K"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 415951F5FF
	for <linux-pm@vger.kernel.org>; Fri, 12 Apr 2024 08:41:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712911316; cv=none; b=Sm1WvjPFCgGBNtXwFhkiHa5Nr6PXJ4jvtsvxSTzM9JlQUA+PYCJVjYTGOUusucSYX4IMeG/q+JUphRw84DF/dHFXDDdmfsH48ZFNZMN6Z7jPFv/nnBSyiIjLfln2c53ajN8cxlTFEziv3Dv7be4FFMqua84e/tRCJsCeFlTIT18=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712911316; c=relaxed/simple;
	bh=ikLHZ7DNZW/Ca/CIjkJHHCPEm9GHST1v51vR14ltSUM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Mb6+lIEGK1Qaim0sgBN3xga4gwnfaHEKc23ErXyHdAYbeYb9bL/fhIAKJKA5q9Wxkz7Rw9VmaudfBoB2OyqbVPo1WTChiQsyk/BRZtoIR681miU056EOC+aqBqTMDpqd6hc2MyXjZcsRNFFQVg1v+etlvIfcARMrnUaBywszXDw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=B3Ux2N+K; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-1e40042c13eso5188955ad.2
        for <linux-pm@vger.kernel.org>; Fri, 12 Apr 2024 01:41:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1712911313; x=1713516113; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=jiD5nR4sveHdMLlVkzf7AW+Iyy665nseig81tvRhcYc=;
        b=B3Ux2N+KlO/ONETyL4O0ukDGXe8tzVMKIienB32opYEd+RNhVIPlFqEwzSlznpd1EG
         Uq7D7Zu8EkMsi5MVt00ZDGuG2BhWI2Vu2oP8WqutLwLMO1DWmiTNhrHUSS8hMhgbpCte
         nphl7zIrqgakl4U5L+4SpnmjtJ6YzAjfoy47lAkeRHb9xiYS5ppkEmmJ/nR7pUATTsE2
         aZAuDiRXG56hNf5wHyB6fGr2lAIpmrSYxIIY1yCxOpOmERufXhHKAXQ3+NTDFcawz8a/
         hRFfah+/fxp39S0WujvelLvXbY/uPpzPIgZBwWV7FgmB97eyrNWBfgy8BnuWNSlZAF8q
         +Eyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712911313; x=1713516113;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jiD5nR4sveHdMLlVkzf7AW+Iyy665nseig81tvRhcYc=;
        b=FKBzuwcHQheQ6C3WOJ7AhoVebVr2tQRtX0+N/C3t5qmo2554n6CUxizx8lbJ+v/hat
         UOnQ5T+x+ST9JMnpYXtt87zRoYRy/GotvkpnlVpQuJDHeq3y5zq3rD4mgcHqg83q17o2
         TFVD20Uug27KWTFDW31m1gnIi48NO/SqEzvoy0wGoSMpXT/cwsLfrkGIc3fvKkm7arpw
         7PmoYZZvsOrviOJB2e2SdzqV/ea/sVLaQuWkT4Z7rXwuUhPAvwnWyXeB0F8WQUv/+Wfh
         gFNWPcKEoxm01e0Wdih4M1wkpIlsSJUNeEStOCdOq6e/6Ir58udf5bNjHXLK6p61hmoJ
         bV1w==
X-Gm-Message-State: AOJu0YwA76xnhrFo/A3Ha6uzayb+hH/5O7+HsSLoIruP1pRQptu9bSDo
	fRZE0foeTLKbzubUbwiAIunw8AkRyt1jFukJrwyJO3LoQ6gUHB/HN3WJUZcGF8g=
X-Google-Smtp-Source: AGHT+IHqzlVXqP2gD1aO7lBgZP0b5sN+Gg/7Pf6rKemMohLxQodYUBQtZz+jscLJUuNFNJuktFAiiQ==
X-Received: by 2002:a17:903:2442:b0:1e4:5b89:dbf3 with SMTP id l2-20020a170903244200b001e45b89dbf3mr2129510pls.35.1712911313230;
        Fri, 12 Apr 2024 01:41:53 -0700 (PDT)
Received: from localhost ([122.172.85.136])
        by smtp.gmail.com with ESMTPSA id w3-20020a170902904300b001e2bbc0a672sm2455762plz.188.2024.04.12.01.41.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Apr 2024 01:41:52 -0700 (PDT)
From: Viresh Kumar <viresh.kumar@linaro.org>
To: "Rafael J. Wysocki" <rafael@kernel.org>,
	Viresh Kumar <viresh.kumar@linaro.org>
Cc: linux-pm@vger.kernel.org,
	Vincent Guittot <vincent.guittot@linaro.org>,
	linux-kernel@vger.kernel.org
Subject: [PATCH V2] cpufreq: Always clear freq_table pointer
Date: Fri, 12 Apr 2024 14:11:46 +0530
Message-Id: <68294ce534668c6ab3b71a1b3e6650227c6e1f20.1712911186.git.viresh.kumar@linaro.org>
X-Mailer: git-send-email 2.31.1.272.g89b43f80a514
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The freq_table pointer must be cleared even if the exit() callback isn't
present.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
V2:

- Dropping the other change as it is covered by:

  https://lore.kernel.org/all/20240411231818.2471-1-sensor1010@163.com/

 drivers/cpufreq/cpufreq.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
index 66e10a19d76a..13980cb0527a 100644
--- a/drivers/cpufreq/cpufreq.c
+++ b/drivers/cpufreq/cpufreq.c
@@ -1679,10 +1679,13 @@ static void __cpufreq_offline(unsigned int cpu, struct cpufreq_policy *policy)
 	 */
 	if (cpufreq_driver->offline) {
 		cpufreq_driver->offline(policy);
-	} else if (cpufreq_driver->exit) {
-		cpufreq_driver->exit(policy);
-		policy->freq_table = NULL;
+		return;
 	}
+
+	if (cpufreq_driver->exit)
+		cpufreq_driver->exit(policy);
+
+	policy->freq_table = NULL;
 }
 
 static int cpufreq_offline(unsigned int cpu)
-- 
2.31.1.272.g89b43f80a514


