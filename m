Return-Path: <linux-pm+bounces-16700-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E0B79B5BF0
	for <lists+linux-pm@lfdr.de>; Wed, 30 Oct 2024 07:44:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C27791F220CE
	for <lists+linux-pm@lfdr.de>; Wed, 30 Oct 2024 06:44:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 570311DE3BD;
	Wed, 30 Oct 2024 06:44:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CQwzxd/9"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F7B11D63E3;
	Wed, 30 Oct 2024 06:44:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730270667; cv=none; b=Z09lAA1PkpCjq0NBOgAH0n25LLdWFzuN8htPR9S9XKgtu5QFTGEKrzezsJonMRaglKCmujYuFQi1MX6h1LBcYHs/2GehEPixprY2YPVYvukYqpnbyO/WgOqgjcjgkiJ2dy9+ozDyCsshcOJUZLJpWQK6R5KOm5CkVhHHkLhDWNQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730270667; c=relaxed/simple;
	bh=m1T9HiX7+i3wBf2xZSXfSq8sq++p65LRzFdeJzf9CJM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=VaKLL94Ha9pJ++m48fjpY4yzfmvuALGYNV364Qq1qEZEFhUKeX0MK9wOB9FIoJYdz/Fd9QxNAbAi7X39l9GGrWhMO/vyH8PvgxseSbpvIMg5V5dV4umkfeFScmuiVnMz+ICgxWkaG3vuCF/W+KTaA2T2fK+xzku+eFtWjK57U18=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CQwzxd/9; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-431ac30d379so23953925e9.1;
        Tue, 29 Oct 2024 23:44:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730270663; x=1730875463; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xthRcNHrX1KA8pnYHsJC/36HOWII/OJyqHZyYAZYrXA=;
        b=CQwzxd/9lw09CzCelITZ3IP3errExT0W/4mfYOSfbU06ldkwUbtx8h+e4twtgGTrMQ
         DFNuVIg8xyha/Tv08nUJzHzREzw0N9rs5FhNdIgdMcrO9v2WE6hbRRxChb18SUWXdwZS
         7oNMQ4kzAqX1J2HeEYVvM+3S0NZMpprQ3uE/qk9OGCQw+4mnVJCsp/ES5ezLrClTOHJF
         9/sX1/MASEJ35bAAmK0/0FJC+DoY5isB43xsmH3bhhi2c29Lk6BSerTy7ZRFcgIWkeNm
         MUjsOg7Rk8NrdF3jkydF1gkcjlFVXkdq4ae0GzkgL/45G7jEbMQP6Dl60HyYEVgpM6Ak
         5XwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730270663; x=1730875463;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xthRcNHrX1KA8pnYHsJC/36HOWII/OJyqHZyYAZYrXA=;
        b=FStcK0gfq92wYZb3rvIUPJPyN8KsNbukbiPEpbYmgSn3TtgKDhDFyw8r6NL9EQy9oN
         BRm1zH9zmBUIHATe03rdMYFNUI8gbfO9xjKZt0VwVV2dW/73DDprVmAuYNdsQrAFEv+T
         Vok4Cq/dhq688XaJQ330t4znsyHRxzrqsKYSDCzPt1lPV1jIK08a73NfUyKddWVkjtTp
         OvJrl+cerR3SIghFyzTLI5Qj23lqBO6MdQRtXb4X2OQYfTMNvKcC4yy70fp5wyW0a/bE
         ZilhYdw3CRLJd3BdoZ/RydR4oyCKqcgNboUIFLVEbbKpqUsruvLVTDKxZqy6HzUAD4GL
         dOxw==
X-Forwarded-Encrypted: i=1; AJvYcCVKhY44o/LCiIr+E6oQBigFm6g9BG+AtVUVDn2/KDcgREagN8rp8U6bOqTTUAd2/IOn2VM4BFXyR3pZFoY=@vger.kernel.org, AJvYcCXhBEA2YNBiFCHLj+FwTFs7nxvw/8qAaxM19dDlC9yZYmYzhtap0oybIkPI/I5XONJWxLB1E+BgQjU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxwp7WGYxUGdE2ZRDNN84FkEGWRBsJoG76k8IpEGPdrqjwOSVng
	dP9ziXU9x7nFa+l4MCgwXEfyTptjZBEaMXxWpaKFSJD1DY15fQWHkL2EiV8C
