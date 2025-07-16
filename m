Return-Path: <linux-pm+bounces-30927-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D9720B079CF
	for <lists+linux-pm@lfdr.de>; Wed, 16 Jul 2025 17:28:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3760E17A35B
	for <lists+linux-pm@lfdr.de>; Wed, 16 Jul 2025 15:28:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FF352F2C69;
	Wed, 16 Jul 2025 15:28:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Vtbc4OJ3"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BAD126D4D8
	for <linux-pm@vger.kernel.org>; Wed, 16 Jul 2025 15:28:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752679698; cv=none; b=WsXgTI8UkXeXvzcEmlFaeKFkia6IVCLIg2uhllDrtQ1QtudJhVnTuX5muO7+xz1k7FJE6ZFwWY+zuOIJ0Yo6E8pP05sicZpKIfygqXh2ylvhvnR94dkM1g/dWT2k02Gm1tqjXUfiFUHiUDhxUytPVEZ+QjyeA7v51nsP2KEJo9c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752679698; c=relaxed/simple;
	bh=awJhqK9vZx7HfSJmr9fd7vWzKJvnlam9KSwzA05jp7c=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=F+wMKWgdxT7Vl98TZKKe33BZ9dXAWTzzOkbbTlIGizxiJku8ds7faQCS083NFSs8NSahqF7WO7TdLXR7W/sGg8VJsPfXtYX1HrLrx+4qd+UPVOVdBx1BtKCCIuYt0RKxSpT0KTmnluqNjqAWVilbUquSBTy85LcBXQ6U498z9ug=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Vtbc4OJ3; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56GCs3Ug025762
	for <linux-pm@vger.kernel.org>; Wed, 16 Jul 2025 15:28:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=eId7Thpi9XZ
	dt0UdhQINAu7XwHMfKszVh+XHIOlEnig=; b=Vtbc4OJ3gC+WqXbqSbAz5OFi+Re
	932uuNUJV4X43NhFdYr0TIfI9s6nX/IRCHIxUooAqPSWHeAzPZlozHzPVosugvw/
	UDyr7afk4IWMlinxR/OGcNCDePpoH8PtiOsGe6JzIOC2cAaV287DUDcWQahHVYaD
	ddO2QO5ajKhv1gq2xL1xpoX6W1l6hZC4RPOV3VRht2wl8DlDm5+yu2ubYx9RMmxR
	nmuJ01RhahDKys4N/8sMlYzYvssR21hmWZWUxTjtpVo+3JWjCic8L/5WdImaCyy2
	OeS1lEBZ9TNuX4AmXnfIE3rquFLVicDbYe6UHjViPtfIk9fN1mlLMhe0Q0A==
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com [209.85.216.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 47wqsy4bnw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Wed, 16 Jul 2025 15:28:16 +0000 (GMT)
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-31218e2d5b0so41987a91.2
        for <linux-pm@vger.kernel.org>; Wed, 16 Jul 2025 08:28:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752679696; x=1753284496;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eId7Thpi9XZdt0UdhQINAu7XwHMfKszVh+XHIOlEnig=;
        b=npAZFSwCIVLQW0fzQD9Bkx3/i77kPrGBmk8TOMt+I825UiHHRh/8uTSLlSaridvHMF
         I/NPcHsTWQY4btIUnRkg7/GnuMJYVu4TYTvf4k3QhMlNp+jMkzzPYWcQflNSuovbV6gK
         Sx0CwZl3ZFY3Fh03qErsSIpakPeIYz3Jg8JKzUNp0SRfzQI5KGFor5FwoSojLbRImq1i
         HQ/IfdwwgttAflLwJncnAZHndeoIXqx8qH7fvTlKOcrSpyhTnlR3kwWFPInf+bkY0jM9
         CWvI6KPF0Zki7WQO/04TJ5Mh9rJogtWZQCJTOXx0oTbdMhdcfr6kdYK+FAzvb/jPLq0r
         umPA==
X-Gm-Message-State: AOJu0YyTUoyy5k4O0KOk8Y6ltWuMmHs8O7ugNTqlaQND8K4Nidm5Xi31
	x5tptUgPQ5jeumzuwBsyBetoPzEw2HQPazPfv0A+w93qGlXsYt3OH/il/Z1wS/z9odn/61VqQ1Y
	EYGBwtRl1qZTUstqIM71rEEVaWsEkszZEJiCQa30mDrDsH+/IeM3ftl8dcmftgA==
X-Gm-Gg: ASbGncsseYU5GNWFTLS8cBFeXw/7ZKuU/6ljUaLUGQiso6Gb6WnifW7Dqd7D5TtxEN8
	iOhzkhJV1dd6Ywv+SzpJJbXlsaoL1rSSXuSzqc6kDKGr+UWXTmFxzTb/ROTVJpmtImi4iUa2Juy
	Jb2acGaQPiQKOvMXis+5l+O/1NzG8NrPLSnSmg2/yce0PwmcwIsT+SJNtl4DelFsWaY+LcfE/qr
	3fjWpF/x83SpLlNnQIySYo0gY89WBcGnemG5vU0jS/PnPGD3MYBEX1rKIiERmO34cCTg2csqsG+
	8Fcf2WWbs1oRDkJVdpWzfgM7j8ykp+SwD9jBE/VeFzw4HKbTXY05OJ/d0ya+JkizHPKDKcm/zev
	cFRbZnCrM74fzwSmFjmGvg5okv8gz6PQmmI4YZ9kebXNSKtbnw3ZOPv+FfBus
X-Received: by 2002:a17:90b:3511:b0:312:ea46:3e66 with SMTP id 98e67ed59e1d1-31c9f45e1c5mr3880521a91.21.1752679695700;
        Wed, 16 Jul 2025 08:28:15 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGtxskSX4ykowgYW6uvYkR4w5BMuKXIb3nL0la8MIwNTod9JbY4bqqI87oJ/MQXKSnNbpjtsQ==
X-Received: by 2002:a17:90b:3511:b0:312:ea46:3e66 with SMTP id 98e67ed59e1d1-31c9f45e1c5mr3880481a91.21.1752679695170;
        Wed, 16 Jul 2025 08:28:15 -0700 (PDT)
Received: from hu-pankpati-blr.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-31c9f20e87bsm1688563a91.35.2025.07.16.08.28.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Jul 2025 08:28:14 -0700 (PDT)
From: Pankaj Patil <pankaj.patil@oss.qualcomm.com>
To: robh@kernel.org, lumag@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
        ulf.hansson@linaro.org, konrad.dybcio@oss.qualcomm.com,
        quic_tingguoc@quicinc.com, quic_rjendra@quicinc.com,
        kamal.wadhwa@oss.qualcomm.com
Cc: linux-pm@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] dt-bindings: power: rpmpd: Add Glymur power domains
Date: Wed, 16 Jul 2025 20:57:57 +0530
Message-Id: <20250716152758.4079467-2-pankaj.patil@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250716152758.4079467-1-pankaj.patil@oss.qualcomm.com>
References: <20250716152758.4079467-1-pankaj.patil@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzE2MDEzOSBTYWx0ZWRfXxzSbmFWo4bTx
 js9Q9ZQaFsujnyp5LESgG1XV4IBJlHaymvXNSDWm/6XiMIPKQFDXtnseXGpF8hctHtxr4fOwLf+
 PhmSZrDV7CmSbDeVos8ZQGDU2aSCiFhez1rtacgSpXJMQIRkNPQUmrwFSCOikAJQOOrJXllerfG
 GDR1vkrQrHRLjAlzd4iru/7h8oTE/GNp5lRfCot0GvV5zGm2sVjPMbeyufi6zMHfCx/C00qT4MK
 gxKsrISJmrhuPRPOUZ2rQkRXPabW44HVd96GZ6wXgsrFpyaswv6OMVYYm3rL6JatKSmn868FCDa
 1FWz0FxEeXHbMEj1ISKtpwECKbTpjRKYS4cNRV0GGnb+FW9+Q1760GOEfxo689Nw1wwXZZGB9Su
 9W6LWJf8o5y1BRpJbEFj/YMKrbeYocJ39fai/W9mZ8kOszXryclZ6esnbPOJ7duQ4QXE4W1V
