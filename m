Return-Path: <linux-pm+bounces-28873-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BF321ADC5B9
	for <lists+linux-pm@lfdr.de>; Tue, 17 Jun 2025 11:07:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B98AA3B2A6D
	for <lists+linux-pm@lfdr.de>; Tue, 17 Jun 2025 09:07:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C384293B72;
	Tue, 17 Jun 2025 09:07:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="V1KirzYT"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2759D290D8E
	for <linux-pm@vger.kernel.org>; Tue, 17 Jun 2025 09:07:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750151234; cv=none; b=DI12g3jRYnbjZ7x3g/Bktp8A2ktwKiHstLIS/L36n17bgTG/b8PqNVRTzR61hzL3DKEVssMEZox60s6C6nChUj+2VT6Q59aUMqHPOs/8vFLyBgy0YEg+xUSK1QO6rjkfFTCrLk4litIqQCaXjVR/aEeXgu7zDzveTLc2rzL+w7g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750151234; c=relaxed/simple;
	bh=Vn5omH7xMvt1iEtCLJWJvK4XrcA+3vcYMlQkxOXLM/Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YyiDE4fgBeI5r8OCdwj+yP14vYc39izyAy3rO4VRDnTTa3wvnU/LDHScyV9mn+CgE9mPRt66Od7GXOiM0t+5OGllRs8rdxaNUArw6zU8EwP0/OHsjWXt4PBjs60YlK+CYoKuiEH1Vs4IGMbVra5Fb4Ze3/kXFPwxOgKhshktdk8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=V1KirzYT; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55H71RhW002991
	for <linux-pm@vger.kernel.org>; Tue, 17 Jun 2025 09:07:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=Qly2EdwvT9V
	KNW+eXeSW4hrs+ShzHfZ0sLmUFke1LiY=; b=V1KirzYTdvewPve4ZhqqrTPVYAh
	mR1kMmckSPeVElmcI24KcJbXd8tH6RKYDWkGlaYzNM9W0LSeqCDEbux+idDTi4z2
	vKTJRXKaiisaRl2n/Dd2A48lUSsengNgNHMm6+9bVpEFPDA0e/UMQ3OZcb7nmBHV
	1klalkHEX14NbZG1X+CI8PibVAdmq8o6IZGwuGMAav0xikj4QZwTl9ZIUIqm5sO5
	24WeqDLkrTYX21MIN6bfbQyon2eXQxU3CYubO2R+QFTq9yueB1IiJfkNmnJuUwEt
	/g+BSkoPsxdaNnIuiaplrwBoxVGDFECNQV2Xi1Lt5RLS+93EXxsElpu+mHg==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 47ag233ryf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Tue, 17 Jun 2025 09:07:11 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-235c897d378so46286275ad.1
        for <linux-pm@vger.kernel.org>; Tue, 17 Jun 2025 02:07:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750151230; x=1750756030;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Qly2EdwvT9VKNW+eXeSW4hrs+ShzHfZ0sLmUFke1LiY=;
        b=wrMigEPitrd0xLH4C6t0vLBPaVEQ8fVC/X8lru3stBnQJVgEZEveRF9yTzeaevg/gc
         SneqNVhfastSOeaI7a/DL6HPxSr3uy93oaTrZCstV+g8MwdFbArYcWPGXZ+8aHOWT9zm
         8VDYZcbbgI7lTWpsxhd2QE6GcDdUbrYLPaklsnO7qRDmMz0X/n+ti+mnL59y7F7bafuv
         mKbtTb6OGENL69vzofg7ASE3CJv8y+FULWC2tB0SLRdwxLxG0m8id5hMc/w4yyS2fW1k
         oSpFzirLL35ZaYl+MYheNX5HY2HNMxn+cZNWhBtgwAf0HZZUgozkPJdJPJGKh30qDUcl
         aZsw==
X-Forwarded-Encrypted: i=1; AJvYcCWZ5okEtn0WT2ggYaLyNeZTGMFOII52AIINPo1fgkb8IKqZgerbcOTkr1Hix0NqLXY56QEWENuzIg==@vger.kernel.org
X-Gm-Message-State: AOJu0Yw5RRkqo0ameicR81AqVw43VelHKnaiHwDuhBWQwBwzXwn9KIUM
	yvkov33Hoj3NdlEMB0iU/tw79u8gpo4I+cb3MsmxNrjYseUA6J/aaLUjd6QVrMMVlXXKp5QRUoA
	tpdbPRZSVUSaEuroun6nWW53oytwA/qAj598ldwOMWFDgRrXIE+RlG50LpZRgQIupypdQrg==
X-Gm-Gg: ASbGnctYxZImHRsXayl6vzOcjnk9yDDghcsonNXePuJ+MqjdhSPAnSLOF9QuH5Am3Kg
	xfWXnnCR6QshsS4PEcL/K9K6BuodBHMgXnFAQHr+FNJw5473mj2683G2JSFCueshTQqDwXtHJdi
	uivid3KxWdLu2wfmF0bJevB5gK3qNwT78mTlSoU1DRe4lEHMak4KSSwRNXp8pQ9oMBVEpZbZjzH
	Jh3BUK+IBAwQM53Fz92Imuztc/pIfYa9fr4r+jcKvEbj6D5Gw1nCCvr2Caj0Oujv6vZjLi+M2pH
	cFtOyRMGOskK4aMxW9GHsMM1tK5qD1c+x+j+RcGI9RAwWrdQgpMk6ELZynPQhQ==
