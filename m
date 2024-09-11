Return-Path: <linux-pm+bounces-13987-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BE8E974D16
	for <lists+linux-pm@lfdr.de>; Wed, 11 Sep 2024 10:48:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7D0AEB219E1
	for <lists+linux-pm@lfdr.de>; Wed, 11 Sep 2024 08:48:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 413C0183090;
	Wed, 11 Sep 2024 08:47:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QzG+Rqro"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com [209.85.215.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2A82181BA8;
	Wed, 11 Sep 2024 08:47:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726044428; cv=none; b=nSAl4iYps3u36JTmQcoWH+Z/0X0LCY13ZxO6U+P1Fj0sdmQou7QsBq5BQiHN9KkAheLh6FR3yhZjQwhWolUUd71hEm8VIo2XhQxZQsBUM6pZZR0DAz0rXbqgTEKWDd0+q6DdJn7mUPOLzmNuav1558FalBCNpnQZu5R1eZCYRqA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726044428; c=relaxed/simple;
	bh=/TZwa1P5GOi0weNisvEEpeoua8fx09BY++vgJdF9ecA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Bq6aW35lGcg6bEuP2EDkEtz5GsAi1eQrG3N3sysZP5yKRMnK0W88BDyTIgCIDAD1IypNDdl0dy0O8dThBLiLi0CBYo7Ks/mij8c3zdPck1QRe1oiXzLej09VWIYHoj/i+arbjJ/AB0/z8jmbEjNWR/RUbF9nR4T+utyI0EqCi9A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QzG+Rqro; arc=none smtp.client-ip=209.85.215.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f182.google.com with SMTP id 41be03b00d2f7-7c3e1081804so917854a12.3;
        Wed, 11 Sep 2024 01:47:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726044426; x=1726649226; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IeDHamkVCqUamIh6SnSmGPyPT7GfV2/5V36/vymSx7s=;
        b=QzG+Rqro6vaDWiWmwmFbY1nPiQohPQh6K54x4PHzcczycX8Jelm8KBMifiUSLTygaq
         z68nhwRwH9BtUMrt5z7G2ylIfGXMyApwAZMLq90KDuR5pDBfLi7AMF0RgadlDFyfgfOC
         5T4fgYgVScES8BUZAPScDHXr4qQ94eRDoa1nFI+KUyQR51KrC7iush/hufpz0sZxivum
         0E+eIbVfr9jBRkdBIOLIAlal6dJYbDAFyYpqNxTM3Te38SVw0CEFgm45K+bxWGXb8Dbx
         ghUyWBS0625tvr/blSffI3/oqMVBdecEhYfdR4pPY5XENqwBOCG/WfvlgXOCX3S+yvz2
         YGfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726044426; x=1726649226;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IeDHamkVCqUamIh6SnSmGPyPT7GfV2/5V36/vymSx7s=;
        b=VBYTo+E+N3rTdBaYZGjNhxdfloVVsMXpNFrmn+huuC52ufgHmlHWUXzFowDnx/Jmxc
         07v9hInC9eUeDZMMc5wgwcF/OEtGMCs/wXRcgzFBmqkgj7dzTnzW8ANdarA01uOxcXfg
         AItb4jd8Ng4hKy0QvNOK5nttVanRafgiQGeowkECvgXfoJA5NQlBaV/vCBX1ARuJwG16
         hPeMRz9REKs9asiVjlDUJESn2mdPMPl7v8/HUYyAqs0JlJLmWeh1DA5BAkIVJL4rgskD
         h6xjqfypTcoDcLDvZQ1keyROYqLemOJyxoM1f966d51Qjo4PQ6lg/RsAKlp+Lr488aDO
         s0jw==
