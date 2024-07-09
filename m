Return-Path: <linux-pm+bounces-10851-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 29C9692B55F
	for <lists+linux-pm@lfdr.de>; Tue,  9 Jul 2024 12:31:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 151DA28280A
	for <lists+linux-pm@lfdr.de>; Tue,  9 Jul 2024 10:31:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0416714290;
	Tue,  9 Jul 2024 10:31:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EzqsyxRN"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58DF3156862;
	Tue,  9 Jul 2024 10:31:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720521109; cv=none; b=AO4uG9jKZg/sjdpuhyAZdeQrpOBLUfJsKvXX61cofqNqg7Wo6QAy892+kMcgT8g1/jx9LySncFPQxxG2X3Hu3MCmgReoMJHY0TDlvKBW/yOgejW8PgecaToEunu6wlmrFO4hC5exUhzmdXs937Yv3xbphYWHInBwK79YU55nUcU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720521109; c=relaxed/simple;
	bh=M0cT28gjYHuIFgzG9/ClXs9YX1csSfujvjDFgwjE5rc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hTN/nqF6xboZpOm4ipQv1ejukDozjJsMR02oMbfe1uvomEXiISMaD95JQr9BGoOaqMZBF/iy3O6n3avWSf8DdIHih1beau4/wTPSD9j2Z7yw6xkMO4kbM8HcK8lT9f7mCCLmQJDFcVY4lmySalFtHRV+Ovwy6NYbB6FQFVPopG0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EzqsyxRN; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-a6fd513f18bso502350066b.3;
        Tue, 09 Jul 2024 03:31:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720521106; x=1721125906; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dDbouyq7PTfUaRSnNtYQgcWs9NVpLUWQ/wAcLJNaYk8=;
        b=EzqsyxRNbKxkj4ZDUYnrrH/vvJ5ToLZq7P3eN37bCos1Wt0qwnTPH2KKDOSJmxUnq4
         cEqjIhDEgzv77xG5DkTbJVPYys/nhiveuTrFpSK0cKVKyzEizqrpnbrNts1Do2RZQ7Qp
         qqwvJN58Uuba9jQky0mMCHQ/jx3QfmWQPB5DAS8V+Gcn7sAmAOnYOrksFZRxFz8rErl1
         /tSZwvVlYw0fUBK5wumvZYNBufTxyDqojaVna4km5NAohJECJ/8+rte/dG+ACHG8QMa9
         or8glI8mF5fuRaFWXhiGceNkQCIlFw7qSdDIIH3KVtz2Gw62skMOidvjiC+F67m/HaGp
         t0RQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720521106; x=1721125906;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dDbouyq7PTfUaRSnNtYQgcWs9NVpLUWQ/wAcLJNaYk8=;
        b=QigbWZGUGZ2S7YoUmM8YaLtcNzpBODY7ny1uTor7waN6hlmCbYSuMhvuqyHTK+MtC9
         r4XxDSN3nesRFKV5LB6IwIGIC3iZY1bQ3T96Y0tgPCekMbladJjlCBc0d9KEMnb6NVVN
         bGGGyBGEb/dKdxkXcqOKjWMZdag0RcQfX1s0g0x9llm4FoRs0sAOAaWov7uUelVhYP3y
         HrX6rKSkIUVv3gfuE2j6bXErIKV+zZBOb7UahMZ8VNLsafZWMHmt/oo+NklFrOFPs5O1
         VrwkiFLAxEJ1bplYfVJ8Ao6+RbcHAF1i45rRrAnz2+dVjMFqOuXN4a866R9vXzEmZQgQ
         KAHA==
