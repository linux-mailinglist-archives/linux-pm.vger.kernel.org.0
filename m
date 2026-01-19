Return-Path: <linux-pm+bounces-41090-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D67CD3A83A
	for <lists+linux-pm@lfdr.de>; Mon, 19 Jan 2026 13:14:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 332D330BF509
	for <lists+linux-pm@lfdr.de>; Mon, 19 Jan 2026 12:09:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F71635B138;
	Mon, 19 Jan 2026 12:09:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="xQzwqJnq"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9F4C35A927
	for <linux-pm@vger.kernel.org>; Mon, 19 Jan 2026 12:08:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768824541; cv=none; b=qLkrDOl0NxNIBbpArgbJYDrkAlq1HFTZW8MPOOAW/ygv/EMRTeTqKaeahsqZESzrX14Twh6Xv5d94c8H0szq33fxiBYrl6BXRfDgTCTn+ShuweZEAPnD/T9xhIAPNvxNElUH0+EMmlXILT3cIHEqEolmKusszb5SnR185Y2HZtA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768824541; c=relaxed/simple;
	bh=7HVJFrG3U/QwDFKx95QyYbsMuRfAm1hbMd+GcbM229I=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=XFrm+VxTp6eJog5FL3s7cSBQ3skSP4AHMFw3+RvOR83QVWR0fY6O0TR33lOsefVgzAtC9C0bDqb2/aibYwCEnr/49pqilxxmdBfdUzgBaLJAreUhlIAuTE6dEryczFrjldsSV3eFJ4dO1hiSG1b1xJhJapq4sMYgw8k4gPBmN4Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=xQzwqJnq; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-42fb6ce71c7so3765419f8f.1
        for <linux-pm@vger.kernel.org>; Mon, 19 Jan 2026 04:08:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1768824537; x=1769429337; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=uDx8GJwGFtxKfvZU7MLXX1ujE0p+LvEQKHj4ysnyPoQ=;
        b=xQzwqJnqQ9rESYuM6yz0wi16zF+AOWzQ/9ioAwCrKB+FNjAvPAcoTW8DBJWMOsQG73
         M8SSGiF5rsY2DwzGJAEfb19OsltfuMwQf4xbG4+CHjuXfsXQtyq+Z8zUpMith6UZT2j6
         +Qo1OIsiUIjlmX7pqMT9ZvgDi8xr50Emu9lnR+sneekg3amiQg8W6NEPHpU7eT7u4P5I
         xjWw3gOEasYumxiXnz7dave6/yI4j52BgUEs4H41GaQRdG2rdg7sJOKoahbZj/k4vr+F
         NLhgifc7oeOg0QMCxwLu4Q7jqC7kJ0NDpQNflmrYdQC4HyDsZadLN82BF0+K1OOT/T2A
         LY8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768824537; x=1769429337;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=uDx8GJwGFtxKfvZU7MLXX1ujE0p+LvEQKHj4ysnyPoQ=;
        b=mYmbT1wnBf6OJYjwp5rcMTspF+AjvR5RI2Tr0TQRX+J+izfx95G3rZsUS74ZXhLXGz
         +vTAOr7OlDemQKwkDYCSDKja24Tm3fuRt+C/J8zJCz1YDgJPH5/3bXUDwLyZY8quq/ys
         ns+55v1Z8nSBP/iT7TzYgsJCdvnqUiTvdKM9UuTUZeMAUWdJb4mhwc4VBlHterfT/f5q
         wRPmf3Z0PcV3BDoxY7tBAOP9ECyhMM6prw+pFaPBtFRthbFqHT5p7pnY8oa0Yvhaz9uf
         KHXvg2Q0+Tk96awMRuN20sz4QE90gCosk/2IlEtVFohD+quDVlUiOAEWtvnY+HMCvovq
         pY6g==
X-Forwarded-Encrypted: i=1; AJvYcCUGoqGFxCm/gbNanWeZPHkPjzaoqq0flubBi4rx5Y+bOggf07+ZpkoKBe+EzhqlLSQvMN0imVJb+Q==@vger.kernel.org
X-Gm-Message-State: AOJu0YzWlodNPWQB7WaZ7fimx6+gYZJF9CFD2KpMQ+qZv3wqUNQFYb2W
	9KOL4N4MResv3osegr3IjvePOv6bFe2YKTQoV4gz9L1vLMcuhrNC9LIdXT4s9gxJRko=
