Return-Path: <linux-pm+bounces-33077-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 84139B353F1
	for <lists+linux-pm@lfdr.de>; Tue, 26 Aug 2025 08:12:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 266DE684687
	for <lists+linux-pm@lfdr.de>; Tue, 26 Aug 2025 06:12:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD8382F616F;
	Tue, 26 Aug 2025 06:11:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AwnMMZxk"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CC212F549B;
	Tue, 26 Aug 2025 06:11:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756188708; cv=none; b=rYJ6v2g4fL2vUacOq8GoLPrXtVRBl7i/UdJOuCslPJrRdqJYHRalQJ7oLrjLVXOmo/NDzVydmY63tjwioAvVCCyGl52qy9vyFYoPzIhVKMX7ZZ+9VBtRztPz16IIE77qLFW+8xdU0Og1byNarpq6wCdKFTR0voP468OvQAT5h8w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756188708; c=relaxed/simple;
	bh=gTGzTx3fZPSLdbfMpeUC0v+CLlCPl2Ad2XWcZCvFQH0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=utsEpase5/ZZlKV5fdrbb4Ap3qADoG/580FX0g6D6e+0vu0rqoK2LwVeINA0/iUcLhDwoMKY7c72sHIu5RfsrGwMflF6czVyg9ukhf90swA3ulcW4SCV5p3VbjUdGuQTcnl/AHrx+tl2VhcbJC/W75UGqmZjyyvR6Xx7n+CFREQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AwnMMZxk; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-afe84202bb6so206950466b.2;
        Mon, 25 Aug 2025 23:11:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756188705; x=1756793505; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5nYpwwlOfuh5M3K/Wost7HX5KbOQu2u9S4zhrB5/9qk=;
        b=AwnMMZxkNyqUqmQIFn9ectl7XMO05StFKwRr0ks+VXwSo55Kn2XPEnFHeH99Jg4Ru+
         IWZBREfq6xCEk2tEHYyDSLb3oE3043OFSx6WlHWK+vMJQUDPsc2dJSDnxfl8at1KRxwM
         OVJthKjd3/+ODnSmcYHgKpOMk9IgUg50md7F1oQY+qNqqTxffo6Yextft0m1vROveG0G
         0iF8VwAOeKf22vqw3U1apDQsd+cOwSkfqKc9rnd1haxtb7p8ocw2J1MusEo1u9Va/cX5
         gELsshsUuF+G0+EVtvYRtG8ZN7O8RdeJo4FwYD3AqAgE1TuKJAgQ6VbpZCvOjwvveSTt
         TOkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756188705; x=1756793505;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5nYpwwlOfuh5M3K/Wost7HX5KbOQu2u9S4zhrB5/9qk=;
        b=CRVKww2W7xBwQKYllM56dA8S8oETbRQKw9+uCNacwjwGIC7CsRGr1N1gAApAMf+9GQ
         TVTxi51Fc8evd3J1e9MkeqQfRjiGOObrmUh0qUiOYf5GuUErt9j1jncUKWagLYFEL13X
         StHjDQ0EHfa/Acu4Lo+Vy3BxV5n1fnl4281FbeJdhgiQNCSnzwimW5vpjDTb1JhUaDGH
         liZ7fyqXT8Z/typ45SRnLRMhYDmZ0+UhckEtP2KT5PEUaIFsIbJA3MkmUiVsQJvea8xN
         F+hKBovN+DQY/RUMXUSwSvRqQc9O08FyJ/V5kwYaHmmjxR+b/JTDpPOTHddZXrGbG2Q6
         tWzw==
X-Forwarded-Encrypted: i=1; AJvYcCVKAg7i2S7T5YGddcfvpeTWj62KBmoxtIosxZ8qZS9F/X3i6YQwmbjU3BQLK/noOdfFggwpfBeyoK7fW+wD@vger.kernel.org, AJvYcCVKkPw5l1ZltSt0jecLIZdVAp3jeSPWZfeJPFyJNKvBs2wOET8iz5x+57Jm+rwmpr5VGOUWVxmxmCY=@vger.kernel.org, AJvYcCVegyEfh89zev8QIOICT6E6yYyCKa1WrLDf5yK6l0MCziLqZRofDW79lqef46XCKlPJcG0BrF5/zRI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz85tGPgklx9tv0OFwJLTOcPN+nG4LLDzw64nHxz3ymoL90clHP
	FlTTBARMD/lMPXTKTh6hTFB45MRlxUjc8MKwa7kY0yTmQUbXKlGfLXCQ
