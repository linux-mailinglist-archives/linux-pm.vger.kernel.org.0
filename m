Return-Path: <linux-pm+bounces-38457-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 7ED36C80240
	for <lists+linux-pm@lfdr.de>; Mon, 24 Nov 2025 12:13:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 8EC764E4575
	for <lists+linux-pm@lfdr.de>; Mon, 24 Nov 2025 11:12:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3883B2FD684;
	Mon, 24 Nov 2025 11:12:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="QnLufYJa";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="FJhkUro/"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 902B42FCBE3
	for <linux-pm@vger.kernel.org>; Mon, 24 Nov 2025 11:12:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763982773; cv=none; b=kncv0dRaFW6oBnvI0Q4GiNwKYvOxIHGuPXX/PToF9YBYnVBR7CIiYv3o+vqW3hUpfnFMkorpbuBGz0NVsF4ojV5fbkXQ0nFZj+FnK5QOPvRnX0lTtBNERtG8QH+b2YXe12rIxe+doK9YvGiy6bKEeg5vzQj+mCvzzBOEaDJi7T4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763982773; c=relaxed/simple;
	bh=gvw6vJt65/j3kDflSAmg5Ggctp4w5GkDPc1mSBR1PtM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=DjwE6xmg8NHWBdDAHuQPTdhx0SxL+J3OnVhGQaSBNIMUN1pUAeuTBuOImxz1yjmxTqiagdwhcaLi7xOireC765tme6nQ3kvGpXesT1a47vbPm1EXLVoZ43UA76boJdw67yISg8ADERaetXCBcPfT1Vq7XIYBvkawYe/4qtY5ej0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=QnLufYJa; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=FJhkUro/; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5AO7xQfE2117551
	for <linux-pm@vger.kernel.org>; Mon, 24 Nov 2025 11:12:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	FzYWAX8ciiG0wHhKqetFvk7149rfeYeDrlq54Hply/U=; b=QnLufYJaK2Yb6+ze
	G8sFDYfQbWBClxrc6SBIq61/y3rqdgxorSQtUOapl6AAivBxQDwTQjfQMyP466EO
	5AnSZTM+T85Gphv9sw7KaLP2odjTYdrQarEfRDPGGa35yIT7uMSZ2jmIbQlidU3J
	GeGFDns/SnfB8b2mlyj1RTqnQnFLl6YTuVIpPxA3rCnN4/9lQiImWQpGU1b/0IE1
	1n6jHTFuEc7hELIQjjJ70O6MyQtQaJVfUa7/gZvOsDFqc40txLha8bEhLr90QJZ3
	14H1QK0qLBuZMJ6EN/HsyCDM+zxzuM9d3tx5Dd7ncf+YnI4uoZX8+/+KeoF0QtFK
	6RfxVg==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ak694vrbe-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Mon, 24 Nov 2025 11:12:51 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-2982dec5ccbso94368235ad.3
        for <linux-pm@vger.kernel.org>; Mon, 24 Nov 2025 03:12:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1763982770; x=1764587570; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FzYWAX8ciiG0wHhKqetFvk7149rfeYeDrlq54Hply/U=;
        b=FJhkUro/mCaPRwdCpoWJZ54TYCP1iVsR4UAUlO0tPK79TN8wVrAuvW0oWGW5nsZG19
         fR7iZZYwEHEON+Drh/9Iao93BTceY5sDcQ/s7Jui819TxHLXAvFOv8EcJRSnkDXbl0co
         wZuC11VzC/t4Cm2GxHgJVfG3pD13uU2ApdrWABWrVMPw4KUDUkuAdhEtrxZZ3pPEqvG2
         JAlpaqjH8fAgWQiHJY7QYGqAG1W0ONPSBInvkuhQAJ/7sCDLNTGLmve9uMmx4xaBNF49
         EbM+b46tRg8c37jgyMXLJm6P7rxXfGWWfj+5kFoLf8QalUQk+JmSwokWGc+8rT5SpMqb
         DlsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763982770; x=1764587570;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=FzYWAX8ciiG0wHhKqetFvk7149rfeYeDrlq54Hply/U=;
        b=r3gQ8hGr48ne1fNFm+s8PH2ss1e+kN/jxaTMIwT4trsTr2kmMaJNO73sKdO9iCITO0
         qPTs3qqN0GmVL6XoCrIFBAnbYz+GtAIUqvzAmatHgUfG4IyWjF+dVG3Rcd2H2j3LvlLp
         VSiRt39+L1bCTE1B4jwR/PHfHUMfQMfdo/hS95Ae/x+1qqZQo0Ujuywp/q0kZQGKeEqA
         phLAWIcuQJ62/8FJ+mDmg0dXXPH0K9sSZwn5Qv8nYK9i2h9lC6PYuKKH0OjHIXtGuGl9
         pSrSpSI9+PCm602egcL8GPjFYagPFIS9tp91q20hMiYY02qAgMlGXX4MSrY1Nj+Z5HXB
         2IRQ==