X-Received: by 2002:a17:902:ef45:b0:234:a063:e2b5 with SMTP id d9443c01a7336-2366b1224a8mr179419805ad.30.1750151229662;
        Tue, 17 Jun 2025 02:07:09 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHOtX4HvuLhem2kJyZ83xaYVvt9E2oOIf3GftGjva6d/NVHBthTT2N3GFudpNlTYUanrft4LA==
X-Received: by 2002:a17:902:ef45:b0:234:a063:e2b5 with SMTP id d9443c01a7336-2366b1224a8mr179419395ad.30.1750151229257;
        Tue, 17 Jun 2025 02:07:09 -0700 (PDT)
Received: from cb9a88ed5d41.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-313c1bdb39bsm10017370a91.20.2025.06.17.02.07.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Jun 2025 02:07:09 -0700 (PDT)
From: Raviteja Laggyshetty <raviteja.laggyshetty@oss.qualcomm.com>
To: Georgi Djakov <djakov@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>
Cc: Raviteja Laggyshetty <raviteja.laggyshetty@oss.qualcomm.com>,
        Mike Tiption <mdtipton@quicinc.com>,
        Sibi Sankar <quic_sibis@quicinc.com>, linux-arm-msm@vger.kernel.org,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 1/3] dt-bindings: interconnect: Add EPSS L3 compatible for QCS8300 SoC
Date: Tue, 17 Jun 2025 09:06:49 +0000
Message-ID: <20250617090651.55-2-raviteja.laggyshetty@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250617090651.55-1-raviteja.laggyshetty@oss.qualcomm.com>
References: <20250617090651.55-1-raviteja.laggyshetty@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: WAMrgZR9-zXjq8Fxl_qjr64gmqHqSs6X
X-Authority-Analysis: v=2.4 cv=edY9f6EH c=1 sm=1 tr=0 ts=6851303f cx=c_pps
 a=IZJwPbhc+fLeJZngyXXI0A==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=6IFa9wvqVegA:10 a=EUspDBNiAAAA:8 a=n01AJKLZCHBDCBjb8ZAA:9
 a=uG9DUKGECoFWVXl0Dc02:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjE3MDA3MyBTYWx0ZWRfX9AnjUI/LRF21
 0GbF7pHx25gpGRmltElXQBbQyheest/LTc6yXOhAZFS527tKVwjXwXIyiHSoFjizGD8JvY5rvI3
 5w1H4QPJhy6djN4dWchUgV3+IMXM0cNMjMDivqtMYdgMcDO5rJeVHeKCF+azxCwTy4OEAaFlNvW
 bE5kE4wC3buTnKH/nVltGa8NZ5G8Hdkt2QCjKzMhx1wrDvOKJxvJu/FZHtZOaBjSgXSoRdZiN5C
 ryeuVzsgP0qep+5mvMoyN7Ez1f25AHhKVOUb0YujC5BwuXStjvpjl3rZmI2d+3CfdUoRxGcIVXD
 T4FDOiw+qlPVnG4dvgrFJ+Yc27eSNSBiuArz8lCtrajmwv3vMYc/qOmMhYNCfjGGFGeY216MBtO
 J0FSa3CmOz290zUpzQ+6S537xvAXeXN3uGZRn60B+ng9TINOBHUVSpDf8/5gYppUsCJEL1kX
X-Proofpoint-GUID: WAMrgZR9-zXjq8Fxl_qjr64gmqHqSs6X
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-17_03,2025-06-13_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 priorityscore=1501 suspectscore=0 spamscore=0 bulkscore=0
 impostorscore=0 mlxscore=0 clxscore=1011 mlxlogscore=999 malwarescore=0
 phishscore=0 adultscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2506170073

Add Epoch Subsystem (EPSS) L3 interconnect provider binding for
QCS8300 SoC.

Signed-off-by: Raviteja Laggyshetty <raviteja.laggyshetty@oss.qualcomm.com>
---
 Documentation/devicetree/bindings/interconnect/qcom,osm-l3.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/interconnect/qcom,osm-l3.yaml b/Documentation/devicetree/bindings/interconnect/qcom,osm-l3.yaml
index cd4bb912e0dc..64ad3898abb6 100644
--- a/Documentation/devicetree/bindings/interconnect/qcom,osm-l3.yaml
+++ b/Documentation/devicetree/bindings/interconnect/qcom,osm-l3.yaml
@@ -35,6 +35,7 @@ properties:
               - qcom,sm8250-epss-l3
               - qcom,sm8350-epss-l3
               - qcom,sm8650-epss-l3
+              - qcom,qcs8300-epss-l3
           - const: qcom,epss-l3
 
   reg:
-- 
2.43.0


