Return-Path: <linux-pm+bounces-32080-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 83C51B1F45E
	for <lists+linux-pm@lfdr.de>; Sat,  9 Aug 2025 13:28:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8B45A18C7560
	for <lists+linux-pm@lfdr.de>; Sat,  9 Aug 2025 11:29:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 010222777FC;
	Sat,  9 Aug 2025 11:28:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YNkVchFu"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DCCC246779;
	Sat,  9 Aug 2025 11:28:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754738926; cv=none; b=OEWUNavuBIAKhtRQ6cclmG0CX5nEwBxJfoNNR/fCuZ5Mi6KvXK7qMTmX2W8V0qzMHKVlbN8TBgwXlUF0PMSbK/APyV0I/P4buZ3Cl5uoC4CbeT0diGNM2JvkKEaiXi0/ePwqJqYKnYnLnm+VyZW4/GdYZPZxAMWc0DJ3Aa0BVg8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754738926; c=relaxed/simple;
	bh=YAcz0GI6lmhmLOzPOdOzpzMapTDL/z/W8wLkh75SQL4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=r7FVCokpH1EFtRCYplsoOLxX3e+VVIXVzNFviob1hw+UO7k7R2m0UxjJrsKrRfsNTm0651VIUnukxqk4ZEWFIN2yYK6uSF2DiuyNdmd2FVtxJ1Kj2/V38oCd1LlPC/xwFmRxUMAF8g8deAmU/8Z9bjnov8zQwCzSVn5BQhuXSRk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YNkVchFu; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-459ddb41539so10101725e9.2;
        Sat, 09 Aug 2025 04:28:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754738923; x=1755343723; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=6jUBDNtcZUdQBqv/XouqcNisEUoX1i6dcMgd7LXXpWM=;
        b=YNkVchFubTECVJH1SPEIiYX017yGCpF5xXj1zfAlju1E3//dFpDwSRl6zCgn2xyuQy
         UKrvIPYHV7v4tnT++2Po1kbTP4FENDf5jQPUBkfARpNc5gPYF76jQVnGHUyE9WJY3bZk
         MtGeos3ecyNf4NWc+iQH9/bz/OLnX76gOxFOb/tDdRnRC0QsPs8PDIxk4GPfhtpxS80Y
         hRPbdDX/ugHU4rSkMZeLFya9CHMGkWgUBCCrbDr5pJ+aF/Ev3zcj+1D438yzg5OzHQGx
         F6oqGlv9tKGgF2nuDTaQvjG+HaVB+NiJK3PQM2raza/0TZIVet34fr4BxETi0SIk9u+e
         DM0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754738923; x=1755343723;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6jUBDNtcZUdQBqv/XouqcNisEUoX1i6dcMgd7LXXpWM=;
        b=TmXYjHJmKY8+N4T93zYkPpEKdW2dsdGvtB94HtOwoWpmmEks0itgb2FUG3vKYHifhl
         Ym4KjGJWg3EAE/p3jFMsYYmWiVNQYB2sYN5WCgMREEHYWpGu61iUfF6uRVDlhv1pjeJ9
         xlxQecpqZDaLtNJU/+onxrT0cMzdbdQAG2E86I9+nMagBJA/A2mV9gxQ4bQzQNG1QiW/
         A9JJZIx44Lj1Ux1zcT27keV+6qntKeJq4NcpdjOlWbEUKZAxtLojqteHTM8gLQO89lFx
         7FGHcuBlA8WYB9NgLeC4aFUAQfttfTpQfqRFnBk8EYSWwDSUbdFlYSzsHBhx+V+nopZq
         MnXg==
X-Forwarded-Encrypted: i=1; AJvYcCUUG712c6yQcP2eqQc1OFZd3ENHtP/CqWrpu3/SACr4ymEiOjx+eM1YulYV5RzTDQT+KCzvNOlJgdI=@vger.kernel.org, AJvYcCVod+KVv6VDhoHjIfJ1FNp/nzvvoPyd0xwNiw3tfEIRKexLNvsx8M3Pbwbe2l7BxdjMqzkKsi36M50T8iw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzoyV+VygECWo866BdjWReXiNZkJBqS1FJD6/BkKhL47nLnxhgC
	zubWHDX0imSyeHc6YhjX8JgdbBeVGLTeCaWf+WAWpoQOoIieGMD32fbh
