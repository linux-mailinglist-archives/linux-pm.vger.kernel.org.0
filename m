Return-Path: <linux-pm+bounces-16827-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B7279B7A6C
	for <lists+linux-pm@lfdr.de>; Thu, 31 Oct 2024 13:21:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1B032285964
	for <lists+linux-pm@lfdr.de>; Thu, 31 Oct 2024 12:21:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4DB319C563;
	Thu, 31 Oct 2024 12:21:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mqR9rz9o"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEFDE14E2C0;
	Thu, 31 Oct 2024 12:21:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730377287; cv=none; b=Jgi2C+x7T6Cd01HTsBGWR21XAtWWka9jCg+4T5Cg2Zn3FY4FDgkwoMp4sYHSDvITkwa/Uaqo8VOxFecKhCZrcoSZ2YS9mmCogI9iSV+lsVLNl0n/8yqyFPpkNngpWdVAlWIi1Nn/xLG7BXRJvxlRDXuynmxequbVHnorESiK7o4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730377287; c=relaxed/simple;
	bh=z7qRdrc/aNJJoVPFpdm9WaJa+syCyVzHfCsRPb9pirs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=rQDvWox77sYLsId9buMqS4tE3Aj8mObJDYQLHsCn6K/XoU+hqEReB20nzBxPkZfjQ3yq1ZExRgEivI34YmgOlT449UT1StSUI1Wc35WRgl9xKOS77zLQMZM+uIAV3+T2jVGnXKcwllHRAJ0L+/BqE3k41aOEWt7utmw4uUJA3dg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mqR9rz9o; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-4316f3d3c21so6842165e9.3;
        Thu, 31 Oct 2024 05:21:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730377283; x=1730982083; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=tifA01aEwpCB7k+rl2olkAmgjeZifjZgKwXOFawd/9Q=;
        b=mqR9rz9o/bjjAzc6PINtEcvflhJVJ1qvAx0NEmEWS6bqNmzx5Jtxv6a4UBRSsT9CuR
         QElwqmkA/2/YUfCj1UrTxtR3U42e3lIXh44O5POdDEJuWsbFsYbx4i0HfMf63kicpShN
         iwcR5Vj5+fT3zbFwr/UBPjsJ2rh6AvrxKrYebOkEX0x+cEiMgHx6X+Ac7bKaC82K3eIN
         XjyDKMzJbWbuAfdAQC9honNUpWnl2KcJA2q84ja6cFApgNxLqePDOupaa1C8R7qqBN7K
         TJRYY/HxNjnBy8tlPfZugwkX7jiHrTjwaDFrWqt8h6XDVNz2ztBSVqKPsX7EdAh/5m9N
         qUMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730377283; x=1730982083;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tifA01aEwpCB7k+rl2olkAmgjeZifjZgKwXOFawd/9Q=;
        b=Z4J8ZeKSMVW0vIXZHHAxRVS8mxu4ajCfNvCbDCxiGDseDELsLC94lru0MTiQpda3Ko
         l+gpW9p3BHK4oum5KvExqd57Y/A64+Rsevvg065+5bsKn1JAhPjwesOoTm6OCD548yMK
         M6cn4sm18/yyppZD86MhDGBbEAu4/tZ5T91DHkvwPciPZ4FKATWLEdEMtMbnwSEgEpta
         5N/y7DqRCkqL1S6ai0HYhFe1ywnE15oJXgvGg1X1Uj5Gi7YxONxEv/lCljkMrAh2fsOL
         Z8i9LsjADHIlCOh59lRLELiu78b9LzSb+AbO6DT9w6J+MXCM9+vuLYv4kxz6iWnPggER
         SwDg==