X-Proofpoint-GUID: _ToNbxkxWlpj1d_qPWYzEj83jmmtCL4f
X-Proofpoint-ORIG-GUID: _ToNbxkxWlpj1d_qPWYzEj83jmmtCL4f
X-Authority-Analysis: v=2.4 cv=McZsu4/f c=1 sm=1 tr=0 ts=6877c510 cx=c_pps
 a=0uOsjrqzRL749jD1oC5vDA==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=Wb1JkmetP80A:10 a=EUspDBNiAAAA:8 a=mKLVYdK_SoQD2tn2_ugA:9
 a=mQ_c8vxmzFEMiUWkPHU9:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-16_02,2025-07-16_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 mlxlogscore=999 impostorscore=0 mlxscore=0 phishscore=0
 adultscore=0 lowpriorityscore=0 bulkscore=0 clxscore=1015 suspectscore=0
 spamscore=0 priorityscore=1501 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2507160139

From: Kamal Wadhwa <kamal.wadhwa@oss.qualcomm.com>

Add the compatibles for the rpmpd power domains on glymur
boards

Signed-off-by: Kamal Wadhwa <kamal.wadhwa@oss.qualcomm.com>
Signed-off-by: Pankaj Patil <pankaj.patil@oss.qualcomm.com>
---
 Documentation/devicetree/bindings/power/qcom,rpmpd.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/power/qcom,rpmpd.yaml b/Documentation/devicetree/bindings/power/qcom,rpmpd.yaml
index 7d4394a3ccbc..af5fef872529 100644
--- a/Documentation/devicetree/bindings/power/qcom,rpmpd.yaml
+++ b/Documentation/devicetree/bindings/power/qcom,rpmpd.yaml
@@ -17,6 +17,7 @@ properties:
   compatible:
     oneOf:
       - enum:
+          - qcom,glymur-rpmhpd
           - qcom,mdm9607-rpmpd
           - qcom,milos-rpmhpd
           - qcom,msm8226-rpmpd
-- 
2.34.1


