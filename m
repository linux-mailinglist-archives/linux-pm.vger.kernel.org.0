Return-Path: <linux-pm+bounces-16699-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CB589B5BED
	for <lists+linux-pm@lfdr.de>; Wed, 30 Oct 2024 07:44:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 620D31C210F1
	for <lists+linux-pm@lfdr.de>; Wed, 30 Oct 2024 06:44:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A20B1DACA1;
	Wed, 30 Oct 2024 06:44:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MVzoA2ds"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com [209.85.167.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0A521D0E27;
	Wed, 30 Oct 2024 06:44:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730270666; cv=none; b=losXVh7JeRVS1BF5QxEyyYiiNiNjpAD9MhAiGQDJfPUzgM/9uABFGjifRrXc5p36426b40RciHtWXlQ+yeU76nr0ZckyUIHl9TePlU7rYhFGC+GbkDPZV14fmdesTrDL2N4SvaeYqiHiBJmbVmxwoW+LWqTeau6wSsizeFA1gKY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730270666; c=relaxed/simple;
	bh=BckDlgNxXN37WM9rRTU+h45QD44ycxfdprrjTJEpleg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=YdGVUo9s6gFS2qGiOgEPtgAz7OM2eURmnZttIq74dt/lBK8oUR66+ce9r4Lx/4C/0bUalP4Au8PQb8sDK9m1r3S9YWwGwfahVxlcDZVeBKPWLlVbavfq/58sDVraoK0BnYUKx/rm96yQKQXKiVmMSQp3PDCA6r5Kmlm6vX5N1CU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MVzoA2ds; arc=none smtp.client-ip=209.85.167.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-539d9fffea1so5854498e87.2;
        Tue, 29 Oct 2024 23:44:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730270662; x=1730875462; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=S8LuPiSu7wFtVCRkCbuWOFPZfKo40h92poaJRDjY0b8=;
        b=MVzoA2dsF99t95Yv/Xz0FeQTqW9DT360JeMgJ0ueDzWvKObrySX+RVu0KW5N/u0gjz
         V6q/RyLK4kmA1Ryn0AbBtrvk3bH0oH7mpFHG/IncfqMUrbGweiX7ZMKRSkXJHnNibMJE
         Op0+9OjwyE4MdXoqvz1JDhy1XnRhdYooCBqTltaSjoi/GtoDjrLQ2dcCREjqCo7eQ8vu
         2B6u1Fd7O/nEFOxmlz5Ei7ttq2dMDUDKQYoQXwnG6pWpI2IYIMoTQQ9K46fAYg+Mjtb3
         JSw+O0+/b8Yg+7ls++lmX2fN+vCYsqFMFeQ4QucnDdGIHj321JrGP4Yrk5/pU5KAhpuX
         JSug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730270662; x=1730875462;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=S8LuPiSu7wFtVCRkCbuWOFPZfKo40h92poaJRDjY0b8=;
        b=qtTh+LrOtCOM6NJuFSzjplvI9Tljjq9DMzFTXhMsDbo4Ye/D1CbnQnw4ARpVSJdmmg
         2dKYZDLgNKAlL2StFCTq1aj2sgSybS9TPXMJTQMIrZ+UmOQYo50u77YYMz9Ey+brTarw
         NW+EGla+wQkqYUEvMz9l02gwztbw6J9H7TxFnKognQ36wk7Q56JzDidJWRFi0gPynWIy
         H7vOkpQ1SN1JQ7et/tKrsID9x1VCuWeN9G9BqpD4oj1eYSUKneiQemcItikvtLgFek3p
         RWsPv1p7xCAhMCs10ne/1ok78aSUf9WGyNsDXVp+nffW7vn0L1liTeBWziqUcQbhElQZ
         2pWA==
