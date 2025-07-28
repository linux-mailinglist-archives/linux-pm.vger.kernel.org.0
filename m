Return-Path: <linux-pm+bounces-31479-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 03824B13A5B
	for <lists+linux-pm@lfdr.de>; Mon, 28 Jul 2025 14:18:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 17EE8189CA62
	for <lists+linux-pm@lfdr.de>; Mon, 28 Jul 2025 12:19:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BE05264638;
	Mon, 28 Jul 2025 12:18:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="IulGPGOM"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D0B0263F36
	for <linux-pm@vger.kernel.org>; Mon, 28 Jul 2025 12:18:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753705112; cv=none; b=kZqOf6esCcrVNqUw9R2fBQP1+IGVn7HtsUScygM8pQ5xYuJCN3MYsF5BDXmTvAD2WyIyuXW+dCf+hOn7U6kOSrPaFbujJuSswjl+FW8DU6CdyPvlmhuOzwtvWWBLNyP2XZn2dwkYvvl0CGbbmzMhz1sYXyoE9V/u5gZ8pb57+GE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753705112; c=relaxed/simple;
	bh=ZhwhKLAtYMZqTw9nmo62hQRgpAsB4vx7PKceU/8QYqI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=YoC2bpB1zSsW2YdI4qECoi+BhRkMDDgr790ny4x2G4PtEacM+lKFrIEWbGMHO8H8ceoZNP/t5f4pL9Lg9zyQ30GBntQHosCzy0kXfz/pJZDMu+lXfBf1F5oAFpKmaDX34KM1Ynqr7xcYQHGX1qzcpda08QGllMdjg2oLHXrMr00=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=IulGPGOM; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56SAlQcV012314
	for <linux-pm@vger.kernel.org>; Mon, 28 Jul 2025 12:18:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	73vUzY4qHLFFO0Y15w5GNl6DVd2I2wvbjzyXYScYf4k=; b=IulGPGOMR+2Tnqyh
	KOy+D3In0+96p1D7+y5L1JdbpOboR5IDHeor35TFENcFbuPYHWHz4iAqaFMJ+HLC
	TxIwbe9Xe2RQWmBQszIlJud3HHcz30XRNnQd2uTpYljxsdLlh6PVLnUXrQ51kzok
	7VkAx1Xm04Mw/P+jD5nw2nL4E3v2W4eXj43SmvHjQR6oGuy11lfBxEnLSKs9aIKJ
	6UiezxdbmLHQwJrfyb0noJcaSIbMop1bOLEi+FIqqIXD2LMMRmmfR5wz7+F8wQhp
	0QITn7iyAvBdC1SpNpv6pKV2QMex0j1IbcK0qMBa5ZC2OmvJXi/i6FFuqmGZe3Dl
	LG23Lw==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com [209.85.160.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 484qsk4gec-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Mon, 28 Jul 2025 12:18:29 +0000 (GMT)
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-4ab5e2b96ecso83850781cf.3
        for <linux-pm@vger.kernel.org>; Mon, 28 Jul 2025 05:18:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753705108; x=1754309908;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=73vUzY4qHLFFO0Y15w5GNl6DVd2I2wvbjzyXYScYf4k=;
        b=fdZp/zDWkJG1mpUcCq6peKLOGi1url/Pp5HM3EMfWoT1VyH3SYbgLkWZo6TNBc1ldF
         fchPyoSwZOp3yiA6W87AoaB5TiFerfvJlFT2OCooc7FjzJc0bWPbwbsxG5wglHCrRn76
         WZ9QOI0HPtgkzW1ZSh2ln4E4a7weret4w10XhZamjn3LOX3tCItRjCyZM6t6zyZFnj86
         v4/gm8uIuVJkkrgrKowE9hcNUWoaR/KujpAnEGLhT2Zs9yOg7PVdBYSrA/6h2LJgzhVP
         5FpxmnfGPam3RYjx294YibQKztNskaCGIG7d4JNIrKgFmZDABPJ0Kb2ITML+FF+eFuYr
         3mjA==
X-Forwarded-Encrypted: i=1; AJvYcCW1SfTPvIOVwD6CEyZ0acbFzZwjTF+EOrQhoDdIXbFQa9gdiqMivPKRUjFKCIjuDa2j1kkBBivBsg==@vger.kernel.org
X-Gm-Message-State: AOJu0Yz+crhm1hteKEzBlAO7heztWADudaaJTsXoAdo10ZI6S85NTFs7
	XTt3tp9GzxeJTCD53nWzNr2Rbq8CSs5pvQOho6a+49PUwPzPmYQQ1dY+TEzaAm9R4GoVsjviL7v
	23QWCszXJDhgarIBRr3IQeEjslu0nWQjm9o5OfeYvjOQvx4svbXv2eNi6VdW/SUAPCnT8Wg==
X-Gm-Gg: ASbGnctMVWmyLNGfdcHPM/ohOuslUE0idN3eoWK/C5aQgSv/hpvuui/fKM6VJDcD4hg
	TPgndpKKUKFjXfGw6kuPtsXN3ZRRSVgY9xsQO5HfWdagEXlU+4eMiAYzqOu4MJibcZVUGu1vPuY
	7hTWFHQEOBRJqUbnQjjwku8Nv9c8RSSrLssJOl3ps6LFkB2Q26juaKQ1hEqVlpndwEP6hP3gv4J
	Gv5YB2+onwdMGBBAJoJNEJjs1vF6WqEZu4cBn2SNiI+TMVt2DMz5R4F4wu/UqrpKfiTsPNL/sPY
	Kj+98yAbRHWLdRxK1rr9Fj30XLWhNL6YjPXxtsFQ/6AaYwEqSFh8s76jvO3cJ0ek9xgqQoIPs5K
	qYGX/KAh0a+dxejYCcb28pT90iy1qDnolt4TI6ldV+8vPBmqtOEx/
X-Received: by 2002:a05:6214:460a:b0:707:3829:d491 with SMTP id 6a1803df08f44-7073829d6aamr89286076d6.0.1753705107955;
        Mon, 28 Jul 2025 05:18:27 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGHhEapzZAPzbqM8Bb0XK1MiLkiJuUco8jHXvQ5a/36dp9k3W7CHx8FOFpiIGIfD4IOk3xS6Q==
X-Received: by 2002:a05:6214:460a:b0:707:3829:d491 with SMTP id 6a1803df08f44-7073829d6aamr89285586d6.0.1753705107335;
        Mon, 28 Jul 2025 05:18:27 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-55b633b9d7dsm1241315e87.209.2025.07.28.05.18.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Jul 2025 05:18:26 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Date: Mon, 28 Jul 2025 15:18:23 +0300
Subject: [PATCH v2 1/2] thermal: qcom: make LMH select QCOM_SCM
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250728-lmh-scm-v2-1-33bc58388ca5@oss.qualcomm.com>
References: <20250728-lmh-scm-v2-0-33bc58388ca5@oss.qualcomm.com>
In-Reply-To: <20250728-lmh-scm-v2-0-33bc58388ca5@oss.qualcomm.com>
To: Amit Kucheria <amitk@kernel.org>,
        Thara Gopinath <thara.gopinath@gmail.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Zhang Rui <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>,
        Jackie Liu <liuyun01@kylinos.cn>
Cc: linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1153;
 i=dmitry.baryshkov@oss.qualcomm.com; h=from:subject:message-id;
 bh=ZhwhKLAtYMZqTw9nmo62hQRgpAsB4vx7PKceU/8QYqI=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBoh2qQ58wCL/wOE5Ao7BI61Fvf3f9Tt8RHq2IIO
 u1PLCws0SqJATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCaIdqkAAKCRCLPIo+Aiko
 1UtRB/44Ti8ej97m1vf8x5inMO3n+xf9thaNELG9BP5X8Q2ThCWmSptIRgNKF3ck3X6C8Fcsrlt
 AiEfMP2WEnwPwyBo1ZBibw2FbWbUdXyI10j1G9bbSfeIbwOABfXRF9sBmqN/GaJvY9wYa3ZslVu
 HOHgTgi0CuIrYZ/g1ef1VO0fj6z6B8mwFpiBdUfov5OvpRGe7RGgNmdaTUVUACiu63hMoPv3n1C
 xGrUbux/Ow+IgydJ2AKXi82zXFUbMH4NaS+USSpsXUjBm6DJU/wBdf9+Yg7i2S+Tmu5CCzFjTfT
 VEzMxw+krAio/zFC1YB3L8QgGMgXXyKeB2H1PAM3gNwrTD9H
X-Developer-Key: i=dmitry.baryshkov@oss.qualcomm.com; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A
X-Authority-Analysis: v=2.4 cv=KdDSsRYD c=1 sm=1 tr=0 ts=68876a95 cx=c_pps
 a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=Wb1JkmetP80A:10 a=EUspDBNiAAAA:8 a=_a-utCDu36pnI6q6VeAA:9 a=QEXdDO2ut3YA:10
 a=a_PwQJl-kcHnX1M80qC6:22
X-Proofpoint-GUID: g3wlKB9ywY7xFfxzjrop7_-o4mccuk8I
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzI4MDA5MCBTYWx0ZWRfX3ASJal/p7I+F
 Yw2K+PsGCJHwatHjyAFkPle+2qe7opQW+RGrJ1inUTaX/PfJcMlYP/SD+UIGtmzpNBFLL5cGWUE
 GOpxoVZTMrz881nXnr7we9oHapZRGz2BFcc6QuXbeXVCQZU77QDAqMCIvcecIqHYpH8XhZfwRnH
 2XV+3tQ/U8yTGJLAuA4TXAWhAHD+OGGnu6Wdo7tKkOAMhpa1a2E7OX1sxX14pQxRiUIXkSFAhUh
 3imn+bTofWJNauHM/7ZAKUcJUCtsMmwo+kwyjoXObl12jlm89ADfSys9vzHgEZ04nxiA/iJ9iCu
 VDDGXZgpl6Ngmlz5V3O3lOA8sQNKavXsv6DCmFkzxxV2cqPI8ZXA8hdJPFGNZtdaHPNQ1T+oZCi
 jyjXfGEGNl592Hmw3cyiF/u8BgmyrxwqfYWpS2XkPuC7R82DpH/c350FtQ2pUS5V6Bj1yKrT
X-Proofpoint-ORIG-GUID: g3wlKB9ywY7xFfxzjrop7_-o4mccuk8I
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-28_03,2025-07-28_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 impostorscore=0 mlxscore=0 spamscore=0 bulkscore=0
 adultscore=0 priorityscore=1501 malwarescore=0 mlxlogscore=999
 lowpriorityscore=0 phishscore=0 clxscore=1015 classifier=spam authscore=0
 authtc=n/a authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505280000 definitions=main-2507280090

The QCOM_SCM symbol is not user-visible, so it makes little sense to
depend on it. Make LMH driver select QCOM_SCM as all other drivers do
and, as the dependecy is now correctly handled, enable || COMPILE_TEST
in order to include the driver into broader set of build tests.

Fixes: 9e5a4fb84230 ("thermal/drivers/qcom/lmh: make QCOM_LMH depends on QCOM_SCM")
Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
---
 drivers/thermal/qcom/Kconfig | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/thermal/qcom/Kconfig b/drivers/thermal/qcom/Kconfig
index 2c7f3f9a26ebbba41b89c8aa5d310048e8d6c792..a6bb01082ec6978afb5df32464cf591e4670549e 100644
--- a/drivers/thermal/qcom/Kconfig
+++ b/drivers/thermal/qcom/Kconfig
@@ -34,7 +34,8 @@ config QCOM_SPMI_TEMP_ALARM
 
 config QCOM_LMH
 	tristate "Qualcomm Limits Management Hardware"
-	depends on ARCH_QCOM && QCOM_SCM
+	depends on ARCH_QCOM || COMPILE_TEST
+	select QCOM_SCM
 	help
 	  This enables initialization of Qualcomm limits management
 	  hardware(LMh). LMh allows for hardware-enforced mitigation for cpus based on

-- 
2.39.5


