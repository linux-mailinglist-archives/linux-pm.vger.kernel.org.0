Return-Path: <linux-pm+bounces-10787-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C2C392A81E
	for <lists+linux-pm@lfdr.de>; Mon,  8 Jul 2024 19:15:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C91C9280FFF
	for <lists+linux-pm@lfdr.de>; Mon,  8 Jul 2024 17:15:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31769148317;
	Mon,  8 Jul 2024 17:14:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="e3HDmOWM"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com [209.85.208.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 761F5146D74;
	Mon,  8 Jul 2024 17:14:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720458890; cv=none; b=LfAG03Qv9GDI7iGxeA1R7M62MlD2UyL6yaZsEBn3I4hjI+oLjlEiw9wHsxFkxt4779+3o8CeWiJEU6UftsSEqpO1dPzuiQnjsABp9XPFv7kU/LLFh3cOocHzQ8TvdOx2EYPqLL0rufUHGBBfbKDPdSXWyIPbKYwLSOAPRZu/ECY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720458890; c=relaxed/simple;
	bh=98KZVehEnsd3PhQXr987y4Edy9ytXgP3wLgPB/Ivc0Q=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=GZ4Pm1VLUVJvXWS0OROVNHaWy42oM6WzzzZDt9ChvPGyNKF8U+3RwiCp+k9xxlsmqNYVz/r1XE1giXQbbDmEoJwUeH1cMrNd5tEARJqOgeQw3jYGrASwRLSA1vieoqCUlRsLdkYUf5drjoj4kj1RfXBi6eEcp0IX+6qWmb/yM0Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=e3HDmOWM; arc=none smtp.client-ip=209.85.208.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f178.google.com with SMTP id 38308e7fff4ca-2ee8911b451so52117271fa.2;
        Mon, 08 Jul 2024 10:14:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720458886; x=1721063686; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=AH6LUdcBA2pznTYvrbFIdQvAbh5slbBjvxCpyNIT8HU=;
        b=e3HDmOWMCNOKg2k+JYr3F5uQkV3ja3LD3R9d8yoD1NJxM6UZjlcNMzhfJ981sYkeZi
         EwLjgFS07FfvIeOCkFHv6nHaCrnz8kzvVwQSIP2fLDA86QoNhXhsp7BK6h2e+Pe74WVO
         ObUlWPdf4u1hlbdRR3vZxt6vvkeH3UhD7SRpA8BG9PcYUc3SaOdLeWbu8tHCPXKFq1jd
         cmS1sZinnVRLegYqAfbrgOLZoBEuiE48wFnF4oIwRYnnKNwb/Q5b65N0hNumvISk4/BD
         a0rSdp4iB/me7BemB8aeML7otIh32DewcvhOWWqsLkuQmBJ3apPF3Rf2JbZzTY3B0aaH
         RUZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720458886; x=1721063686;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=AH6LUdcBA2pznTYvrbFIdQvAbh5slbBjvxCpyNIT8HU=;
        b=ItiDu4h9o26rHcftxkWryUNqaOZmtw4cnhTfeOCpvtud+EiHLh5WnvbSS6gEl78N5I
         i6LepZya0lf+oBeLFooRbK7ce8ZMpUnkVuCQIXzq2an1kg76YyN3pdTUmXeCLFS5A40z
         /sYdJ7ZaqjWIf6PUMAZqHONlpLifpPZ4UtqNBbRH1DvMIsD6O8kgXsj13E47fYchnwdH
         1zPCEHdATJ7XoELqibIn96rkdzaBukt2nk8nTyU6Voc16UZbYNVWnZqt+ND3xLxQ1Nvz
         Yc4EaPGGVz1LqjNRIj0m3XYpxhH39CmCVO5Sl0sDqjQ+0/Rgasd7Zja/jZ/0KVOV4/ia
         954Q==
X-Forwarded-Encrypted: i=1; AJvYcCVlzTvlLUstUPrx+4UHElc11K2hxXZqynQTgjBCdq+uBi8Hjh6MdZd8DIq4f3/lRHCrnxBaAvwTz7UfkBE+aTTb+00hn0uLdcBihMvNmrhVsP09JcNIieeUTUmde0cncaq7jBseMVw=
X-Gm-Message-State: AOJu0YyA8hCYdgCnCG5+dnb2hrMAY1cQ3mjE9oTrHf6xxH8NeE7tBsqt
	d1pIRtCZkYu639IrcSqCmj0loWDMjxNedHwoCPJ37T3s+w3m+aLa
X-Google-Smtp-Source: AGHT+IEN5DfkubDT5gfgqNhNr0gKh0isbiFIhj+wDr5xuXU5SvAS70bUQlCMHGeHRici2j9JlCnHmQ==
X-Received: by 2002:a05:651c:4c9:b0:2ee:8171:8e13 with SMTP id 38308e7fff4ca-2eeb318a3a4mr2723491fa.44.1720458885961;
        Mon, 08 Jul 2024 10:14:45 -0700 (PDT)
Received: from localhost ([2001:861:3385:e20:6384:4cf:52c5:3194])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4266f6f5a27sm6034055e9.23.2024.07.08.10.14.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Jul 2024 10:14:45 -0700 (PDT)
From: Raphael Gallais-Pou <rgallaispou@gmail.com>
To: Patrice Chotard <patrice.chotard@foss.st.com>,
	"'Rafael J . Wysocki'" <rafael@kernel.org>,
	Viresh Kumar <viresh.kumar@linaro.org>
Cc: linux-arm-kernel@lists.infradead.org,
	linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] cpufreq: sti: fix build warning
Date: Mon,  8 Jul 2024 19:14:34 +0200
Message-ID: <20240708171434.111623-1-rgallaispou@gmail.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Building this driver yields the following:

.../drivers/cpufreq/sti-cpufreq.c:215:50: warning: ‘%d’ directive output may be truncated writing between 1 and 10 bytes into a region of size 2 [-Wformat-truncation=]
  215 |         snprintf(name, MAX_PCODE_NAME_LEN, pcode%d, pcode);
      |                                                  ^~
.../drivers/cpufreq/sti-cpufreq.c:215:44: note: directive argument in the range [0, 2147483647]
  215 |         snprintf(name, MAX_PCODE_NAME_LEN, pcode%d, pcode);
      |                                            ^~~~~~~~~
.../drivers/cpufreq/sti-cpufreq.c:215:9: note: ‘snprintf’ output between 7 and 16 bytes into a destination of size 7
  215 |         snprintf(name, MAX_PCODE_NAME_LEN, pcode%d, pcode);
      |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Fix the buffer size to avoid the warning at build time.

Signed-off-by: Raphael Gallais-Pou <rgallaispou@gmail.com>
---
 drivers/cpufreq/sti-cpufreq.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/cpufreq/sti-cpufreq.c b/drivers/cpufreq/sti-cpufreq.c
index 1ffa23dd8907..8e2e703c3865 100644
--- a/drivers/cpufreq/sti-cpufreq.c
+++ b/drivers/cpufreq/sti-cpufreq.c
@@ -18,7 +18,7 @@
 #include <linux/regmap.h>
 
 #define VERSION_ELEMENTS	3
-#define MAX_PCODE_NAME_LEN	7
+#define MAX_PCODE_NAME_LEN	16
 
 #define VERSION_SHIFT		28
 #define HW_INFO_INDEX		1
-- 
2.45.2


