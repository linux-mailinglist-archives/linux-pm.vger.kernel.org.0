Return-Path: <linux-pm+bounces-12191-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D236B951401
	for <lists+linux-pm@lfdr.de>; Wed, 14 Aug 2024 07:45:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 818C31F25408
	for <lists+linux-pm@lfdr.de>; Wed, 14 Aug 2024 05:45:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D659377F11;
	Wed, 14 Aug 2024 05:44:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="AC6/dn7G"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A5A8745F4
	for <linux-pm@vger.kernel.org>; Wed, 14 Aug 2024 05:44:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723614286; cv=none; b=b4eo2F2tL6ItQN6jSkSeA538EGjt9aXoWwjKNyLHK9Y6OgJE/4s5pZBXM1ZM805FTWMD4JxTqiaiD/X2oU7LQD1I7FZi/TCbFtGhOd/hzJQJW8WVriFiLDOUpszCw93i/uOsHPliGFCBQV0RxNnxtNvIiWfpAK8qzX8fcjCQHOs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723614286; c=relaxed/simple;
	bh=oz/ZbxOYBYoSaJv71NLT+p3jqnf7AjyeXy1UYDpRuJ0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=cwzaqx8VtloIi4UqBHptseyfs08ZYEigbAi14cCkHmZ346PL587Z6B04E9adBTYGC+QWiDngGrgzXC8nRF2rRxNv+dRaxFSuaZmOWy9F4/3ThXplmCQbuwJBeoZ6j/kF6hhO+Vm52443ceew+hySJ86RsmALZ5toKHBF8I+Q2JU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com; spf=pass smtp.mailfrom=sifive.com; dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b=AC6/dn7G; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sifive.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-1fc587361b6so52506115ad.2
        for <linux-pm@vger.kernel.org>; Tue, 13 Aug 2024 22:44:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1723614285; x=1724219085; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7//UyL4OxAxRCQ/u8WgruiMwE8g6st4KW8tP9FVdOz4=;
        b=AC6/dn7GpLsLmbXVIo0MEBsKyD+/dL/Z0sa6Avm9dUtI7s0O0HzPZb3UOIk5MQsPGT
         iDSLdbPduhUbUMFqjJmkhSxilTyQ8jiRI0b4D0Vet7Zc8hMUNQ5bIk+Cn3Z2RirJrFeY
         j4pl1FD6d9rg02OXjVj3lZ2m+UqsIWn6a/2ged6J2vJgrEhOzYNd/zthQTCJa+h8keB/
         aWUMG1NNh3wJTBd7BPSA+W8/lYTAgaL14LbaDhxjWAQHlgw9e24rlSDM/XcQZlokL6Dg
         1u+AYNoJIF4dvlV5qAipayYLN8WaEBIctju6SSEM6RpRUN9idzMTTDjRs0heMKVOyCVd
         H/ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723614285; x=1724219085;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7//UyL4OxAxRCQ/u8WgruiMwE8g6st4KW8tP9FVdOz4=;
        b=C9biLTPIdl+C23w5ixgWa+pYbqZ23Qiz5Lm7hAxUY0VVGOmX01aFVODda73SmL9F1P
         wiHO22Kd++/LEvx3a8T8oPJuRgqAEY/FStvu01ewIxW2QGf/0EQ0suXToRWie7OciGIj
         XVKGANQ5Zyq4MmM7pdvk+DBaRCrx0VYolIYuEIO3zYOVwGdiN5MwC7hB0V8Bd7G9Z/oX
         XWXlHvxvHuvz7GwDDmkDzpOWDASSzItBo7CZ8WG1f3URc9bliuTaHJgTLQPGPQ7ioNP/
         ctLHeUjfHlS6BvxNYpmr+fgDrPUfBW3QcweXcPDqUiRuzK7uDEc28IfHNFi0sky2K+6t
         S/PQ==
X-Forwarded-Encrypted: i=1; AJvYcCVvNQnD15Vr8Z5O3PgaLSMRZ1JkN6UCs0sNq+DoaM58avQMobj+NaMDFaadMoVoK7Nb/IdIsJm9+A==@vger.kernel.org
X-Gm-Message-State: AOJu0Yy2v3stwWBg96EN3sxq2rGPKN34Bs+DBC5L8JhDZq8PV35Km/5i
	lGU4lJoHI02Psh/UUw4rEZlX6xFkWSw/OGqD3KEU5tmN6x3naqn8/tUwYXK/ZD8=
X-Google-Smtp-Source: AGHT+IH2u5Hy7JK9qr9NzQ+z/s4QL68RKujwQoMl1KYw/4mDtUdaVsYGJsQISTuL1RB+J7X1O07FeQ==
X-Received: by 2002:a17:903:3607:b0:1fb:8f72:d5ea with SMTP id d9443c01a7336-201d64a5b20mr21592635ad.50.1723614284535;
        Tue, 13 Aug 2024 22:44:44 -0700 (PDT)
Received: from hsinchu35-syssw01.internal.sifive.com (59-124-168-89.hinet-ip.hinet.net. [59.124.168.89])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-201cd1ab486sm22062085ad.150.2024.08.13.22.44.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Aug 2024 22:44:44 -0700 (PDT)
From: Nick Hu <nick.hu@sifive.com>
To: anup@brainfault.org,
	rafael@kernel.org,
	daniel.lezcano@linaro.org,
	paul.walmsley@sifive.com,
	palmer@dabbelt.com,
	aou@eecs.berkeley.edu,
	linux-pm@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	greentime.hu@sifive.com,
	zong.li@sifive.com
Cc: Nick Hu <nick.hu@sifive.com>,
	Anup Patel <apatel@ventanamicro.com>
Subject: [PATCH v2 1/2] cpuidle: riscv-sbi: Move sbi_cpuidle_init to arch_initcall
Date: Wed, 14 Aug 2024 13:44:33 +0800
Message-Id: <20240814054434.3563453-2-nick.hu@sifive.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240814054434.3563453-1-nick.hu@sifive.com>
References: <20240814054434.3563453-1-nick.hu@sifive.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Move the sbi_cpuidle_init to the arch_initcall to prevent the consumer
devices from being deferred.

Signed-off-by: Nick Hu <nick.hu@sifive.com>
Link: https://lore.kernel.org/lkml/CAKddAkAOUJSnM=Px-YO=U6pis_7mODHZbmYqcgEzXikriqYvXQ@mail.gmail.com/
Suggested-by: Anup Patel <apatel@ventanamicro.com>
---
 drivers/cpuidle/cpuidle-riscv-sbi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/cpuidle/cpuidle-riscv-sbi.c b/drivers/cpuidle/cpuidle-riscv-sbi.c
index a6e123dfe394..98e7751dbfe8 100644
--- a/drivers/cpuidle/cpuidle-riscv-sbi.c
+++ b/drivers/cpuidle/cpuidle-riscv-sbi.c
@@ -592,4 +592,4 @@ static int __init sbi_cpuidle_init(void)
 
 	return 0;
 }
-device_initcall(sbi_cpuidle_init);
+arch_initcall(sbi_cpuidle_init);
-- 
2.34.1


