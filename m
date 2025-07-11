Return-Path: <linux-pm+bounces-30674-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 115C9B019B4
	for <lists+linux-pm@lfdr.de>; Fri, 11 Jul 2025 12:26:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DF7F01CA6283
	for <lists+linux-pm@lfdr.de>; Fri, 11 Jul 2025 10:26:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A67C28506D;
	Fri, 11 Jul 2025 10:26:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="lyit5L4a"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D354E28136E
	for <linux-pm@vger.kernel.org>; Fri, 11 Jul 2025 10:25:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752229560; cv=none; b=Zphb9g3dlbHG0CgjiQyPzCCWy30XNUvUWfJ1Rp6r0bOeSJOOYk7PBr+kZyciobBvlgR/IAbV7iL9ck3UqN5z4FTrVNsK9bJmuBGEHE4b6+cGgq+Ev7nCmHMG582G1+gaJOCVi4kjlJg2RSGrLJAxQKfIWEpQVlKBwweftrBXhzI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752229560; c=relaxed/simple;
	bh=M4/1zW6eg8rGjRFEXSCi8ldnIpnhgwBY1LCfEz3wlLI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dSJjvKkuE8rJO6CZtwnoHnUtT1YVyufneP9fzjvygND1PqjdznWJS4fZFN9waX9UDe0fng37hxhKAZyR4QkW6MN2iUg0guQpIjY3UwBHLin40x44gXqpojU5gh4jaML51XWFEmA90Duz/euoiaoh/OrQs0o4mssnVBtH8VNihVk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=lyit5L4a; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56B1X7Xa018332
	for <linux-pm@vger.kernel.org>; Fri, 11 Jul 2025 10:25:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=LAo7+LmXMWY
	aVSvdOinK2bRx0fazfdgWlxITs8x41dc=; b=lyit5L4acT0WO65hknn5N/a971Y
	qpWZIO/kuc7aXXR6pc16iKf0xh4MaXjPwzNUt5nBwBvws/7euVKyhGLHCKF7Bsiv
	FZyL5WTWH/T609HaC/YVhGpP7HXa82JCEnznezLpm9wx4FLS6egcZYE+KVV56h7+
	FSEg7PCI0PFlUyQaCRCCB20vtc/A5OKmEaUw3Vvutemh3BKS5Sv7F9g58mOA2Co7
	YIZfNR2Z3Qb3dvZIMBkSkf2Q2ijswZmU+7IJ6tlQW0I6wy5NnxhjwKp9NO/VUz7g
	TVeDE6yKClCIQSj6TwdDiog98NUGYYPZK9DoL5+v4qDFmnxy+DJBkoSYr3A==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 47tkf324uw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Fri, 11 Jul 2025 10:25:57 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-2369dd58602so19609225ad.1
        for <linux-pm@vger.kernel.org>; Fri, 11 Jul 2025 03:25:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752229557; x=1752834357;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LAo7+LmXMWYaVSvdOinK2bRx0fazfdgWlxITs8x41dc=;
        b=u5mgDsAj3MI8zQcGM/I3w0SIgzIXKU0aurjoofYet9Tfc6G+dv8hgMQYeOg0+DstFh
         xtY3P1D/rYMn8IW6lesDKbknHEo9F7sZSilUugchToGtlIoq2M6paKx66815JmyNQ+5u
         YpiYUswxpBz/hC4nHFuF/+AnsNe0TFq7SK/UPdUMvZ5+Vpo3Ye23V0u+YN0uTV0fx7Vp
         bwQMvWwQUofZw2PAiwSnOizcjDDwHhXIZYEiM9poTIW9fFWG7Z1tvvGuTkORfKcASFqD
         c2ceRu/Ggpt5Y5W5ilZX61jOCj/anx+b7RQAy6WGyyL7b77HtyF3MdFFxE5aHsq4COxE
         HhfA==
X-Forwarded-Encrypted: i=1; AJvYcCUjOOCucl0LvApBa5PPQE8yayOkAezcnwJg+gWwgi4xiHxMVFn78BjnYQmJjxUP54H5qG+1tOkL4Q==@vger.kernel.org
X-Gm-Message-State: AOJu0YywUMmRhVOKrxXBqD2nN19KDE9vuN0EPltK1/ilTLKElTHR0gla
	BuiJhHdDxLTZ8GT2w51yRaZu5bckB8Jyr0gYKoBHJy2aNAOYJOpyV5AwVpC8CqmDnH1o8BhdBbE
	VwxTlWAvrIAmIp2oaTG1d4C234He/CW7Q2HfLTDss4N6rsX+UXk7Kbv+nItkxwQ==
X-Gm-Gg: ASbGncsGc0Si9YUDa/caEMbMPbADJq/Q+L4CMcj6jvnuJ8MMkB8mZ5/QkcrO0M4A46b
	hc4K9eSFqxPhtM6d96tAnOm3HOoRdONvAGHNLP28PbyJt/V3NM0uXHeqZiv2Ff5rAHld+TP1Cl2
	st2ZG88yLLzF+2r6SYv5E9S1cFbiojAOgTNoEy0VLWxQQSvAOLh+uIYXWJ/9G5SSC1WPXc6GWX9
	dBk3Mw780tcgIgiJu0/szUuRQDQSO1y+3X8DfRkrEiokmJRZKnXEF7qDvzz77NLIdCCXrbcIQkv
	w2jfO7UGM7H0ZgZs8vc8fy1naXklyn0XQAHV+c2uaeXtqDMO08sHRYtBJiieYnoGhZgqcXu4EGD
	o9jo=