X-Gm-Gg: ASbGncui3HdG7b5w1UYy70tg7nfRronblNfnvccge/Jxnlp9uRqHhsnrVOq3BO5Gc+A
	xBseB8NnXzCrCfmqPDKXNNWCsE1X0V8IJH6IN5c+y/hOCJBXrSTTD1g+TviDr4qGOfnLV2v2YS6
	VQObJZR1DvYyyYIFr5AYUzhHmQ+JtC3wI8ATxhwlGHWiy0kzU4wM2lEMF3SLT+ZnhTAMZ7rzydH
	MbBvopQFj/SsGFdJg0i+W2ximy/ZwpuO0Yv5Q/sE+DPjbN9E84qJwC8DF+ZOHfpwiFoWufi3HoR
	3x04GNS7rUwy3if8VoV7WfZOplvOkah4tl014sjQ4Javeh3I2KxhQ0I/UPvCKkOd57O4lrBSS75
	szjh8DypmayfUR9M7Yvd96nC4/c4rjl0nkN/oFYJyz2dJG3EjWkh7OjztBaEc+lHlvwxjmWE9eT
	tPDg==
X-Google-Smtp-Source: AGHT+IHGpAZN88lSkNQFhW8Q7CX8cvPXLBRCvqb9iAebcw24MmuPgU9OMUjXhEiZ9pvM9mcp8UqlhQ==
X-Received: by 2002:a05:600c:6286:b0:439:86fb:7340 with SMTP id 5b1f17b1804b1-459f5687c58mr62609365e9.30.1754738923262;
        Sat, 09 Aug 2025 04:28:43 -0700 (PDT)
Received: from Ansuel-XPS24 (host-80-181-255-224.pool80181.interbusiness.it. [80.181.255.224])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-458f713eb44sm293650725e9.14.2025.08.09.04.28.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 09 Aug 2025 04:28:42 -0700 (PDT)
From: Christian Marangi <ansuelsmth@gmail.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>,
	Viresh Kumar <viresh.kumar@linaro.org>,
	linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Christian Marangi <ansuelsmth@gmail.com>
Subject: [PATCH] cpufreq: airoha: Add support for AN7583 SoC
Date: Sat,  9 Aug 2025 13:28:30 +0200
Message-ID: <20250809112832.15830-1-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.50.0
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

New Airoha AN7583 SoC use the same exact logic to control the CPU
frequency. Add the Device compatible to the block list for
cpufreq-dt-plat and to the Airoha CPUFreq driver compatible list.

Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
---
 drivers/cpufreq/airoha-cpufreq.c     | 1 +
 drivers/cpufreq/cpufreq-dt-platdev.c | 1 +
 2 files changed, 2 insertions(+)

diff --git a/drivers/cpufreq/airoha-cpufreq.c b/drivers/cpufreq/airoha-cpufreq.c
index 4fe39eadd163..b6b1cdc4d11d 100644
--- a/drivers/cpufreq/airoha-cpufreq.c
+++ b/drivers/cpufreq/airoha-cpufreq.c
@@ -107,6 +107,7 @@ static struct platform_driver airoha_cpufreq_driver = {
 };
 
 static const struct of_device_id airoha_cpufreq_match_list[] __initconst = {
+	{ .compatible = "airoha,an7583" },
 	{ .compatible = "airoha,en7581" },
 	{},
 };
diff --git a/drivers/cpufreq/cpufreq-dt-platdev.c b/drivers/cpufreq/cpufreq-dt-platdev.c
index a010da0f6337..7a01c0ae904a 100644
--- a/drivers/cpufreq/cpufreq-dt-platdev.c
+++ b/drivers/cpufreq/cpufreq-dt-platdev.c
@@ -103,6 +103,7 @@ static const struct of_device_id allowlist[] __initconst = {
  * platforms using "operating-points-v2" property.
  */
 static const struct of_device_id blocklist[] __initconst = {
+	{ .compatible = "airoha,an7583", },
 	{ .compatible = "airoha,en7581", },
 
 	{ .compatible = "allwinner,sun50i-a100" },
-- 
2.50.0


