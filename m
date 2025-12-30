Return-Path: <linux-pm+bounces-40068-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BE05CEAE13
	for <lists+linux-pm@lfdr.de>; Wed, 31 Dec 2025 00:36:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 4A2BC301F3F6
	for <lists+linux-pm@lfdr.de>; Tue, 30 Dec 2025 23:36:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22F4D2E5D32;
	Tue, 30 Dec 2025 23:36:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="hGIXLqce";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="dG3brML9"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45A7F2FD68D
	for <linux-pm@vger.kernel.org>; Tue, 30 Dec 2025 23:36:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767137783; cv=none; b=qe92exTHdkCl91F2Th43ecKiurUzkRQSNMd7QObdPa5fJtOsXcgzJFe0DRJZJBuI/iCJ5C/haxrvdXLJMwyDONjkSWZZP4qZa3B8w8XbhhdveTxzk5AOpOKIJA+enl99buEytiSQZlELk8ORw2Oyk3ghZttCEDZS6lxGbeVWaHw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767137783; c=relaxed/simple;
	bh=Pz4bYuDWOk27q8/d1KeCQS7z4vWcU9y3prNSQvbuMuE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=k5Ra8OHwhmtsvQgU1lBxpvxePkp3mmDQeyGUdlXpLZtHtBJ3OQVgX7QT8WlUKyZt0j1B106+1p6Vu0WvhdCfMVtJmXK6tq+Jg++mxkJv3gfMNxDEK5UeceHFU5ie4PCknrbttchPmeOPA7A6mNBMUC/C52GB7Ttk6Q7SPAJt+XE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=hGIXLqce; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=dG3brML9; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5BUDF2Cb2546976
	for <linux-pm@vger.kernel.org>; Tue, 30 Dec 2025 23:36:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	N+FVwNRLikQP8LSojRQtHGdUV511zX9zkUOVCzM0yiQ=; b=hGIXLqcexQ1Pj2UR
	Bkjfa/MMgfSquAig0IZEtKMMN97R8FB+VMXuAes8LaJToSI2uqfbcBaUsXfVY8a7
	movLC0e4Gh755YBmiIynBdBmrdWkGvYCrg2+3acmNu2ihATJNZ20eCIVVTz3wQ+/
	rgPxlg7voc5hQunfKHr9g+SBwUcBK2MxI+E3DIYNx91EpmQJUGYyWkn1SNzmj1/c
	ntfVIEa5tJHMbqpJJrHEQCyJWiFLzOtJnNIVAFSogUZQVa1/8dNzEItstQ/nQrcI
	RwI6Mu1Fsyin7Z+0s0eO8bu5JpDDOYyTJNK3RydUMG6IgFMdrVXN/ibwWz4RrOWy
	59UCUg==
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com [209.85.219.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4bc739acx4-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Tue, 30 Dec 2025 23:36:19 +0000 (GMT)
Received: by mail-qv1-f70.google.com with SMTP id 6a1803df08f44-88883a2cabbso381240396d6.0
        for <linux-pm@vger.kernel.org>; Tue, 30 Dec 2025 15:36:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1767137778; x=1767742578; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=N+FVwNRLikQP8LSojRQtHGdUV511zX9zkUOVCzM0yiQ=;
        b=dG3brML9y/nDhUukny8LhHqTvni5WHam1JgC8xl6rWvT40GOoeLBuFiqn2Iv3i29qN
         aH6mvNHiXUZTKqYI0jFG7IUjpp06edMazNJQoCC7NyD+3tdeCOjcYoFTIHhTnxKC8mvf
         2RzOItBkkrsFE6hgVnN484tmDnzjvhhx7sht2Oy/132HNfgFA2UAZ3tVzaWOcZv0taAv
         MWwGsw5vo5qvl9Zz1lKG9UCqrC4hjB0TpdeegZeSKkNDKW4G6lZ/GYz/iB+JKsWW41Tc
         nF6MnGBghGNnNmy+A4OqFjQ2KrKuBwYej4jVHpBL5r2nGC7wwmKgmIoZW28YMfrf/6WL
         3riw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767137778; x=1767742578;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=N+FVwNRLikQP8LSojRQtHGdUV511zX9zkUOVCzM0yiQ=;
        b=ggXozO5LLE4fmtShmhALEJDKWF3WWS1SRuEh39x6PlVVKvAPe0UN8/i+aUvVwAyonE
         HETboRMMzbEXyQQq5uptWXNdf9yUrCCWkbKx0oRjcO0zoYat3KeqIpAPXSdXQObhosuB
         OonHfc5z1cHz+rouYauzLkccVSJdCo44weCgTQVM5vdcqWU9kiC64lilKo2c7ewEm1/d
         5fxTHxK59l2DcKMi4igWJHoMf7Uo32ONGK08Y4vd03ETouf9TdIEdYV8Qm2lOhnKBjMn
         VZT8cSyY1VnxcOfYznNzMp1AT2YUcxhgIANTgOqMZCpZ15b7lRXY7EE+/IdNY+G12ALO
         8qxw==
X-Forwarded-Encrypted: i=1; AJvYcCWZeKUd5UpOAK3nNvUoM9YWmWeKn/9NryIWsPaeW2mSTajGd/5sUeIsRwGe3PvZZgqk+S+baAs/aA==@vger.kernel.org
X-Gm-Message-State: AOJu0Yz45TW42G01qB6ATjOe71PdijOctZ5UbdOzObleAYBzNgcqHMmt
	n6aylBHEPDU8OG4eIxO4TFNY+dz4nPAD8p6kykNJZGw9Lb2gFjNxEUYSfXfgS0vTRRi6Dbn1G6f
	pflBwK9dUZxxXy7ZHV+84fR8ZCO18UH+3URu0uzt//+hKd2fQrnXqo2FwDWr06g==
X-Gm-Gg: AY/fxX7J9fAD+SvTTQYowE3YzjYKqHi/klNEM8FfMtqK7ln18LB1SZEF22Uup+GTlso
	Qen6c2ju0FCnPTm2DFf2AlRYlgDqRc9YYox8WO4vG6EJi4OTbN+4wDiH52+6I10XdIv+hj2RuQq
	KG3/0pi7zXwkfQ5rm79TGhxJhgw6u747Mu6XQJCsHARVoWHOxS9UTCZaWRStGCDQ3KdCnjZC7AO
	A7drQx3Fk9OaXozFjYTr4pPLrHXkgTzY79vWqbJ/ovCE3fqI+w25h2GRf1XnIRhYb3Qj1IuiiHr
	TJ/TTvab2Vb4OqbVgpu+i+Oy2/rs5ESMvtKG8CLy1xik3g54EWzZq9gpEEpK6XkuehTfXPHC/nW
	BkR1fnIrlCDWAPrGvOhDyIXLxaQXgeWR8Kw0iDoqPrNEZN1EYyZ0CtZ3cLrwMRaM5m8T0CNO48I
	Wo2rug7GfkL1hfFA+jLo1g5ao=
X-Received: by 2002:a05:622a:2b46:b0:4d0:ac40:fab8 with SMTP id d75a77b69052e-4f4abcb609amr511678141cf.7.1767137778404;
        Tue, 30 Dec 2025 15:36:18 -0800 (PST)
X-Google-Smtp-Source: AGHT+IH59lx+ZCDpow83PB4eH/5T/X29RNR0aVJbnqhYno60nbct3hC5Y5OsKlGMVfNCgjJmFDZvoQ==
X-Received: by 2002:a05:622a:2b46:b0:4d0:ac40:fab8 with SMTP id d75a77b69052e-4f4abcb609amr511677921cf.7.1767137778035;
        Tue, 30 Dec 2025 15:36:18 -0800 (PST)
Received: from umbar.lan (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-59a18620337sm10349574e87.86.2025.12.30.15.36.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Dec 2025 15:36:17 -0800 (PST)
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Date: Wed, 31 Dec 2025 01:35:59 +0200
Subject: [PATCH 09/14] arm64: dts: qcom: sm8150: add uart13
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251231-wcn3990-pwrctl-v1-9-1ff4d6028ad5@oss.qualcomm.com>
References: <20251231-wcn3990-pwrctl-v1-0-1ff4d6028ad5@oss.qualcomm.com>
In-Reply-To: <20251231-wcn3990-pwrctl-v1-0-1ff4d6028ad5@oss.qualcomm.com>
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
        linux-pm@vger.kernel.org, Krzysztof Kozlowski <krzk@kernel.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=910;
 i=dmitry.baryshkov@oss.qualcomm.com; h=from:subject:message-id;
 bh=Pz4bYuDWOk27q8/d1KeCQS7z4vWcU9y3prNSQvbuMuE=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBpVGHluW6qebycSnrD5SNFOD5335n2RZeHUhSEk
 te7vraHp9eJATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCaVRh5QAKCRCLPIo+Aiko
 1XA+B/9Ku9Oec16ayWeVxl+sQOev59kRkI4jvd53Bo4+j993wCSjdYNaBIcMOjHpBtdsyi/DDeh
 FCqhwnxfxwR/cTOJeCd3hsWAoEPp4WsLb4HwvE5IIHlu4zQhsE7Q6D2qfsiqMUE7Fn52T4GEAwT
 5cCemYj0GzUO0yeFyn7bnsYk0FsfenLfPLViJXvkAT6CoqZCRM6Zd70UDRgNzeDLnlsyGYEIJ0M
 ZkLNxrAqNvJQiA6/WsXXq6tIRKw2+yRXdZ6k60oc7W7vAQU2lpYSfCGPED8gbKF6EsSAajYTlW4
 VMy3sEhDdO9MoAeR+LxRsuVtx3ficRB/NdBrAh7X+qu98d3V
X-Developer-Key: i=dmitry.baryshkov@oss.qualcomm.com; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A
X-Proofpoint-GUID: Mjrx5obXBd-kikUVgQvDknJEAJdXHl3i
X-Authority-Analysis: v=2.4 cv=HrV72kTS c=1 sm=1 tr=0 ts=695461f3 cx=c_pps
 a=oc9J++0uMp73DTRD5QyR2A==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=wP3pNCr1ah4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=EUspDBNiAAAA:8 a=3uNi7MZmT9RZencDy0AA:9 a=QEXdDO2ut3YA:10
 a=iYH6xdkBrDN1Jqds4HTS:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjMwMDIxMSBTYWx0ZWRfX+08hdJJKLUa6
 TbWlHXYwxDeakiu9c5QOoFrXSFgj5jbTuMpNJ+gazbBvuxbhII8lf3d+rWoS/Rp9IhHucrJo2xU
 odJBOD5ONDzKFiVlJ0l11Ywb/QzPUp94c6qDko0dmDko/V4QY1FYQxg79qGWinr8lS33twdrBde
 gupo6rcDrc/ILJXU3CtZZ0AJ7YPQpIkZiPmYsvzBGF+XUjvoVmYG647EIJ3SQ1SKnoiZmlvDxmN
 0FoOnbtfrr/pwcn2zPigHJMI8sgSrMx80EXd6dS2qp3NwrROyUQSrieNCY3jsehiXnDag8LJ9BO
 DnFAtZXDidgIz5Npii0qBoluDD8rs2RlXyFJe8eVGLMKd00oi/gI9ElABl0f/6XgpHjcwps+xU/
 Zkjcxu6ZPvh1jkFf0xVlYb6QQ0T4oRw++FN/dl/+sFrnurOO1OMu3J1EfJzRF+QrfNZPZbbpw10
 A0ocWkmSV7qYDpoSf4A==
X-Proofpoint-ORIG-GUID: Mjrx5obXBd-kikUVgQvDknJEAJdXHl3i
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-30_04,2025-12-30_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 phishscore=0 adultscore=0 suspectscore=0 clxscore=1015
 lowpriorityscore=0 malwarescore=0 priorityscore=1501 bulkscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2512120000 definitions=main-2512300211

Add UART13, typically used for Bluetooth connection on SM8150.

Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
---
 arch/arm64/boot/dts/qcom/sm8150.dtsi | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sm8150.dtsi b/arch/arm64/boot/dts/qcom/sm8150.dtsi
index e3ec99972a28..24c1691642c8 100644
--- a/arch/arm64/boot/dts/qcom/sm8150.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm8150.dtsi
@@ -1693,6 +1693,15 @@ spi13: spi@c8c000 {
 				status = "disabled";
 			};
 
+			uart13: serial@c8c000 {
+				compatible = "qcom,geni-uart";
+				reg = <0 0x00c8c000 0 0x4000>;
+				clocks = <&gcc GCC_QUPV3_WRAP2_S3_CLK>;
+				clock-names = "se";
+				interrupts = <GIC_SPI 585 IRQ_TYPE_LEVEL_HIGH>;
+				status = "disabled";
+			};
+
 			i2c14: i2c@c90000 {
 				compatible = "qcom,geni-i2c";
 				reg = <0 0x00c90000 0 0x4000>;

-- 
2.47.3