X-Received: by 2002:a17:903:40d1:b0:235:f45f:ed41 with SMTP id d9443c01a7336-23dee1ae472mr35780025ad.19.1752229556280;
        Fri, 11 Jul 2025 03:25:56 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGQv80PZJx79PU5ryxk66WdVg6dRamBPztALKkT8zsOOgqaEemmBQGVGuRSz3CrDGmB5zKI4A==
X-Received: by 2002:a17:903:40d1:b0:235:f45f:ed41 with SMTP id d9443c01a7336-23dee1ae472mr35779595ad.19.1752229555819;
        Fri, 11 Jul 2025 03:25:55 -0700 (PDT)
Received: from a10065738a1d.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23de436839bsm42861375ad.253.2025.07.11.03.25.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Jul 2025 03:25:55 -0700 (PDT)
From: Raviteja Laggyshetty <raviteja.laggyshetty@oss.qualcomm.com>
To: Georgi Djakov <djakov@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Sibi Sankar <quic_sibis@quicinc.com>,
        Odelu Kukatla <quic_okukatla@quicinc.com>,
        Mike Tipton <mdtipton@quicinc.com>
Cc: linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Raviteja Laggyshetty <raviteja.laggyshetty@oss.qualcomm.com>
Subject: [PATCH V2 1/3] dt-bindings: interconnect: Add EPSS L3 compatible for QCS8300 SoC
Date: Fri, 11 Jul 2025 10:25:38 +0000
Message-ID: <20250711102540.143-2-raviteja.laggyshetty@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250711102540.143-1-raviteja.laggyshetty@oss.qualcomm.com>
References: <20250711102540.143-1-raviteja.laggyshetty@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzExMDA3MyBTYWx0ZWRfX6NIULYCpYTlD
 jpIoZrl4GZeVyLggkz37YORDoBDiyQAaPmAFAxbqDwg5ZPEW6d/Ij4uDZB9Oyj9OMJxv6oxAkh+
 QDjsRk4Li/3rVziywAcNMLJ36aAWodOjSoqpHuEnxPo+jOYV3rhE+tyfI8S6HiKNeujtYa9YKfD
 gLh88F5bqJhpw3glJ56dCwefrxEz6Oi5WHvDxxPgQXouF4R+Xyii0b+cpAQR3pxbVnLOXj6ZJFA
 3fE8vSSNDMoZoQbNKuHOGVGFSiCocWv6wt6ZtI83TIRLvA5X8KUfyjs8EfqLZaPFpViBQB5GrZL
 MUqE8f4wLrAZQPSnSaUQsv/ifG3qAWeAJgY6qDy/EttFHixqcsAP/4K1ukG+JFETWAOyFDywjaZ
 n3FY2FbXeMCnaGEpOV3VSs34ngCtTJg/+0qbfNDCdZbEzP7CUE8VX27esMJuHKr1ahak+OJq
X-Proofpoint-GUID: gUKIlZdyh9fc1M2FYOLGJ320B_tP475a
X-Authority-Analysis: v=2.4 cv=Xuf6OUF9 c=1 sm=1 tr=0 ts=6870e6b5 cx=c_pps
 a=IZJwPbhc+fLeJZngyXXI0A==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=Wb1JkmetP80A:10 a=EUspDBNiAAAA:8 a=tdxlyS0QQrc70uz5QrwA:9
 a=uG9DUKGECoFWVXl0Dc02:22
X-Proofpoint-ORIG-GUID: gUKIlZdyh9fc1M2FYOLGJ320B_tP475a
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-11_03,2025-07-09_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 bulkscore=0 spamscore=0 lowpriorityscore=0 impostorscore=0
 clxscore=1015 priorityscore=1501 malwarescore=0 adultscore=0 mlxscore=0
 phishscore=0 mlxlogscore=999 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2507110073

Add Epoch Subsystem (EPSS) L3 interconnect provider binding for
QCS8300 SoC. As the EPSS hardware in QCS8300 and SA8775P are same,
added a family-level compatible for SA877P SoC. This shared fallback
compatible allows grouping of SoCs with similar hardware, reducing
the need to explicitly list each variant in the driver match table.

Signed-off-by: Raviteja Laggyshetty <raviteja.laggyshetty@oss.qualcomm.com>
---
 .../devicetree/bindings/interconnect/qcom,osm-l3.yaml        | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/Documentation/devicetree/bindings/interconnect/qcom,osm-l3.yaml b/Documentation/devicetree/bindings/interconnect/qcom,osm-l3.yaml
index cd4bb912e0dc..ab5a921c3495 100644
--- a/Documentation/devicetree/bindings/interconnect/qcom,osm-l3.yaml
+++ b/Documentation/devicetree/bindings/interconnect/qcom,osm-l3.yaml
@@ -36,6 +36,11 @@ properties:
               - qcom,sm8350-epss-l3
               - qcom,sm8650-epss-l3
           - const: qcom,epss-l3
+      - items:
+          - enum:
+              - qcom,qcs8300-epss-l3
+          - const: qcom,sa8775p-epss-l3
+          - const: qcom,epss-l3
 
   reg:
     maxItems: 1
-- 
2.43.0


