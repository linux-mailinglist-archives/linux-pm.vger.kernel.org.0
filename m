Return-Path: <linux-pm+bounces-38024-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D813C5C4C9
	for <lists+linux-pm@lfdr.de>; Fri, 14 Nov 2025 10:35:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B621C422B20
	for <lists+linux-pm@lfdr.de>; Fri, 14 Nov 2025 09:31:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B56223093AD;
	Fri, 14 Nov 2025 09:31:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fairphone.com header.i=@fairphone.com header.b="SvnjwB+r"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C132307492
	for <linux-pm@vger.kernel.org>; Fri, 14 Nov 2025 09:31:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763112679; cv=none; b=rrSS+qpx9GQnLvWiiL37E9xhdOWpsjJMG0kUFp0zvdm9rAV9P4BH5JM87BJet2X8zjwClaCk8Ryo7eSTilKv6fzTYMGY1dzl5IvSBfCzJSAsU1/UeOWdZDAY4B3hbra977H+JCx6PyHOli21HZ9KImrO/uy555JEVUyzuQv4OGk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763112679; c=relaxed/simple;
	bh=EXmlrAx8G+qEQXvn4Hjc2SxpukaT9VckUvipBtJ1isk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=JANrVKKli1Ktc9Yy749NjTFiUe2WFSoVnEV/cswFDey8db0rrIWB2AjB13rMyAFc+ngcZcHgFaNwQWEZ6nGwlfKlp4C5n4Z0Xg/5umvuQOEAU0sInd0dqpCO/QGaRdWiBVQblxv7pEobNYuVrypiumUjGfQQJQ0etMLIr7OjTUA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fairphone.com; spf=pass smtp.mailfrom=fairphone.com; dkim=pass (2048-bit key) header.d=fairphone.com header.i=@fairphone.com header.b=SvnjwB+r; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fairphone.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fairphone.com
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-b713c7096f9so218030066b.3
        for <linux-pm@vger.kernel.org>; Fri, 14 Nov 2025 01:31:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fairphone.com; s=fair; t=1763112675; x=1763717475; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bjagkFHTl3ZcyROBN79dvzdfXtI/biV++zkJ6Wi3X80=;
        b=SvnjwB+rXaGh+yKxRpV4Mq1iY2MfxvdkgTRY7HMO4N2sMRGSjMIizbgVW5FG66svhc
         +bNZU6S5TJZgeAS8tXsAC5KwFpPjDUP+vtIebpHUU56LSDWkTOToxpkK+x4+jNo/vFHs
         lMdatv88qutTVM+Em51R+agNv4mjk5nUPKOXPhNAU/OKU/iZ3ztidejN2Ugig53q/6pn
         9GpUlyJnrIW5pH+DiIWhLBFe7TS8kNhrHTl+Xa/1jA0CZFqpa+88L3GCir8K2dZtUkru
         jwT7pdS2h8f0qPLj7TeqFopF0l+SIaOmfdKn4NN7OgPsuXwkfQwUfLwgvdm+cWx/3030
         SQdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763112675; x=1763717475;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=bjagkFHTl3ZcyROBN79dvzdfXtI/biV++zkJ6Wi3X80=;
        b=UBWcN83LTitsmseKpTSUS+CKoVPeawTnODtPOzuI1dOP3lVKmQ+TLnrHXi4rZZ3UJ2
         VsgcTS87Ntuybez03pO0BsAiV4Vt7fFA4DsIZ2jbqq0NJYfkGY3Fu9Wd4nUZ7VLt0eeZ
         5k8HEFkt1WeWM3bGIZNh7/HTOYIKAZ26jgBRPtydxQP+QY1Ys+KUsf3I0rOF6Ji4iI9Z
         OGV5JI9HaDlB3MqI8TKowLfRtYKru4K1XzG5c1ARiCz/T7du3FNp+E9oMdXE9XqkUS4N
         ldBTPGn7PsmxHNSs6akVaQxLXrMUDSiF1G+oq6S9ahM2Guqo5pyBTVev5OA6UP+K731U
         vORg==
X-Forwarded-Encrypted: i=1; AJvYcCU/LfyI/IRjfyr4zLq0kzYXaYHgu6nC3W9SXAUpqbrGjzUDn94jFA2c5eC0JPuSLVWDJQKIGz/LSQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YzkBprkNTT0Oc4w28C4Oep6J1TdQ8GQyDRKmylUHC2QPwvr5MCe
	te2YfEdw5UDssyttv28xoITYt1BsSG/6XaBDwp+dOjnRTdGisD8FdU1+Y4asXKa+h3I=