X-Forwarded-Encrypted: i=1; AJvYcCU2wYMT2SV3ZbQU/XnYifC3ex4pr4iwCmREfJHTCvxMj5G84Ho+BGS+hyeXx3ksYCTVq1tiKpEgoegOUGtP@vger.kernel.org, AJvYcCUgEEK+EY8a1x4rfBJet+PKaQhpSSFI1N97oqrbNXM0zCpL8/7yp81IgCPqXMxrmmTeR2t+YLKCiifE4w==@vger.kernel.org, AJvYcCUm+uAy0dH09Lg6Kc5VnTSfipWHX0VL2oDbeDyd5uzj25zfKSxuKM9Mc8E5mVU7nSE8e0G5Gj3573U=@vger.kernel.org, AJvYcCWCWbBpMKR3YUsQCPtflUpTqIB4YoscLFWVW7h1oe6NtETvPJRMfEpbOuDEqLPlF95ddlhhw9pmfIuo@vger.kernel.org, AJvYcCWeXlnnwhX8keHjYx5AMM/QScix7V8BV5S3B3ibnVyuUzSNNAGd+wvrDCp5EupGSHTAUnWFSQiVjnFrAHUHHhg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxS91sgWe+Zevmp4/MGa/tV/ZGwn8aa4B0t+jq2RALb/MEByLyT
	WgobSlVszwC4lFuKhMXJiR40m4KL7lVavjratN/tnKgqUmoG0QCc
X-Google-Smtp-Source: AGHT+IHMTwHhuGM1xzJNE2TMTpnQCgKvCX0aXtXz2sZckro6H0s3Lmt7OmVQ/AFM6EQ0mVB19l2HUQ==
X-Received: by 2002:a05:6a21:460c:b0:1cf:2a99:91ec with SMTP id adf61e73a8af0-1cf62cdecbdmr3891676637.28.1726044426062;
        Wed, 11 Sep 2024 01:47:06 -0700 (PDT)
Received: from nick-mbp.ust.hk (wf121-022.ust.hk. [175.159.121.22])
        by smtp.googlemail.com with ESMTPSA id d2e1a72fcca58-71909095177sm2530125b3a.112.2024.09.11.01.47.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Sep 2024 01:47:05 -0700 (PDT)
From: Nick Chan <towinchenmi@gmail.com>
To: Hector Martin <marcan@marcan.st>,
	Sven Peter <sven@svenpeter.dev>,
	Alyssa Rosenzweig <alyssa@rosenzweig.io>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	Viresh Kumar <viresh.kumar@linaro.org>,
	Linus Walleij <linus.walleij@linaro.org>,
	Wim Van Sebroeck <wim@linux-watchdog.org>,
	Guenter Roeck <linux@roeck-us.net>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Mark Kettenis <kettenis@openbsd.org>,
	asahi@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-pm@vger.kernel.org,
	linux-gpio@vger.kernel.org,
	linux-watchdog@vger.kernel.org
Cc: Konrad Dybcio <konradybcio@kernel.org>,
	Ivaylo Ivanov <ivo.ivanov.ivanov1@gmail.com>,
	Nick Chan <towinchenmi@gmail.com>
Subject: [PATCH 03/22] dt-bindings: cpufreq: apple,cluster-cpufreq: Add A10 compatible
Date: Wed, 11 Sep 2024 16:40:53 +0800
Message-ID: <20240911084353.28888-5-towinchenmi@gmail.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240911084353.28888-2-towinchenmi@gmail.com>
References: <20240911084353.28888-2-towinchenmi@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The block found on the Apple A10 SoC is compatible with the
existing driver so just add its per-SoC compatible.

Signed-off-by: Nick Chan <towinchenmi@gmail.com>
---
 .../devicetree/bindings/cpufreq/apple,cluster-cpufreq.yaml    | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/cpufreq/apple,cluster-cpufreq.yaml b/Documentation/devicetree/bindings/cpufreq/apple,cluster-cpufreq.yaml
index 76cb9726660e..e0d1a9813696 100644
--- a/Documentation/devicetree/bindings/cpufreq/apple,cluster-cpufreq.yaml
+++ b/Documentation/devicetree/bindings/cpufreq/apple,cluster-cpufreq.yaml
@@ -24,7 +24,9 @@ properties:
               - apple,t8112-cluster-cpufreq
           - const: apple,cluster-cpufreq
       - items:
-          - const: apple,t6000-cluster-cpufreq
+          - enum:
+              - apple,t8010-cluster-cpufreq
+              - apple,t6000-cluster-cpufreq
           - const: apple,t8103-cluster-cpufreq
           - const: apple,cluster-cpufreq
 
-- 
2.46.0