X-Gm-Gg: ASbGncvWEiR3kDmxiIkm0uOh+Up1g4M/jBuhUYAavD/q8oNjntV1AyHdCVdH0tE3Ec0
	+llp6EY6MAO5Fl22INPFLWrUfETOkK10O7vRqqPkcrpCPD9+ppQtrd1063mPCyZokpQi8vAfetb
	DvUC9Qw46GdjnlW+iQJ6rQqOsHWB+tlpLt/ZAgXBens4odfLRoboON/nEpqngY2VAoMVtuP6lpN
	jwbSTgGkg3iE1U8NrCcTQEv8E8fwPDtl8UR+Kz0jMmRfqNN8xK5Xk+oFlTBOMQR9pxmbeBVq6/6
	7/SLyLGX/iTQBNbw/SXi1VUeok2KNkRX4pmNwgtN8yJEGhqjb6I5ERUo5gygtj9y+nNPnixawR8
	rF8/tcF/uBrt5HaHO75elQ40y
X-Google-Smtp-Source: AGHT+IE9MhXq2y8if+Ug1Zsx7a+3fRgNft7qRPhux/ffbLTU8V6rUt2KFckMprCzKyHsU9deJqinVQ==
X-Received: by 2002:a17:907:9305:b0:af6:a116:f13c with SMTP id a640c23a62f3a-afe28f16478mr1400111766b.23.1756188704861;
        Mon, 25 Aug 2025 23:11:44 -0700 (PDT)
Received: from xeon.. ([188.163.112.76])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-afe492da4b9sm711067966b.63.2025.08.25.23.11.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Aug 2025 23:11:44 -0700 (PDT)
From: Svyatoslav Ryhel <clamor95@gmail.com>
To: Thierry Reding <thierry.reding@gmail.com>,
	Thierry Reding <treding@nvidia.com>,
	Mikko Perttunen <mperttunen@nvidia.com>,
	Jonathan Hunter <jonathanh@nvidia.com>,
	Prashant Gaikwad <pgaikwad@nvidia.com>,
	Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Viresh Kumar <viresh.kumar@linaro.org>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	Svyatoslav Ryhel <clamor95@gmail.com>
Cc: linux-tegra@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-clk@vger.kernel.org,
	linux-pm@vger.kernel.org
Subject: [PATCH v3 3/4] clk: tegra: dfll: add CVB tables for Tegra114
Date: Tue, 26 Aug 2025 09:11:16 +0300
Message-ID: <20250826061117.63643-4-clamor95@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250826061117.63643-1-clamor95@gmail.com>
References: <20250826061117.63643-1-clamor95@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Extend the Tegra124 DFLL driver to include configuration settings required
for Tegra114 compatibility.

Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
---
 drivers/clk/tegra/Kconfig                  |   2 +-
 drivers/clk/tegra/clk-tegra124-dfll-fcpu.c | 158 +++++++++++++++++----
 2 files changed, 132 insertions(+), 28 deletions(-)

diff --git a/drivers/clk/tegra/Kconfig b/drivers/clk/tegra/Kconfig
index 90df619dc087..62147a069606 100644
--- a/drivers/clk/tegra/Kconfig
+++ b/drivers/clk/tegra/Kconfig
@@ -4,7 +4,7 @@ config CLK_TEGRA_BPMP
 	depends on TEGRA_BPMP
 
 config TEGRA_CLK_DFLL
-	depends on ARCH_TEGRA_124_SOC || ARCH_TEGRA_210_SOC
+	depends on ARCH_TEGRA_114_SOC || ARCH_TEGRA_124_SOC || ARCH_TEGRA_210_SOC
 	select PM_OPP
 	def_bool y
 
diff --git a/drivers/clk/tegra/clk-tegra124-dfll-fcpu.c b/drivers/clk/tegra/clk-tegra124-dfll-fcpu.c
index 0251618b82c8..1405217fed5d 100644
--- a/drivers/clk/tegra/clk-tegra124-dfll-fcpu.c
+++ b/drivers/clk/tegra/clk-tegra124-dfll-fcpu.c
@@ -28,6 +28,99 @@ struct dfll_fcpu_data {
 	unsigned int cpu_cvb_tables_size;
 };
 
