Return-Path: <linux-pm+bounces-10849-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4981F92B557
	for <lists+linux-pm@lfdr.de>; Tue,  9 Jul 2024 12:31:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E80861F21959
	for <lists+linux-pm@lfdr.de>; Tue,  9 Jul 2024 10:31:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35510155C8C;
	Tue,  9 Jul 2024 10:30:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jp+GRLWA"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97B9014290;
	Tue,  9 Jul 2024 10:30:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720521056; cv=none; b=STB54goSDDpiUAxxPumED4MFRjGlGLlmbne2hHBACU8U5Yjnqh9bRI1hHZUhLDlMh//sJIdNgNXcF2XGEV3OzGq63bSgCG/yk4sk8v5LC1W7Ud2RAlqb6INMeK+MoEHAiynyQn/WEQgo7urAi+suyq5obQ6WudLAvtYeWQQFfpw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720521056; c=relaxed/simple;
	bh=xfPBQzBeW4Tv/lqWpULf17daEKzix9DRjXatlfKOswk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oQnaITZPdjOdVghBUVkpTzSeWsgvtK9HQju9GAuVbimDjGV6LCZrgVDIBvJ8BNnfUcEB/wtHLLCPE9o8B/GTVtuJDFiILWs8tncSAgNbwvKfKbe/vb4vjEETmIzbYlmdltB95IPci8vGFEPY+vjpMWqZ4gv5qQe0qsCQvQm49zs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jp+GRLWA; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-5956fbe6d0dso440549a12.1;
        Tue, 09 Jul 2024 03:30:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720521052; x=1721125852; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aIt+jIdXxKvutjLGPruJn2rCWqpErD00vGwYrFUI2jE=;
        b=jp+GRLWAP41qyMHCn7QAnIHrAXBlAhjN1pFKsaw946jWZ2wNJAUMyMtJqUNPjPmMmt
         EvaGYiTQn8ILZjtp2rYJkLPgLQf3/fu9/FjH45YY8/vR1p1Cnzp9sjObOaWlFEASr2n/
         YpulxOLJs1zIHrjHK7TV8GuQelWcBqq7oWH7lnflc7T9Rz5bmRA8O37EISCNOp8zD2b7
         lPxnkyHlUbjIFSLFWHENz2e73LCzTGbiQRO8r50S8UVkpl66CAThfgDxAJ4mVJs1bGa2
         qtqzbtEDWwJlvXW4UDL+rJ3mCvR5clTYaV/y4NgCYGHapiVLAIcCK/yRxo2fYFzH2wOt
         JYuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720521052; x=1721125852;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aIt+jIdXxKvutjLGPruJn2rCWqpErD00vGwYrFUI2jE=;
        b=TRaLerClM7UCidSABsydWiTP1t0oAN3H7/QciXNkjpk6ihgeryKYLYv9mq+TrBm0uf
         GiFbeTK2OuXGK1+dbaqGHepiaMkqFEKlpaRGlgESuQe/Cc9FH25OA/bwxpi7jnDfiPsE
         QLSxHUXrBSh7PuzCth/QwnWY/Sk6IIiO8oP/7PFKCxDcclK08zpOtdYcgSYDYXhIjdzn
         mgT0es4gGXWCLsOwZoljXJunvfXnTVHSF+d6sdb05kI6eag/w+RtkGTSGn0p5fqJkgSo
         D+A017uSIs/hKps1YvawI+28HTOPBaWMzJK/6TcB1gFWICaZ3asDTCZhH+uubHrjN3cv
         j8SQ==
X-Forwarded-Encrypted: i=1; AJvYcCURbbPEI0irIkGcOt2DdDNAyd7PFzEZwpTfLOZ5uV83zEJ4w3IkbGyhCKc58T6jGj6Tdyk17UoXX+s40sDNqRzB3IxEn9pq9vdxW+BMXawRoiovToOyAfjVPfeBajchZXJXAe/bgI/0y4mctt0xJI081YXho8rSnmZvgqsI92UiZscSo9I5QEZbHsFc1LL/KNmRPPhueACHQIDsWVFRw9KQnA==
X-Gm-Message-State: AOJu0YzUWnkv7wfvVfHQuxhnPixR/sqo669G9b1cxvoFDJoG4nBdd/v9
	AhQhQiBgC6gAnVV0gUE+/c8eSn4sR8o0FIDKgR/bBVl5l9MzZuUsSKcVrg==
X-Google-Smtp-Source: AGHT+IG+g0RfzuMoLuFgs/UBmwZ7vjY32b0jDS5/Rd7t7zjlcn8tVPd2nXkOMlzIcrAZ5LhXPoupfg==
X-Received: by 2002:a17:906:f146:b0:a72:81f5:85b6 with SMTP id a640c23a62f3a-a780b6b1e19mr135544366b.18.1720521052536;
        Tue, 09 Jul 2024 03:30:52 -0700 (PDT)
Received: from localhost.localdomain (bza125.neoplus.adsl.tpnet.pl. [83.30.46.125])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a780a6bcc21sm66528166b.16.2024.07.09.03.30.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jul 2024 03:30:52 -0700 (PDT)
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
Subject: [PATCH v3 7/9] dt-bindings: interconnect: qcom: msm8939: Fix example
Date: Tue,  9 Jul 2024 12:22:52 +0200
Message-ID: <20240709102728.15349-8-a39.skl@gmail.com>
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

For now example list snoc_mm as children of bimc which is obviously
not valid, drop bimc and move snoc_mm into snoc.

Signed-off-by: Adam Skladowski <a39.skl@gmail.com>
---
 .../devicetree/bindings/interconnect/qcom,msm8939.yaml      | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/Documentation/devicetree/bindings/interconnect/qcom,msm8939.yaml b/Documentation/devicetree/bindings/interconnect/qcom,msm8939.yaml
index d19e20247df8..4b08be72bbd7 100644
--- a/Documentation/devicetree/bindings/interconnect/qcom,msm8939.yaml
+++ b/Documentation/devicetree/bindings/interconnect/qcom,msm8939.yaml
@@ -69,12 +69,6 @@ examples:
         compatible = "qcom,msm8939-snoc";
         reg = <0x00580000 0x14000>;
         #interconnect-cells = <1>;
-    };
-
-    bimc: interconnect@400000 {
-        compatible = "qcom,msm8939-bimc";
-        reg = <0x00400000 0x62000>;
-        #interconnect-cells = <1>;
 
           snoc_mm: interconnect-snoc {
               compatible = "qcom,msm8939-snoc-mm";
-- 
2.45.2


