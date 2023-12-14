Return-Path: <linux-pm+bounces-1147-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 98A88812D0E
	for <lists+linux-pm@lfdr.de>; Thu, 14 Dec 2023 11:35:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 54DBF281A71
	for <lists+linux-pm@lfdr.de>; Thu, 14 Dec 2023 10:35:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C7673BB2A;
	Thu, 14 Dec 2023 10:35:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NDkATCZM"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF174139;
	Thu, 14 Dec 2023 02:35:08 -0800 (PST)
Received: by mail-wr1-x436.google.com with SMTP id ffacd0b85a97d-32f8441dfb5so7205644f8f.0;
        Thu, 14 Dec 2023 02:35:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702550107; x=1703154907; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5YMMP/qsVfdoJtEElBLyEEO9c305KOAYJqUkekDdPZs=;
        b=NDkATCZMfoiVgg3N51a1twyD814Uj1CuF/7rrOYTHHHfXn2km7YjNZOYfFZhCDvhnT
         0sdCN6/Ma/VWit5yxzq3XNqb+8rbD0VwawuPrwQAcqyhxIEIfgghukbp6pDvPWR3iqqP
         6BRKwNXI63C+lCF+ZNUiN63Wj+pGQQOHeGfiabwTE+TPtk9hsQ7uC7cZvGwE8TSLQJ/q
         XUV8nOB0YK1scYnc0f0e+gA+H8E7SjwtXXLXeSzVH4tC+g91Lyl5RpvZigkROqjRUFfO
         Sdgixn+e8Q6If94xk1L1p12btGMevJ2w3w7N1B5MvBnbStdw8veNqMciLeacSEJGLxDO
         1Fzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702550107; x=1703154907;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5YMMP/qsVfdoJtEElBLyEEO9c305KOAYJqUkekDdPZs=;
        b=XN3hFTaX7XjeLZ6hTH2JCAusZTLtEl8qpdx9VC7TfsI61kNO3QhnPTljqWceP6aPNi
         fZVtvX6rciVsuiuV+djQvcFnRjnzHSuPCbQgCms/4EB1Sj255BMWFgsJOli0oF42Ur8v
         dp2zFykXB2pO+Erz/znBcgYGgRiNYuFh2GbuIUhYMVezdkK2fZemGB9qE4QNmEdnhL5Z
         jUiHHbA69N7/nLRtUp0/Dg1Hd5R/gXg2BE47iOxhmHFYjmGFjJLXlozqKeGJrQmED3js
         e1/mZAdCRxRBHPB3v6aRSC7Pk+tqT3L49iDAW2UeEpHFbmMFWnhwJ7n7gpEvRcrzihlw
         LBeg==
X-Gm-Message-State: AOJu0YzG84AjYnhmga3TYtHbmDTpyiHhnu/c8XsxHQjlHPKMDwwlQwBz
	+KHlEd5qVLFG7cprY/ikMR4=
X-Google-Smtp-Source: AGHT+IGB2gMg2Mze62sZsH15EW7tQ5RddMXqMonm4fA8WEreIbA3LcsoIasFJ6/XxlhankFX/CQcBw==
X-Received: by 2002:adf:9790:0:b0:333:2fd2:6f82 with SMTP id s16-20020adf9790000000b003332fd26f82mr4844499wrb.140.1702550107021;
        Thu, 14 Dec 2023 02:35:07 -0800 (PST)
Received: from localhost.localdomain ([129.0.226.240])
        by smtp.gmail.com with ESMTPSA id e4-20020a5d65c4000000b003333ed23356sm15849623wrw.4.2023.12.14.02.35.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Dec 2023 02:35:06 -0800 (PST)
From: Brandon Cheo Fusi <fusibrandon13@gmail.com>
To: Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Chen-Yu Tsai <wens@csie.org>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Samuel Holland <samuel@sholland.org>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	Viresh Kumar <viresh.kumar@linaro.org>,
	Yangtao Li <tiny.windzz@gmail.com>
Cc: devicetree@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org,
	linux-sunxi@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-pm@vger.kernel.org,
	Brandon Cheo Fusi <fusibrandon13@gmail.com>
Subject: [PATCH 2/5] cpufreq: sun50i: Add D1 support
Date: Thu, 14 Dec 2023 11:33:39 +0100
Message-Id: <20231214103342.30775-3-fusibrandon13@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20231214103342.30775-1-fusibrandon13@gmail.com>
References: <20231214103342.30775-1-fusibrandon13@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add support for D1 based devices to the Allwinner H6 cpufreq
driver

Signed-off-by: Brandon Cheo Fusi <fusibrandon13@gmail.com>
---
 drivers/cpufreq/sun50i-cpufreq-nvmem.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/cpufreq/sun50i-cpufreq-nvmem.c b/drivers/cpufreq/sun50i-cpufreq-nvmem.c
index 32a9c88f8..ccf83780f 100644
--- a/drivers/cpufreq/sun50i-cpufreq-nvmem.c
+++ b/drivers/cpufreq/sun50i-cpufreq-nvmem.c
@@ -160,6 +160,7 @@ static struct platform_driver sun50i_cpufreq_driver = {
 
 static const struct of_device_id sun50i_cpufreq_match_list[] = {
 	{ .compatible = "allwinner,sun50i-h6" },
+	{ .compatible = "allwinner,sun20i-d1" },
 	{}
 };
 MODULE_DEVICE_TABLE(of, sun50i_cpufreq_match_list);
-- 
2.30.2


