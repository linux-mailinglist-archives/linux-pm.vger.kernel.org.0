Return-Path: <linux-pm+bounces-40244-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 1902BCF6360
	for <lists+linux-pm@lfdr.de>; Tue, 06 Jan 2026 02:12:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C9ED5308111F
	for <lists+linux-pm@lfdr.de>; Tue,  6 Jan 2026 01:11:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E0BA31578F;
	Tue,  6 Jan 2026 01:01:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="aMl9wn13";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="ecpfhQwM"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AE193148A8
	for <linux-pm@vger.kernel.org>; Tue,  6 Jan 2026 01:01:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767661298; cv=none; b=WTuvF21sLtuX1StgoFJ3UrHQ9uD9PovQqNbM/+eA18QoEgmObZjI2UxJxySIlVClRa39SscF36/z1v/sUpZHCH+Dt3BxbrYPjizMckBih61Nulb/QtgCRyka34DN7jZgN62qmsbR6/uNtxEhsvln1FbdRfbSGupOUpsh5yx21u0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767661298; c=relaxed/simple;
	bh=Sxwe6pBBzgKc/Rbx3hGlBLXglP8Dn+Y8xXV50hDaYm4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=loXQ6uonQGbQi0tcUkwaej/oOefdGL0TGwsPKpt/dguZ0zpewk+EdO7gsUPhAsf7UAtOJFitBbHWV5CgyWtimAJupg5Sl56AS/IGyO5OJs4tZQjq+uJx95xjBjrECuAeuJ4w4pOxLjWUY1AxeYh/lQsFQxTCMbHiZeHaSNBZYIg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=aMl9wn13; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=ecpfhQwM; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6060ocUW2107394
	for <linux-pm@vger.kernel.org>; Tue, 6 Jan 2026 01:01:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	qIHZTxnOdazQFGAJQSxqsY8ozTjZjXZSimhBE4+TrtU=; b=aMl9wn13r2pa8iQc
	y5aGy7bCAivl74SpmiNNqY1QPMmnGAr/jIZztOwzuVz2ne1Foxd0c1Vm4a2qlWtN
	VjAtWDfj0yitBmaOwJBEc3u9vDK8uCaKoTCDQ3T+2pUMdzphj2tni+F2xmQf7ycM
	lYCoH76UOSv3y50Ty9kIVEMRcQsv4CiZzbwrQ0q8dZ7mY6ITEmM523AqOoDG8y/J
	6KcUIzgxvpSBdjEvcH/C4kk90HZXjVG8av5Xzla93Oe37X0FH9AFtlyVieXFwBR9
	WJlqmhB7R2/XaoSxeXrj5lsIukCnvEmROEiUmYcx3R1xuJJTIHEk9R+eqEFIdB9y
	NZ1zyQ==
