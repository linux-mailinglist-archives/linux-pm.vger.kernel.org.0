Return-Path: <linux-pm+bounces-19006-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AD3649ECB10
	for <lists+linux-pm@lfdr.de>; Wed, 11 Dec 2024 12:24:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B78C41884351
	for <lists+linux-pm@lfdr.de>; Wed, 11 Dec 2024 11:24:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4EC7236FBA;
	Wed, 11 Dec 2024 11:23:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JQWU6ss9"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com [209.85.215.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 659AE236F95;
	Wed, 11 Dec 2024 11:23:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733916204; cv=none; b=WXukyCTBgZO0YmnYPSxQ6YNj7O1R/xOBJWW/6VSYL5/XeZNI5dESu2V2eHbRkh9UdPrw37/SJbqRAVCk6vzMRyAzi4LBQaz29QlOBdQA88/8nPTtn4wrJDrWQqMziScqaCUEVHrY01Cl0UOWjx60ZkCYW90XlGWC/kK+rj25FTo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733916204; c=relaxed/simple;
	bh=MDFsueiGJp/ZzlB6eQNdXlWorFXPp/SAmEiTPyvzvK8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IFTZNSL83qJ2Z0rF3N5eNUgw3niHm58+uvu1LG+K0qbX8uwcxUm9mBQRn7bmYjutmkF0cAd//Qlj+Hngk3mhDFIhN+ZvJsji09zHQtvxibVWhZK9o706IYKRs3GqxsXvrl2LDoSbKEi1TrN0oOpZ/K+L2E2IpEIRCXgZ84wq1Ng=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JQWU6ss9; arc=none smtp.client-ip=209.85.215.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f172.google.com with SMTP id 41be03b00d2f7-7fc93152edcso467413a12.0;
        Wed, 11 Dec 2024 03:23:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733916203; x=1734521003; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6l1I2ck309o9qdqJYu3bhIkW88QmjXQLLkvder5A/zo=;
        b=JQWU6ss9MiSHblrbShKRJEGFiP/uHndugfDFGspyOYNf7ahDuSd+02v7AfI/Ic/iGB
         5G7gxJUy0YOWyhQYdR5UaoGEjm5VQJVoTMuWl/OQvzARdACDPLCp+v9y3WvUrH9gZk/t
         95EmMXB+fWa4n88Wg/rokUNJIsyyhvULoo4/EP/gRTI/uFoW7lC9eKFoZvp5U25owwHM
         QPkaatoC2i2cWnZLNYq20kQ5PpJNPsoPVqZKzbSVKoTo3L3isq+UJDkgUTrRcGOOOz1j
         4PgR3QLjuLPYIoSMwpI7ZMU5EfA5uuGTs5dZN2jb5r3cE7IOJp/DPNJVY1LNGa4z2hp9
         bpFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733916203; x=1734521003;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6l1I2ck309o9qdqJYu3bhIkW88QmjXQLLkvder5A/zo=;
        b=C56qKXYqx8gq7VEARKUAjHf/EbVv7JOIv8rKZ9mXJtYGmXOjDtRZ5mTx20Q0LTydSr
         O7HLmQWdPjaL3PKipWM30SDuhBs3C05NqAMgsDfisArjMGf97RW19dHdgrZi5KcDe3Y0
         cFSYC+xxynfRAaFlUols+JhfaBrT176FdgDCAZcG1VPvk9bU+t4opEqHkAYQapiwf+BG
         FJRJHNTR2f5y2bwhQyAXYF6Ue3sQDXiIWF4ZyGPTBkJnDp343R8J4fmH1/vYfL7UciCs
         TkGMCb5csmUJzG56lPk/JS0ku7vF17EZEQzQX1hcBPwvdxgp3xn1iQYEhu6qgFz9VPJ4
         QTYQ==
