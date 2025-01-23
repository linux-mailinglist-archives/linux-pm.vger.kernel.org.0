Return-Path: <linux-pm+bounces-20853-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DCDBA1A343
	for <lists+linux-pm@lfdr.de>; Thu, 23 Jan 2025 12:41:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 687837A3CF8
	for <lists+linux-pm@lfdr.de>; Thu, 23 Jan 2025 11:41:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADA2B2147F0;
	Thu, 23 Jan 2025 11:39:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="CzS9AUF+"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 304822144DC
	for <linux-pm@vger.kernel.org>; Thu, 23 Jan 2025 11:38:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737632340; cv=none; b=tTC4g4cIYMH9CD4Zr4mrLDDhS8MKpsYV7yU0DOgL44ePIl3N69H7MnK55tZlOtjpHEaEkN36KiAcjIWW0My1qylfKQrqJy0O62lVF/yxVn4Wck+tX1aisn8lK6vjwlVub7gVaT1HiwG+UuSIF8I5PVnEYXL+WG1KQXSbizJRsLc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737632340; c=relaxed/simple;
	bh=SElg6W0brjdrMTzkS2G3RHlECrQXEcemB+B1qzeCoSw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=b/MqOSm/eo7idAJEWfRRBihGAhJi7QvuJOouNaQXrpP4K0bRnTCdf021qXJjCN3jbuBxL9GMMSoTNvUTCgGAC0nb+on4EquRd+qVJ/64LH+Qiv2VeRsGf6x0JWq2WojMW/R7vIoTUMnn0ejllnh6X87QSvFlPGi2UPoNQkmb/AE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=CzS9AUF+; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-21619108a6bso11659695ad.3
        for <linux-pm@vger.kernel.org>; Thu, 23 Jan 2025 03:38:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1737632338; x=1738237138; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jgUMFQF2jZPTg63RfJyqUIOezgHoYovaa305j3CfZfs=;
        b=CzS9AUF+sjapUMxblrgkpmBRNNvux8xFwfgVWl9ZD3alwoCqsVPIkjaxZOB4bEcuwP
         Q/cXjEX7n4bYw8n2entQOguVZv3tDy191mXuZqwvTjBsKXHG47jT7QfsTOwQ3etpSFj9
         4Td/mH+QZZ4g3Ygbc8GXsynWlLSL3c/E9ypjRaYVFV2tc9QYIDNKmadVtmICZ42CgGD9
         HxUiswu3zebFETyJ2Kbfq9PCKHedipCQgSqwkwz09S1t/f9qPa7qGkglswnKpHlDH8rh
         LV8zOexd5PmdPWHI2gsoscYg0/nh7JkMFBflOv3Nghsui6Rt2mQciEbmQ20K6inHEhC8
         2L4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737632338; x=1738237138;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jgUMFQF2jZPTg63RfJyqUIOezgHoYovaa305j3CfZfs=;
        b=SLaPtSzz+jTUiV3cAyZGUyX8ROExtWcX4osD2IZZSLpwl8IQbNzyl1L7ZF5GMqoJfy
         Aj55NeoWJ0gCWeAOTmYcVn2PxoBWFRgiaqy5bWwohWwB+vTjWcl8Wv053/tvP7258xk7
         nnWCRMybDSpVw+iBriI/ezi9UBA0sQ7GEY6Rbv1FwesmhLhBpzcZ3mGx/0tGSh78FfK1
         QZz9BfdyzvR+vQBpguxs2uv4+dDLo/11Rg02ic2/e0IQrFBGCTJ8fL5idtFjOEJpLS1H
         +KhQq7OlrFY/sJLZ1k8ZfS01VMYDHaScIv5kU0GRYf29veG4yxwdU1TqJPu7vLNUbbUj
         y7cQ==
X-Gm-Message-State: AOJu0YxqIaYe4tFFsAyI6tCplTS1+z26ZE5avGrk6I1H0oWoUZnDSt9Z
	83cbMwQtCPwPAq0brnppwd1RXO4Hkl+Ke5mA99U0SI97r4ZsM/Zh33PbDyyNPlY=
X-Gm-Gg: ASbGncvrOAFRkFOcZrJm81B0Lf/pOarxOrkUyyYESpae2WSaOmcNCG0xgt/T6Jmou4I
	s0Rqdsjg5iaNLhHLPec4nsyjGhYXQbNowsfxnqk+khQVwLhhV6+cLb7RnRaucZGetQanK9p5cOa
	z+Wz18aXh5JrCNyBaV3GAMgGtNLV13urL0SXt4lZdL4l6X6iPhSpnLusBpt7WMxE3DvEvlGCMpw
	AZunnDTd4ikRNAAGaF0t51N2HWaBJlZYBCkiu6ilUQgEVYlylg46vLrPJZhG/HeNDxRmE9ujpyW
	uDXfYqk=
X-Google-Smtp-Source: AGHT+IG8elfcqoVP5TeqJF0YRGoxv3Se634EVNeUTNkO1Px/MlZcL9qlyaSPzaiuo/PEWE6hWA8Y5Q==
X-Received: by 2002:a05:6a00:be0:b0:72f:59d8:43ed with SMTP id d2e1a72fcca58-72f59d84743mr12350234b3a.14.1737632338582;
        Thu, 23 Jan 2025 03:38:58 -0800 (PST)
Received: from localhost ([122.172.84.139])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-72dab8148dbsm12918263b3a.44.2025.01.23.03.38.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Jan 2025 03:38:57 -0800 (PST)
From: Viresh Kumar <viresh.kumar@linaro.org>
To: "Rafael J. Wysocki" <rafael@kernel.org>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	Naveen N Rao <naveen@kernel.org>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Viresh Kumar <viresh.kumar@linaro.org>
Cc: linux-pm@vger.kernel.org,
	Vincent Guittot <vincent.guittot@linaro.org>,
	linuxppc-dev@lists.ozlabs.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 17/33] cpufreq: pasemi: Stop setting cpufreq_driver->attr field
Date: Thu, 23 Jan 2025 17:05:53 +0530
Message-Id: <a93cb0a441881a23ed867fa35d5960aaba9ae0f3.1737631669.git.viresh.kumar@linaro.org>
X-Mailer: git-send-email 2.31.1.272.g89b43f80a514
In-Reply-To: <cover.1737631669.git.viresh.kumar@linaro.org>
References: <cover.1737631669.git.viresh.kumar@linaro.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The cpufreq core handles this for basic attributes now, the driver can skip
setting them.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/cpufreq/pasemi-cpufreq.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/cpufreq/pasemi-cpufreq.c b/drivers/cpufreq/pasemi-cpufreq.c
index 5fc9cb480516..a3931349360f 100644
--- a/drivers/cpufreq/pasemi-cpufreq.c
+++ b/drivers/cpufreq/pasemi-cpufreq.c
@@ -245,7 +245,6 @@ static struct cpufreq_driver pas_cpufreq_driver = {
 	.exit		= pas_cpufreq_cpu_exit,
 	.verify		= cpufreq_generic_frequency_table_verify,
 	.target_index	= pas_cpufreq_target,
-	.attr		= cpufreq_generic_attr,
 };
 
 /*
-- 
2.31.1.272.g89b43f80a514


