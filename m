Return-Path: <linux-pm+bounces-35661-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EBF68BB35D5
	for <lists+linux-pm@lfdr.de>; Thu, 02 Oct 2025 10:55:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7E2BE3AD1CE
	for <lists+linux-pm@lfdr.de>; Thu,  2 Oct 2025 08:53:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C4E62FD1C1;
	Thu,  2 Oct 2025 08:53:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="CAP2GieB"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D0202F9DA1
	for <linux-pm@vger.kernel.org>; Thu,  2 Oct 2025 08:53:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759395188; cv=none; b=kyci34xnJU+2yAEXRnNW08sqEDlRaEK/KOFm0W4RawQ//8NaAjU5+LC4fF1fJTGHA7gDql8x9F/dOpfLqRdrvIGlj6xT7/E2F7uHJp6+OTLXAA1ACOOypErhDLLtjXQ6zbBLvDItPd1jKCm1owFiohaiP+y8QcAReUZ9RNvj5+I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759395188; c=relaxed/simple;
	bh=4HhiCdtPcD/lAuJiiWVZDNzGfAoGz/T6J5k93s3E1eQ=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=XrYsu3xC/2efqPv9SS/yAucxLnTaDvCp+Q9VSJR5Iiu0ntopJwtgSoRqNyCuv1C347ao2YFVJxUVtiq6Y61CpP+MjaqjMbGhxk4GuxprHc8SmtJji8VheN/3P4eNjhbTr6Uf1iH5sQkx1ViDriT3YyOmtTNOX72sE01vWKR4cmg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=CAP2GieB; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5925kJbg007885
	for <linux-pm@vger.kernel.org>; Thu, 2 Oct 2025 08:53:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=TASzNO6cx4aY4C3+AUINvs
	P0m6HCBQVPuXIy+ecED+A=; b=CAP2GieB3AbnC5uPndtMr2krZegxzNq1Cuuyld
	ESrqYSY9TzqA+eOR97cRjXAOPiMhcToPndkwzI4ZEXJBkH/5el3QRr/4TvvywYW+
	wuroS8UZNwGzeyVFJHGcnH817CxjrZ5M1X7B0gJBJgsfrzZ4SIEcUvN6lz/ndx91
	hs39Z7DzcYTpVzrhTkoSWTsBgdDMsoRaLljXVmAxIplxnRhgsZzjC3XGeJNNJu/1
	b/vwLYfDzoOIA7sh4Rg2VwaDnRuPEsdq847MSydDnt6Hsb9MzO5KhXuABgSFaPf2
	ln+cfBbBG/57CITqw8+oot7rRYuhwmzB4/W4xd9txNpESsPQ==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com [209.85.160.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49hkhh0e3h-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Thu, 02 Oct 2025 08:53:03 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-4e484dccaafso19171781cf.1
        for <linux-pm@vger.kernel.org>; Thu, 02 Oct 2025 01:53:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759395183; x=1759999983;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TASzNO6cx4aY4C3+AUINvsP0m6HCBQVPuXIy+ecED+A=;
        b=o27jb30SqO+28s3QxJmTEXj4T79W2m3R8gD/28g5ijhK3f+S/I/u+gL7GmxyEFiRtx
         7Ews76Qlswx5NeWusZTrrNg1Eo451nHUtwcMP5MkMVofXr2WzBNAuK0gzwcsBToYnY2h
         Z8N6Wi2QnodQDQIZx+5kNSj4xCtz52ZohF/lnCrvpjT1m2vsXo1B+WNi+fJ9yekkZCgw
         aCK9v4hNGIXKXnBFscyySaHIiYU5Xf3W6RCASx1IWY8AxKlWQ63ZU+uw1jS+qVLQtaNP
         eJGbpGFHFIthVwFxOnmwHBKagQKvcOi4eTeePjCgcLDPhJRTv7jwpZBTkRbGYGoNhniJ
         7jkQ==
X-Forwarded-Encrypted: i=1; AJvYcCWTN+3JBoGx1OhJS+H594Q7X1H1T43BPnrPq8rQPloaxk4k5twiJUim4p7/sYDp7Siy6VkC2A0FBA==@vger.kernel.org
X-Gm-Message-State: AOJu0YzhTfzow3oPhcqo67h6/lF0GR1nCJWXD+WP0dRXD2oEmywzRaHf
	kRjbVK8gmGLIKhFken9zSPYPZA7qZcMYDnzo8RAN/c2ZExBSPmCiOPdRX3AL3629LXI9ihbcpcZ
	11wFiYvm4Ptrf8k5+ldx0cYSmSKLKKHBbtQfdRfSQUA5fvysjU9kqndxy3XWgpw==
X-Gm-Gg: ASbGncuyjL69V41a0AdJNDcCtXEkN7XJpieAJs5nmGPhKZ9faeDxN09ePbnAd8o5AXl
	Sj+lWPhgCg0/aqpdxsaBMqiKEIHu3N8ZGxwb3m2uqJhBMtH04xrlyqiUlZVEH7tYyuo6ZxAKPKr
	Kq69C2PyhOsRDfhyxSfrBtSHzBKevORkoTsR9VJOJ6r/0MC8agKWfGXJt04fj4HBbfYTl25mxK4
	OPz29L7/szY1dPCfla3wiLCitcShb9UYxMRsihM2IyqRl4oSJgwt5CW81R7YupNKjOubRNxZDKD
	Kd9kfDoQJ2YGKgmwS9z9ZVm9NzZfEdenDACTmhRG7eiBAmvjekcj+PxMB/ig6kCqIDHobdobdnd
	ky/pak9Q/eQpAIy4rThyGf3ThHrZCFJkpdeWGhuPkGFjXyupS/DHrgPc11A==
X-Received: by 2002:a05:622a:178f:b0:4b7:acab:852b with SMTP id d75a77b69052e-4e563187a7dmr35617801cf.26.1759395182878;
        Thu, 02 Oct 2025 01:53:02 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHNOAfQi87LSJCR34yVxacyKLw6xvoldf4BlPcvjoOelxPVg87GKyqRVsbOCBcClJYp2rXwDA==
X-Received: by 2002:a05:622a:178f:b0:4b7:acab:852b with SMTP id d75a77b69052e-4e563187a7dmr35617391cf.26.1759395182191;
        Thu, 02 Oct 2025 01:53:02 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-373ba3124bbsm5207351fa.27.2025.10.02.01.53.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Oct 2025 01:53:01 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Subject: [PATCH 0/2] arm64: dts: qcom: msm8996: fix issues with probing of
 USB hosts
Date: Thu, 02 Oct 2025 11:52:59 +0300
Message-Id: <20251002-fix-msm8996-icc-v1-0-a36a05d1f869@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAGs93mgC/x2MQQqAIBAAvyJ7bkGFLPtKdBBdaw9aKEQg/T3pO
 DAzDSoVpgqLaFDo5spn7qAGAf5weSfk0Bm01KOSUmPkB1NNs7UG2Xv0pEI0yoVJaujVVagr/3H
 d3vcDh+1ZgmEAAAA=
X-Change-ID: 20251002-fix-msm8996-icc-ce1df61ad702
To: Georgi Djakov <djakov@kernel.org>,
        Yassine Oudjana <y.oudjana@protonmail.com>,
        Dmitry Baryshkov <lumag@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=826;
 i=dmitry.baryshkov@oss.qualcomm.com; h=from:subject:message-id;
 bh=4HhiCdtPcD/lAuJiiWVZDNzGfAoGz/T6J5k93s3E1eQ=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBo3j1sHDRs9Wa78xf7Zro3JM+9I5+e4+9JwUjFg
 tK/W9+sH9uJATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCaN49bAAKCRCLPIo+Aiko
 1edjB/9w0q5npQeXksi6wlcEjIQu25zJ0+LLfiiJgla4Z49TyAgXj6UVL73votEUyO58Gp0OjcW
 Yx7BQMKPhHZu8RQa8qqDJj/m/VBKkNXIxZ+NalS+lLaHbWqI3JkB5i2OZmOcQfsONl5PIG5dCqY
 tEfzjlzaQzFXPzhdCoYHMOXyHTOd59m+PdWFM8Pp9rC177WfRdh/gu720rIDpvNsE1B2Gd8VzMr
 atxAbUY/CPpN5TdEKYzc+EPyf15f64U9HKif0PDSAXbuGo9lcY366BrFL/vkWU5TU/hrlQs+xLi
 7XHR1tqMIgh1kh3FzyGieYKpxVD8MoeTifEk8Ee/0ZRkD0D2
X-Developer-Key: i=dmitry.baryshkov@oss.qualcomm.com; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A
X-Proofpoint-GUID: JiPWaOIaMlyiHPlYX7oMvFy5zNDzg0Ve
X-Authority-Analysis: v=2.4 cv=cILtc1eN c=1 sm=1 tr=0 ts=68de3d6f cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=x6icFKpwvdMA:10 a=EUspDBNiAAAA:8 a=tC0vjRaNn0V86lLPGsYA:9 a=QEXdDO2ut3YA:10
 a=dawVfQjAaf238kedN5IG:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDAyMDA0NyBTYWx0ZWRfX0cMcoeKSKFJ1
 cK40IbF6tjhvpWSXGyr6Czx1ghUTo4skuapfDbicoTysZto9ryVP1V657YB1SQ2iAAEf+/U/Cpd
 bEp8MzfnENGh9A8QvSy2ZiwgiC9cZN9R4rppVRuGwUMvVkm5Urho+r7CikqIvhQybtP4WrX/dYz
 MEpi6+WbzaZeMiGn9tIzz0nEUOzJrpMmM8niNdQHKqPTIBzLRi/YMZ3OnutkWvMUP2TtXIQUgC3
 28QLr9WhFQ6uChIhMfTh4FRE01pDQNPvdDYtmFoQ53hLjH31lq219YTK6XdLQZ5zxoeuvRA2GdI
 axpN+yjW4fjGDnKC+iGqYV6yvxO1HH0E/ZxRr8LCZ7XVgWg480qW5oYk3Bz68mt0bW2r/M5j6aQ
 qJpHh4pbc5XSghUvY5Z+wFsd/gSbeA==
X-Proofpoint-ORIG-GUID: JiPWaOIaMlyiHPlYX7oMvFy5zNDzg0Ve
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-02_03,2025-10-02_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 phishscore=0 lowpriorityscore=0 priorityscore=1501
 impostorscore=0 bulkscore=0 clxscore=1015 malwarescore=0 adultscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2509150000
 definitions=main-2510020047

The lack of the interconnects for the USB2 host might result in the
register writes for the PHY not reaching the PHY and thus the PLL not
locking up, resulting in -EBUSY errors for the USB host on the platform.
Add missing interconnect link and add interconnect paths to the USB2
device.

Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
---
Dmitry Baryshkov (2):
      interconnect: qcom: msm8996: add missing link to SLAVE_USB_HS
      arm64: dts: qcom: msm8996: add interconnect paths to USB2 controller

 arch/arm64/boot/dts/qcom/msm8996.dtsi | 3 +++
 drivers/interconnect/qcom/msm8996.c   | 1 +
 2 files changed, 4 insertions(+)
---
base-commit: bf2602a3cb2381fb1a04bf1c39a290518d2538d1
change-id: 20251002-fix-msm8996-icc-ce1df61ad702

Best regards,
-- 
With best wishes
Dmitry