X-Forwarded-Encrypted: i=1; AJvYcCU+Z9iLjGu6saHH4zZGxjFFZnIYHFpLlO8kWb/tytPVfKyhMVxgJXSXrSkQ/xk7ryFpqpEmtyTRwjwaIuRc@vger.kernel.org, AJvYcCV7nI8G1WQqTMBPchEiW1MmiPjvFOm7/v/ffdgXxW71bRk74J0iZU94Pk4PRjBb1KB9Z6V3PGCkhg0=@vger.kernel.org, AJvYcCWnFLo2L7d3P/wAIfXN9hKKme0UpHPC01Pb2ClO4bcXe45lW8KirHzW30T6qGxF/t2PqNxCNhOUvlk5@vger.kernel.org
X-Gm-Message-State: AOJu0YwgNFdbDImM7yXL3bwDYGyMY2/q+zOtOCirBwGggyVhaw2Huo+L
	KG9UzVNQe08RNCrUpdXvqxB9R/re21r9Zn1BZTsudUENgwpZBP2V
X-Gm-Gg: ASbGncsVYgKomnG1chq+ozYaVfdJNX03pEWS2oBZGSkavwq1TiZmYYW+KmXg+HmMZJn
	xX3Yf9PDV4A+rp5/Og6e7JzhvZhOjWmSvtqK+gBifLvhIDBtg8AVw874emEulFbnvLudTFgLF5Q
	vYNl2NK0w7chO2OlziU/OZzPjQX6OnNdK19gKpq8diXbSKRxSgLPzlaQJYJZERgY/6V2+362hMx
	ChrZNzHe1m28oyVjdDAAeP+XEQClZ6eSocwiHAl8f07jrI0g6yXi0lhf1uGZtcmFb1lNg==
X-Google-Smtp-Source: AGHT+IFZ/i4RQlCJ3AH9/61VkIUfCaOigGZYmLs5RHyiP6u8Y2aWFd6COWq3vEZzepN3j6B/3uPbDQ==
X-Received: by 2002:a17:902:e54a:b0:215:2d2c:dd0c with SMTP id d9443c01a7336-21779e47121mr34337095ad.14.1733916202695;
        Wed, 11 Dec 2024 03:23:22 -0800 (PST)
Received: from localhost.localdomain ([59.188.211.160])
        by smtp.googlemail.com with ESMTPSA id d9443c01a7336-21650ccdc7esm48956615ad.133.2024.12.11.03.23.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Dec 2024 03:23:22 -0800 (PST)
From: Nick Chan <towinchenmi@gmail.com>
To: Hector Martin <marcan@marcan.st>,
	Sven Peter <sven@svenpeter.dev>,
	Alyssa Rosenzweig <alyssa@rosenzweig.io>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	Viresh Kumar <viresh.kumar@linaro.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	asahi@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	linux-pm@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Nick Chan <towinchenmi@gmail.com>
Subject: [PATCH 6/7] cpufreq: apple-soc: Set fallback transition latency to APPLE_DVFS_TRANSITION_TIMEOUT
Date: Wed, 11 Dec 2024 19:19:33 +0800
Message-ID: <20241211112244.18393-7-towinchenmi@gmail.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241211112244.18393-1-towinchenmi@gmail.com>
References: <20241211112244.18393-1-towinchenmi@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The driver already assumes transitions will not take longer than
APPLE_DVFS_TRANSITION_TIMEOUT in apple_soc_cpufreq_set_target(), so it
makes little sense to set CPUFREQ_ETERNAL as the transition latency
when the transistion latency is not given by the opp-table.

Signed-off-by: Nick Chan <towinchenmi@gmail.com>
---
 drivers/cpufreq/apple-soc-cpufreq.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/cpufreq/apple-soc-cpufreq.c b/drivers/cpufreq/apple-soc-cpufreq.c
index 94e57f055a5f..0af36f911bea 100644
--- a/drivers/cpufreq/apple-soc-cpufreq.c
+++ b/drivers/cpufreq/apple-soc-cpufreq.c
@@ -291,7 +291,7 @@ static int apple_soc_cpufreq_init(struct cpufreq_policy *policy)
 
 	transition_latency = dev_pm_opp_get_max_transition_latency(cpu_dev);
 	if (!transition_latency)
-		transition_latency = CPUFREQ_ETERNAL;
+		transition_latency = APPLE_DVFS_TRANSITION_TIMEOUT;
 
 	policy->cpuinfo.transition_latency = transition_latency;
 	policy->dvfs_possible_from_any_cpu = true;
-- 
2.47.1


