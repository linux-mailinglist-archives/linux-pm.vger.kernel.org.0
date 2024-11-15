Return-Path: <linux-pm+bounces-17661-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D27649CFB35
	for <lists+linux-pm@lfdr.de>; Sat, 16 Nov 2024 00:32:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 582ED1F24591
	for <lists+linux-pm@lfdr.de>; Fri, 15 Nov 2024 23:32:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2389190063;
	Fri, 15 Nov 2024 23:32:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LvJqP35L"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18D2A185B58;
	Fri, 15 Nov 2024 23:32:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731713568; cv=none; b=VZOsOCGO2zdZcQM5I73KfjAWScyiMo+AAw3xqsVtTAL0NPhIULEBBzAFdutauavo6uVR9z6XsV0/7tVRpbckAlMIbNDmEM1xMtBx/TdVLt8bPFkN+rKjXJJlow9UWdCQlGPYB2IwKAz7mNPMNyUf7lLtHaZid3nZ7bIDID/0leA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731713568; c=relaxed/simple;
	bh=OSD+oIIobbkjTj3wZizfrrejaW10Hs0ipasM8FAF5aE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=t18kajqLVJa8xfyKivFeowJLeKkInqOlBG2jQnJL+2A6lxuiSlSG0oVtfdZa//XfAoQ+xJN4znqUMQudtYHGFz7PNcwtL6PeuDrrFB0KHgIS/wiKY8zRKwPbkzBQO+HeSocRkGSuBEnHSyuRw+R7AjozJThRB3ewupcQ5wonKw8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LvJqP35L; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-3823194a879so350644f8f.0;
        Fri, 15 Nov 2024 15:32:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731713565; x=1732318365; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Bh6tDwODnq8Uz0ftqgMQifASUmQBQRHrNSlc/NxcVPs=;
        b=LvJqP35LnRr7/8KClpH0fiAlLW6r4vKT54ZRcq+E4F8wqh7qA/s7lM/+6kUoB/vQFl
         9Hn73xxAOdPg1b8I+57bsAKwK+0cQYDw0/upwxeirtuP3EL2han/lYV9oWI+enFo94Gm
         idZ3SMxJBdeK6TshTD3ARAFbeJOeOrX68m9rXG1QKtsRRnrIuph6FFdJeBN8Z5VA540G
         S0t3Q0ExJRZN16HuLhH0Y6r3HVODjVFw70bqaKusMVBz9BlQ55VPqImzCrRabR/3seZw
         IsG5UDzQcUPuCRodLBjjodvb2MG7dPLXV8CQzWeL+UN/RfIwc2SfOb0x0fnMrI/D0QVU
         5WLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731713565; x=1732318365;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Bh6tDwODnq8Uz0ftqgMQifASUmQBQRHrNSlc/NxcVPs=;
        b=aBPMAu2N49ceb8z3v2DfRfHT0lHlyJW7YyMA2eMSM3JfmaLideWu1JlEzL7QyGlz5U
         xHYYYItul+XGk21aelCBjKAoj37PdzEiHZIz9oQflSnNQZiPx0veyW8aMdf0X9xg/vAy
         6ySF7+3VsQRB5DWRB+M5aSrXqHYdFbLoq5+oM+ZkaBTqlklBI5x7H2dyKT+BRc5v8GFa
         wwplCC7onykfApoQDV5/vQWYzhHuSs9XzA3HEYFxna+yEemARxcfggZ+/BB9Ol0KCavy
         Axj3CRVt1OH5xVhQDe/zSBabYMLtfzh7taBzpV99P5EZJoLPvFquwJmZE0QMTL2LjBhC
         Hv/w==
X-Forwarded-Encrypted: i=1; AJvYcCXXHoKd2gOY72I0Z5T1OsDhp6dPA/wJClw4sLZjgEWpjmIF0m36q1xZBvFK5C0E8j3v+NLlUrLF+Kk=@vger.kernel.org, AJvYcCXkCLQ9r8cJvN1PWV4Z2r038hxb/Jt+Ojp/VemgqUhN+g/eTYA8tvKWrvip4B3VrcHCAtXCN5en7fOoR/4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwpqOYtNKVdo5QIwavexo2BZN7JNheB3NQa/Zx0/GrnHnUGUlmK
	ceW27wt1V4MuFu21Bjtl0+4OQpBUBAycaVPt83IAMmc4qOXQF/YiD+58cQ==
X-Google-Smtp-Source: AGHT+IF+13KXSUbKCa1sqaGVFC2eXYP/XSlFhfc3SaEKJ5GBSoOKuGlI1jesZSuVgFdztcKkZo8ZSQ==
X-Received: by 2002:a5d:64c8:0:b0:382:2276:c93c with SMTP id ffacd0b85a97d-38225a8a36cmr4291816f8f.44.1731713565042;
        Fri, 15 Nov 2024 15:32:45 -0800 (PST)
