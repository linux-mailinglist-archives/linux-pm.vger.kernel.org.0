Return-Path: <linux-pm+bounces-5439-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 534B688CD60
	for <lists+linux-pm@lfdr.de>; Tue, 26 Mar 2024 20:43:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 08AB02E7045
	for <lists+linux-pm@lfdr.de>; Tue, 26 Mar 2024 19:43:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D9E513D292;
	Tue, 26 Mar 2024 19:42:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="z2b1FnVQ"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A44F13D264
	for <linux-pm@vger.kernel.org>; Tue, 26 Mar 2024 19:42:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711482167; cv=none; b=NNasVMqqz7Ik+TVYac6p4ZDQ2PYcuQc9tk6a716HTbgRq28+Xn+qBMr+EXXSXHY+ZylBRLMAd6YJMExu/ZJBGCuIP1UwxBpnqLtyZ+AfoAJ7SCs2495TnmizTbPcjDKepvQ23W3Ts88mld3IL2L9FcntGjwI/IhKKJNCyoFSBaY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711482167; c=relaxed/simple;
	bh=oOKy+s0UncDHMzy0sCXGno/jN+7VHEire36Z2/0jSjs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Y0BENDEcxkPow0t5DkruoLRy3Ru1m7TJhxTlshs4L8MLB+2bE4ZDqPCytUn1K4UctaIlNphMlYpAioDDSfCqHIlMkxLRwk/jbRuaXAHgL1/rDKRYzh+BV8otdciIxkBxpw92p0h2Ak+PqDzBxmo9ssLlefScI0svVViAG9V5Wec=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=z2b1FnVQ; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-a4a3a5e47baso310327366b.2
        for <linux-pm@vger.kernel.org>; Tue, 26 Mar 2024 12:42:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1711482164; x=1712086964; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=X2MOT4emaHQnBcdhGx0ryRRILbJ/qZ8WNQ+3qQOoAxc=;
        b=z2b1FnVQv97RYu++PgQ8xak+X11GMZfF2xfHFUv6pZicjgHRXe2jXwbgvxQqN2Idzr
         QwWV7v3KmLkLk7zwO25dLprI83YvwKXWWR+aS4IwxI0pr0bGm/U6thRtCPQWtVPRamIB
         +ngaqOiYQj5rqzA8PHVH4VOBChSe+av06CmJRQAoxgik1grxO3LPxsS2IYnTJAKg2c3o
         7VQs0Y5kJEWJOg30jqOGzC5ovlJtpMsJCElOSWGKCs6vN5n1/dm3fjMxFkL3JmoLaCyp
         i3VmrRytaCIi8RI1wSL7TEMyNyBnKs/96iv8t66+bRFZmn1zKGdNVuM0eN4f51r9IgAu
         /lYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711482164; x=1712086964;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=X2MOT4emaHQnBcdhGx0ryRRILbJ/qZ8WNQ+3qQOoAxc=;
        b=Aa5xrsR2Ix45K/S5mmWwFrJdcKB9AUM2vrmpo9Skh1ZAubIbBVba6RujSvz5B2Oi8f
         uUdKAxS2SGxiBT3N5uY/zH8OPw0EBBgY//1LHZ8b2PoojUjZbbCPao3mw8lxvXWT0wB+
         2C5Wnb18NM6PXJJ284pJU25ZHMerff9q8GxVd5IpgPcLuQgOUWflyXddUNejCWiCIaAJ
         xRZm2l13EoBAjPV1r26TwA08b7RCzWZB28TOk/oZY+EXiU9Ta+Igj5Yxpddz8dl/TiWw
         rUCvAbubzK5Aldz/8endKzkrzGJHn20+RR3cBm9m07X0JGGNSLQuDY7MC4Du1BWvObz+
         A0Ug==