X-Google-Smtp-Source: AGHT+IHQ1NHOTA/Y5PIyYKQkbEKei8UPfqq6CzosOO568i/CJvp0+diEhs8+E3HO+oAewO52R20TBQ==
X-Received: by 2002:a05:600c:3b86:b0:430:5356:ac92 with SMTP id 5b1f17b1804b1-4319ac7642emr125927235e9.7.1730270662983;
        Tue, 29 Oct 2024 23:44:22 -0700 (PDT)
Received: from [127.0.1.1] ([213.208.157.67])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-431bd9ca704sm11249655e9.41.2024.10.29.23.44.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Oct 2024 23:44:22 -0700 (PDT)
From: Javier Carrasco <javier.carrasco.cruz@gmail.com>
Date: Wed, 30 Oct 2024 07:44:10 +0100
Subject: [PATCH 2/2] cpuidle: riscv-sbi: use cleanup attribute for np in
 for_each_possible_cpu
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241030-cpuidle-riscv-sbi-cleanup-v1-2-5e08a22c9409@gmail.com>
References: <20241030-cpuidle-riscv-sbi-cleanup-v1-0-5e08a22c9409@gmail.com>
In-Reply-To: <20241030-cpuidle-riscv-sbi-cleanup-v1-0-5e08a22c9409@gmail.com>
To: Anup Patel <anup@brainfault.org>, 
 "Rafael J. Wysocki" <rafael@kernel.org>, 
 Daniel Lezcano <daniel.lezcano@linaro.org>, 
 Paul Walmsley <paul.walmsley@sifive.com>, 
 Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
 Atish Patra <atishp@rivosinc.com>
Cc: Palmer Dabbelt <palmer@rivosinc.com>, linux-pm@vger.kernel.org, 
 linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Javier Carrasco <javier.carrasco.cruz@gmail.com>
X-Mailer: b4 0.14-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1730270658; l=1323;
 i=javier.carrasco.cruz@gmail.com; s=20240312; h=from:subject:message-id;
 bh=m1T9HiX7+i3wBf2xZSXfSq8sq++p65LRzFdeJzf9CJM=;
 b=FHS7yNAJhB0v5GNqH1PLbBsfTbP5beoCMPpMWfQ6NgPppVeYQ2SabddKJWpbSascpojP1A6CL
 NqbpY1ha6EuCDToUI3DaeH4JLkvR6jBIP9xAYthV0M5/f7YLsBJ9iQf
X-Developer-Key: i=javier.carrasco.cruz@gmail.com; a=ed25519;
 pk=lzSIvIzMz0JhJrzLXI0HAdPwsNPSSmEn6RbS+PTS9aQ=

Simplify the code and make it more robust against new execution paths in
the loop by means of the cleanup attribute.

Signed-off-by: Javier Carrasco <javier.carrasco.cruz@gmail.com>
---
 drivers/cpuidle/cpuidle-riscv-sbi.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/drivers/cpuidle/cpuidle-riscv-sbi.c b/drivers/cpuidle/cpuidle-riscv-sbi.c
index 2b3aec09b895..3a78d6b7598b 100644
--- a/drivers/cpuidle/cpuidle-riscv-sbi.c
+++ b/drivers/cpuidle/cpuidle-riscv-sbi.c
@@ -504,23 +504,21 @@ static int sbi_cpuidle_probe(struct platform_device *pdev)
 	int cpu, ret;
 	struct cpuidle_driver *drv;
 	struct cpuidle_device *dev;
-	struct device_node *np, *pds_node;
+	struct device_node *pds_node;
 
 	/* Detect OSI support based on CPU DT nodes */
 	sbi_cpuidle_use_osi = true;
 	for_each_possible_cpu(cpu) {
-		np = of_cpu_device_node_get(cpu);
+		struct device_node *np __free(device_node) =
+			of_cpu_device_node_get(cpu);
 		if (np &&
 		    of_property_present(np, "power-domains") &&
 		    of_property_present(np, "power-domain-names")) {
-			of_node_put(np);
 			continue;
 		} else {
 			sbi_cpuidle_use_osi = false;
-			of_node_put(np);
 			break;
 		}
-		of_node_put(np);
 	}
 
 	/* Populate generic power domains from DT nodes */

-- 
2.43.0