X-Gm-Message-State: AOJu0Yw7CxvQt6AspnNSHXL/2bNKxaHZTa5nk4mqh/b/zmrpuMLnLIqC
	PUy6/ryBDorl8VzxGQjLL8A0obRnbvNf+a5iirTF6+WRdoPMxlE4lL8CBCdgXh1IGt4dpLVLXC+
	Fdl2DjL8yzrYCUgcuXvcy8LrZvgdMwI1jPR5j6OaVztSrsiFpUbSmxt5SE+YE
X-Gm-Gg: ASbGnctIoAwIPY14/5I/doMTxUjdiaQYvvzoXw93eRF+Y4QOOtqqkQn6cXvJoQuSGAj
	IWb/H1DdHeqr1g2bPjXys1+QSx/Ch8uPzaial7OX8xM2n+2sQKoQ7ZuJkp42s2+OjqPvLVGwlaG
	JjPEnPDTY5P41pNl0foNuv+Iid3e1r5HYWO9trKIohY9p4BLfp2+vy1U4BPNYBBRKFkTcrM91kD
	/7o6MYDToa6QbRGsQ3crQulRp7mFmOYgSXOPmwOm1bEkRXteZ7PtpG2NXEO7ceZhv7q1EjiZkuG
	xFnktFqNmVzq4RxYbt8zigc4dthcyDRKRkyR/uUJHaQn8lBXiid8fWkHOBfzeynKXdovdyDgsis
	F2VYZJOiSkpbTMUwcl4QDByCpF0tjcvD0w6hU0CE=
X-Received: by 2002:a17:903:2f8f:b0:299:f838:a279 with SMTP id d9443c01a7336-29b6c3dbdb9mr128059905ad.2.1763982770318;
        Mon, 24 Nov 2025 03:12:50 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFDveKxAciudWptELKQFKCSinQSXZwY0H1MAxJj5zDA1IhZ3LDb68ilc20l+55j3RhtQdCkdQ==
X-Received: by 2002:a17:903:2f8f:b0:299:f838:a279 with SMTP id d9443c01a7336-29b6c3dbdb9mr128059735ad.2.1763982769916;
        Mon, 24 Nov 2025 03:12:49 -0800 (PST)
