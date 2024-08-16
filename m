Return-Path: <linux-pm+bounces-12362-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E3E7954D58
	for <lists+linux-pm@lfdr.de>; Fri, 16 Aug 2024 17:10:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C41DD1F22BEB
	for <lists+linux-pm@lfdr.de>; Fri, 16 Aug 2024 15:10:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71CFF1BDAB3;
	Fri, 16 Aug 2024 15:09:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="LFX/IDR7"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com [209.85.167.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A94A1BD502
	for <linux-pm@vger.kernel.org>; Fri, 16 Aug 2024 15:09:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723820982; cv=none; b=DWH+IYWDZee005a0vK1RXfFe+axWSeB6IBIZv9ZTLDbaytjLw6sVTHmhR/n7+SkZzwobUPuhFuuoNt6uxOe4k32U4papdmONpS7wyke0YB/yCqDhIDPAJeWLoG297QjFSxAgzABvKDyhIoPJ66+cT6oD2+aRBcJcrP1yZL7buvI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723820982; c=relaxed/simple;
	bh=RxdSPEBhE/sg1xbx+aIm2P4PC4lrIxdxMgkdgbz3zms=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UAkLhqbv89vr8WmfyXFkl5hVblfgV4+8Sp/Jc1EKALIFatZz02sgkuukUGb6nM0MmHOvr7vM1rJDZFm4mnuUnrym1o9ERC9U9prg+JMGU2s0DddGrZgCq7Fs/8tYjfpzI/cu97Ca+MgBauZUEcd91nxy90GjCOSLsd4vVGFIrKQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=LFX/IDR7; arc=none smtp.client-ip=209.85.167.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-52efa16aad9so2644514e87.0
        for <linux-pm@vger.kernel.org>; Fri, 16 Aug 2024 08:09:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1723820979; x=1724425779; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=td2rg5GyKlqce51WO+zvnPs34jMkYsAdv+WksjCyFsM=;
        b=LFX/IDR7y2KQlzCCSqNSkqKwRDXFDHjLoYTzz7Te+W6RaRJLDtIe3pd9n5Tg9Kd18A
         bS+JoYI6hkvCd+er9tRcZR7qKKqNSoSkVsilzUtzRtRISJx8amupJDeqxqc2nUEgcVbx
         01NZ77HBu96zR4uOVOe+NVhKKBmY/5+pu5rgt4RMsmSCgbbSCDcImS9a7iQIghP8jvg6
         ZTn2EI1Ps/sg8UDft3El8LY0HQVom4ORLrqaKbYJLs3iZbpCqYNb42H0NuJFt+Sfs0lu
         1ZeLmsiCNbOk6o5iYGxkvj75shWP0l35gxdzvFc9oq1ampwaO3WBOAy1W8cL59trxM02
         Kf5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723820979; x=1724425779;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=td2rg5GyKlqce51WO+zvnPs34jMkYsAdv+WksjCyFsM=;
        b=EZau0fblZCxGYJSf6AkDwNg+C02AgClCHmhRKTXzYSwbLKWu8jW/s6F6jT/ZrMq2ID
         KwfOdqFUvaFUhBgng9qmiHJk6/DpFZ1FAM80919HuzszWvKYMdpbAPNorIxzzUiz6+67
         nIAdLcXcu+NL3IF1FVTfWM8CREuRD2XiQtrLLHl9Y4cAgiAwD73dun5y8cqITmBd0Zl+
         XWZgke02SBEapbHVI9TMldshko/BCeW0yHcqGepcYjNZ3iMLQG24VhW8G/0NRmiqcArf
         vlRu+rKI/7yb+V4bk28u8YJYrSja8T1pS4FI6B9FkGLGjhI6Nq64lTmvdlUS7P5yGVzU
         /vnw==
X-Forwarded-Encrypted: i=1; AJvYcCWXuCRI349TxeJcTMzDrgOQT7ZsYqRVC0ENQ5vwwk/d98UnSW2kezne/dzPi9d93nbf43NZo+eqdcy5pRycPsRVjS9x9CczeYU=
X-Gm-Message-State: AOJu0YxIsSIFlaWPb7ktJl2VnxRunjGLTnYxGR/GQ9f+MEMVjjycKTKB
	Wh7d3FSNHCTlmuLyddMbHf7kDBfyw5g+42zeOX/M09i3FFUd0ZdvbkcykQJACMA=
X-Google-Smtp-Source: AGHT+IHaJrVe+YG7WrIsIhySz+TrI0z8q1N6+97MbyrpU5ReE7HuOkmva7Y8+xgV05N9m9+gUaX3EQ==
X-Received: by 2002:a05:6512:10c2:b0:530:da95:b54c with SMTP id 2adb3069b0e04-5331c6acec2mr2537162e87.23.1723820978496;
        Fri, 16 Aug 2024 08:09:38 -0700 (PDT)
Received: from krzk-bin.. ([178.197.215.209])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3718984993fsm3808758f8f.31.2024.08.16.08.09.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Aug 2024 08:09:37 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To: Ulf Hansson <ulf.hansson@linaro.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Daniel Lezcano <daniel.lezcano@linaro.org>,
	Anup Patel <anup@brainfault.org>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	linux-pm@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH 3/4] cpuidle: riscv-sbi: Simplify with scoped for each OF child loop
Date: Fri, 16 Aug 2024 17:09:30 +0200
Message-ID: <20240816150931.142208-3-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240816150931.142208-1-krzysztof.kozlowski@linaro.org>
References: <20240816150931.142208-1-krzysztof.kozlowski@linaro.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Use scoped for_each_child_of_node_scoped() when iterating over device
nodes to make code a bit simpler.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 drivers/cpuidle/cpuidle-riscv-sbi.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/drivers/cpuidle/cpuidle-riscv-sbi.c b/drivers/cpuidle/cpuidle-riscv-sbi.c
index 5bb3401220d2..d228b4d18d56 100644
--- a/drivers/cpuidle/cpuidle-riscv-sbi.c
+++ b/drivers/cpuidle/cpuidle-riscv-sbi.c
@@ -448,7 +448,6 @@ static void sbi_pd_remove(void)
 
 static int sbi_genpd_probe(struct device_node *np)
 {
-	struct device_node *node;
 	int ret = 0, pd_count = 0;
 
 	if (!np)
@@ -458,13 +457,13 @@ static int sbi_genpd_probe(struct device_node *np)
 	 * Parse child nodes for the "#power-domain-cells" property and
 	 * initialize a genpd/genpd-of-provider pair when it's found.
 	 */
-	for_each_child_of_node(np, node) {
+	for_each_child_of_node_scoped(np, node) {
 		if (!of_property_present(node, "#power-domain-cells"))
 			continue;
 
 		ret = sbi_pd_init(node);
 		if (ret)
-			goto put_node;
+			goto remove_pd;
 
 		pd_count++;
 	}
@@ -480,8 +479,6 @@ static int sbi_genpd_probe(struct device_node *np)
 
 	return 0;
 
-put_node:
-	of_node_put(node);
 remove_pd:
 	sbi_pd_remove();
 	pr_err("failed to create CPU PM domains ret=%d\n", ret);
-- 
2.43.0