X-Forwarded-Encrypted: i=1; AJvYcCXt8kFr/OwzS0Ha+GPnbEpJ2IPrWRaz1uqqabY6wsSTH4r1D4CFarw2lEVEzz1NItga2slB1LorSEE8rv+YXJYn+lYj5hw1Tao3OfdYn//TmkxZCVzqLgesrsiRz2Nq3QWacBzbRA/yY4XRCYr31htgHfK1rH6zNohKHWZc4za7FtRUQkxBTJulGGk2ee7gU3JntW87VCD5gnc4zeuUDzRVpg==
X-Gm-Message-State: AOJu0YzvWvk+ukq/ign+H/AYwlBL962QPs1fdd06ROA741ucuZLEiBmQ
	j8oHnSgtGKQVJKbb5cQyvXknEhAb85JbgxB3OwWJJ5DDa5oQSNjFGXWSVA==
X-Google-Smtp-Source: AGHT+IEsA/zPMeXS/Kjwa7RgTlDMmN4h02MAxM+4067UQXiCOMEkSVIS0G0E6drBIQ736RcgORKrDw==
X-Received: by 2002:a17:906:3590:b0:a77:c8f8:f9d0 with SMTP id a640c23a62f3a-a780b705305mr135816666b.44.1720521106064;
        Tue, 09 Jul 2024 03:31:46 -0700 (PDT)
Received: from localhost.localdomain (bza125.neoplus.adsl.tpnet.pl. [83.30.46.125])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a780a6bcc21sm66528166b.16.2024.07.09.03.31.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jul 2024 03:31:45 -0700 (PDT)
From: Adam Skladowski <a39.skl@gmail.com>
To: 
Cc: phone-devel@vger.kernel.org,
	~postmarketos/upstreaming@lists.sr.ht,
	Adam Skladowski <a39.skl@gmail.com>,
	Georgi Djakov <djakov@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Vladimir Lypak <vladimir.lypak@gmail.com>,
	Rajendra Nayak <quic_rjendra@quicinc.com>,
	Rohit Agarwal <quic_rohiagar@quicinc.com>,
	Danila Tikhonov <danila@jiaxyga.com>,
	Bjorn Andersson <andersson@kernel.org>,
	Stephan Gerhold <stephan.gerhold@kernkonzept.com>,
	Andrew Halaney <ahalaney@redhat.com>,
	Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
	=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>,
	Barnabas Czeman <barnabas.czeman@mainlining.org>,
	linux-arm-msm@vger.kernel.org,
	linux-pm@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Abel Vesa <abel.vesa@linaro.org>,
	Sibi Sankar <quic_sibis@quicinc.com>
Subject: [PATCH v3 9/9] dt-bindings: interconnect: qcom: msm8953: Fix 'See also' in description
Date: Tue,  9 Jul 2024 12:22:54 +0200
Message-ID: <20240709102728.15349-10-a39.skl@gmail.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240709102728.15349-1-a39.skl@gmail.com>
References: <20240709102728.15349-1-a39.skl@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

"See also" in description seems to be wrongly defined,
make it inline with other yamls.

Fixes: 791ed23f735b ("dt-bindings: interconnect: qcom: Add Qualcomm MSM8953 NoC")
Signed-off-by: Adam Skladowski <a39.skl@gmail.com>
---
 .../devicetree/bindings/interconnect/qcom,msm8953.yaml         | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/interconnect/qcom,msm8953.yaml b/Documentation/devicetree/bindings/interconnect/qcom,msm8953.yaml
index 732e9fa001a4..1397ad6ba37d 100644
--- a/Documentation/devicetree/bindings/interconnect/qcom,msm8953.yaml
+++ b/Documentation/devicetree/bindings/interconnect/qcom,msm8953.yaml
@@ -13,8 +13,7 @@ description: |
   The Qualcomm MSM8953 interconnect providers support adjusting the
   bandwidth requirements between the various NoC fabrics.
 
-  See also:
-  - dt-bindings/interconnect/qcom,msm8953.h
+  See also: include/dt-bindings/interconnect/qcom,msm8953.h
 
 properties:
   compatible:
-- 
2.45.2