Received: from hu-kotarake-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-bd7604de68bsm13133780a12.21.2025.11.24.03.12.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Nov 2025 03:12:49 -0800 (PST)
From: Rakesh Kota <rakesh.kota@oss.qualcomm.com>
Date: Mon, 24 Nov 2025 16:42:40 +0530
Subject: [PATCH 1/2] dt-bindings: battery: Add SiLION battery bindings
 technology
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251124-add_silion_battery-v1-1-3c86b70d2543@oss.qualcomm.com>
References: <20251124-add_silion_battery-v1-0-3c86b70d2543@oss.qualcomm.com>
In-Reply-To: <20251124-add_silion_battery-v1-0-3c86b70d2543@oss.qualcomm.com>
To: Sebastian Reichel <sre@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc: linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, kamal.wadhwa@oss.qualcomm.com,
        fenglin.wu@oss.qualcomm.com,
        Rakesh Kota <rakesh.kota@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1763982763; l=910;
 i=rakesh.kota@oss.qualcomm.com; s=20250919; h=from:subject:message-id;
 bh=gvw6vJt65/j3kDflSAmg5Ggctp4w5GkDPc1mSBR1PtM=;
 b=NnIeS+ZNNGHvis+Mn8ogwgdDKcSI8hu2XmpKHt7pA0spbbQtaqxm2ui6TfS8jEnT0Wj2+OFyl
 Zh2YZAsHvg7BSseqyU9WgS2K5Kzd38IgCqA8BgbfyeK/GZMwWiuLkLC
X-Developer-Key: i=rakesh.kota@oss.qualcomm.com; a=ed25519;
 pk=dFhv9yPC8egZglsSLDMls08cOvZKZkG6QQn1a/ofwNU=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTI0MDA5OSBTYWx0ZWRfX5EX82a8GFo0E
 PhLnzFQHLvSkBNluYwppYVIu+m1AhpQAl5JB9wOev2N7QHKmsOy4Hn7EnyBOtktF015ACEXvmZ3
 R2AuIzxS1U4sd3GfspWki8+vyxWaGAkIBCf4u3a2fdEdZW7LTLZUqLO0Ghopc/qCo0/Pmsw7wqK
 JJnENEXt67MudGw8wvVLAi76zT8jaYu3qlvlPgd4wRa5bM1KGBAXPbZKclj8eNU+rbW4OztP5Tj
 gXMPekJt4k2KEntUcY4MTLy5gwq7ZbS2xT9BVpoyemwdglWZI0Y/TumP7kh1T2qnuiJWvxiOtOo
 GLZAfMKrzc8L7jHWwqxttYaaPk1PPxUNS6z89OqhrtXVPpIoV1PHn4mVvJQckqE9WNLgEVarmuR
 d6JpYSj2ZD0kOymyvt4dRU/332kP5Q==
X-Authority-Analysis: v=2.4 cv=YJqSCBGx c=1 sm=1 tr=0 ts=69243db3 cx=c_pps
 a=JL+w9abYAAE89/QcEU+0QA==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=6UeiqGixMTsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=EUspDBNiAAAA:8 a=3dr8tOzktftmaQavoPgA:9
 a=QEXdDO2ut3YA:10 a=324X-CrmTo6CU4MGRt3R:22
X-Proofpoint-GUID: INEjh_4WFPz5XaGr6RjAroCH9i22z_Me
X-Proofpoint-ORIG-GUID: INEjh_4WFPz5XaGr6RjAroCH9i22z_Me
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-24_04,2025-11-21_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 bulkscore=0 suspectscore=0 phishscore=0 clxscore=1011
 lowpriorityscore=0 malwarescore=0 impostorscore=0 spamscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2511240099

Document a new battery chemistry for silicon-anode lithium-ion
cells.

Signed-off-by: Rakesh Kota <rakesh.kota@oss.qualcomm.com>
---
 Documentation/devicetree/bindings/power/supply/battery.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/power/supply/battery.yaml b/Documentation/devicetree/bindings/power/supply/battery.yaml
index 491488e7b970397b409c248fb0c2a524301686a9..49cbd03956eeb9fc8be72540d8bf35840ccd7156 100644
--- a/Documentation/devicetree/bindings/power/supply/battery.yaml
+++ b/Documentation/devicetree/bindings/power/supply/battery.yaml
@@ -44,6 +44,7 @@ properties:
       - const: lithium-ion-polymer
       - const: lithium-ion-iron-phosphate
       - const: lithium-ion-manganese-oxide
+      - const: lithium-ion-silicon-anode
 
   over-voltage-threshold-microvolt:
     description: battery over-voltage limit

-- 
2.34.1