X-Forwarded-Encrypted: i=1; AJvYcCUk+IVIbPqDWOOAHXA/bGVfQrp30vbLuth22rVogquB3gIc77+LvZaayJ9O/p7goGk4ah1ug44s5GQmuVdLRNEfGFoYS+RSU44=
X-Gm-Message-State: AOJu0YyVPp7EzU8GRcuQOH7IPWheRCjAkWVgfAZzmcivoJEnp+Uolzna
	6I+2q/qXvi755BLIECe3mYlk3PjVONekejBvXDnr30DvGI1Wb2nTnfhJopOSi2w=
X-Google-Smtp-Source: AGHT+IEtLIh+oxJU3qv0DY10/DtNE3qVjcy0SfG34hWYv/2FwteGaYK6Yyc3PMONxp3/QRIYq0fwNQ==
X-Received: by 2002:a17:906:c099:b0:a46:da84:471a with SMTP id f25-20020a170906c09900b00a46da84471amr7761655ejz.63.1711482163867;
        Tue, 26 Mar 2024 12:42:43 -0700 (PDT)
Received: from [192.168.92.47] (078088045141.garwolin.vectranet.pl. [78.88.45.141])
        by smtp.gmail.com with ESMTPSA id i8-20020a17090671c800b00a46d4e26301sm4523807ejk.27.2024.03.26.12.42.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Mar 2024 12:42:43 -0700 (PDT)
From: Konrad Dybcio <konrad.dybcio@linaro.org>
Date: Tue, 26 Mar 2024 20:42:33 +0100
Subject: [PATCH 2/4] interconnect: qcom: qcm2290: Fix mas_snoc_bimc QoS
 port assignment
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240326-topic-rpm_icc_qos_cleanup-v1-2-357e736792be@linaro.org>
References: <20240326-topic-rpm_icc_qos_cleanup-v1-0-357e736792be@linaro.org>
In-Reply-To: <20240326-topic-rpm_icc_qos_cleanup-v1-0-357e736792be@linaro.org>
To: Bjorn Andersson <andersson@kernel.org>, 
 Georgi Djakov <djakov@kernel.org>, Shawn Guo <shawn.guo@linaro.org>
Cc: Marijn Suijten <marijn.suijten@somainline.org>, 
 linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Stephan Gerhold <stephan@gerhold.net>, 
 Konrad Dybcio <konrad.dybcio@linaro.org>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1711482160; l=803;
 i=konrad.dybcio@linaro.org; s=20230215; h=from:subject:message-id;
 bh=oOKy+s0UncDHMzy0sCXGno/jN+7VHEire36Z2/0jSjs=;
 b=47PKuOBRf08el4ftmJgJT7Eg306dqETTPhwAVizzG4J7znmhOgtxetRjkkC3VVGcxQItWiI3H
 21PDaJ9veoMB7RJJt0YBLSygubYU6cWXMEbsVpmb8M2Gm6AjkiT9Sa6
X-Developer-Key: i=konrad.dybcio@linaro.org; a=ed25519;
 pk=iclgkYvtl2w05SSXO5EjjSYlhFKsJ+5OSZBjOkQuEms=

The value was wrong, resulting in misprogramming of the hardware.
Fix it.

Fixes: 1a14b1ac3935 ("interconnect: qcom: Add QCM2290 driver support")
Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
 drivers/interconnect/qcom/qcm2290.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/interconnect/qcom/qcm2290.c b/drivers/interconnect/qcom/qcm2290.c
index 96735800b13c..ba4cc08684d6 100644
--- a/drivers/interconnect/qcom/qcm2290.c
+++ b/drivers/interconnect/qcom/qcm2290.c
@@ -164,7 +164,7 @@ static struct qcom_icc_node mas_snoc_bimc = {
 	.name = "mas_snoc_bimc",
 	.buswidth = 16,
 	.qos.ap_owned = true,
-	.qos.qos_port = 2,
+	.qos.qos_port = 6,
 	.qos.qos_mode = NOC_QOS_MODE_BYPASS,
 	.mas_rpm_id = 164,
 	.slv_rpm_id = -1,

-- 
2.44.0