X-Forwarded-Encrypted: i=1; AJvYcCU1CCwkLJM0JyUFEhtcW7LQbDeGd712csZQpbGU3OcVECstHFu11TH1tEx6EDOuoe3GUHWyA1FJ@vger.kernel.org, AJvYcCU4S4VSmZUlPykf1EAGXwRXacUSZzu6/3EMiWizvTeweftneMwwxirzEHw05Bs2kvvEE4Y0agpzMnc=@vger.kernel.org, AJvYcCXOFmAhv3s/0V+H5pRB2wt6p9PFi+s1R8Vk7x0cMWEB96Il4ktaL111KVB5l7YqMZJ8MlOAdKRu+BygXSs=@vger.kernel.org
X-Gm-Message-State: AOJu0YymjZX8evltyg4ZQ/KDE87HFU+kQE/4fFhA18EeTM+kbv5cu2+Q
	iymxNMM5qLCj0xL77HkJbyE4FkTIxBi5VOrdCEx63gQewOjLAAsVfL4ZNKF2
X-Google-Smtp-Source: AGHT+IGWhVQIhV4BdDIT9PkTI8qrQQX12NQPVSDcsmyAO931TnpfZkEuwVFFDyI12BadGeJMbiXo2g==
X-Received: by 2002:a05:6512:3caa:b0:539:e88f:23a3 with SMTP id 2adb3069b0e04-53b34ca488fmr6256607e87.60.1730270661384;
        Tue, 29 Oct 2024 23:44:21 -0700 (PDT)
Received: from [127.0.1.1] ([213.208.157.67])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-431bd9ca704sm11249655e9.41.2024.10.29.23.44.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Oct 2024 23:44:21 -0700 (PDT)
From: Javier Carrasco <javier.carrasco.cruz@gmail.com>
Date: Wed, 30 Oct 2024 07:44:09 +0100
Subject: [PATCH 1/2] cpuidle: riscv-sbi: fix device node release in early
 exit of for_each_possible_cpu
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241030-cpuidle-riscv-sbi-cleanup-v1-1-5e08a22c9409@gmail.com>
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
 Javier Carrasco <javier.carrasco.cruz@gmail.com>, stable@vger.kernel.org
X-Mailer: b4 0.14-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1730270658; l=1134;
 i=javier.carrasco.cruz@gmail.com; s=20240312; h=from:subject:message-id;
 bh=BckDlgNxXN37WM9rRTU+h45QD44ycxfdprrjTJEpleg=;
 b=ujl2h06lGh4YP2Y79CiPlMHPbox7pBxEij20AzVxtyPJO6YkpF6IXkkR1VQPlWKQticw+fNHm
 BmWt+LqTvfWA8Vjuu0X/60D+gHiHeI69Qr32rb1foKW4ivVqq8FVgUK
X-Developer-Key: i=javier.carrasco.cruz@gmail.com; a=ed25519;
 pk=lzSIvIzMz0JhJrzLXI0HAdPwsNPSSmEn6RbS+PTS9aQ=

The 'np' device_node is initialized via of_cpu_device_node_get(), which
requires explicit calls to of_node_put() when it is no longer required
to avoid leaking the resource.

Add the missing calls to of_node_put(np) in all execution paths.

Cc: stable@vger.kernel.org
Fixes: 6abf32f1d9c5 ("cpuidle: Add RISC-V SBI CPU idle driver")
Signed-off-by: Javier Carrasco <javier.carrasco.cruz@gmail.com>
---
 drivers/cpuidle/cpuidle-riscv-sbi.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/cpuidle/cpuidle-riscv-sbi.c b/drivers/cpuidle/cpuidle-riscv-sbi.c
index 14462c092039..2b3aec09b895 100644
--- a/drivers/cpuidle/cpuidle-riscv-sbi.c
+++ b/drivers/cpuidle/cpuidle-riscv-sbi.c
@@ -513,11 +513,14 @@ static int sbi_cpuidle_probe(struct platform_device *pdev)
 		if (np &&
 		    of_property_present(np, "power-domains") &&
 		    of_property_present(np, "power-domain-names")) {
+			of_node_put(np);
 			continue;
 		} else {
 			sbi_cpuidle_use_osi = false;
+			of_node_put(np);
 			break;
 		}
+		of_node_put(np);
 	}
 
 	/* Populate generic power domains from DT nodes */

-- 
2.43.0


