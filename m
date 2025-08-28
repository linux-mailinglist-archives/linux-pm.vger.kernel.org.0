Return-Path: <linux-pm+bounces-33338-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F2FCDB3ACC9
	for <lists+linux-pm@lfdr.de>; Thu, 28 Aug 2025 23:35:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 24A99189504C
	for <lists+linux-pm@lfdr.de>; Thu, 28 Aug 2025 21:35:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91423284B41;
	Thu, 28 Aug 2025 21:35:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ijr8VXhy"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC47126B96A;
	Thu, 28 Aug 2025 21:35:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756416906; cv=none; b=SrUe/OLv5SmxX9HWqmaAOnMTiJakaSytSvHKNfpmG5IokhjxnXsuFtYALnY+MQD5cjqN3DC7fqTPD6M+ZRu1SmHFqzMy81/xnwNgqJt2JGwOQWvygkZ+opwqXXYXME5wEswyi62rHrvfTCf9V/G6TkeAdX7IBnZw4Y7X6hNayMc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756416906; c=relaxed/simple;
	bh=I7wEGxMZdqIIi5xw7IylI92kj9j17xHEIgaigxtGPcs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=D1kExjRlQCLsz8qfyi0kHKCqEsReD8ChHbzT3Iotuu3TkKy5s3EGrh/38gxOuzlUTsxPjSoFZv/rYyTlYUomryyuEv082sNHM5PKmIYFiJxNFucOM+j2Lyp4teTXMn7nacCj+FKqZpbQBQxxrSugtfVLiWpSp/IrTFMJcHBkQGM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ijr8VXhy; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-afe9358fe77so151330566b.1;
        Thu, 28 Aug 2025 14:35:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756416903; x=1757021703; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=R6RgA1Amq2gbjziZJHa66M8vo8i+nRkKhXZ8PDenMzI=;
        b=Ijr8VXhyp/0dG7zVlTKYc9eIGUTtNsZGCY+gBuh0DJ8TBEfnbf1ywdFM/S24muYKTG
         sZm31NUv11IIKmJw96pjqMY4BNfkPMnQfWvBcnJrhQ0yEu4NlIDluV6AtuaW//WumOkE
         htk4rG/F3QAgKYkeFJsRMX3zQSxoB7eXcRyhNUro7I9CPJ6HhvJWqDAdyQcI/1Cz8f5V
         eByYwxxi5AN0Oj6VOMBbKjUjzK9gqY7+tidYUgDUp29Ky9OkhpdUZB9KzAYbOf5X3FOU
         DkVdXGF+iZl3J36XSmkZA1IWT19uhi2dvWJi0PBkAJCQ5oR9lwqOFQJbkrywz4Rt48s3
         vqUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756416903; x=1757021703;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=R6RgA1Amq2gbjziZJHa66M8vo8i+nRkKhXZ8PDenMzI=;
        b=qZ3cZU6AXUlXtmABx071zfyJWnAWnXvgmOGjUVG85FSJ322TpolcUknBwq37u4SzmU
         c+BIN4B0tp/WR+hPFE9azBJdfEt9gFWCFM2ni6lfRjCAU+Zy1qwFwYF6Nb8qUf4VqsXO
         L+zpb0UT9Cr8f7ICEHx47Viyxl8GW4RqMSwN1aSgIQ33Ruli1jp8sl7eYMtPShGRFISF
         5QyJ9kJ1m4mgu1eRCJ9aaY4W96t6beWiUBIdYj1njJ23gBPLw9ggDkPk24N2BiFDwctd
         cVF4hOFp1/54ZDWzFr/nXSAEA+42+SUp+cOxXJsUKXbm7DkKnrLF5/SFmYrfhV/JhxB4
         Uaqg==
X-Forwarded-Encrypted: i=1; AJvYcCWx57evTdzTu6RuUtbgdDg6xmpvBbNGV7+bx55LnirCaHv4RLzvf7TIuJ6EW9W2Y1h6lyEPSr1SF5nNPrQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzhtLPLYa7a/kshFIUVBLS2CHHFy20IzRebjsaKHnng4QkLIbwe
	PzXqYPiLQIz0DrN+JxQInog7UTdt3t7AUtXRgCMOMjYyDuvw4z1YBjmF