Received: from mail-ua1-f71.google.com (mail-ua1-f71.google.com [209.85.222.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4bgr7380rq-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Tue, 06 Jan 2026 01:01:35 +0000 (GMT)
Received: by mail-ua1-f71.google.com with SMTP id a1e0cc1a2514c-94125ded3dbso1067603241.2
        for <linux-pm@vger.kernel.org>; Mon, 05 Jan 2026 17:01:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1767661295; x=1768266095; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qIHZTxnOdazQFGAJQSxqsY8ozTjZjXZSimhBE4+TrtU=;
        b=ecpfhQwMsAHCA/cCKWnKGJ13hJXul7jJrSD2dSVHe/9RmuvYjBg/wy8jpqCPR2FV0p
         SWfHKYGJVpJnPNoiQg9FmKqFemTpoX+hWnGGP0T5v8JlPfE3/dpg5Z4rkG+hPkjQKsZu
         QT4w/fcXwNAvBhWl+teDL/5Wna/fQmaN+najWCbF0rEH2Fj3CI+lPNJtcaiyN9iAVtah
         LrnyJv4leXhEH4zADye59NwRUpWX+g+QiKj8b5hchumUjX8Asy2nJFm/t5oFxPyubJ09
         u7OHryW3g+KlYy3ilOm76K01wSFMip8xihOY2tCyL9/rDHdaVR2WLRU8f6YIyEmNsYQp
         ZhSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767661295; x=1768266095;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=qIHZTxnOdazQFGAJQSxqsY8ozTjZjXZSimhBE4+TrtU=;
        b=mHqE8pmWXVd1bJoyZAcgFhZZ1JRrfF8SSbVmm+RMqRBa1TsBd0owK5eqkc/Uj38uQL
         cJZMZss8jt63OFtGPMtpYk9Iu4f9UDtx2c7tjFCOA6dyEFvavcXZfQuSRgKHv3ZM4zop
         K73aD7+vlx6G4Eqcw2Zykf1ondpUmwVnW+U0E9hoquYEWWcHOjER3pe9VMoVpuWxEgrx
         qL40YaUmF7E0xYkjf1H61X2C0kWh1RQyJlMF4a4P7WusHT+P40c7k6OY7XID2hRbJlOe
         Ga2qoyuSEsJLjBuOXp8JIDFFCVRwtFuJtwGZt16DSOT9bf7p9xrtSqPUCjRrADM7hn9O
         AOsQ==
X-Forwarded-Encrypted: i=1; AJvYcCXFciMnZzgM1RtPVVU9VZ6VQ1GiCvABpMUObzd8UZRMz/HdDVdWMXs9cePIcJgU+PvgqrKf/K2B4Q==@vger.kernel.org
X-Gm-Message-State: AOJu0YwknDbNoUu9o5P4+Uq2seu5idL9CjVJ7hM1/lcD8WsG5uJbNpP6
	kqck1EjcIxfFQ4zIjMpc50AjMRDddI4lQ+xf+JRhNR88PXxvIQcKcDFNbWpJ0L32al8V/w0+vMl
	BjvDyC/MtDP+uGsITwnBN4Qf3aCyFFdgXb/aR6c9GltZmVs+/XY7sScpMYX9HUg==
X-Gm-Gg: AY/fxX6DhBggra6np9f7XnhbLEFLre/c/TKzLkXT3wy/4zUTeTeB9buu89HPQGqo4sU
	GNmlc84QAqbD887KmSWLdUmq6sCEfbEgcVlryBJstVlohBecpcY5vmrH23rwfjMQ+LuPCdpHZRV
	J+iPK31en0aQdHGzP1K5LxcaeZ03PjDJ38wxWj1zhTK5KVCtmPbuZhxu/KMGrmunvpp/74vGxHG
	ilLIX6oFXn+p+4g6X7BjSvq49XFNEmUq8coRGa74X99zTBMSePhVy/ctce5tTZHR56R+BjHzabg
	QASKXBTLOj0dBmvJ8DV3RFPtQAtnS2rRnlhWNZRtMISM1KSCue4ErEbPjw+iTHIPiYcitvWTwbR
	4d3545h8PD8R5M4b9OHzBvHumMpUtFoHP4ZLwQm9H0w8UoV2S4Q8raY8p+N1zFh5e8uW7c4Rodf
	ZcxquH4Cqb/pYwb33pI5ME34w=
X-Received: by 2002:a05:6102:370e:b0:5db:cc69:7399 with SMTP id ada2fe7eead31-5ec74329c39mr406520137.5.1767661294633;
        Mon, 05 Jan 2026 17:01:34 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGebirOgsDiT7jy5CL+h38CH91id84REIWuMIjih8Il5xh+FCp6mTy2jPQ3VA807d2Ub/nd3w==
X-Received: by 2002:a05:6102:370e:b0:5db:cc69:7399 with SMTP id ada2fe7eead31-5ec74329c39mr406501137.5.1767661294163;
        Mon, 05 Jan 2026 17:01:34 -0800 (PST)
Received: from umbar.lan (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-59b65cea8b1sm181082e87.6.2026.01.05.17.01.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Jan 2026 17:01:32 -0800 (PST)
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Date: Tue, 06 Jan 2026 03:01:17 +0200
Subject: [PATCH v2 07/14] arm64: dts: qcom: sdm845-db845c: drop CS from
 SPIO0
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260106-wcn3990-pwrctl-v2-7-0386204328be@oss.qualcomm.com>
References: <20260106-wcn3990-pwrctl-v2-0-0386204328be@oss.qualcomm.com>
In-Reply-To: <20260106-wcn3990-pwrctl-v2-0-0386204328be@oss.qualcomm.com>
To: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bartosz Golaszewski <brgl@kernel.org>,
        Marcel Holtmann <marcel@holtmann.org>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        Jeff Johnson <jjohnson@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Manivannan Sadhasivam <mani@kernel.org>, Vinod Koul <vkoul@kernel.org>,
        Balakrishna Godavarthi <quic_bgodavar@quicinc.com>,
        Matthias Kaehlcke <mka@chromium.org>
Cc: linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-bluetooth@vger.kernel.org,
        linux-wireless@vger.kernel.org, ath10k@lists.infradead.org,
        linux-pm@vger.kernel.org, Krzysztof Kozlowski <krzk@kernel.org>,
        Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1014;
 i=dmitry.baryshkov@oss.qualcomm.com; h=from:subject:message-id;
 bh=Sxwe6pBBzgKc/Rbx3hGlBLXglP8Dn+Y8xXV50hDaYm4=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBpXF7ZlqUdRROe+lrbb5qeAmQzNxwRhkFbuQafZ
 1LnRVCUW9SJATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCaVxe2QAKCRCLPIo+Aiko
 1VsbCACUB9ZxKyeCESIpnYkNLBvtnArQbybVrFIjFFgB6l3oeJuYSCmeGB8KtWBcWFX2p27bPvy
 l4Aze9U5+0VUf1taw5VP9+CAZWtu0J9j/xyuRRkykC8Cy4zqkDxHYPHOEijFrDMm7mRL+R5SMX0
 EH1oqdcUgqMlq0H99DIFM4hm6AWODt7utQmKjM5NQjq6qy/clKrEbuwMXOFqdJq3gYt1yUbMY+b
 RsiCT96M2hDYAk/EnNDrvSNw+PX1El55uN7ExzhDgQeQ+xxpacGhZkL1YLw54HrtKMAcGhvvDId
 WiS5YD8VbDIFZwP6j7BaWXuWjm97vOokxspiSsDKglf8y87A
X-Developer-Key: i=dmitry.baryshkov@oss.qualcomm.com; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A
X-Authority-Analysis: v=2.4 cv=QrxTHFyd c=1 sm=1 tr=0 ts=695c5eef cx=c_pps
 a=KB4UBwrhAZV1kjiGHFQexw==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=vUbySO9Y5rIA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=EUspDBNiAAAA:8 a=Vj5tKrsnPMLlX677hvEA:9 a=QEXdDO2ut3YA:10
 a=o1xkdb1NAhiiM49bd1HK:22
X-Proofpoint-ORIG-GUID: MxFNdL4CPDL3HEHtG1o9Zqu8XQ70SLb6
X-Proofpoint-GUID: MxFNdL4CPDL3HEHtG1o9Zqu8XQ70SLb6
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTA2MDAwNyBTYWx0ZWRfX2Ec6fbCidRu3
 +EHI85kgzbPoqNB/0d5ARdwpINsZY9rHJyPVAE3Jl3X/LGd7oEo/LYNi/bbYHURCN4ie0gPxd6T
 +1W3DbnLJ8L3EAmxkaJ4+6fuVlZpqlBQZfXr72w9CbDYn+BFy76/6+Bby6XvLFZtoSvY2y69TE4
 znMJoy1l8qBbI+cXIsVkoaCxduLGdhxM7MhAZblKNjvIsUJJSQ1P5ySGjZtijAhCqonom9lCXDS
 RNrOu5cxy/VPomkIlIlrhUhr1sHZa1Zbzlewx65SO0A9H+AsG69gL+pelu7j9KsIhYHccOxu3zA
 MA2eFk5UrQEVXwJn+0utou8LMgRtPJCA6AN09wsddZHNls2AUZgEaRbdnakFtRYFip2BEMscqV4
 VAzBFyckQvGU6LzpEdl/TiXwSDw5e3QkYcxIg/UkjFnBfddyd7vmt7MvmYq5i8bWwM1yRx3K6SJ
 6tAKJEWTGDAHsFvoqKg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-05_02,2026-01-05_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 bulkscore=0 malwarescore=0 suspectscore=0 spamscore=0
 adultscore=0 clxscore=1015 lowpriorityscore=0 priorityscore=1501 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2512120000 definitions=main-2601060007

On SDM845 SPI uses hardware-provided chip select, while specifying
cs-gpio makes the driver request GPIO pin, which on DB845c conflicts
with the normal host controllers pinctrl entry.

Drop the cs-gpios property to restore SPI functionality.

Fixes: cb29e7106d4e ("arm64: dts: qcom: db845c: Add support for MCP2517FD")
Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
---
 arch/arm64/boot/dts/qcom/sdm845-db845c.dts | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/arm64/boot/dts/qcom/sdm845-db845c.dts b/arch/arm64/boot/dts/qcom/sdm845-db845c.dts
index ce23f87e0316..ad283a79bcdb 100644
--- a/arch/arm64/boot/dts/qcom/sdm845-db845c.dts
+++ b/arch/arm64/boot/dts/qcom/sdm845-db845c.dts
@@ -850,7 +850,6 @@ &spi0 {
 	status = "okay";
 	pinctrl-names = "default";
 	pinctrl-0 = <&qup_spi0_default>;
-	cs-gpios = <&tlmm 3 GPIO_ACTIVE_LOW>;
 
 	can@0 {
 		compatible = "microchip,mcp2517fd";

-- 
2.47.3


