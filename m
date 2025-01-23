Return-Path: <linux-pm+bounces-20845-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E0CE0A1A331
	for <lists+linux-pm@lfdr.de>; Thu, 23 Jan 2025 12:40:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9EA8A188756B
	for <lists+linux-pm@lfdr.de>; Thu, 23 Jan 2025 11:40:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D824211A23;
	Thu, 23 Jan 2025 11:38:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Sp1ICBkb"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8691211A0E
	for <linux-pm@vger.kernel.org>; Thu, 23 Jan 2025 11:38:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737632313; cv=none; b=MaNkFsKRnSCHkO0D0KEZ1ETHRakVZBxpEHo8GZqypDEeCBJSk12i8gaguQX002uzpG+zL2t+IJEFVkISGcNMJaHjfdFtIaeUL1R5mt2D3LGYZ23PJ7RXEZ1RzVAbH5rA8j3xCO3OobP/CepiMo0HptZVqzr7Kbfl/xFIuXJqosg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737632313; c=relaxed/simple;
	bh=THNC8n9hqdQ+kzmG3RgwjlwfPOuFsB8/C0FFHQfr36Y=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=lVHEXP7vFRiKuZ9bsAj/Mxz9y2zaoNOcUEBn/KfpoSafyL13UWcglpQKViKlI+Zwk92qzthQxK7yrbttAcOVZxt7hMaLnewnxt+u3ul50wY4mtH94n9JtLmFB2/0vuVAh731u7rVrskIk3CGM+zFstwEBkBL3FM4yLNQAYCQITg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Sp1ICBkb; arc=none smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-2eec9b3a1bbso1188964a91.3
        for <linux-pm@vger.kernel.org>; Thu, 23 Jan 2025 03:38:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1737632311; x=1738237111; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=T9f/kMsBtgnH6FD3SBlZFGa8eDXW7rw9RTFttNA9PE0=;
        b=Sp1ICBkb4bOq2sITiNPYVry9pvzxxYArojQwx112LyW17WzxHnZ6wh29ULAAbwO5T3
         7koV/Ck2AoY4c7OsL4/34L9mBpnahcFglQaBjbL5KPs9zpXnqqq+zFHIOVtIzP8B5Je9
         4e7Rm4WdgMhQY2vJ+IRn0ITsJfvlYQ/fdhHzA+eyDpUROb8Mch+hCODDKokr2CDybcZQ
         2Wap0V5fxvsXE0U7vW0+cEhltw3Jqzk2AyqsYy2x9JlupcCQ4mJW7yyZjfoRWzoUC026
         T2G7RcFhvJFodmKBVmbcNRve6qa4sAfCoeKVKytPNGYrXF4CGveQZ1Q52Q05qS/0hZJM
         DEUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737632311; x=1738237111;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=T9f/kMsBtgnH6FD3SBlZFGa8eDXW7rw9RTFttNA9PE0=;
        b=ZBm7Gc4QwPywTZnMsl6HSjkTvD+gANrSAPDMKl6HAipL77I1vZp/eSCZMKggFM+4FI
         I27C8PGdxsAVOvKhdBxK+JAP+hDCoHLekijGwRKHpdyHx3Gk42n945m0VUeGqnYBrKG+
         QLp6ybieCMCxpTPeC7y0HqofaIbaspBWLG7HbO7deZNW7z4WS8VWKW3Z+eqPEFQlY62r
         Fxx4sRwncCobSmFhSZKu0Csz9cPt+ybqXMer94+9VAgPckfXqA23ms5J+1/EVq+eZORn
         VIcLmXYO8fl1WPSw/YZHzGcIOJj4N6kWmd13oXDuTfsiC18th0i09r7KLnbUecGyYWxI
         k+6A==
X-Gm-Message-State: AOJu0YyHAZFNSa5uVX6OFtZxq3UUwQgzUqj4cdydzhg2iHKWxICF8Zfy
	2fWLdlQZ2k+ud/8rR+jMpe6N4Wa0XkF1YJYUEqVuN0y9EzuR6kCg7i+adStdvpI=
X-Gm-Gg: ASbGnctWBmX/J20Nq760s87FbXpag6LKcAJ7PpVmo8WrbDAeheifvyg7/O93LmnpPUk
	n26eOb0dtCGspEvUdcMQcCml/JECjyPZxnuExlLGqM4djHaZnvtyDV0BBBKoF78TEH6b9ndCenK
	CcoDuCqpxmsFQ44DKyPdZkRTUQNeC2dq85fUdNFU2JhxpUYbHvYenppNTe6ZhTcdfSOMMErvWkZ
	rohpYl3fdh/0t+u9xzut1uVXxiF7SUH4+NMoRQJAvwlYJfuiWbnw6kfiatMp/vA5gqcpqfKjWyZ
	9V3n3Fk=
X-Google-Smtp-Source: AGHT+IHcc6cJOWSdjAR8ms0RMJfjcVOJQ3pnBAUSPrtKAPzCiALqJYum2MVWf1fzB1fOvmO+PFUsuQ==
X-Received: by 2002:a05:6a00:21c3:b0:72a:a9d9:5a82 with SMTP id d2e1a72fcca58-72daf8878c0mr37819280b3a.0.1737632311336;
        Thu, 23 Jan 2025 03:38:31 -0800 (PST)
Received: from localhost ([122.172.84.139])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-72dab9c8ed3sm12764611b3a.113.2025.01.23.03.38.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Jan 2025 03:38:30 -0800 (PST)
From: Viresh Kumar <viresh.kumar@linaro.org>
To: "Rafael J. Wysocki" <rafael@kernel.org>,
	Viresh Kumar <viresh.kumar@linaro.org>
Cc: linux-pm@vger.kernel.org,
	Vincent Guittot <vincent.guittot@linaro.org>,
	linux-kernel@vger.kernel.org
Subject: [PATCH 09/33] cpufreq: elanfreq: Stop setting cpufreq_driver->attr field
Date: Thu, 23 Jan 2025 17:05:45 +0530
Message-Id: <bc2bae3ff0dcaced13e8305722e1b570abbda4bc.1737631669.git.viresh.kumar@linaro.org>
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
 drivers/cpufreq/elanfreq.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/cpufreq/elanfreq.c b/drivers/cpufreq/elanfreq.c
index 4ce5eb35dc46..36494b855e41 100644
--- a/drivers/cpufreq/elanfreq.c
+++ b/drivers/cpufreq/elanfreq.c
@@ -194,7 +194,6 @@ static struct cpufreq_driver elanfreq_driver = {
 	.target_index	= elanfreq_target,
 	.init		= elanfreq_cpu_init,
 	.name		= "elanfreq",
-	.attr		= cpufreq_generic_attr,
 };
 
 static const struct x86_cpu_id elan_id[] = {
-- 
2.31.1.272.g89b43f80a514


