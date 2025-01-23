Return-Path: <linux-pm+bounces-20848-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E8A64A1A337
	for <lists+linux-pm@lfdr.de>; Thu, 23 Jan 2025 12:41:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 03D0E18892CC
	for <lists+linux-pm@lfdr.de>; Thu, 23 Jan 2025 11:40:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DCF6213245;
	Thu, 23 Jan 2025 11:38:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="JMYf1tG4"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 025FE212FB4
	for <linux-pm@vger.kernel.org>; Thu, 23 Jan 2025 11:38:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737632323; cv=none; b=lHIj2611UEAgKK70gkJ0MlnN9YoCqJR4W/cMTWZFtfcsmcRkKbQxwX0Qu6AZgHh67MuvG9ebl8WJAJnoKGmcXGFAQIMZwvVwiLQDi8rTs7YS6oVWGkAiyVMIDbNy/VQ+3ExJPHpgb6PXKZhrD94YkeP+YuaLl+/FzvPtAZObTCM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737632323; c=relaxed/simple;
	bh=gjhLnUgCBEp9meHZg6SfAGfSOVSDJTb1Hpxddkmkf70=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=cdJiZ3CUS22gPC313jnHYD4Q28n7KEKSz1Y3rPHNQpIqFgMn/QlrxgrBZ67+Q/Vk9R31BpN/HWmm6EsFLvx85DMLLzD1lZ2pbNCUQxNzPRRgebQZsgUZSFKyGsdLIInnlHdQlTNCFfwpThrjtdhgmIw95acplctmOT2oMT+O858=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=JMYf1tG4; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-2166360285dso12899245ad.1
        for <linux-pm@vger.kernel.org>; Thu, 23 Jan 2025 03:38:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1737632321; x=1738237121; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/f+R49y7rqR8LPNzeEWH65+ozFeRSdC3z0jYqOQ6KQE=;
        b=JMYf1tG4EsSKxn+KkXQvic+64WNqEZFcE+rv2kk7oDhrh3RK/t30jNkFEp8Dhs2EdM
         9SGuxU0ixP+EWZfUe3gOhPBkdI6ZYqoJuF1YH2UqZL+OZ8LcrwboNmG5r9cGDh8nPDbT
         0zba6pOdE4Fb4M4BJC1hN3nVcasrtZEJdolykudUN/FomY8iVPWs32l1a3C/JaNzckq3
         tuo1Exfn7iaiDVrLhw81zs+NWKfRsDMuas/r5D2/c5EMRqQbs6H2M4J3pM5M02dHHEiA
         P88BayOjkL2fHso3iy9e5YIq9cT75aq3JDSVjy985cp6m/AFpa+12tb76FvCVIFa64fU
         ucog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737632321; x=1738237121;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/f+R49y7rqR8LPNzeEWH65+ozFeRSdC3z0jYqOQ6KQE=;
        b=MPkFpN+3Zwxgry4Vt0VSEPp125LlnfLIWL1CxdeR+foMd0ONDuPI5lYtNrIQ63sxPV
         1W7DVMxcWJoY8kuhqRTH/RI02KWfOThhM/Wb1CQugss+ilRVa2Hci2oYWM5ZZ9dUXJoo
         OF6uErRlcuSVJI1CT/jnaQ7WR3JyPbvDUz4RuelDMhgDqFLw8vYAoXWxWv9Ng8A53ksw
         Bs+YbxzIS04bdisISPjTt4CoZ/a4ORkQRzlJzBym7xdUZVhrmcNCEu+6FG31dDgEpQo2
         dRulzuFhsnGFmseXyl78u8eUNmg2ZBbHvIrAyID3rgozkiIjDQaisRCgNthbZxH7ra6M
         dPJA==
X-Gm-Message-State: AOJu0YyzaBU5lJfCTY71gR0HpysZEYmt4rhGnzz5K8v/81mX47UG+yvh
	HWQ/sgN/6z9TGRZmC8sL13sVw/kJvzKC0zmoC/SbhC0Sq+JILem8CisqcdkhnLk=
X-Gm-Gg: ASbGncuwsSEnXocY9oMEvGMKZWxvLgY/lGXW0rz9EekAuVdlRCLkpUC4+gckwEwnI1T
	FcJ8fvMNwFCiYa5VxLvPMpzxYGTcAtIwfnRTiI2GX3tExyE/DeQgijFH1XU4KPYyVgSPDitnSrP
	+Uv1z2WOe1ln3I5vwp/BNowdEfYpDtWEfIch+5fOSYBvaCw087nPDZqXSfosTpHs+we/Fby2tpT
	6/KDNJ85pN+1HvLXRWEP+GhIYHpfDOafCc8uL2zKJGe7cXJ77tMYDc0U9XTeuMXSymgZFW7Y/VW
	XkUgG68=
X-Google-Smtp-Source: AGHT+IEF1gk8nknAFgH2VOJv+6XrYgoix7hht6At3tn5rpItQbdwTaF2EtfB8RgZioj8Vw2107cNrg==
X-Received: by 2002:a17:902:cec3:b0:21a:7cbe:3a9a with SMTP id d9443c01a7336-21c353ee9cfmr386129505ad.14.1737632321228;
        Thu, 23 Jan 2025 03:38:41 -0800 (PST)
Received: from localhost ([122.172.84.139])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21c2d3acf2csm110513615ad.121.2025.01.23.03.38.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Jan 2025 03:38:40 -0800 (PST)
From: Viresh Kumar <viresh.kumar@linaro.org>
To: "Rafael J. Wysocki" <rafael@kernel.org>,
	Viresh Kumar <viresh.kumar@linaro.org>
Cc: linux-pm@vger.kernel.org,
	Vincent Guittot <vincent.guittot@linaro.org>,
	linux-kernel@vger.kernel.org
Subject: [PATCH 12/33] cpufreq: longhaul: Stop setting cpufreq_driver->attr field
Date: Thu, 23 Jan 2025 17:05:48 +0530
Message-Id: <2fd835c8f4f626588d2d87cf8892eb66b4f2bf63.1737631669.git.viresh.kumar@linaro.org>
X-Mailer: git-send-email 2.31.1.272.g89b43f80a514
In-Reply-To: <cover.1737631669.git.viresh.kumar@linaro.org>
References: <cover.1737631669.git.viresh.kumar@linaro.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The cpufreq core handles this for basic attributes now, the driver can skip
setting them.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/cpufreq/longhaul.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/cpufreq/longhaul.c b/drivers/cpufreq/longhaul.c
index bd6fe8638d39..68ccd73c8129 100644
--- a/drivers/cpufreq/longhaul.c
+++ b/drivers/cpufreq/longhaul.c
@@ -906,7 +906,6 @@ static struct cpufreq_driver longhaul_driver = {
 	.get	= longhaul_get,
 	.init	= longhaul_cpu_init,
 	.name	= "longhaul",
-	.attr	= cpufreq_generic_attr,
 };
 
 static const struct x86_cpu_id longhaul_id[] = {
-- 
2.31.1.272.g89b43f80a514