X-Gm-Gg: ASbGncul9id5xx8dIIZ4PEL9BN0TxEL7q9QAs36a8pFfe1eFCuWfSjSThlzPXmc85NE
	ljkzLUEoGS17UCqTr2Cq5TzUjfB7Ukm+wPBccwb1DoWM0UspqF4gjZIuosUVDud8bk9OinSzHsL
	VUMXg6TtYwSkcub8qM4c2O/3WWgLyVrm11MEmNHVmz/qNyCp/fiH9aGUShglnfYLyW5KGNkx3z+
	/Z4oJ26BF0hckOEAp9K255+BtsnkCZye1FvOdJtQPT5k6maMRCGRI7YPwYUAqHBTYViSkIpkmTY
	bN5t80j9NdutdH5kWaMnUSdbO6lfOaS0TIqtRcs6v8gaZ0BoohwWKAqX+fmaXLG1qLioFlmL7e7
	VpMgnZ9quBZcAZHjNkOQ1gCsfGdZ25HLo1cSLpEU9CCpHXBdYoYoaoADGsD1i6SW7KCIFVjugoh
	g2BsUX4HzZnJGTdDEo31EQtqjSDKxbjWf7gzskiZRosibXhT7H4sVXIYyBPRcGcXlhBzx6GEthn
	ZIKeoOBDxgbDB7LGEd+nTU=
X-Google-Smtp-Source: AGHT+IF93Hcmy+2QpI1Usg+qVaNay64indlpTI/ams9EhdWoqHHpowSpmlonp+hK3sYc2L//Ct4xhQ==
X-Received: by 2002:a17:906:c10b:b0:b3b:5fe6:577a with SMTP id a640c23a62f3a-b73677ece6fmr210520666b.8.1763112675373;
        Fri, 14 Nov 2025 01:31:15 -0800 (PST)
Received: from [192.168.101.179] (2001-1c04-0509-ec01-156d-fa6e-7f19-0b67.cable.dynamic.v6.ziggo.nl. [2001:1c04:509:ec01:156d:fa6e:7f19:b67])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b734fd80841sm352104366b.41.2025.11.14.01.31.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Nov 2025 01:31:14 -0800 (PST)
From: Luca Weiss <luca.weiss@fairphone.com>
Date: Fri, 14 Nov 2025 10:31:10 +0100
Subject: [PATCH v2 2/5] interconnect: qcom: icc-rpmh: Get parent's regmap
 for nested NoCs
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251114-sm6350-icc-qos-v2-2-6af348cb9c69@fairphone.com>
References: <20251114-sm6350-icc-qos-v2-0-6af348cb9c69@fairphone.com>
In-Reply-To: <20251114-sm6350-icc-qos-v2-0-6af348cb9c69@fairphone.com>
To: Georgi Djakov <djakov@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konradybcio@kernel.org>
Cc: ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org, 
 linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Luca Weiss <luca.weiss@fairphone.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1763112672; l=1698;
 i=luca.weiss@fairphone.com; s=20250611; h=from:subject:message-id;
 bh=EXmlrAx8G+qEQXvn4Hjc2SxpukaT9VckUvipBtJ1isk=;
 b=Yz/vL8tGTL2oSQMgT7z1ixGoz4iaaPuz42Yx+czSB0njpQPU2HdbrCP2DQwyMtej+3iMSF5Ge
 J7XNWTAR7w2D7rA4AS/afTP/WyeDvLj4F4qaBNh9dKkKfnpqudsWjw9
X-Developer-Key: i=luca.weiss@fairphone.com; a=ed25519;
 pk=O1aw+AAust5lEmgrNJ1Bs7PTY0fEsJm+mdkjExA69q8=

Since commit 57eb14779dfd ("interconnect: qcom: icc-rpmh: Support child
NoC device probe") the icc-rpmh driver supports initializing child NoCs,
but those child NoCs also need to be able to get the parent's regmap in
order to enable QoS.

Change the driver to support that and support programming QoS register.

Signed-off-by: Luca Weiss <luca.weiss@fairphone.com>
---
 drivers/interconnect/qcom/icc-rpmh.c | 19 ++++++++++++-------
 1 file changed, 12 insertions(+), 7 deletions(-)

diff --git a/drivers/interconnect/qcom/icc-rpmh.c b/drivers/interconnect/qcom/icc-rpmh.c
index f90c29111f48..3b445acefece 100644
--- a/drivers/interconnect/qcom/icc-rpmh.c
+++ b/drivers/interconnect/qcom/icc-rpmh.c
@@ -308,14 +308,19 @@ int qcom_icc_rpmh_probe(struct platform_device *pdev)
 		struct resource *res;
 		void __iomem *base;
 
-		base = devm_platform_get_and_ioremap_resource(pdev, 0, &res);
-		if (IS_ERR(base))
-			goto skip_qos_config;
+		/* Try parent's regmap first */
+		qp->regmap = dev_get_regmap(dev->parent, NULL);
+		if (!qp->regmap) {
+			base = devm_platform_get_and_ioremap_resource(pdev, 0, &res);
+			if (IS_ERR(base))
+				goto skip_qos_config;
 
-		qp->regmap = devm_regmap_init_mmio(dev, base, desc->config);
-		if (IS_ERR(qp->regmap)) {
-			dev_info(dev, "Skipping QoS, regmap failed; %ld\n", PTR_ERR(qp->regmap));
-			goto skip_qos_config;
+			qp->regmap = devm_regmap_init_mmio(dev, base, desc->config);
+			if (IS_ERR(qp->regmap)) {
+				dev_info(dev, "Skipping QoS, regmap failed; %ld\n",
+					 PTR_ERR(qp->regmap));
+				goto skip_qos_config;
+			}
 		}
 
 		qp->num_clks = devm_clk_bulk_get_all(qp->dev, &qp->clks);

-- 
2.51.2