X-Forwarded-Encrypted: i=1; AJvYcCUJr2CMSjUo4q/rYS2CtA8mpnartdZfAUoSBfazRLP6SDr0gyfV6wk8U/c4zF2HRfjLl5F/hFQ4bc6mw3w=@vger.kernel.org, AJvYcCVXEm0uAJYhyuZuizb+GEZ/Z3RZM22KK99lOIx4YvU1kkNzu5f2IoB/P8mwc5Fq2nds3kJsFXcGfsk=@vger.kernel.org
X-Gm-Message-State: AOJu0YwM0XnHUYGNwt3rJ0NocLkAHU5jtE1UIoaonYyHmETU2npJf66d
	WdgphugAF/nJsmo/X/93cRONDIuppmuM8IK5Lh8zjnTFmDvHIVqsJVpmoj01
X-Google-Smtp-Source: AGHT+IHBp1TxQM76X7gohSGb17rZI4WDJf50xd41RLJtG/+yD5bf+XGvKdhWF0CXlWSUO85e3Qvd4A==
X-Received: by 2002:a05:600c:19d3:b0:431:5044:e388 with SMTP id 5b1f17b1804b1-431bb9d0aeamr60992515e9.22.1730377283328;
        Thu, 31 Oct 2024 05:21:23 -0700 (PDT)
Received: from [127.0.1.1] (2a02-8389-41cf-e200-d7b9-afdb-c541-d023.cable.dynamic.v6.surfer.at. [2a02:8389:41cf:e200:d7b9:afdb:c541:d023])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-381c10b7e1bsm1975728f8f.1.2024.10.31.05.21.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 31 Oct 2024 05:21:22 -0700 (PDT)
From: Javier Carrasco <javier.carrasco.cruz@gmail.com>
Date: Thu, 31 Oct 2024 13:21:17 +0100
Subject: [PATCH v2] cpuidle: riscv-sbi: fix device node release in early
 exit of for_each_possible_cpu
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241031-cpuidle-riscv-sbi-cleanup-v2-1-aae62d383118@gmail.com>
X-B4-Tracking: v=1; b=H4sIADx2I2cC/32Nyw6CMBBFf4XM2jFtQWJd8R+GRRlGmIRXWmk0h
 H+3Etcuz0nuuRsE9sIBbtkGnqMEmacE5pQB9W7qGKVNDEaZQitjkZZV2oHRS6CIoRGkgd20Lsi
 2yamxJeuyhbRfPD/kdbTvdeJewnP27+Mq6q/9VXP1pxo1KrywujpjyBbKVt3oZDjTPEK97/sH7
 jkudcIAAAA=
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1730377282; l=1974;
 i=javier.carrasco.cruz@gmail.com; s=20240312; h=from:subject:message-id;
 bh=z7qRdrc/aNJJoVPFpdm9WaJa+syCyVzHfCsRPb9pirs=;
 b=CB9ImtE+5I0MlaIX2MMtoX1tMIgGy+QmeqoCgGwhOl6uPJ//3TZYqNIhCtenKmP9r5lbBf99l
 Wiw5cWse1/6ApwFEAY3rtmazsgzl3CVlgSV3VpPNZdA+lgRrQprlUkw
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
Signed-off-by: Javier Carrasco <javier.carrasco.cruz@gmail.com>
---
Changes in v2:
- Squash patches for mainline solution without intermediate steps.
- Link to v1: https://lore.kernel.org/r/20241030-cpuidle-riscv-sbi-cleanup-v1-0-5e08a22c9409@gmail.com
---
 drivers/cpuidle/cpuidle-riscv-sbi.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/cpuidle/cpuidle-riscv-sbi.c b/drivers/cpuidle/cpuidle-riscv-sbi.c
index 14462c092039..3a78d6b7598b 100644
--- a/drivers/cpuidle/cpuidle-riscv-sbi.c
+++ b/drivers/cpuidle/cpuidle-riscv-sbi.c
@@ -504,12 +504,13 @@ static int sbi_cpuidle_probe(struct platform_device *pdev)
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

---
base-commit: 6fb2fa9805c501d9ade047fc511961f3273cdcb5
change-id: 20241029-cpuidle-riscv-sbi-cleanup-e9b3cb96e16d

Best regards,
-- 
Javier Carrasco <javier.carrasco.cruz@gmail.com>


