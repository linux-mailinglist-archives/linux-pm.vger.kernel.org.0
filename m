Return-Path: <linux-pm+bounces-40239-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id E0373CF6371
	for <lists+linux-pm@lfdr.de>; Tue, 06 Jan 2026 02:12:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 74BA7309D9CD
	for <lists+linux-pm@lfdr.de>; Tue,  6 Jan 2026 01:11:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48A212848BB;
	Tue,  6 Jan 2026 01:01:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="jQmbv7Hm";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="VtcZOgMY"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 454E4287247
	for <linux-pm@vger.kernel.org>; Tue,  6 Jan 2026 01:01:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767661287; cv=none; b=UapMtjRyLlnSEw5sqW060n6bOm/NP7ZDRfYumhpSPp5TdN1+vtauBtHcxT/2NcOQ1usjXc3bOEtQSmkaXE6DXsUyVjQCFQku0rOSJajpMotD8nh9WYT8QVcxW0EfOMGAUkMc5hR8uQu6U/yDAUfmG449RECe2sQIfgUcHuKzPHk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767661287; c=relaxed/simple;
	bh=8ro0A6tVVAR8N1a3EJt6gZeL+nfKC2FamuLo+mTTcgM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=WbveLBISaNPoak8BviJzurV2Ajjtqz5iuFCLjjWS7cnaztsrCBNXV9Dq01PtCSP1JHCXItVABaiONS9fP4wrLtLRZkQkB5/0/JXZeUTFLL937I4WZ0u9d5kwHFcIGtmJR2gxN50xCyuqUAmzaHFH8HetlEtxL+AF2To4jt7Azrw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=jQmbv7Hm; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=VtcZOgMY; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6060nNdK202716
	for <linux-pm@vger.kernel.org>; Tue, 6 Jan 2026 01:01:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	SuVJjvlCTXRFYAFx0rLVTZXUOY4TgeWGafNaZ/GaNBM=; b=jQmbv7Hm6oM7Fh9T
	PsbD2BMkMvJs2UioXCo1W5VCFS3fhze52LW/etURrC386p5MtNw824OiW05k2eSF
	js5GvLofGI5vymuNSG5h8FU/VaeReoAAzJuzty5IG7MPEIZVDVyOvGhsChH6429a
	tcnA7x5TBFdUPdMDRDS1jguEFYsVnFlL4P529MEF07oazVQSz88Hvb7QwrdcXYD7
	cG3qnoxsQOg335m8ujGk6KDzsqfjYsFf8FQNcqx1sf4Gg/9bbwylSPq0ZbB0WHMq
	gnRwQJ/GMNjBeQomqRmoqmXfpGcaYTnnUy4LCjK4g43G+mYuKOiJ2MbH9P8hrlSp
	twXDLw==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com [209.85.160.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4bggqu19e2-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Tue, 06 Jan 2026 01:01:24 +0000 (GMT)
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-4edad69b4e8so10184771cf.1
        for <linux-pm@vger.kernel.org>; Mon, 05 Jan 2026 17:01:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1767661283; x=1768266083; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SuVJjvlCTXRFYAFx0rLVTZXUOY4TgeWGafNaZ/GaNBM=;
        b=VtcZOgMYJexBwgPuQm5ab85OwzbavcQYaYgHl/xgZ8nCHwyO/nIPlFAQrl1NucM6Wx
         qOC2aCVSQVTySmVKQMk3jAhURiO7RV+oJwgs+dHLauZyh0S4K7v3e5chki+sgi4fLUSm
         Pmdc4dP2pE6gE5/iRkXkBeMlLgWNkYqs0bIPkzl0dHkzzIu/NNoy0vQao4JZMdGnFamk
         BYB5KTp0ZhkdbZeNAcT4X3E2ePt3eekK5NDKNl57uzZsqd9P76/PatisN30T892xxlXv
         vd2JM410Hr5kVTwpTH4w3B+CTyFta+mS4eHj+T1CeWtnNEa9nQTCMN/T/kE6I0r3XMpH
         KMqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767661283; x=1768266083;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=SuVJjvlCTXRFYAFx0rLVTZXUOY4TgeWGafNaZ/GaNBM=;
        b=FTKV4anqlmuOfgwQUU53pCM07yEKwMoR+2AQ14WuoOdVHvMVNz5A2X8K7FYr8ccym5
         ktOMLAToFjbNV3ZZNon4zEpaie78w1ibS0qznsxh4oIOYceApO/Aac8OkVvp2KUYSoJd
         zGnhwYV+IREhi1+HbYOO/g+J5+MNI4MiUrmE7sMwegk9+ayEOWaeP1HO5fv0Nm3AAAv7
         oBhykb1nhl3/20gZJOsKMLpTCrKfqWinzR+hjNLWgD8ClXWRju7N9024wOV8BZQBa5Sm
         iCqe1Z6U6ts+sxcjKFVXOWD/iQcJzLy/oRr3qRBZhXgM0tvP0Kqj9yRTH3QNdXETYN0P
         iWvA==
X-Forwarded-Encrypted: i=1; AJvYcCWoabBNhGqRl+o5uPFfxZQV3xTRsYVem/7JaFf8mZVpKQTkwXfReI2lFPxM8xzJCChGYQFMHChHLg==@vger.kernel.org
X-Gm-Message-State: AOJu0YyoktE6OqQJD88Y6TPAm6kR6y/0BufZYlWLc4Xw5rPOlTCpM3tu
	NQ0v7hLzrpr7YhXMC4UOaXQtSfLT+3Isfu6BrolzDYLmVPcjwdgN+nJV5oaQXmVbrfUo8c7+yzT
	s2v6dS6t9ye5DnwdB8Fqn2/NkTNmgUuJJ2m3cRbmdA8f57e3pkiNeIftb/rzcmg==
X-Gm-Gg: AY/fxX6ZHn/3uKJCJ2Fq2LTF3CoMTfsCbFNixTD2uWYfWAm5lg82sA9MfjZ23MnHUO0
	ho9fsNtp/ltO986i93Y4aJMMhsXaoZEPf8QDLbKUgtljH5U/2Z6Y8VGJQEn+8kboNUT64aulv1k
	JkivCSaHDcJquv0nHhigGDiqsTRKbxXE4VtuPl5QYCKESV961N4ssX6C/Cw0PWr2yIT+7eYGkE/
	nbpaEvrqsq0TZPgLQYRKLWRQDG12xFNvKARu7aYhSiJ6WjCqST2CDIfcZ8gr47VG+lB5UovGQkr
	CzAlzrDPcip9+7JhtWznjFIkJDhnAWwz7ylqowztqxG2UJgWGRK5TuROEapxrxoZhJnii5oTkEQ
	Gt3sEUoN0KMMEecUbFkr51+Uhh03QvLDcXiDsZw8ui96e2uvBO+DjrLOowYr6XSmFYueWd+Tlka
	J5VIlpFDRfFtuq5xG6mW1q3yM=
X-Received: by 2002:a05:622a:14d4:b0:4ed:7fe3:7be7 with SMTP id d75a77b69052e-4ffa84d5bd0mr14665211cf.24.1767661283393;
        Mon, 05 Jan 2026 17:01:23 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHrZ1tIZiQ6ycHzI3EiYuZDUWEqWF7mMpIemTNtxXuHPb4jtHfXaJhVQFBU4f2EXJPRI/6qNg==
X-Received: by 2002:a05:622a:14d4:b0:4ed:7fe3:7be7 with SMTP id d75a77b69052e-4ffa84d5bd0mr14664681cf.24.1767661282972;
        Mon, 05 Jan 2026 17:01:22 -0800 (PST)
Received: from umbar.lan (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-59b65cea8b1sm181082e87.6.2026.01.05.17.01.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Jan 2026 17:01:21 -0800 (PST)
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Date: Tue, 06 Jan 2026 03:01:12 +0200
Subject: [PATCH v2 02/14] Bluetooth: qca: enable pwrseq support for WCN39xx
 devices
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260106-wcn3990-pwrctl-v2-2-0386204328be@oss.qualcomm.com>
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
        Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=2075;
 i=dmitry.baryshkov@oss.qualcomm.com; h=from:subject:message-id;
 bh=8ro0A6tVVAR8N1a3EJt6gZeL+nfKC2FamuLo+mTTcgM=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBpXF7YIE+RgnOdF6j0+1WDplDzh9OEu7rZOc19L
 X/4QNNE9O6JATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCaVxe2AAKCRCLPIo+Aiko
 1YXkCACC7NBtif8a2rH1Vkwu+aCXo1j7E9efr80epimwSe9+/TpA38HWBS8S9p5hLjd+LkneptH
 dTD1KFpwF9FhUb66xrLzboGL/Qu+AkHxaw2OEUxdQuBpW8dOcszVT43KfRGk4u7I10YMxMEb403
 0SXACEFtKg4FZafeHufsYLCBlPE5GpXBbwR2YLACyCFrt4lSmtlwTWmoC9IcVExx2vLzEYzSWO3
 G9HZIcJEbbfAf8bPovnN256QMeNiLd4sW5DgaoRtsbWHEKHLC8mowRF2iTN6mlHP7Ua/Zeh3GKT
 eMKVCkcXPzZXfPFenhs63JikBAY3tfp3eyMLslp+14pWjp0H
X-Developer-Key: i=dmitry.baryshkov@oss.qualcomm.com; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTA2MDAwNyBTYWx0ZWRfX97uvpVWNwo7n
 3Eb0N5DZSSAibdpa2AYJ7MbIcpCH1uDVFU7BpW9yKqZUfQC+voKKO5UY+Ll1P/tZjUpfuz6Jup0
 WkaudS9xK9VM7byYNmvTOIA6QLsbHpACHFzvsC6nlU0a8iZkc7KgjPVCoZWW4d4+4FMtSaT3Dag
 PMRmKmTn7d4f3BC0MnWa6/QntjnmEJ0SXwklBa8uQByysh/bq+cfuo+XRx/X3tQJSUQ+sz3mtg0
 e10UEBZsN0AyLuzXIcz93PuXMDY0eE/M/WxsIJ0f6TaZ4hYlMs/rwtANRzh90zsPvY5nLj7UrbB
 ZlbdOfo86+lfUvMnmDVJbPamT21zjAt7nsZ2yG+DxvVqOczLQFiJGCOBxujeCBAeGkFI4mzfJ8Q
 GkzKXaqBVn6JqzL0kkrv3cRuaC0SVhrqATNZ1ZbaxdF7/eIGtqT1ocdNDuGw3TvYpw8YLaVM/VH
 xD34usjOiZVUD/TSCpg==
X-Proofpoint-ORIG-GUID: zpOKChxMBQG6rM_At1KNUuZfwK7pJo1s
X-Authority-Analysis: v=2.4 cv=fr/RpV4f c=1 sm=1 tr=0 ts=695c5ee4 cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=vUbySO9Y5rIA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=EUspDBNiAAAA:8 a=WNkeAZsnUospxCs8hJ4A:9 a=QEXdDO2ut3YA:10
 a=uxP6HrT_eTzRwkO_Te1X:22
X-Proofpoint-GUID: zpOKChxMBQG6rM_At1KNUuZfwK7pJo1s
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-05_02,2026-01-05_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 suspectscore=0 adultscore=0 spamscore=0 priorityscore=1501
 impostorscore=0 bulkscore=0 clxscore=1015 phishscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2512120000 definitions=main-2601060007

The WCN39xx family of WiFi/BT chips incorporates a simple PMU, spreading
voltages over internal rails. Implement support for using powersequencer
for this family of QCA devices in addition to using regulators.

Reviewed-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
---
 drivers/bluetooth/hci_qca.c | 26 ++++++++++++++++++--------
 1 file changed, 18 insertions(+), 8 deletions(-)

diff --git a/drivers/bluetooth/hci_qca.c b/drivers/bluetooth/hci_qca.c
index b54350317a43..d1402a344063 100644
--- a/drivers/bluetooth/hci_qca.c
+++ b/drivers/bluetooth/hci_qca.c
@@ -2230,6 +2230,18 @@ static void qca_power_shutdown(struct hci_uart *hu)
 	qcadev = serdev_device_get_drvdata(hu->serdev);
 	power = qcadev->bt_power;
 
+	switch (soc_type) {
+	case QCA_WCN3988:
+	case QCA_WCN3990:
+	case QCA_WCN3991:
+	case QCA_WCN3998:
+		host_set_baudrate(hu, 2400);
+		qca_send_power_pulse(hu, false);
+		break;
+	default:
+		break;
+	}
+
 	if (power && power->pwrseq) {
 		pwrseq_power_off(power->pwrseq);
 		set_bit(QCA_BT_OFF, &qca->flags);
@@ -2241,8 +2253,6 @@ static void qca_power_shutdown(struct hci_uart *hu)
 	case QCA_WCN3990:
 	case QCA_WCN3991:
 	case QCA_WCN3998:
-		host_set_baudrate(hu, 2400);
-		qca_send_power_pulse(hu, false);
 		qca_regulator_disable(qcadev);
 		break;
 
@@ -2414,6 +2424,11 @@ static int qca_serdev_probe(struct serdev_device *serdev)
 	}
 
 	switch (qcadev->btsoc_type) {
+	case QCA_WCN3950:
+	case QCA_WCN3988:
+	case QCA_WCN3990:
+	case QCA_WCN3991:
+	case QCA_WCN3998:
 	case QCA_WCN6855:
 	case QCA_WCN7850:
 	case QCA_WCN6750:
@@ -2438,12 +2453,7 @@ static int qca_serdev_probe(struct serdev_device *serdev)
 			else
 				break;
 		}
-		fallthrough;
-	case QCA_WCN3950:
-	case QCA_WCN3988:
-	case QCA_WCN3990:
-	case QCA_WCN3991:
-	case QCA_WCN3998:
+
 		qcadev->bt_power->dev = &serdev->dev;
 		err = qca_init_regulators(qcadev->bt_power, data->vregs,
 					  data->num_vregs);

-- 
2.47.3


