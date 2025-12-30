Return-Path: <linux-pm+bounces-40061-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 17CA7CEADF5
	for <lists+linux-pm@lfdr.de>; Wed, 31 Dec 2025 00:36:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 166953016EE6
	for <lists+linux-pm@lfdr.de>; Tue, 30 Dec 2025 23:36:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBE242E8B8D;
	Tue, 30 Dec 2025 23:36:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Yv+o7+Lz";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="QLS+XWtI"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9C4F21A447
	for <linux-pm@vger.kernel.org>; Tue, 30 Dec 2025 23:36:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767137774; cv=none; b=DRJwAJV4rVHVPavKoEoHnneGj8Hq9OnYWTjX3znRlWUcl42raOA8fNSHdcxkUWctSKnG82ohM+1Fse9Z2BBRpvkeoIBRNeIhZ7if+gpenL+yWYlbdZZyM+w5QR5Eh0exr/lVjA7/uvcua6/vU74th55Y1q/l9GUCNdI9yPH8whc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767137774; c=relaxed/simple;
	bh=dsdXZ95EeYH9C3J7omxSTW2//MbnLXvg26+sdstW5a8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=RplJaI+GQGQ+doECDoYK7N1ROFa5ZaiGUGEkDqNIorn2/KgSyZKPdLISmCy5r7HS1Pncfsq1IA9ujD8MGMz9L6kFVHj/0EsAu+35ShP0Yseq+rl9ByrnZxNDa2rDOaor0qSCAsW0Kdm3vki8BmykPqQw/rbdq4f4dJOLvjXI8hU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Yv+o7+Lz; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=QLS+XWtI; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5BUK9vZH2284812
	for <linux-pm@vger.kernel.org>; Tue, 30 Dec 2025 23:36:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	GaHFmXFU2LgOEbPPkpReuSY4xCJ4+sCSY2NisbXzuSg=; b=Yv+o7+LzjZXcCX2b
	7JPyh9dZxYnPFPvoaXJK+MZLcII6w+nYNiZlcGovs9KUL0M8ZAZQW+bKoRxT5K7c
	4VyrMpDe2wrLxh7H6zVdTw23s5WWApL1T7WfQyUl1+WpGYZeMtoBFLPfh5rweUXv
	XKiMK3lCGnzN/qZSN+3vePKariXpGxjeIMaS7tt7COionftMy9+7mhzjPxMVYBMY
	KpZgSA+zu7cfJ/eIxEwYMwO/FSxXleDRFmAD6gjGdZkxUudT8CBl4KeblAzHC/un
	iVOGmwPvW+yRLgYJwQaQV/69BxbPPEdOQdzBtNnx1IGNgu17Bgi3KIVoB/FKafN5
	6ysvvQ==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com [209.85.160.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4bc06gu68e-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Tue, 30 Dec 2025 23:36:12 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-4ee0995fa85so309168701cf.1
        for <linux-pm@vger.kernel.org>; Tue, 30 Dec 2025 15:36:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1767137771; x=1767742571; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GaHFmXFU2LgOEbPPkpReuSY4xCJ4+sCSY2NisbXzuSg=;
        b=QLS+XWtI/yYjhrIh6oIwkDKaGJygVqowTgMJARyEQ6xj+IMmwJWJIjxGhZc0WaTAkN
         9rdqqkBIEPnUNWB6JiiA2VsBiJRiIA2B9e+R8rkRoEmkQdDqdABANI9x4TRHfn+mW7qW
         d8PsyWmvlg2p9Y4d8GizNV1R+N5jxOkFHP4aenXAijIYmQEs/6wJ5/FFwavfAXBf0sha
         vzlzeGbmixXGTLpRmbhwB8ZCrBgqt9RQU+lJLVKvKdaT4ugwq01kCFSNkjdbS2aGN7Uu
         dWVwONsQ083uCNKrb8/8O0bF735YAxy/Gn2H/0Y0KHhPSk2DoiOGs9fMcz1X5mXxngVy
         C+LQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767137771; x=1767742571;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=GaHFmXFU2LgOEbPPkpReuSY4xCJ4+sCSY2NisbXzuSg=;
        b=koZHCRZ0T/69U8HXSW8I8yH0bk5eNlpGXmOIR56d9EcGDtWqKmErt9m00yWm97iL73
         c4A1PO3Vuf6+7dIIPVLzqz++8lwpGbDbT4V4Pf1IT3C69WLSD6+zTrWhFTJFznzegBo7
         jErqkQpZV/cKqTu+xGGQPbO+xS90CZ9EBi7Gv2kBQpfJNTSX8LINlXDigcra2ISNsfaX
         Kw+8Hns8BlFvUpgGyV7TneD518ZItYtl5G4zVfWa8P1NbkDmSJjLHdEoNLAQWxWl4VJG
         Dl4cyJXeg6RiDcLfWQkoSpxCrjzIVwEtlEhWsxgRE8loRWMljxAVJ9YPnBLy9Bs511eB
         2/bg==
X-Forwarded-Encrypted: i=1; AJvYcCV/vn43p+aDWo1asQl2mUxC7a/GqjIJk4aGN64mG0zsFJQoFFywbYeJt2vCgfst97bnUoPxAjaKbA==@vger.kernel.org
X-Gm-Message-State: AOJu0YyFuL2zH2CDL6uud20tLevApT3IozDE5jutwRFj6psrDsCgCrHb
	U8uqoaugu/gjGxw1ODvhf2sRjFjjjhxfWXY33ptGJBFBxa1rVqPaSgJidN01QsIotSxOEOa5vxf
	S719ro47ugofZlhPMtkDSjPzapk12XAz5bYQAHEtuDzvDHHoJmJbhtWsB3kXXIQ==
X-Gm-Gg: AY/fxX6WHsGUwBDGzkIBVoLFwKGKRfM4BqolEzjDuI13akz2xb1Dca2twzDLjQsSKoZ
	/9k7x9Ux/vBL1K5h9MaHH7WXy94D+jmkhdr9l5NLlZ2PMVjLK6AxKw3+9mOhcF5LPBD9A53Mdgs
	VuNnXexsjBjd776YsUkHaY5HShgPx9jdMtWG/EFw5kdIDNTHMShFHVGWnBjjRL4S4cFE62202hV
	OEivNCRlBWpeZXZNEU4v/fz2wtJOuPQPBsoiDJlOYZ9GIIcg65dyi/yd6PwJRzNIMNDiUcD1Hq1
	HyHm+5k75A5IJ221BdyYpwFj4kz6Y6785PE1Kf8rOPgbhebfnHa6VbhynGnyivbM66itnxHR+Ko
	BJZ9drWCqbMKZlFXHhN+PrdrvJcu81kXZFktfB7XWLAOi+5QhfDlsATzFrmiO96Q1qEZQTNsU2b
	jYXNkjhlk1yUqkY7pOXdsc+T8=
X-Received: by 2002:a05:622a:28f:b0:4ee:1563:2829 with SMTP id d75a77b69052e-4f4abdaad3cmr497925351cf.72.1767137771253;
        Tue, 30 Dec 2025 15:36:11 -0800 (PST)
X-Google-Smtp-Source: AGHT+IF7BCqXmSeXpjNJMgSVwWhyvWdlkv5tk6ilmCUcGI8RE1/asO6kLVQNDkJuRevRigqYoaXlzw==
X-Received: by 2002:a05:622a:28f:b0:4ee:1563:2829 with SMTP id d75a77b69052e-4f4abdaad3cmr497925031cf.72.1767137770776;
        Tue, 30 Dec 2025 15:36:10 -0800 (PST)
Received: from umbar.lan (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-59a18620337sm10349574e87.86.2025.12.30.15.36.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Dec 2025 15:36:10 -0800 (PST)
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Date: Wed, 31 Dec 2025 01:35:53 +0200
Subject: [PATCH 03/14] Bluetooth: qca: fix ROM version reading on WCN3998
 chips
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251231-wcn3990-pwrctl-v1-3-1ff4d6028ad5@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1411;
 i=dmitry.baryshkov@oss.qualcomm.com; h=from:subject:message-id;
 bh=dsdXZ95EeYH9C3J7omxSTW2//MbnLXvg26+sdstW5a8=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBpVGHks3ladrkLXuAKtpF6vTDXvxft+w/1qQfxX
 qPTZ4Pi+fqJATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCaVRh5AAKCRCLPIo+Aiko
 1X1XB/9RVAlu0fS0XyVVNsfzMyzV7ZUtWWfh4tVhINiynx0u4UygowO8h7lO24yuVEKKVUSTBHJ
 b8NAbdOwfEjJFZXEWol5x8ywChGdEwbxHR8bd44LeF80FJA8rlZlbgp/bs2mKAvCreZsyofEnZf
 +OOl+6Cu5kLFc6XDte7pn1yPsPv0OOMiZgodEdd5Q9eXgVpyzbaX625o4PSLYrcfAuxIPOE7oyc
 3wZydLNC3ueDiOeKRhr2+Rc4tPFuwf7vP2z/THMgsn315cBcWgPx9uHF6jFM3elHZxpD1j6gBTr
 Pm6F4L60wOXU6YCQkgQY2jTpWojPNK1V4OsD9CXb3lP/spvn
X-Developer-Key: i=dmitry.baryshkov@oss.qualcomm.com; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A
X-Proofpoint-ORIG-GUID: dgGuceXiS2AZ95V_BuivTTvUj37mbI-8
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjMwMDIxMSBTYWx0ZWRfXy5zxfkcB1BZ8
 zh5Tzge4FHWr8SektBjmNN3OCC06yp3f8x3iJaYD9sRU7IJUZYOSlEuqNm579EMgeHBmtdk/Kl8
 gFMg8eC12GFdsV+BoWvD2PbLWupoH7WkJJYh9uTGifProte6+9cyojgAQQUUbMOh5t56rUJE8/F
 Lhd3NfhKPbjEu50/Zz8K2mCHsG/IxSZHDW8n9GFJlJKoQ/wasFL2fkOZa8JngScwYbNDsqePDDk
 tj21uhU+NTjQjO+ZOxnFprb7n77MmfC8x5zF6lxnJs05QZJozbQNHv4w4EDMIygDInfPcPsHcBu
 xsk+eIVg+e1wEFjpjIdSuawHgXYEAxJxtli35ehLU/K1VhffpPXeiX02pF2eVynVTY6o/+ZRpbm
 M1PI4xHLpVViMmC0bb4oo8FR0esJ0b36U2M2WvPugYgHXNG/PDW5Jn5DKn8wibQtknCl15Azlv1
 5MEOi7rB3tJJT3q6T7w==
X-Authority-Analysis: v=2.4 cv=A45h/qWG c=1 sm=1 tr=0 ts=695461ec cx=c_pps
 a=WeENfcodrlLV9YRTxbY/uA==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=wP3pNCr1ah4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=EUspDBNiAAAA:8 a=TaVSYX7Pq2PjI-6xwy8A:9 a=QEXdDO2ut3YA:10
 a=kacYvNCVWA4VmyqE58fU:22
X-Proofpoint-GUID: dgGuceXiS2AZ95V_BuivTTvUj37mbI-8
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-30_04,2025-12-30_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 priorityscore=1501 clxscore=1015 suspectscore=0
 bulkscore=0 phishscore=0 impostorscore=0 spamscore=0 malwarescore=0
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2512120000
 definitions=main-2512300211

WCN3998 uses a bit different format for rom version:

[    5.479978] Bluetooth: hci0: setting up wcn399x
[    5.633763] Bluetooth: hci0: QCA Product ID   :0x0000000a
[    5.645350] Bluetooth: hci0: QCA SOC Version  :0x40010224
[    5.650906] Bluetooth: hci0: QCA ROM Version  :0x00001001
[    5.665173] Bluetooth: hci0: QCA Patch Version:0x00006699
[    5.679356] Bluetooth: hci0: QCA controller version 0x02241001
[    5.691109] Bluetooth: hci0: QCA Downloading qca/crbtfw21.tlv
[    6.680102] Bluetooth: hci0: QCA Downloading qca/crnv21.bin
[    6.842948] Bluetooth: hci0: QCA setup on UART is completed

Fixes: 523760b7ff88 ("Bluetooth: hci_qca: Added support for WCN3998")
Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
---
 drivers/bluetooth/btqca.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/bluetooth/btqca.c b/drivers/bluetooth/btqca.c
index 7c958d6065be..86a48d009d1b 100644
--- a/drivers/bluetooth/btqca.c
+++ b/drivers/bluetooth/btqca.c
@@ -804,6 +804,8 @@ int qca_uart_setup(struct hci_dev *hdev, uint8_t baudrate,
 	 */
 	if (soc_type == QCA_WCN3988)
 		rom_ver = ((soc_ver & 0x00000f00) >> 0x05) | (soc_ver & 0x0000000f);
+	else if (soc_type == QCA_WCN3998)
+		rom_ver = ((soc_ver & 0x0000f000) >> 0x07) | (soc_ver & 0x0000000f);
 	else
 		rom_ver = ((soc_ver & 0x00000f00) >> 0x04) | (soc_ver & 0x0000000f);
 

-- 
2.47.3