+/* Maximum CPU frequency, indexed by CPU speedo id */
+static const unsigned long tegra114_cpu_max_freq_table[] = {
+	[0] = 2040000000UL,
+	[1] = 1810500000UL,
+	[2] = 1912500000UL,
+	[3] = 1810500000UL,
+};
+
+#define T114_CPU_CVB_TABLE \
+	.min_millivolts = 1000, \
+	.max_millivolts = 1320, \
+	.speedo_scale = 100,    \
+	.voltage_scale = 1000,  \
+	.entries = {            \
+		{  306000000UL, { 2190643, -141851, 3576 } }, \
+		{  408000000UL, { 2250968, -144331, 3576 } }, \
+		{  510000000UL, { 2313333, -146811, 3576 } }, \
+		{  612000000UL, { 2377738, -149291, 3576 } }, \
+		{  714000000UL, { 2444183, -151771, 3576 } }, \
+		{  816000000UL, { 2512669, -154251, 3576 } }, \
+		{  918000000UL, { 2583194, -156731, 3576 } }, \
+		{ 1020000000UL, { 2655759, -159211, 3576 } }, \
+		{ 1122000000UL, { 2730365, -161691, 3576 } }, \
+		{ 1224000000UL, { 2807010, -164171, 3576 } }, \
+		{ 1326000000UL, { 2885696, -166651, 3576 } }, \
+		{ 1428000000UL, { 2966422, -169131, 3576 } }, \
+		{ 1530000000UL, { 3049183, -171601, 3576 } }, \
+		{ 1606500000UL, { 3112179, -173451, 3576 } }, \
+		{ 1708500000UL, { 3198504, -175931, 3576 } }, \
+		{ 1810500000UL, { 3304747, -179126, 3576 } }, \
+		{ 1912500000UL, { 3395401, -181606, 3576 } }, \
+		{          0UL, {       0,       0,    0 } }, \
+	}, \
+	.cpu_dfll_data = {      \
+		.tune0_low = 0x00b0039d,          \
+		.tune0_high = 0x00b0009d,         \
+		.tune1 = 0x0000001f,              \
+		.tune_high_min_millivolts = 1050, \
+	}
+
+static const struct cvb_table tegra114_cpu_cvb_tables[] = {
+	{
+		.speedo_id = 0,
+		.process_id = -1,
+		.min_millivolts = 1000,
+		.max_millivolts = 1250,
+		.speedo_scale = 100,
+		.voltage_scale = 100,
+		.entries = {
+			{  306000000UL, { 107330, -1569,   0 } },
+			{  408000000UL, { 111250, -1666,   0 } },
+			{  510000000UL, { 110000, -1460,   0 } },
+			{  612000000UL, { 117290, -1745,   0 } },
+			{  714000000UL, { 122700, -1910,   0 } },
+			{  816000000UL, { 125620, -1945,   0 } },
+			{  918000000UL, { 130560, -2076,   0 } },
+			{ 1020000000UL, { 137280, -2303,   0 } },
+			{ 1122000000UL, { 146440, -2660,   0 } },
+			{ 1224000000UL, { 152190, -2825,   0 } },
+			{ 1326000000UL, { 157520, -2953,   0 } },
+			{ 1428000000UL, { 166100, -3261,   0 } },
+			{ 1530000000UL, { 176410, -3647,   0 } },
+			{ 1632000000UL, { 189620, -4186,   0 } },
+			{ 1734000000UL, { 203190, -4725,   0 } },
+			{ 1836000000UL, { 222670, -5573,   0 } },
+			{ 1938000000UL, { 256210, -7165,   0 } },
+			{ 2040000000UL, { 250050, -6544,   0 } },
+			{          0UL, {      0,     0,   0 } },
+		},
+		.cpu_dfll_data = {
+			.tune0_low = 0x00b0019d,
+			.tune0_high = 0x00b0019d,
+			.tune1 = 0x0000001f,
+			.tune_high_min_millivolts = 1000,
+		}
+	},
+	{
+		.speedo_id = 1,
+		.process_id = -1,
+		T114_CPU_CVB_TABLE
+	},
+	{
+		.speedo_id = 2,
+		.process_id = -1,
+		T114_CPU_CVB_TABLE
+	},
+	{
+		.speedo_id = 3,
+		.process_id = -1,
+		T114_CPU_CVB_TABLE
+	},
+};
+
 /* Maximum CPU frequency, indexed by CPU speedo id */
 static const unsigned long tegra124_cpu_max_freq_table[] = {
 	[0] = 2014500000UL,
@@ -93,7 +186,7 @@ static const unsigned long tegra210_cpu_max_freq_table[] = {
 	[10] = 1504500000UL,
 };
 
-#define CPU_CVB_TABLE \
+#define T210_CPU_CVB_TABLE \
 	.speedo_scale = 100,	\
 	.voltage_scale = 1000,	\
 	.entries = {		\
@@ -120,7 +213,7 @@ static const unsigned long tegra210_cpu_max_freq_table[] = {
 		{          0UL,	{       0,      0,   0 } }, \
 	}
 
-#define CPU_CVB_TABLE_XA \
+#define T210_CPU_CVB_TABLE_XA \
 	.speedo_scale = 100,	\
 	.voltage_scale = 1000,	\
 	.entries = {		\
@@ -143,7 +236,7 @@ static const unsigned long tegra210_cpu_max_freq_table[] = {
 		{          0UL,	{       0,      0,   0 } }, \
 	}
 
-#define CPU_CVB_TABLE_EUCM1 \
+#define T210_CPU_CVB_TABLE_EUCM1 \
 	.speedo_scale = 100,	\
 	.voltage_scale = 1000,	\
 	.entries = {		\
@@ -166,7 +259,7 @@ static const unsigned long tegra210_cpu_max_freq_table[] = {
 		{          0UL,	{       0, 0, 0 } }, \
 	}
 
-#define CPU_CVB_TABLE_EUCM2 \
+#define T210_CPU_CVB_TABLE_EUCM2 \
 	.speedo_scale = 100,	\
 	.voltage_scale = 1000,	\
 	.entries = {		\
@@ -188,7 +281,7 @@ static const unsigned long tegra210_cpu_max_freq_table[] = {
 		{          0UL,	{       0, 0, 0 } }, \
 	}
 
-#define CPU_CVB_TABLE_EUCM2_JOINT_RAIL \
+#define T210_CPU_CVB_TABLE_EUCM2_JOINT_RAIL \
 	.speedo_scale = 100,	\
 	.voltage_scale = 1000,	\
 	.entries = {		\
@@ -209,7 +302,7 @@ static const unsigned long tegra210_cpu_max_freq_table[] = {
 		{          0UL,	{       0, 0, 0 } }, \
 	}
 
-#define CPU_CVB_TABLE_ODN \
+#define T210_CPU_CVB_TABLE_ODN \
 	.speedo_scale = 100,	\
 	.voltage_scale = 1000,	\
 	.entries = {		\
@@ -238,7 +331,7 @@ static struct cvb_table tegra210_cpu_cvb_tables[] = {
 		.process_id = 0,
 		.min_millivolts = 840,
 		.max_millivolts = 1120,
-		CPU_CVB_TABLE_EUCM2_JOINT_RAIL,
+		T210_CPU_CVB_TABLE_EUCM2_JOINT_RAIL,
 		.cpu_dfll_data = {
 			.tune0_low = 0xffead0ff,
 			.tune0_high = 0xffead0ff,
@@ -251,7 +344,7 @@ static struct cvb_table tegra210_cpu_cvb_tables[] = {
 		.process_id = 1,
 		.min_millivolts = 840,
 		.max_millivolts = 1120,
-		CPU_CVB_TABLE_EUCM2_JOINT_RAIL,
+		T210_CPU_CVB_TABLE_EUCM2_JOINT_RAIL,
 		.cpu_dfll_data = {
 			.tune0_low = 0xffead0ff,
 			.tune0_high = 0xffead0ff,
@@ -264,7 +357,7 @@ static struct cvb_table tegra210_cpu_cvb_tables[] = {
 		.process_id = 0,
 		.min_millivolts = 900,
 		.max_millivolts = 1162,
-		CPU_CVB_TABLE_EUCM2,
+		T210_CPU_CVB_TABLE_EUCM2,
 		.cpu_dfll_data = {
 			.tune0_low = 0xffead0ff,
 			.tune0_high = 0xffead0ff,
@@ -276,7 +369,7 @@ static struct cvb_table tegra210_cpu_cvb_tables[] = {
 		.process_id = 1,
 		.min_millivolts = 900,
 		.max_millivolts = 1162,
-		CPU_CVB_TABLE_EUCM2,
+		T210_CPU_CVB_TABLE_EUCM2,
 		.cpu_dfll_data = {
 			.tune0_low = 0xffead0ff,
 			.tune0_high = 0xffead0ff,
@@ -288,7 +381,7 @@ static struct cvb_table tegra210_cpu_cvb_tables[] = {
 		.process_id = 0,
 		.min_millivolts = 900,
 		.max_millivolts = 1195,
-		CPU_CVB_TABLE_EUCM2,
+		T210_CPU_CVB_TABLE_EUCM2,
 		.cpu_dfll_data = {
 			.tune0_low = 0xffead0ff,
 			.tune0_high = 0xffead0ff,
@@ -300,7 +393,7 @@ static struct cvb_table tegra210_cpu_cvb_tables[] = {
 		.process_id = 1,
 		.min_millivolts = 900,
 		.max_millivolts = 1195,
-		CPU_CVB_TABLE_EUCM2,
+		T210_CPU_CVB_TABLE_EUCM2,
 		.cpu_dfll_data = {
 			.tune0_low = 0xffead0ff,
 			.tune0_high = 0xffead0ff,
@@ -312,7 +405,7 @@ static struct cvb_table tegra210_cpu_cvb_tables[] = {
 		.process_id = 0,
 		.min_millivolts = 841,
 		.max_millivolts = 1227,
-		CPU_CVB_TABLE_EUCM1,
+		T210_CPU_CVB_TABLE_EUCM1,
 		.cpu_dfll_data = {
 			.tune0_low = 0xffead0ff,
 			.tune0_high = 0xffead0ff,
@@ -325,7 +418,7 @@ static struct cvb_table tegra210_cpu_cvb_tables[] = {
 		.process_id = 1,
 		.min_millivolts = 841,
 		.max_millivolts = 1227,
-		CPU_CVB_TABLE_EUCM1,
+		T210_CPU_CVB_TABLE_EUCM1,
 		.cpu_dfll_data = {
 			.tune0_low = 0xffead0ff,
 			.tune0_high = 0xffead0ff,
@@ -338,7 +431,7 @@ static struct cvb_table tegra210_cpu_cvb_tables[] = {
 		.process_id = 0,
 		.min_millivolts = 870,
 		.max_millivolts = 1150,
-		CPU_CVB_TABLE,
+		T210_CPU_CVB_TABLE,
 		.cpu_dfll_data = {
 			.tune0_low = 0xffead0ff,
 			.tune1 = 0x20091d9,
@@ -349,7 +442,7 @@ static struct cvb_table tegra210_cpu_cvb_tables[] = {
 		.process_id = 1,
 		.min_millivolts = 870,
 		.max_millivolts = 1150,
-		CPU_CVB_TABLE,
+		T210_CPU_CVB_TABLE,
 		.cpu_dfll_data = {
 			.tune0_low = 0xffead0ff,
 			.tune1 = 0x25501d0,
@@ -360,7 +453,7 @@ static struct cvb_table tegra210_cpu_cvb_tables[] = {
 		.process_id = 0,
 		.min_millivolts = 818,
 		.max_millivolts = 1227,
-		CPU_CVB_TABLE,
+		T210_CPU_CVB_TABLE,
 		.cpu_dfll_data = {
 			.tune0_low = 0xffead0ff,
 			.tune0_high = 0xffead0ff,
@@ -373,7 +466,7 @@ static struct cvb_table tegra210_cpu_cvb_tables[] = {
 		.process_id = 1,
 		.min_millivolts = 818,
 		.max_millivolts = 1227,
-		CPU_CVB_TABLE,
+		T210_CPU_CVB_TABLE,
 		.cpu_dfll_data = {
 			.tune0_low = 0xffead0ff,
 			.tune0_high = 0xffead0ff,
@@ -386,7 +479,7 @@ static struct cvb_table tegra210_cpu_cvb_tables[] = {
 		.process_id = -1,
 		.min_millivolts = 918,
 		.max_millivolts = 1113,
-		CPU_CVB_TABLE_XA,
+		T210_CPU_CVB_TABLE_XA,
 		.cpu_dfll_data = {
 			.tune0_low = 0xffead0ff,
 			.tune1 = 0x17711BD,
@@ -397,7 +490,7 @@ static struct cvb_table tegra210_cpu_cvb_tables[] = {
 		.process_id = 0,
 		.min_millivolts = 825,
 		.max_millivolts = 1227,
-		CPU_CVB_TABLE_ODN,
+		T210_CPU_CVB_TABLE_ODN,
 		.cpu_dfll_data = {
 			.tune0_low = 0xffead0ff,
 			.tune0_high = 0xffead0ff,
@@ -410,7 +503,7 @@ static struct cvb_table tegra210_cpu_cvb_tables[] = {
 		.process_id = 1,
 		.min_millivolts = 825,
 		.max_millivolts = 1227,
-		CPU_CVB_TABLE_ODN,
+		T210_CPU_CVB_TABLE_ODN,
 		.cpu_dfll_data = {
 			.tune0_low = 0xffead0ff,
 			.tune0_high = 0xffead0ff,
@@ -423,7 +516,7 @@ static struct cvb_table tegra210_cpu_cvb_tables[] = {
 		.process_id = 0,
 		.min_millivolts = 870,
 		.max_millivolts = 1227,
-		CPU_CVB_TABLE,
+		T210_CPU_CVB_TABLE,
 		.cpu_dfll_data = {
 			.tune0_low = 0xffead0ff,
 			.tune1 = 0x20091d9,
@@ -434,7 +527,7 @@ static struct cvb_table tegra210_cpu_cvb_tables[] = {
 		.process_id = 1,
 		.min_millivolts = 870,
 		.max_millivolts = 1227,
-		CPU_CVB_TABLE,
+		T210_CPU_CVB_TABLE,
 		.cpu_dfll_data = {
 			.tune0_low = 0xffead0ff,
 			.tune1 = 0x25501d0,
@@ -445,7 +538,7 @@ static struct cvb_table tegra210_cpu_cvb_tables[] = {
 		.process_id = 0,
 		.min_millivolts = 837,
 		.max_millivolts = 1227,
-		CPU_CVB_TABLE,
+		T210_CPU_CVB_TABLE,
 		.cpu_dfll_data = {
 			.tune0_low = 0xffead0ff,
 			.tune0_high = 0xffead0ff,
@@ -458,7 +551,7 @@ static struct cvb_table tegra210_cpu_cvb_tables[] = {
 		.process_id = 1,
 		.min_millivolts = 837,
 		.max_millivolts = 1227,
-		CPU_CVB_TABLE,
+		T210_CPU_CVB_TABLE,
 		.cpu_dfll_data = {
 			.tune0_low = 0xffead0ff,
 			.tune0_high = 0xffead0ff,
@@ -471,7 +564,7 @@ static struct cvb_table tegra210_cpu_cvb_tables[] = {
 		.process_id = 0,
 		.min_millivolts = 850,
 		.max_millivolts = 1170,
-		CPU_CVB_TABLE,
+		T210_CPU_CVB_TABLE,
 		.cpu_dfll_data = {
 			.tune0_low = 0xffead0ff,
 			.tune0_high = 0xffead0ff,
@@ -484,7 +577,7 @@ static struct cvb_table tegra210_cpu_cvb_tables[] = {
 		.process_id = 1,
 		.min_millivolts = 850,
 		.max_millivolts = 1170,
-		CPU_CVB_TABLE,
+		T210_CPU_CVB_TABLE,
 		.cpu_dfll_data = {
 			.tune0_low = 0xffead0ff,
 			.tune0_high = 0xffead0ff,
@@ -494,6 +587,13 @@ static struct cvb_table tegra210_cpu_cvb_tables[] = {
 	},
 };
 
+static const struct dfll_fcpu_data tegra114_dfll_fcpu_data = {
+	.cpu_max_freq_table = tegra114_cpu_max_freq_table,
+	.cpu_max_freq_table_size = ARRAY_SIZE(tegra114_cpu_max_freq_table),
+	.cpu_cvb_tables = tegra114_cpu_cvb_tables,
+	.cpu_cvb_tables_size = ARRAY_SIZE(tegra114_cpu_cvb_tables)
+};
+
 static const struct dfll_fcpu_data tegra124_dfll_fcpu_data = {
 	.cpu_max_freq_table = tegra124_cpu_max_freq_table,
 	.cpu_max_freq_table_size = ARRAY_SIZE(tegra124_cpu_max_freq_table),
@@ -509,6 +609,10 @@ static const struct dfll_fcpu_data tegra210_dfll_fcpu_data = {
 };
 
 static const struct of_device_id tegra124_dfll_fcpu_of_match[] = {
+	{
+		.compatible = "nvidia,tegra114-dfll",
+		.data = &tegra114_dfll_fcpu_data,
+	},
 	{
 		.compatible = "nvidia,tegra124-dfll",
 		.data = &tegra124_dfll_fcpu_data,
-- 
2.48.1