Received: from [127.0.1.1] (2a02-8389-41cf-e200-58e8-a69e-d502-6c71.cable.dynamic.v6.surfer.at. [2a02:8389:41cf:e200:58e8:a69e:d502:6c71])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-382247849b0sm3617373f8f.97.2024.11.15.15.32.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Nov 2024 15:32:43 -0800 (PST)
From: Javier Carrasco <javier.carrasco.cruz@gmail.com>
Date: Sat, 16 Nov 2024 00:32:39 +0100
Subject: [PATCH v3] cpuidle: riscv-sbi: fix device node release in early
 exit of for_each_possible_cpu
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241116-cpuidle-riscv-sbi-cleanup-v3-1-a3a46372ce08@gmail.com>
X-B4-Tracking: v=1; b=H4sIABbaN2cC/33NTQ6CMBCG4auYrh3TTpFQV97DuCjtCJPwl1YaD
 eHuAnHBiuX7JfPMJCIFpihup0kEShy575bQ55Nwte0qAvZLC5SYKYkG3DCybwgCR5cglgyuIdu
 NA5AptStNTir3YrkfAr34s9mP59I1x3cfvturpNb1r2p5oCYFEq4kC4voTCbNvWotNxfXt2JVE
 +4ldSQhKLCWcvS60EoVe2me5x9SPvP8DAEAAA==
To: Anup Patel <anup@brainfault.org>, 
 "Rafael J. Wysocki" <rafael@kernel.org>, 
 Daniel Lezcano <daniel.lezcano@linaro.org>, 
 Paul Walmsley <paul.walmsley@sifive.com>, 
 Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
 Atish Patra <atishp@rivosinc.com>
Cc: Palmer Dabbelt <palmer@rivosinc.com>, linux-pm@vger.kernel.org, 
 linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Andrew Jones <ajones@ventanamicro.com>, 
 Javier Carrasco <javier.carrasco.cruz@gmail.com>
X-Mailer: b4 0.14-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1731713562; l=2176;
 i=javier.carrasco.cruz@gmail.com; s=20240312; h=from:subject:message-id;
 bh=OSD+oIIobbkjTj3wZizfrrejaW10Hs0ipasM8FAF5aE=;
 b=CgLScY+fBx01z2OhvbnOitrjuXIF70J+E1fl1CA/E6YXlP/Lrjz6NKa4IET03JPGbMxO2h4kN
 4GLGXY52VRbAV2+a6go6DR6Y9mafHIFep3P44cBsfzvKGgTNaPxW6nm
X-Developer-Key: i=javier.carrasco.cruz@gmail.com; a=ed25519;
 pk=lzSIvIzMz0JhJrzLXI0HAdPwsNPSSmEn6RbS+PTS9aQ=

The 'np' device_node is initialized via of_cpu_device_node_get(), which
requires explicit calls to of_node_put() when it is no longer required
to avoid leaking the resource.

Instead of adding the missing calls to of_node_put() in all execution
paths, use the cleanup attribute for 'np' by means of the __free()
macro, which automatically calls of_node_put() when the variable goes
out of scope. Given that 'np' is only used within the
for_each_possible_cpu(), reduce its scope to release the nood after
every iteration of the loop.

Fixes: 6abf32f1d9c5 ("cpuidle: Add RISC-V SBI CPU idle driver")
Reviewed-by: Andrew Jones <ajones@ventanamicro.com>
Signed-off-by: Javier Carrasco <javier.carrasco.cruz@gmail.com>
---
Changes in v3:
- Unwrap line (100 char width).
- Link to v2: https://lore.kernel.org/r/20241031-cpuidle-riscv-sbi-cleanup-v2-1-aae62d383118@gmail.com

Changes in v2:
- Squash patches for mainline solution without intermediate steps.
- Link to v1: https://lore.kernel.org/r/20241030-cpuidle-riscv-sbi-cleanup-v1-0-5e08a22c9409@gmail.com
---
 drivers/cpuidle/cpuidle-riscv-sbi.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/cpuidle/cpuidle-riscv-sbi.c b/drivers/cpuidle/cpuidle-riscv-sbi.c
index 14462c092039..0c92a628bbd4 100644
--- a/drivers/cpuidle/cpuidle-riscv-sbi.c
+++ b/drivers/cpuidle/cpuidle-riscv-sbi.c
@@ -504,12 +504,12 @@ static int sbi_cpuidle_probe(struct platform_device *pdev)
 	int cpu, ret;
 	struct cpuidle_driver *drv;
 	struct cpuidle_device *dev;
-	struct device_node *np, *pds_node;
+	struct device_node *pds_node;
 
 	/* Detect OSI support based on CPU DT nodes */
 	sbi_cpuidle_use_osi = true;
 	for_each_possible_cpu(cpu) {
-		np = of_cpu_device_node_get(cpu);
+		struct device_node *np __free(device_node) = of_cpu_device_node_get(cpu);
 		if (np &&
 		    of_property_present(np, "power-domains") &&
 		    of_property_present(np, "power-domain-names")) {

---
base-commit: 744cf71b8bdfcdd77aaf58395e068b7457634b2c
change-id: 20241029-cpuidle-riscv-sbi-cleanup-e9b3cb96e16d

Best regards,
-- 
Javier Carrasco <javier.carrasco.cruz@gmail.com>


