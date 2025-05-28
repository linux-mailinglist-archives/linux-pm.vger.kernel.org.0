Return-Path: <linux-pm+bounces-27756-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 318B9AC71A9
	for <lists+linux-pm@lfdr.de>; Wed, 28 May 2025 21:46:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 80E6AA27E1C
	for <lists+linux-pm@lfdr.de>; Wed, 28 May 2025 19:45:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12CFC220F2B;
	Wed, 28 May 2025 19:44:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Q2uKJWaW"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A52F21FF5E
	for <linux-pm@vger.kernel.org>; Wed, 28 May 2025 19:44:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748461490; cv=none; b=il8bKw+RI3+Vi+7Naqz++Qrf2vB8yCPhRPp3nlvqS12gFDwqJvZ3ttcKjIO3zV2vGykMkLfmQ1B33WvM7/zFfYZuVpuEXuP7izx/U32tzv784e7YbAD7L4e6OrSddCrWtdIel+Rqjpe9J3gQy/ctIPd9VS5jNWhkclN1jdAc1cc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748461490; c=relaxed/simple;
	bh=NsbxytOYWrXE3noj6kwrK97+xlKGqouOO51NUpMV9Gw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=emyBfcVLQLnqDgCF72VsBzqzRrusyTk0Ix3bR7LN/vtjplFAP96+LCgd7UPVefcQBWCQGNm92RslHAg1KLwfWS1amu+InRaPYNH1bMQqDfV+baYxQPxgXGtdi36r/4n5kynDewaOqa6i7jK/ukwRu9OYfxg4oZgCZDloQkXKiqg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Q2uKJWaW; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-3a4eb4acf29so26141f8f.0
        for <linux-pm@vger.kernel.org>; Wed, 28 May 2025 12:44:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1748461486; x=1749066286; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hT2eARVVBUoBTxUln7TLvVM6HhTKGafXKW8Q+FpQYKY=;
        b=Q2uKJWaWqpwlXVV9H4LBuaBnhELmQ7GsIbl5C/wHeL1lDIOh9Jr+ublYGHOEIqEgYb
         /nKuO3sJuB1jJ1bWxqEOmucALiWrpjRAJCJiJPUrzPIijt+CEHLVAexj2nm8UISGfXFf
         XKgc5PtE8WfUDrKfobFR7zsAKKMO2QcEocrg4U5o3HlQhlcgA4Lp49KdB/uzEElAQKWX
         uA3cJLnsW/nIhKOTIKu04uvF8QGw354kXs0nVLaM1Ng8N51H+HcWiPNPdSIa5nKOr38l
         KbgeAZ66i39rk/283gjSU0cGI21CS4NBaoRSZzx+fZhO980tPaWIAwUpyaRjVeNsuJwS
         rmRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748461486; x=1749066286;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hT2eARVVBUoBTxUln7TLvVM6HhTKGafXKW8Q+FpQYKY=;
        b=IievPwFWMhhzWyPMYvfis1vc3OuXEtAsuCcqXVqfvgXYkEv+FEvhwDYkVZ1dsHhtTw
         C/DZPHQ7V2ck4hR1IoOlLdu59q2fCM9V9y7rfqJ/UjuEY84QMN8wWoSJ7/DIB1yU02Y2
         4rdMc2fUthkNLQrs5NQg1kaZX79seHf7afPY4mdFJ7KKo7mKbJK5Mlorv04JCYOOpack
         FpiVXZOYtOduzekaQM/yCjEciXjBOn5WkPMyuARHDZr18uqzcrMUo1o6VEA5f1/QnF3r
         lvCRBo6sREoEPoy2Ef7MaIi/P5kKbgHAONP3LI8KWmTKFWGzFffSV9qz2R3NwhufzXUC
         7mjg==
X-Forwarded-Encrypted: i=1; AJvYcCUqWs9FnrTvfv3l9kxnxVamYAF866U6VWAlDM8HiPhUZhs002Hk6BJ87fPIWKUuvMGT66M70U5H0w==@vger.kernel.org
X-Gm-Message-State: AOJu0YzCU+TuEJC23AjdcmoSacBdcbdHt7EQ12kvodU2qKEQOIIAlqwh
	t0BcaqYp/W6DS1oLTM80LFEUdMttnMBRASE4TlNx/vE3iB+c4JhDsK1hyZO0stkCrYQ=
X-Gm-Gg: ASbGncvIWcPrjFzj1LQXrJXJAZdU0YBGahzlmJDCJfOScLZHVQmLit8ENc1L1k2tRQd
	nB1Hj3mGuMvwLzFXqqG23WZKvxzimA/xf0P0O7WtgHF+ZlqitLxoSBYUtist4cRHMQMBWoJ2QPN
	wxTTJdNEiujQ6aXQhVruhvz1yhSb5OqAkYIuTKcw/uMwako7ThvOJew8k3ta3NPvD95bUUxyUu/
	sMWFvwie7cQxOUEtwm3uWafIr4yoXA4ef2hUiZ+ZJME4gfU+LRHrrGMt5nHiu7V9EeznIyJvH/S
	9BrN1yUMexjRvbAkAKU7ko+TjLDDYZy+uurbBvB+JZGyI1ZupunruROFKaHWGw==
