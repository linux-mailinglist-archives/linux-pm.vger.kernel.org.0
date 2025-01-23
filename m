Return-Path: <linux-pm+bounces-20842-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7055EA1A329
	for <lists+linux-pm@lfdr.de>; Thu, 23 Jan 2025 12:39:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9795516980C
	for <lists+linux-pm@lfdr.de>; Thu, 23 Jan 2025 11:39:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1744D20E710;
	Thu, 23 Jan 2025 11:38:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="i7ykwDTT"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 885F820FAAC
	for <linux-pm@vger.kernel.org>; Thu, 23 Jan 2025 11:38:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737632302; cv=none; b=IfBfY1XvlKE3I5R4hiDwvhX9GJv/I4gCA7HjKpyXfyMDJOVCQS09BOiODioL1rrM9N0fYZUU2fFaXhERBhf6a7k6pVeTB5Uh6q9CB5Fnz5I8oxexTt4kR8e7p/IkzJ06IbnUAURdYHyngOU8sH3MmAOUm92mmt2FI1BJAsyz/Fc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737632302; c=relaxed/simple;
	bh=chdagJqGuIzaTRQhr0IscjqPzKErLMaWgV64P/MSA1k=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=mzQZIUk+Xq2bgKIkKCsDUthBIVLEF2T4wfAx07+QJZPA8dSNNdqnoT1PgtO6M/NsW5cB45bn0x3/r8jddhTZsFmTGT3Kr11Q3QEoV24PUOiA2VjVhCNI2wmxpMaLHGidik8C5m4x9loUAXl/pbXVACupwSFUygVKlyemPF0xdns=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=i7ykwDTT; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-21680814d42so12124465ad.2
        for <linux-pm@vger.kernel.org>; Thu, 23 Jan 2025 03:38:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1737632301; x=1738237101; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OpVXuYPIOo1AMkujzDGS3Xg8DYJdil+zOZbNi+qKPE0=;
        b=i7ykwDTTCuXEcx3O54+ypsL1MvXhiW4s++1UGQ9gGV7intv2FVl3c0+f4FPpxMvDLa
         YZAxMkfCcjTfoJid5p3TIfWGlxlWI6KqorIIz5/9zhxCOqhMSfsn69EJ3cUK/vUCgSst
         o/YhQ5EyYdyq8y4F7eFT55OGNhrRhXMrL79GFjH4ArVXTlL+7ZAxtglyK+rRhkXVYrQQ
         zoIpWAzvi4O32juQLg6ZEmAI4M54GLxEBUcvY7g3nJUTCr7mCAbyYW5NiHryc8gb7Nhs
         SI4g11HmOExTg5aUbcQmyIAt/MhGW9EPMVQ+Sh5b9VWVNnQ9bYn4zzrRJ4gWgcFXtAz0
         t1/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737632301; x=1738237101;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OpVXuYPIOo1AMkujzDGS3Xg8DYJdil+zOZbNi+qKPE0=;
        b=dMJB7AulbJCDLA2I+P4Nqlg9SmDZlZJlSLG6FwQshmB3ccuTDYpjfzwvsUKCUQ1CXF
         K5iCLMjenmAu9wi1jBz5kawcGM42SLYOHFfKnVQ9keklPMozDopuJ0yMeaqcaTXuUPE3
         lrbifONOWSx8aCBMfPPcCaaTpD9FMnzTKySO6GRsZon2o3nhWxVVAOlgwr7E7wXhko3H
         0STmNK5gA3j9nfzac3dP2NlgdYjz7w5G3/6Gjo6ua512GEkAa8hFwxYH2/RoY9VuYvr4
         gEGrApuW5WnvfM9fqt4U7vFKmHRAbpMBBczjysnfCsuIuE1m2DMQAuYedndMTFpT34wH
         0bBw==
X-Gm-Message-State: AOJu0YxqwBE4+9gYb0nAtWDJFi/rcWd4h1CYJqe4/4pOnzhWMV/ejBco
	UOfdHCqunu4iwhQFUo6k/82IlwR4GPjyu2kNK5l39q6jeiVKdDxPMpuNclxI9NIJY+lBTM7Zh78
	v
X-Gm-Gg: ASbGncu7tfQaKFETsAgQ4sIPfIC9fKFyY7qKunOwHuRmGwxYduENJZHISl8DKD4lmhi
	OzfmE3R+lOKammRnSFHgOCg4wRclZ2sknqCogEdqjT6JftxrPSxqBxBf6tqFcsiDwawCaHOtO/O
	FT6ttfeG+993sd1BWypeLALDUulkVPRFb806Na1VLAgBMJr33BRdJVxxULt7foj5tAfv99kiw/9
	xlOaPGvBBzD8sC2JQssqjC2ZHNTSP+z00OogcGxwIpxWRFxEN1XN4SQYemkYEs1vMfPGoxATPTz
	W783Rho=
X-Google-Smtp-Source: AGHT+IH/XL+a1IKlocNRJcPr/DB+WeQS0VytU2SOKmpvEEPtNpqG4MYiPimBgaGTBbIa0Va5cHYLyA==
X-Received: by 2002:a05:6a20:4307:b0:1e0:c8c5:9b1c with SMTP id adf61e73a8af0-1eb2145cb94mr39891344637.9.1737632300901;
        Thu, 23 Jan 2025 03:38:20 -0800 (PST)
Received: from localhost ([122.172.84.139])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-a9bdf0b7041sm10951980a12.75.2025.01.23.03.38.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Jan 2025 03:38:20 -0800 (PST)
From: Viresh Kumar <viresh.kumar@linaro.org>
To: "Rafael J. Wysocki" <rafael@kernel.org>,
	Markus Mayer <mmayer@broadcom.com>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	Viresh Kumar <viresh.kumar@linaro.org>,
	Florian Fainelli <florian.fainelli@broadcom.com>
Cc: linux-pm@vger.kernel.org,
	Vincent Guittot <vincent.guittot@linaro.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 06/33] cpufreq: brcmstb: Stop setting common freq attributes
Date: Thu, 23 Jan 2025 17:05:42 +0530
Message-Id: <3e6d8f8ac58727a8ca4d2a57fd90600618085936.1737631669.git.viresh.kumar@linaro.org>
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

The cpufreq core handles this now, the driver can skip setting it.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/cpufreq/brcmstb-avs-cpufreq.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/cpufreq/brcmstb-avs-cpufreq.c b/drivers/cpufreq/brcmstb-avs-cpufreq.c
index 2fd0f6be6fa3..7b841a086acc 100644
--- a/drivers/cpufreq/brcmstb-avs-cpufreq.c
+++ b/drivers/cpufreq/brcmstb-avs-cpufreq.c
@@ -720,7 +720,6 @@ cpufreq_freq_attr_ro(brcm_avs_voltage);
 cpufreq_freq_attr_ro(brcm_avs_frequency);
 
 static struct freq_attr *brcm_avs_cpufreq_attr[] = {
-	&cpufreq_freq_attr_scaling_available_freqs,
 	&brcm_avs_pstate,
 	&brcm_avs_mode,
 	&brcm_avs_pmap,
-- 
2.31.1.272.g89b43f80a514