X-Gm-Gg: ASbGncuQFu8bTpJXWEs5WcMWeopEy5SqKJVKNWUZEJaTywJrfvBt54Ptio2kAGbct8w
	yi34XoZjn3MLIjKN8ANaWXZeAXX7cHE3Umk/UtNmpKsC3PO1PtzPdvDMwcVQNghPdBg5YBhTCw1
	JP5tjNTdM9SLgckY5yHx5Lln06SKEIwGQkDTrluN0/5+V821aBVwf+RpEgByiKL3RWR/Wdp3lJb
	XxMeAYF/GBREk+M1rOIMatZbiHx0bek1ROZFVBNiblOGp5D6wtWx5b3HqeGNNfy+QELa920PbHj
	36cPD6PjX/UtVEveeV3k6aQnmQowh45Uu2QtY7VLglCAJfZEuJx+wHAYy9nBeiZEuiD9gHaVErX
	TAewBitAQoxfVLIRVlL02Mu1TjlRGxRdR68EbUBBh73Othf9gv1e701IIus9UdXYP0kXTtQVgHz
	HWzUoIIY513scPREx6+7O3STMkHZAnTSL2
X-Google-Smtp-Source: AGHT+IGsOjVY1xHlu7Ck4nnZUfJdc0rldLUjOBL0O+XsSoXmmaDai4XSpeQvLDGVBVp9yQQrqrCOBQ==
X-Received: by 2002:a17:907:970c:b0:afe:af91:2e44 with SMTP id a640c23a62f3a-afeaf9139e5mr1005452266b.14.1756416902804;
        Thu, 28 Aug 2025 14:35:02 -0700 (PDT)
Received: from fedora (2a02-8389-2240-6380-b418-985e-6bb5-99d0.cable.dynamic.v6.surfer.at. [2a02:8389:2240:6380:b418:985e:6bb5:99d0])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-afefcc1c6b9sm45032866b.80.2025.08.28.14.35.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Aug 2025 14:35:02 -0700 (PDT)
From: Dennis Beier <nanovim@gmail.com>
To: rafael@kernel.org,
	viresh.kumar@linaro.org
Cc: linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Dennis Beier <nanovim@gmail.com>
Subject: [PATCH RESEND] cpufreq/longhaul: handle NULL policy in longhaul_exit
Date: Thu, 28 Aug 2025 23:29:36 +0200
Message-ID: <20250828213427.27593-1-nanovim@gmail.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit


Resending this patch to include cpufreq maintainers.

---

longhaul_exit() was calling cpufreq_cpu_get(0) without checking
for a NULL policy pointer. On some systems, this could lead to a
NULL dereference and a kernel warning or panic.

This patch adds a check using unlikely() and prints a warning
if the policy is NULL, then returns early. Also, the loop variable
is now declared inside the for-loop to match modern kernel style.

Bugzilla: #219962

Signed-off-by: Dennis Beier <nanovim@gmail.com>

---
 drivers/cpufreq/longhaul.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/cpufreq/longhaul.c b/drivers/cpufreq/longhaul.c
index ba0e08c8486a..9698d56bfe6c 100644
--- a/drivers/cpufreq/longhaul.c
+++ b/drivers/cpufreq/longhaul.c
@@ -951,9 +951,14 @@ static int __init longhaul_init(void)
 static void __exit longhaul_exit(void)
 {
 	struct cpufreq_policy *policy = cpufreq_cpu_get(0);
-	int i;
+	if (unlikely(!policy)) {
+		pr_warn_once("longhaul_exit: policy is NULL\n");
+
+		return;
+	}
+
 
-	for (i = 0; i < numscales; i++) {
+	for (int i = 0; i < numscales; i++) {
 		if (mults[i] == maxmult) {
 			struct cpufreq_freqs freqs;
 
-- 
2.50.1