X-Gm-Gg: AZuq6aJnnsBLV1z8xhFP5fjWrZHq/dY/ZJ5J47Ct9nYDa93OUVHkzV80JKLijeoBCs1
	qSZk/M0hJTXJWGSsd67aR7GoP3pdmAjMH3fjUQ39rnOpDr9jUTXq9emydlFuyt+78y5Gkej6JVc
	edPT6BCRxdqn9tvQ+tWCgP/n9odMduCVygRITLEdzPQyPtWI0clvWXb0yiVw0M2qb1SRaj7TJ59
	A1hjbi4IY0nF62RFhgI8QDI8w6bVJrQ8X62/LHNxULwHcXRLXtVoSZsU0HqM/Tl9PfBmY3rx0QR
	cs5xMaO11rJyYk0mF0MczaQDDlthwRirg+yUTgTsJN4ujn8zHRMraL0alLXKziVXyyYN7pUQjp8
	h5GKvA9X52j9BfZLbhDBgZSLrOOCbucQY3HSuN+NNsAiAXdfPUZYCNY8aqtLX1BkiZjL+Vb0695
	jZ0by6hqlaMs3kLXmsUvOcwKfoq530ZrvkgwMk2AoEigP+jkUGy64QgxspLoyjLg95fHWx1A==
X-Received: by 2002:a05:6000:40e0:b0:431:2ff:1289 with SMTP id ffacd0b85a97d-43569998e7emr13611166f8f.16.1768824537135;
        Mon, 19 Jan 2026 04:08:57 -0800 (PST)
Received: from ta2.c.googlers.com (164.102.240.35.bc.googleusercontent.com. [35.240.102.164])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4356997e664sm20698421f8f.30.2026.01.19.04.08.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Jan 2026 04:08:56 -0800 (PST)
From: Tudor Ambarus <tudor.ambarus@linaro.org>
Date: Mon, 19 Jan 2026 12:08:51 +0000
Subject: [PATCH v2 5/7] MAINTAINERS: Add entry for Samsung Exynos ACPM
 thermal driver
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260119-acpm-tmu-v2-5-e02a834f04c6@linaro.org>
References: <20260119-acpm-tmu-v2-0-e02a834f04c6@linaro.org>
In-Reply-To: <20260119-acpm-tmu-v2-0-e02a834f04c6@linaro.org>
To: "Rafael J. Wysocki" <rafael@kernel.org>, 
 Daniel Lezcano <daniel.lezcano@linaro.org>, Zhang Rui <rui.zhang@intel.com>, 
 Lukasz Luba <lukasz.luba@arm.com>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Krzysztof Kozlowski <krzk@kernel.org>, 
 Alim Akhtar <alim.akhtar@samsung.com>, 
 Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, Kees Cook <kees@kernel.org>, 
 "Gustavo A. R. Silva" <gustavoars@kernel.org>, 
 Peter Griffin <peter.griffin@linaro.org>, 
 =?utf-8?q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>
Cc: willmcvicker@google.com, jyescas@google.com, shin.son@samsung.com, 
 linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-pm@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-hardening@vger.kernel.org, 
 Tudor Ambarus <tudor.ambarus@linaro.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1768824532; l=971;
 i=tudor.ambarus@linaro.org; s=20241212; h=from:subject:message-id;
 bh=7HVJFrG3U/QwDFKx95QyYbsMuRfAm1hbMd+GcbM229I=;
 b=TlBEnMuauOll69kA3Iht1mp8Vn36O+nZ27Yqrrl+ucAF9TVN0wbdHvi0EFHd/dHU17mHdXaSU
 xi2wLoqH9f+D/9H1BB1EA+6a5jaXfj1M4JXToWWKa7JZ7HltBPIb1du
X-Developer-Key: i=tudor.ambarus@linaro.org; a=ed25519;
 pk=uQzE0NXo3dIjeowMTOPCpIiPHEz12IA/MbyzrZVh9WI=

Add a MAINTAINERS entry for the Samsung Exynos ACPM thermal driver.

Signed-off-by: Tudor Ambarus <tudor.ambarus@linaro.org>
---
 MAINTAINERS | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 5b11839cba9de1e9e43f63787578edd8c429ca39..ab44f2de8e8e03ad9bb022ebdf1b6c0058fb0425 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -23171,6 +23171,14 @@ F:	drivers/clk/samsung/clk-acpm.c
 F:	drivers/firmware/samsung/exynos-acpm*
 F:	include/linux/firmware/samsung/exynos-acpm-protocol.h
 
+SAMSUNG EXYNOS ACPM THERMAL DRIVER
+M:	Tudor Ambarus <tudor.ambarus@linaro.org>
+L:	linux-kernel@vger.kernel.org
+L:	linux-samsung-soc@vger.kernel.org
+S:	Supported
+F:	Documentation/devicetree/bindings/thermal/google,gs101-tmu-top.yaml
+F:	drivers/thermal/samsung/acpm-tmu.c
+
 SAMSUNG EXYNOS MAILBOX DRIVER
 M:	Tudor Ambarus <tudor.ambarus@linaro.org>
 L:	linux-kernel@vger.kernel.org

-- 
2.52.0.457.g6b5491de43-goog