X-Google-Smtp-Source: AGHT+IGyeYQHk86txvFQjNL/kSzOaC8oxeV3ojClqoAenP1P/ur0pNI6V3/rZlFaCma/DHhesO3K4w==
X-Received: by 2002:a05:600c:511b:b0:43b:c0fa:f9c4 with SMTP id 5b1f17b1804b1-44c94c246aemr64089155e9.4.1748461486426;
        Wed, 28 May 2025 12:44:46 -0700 (PDT)
Received: from kuoka.. ([178.197.223.125])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-450cfc15b6csm382385e9.20.2025.05.28.12.44.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 May 2025 12:44:45 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To: Sebastian Reichel <sre@kernel.org>,
	linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH 2/2] power: supply: bq25980_charger: Constify reg_default array
Date: Wed, 28 May 2025 21:44:41 +0200
Message-ID: <20250528194439.567263-4-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20250528194439.567263-3-krzysztof.kozlowski@linaro.org>
References: <20250528194439.567263-3-krzysztof.kozlowski@linaro.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1391; i=krzysztof.kozlowski@linaro.org;
 h=from:subject; bh=NsbxytOYWrXE3noj6kwrK97+xlKGqouOO51NUpMV9Gw=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBoN2eo1Kuszup7yhN+GZtOI3JsBm3QYMVHbHabl
 vyKR4N6o6GJAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCaDdnqAAKCRDBN2bmhouD
 13ilEACG9NlaN5wrc/sjH3QMxeAFQ/kznikD7vfOUfEPVw9qwjJ9uAArQf9fRUonn8RO3dXbp9l
 0qqtybXHkD2clL3Nki30januUHKEKJ898tu6Ky84O1sOo+vJGT4Jo+iDdajbsP2M2USVtOkD00p
 pZIn0DJqLovwakM9OMbno34vGicr7tXGmvH3jrPiAscVX3hwrCPAZuDF5VsjHoH8P8QTMmIwf9g
 Qz4sxkGNOTZNsO4rVJ42pQ8KbR19xnM6u7vh+FrPwVfPgbJJZYljHhb2RZuAJ+5CN8Ahp+6Bxec
 ul7ee+/RSGqxdFEqdRxphy6upvL4Bd+7P9rzQcNpOWKDchO6U/iEN4zBdWkl9YvJL/PIBKXeo5U
 s1hSJKIkD3Ce1rbLZZZSXw3EXPlnXXEQflKKJ2SYn2Ywm7dcRCMlUVTZQ+Ol4zS/cyq0fBMrNmY
 14sel74Q3EHn2oCZv9Zb0IPSPhrYufCF+n1vm7Q0Shgcea+tLmCZEGhR8M7xaLpvIyz+zmVZ0rw
 X2A+bQfNOcJQgPz/FYSw4HrwleYAVvoPs/iwf2MkleDZMX+MdT0hT05t1rzqrjjWyebJ4pwMTrN
 ftOqlUCUMWGdG8AzS4S6vDMZIRTPAJNWnSf7SEzJ7SGb4A1vIMYfu7p56wfgqZnI+sAmN78amsE SgeqHKaaclwMYzQ==
X-Developer-Key: i=krzysztof.kozlowski@linaro.org; a=openpgp; fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B
Content-Transfer-Encoding: 8bit

Static 'struct reg_default' array is not modified so can be changed to
const for more safety.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 drivers/power/supply/bq25980_charger.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/power/supply/bq25980_charger.c b/drivers/power/supply/bq25980_charger.c
index 4ff76e3dddf6..723858d62d14 100644
--- a/drivers/power/supply/bq25980_charger.c
+++ b/drivers/power/supply/bq25980_charger.c
@@ -104,7 +104,7 @@ struct bq25980_device {
 	int watchdog_timer;
 };
 
-static struct reg_default bq25980_reg_defs[] = {
+static const struct reg_default bq25980_reg_defs[] = {
 	{BQ25980_BATOVP, 0x5A},
 	{BQ25980_BATOVP_ALM, 0x46},
 	{BQ25980_BATOCP, 0x51},
@@ -159,7 +159,7 @@ static struct reg_default bq25980_reg_defs[] = {
 	{BQ25980_CHRGR_CTRL_6, 0x0},
 };
 
-static struct reg_default bq25975_reg_defs[] = {
+static const struct reg_default bq25975_reg_defs[] = {
 	{BQ25980_BATOVP, 0x5A},
 	{BQ25980_BATOVP_ALM, 0x46},
 	{BQ25980_BATOCP, 0x51},
@@ -214,7 +214,7 @@ static struct reg_default bq25975_reg_defs[] = {
 	{BQ25980_CHRGR_CTRL_6, 0x0},
 };
 
-static struct reg_default bq25960_reg_defs[] = {
+static const struct reg_default bq25960_reg_defs[] = {
 	{BQ25980_BATOVP, 0x5A},
 	{BQ25980_BATOVP_ALM, 0x46},
 	{BQ25980_BATOCP, 0x51},
-- 
2.45.2


