Return-Path: <linux-pm+bounces-41551-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uIghOVHeeGnytgEAu9opvQ
	(envelope-from <linux-pm+bounces-41551-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Tue, 27 Jan 2026 16:48:33 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id C97F1970FB
	for <lists+linux-pm@lfdr.de>; Tue, 27 Jan 2026 16:48:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 6443130E52E8
	for <lists+linux-pm@lfdr.de>; Tue, 27 Jan 2026 15:28:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3EAD436403B;
	Tue, 27 Jan 2026 15:26:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Jgjk4jIE";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="TxM+XI0M"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 441AA3624C6
	for <linux-pm@vger.kernel.org>; Tue, 27 Jan 2026 15:26:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769527599; cv=none; b=FX1j5zkenVPr73VAh4AAI0KTSjBQ3vhBlfEETLKX5aS5ZyCjgYa8cG0l+CYKzDoF1Bhz+9rc1BVB/FChfQQD/+6gRjNcSF+eVXDiAAhEWgWp97rBhTUcXm/q0FP20RdLxh0QBSixMhirkz2FORjI79rAzGpa/0FbU/WNRZrlu24=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769527599; c=relaxed/simple;
	bh=B4il6pX97sLUqIkiuieF2tYH1GxLjNgVzFJmSBa882Q=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=VS4nNHw0HZaDj7eqUXNsA0V77iuTosFsB952UVhiz/lPw9FWkpULwSa/aCRQ8xhXzgOwIlM9l8pveMf1WCVpNQAcYv0SJ1zTzKcY0vyGfvR0SJvnHQVZvAscXE0K0zbS87wmm50YgShPYmpdp9MiESPwDjetm+BTYOfeJX/obTA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Jgjk4jIE; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=TxM+XI0M; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 60RA6KTm3857541
	for <linux-pm@vger.kernel.org>; Tue, 27 Jan 2026 15:26:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	qRPk0+6/52/Clh9bIxShw5zzmNOeFVJA5z8PJItt+4c=; b=Jgjk4jIEgM0wpBWt
	RG0dcREQ6U5/752UhaBqXv05txS6C2CIP7lDuv1P0g310uJTu0093rh/X+Nn14rz
	23AmW2AL9SDXnt/RI7tIoAUgxfWRcyOjQi8hk2yc5yCMoBQFX5UTE0f1WTti6neR
	sSTrevoudUA9s3tZYTJ59JRuvAYIGCGO6jAKeEEpRn14k3OH79qln/IqZPkQ42ho
	CEH78xo7ge56+6nxBl97EG+NwLNU9yTFix2V2Z7xQtYELJUVsDId3PjU4HcMORQf
	+c+dW/rEs+iZlpou5Ow4zUmfMLu+CVKP/B+v/U8xWsvFkLQyl+RvoiiVhMYx5jUd
	0Edevw==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com [209.85.222.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4bxffs371f-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Tue, 27 Jan 2026 15:26:34 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-8c6b4058909so1359515085a.3
        for <linux-pm@vger.kernel.org>; Tue, 27 Jan 2026 07:26:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1769527594; x=1770132394; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qRPk0+6/52/Clh9bIxShw5zzmNOeFVJA5z8PJItt+4c=;
        b=TxM+XI0MTvvhg80liz+b58Nxo+/2zjWrL+i8xTFw/9iP9o7+oExva3N6P7qySmhr4E
         j6ovdWtNxRz7Y2ql1vJxvI9kPhFu6Qj/1AjG2R1Mg1eFUvCf+m/gN71Gz6WmEhuEuBgR
         vMfYrajkwf6ZUGRP64fxaP77MBtNNloocdBxx4asGVkAlp9d5dMYSFXZ/pIpOdvcDjl2
         B6i21KYlj+6koF7w1q5Utul6SOYT7sPq2ZsurKQRwRJRMbJ1ERrQ7iOm2v1FTwHcZSQz
         dM1UpQ0w1AHSpLmrzyzxo0K2Op82PG60q+l8wRB7IOyNA3/ne2kASA537qGEXu3nQS1a
         ET+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769527594; x=1770132394;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=qRPk0+6/52/Clh9bIxShw5zzmNOeFVJA5z8PJItt+4c=;
        b=SCWwTiirobhho/Kum0yFfj5ldqO7jGE96VrDk4VxJqXWkUb/2Lr8BtkF9l+d/6dj67
         cqeb0xGzuslFFE+o87yqVuAOEi/EO7zfIzdyiVzgPhZ4nTmEQgzcCT2RQnrn5IRKhnEq
         +Fhh4k5NW0MozA/TL3xmXIvSZM+CoSCU6AtrCpw3pgaTQWOmRqT8sm86RDUMjogzqldm
         b0mAfM0L4Vr/+QTZAJMHlNKUtspn482GIXgHWZD2zx2a3lsEo19RQLa2U6AyB9aXOVNO
         knV5JQ0yldq07OZLaEQXNtddNNrt+4VRWeUpoHJ3zUVmRvocWND4iDE0g7Zdm8UGEt2J
         MWJQ==
X-Forwarded-Encrypted: i=1; AJvYcCXasskDpkfFSRGYyc9ZlXS17ByKqBCQkbydFm0Vieycr3oe3CYeVP3IcnGqQ7hRblYGRJpmz2aLLw==@vger.kernel.org
X-Gm-Message-State: AOJu0YxCmVQBsqrLYUu+R3zUBP9aBx1YuV2gWeL8rD/3VsPuWxt4gHpZ
	ptY0ICjrnDI7nZ1z1d0NJyPFJufurdfUFaBj26hJXY026I6Dzkhldm86YjtV8Lt2O+l/U2NlCc4
	CEBxUr9nqwxKllf514NktuG5EVp5hPHs7QZRcdyZ+nKhR1cd76EmuhZm5y1ZPbg==
X-Gm-Gg: AZuq6aLNXziQJJyxPhK7FDeGuMI/6aWaL662xDi9wnkEY3Je1d5cMAacVXK8/XxxoXE
	csN8ZuJkjvJDLMUmzhIYOfQ208IPxjtIiZ/f+m3uynKlw7echtSiPIqZdngFDfVmXHq/w6Unth5
	vtdWPrLBu0aPzSKV+1eJDUmA29gHeZO1frvmHTn+MpFqkn65MAcAVAyCzxMbeTqex9IaH2eoW4q
	HGgACIchJcub1RCoHk1/+qW01EaZnbq4qojBJNpC7ZnmQ2la5MSVoB6EvbWu4YyrMfDldZOMfia
	pC15m7gade8dThxrV+YLLBvYCFEW9Msq2O7RzyS7aMCOt7bKeKX8Hzvm3TRCT2frh/Q+YoO8J2u
	lYAniwwYQ/txmssWGeg==
X-Received: by 2002:a05:620a:2913:b0:8b2:dafb:9089 with SMTP id af79cd13be357-8c70b917823mr231202385a.67.1769527593519;
        Tue, 27 Jan 2026 07:26:33 -0800 (PST)
X-Received: by 2002:a05:620a:2913:b0:8b2:dafb:9089 with SMTP id af79cd13be357-8c70b917823mr231196885a.67.1769527592713;
        Tue, 27 Jan 2026 07:26:32 -0800 (PST)
Received: from hackbox.lan ([86.121.162.109])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-435b1f744e2sm40967260f8f.31.2026.01.27.07.26.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Jan 2026 07:26:31 -0800 (PST)
From: Abel Vesa <abel.vesa@oss.qualcomm.com>
Date: Tue, 27 Jan 2026 17:26:18 +0200
Subject: [PATCH v2 2/2] interconnect: qcom: Add Eliza interconnect provider
 driver
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260127-eliza-interconnect-v2-2-b238a8e04976@oss.qualcomm.com>
References: <20260127-eliza-interconnect-v2-0-b238a8e04976@oss.qualcomm.com>
In-Reply-To: <20260127-eliza-interconnect-v2-0-b238a8e04976@oss.qualcomm.com>
To: Georgi Djakov <djakov@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Odelu Kukatla <odelu.kukatla@oss.qualcomm.com>
Cc: linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Abel Vesa <abel.vesa@oss.qualcomm.com>,
        Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
        Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
X-Mailer: b4 0.15-dev-47773
X-Developer-Signature: v=1; a=openpgp-sha256; l=41327;
 i=abel.vesa@oss.qualcomm.com; h=from:subject:message-id;
 bh=X8bV1J/pZo5ySmTAAEdZfzboh+UXBIikbfcqUfOfyxE=;
 b=owEBbQKS/ZANAwAKARtfRMkAlRVWAcsmYgBpeNkiwqNhV452Y9rmFl+W0oCtUBOEI9qvDGlwS
 oNVcB+bdEyJAjMEAAEKAB0WIQRO8+4RTnqPKsqn0bgbX0TJAJUVVgUCaXjZIgAKCRAbX0TJAJUV
 VrxaEADCOVWsDJGEvAMCUYnVEMSM9WegnQN+LrUbrpPW2NxdsHbz0d6LfXVHxzDcpZqzfL5RQmL
 TrvWfZ3IPZytvgFh6+XJwosRH1+lAcy0Dwp9jX2gc3nbm+1sfS1c/8lPR5G1l7CMR/osgzFJGsw
 MXktpFEf17vbn+Eydb/jsm0iCYSIZGKtaTOWw6tpnngjUzkoeqYXh4AJu16rz/yhrpmBq+jTbza
 n10ElNAzHrKOFw7EdByAQdVNvAowYbDhiieLP/P2BUGhWcf51fgcUUFZquFsC9vLzqzKvtUX/wi
 b8olvh1OrHfIqAmS1Sm/k1c5+0BwPkkKO44NlvdepJ+S2MWL/MwlhPSJZGfPk7C8VYaaC6rPgsr
 yWqQ7IlO6FIJ0Dgd6sSdyjMKQ05vbaxs1Y6w8geF7owzUaRqYgGv8V2UKmJtPWgaEHqxkh6HrQm
 xLNpFJUCJSRTyjmMRjh2jlJcTqxHBRjO7hr+ODZO+OqEEx0e9kO6hcpfOeUtYUWpm5yWrzRHBH4
 bbRmbNqtXcClh8go9TooCftNdub662Hz9IBzDj8fPqDNllSTLIa/3exW+1A3ZXjLE2ktwbwIEms
 XAhI4cWPbIHnDF6g5IwRCO8xBtKOd2T5okb8NtPXqf/rZMgnzMl0OGNQtLfX7SanXCD3/jJACql
 jGOtqTegt198J4g==
X-Developer-Key: i=abel.vesa@oss.qualcomm.com; a=openpgp;
 fpr=6AFF162D57F4223A8770EF5AF7BF214136F41FAE
X-Proofpoint-GUID: s0CiBeNxUNDr3rIIoxI3YZWr58U1Hys8
X-Authority-Analysis: v=2.4 cv=YpcChoYX c=1 sm=1 tr=0 ts=6978d92b cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=oauzzCmhM186DRC0Y2yWPg==:17
 a=IkcTkHD0fZMA:10 a=vUbySO9Y5rIA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=EUspDBNiAAAA:8 a=L9_h2QeFn9c0u-cOwmsA:9
 a=QEXdDO2ut3YA:10 a=IoWCM6iH3mJn3m4BftBB:22
X-Proofpoint-ORIG-GUID: s0CiBeNxUNDr3rIIoxI3YZWr58U1Hys8
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTI3MDEyNiBTYWx0ZWRfX224YPg+yXffS
 32eDDRGoogAo7tGGhMCWZ3B3yDJpfUmW2jL3KrycwKrL5jMF9nLk+xH04fwWb9fCXDFUY3emTfd
 CVzCp6sWbbjnWHe4kfFxTuzPY25KyI0KHg0bsKqPmpgIsQ3WnG1L5xPwH60WYnQ0aSCltwnKsM8
 t2vNeIbvzj+oivr9wvL082mhBEumnagxDhjA9DE/n5exUVwsueBzO4yZgXGUSUOrhdsE0yMW8ka
 wkzG8GKgBLdTOc34+SzLJcft9vVdUGLLSy9BW9sVrKOl+JHQSuLwWHI8EIi+EJWfjm6D2NQRxiy
 qQLxXIb67npCW0ruFutaqTMbdBCaxlQw2fFleF9CmKUdqr4IAAOs7C0bB2BN7JcYtA065rJC+ux
 ckuEyikEQOUtt+JwAId8jG3pbkx0iEkOZT8SJ+AUPgw7D2VEfUyDYMSjNiVG6YjVOWXWuc1kZqv
 Xt4nUYEHvUwMUjxXBog==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-01-27_03,2026-01-27_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 clxscore=1015 phishscore=0 impostorscore=0 suspectscore=0
 spamscore=0 malwarescore=0 bulkscore=0 adultscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2601150000 definitions=main-2601270126
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[12];
	TAGGED_FROM(0.00)[bounces-41551-lists,linux-pm=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,oss.qualcomm.com:mid,oss.qualcomm.com:dkim,qualcomm.com:email,qualcomm.com:dkim];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[abel.vesa@oss.qualcomm.com,linux-pm@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-pm,dt];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: C97F1970FB
X-Rspamd-Action: no action

From: Odelu Kukatla <odelu.kukatla@oss.qualcomm.com>

Add driver for the Qualcomm interconnect buses found in Eliza
based platforms. The topology consists of several NoCs that are
controlled by a remote processor that collects the aggregated
bandwidth for each master-slave pairs.

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Signed-off-by: Odelu Kukatla <odelu.kukatla@oss.qualcomm.com>
Signed-off-by: Abel Vesa <abel.vesa@oss.qualcomm.com>
---
 drivers/interconnect/qcom/Kconfig  |    9 +
 drivers/interconnect/qcom/Makefile |    2 +
 drivers/interconnect/qcom/eliza.c  | 1585 ++++++++++++++++++++++++++++++++++++
 3 files changed, 1596 insertions(+)

diff --git a/drivers/interconnect/qcom/Kconfig b/drivers/interconnect/qcom/Kconfig
index bb1cb8a640c1..d18afe4392f1 100644
--- a/drivers/interconnect/qcom/Kconfig
+++ b/drivers/interconnect/qcom/Kconfig
@@ -8,6 +8,15 @@ config INTERCONNECT_QCOM
 config INTERCONNECT_QCOM_BCM_VOTER
 	tristate
 
+config INTERCONNECT_QCOM_ELIZA
+       tristate "Qualcomm Eliza interconnect driver"
+       depends on INTERCONNECT_QCOM_RPMH_POSSIBLE
+       select INTERCONNECT_QCOM_RPMH
+       select INTERCONNECT_QCOM_BCM_VOTER
+       help
+         This is a driver for the Qualcomm Network-on-Chip on Eliza-based
+         platforms.
+
 config INTERCONNECT_QCOM_GLYMUR
        tristate "Qualcomm GLYMUR interconnect driver"
        depends on INTERCONNECT_QCOM_RPMH_POSSIBLE
diff --git a/drivers/interconnect/qcom/Makefile b/drivers/interconnect/qcom/Makefile
index 6eedff043b41..cdf2c6c9fbf3 100644
--- a/drivers/interconnect/qcom/Makefile
+++ b/drivers/interconnect/qcom/Makefile
@@ -4,6 +4,7 @@ obj-$(CONFIG_INTERCONNECT_QCOM) += interconnect_qcom.o
 
 interconnect_qcom-y			:= icc-common.o
 icc-bcm-voter-objs			:= bcm-voter.o
+qnoc-eliza-objs				:= eliza.o
 qnoc-glymur-objs			:= glymur.o
 qnoc-kaanapali-objs			:= kaanapali.o
 qnoc-milos-objs				:= milos.o
@@ -48,6 +49,7 @@ qnoc-x1e80100-objs			:= x1e80100.o
 icc-smd-rpm-objs			:= smd-rpm.o icc-rpm.o icc-rpm-clocks.o
 
 obj-$(CONFIG_INTERCONNECT_QCOM_BCM_VOTER) += icc-bcm-voter.o
+obj-$(CONFIG_INTERCONNECT_QCOM_ELIZA) += qnoc-eliza.o
 obj-$(CONFIG_INTERCONNECT_QCOM_GLYMUR) += qnoc-glymur.o
 obj-$(CONFIG_INTERCONNECT_QCOM_KAANAPALI) += qnoc-kaanapali.o
 obj-$(CONFIG_INTERCONNECT_QCOM_MILOS) += qnoc-milos.o
diff --git a/drivers/interconnect/qcom/eliza.c b/drivers/interconnect/qcom/eliza.c
new file mode 100644
index 000000000000..a4f7903f0524
--- /dev/null
+++ b/drivers/interconnect/qcom/eliza.c
@@ -0,0 +1,1585 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
+ */
+
+#include <linux/device.h>
+#include <linux/interconnect.h>
+#include <linux/interconnect-provider.h>
+#include <linux/module.h>
+#include <linux/of_platform.h>
+#include <dt-bindings/interconnect/qcom,eliza-rpmh.h>
+
+#include "bcm-voter.h"
+#include "icc-rpmh.h"
+
+static struct qcom_icc_node qup1_core_slave = {
+	.name = "qup1_core_slave",
+	.channels = 1,
+	.buswidth = 4,
+};
+
+static struct qcom_icc_node qup2_core_slave = {
+	.name = "qup2_core_slave",
+	.channels = 1,
+	.buswidth = 4,
+};
+
+static struct qcom_icc_node qhs_ahb2phy0 = {
+	.name = "qhs_ahb2phy0",
+	.channels = 1,
+	.buswidth = 4,
+};
+
+static struct qcom_icc_node qhs_ahb2phy1 = {
+	.name = "qhs_ahb2phy1",
+	.channels = 1,
+	.buswidth = 4,
+};
+
+static struct qcom_icc_node qhs_camera_cfg = {
+	.name = "qhs_camera_cfg",
+	.channels = 1,
+	.buswidth = 4,
+};
+
+static struct qcom_icc_node qhs_clk_ctl = {
+	.name = "qhs_clk_ctl",
+	.channels = 1,
+	.buswidth = 4,
+};
+
+static struct qcom_icc_node qhs_crypto0_cfg = {
+	.name = "qhs_crypto0_cfg",
+	.channels = 1,
+	.buswidth = 4,
+};
+
+static struct qcom_icc_node qhs_display_cfg = {
+	.name = "qhs_display_cfg",
+	.channels = 1,
+	.buswidth = 4,
+};
+
+static struct qcom_icc_node qhs_gpuss_cfg = {
+	.name = "qhs_gpuss_cfg",
+	.channels = 1,
+	.buswidth = 8,
+};
+
+static struct qcom_icc_node qhs_i3c_ibi0_cfg = {
+	.name = "qhs_i3c_ibi0_cfg",
+	.channels = 1,
+	.buswidth = 4,
+};
+
+static struct qcom_icc_node qhs_i3c_ibi1_cfg = {
+	.name = "qhs_i3c_ibi1_cfg",
+	.channels = 1,
+	.buswidth = 4,
+};
+
+static struct qcom_icc_node qhs_imem_cfg = {
+	.name = "qhs_imem_cfg",
+	.channels = 1,
+	.buswidth = 4,
+};
+
+static struct qcom_icc_node qhs_mss_cfg = {
+	.name = "qhs_mss_cfg",
+	.channels = 1,
+	.buswidth = 4,
+};
+
+static struct qcom_icc_node qhs_pcie_0_cfg = {
+	.name = "qhs_pcie_0_cfg",
+	.channels = 1,
+	.buswidth = 4,
+};
+
+static struct qcom_icc_node qhs_prng = {
+	.name = "qhs_prng",
+	.channels = 1,
+	.buswidth = 4,
+};
+
+static struct qcom_icc_node qhs_qdss_cfg = {
+	.name = "qhs_qdss_cfg",
+	.channels = 1,
+	.buswidth = 4,
+};
+
+static struct qcom_icc_node qhs_qspi = {
+	.name = "qhs_qspi",
+	.channels = 1,
+	.buswidth = 4,
+};
+
+static struct qcom_icc_node qhs_qup1 = {
+	.name = "qhs_qup1",
+	.channels = 1,
+	.buswidth = 4,
+};
+
+static struct qcom_icc_node qhs_qup2 = {
+	.name = "qhs_qup2",
+	.channels = 1,
+	.buswidth = 4,
+};
+
+static struct qcom_icc_node qhs_sdc2 = {
+	.name = "qhs_sdc2",
+	.channels = 1,
+	.buswidth = 4,
+};
+
+static struct qcom_icc_node qhs_tcsr = {
+	.name = "qhs_tcsr",
+	.channels = 1,
+	.buswidth = 4,
+};
+
+static struct qcom_icc_node qhs_tlmm = {
+	.name = "qhs_tlmm",
+	.channels = 1,
+	.buswidth = 4,
+};
+
+static struct qcom_icc_node qhs_ufs_mem_cfg = {
+	.name = "qhs_ufs_mem_cfg",
+	.channels = 1,
+	.buswidth = 4,
+};
+
+static struct qcom_icc_node qhs_usb3_0 = {
+	.name = "qhs_usb3_0",
+	.channels = 1,
+	.buswidth = 4,
+};
+
+static struct qcom_icc_node qhs_venus_cfg = {
+	.name = "qhs_venus_cfg",
+	.channels = 1,
+	.buswidth = 4,
+};
+
+static struct qcom_icc_node qhs_vsense_ctrl_cfg = {
+	.name = "qhs_vsense_ctrl_cfg",
+	.channels = 1,
+	.buswidth = 4,
+};
+
+static struct qcom_icc_node xs_qdss_stm = {
+	.name = "xs_qdss_stm",
+	.channels = 1,
+	.buswidth = 4,
+};
+
+static struct qcom_icc_node xs_sys_tcu_cfg = {
+	.name = "xs_sys_tcu_cfg",
+	.channels = 1,
+	.buswidth = 8,
+};
+
+static struct qcom_icc_node qhs_aoss = {
+	.name = "qhs_aoss",
+	.channels = 1,
+	.buswidth = 4,
+};
+
+static struct qcom_icc_node qhs_ipa = {
+	.name = "qhs_ipa",
+	.channels = 1,
+	.buswidth = 4,
+};
+
+static struct qcom_icc_node qhs_ipc_router = {
+	.name = "qhs_ipc_router",
+	.channels = 1,
+	.buswidth = 4,
+};
+
+static struct qcom_icc_node qhs_soccp = {
+	.name = "qhs_soccp",
+	.channels = 1,
+	.buswidth = 4,
+};
+
+static struct qcom_icc_node qhs_tme_cfg = {
+	.name = "qhs_tme_cfg",
+	.channels = 1,
+	.buswidth = 4,
+};
+
+static struct qcom_icc_node qss_apss = {
+	.name = "qss_apss",
+	.channels = 1,
+	.buswidth = 4,
+};
+
+static struct qcom_icc_node qss_ddrss_cfg = {
+	.name = "qss_ddrss_cfg",
+	.channels = 1,
+	.buswidth = 4,
+};
+
+static struct qcom_icc_node qxs_boot_imem = {
+	.name = "qxs_boot_imem",
+	.channels = 1,
+	.buswidth = 16,
+};
+
+static struct qcom_icc_node qxs_imem = {
+	.name = "qxs_imem",
+	.channels = 1,
+	.buswidth = 8,
+};
+
+static struct qcom_icc_node qxs_modem_boot_imem = {
+	.name = "qxs_modem_boot_imem",
+	.channels = 1,
+	.buswidth = 8,
+};
+
+static struct qcom_icc_node srvc_cnoc_main = {
+	.name = "srvc_cnoc_main",
+	.channels = 1,
+	.buswidth = 4,
+};
+
+static struct qcom_icc_node xs_pcie_0 = {
+	.name = "xs_pcie_0",
+	.channels = 1,
+	.buswidth = 8,
+};
+
+static struct qcom_icc_node xs_pcie_1 = {
+	.name = "xs_pcie_1",
+	.channels = 1,
+	.buswidth = 8,
+};
+
+static struct qcom_icc_node ebi = {
+	.name = "ebi",
+	.channels = 4,
+	.buswidth = 4,
+};
+
+static struct qcom_icc_node srvc_mnoc_sf = {
+	.name = "srvc_mnoc_sf",
+	.channels = 1,
+	.buswidth = 4,
+};
+
+static struct qcom_icc_node srvc_mnoc_hf = {
+	.name = "srvc_mnoc_hf",
+	.channels = 1,
+	.buswidth = 4,
+};
+
+static struct qcom_icc_node srvc_pcie_aggre_noc = {
+	.name = "srvc_pcie_aggre_noc",
+	.channels = 1,
+	.buswidth = 4,
+};
+
+static struct qcom_icc_node qup1_core_master = {
+	.name = "qup1_core_master",
+	.channels = 1,
+	.buswidth = 4,
+	.num_links = 1,
+	.link_nodes = { &qup1_core_slave },
+};
+
+static struct qcom_icc_node qup2_core_master = {
+	.name = "qup2_core_master",
+	.channels = 1,
+	.buswidth = 4,
+	.num_links = 1,
+	.link_nodes = { &qup2_core_slave },
+};
+
+static struct qcom_icc_node qnm_gemnoc_pcie = {
+	.name = "qnm_gemnoc_pcie",
+	.channels = 1,
+	.buswidth = 16,
+	.num_links = 2,
+	.link_nodes = { &xs_pcie_0, &xs_pcie_1 },
+};
+
+static struct qcom_icc_node llcc_mc = {
+	.name = "llcc_mc",
+	.channels = 4,
+	.buswidth = 4,
+	.num_links = 1,
+	.link_nodes = { &ebi },
+};
+
+static struct qcom_icc_node qsm_sf_mnoc_cfg = {
+	.name = "qsm_sf_mnoc_cfg",
+	.channels = 1,
+	.buswidth = 4,
+	.num_links = 1,
+	.link_nodes = { &srvc_mnoc_sf },
+};
+
+static struct qcom_icc_node qsm_hf_mnoc_cfg = {
+	.name = "qsm_hf_mnoc_cfg",
+	.channels = 1,
+	.buswidth = 4,
+	.num_links = 1,
+	.link_nodes = { &srvc_mnoc_hf },
+};
+
+static struct qcom_icc_node qsm_pcie_anoc_cfg = {
+	.name = "qsm_pcie_anoc_cfg",
+	.channels = 1,
+	.buswidth = 4,
+	.num_links = 1,
+	.link_nodes = { &srvc_pcie_aggre_noc },
+};
+
+static struct qcom_icc_node qss_mnoc_hf_cfg = {
+	.name = "qss_mnoc_hf_cfg",
+	.channels = 1,
+	.buswidth = 4,
+	.num_links = 1,
+	.link_nodes = { &qsm_hf_mnoc_cfg },
+};
+
+static struct qcom_icc_node qss_mnoc_sf_cfg = {
+	.name = "qss_mnoc_sf_cfg",
+	.channels = 1,
+	.buswidth = 4,
+	.num_links = 1,
+	.link_nodes = { &qsm_sf_mnoc_cfg },
+};
+
+static struct qcom_icc_node qss_pcie_anoc_cfg = {
+	.name = "qss_pcie_anoc_cfg",
+	.channels = 1,
+	.buswidth = 4,
+	.num_links = 1,
+	.link_nodes = { &qsm_pcie_anoc_cfg },
+};
+
+static struct qcom_icc_node qns_llcc = {
+	.name = "qns_llcc",
+	.channels = 2,
+	.buswidth = 16,
+	.num_links = 1,
+	.link_nodes = { &llcc_mc },
+};
+
+static struct qcom_icc_node qns_pcie = {
+	.name = "qns_pcie",
+	.channels = 1,
+	.buswidth = 16,
+	.num_links = 1,
+	.link_nodes = { &qnm_gemnoc_pcie },
+};
+
+static struct qcom_icc_node qsm_cfg = {
+	.name = "qsm_cfg",
+	.channels = 1,
+	.buswidth = 4,
+	.num_links = 29,
+	.link_nodes = { &qhs_ahb2phy0, &qhs_ahb2phy1,
+			&qhs_camera_cfg, &qhs_clk_ctl,
+			&qhs_crypto0_cfg, &qhs_display_cfg,
+			&qhs_gpuss_cfg, &qhs_i3c_ibi0_cfg,
+			&qhs_i3c_ibi1_cfg, &qhs_imem_cfg,
+			&qhs_mss_cfg, &qhs_pcie_0_cfg,
+			&qhs_prng, &qhs_qdss_cfg,
+			&qhs_qspi, &qhs_qup1,
+			&qhs_qup2, &qhs_sdc2,
+			&qhs_tcsr, &qhs_tlmm,
+			&qhs_ufs_mem_cfg, &qhs_usb3_0,
+			&qhs_venus_cfg, &qhs_vsense_ctrl_cfg,
+			&qss_mnoc_hf_cfg, &qss_mnoc_sf_cfg,
+			&qss_pcie_anoc_cfg, &xs_qdss_stm,
+			&xs_sys_tcu_cfg },
+};
+
+static struct qcom_icc_node xm_gic = {
+	.name = "xm_gic",
+	.channels = 1,
+	.buswidth = 8,
+	.qosbox = &(const struct qcom_icc_qosbox) {
+		.num_ports = 1,
+		.port_offsets = { 0x15d000 },
+		.prio = 4,
+		.urg_fwd = 0,
+		.prio_fwd_disable = 1,
+	},
+	.num_links = 1,
+	.link_nodes = { &qns_llcc },
+};
+
+static struct qcom_icc_node qss_cfg = {
+	.name = "qss_cfg",
+	.channels = 1,
+	.buswidth = 4,
+	.num_links = 1,
+	.link_nodes = { &qsm_cfg },
+};
+
+static struct qcom_icc_node qnm_gemnoc_cnoc = {
+	.name = "qnm_gemnoc_cnoc",
+	.channels = 1,
+	.buswidth = 16,
+	.num_links = 12,
+	.link_nodes = { &qhs_aoss, &qhs_ipa,
+			&qhs_ipc_router, &qhs_soccp,
+			&qhs_tme_cfg, &qss_apss,
+			&qss_cfg, &qss_ddrss_cfg,
+			&qxs_boot_imem, &qxs_imem,
+			&qxs_modem_boot_imem, &srvc_cnoc_main },
+};
+
+static struct qcom_icc_node qns_gem_noc_cnoc = {
+	.name = "qns_gem_noc_cnoc",
+	.channels = 1,
+	.buswidth = 16,
+	.num_links = 1,
+	.link_nodes = { &qnm_gemnoc_cnoc },
+};
+
+static struct qcom_icc_qosbox alm_gpu_tcu_qos = {
+	.num_ports = 1,
+	.port_offsets = { 0x155000 },
+	.prio = 1,
+	.urg_fwd = 0,
+	.prio_fwd_disable = 1,
+};
+
+static struct qcom_icc_node alm_gpu_tcu = {
+	.name = "alm_gpu_tcu",
+	.channels = 1,
+	.buswidth = 8,
+	.qosbox = &alm_gpu_tcu_qos,
+	.num_links = 2,
+	.link_nodes = { &qns_gem_noc_cnoc, &qns_llcc },
+};
+
+static struct qcom_icc_qosbox alm_sys_tcu_qos = {
+	.num_ports = 1,
+	.port_offsets = { 0x157000 },
+	.prio = 6,
+	.urg_fwd = 0,
+	.prio_fwd_disable = 1,
+};
+
+static struct qcom_icc_node alm_sys_tcu = {
+	.name = "alm_sys_tcu",
+	.channels = 1,
+	.buswidth = 8,
+	.qosbox = &alm_sys_tcu_qos,
+	.num_links = 2,
+	.link_nodes = { &qns_gem_noc_cnoc, &qns_llcc },
+};
+
+static struct qcom_icc_node chm_apps = {
+	.name = "chm_apps",
+	.channels = 3,
+	.buswidth = 32,
+	.num_links = 3,
+	.link_nodes = { &qns_gem_noc_cnoc, &qns_llcc,
+			&qns_pcie },
+};
+
+static struct qcom_icc_qosbox qnm_gpu_qos = {
+	.num_ports = 2,
+	.port_offsets = { 0x31000, 0xb1000 },
+	.prio = 0,
+	.urg_fwd = 1,
+	.prio_fwd_disable = 1,
+};
+
+static struct qcom_icc_node qnm_gpu = {
+	.name = "qnm_gpu",
+	.channels = 2,
+	.buswidth = 32,
+	.qosbox = &qnm_gpu_qos,
+	.num_links = 2,
+	.link_nodes = { &qns_gem_noc_cnoc, &qns_llcc },
+};
+
+static struct qcom_icc_qosbox qnm_lpass_gemnoc_qos = {
+	.num_ports = 1,
+	.port_offsets = { 0x159000 },
+	.prio = 0,
+	.urg_fwd = 1,
+	.prio_fwd_disable = 0,
+};
+
+static struct qcom_icc_node qnm_lpass_gemnoc = {
+	.name = "qnm_lpass_gemnoc",
+	.channels = 1,
+	.buswidth = 16,
+	.qosbox = &qnm_lpass_gemnoc_qos,
+	.num_links = 3,
+	.link_nodes = { &qns_gem_noc_cnoc, &qns_llcc,
+			&qns_pcie },
+};
+
+static struct qcom_icc_node qnm_mdsp = {
+	.name = "qnm_mdsp",
+	.channels = 1,
+	.buswidth = 16,
+	.num_links = 3,
+	.link_nodes = { &qns_gem_noc_cnoc, &qns_llcc,
+			&qns_pcie },
+};
+
+static struct qcom_icc_qosbox qnm_mnoc_hf_qos = {
+	.num_ports = 2,
+	.port_offsets = { 0x33000, 0xb3000 },
+	.prio = 0,
+	.urg_fwd = 1,
+	.prio_fwd_disable = 0,
+};
+
+static struct qcom_icc_node qnm_mnoc_hf = {
+	.name = "qnm_mnoc_hf",
+	.channels = 2,
+	.buswidth = 32,
+	.qosbox = &qnm_mnoc_hf_qos,
+	.num_links = 2,
+	.link_nodes = { &qns_gem_noc_cnoc, &qns_llcc },
+};
+
+static struct qcom_icc_qosbox qnm_mnoc_sf_qos = {
+	.num_ports = 2,
+	.port_offsets = { 0x35000, 0xb5000 },
+	.prio = 0,
+	.urg_fwd = 0,
+	.prio_fwd_disable = 0,
+};
+
+static struct qcom_icc_node qnm_mnoc_sf = {
+	.name = "qnm_mnoc_sf",
+	.channels = 2,
+	.buswidth = 32,
+	.qosbox = &qnm_mnoc_sf_qos,
+	.num_links = 2,
+	.link_nodes = { &qns_gem_noc_cnoc, &qns_llcc },
+};
+
+static struct qcom_icc_qosbox qnm_nsp_gemnoc_qos = {
+	.num_ports = 2,
+	.port_offsets = { 0x37000, 0xb7000 },
+	.prio = 0,
+	.urg_fwd = 1,
+	.prio_fwd_disable = 1,
+};
+
+static struct qcom_icc_node qnm_nsp_gemnoc = {
+	.name = "qnm_nsp_gemnoc",
+	.channels = 2,
+	.buswidth = 32,
+	.qosbox = &qnm_nsp_gemnoc_qos,
+	.num_links = 3,
+	.link_nodes = { &qns_gem_noc_cnoc, &qns_llcc,
+			&qns_pcie },
+};
+
+static struct qcom_icc_qosbox qnm_pcie_qos = {
+	.num_ports = 1,
+	.port_offsets = { 0x15b000 },
+	.prio = 2,
+	.urg_fwd = 1,
+	.prio_fwd_disable = 0,
+};
+
+static struct qcom_icc_node qnm_pcie = {
+	.name = "qnm_pcie",
+	.channels = 1,
+	.buswidth = 16,
+	.qosbox = &qnm_pcie_qos,
+	.num_links = 2,
+	.link_nodes = { &qns_gem_noc_cnoc, &qns_llcc },
+};
+
+static struct qcom_icc_node qnm_snoc_sf = {
+	.name = "qnm_snoc_sf",
+	.channels = 1,
+	.buswidth = 16,
+	.qosbox = &(const struct qcom_icc_qosbox) {
+		.num_ports = 1,
+		.port_offsets = { 0x15f000 },
+		.prio = 0,
+		.urg_fwd = 1,
+		.prio_fwd_disable = 0,
+	},
+	.num_links = 3,
+	.link_nodes = { &qns_gem_noc_cnoc, &qns_llcc,
+			&qns_pcie },
+};
+
+static struct qcom_icc_node qxm_wlan_q6 = {
+	.name = "qxm_wlan_q6",
+	.channels = 1,
+	.buswidth = 8,
+	.num_links = 3,
+	.link_nodes = { &qns_gem_noc_cnoc, &qns_llcc,
+			&qns_pcie },
+};
+
+static struct qcom_icc_node qns_lpass_ag_noc_gemnoc = {
+	.name = "qns_lpass_ag_noc_gemnoc",
+	.channels = 1,
+	.buswidth = 16,
+	.num_links = 1,
+	.link_nodes = { &qnm_lpass_gemnoc },
+};
+
+static struct qcom_icc_node qns_mem_noc_sf = {
+	.name = "qns_mem_noc_sf",
+	.channels = 2,
+	.buswidth = 32,
+	.num_links = 1,
+	.link_nodes = { &qnm_mnoc_sf },
+};
+
+static struct qcom_icc_node qns_mem_noc_hf = {
+	.name = "qns_mem_noc_hf",
+	.channels = 2,
+	.buswidth = 32,
+	.num_links = 1,
+	.link_nodes = { &qnm_mnoc_hf },
+};
+
+static struct qcom_icc_node qns_nsp_gemnoc = {
+	.name = "qns_nsp_gemnoc",
+	.channels = 2,
+	.buswidth = 32,
+	.num_links = 1,
+	.link_nodes = { &qnm_nsp_gemnoc },
+};
+
+static struct qcom_icc_node qns_pcie_mem_noc = {
+	.name = "qns_pcie_mem_noc",
+	.channels = 1,
+	.buswidth = 16,
+	.num_links = 1,
+	.link_nodes = { &qnm_pcie },
+};
+
+static struct qcom_icc_node qns_gemnoc_sf = {
+	.name = "qns_gemnoc_sf",
+	.channels = 1,
+	.buswidth = 16,
+	.num_links = 1,
+	.link_nodes = { &qnm_snoc_sf },
+};
+
+static struct qcom_icc_node qnm_lpiaon_noc = {
+	.name = "qnm_lpiaon_noc",
+	.channels = 1,
+	.buswidth = 16,
+	.num_links = 1,
+	.link_nodes = { &qns_lpass_ag_noc_gemnoc },
+};
+
+static struct qcom_icc_qosbox qnm_camnoc_nrt_icp_sf_qos = {
+	.num_ports = 1,
+	.port_offsets = { 0x25000 },
+	.prio = 4,
+	.urg_fwd = 0,
+	.prio_fwd_disable = 1,
+};
+
+static struct qcom_icc_node qnm_camnoc_nrt_icp_sf = {
+	.name = "qnm_camnoc_nrt_icp_sf",
+	.channels = 1,
+	.buswidth = 8,
+	.qosbox = &qnm_camnoc_nrt_icp_sf_qos,
+	.num_links = 1,
+	.link_nodes = { &qns_mem_noc_sf },
+};
+
+static struct qcom_icc_node qnm_camnoc_rt_cdm_sf = {
+	.name = "qnm_camnoc_rt_cdm_sf",
+	.channels = 1,
+	.buswidth = 8,
+	.qosbox = &(const struct qcom_icc_qosbox) {
+		.num_ports = 1,
+		.port_offsets = { 0x2c000 },
+		.prio = 2,
+		.urg_fwd = 0,
+		.prio_fwd_disable = 1,
+	},
+	.num_links = 1,
+	.link_nodes = { &qns_mem_noc_sf },
+};
+
+static struct qcom_icc_node qnm_camnoc_sf = {
+	.name = "qnm_camnoc_sf",
+	.channels = 2,
+	.buswidth = 32,
+	.qosbox = &(const struct qcom_icc_qosbox) {
+		.num_ports = 2,
+		.port_offsets = { 0x26000, 0x27000 },
+		.prio = 0,
+		.urg_fwd = 1,
+		.prio_fwd_disable = 0,
+	},
+	.num_links = 1,
+	.link_nodes = { &qns_mem_noc_sf },
+};
+
+static struct qcom_icc_node qnm_video_mvp = {
+	.name = "qnm_video_mvp",
+	.channels = 1,
+	.buswidth = 32,
+	.qosbox = &(const struct qcom_icc_qosbox) {
+		.num_ports = 1,
+		.port_offsets = { 0x28000 },
+		.prio = 0,
+		.urg_fwd = 1,
+		.prio_fwd_disable = 0,
+	},
+	.num_links = 1,
+	.link_nodes = { &qns_mem_noc_sf },
+};
+
+static struct qcom_icc_node qnm_video_v_cpu = {
+	.name = "qnm_video_v_cpu",
+	.channels = 1,
+	.buswidth = 8,
+	.qosbox = &(const struct qcom_icc_qosbox) {
+		.num_ports = 1,
+		.port_offsets = { 0x2b000 },
+		.prio = 4,
+		.urg_fwd = 0,
+		.prio_fwd_disable = 1,
+	},
+	.num_links = 1,
+	.link_nodes = { &qns_mem_noc_sf },
+};
+
+static struct qcom_icc_node qnm_camnoc_hf = {
+	.name = "qnm_camnoc_hf",
+	.channels = 2,
+	.buswidth = 32,
+	.qosbox = &(const struct qcom_icc_qosbox) {
+		.num_ports = 2,
+		.port_offsets = { 0x64000, 0x65000 },
+		.prio = 0,
+		.urg_fwd = 1,
+		.prio_fwd_disable = 0,
+	},
+	.num_links = 1,
+	.link_nodes = { &qns_mem_noc_hf },
+};
+
+static struct qcom_icc_node qnm_mdp = {
+	.name = "qnm_mdp",
+	.channels = 2,
+	.buswidth = 32,
+	.qosbox = &(const struct qcom_icc_qosbox) {
+		.num_ports = 2,
+		.port_offsets = { 0x66000, 0x67000 },
+		.prio = 0,
+		.urg_fwd = 1,
+		.prio_fwd_disable = 0,
+	},
+	.num_links = 1,
+	.link_nodes = { &qns_mem_noc_hf },
+};
+
+static struct qcom_icc_node qxm_nsp = {
+	.name = "qxm_nsp",
+	.channels = 2,
+	.buswidth = 32,
+	.num_links = 1,
+	.link_nodes = { &qns_nsp_gemnoc },
+};
+
+static struct qcom_icc_node xm_pcie3_0 = {
+	.name = "xm_pcie3_0",
+	.channels = 1,
+	.buswidth = 8,
+	.qosbox = &(const struct qcom_icc_qosbox) {
+		.num_ports = 1,
+		.port_offsets = { 0xb000 },
+		.prio = 3,
+		.urg_fwd = 0,
+		.prio_fwd_disable = 1,
+	},
+	.num_links = 1,
+	.link_nodes = { &qns_pcie_mem_noc },
+};
+
+static struct qcom_icc_node xm_pcie3_1 = {
+	.name = "xm_pcie3_1",
+	.channels = 1,
+	.buswidth = 8,
+	.qosbox = &(const struct qcom_icc_qosbox) {
+		.num_ports = 1,
+		.port_offsets = { 0xc000 },
+		.prio = 3,
+		.urg_fwd = 0,
+		.prio_fwd_disable = 1,
+	},
+	.num_links = 1,
+	.link_nodes = { &qns_pcie_mem_noc },
+};
+
+static struct qcom_icc_node qnm_aggre1_noc = {
+	.name = "qnm_aggre1_noc",
+	.channels = 1,
+	.buswidth = 16,
+	.num_links = 1,
+	.link_nodes = { &qns_gemnoc_sf },
+};
+
+static struct qcom_icc_node qnm_aggre2_noc = {
+	.name = "qnm_aggre2_noc",
+	.channels = 1,
+	.buswidth = 16,
+	.num_links = 1,
+	.link_nodes = { &qns_gemnoc_sf },
+};
+
+static struct qcom_icc_node qnm_cnoc_data = {
+	.name = "qnm_cnoc_data",
+	.channels = 1,
+	.buswidth = 8,
+	.qosbox = &(const struct qcom_icc_qosbox) {
+		.num_ports = 1,
+		.port_offsets = { 0x1d000 },
+		.prio = 2,
+		.urg_fwd = 0,
+		.prio_fwd_disable = 1,
+	},
+	.num_links = 1,
+	.link_nodes = { &qns_gemnoc_sf },
+};
+
+static struct qcom_icc_node qnm_nsinoc_snoc = {
+	.name = "qnm_nsinoc_snoc",
+	.channels = 1,
+	.buswidth = 8,
+	.qosbox = &(const struct qcom_icc_qosbox) {
+		.num_ports = 1,
+		.port_offsets = { 0x1c000 },
+		.prio = 2,
+		.urg_fwd = 0,
+		.prio_fwd_disable = 1,
+	},
+	.num_links = 1,
+	.link_nodes = { &qns_gemnoc_sf },
+};
+
+static struct qcom_icc_node qns_a1noc_snoc = {
+	.name = "qns_a1noc_snoc",
+	.channels = 1,
+	.buswidth = 16,
+	.num_links = 1,
+	.link_nodes = { &qnm_aggre1_noc },
+};
+
+static struct qcom_icc_node qns_a2noc_snoc = {
+	.name = "qns_a2noc_snoc",
+	.channels = 1,
+	.buswidth = 16,
+	.num_links = 1,
+	.link_nodes = { &qnm_aggre2_noc },
+};
+
+static struct qcom_icc_node qns_lpass_aggnoc = {
+	.name = "qns_lpass_aggnoc",
+	.channels = 1,
+	.buswidth = 16,
+	.num_links = 1,
+	.link_nodes = { &qnm_lpiaon_noc },
+};
+
+static struct qcom_icc_node qhm_qspi = {
+	.name = "qhm_qspi",
+	.channels = 1,
+	.buswidth = 4,
+	.qosbox = &(const struct qcom_icc_qosbox) {
+		.num_ports = 1,
+		.port_offsets = { 0xc000 },
+		.prio = 2,
+		.urg_fwd = 0,
+		.prio_fwd_disable = 1,
+	},
+	.num_links = 1,
+	.link_nodes = { &qns_a1noc_snoc },
+};
+
+static struct qcom_icc_node qhm_qup1 = {
+	.name = "qhm_qup1",
+	.channels = 1,
+	.buswidth = 4,
+	.qosbox = &(const struct qcom_icc_qosbox) {
+		.num_ports = 1,
+		.port_offsets = { 0xd000 },
+		.prio = 2,
+		.urg_fwd = 0,
+		.prio_fwd_disable = 1,
+	},
+	.num_links = 1,
+	.link_nodes = { &qns_a1noc_snoc },
+};
+
+static struct qcom_icc_node xm_ufs_mem = {
+	.name = "xm_ufs_mem",
+	.channels = 1,
+	.buswidth = 16,
+	.qosbox = &(const struct qcom_icc_qosbox) {
+		.num_ports = 1,
+		.port_offsets = { 0xf000 },
+		.prio = 2,
+		.urg_fwd = 0,
+		.prio_fwd_disable = 1,
+	},
+	.num_links = 1,
+	.link_nodes = { &qns_a1noc_snoc },
+};
+
+static struct qcom_icc_node xm_usb3_0 = {
+	.name = "xm_usb3_0",
+	.channels = 1,
+	.buswidth = 8,
+	.qosbox = &(const struct qcom_icc_qosbox) {
+		.num_ports = 1,
+		.port_offsets = { 0x10000 },
+		.prio = 2,
+		.urg_fwd = 0,
+		.prio_fwd_disable = 1,
+	},
+	.num_links = 1,
+	.link_nodes = { &qns_a1noc_snoc },
+};
+
+static struct qcom_icc_node qhm_qup2 = {
+	.name = "qhm_qup2",
+	.channels = 1,
+	.buswidth = 4,
+	.qosbox = &(const struct qcom_icc_qosbox) {
+		.num_ports = 1,
+		.port_offsets = { 0x14000 },
+		.prio = 2,
+		.urg_fwd = 0,
+		.prio_fwd_disable = 1,
+	},
+	.num_links = 1,
+	.link_nodes = { &qns_a2noc_snoc },
+};
+
+static struct qcom_icc_node qxm_crypto = {
+	.name = "qxm_crypto",
+	.channels = 1,
+	.buswidth = 8,
+	.qosbox = &(const struct qcom_icc_qosbox) {
+		.num_ports = 1,
+		.port_offsets = { 0x15000 },
+		.prio = 2,
+		.urg_fwd = 0,
+		.prio_fwd_disable = 1,
+	},
+	.num_links = 1,
+	.link_nodes = { &qns_a2noc_snoc },
+};
+
+static struct qcom_icc_node qxm_ipa = {
+	.name = "qxm_ipa",
+	.channels = 1,
+	.buswidth = 8,
+	.qosbox = &(const struct qcom_icc_qosbox) {
+		.num_ports = 1,
+		.port_offsets = { 0x16000 },
+		.prio = 2,
+		.urg_fwd = 0,
+		.prio_fwd_disable = 1,
+	},
+	.num_links = 1,
+	.link_nodes = { &qns_a2noc_snoc },
+};
+
+static struct qcom_icc_node qxm_soccp = {
+	.name = "qxm_soccp",
+	.channels = 1,
+	.buswidth = 8,
+	.qosbox = &(const struct qcom_icc_qosbox) {
+		.num_ports = 1,
+		.port_offsets = { 0x1a000 },
+		.prio = 2,
+		.urg_fwd = 0,
+		.prio_fwd_disable = 1,
+	},
+	.num_links = 1,
+	.link_nodes = { &qns_a2noc_snoc },
+};
+
+static struct qcom_icc_node xm_qdss_etr_0 = {
+	.name = "xm_qdss_etr_0",
+	.channels = 1,
+	.buswidth = 8,
+	.qosbox = &(const struct qcom_icc_qosbox) {
+		.num_ports = 1,
+		.port_offsets = { 0x17000 },
+		.prio = 2,
+		.urg_fwd = 0,
+		.prio_fwd_disable = 1,
+	},
+	.num_links = 1,
+	.link_nodes = { &qns_a2noc_snoc },
+};
+
+static struct qcom_icc_node xm_qdss_etr_1 = {
+	.name = "xm_qdss_etr_1",
+	.channels = 1,
+	.buswidth = 8,
+	.qosbox = &(const struct qcom_icc_qosbox) {
+		.num_ports = 1,
+		.port_offsets = { 0x18000 },
+		.prio = 2,
+		.urg_fwd = 0,
+		.prio_fwd_disable = 1,
+	},
+	.num_links = 1,
+	.link_nodes = { &qns_a2noc_snoc },
+};
+
+static struct qcom_icc_node xm_sdc1 = {
+	.name = "xm_sdc1",
+	.channels = 1,
+	.buswidth = 8,
+	.qosbox = &(const struct qcom_icc_qosbox) {
+		.num_ports = 1,
+		.port_offsets = { 0x13000 },
+		.prio = 2,
+		.urg_fwd = 0,
+		.prio_fwd_disable = 1,
+	},
+	.num_links = 1,
+	.link_nodes = { &qns_a2noc_snoc },
+};
+
+static struct qcom_icc_node xm_sdc2 = {
+	.name = "xm_sdc2",
+	.channels = 1,
+	.buswidth = 8,
+	.qosbox = &(const struct qcom_icc_qosbox) {
+		.num_ports = 1,
+		.port_offsets = { 0x19000 },
+		.prio = 2,
+		.urg_fwd = 0,
+		.prio_fwd_disable = 1,
+	},
+	.num_links = 1,
+	.link_nodes = { &qns_a2noc_snoc },
+};
+
+static struct qcom_icc_node qnm_lpass_lpinoc = {
+	.name = "qnm_lpass_lpinoc",
+	.channels = 1,
+	.buswidth = 16,
+	.num_links = 1,
+	.link_nodes = { &qns_lpass_aggnoc },
+};
+
+static struct qcom_icc_node qns_lpi_aon_noc = {
+	.name = "qns_lpi_aon_noc",
+	.channels = 1,
+	.buswidth = 16,
+	.num_links = 1,
+	.link_nodes = { &qnm_lpass_lpinoc },
+};
+
+static struct qcom_icc_node qxm_lpinoc_dsp_axim = {
+	.name = "qxm_lpinoc_dsp_axim",
+	.channels = 1,
+	.buswidth = 16,
+	.num_links = 1,
+	.link_nodes = { &qns_lpi_aon_noc },
+};
+
+static struct qcom_icc_bcm bcm_ce0 = {
+	.name = "CE0",
+	.num_nodes = 1,
+	.nodes = { &qxm_crypto },
+};
+
+static struct qcom_icc_bcm bcm_cn0 = {
+	.name = "CN0",
+	.enable_mask = BIT(0),
+	.keepalive = true,
+	.num_nodes = 43,
+	.nodes = { &qsm_cfg, &qhs_ahb2phy0,
+		   &qhs_ahb2phy1, &qhs_camera_cfg,
+		   &qhs_clk_ctl, &qhs_crypto0_cfg,
+		   &qhs_gpuss_cfg, &qhs_i3c_ibi0_cfg,
+		   &qhs_i3c_ibi1_cfg, &qhs_imem_cfg,
+		   &qhs_mss_cfg, &qhs_pcie_0_cfg,
+		   &qhs_prng, &qhs_qdss_cfg,
+		   &qhs_qspi, &qhs_sdc2,
+		   &qhs_tcsr, &qhs_tlmm,
+		   &qhs_ufs_mem_cfg, &qhs_usb3_0,
+		   &qhs_venus_cfg, &qhs_vsense_ctrl_cfg,
+		   &qss_mnoc_hf_cfg, &qss_mnoc_sf_cfg,
+		   &qss_pcie_anoc_cfg, &xs_qdss_stm,
+		   &xs_sys_tcu_cfg, &qnm_gemnoc_cnoc,
+		   &qnm_gemnoc_pcie, &qhs_aoss,
+		   &qhs_ipa, &qhs_ipc_router,
+		   &qhs_soccp, &qhs_tme_cfg,
+		   &qss_apss, &qss_cfg,
+		   &qss_ddrss_cfg, &qxs_boot_imem,
+		   &qxs_imem, &qxs_modem_boot_imem,
+		   &srvc_cnoc_main, &xs_pcie_0,
+		   &xs_pcie_1 },
+};
+
+static struct qcom_icc_bcm bcm_cn1 = {
+	.name = "CN1",
+	.num_nodes = 3,
+	.nodes = { &qhs_display_cfg, &qhs_qup1,
+			   &qhs_qup2 },
+};
+
+static struct qcom_icc_bcm bcm_co0 = {
+	.name = "CO0",
+	.enable_mask = BIT(0),
+	.num_nodes = 2,
+	.nodes = { &qxm_nsp, &qns_nsp_gemnoc },
+};
+
+static struct qcom_icc_bcm bcm_lp0 = {
+	.name = "LP0",
+	.num_nodes = 2,
+	.nodes = { &qnm_lpass_lpinoc, &qns_lpass_aggnoc },
+};
+
+static struct qcom_icc_bcm bcm_mc0 = {
+	.name = "MC0",
+	.keepalive = true,
+	.num_nodes = 1,
+	.nodes = { &ebi },
+};
+
+static struct qcom_icc_bcm bcm_mm0 = {
+	.name = "MM0",
+	.num_nodes = 1,
+	.nodes = { &qns_mem_noc_hf },
+};
+
+static struct qcom_icc_bcm bcm_mm1 = {
+	.name = "MM1",
+	.enable_mask = BIT(0),
+	.num_nodes = 7,
+	.nodes = { &qnm_camnoc_nrt_icp_sf, &qnm_camnoc_rt_cdm_sf,
+		   &qnm_camnoc_sf, &qnm_video_mvp,
+		   &qnm_video_v_cpu, &qnm_camnoc_hf,
+		   &qns_mem_noc_sf },
+};
+
+static struct qcom_icc_bcm bcm_qup1 = {
+	.name = "QUP1",
+	.vote_scale = 1,
+	.keepalive = true,
+	.num_nodes = 1,
+	.nodes = { &qup1_core_slave },
+};
+
+static struct qcom_icc_bcm bcm_qup2 = {
+	.name = "QUP2",
+	.vote_scale = 1,
+	.keepalive = true,
+	.num_nodes = 1,
+	.nodes = { &qup2_core_slave },
+};
+
+static struct qcom_icc_bcm bcm_sh0 = {
+	.name = "SH0",
+	.keepalive = true,
+	.num_nodes = 1,
+	.nodes = { &qns_llcc },
+};
+
+static struct qcom_icc_bcm bcm_sh1 = {
+	.name = "SH1",
+	.enable_mask = BIT(0),
+	.num_nodes = 14,
+	.nodes = { &alm_gpu_tcu, &alm_sys_tcu,
+		   &chm_apps, &qnm_gpu,
+		   &qnm_mdsp, &qnm_mnoc_hf,
+		   &qnm_mnoc_sf, &qnm_nsp_gemnoc,
+		   &qnm_pcie, &qnm_snoc_sf,
+		   &qxm_wlan_q6, &xm_gic,
+		   &qns_gem_noc_cnoc, &qns_pcie },
+};
+
+static struct qcom_icc_bcm bcm_sn0 = {
+	.name = "SN0",
+	.keepalive = true,
+	.num_nodes = 1,
+	.nodes = { &qns_gemnoc_sf },
+};
+
+static struct qcom_icc_bcm bcm_sn2 = {
+	.name = "SN2",
+	.num_nodes = 1,
+	.nodes = { &qnm_aggre1_noc },
+};
+
+static struct qcom_icc_bcm bcm_sn3 = {
+	.name = "SN3",
+	.num_nodes = 1,
+	.nodes = { &qnm_aggre2_noc },
+};
+
+static struct qcom_icc_bcm bcm_sn4 = {
+	.name = "SN4",
+	.num_nodes = 1,
+	.nodes = { &qns_pcie_mem_noc },
+};
+
+static struct qcom_icc_node * const aggre1_noc_nodes[] = {
+	[MASTER_QSPI_0] = &qhm_qspi,
+	[MASTER_QUP_1] = &qhm_qup1,
+	[MASTER_UFS_MEM] = &xm_ufs_mem,
+	[MASTER_USB3_0] = &xm_usb3_0,
+	[SLAVE_A1NOC_SNOC] = &qns_a1noc_snoc,
+};
+
+static const struct qcom_icc_desc eliza_aggre1_noc = {
+	.nodes = aggre1_noc_nodes,
+	.num_nodes = ARRAY_SIZE(aggre1_noc_nodes),
+	.qos_requires_clocks = true,
+};
+
+static struct qcom_icc_bcm * const aggre2_noc_bcms[] = {
+	&bcm_ce0,
+};
+
+static struct qcom_icc_node * const aggre2_noc_nodes[] = {
+	[MASTER_QUP_2] = &qhm_qup2,
+	[MASTER_CRYPTO] = &qxm_crypto,
+	[MASTER_IPA] = &qxm_ipa,
+	[MASTER_SOCCP_AGGR_NOC] = &qxm_soccp,
+	[MASTER_QDSS_ETR] = &xm_qdss_etr_0,
+	[MASTER_QDSS_ETR_1] = &xm_qdss_etr_1,
+	[MASTER_SDCC_1] = &xm_sdc1,
+	[MASTER_SDCC_2] = &xm_sdc2,
+	[SLAVE_A2NOC_SNOC] = &qns_a2noc_snoc,
+};
+
+static const struct qcom_icc_desc eliza_aggre2_noc = {
+	.nodes = aggre2_noc_nodes,
+	.num_nodes = ARRAY_SIZE(aggre2_noc_nodes),
+	.bcms = aggre2_noc_bcms,
+	.num_bcms = ARRAY_SIZE(aggre2_noc_bcms),
+	.qos_requires_clocks = true,
+};
+
+static struct qcom_icc_bcm * const clk_virt_bcms[] = {
+	&bcm_qup1,
+	&bcm_qup2,
+};
+
+static struct qcom_icc_node * const clk_virt_nodes[] = {
+	[MASTER_QUP_CORE_1] = &qup1_core_master,
+	[MASTER_QUP_CORE_2] = &qup2_core_master,
+	[SLAVE_QUP_CORE_1] = &qup1_core_slave,
+	[SLAVE_QUP_CORE_2] = &qup2_core_slave,
+};
+
+static const struct qcom_icc_desc eliza_clk_virt = {
+	.nodes = clk_virt_nodes,
+	.num_nodes = ARRAY_SIZE(clk_virt_nodes),
+	.bcms = clk_virt_bcms,
+	.num_bcms = ARRAY_SIZE(clk_virt_bcms),
+};
+
+static struct qcom_icc_bcm * const cnoc_cfg_bcms[] = {
+	&bcm_cn0,
+	&bcm_cn1,
+};
+
+static struct qcom_icc_node * const cnoc_cfg_nodes[] = {
+	[MASTER_CNOC_CFG] = &qsm_cfg,
+	[SLAVE_AHB2PHY_SOUTH] = &qhs_ahb2phy0,
+	[SLAVE_AHB2PHY_NORTH] = &qhs_ahb2phy1,
+	[SLAVE_CAMERA_CFG] = &qhs_camera_cfg,
+	[SLAVE_CLK_CTL] = &qhs_clk_ctl,
+	[SLAVE_CRYPTO_0_CFG] = &qhs_crypto0_cfg,
+	[SLAVE_DISPLAY_CFG] = &qhs_display_cfg,
+	[SLAVE_GFX3D_CFG] = &qhs_gpuss_cfg,
+	[SLAVE_I3C_IBI0_CFG] = &qhs_i3c_ibi0_cfg,
+	[SLAVE_I3C_IBI1_CFG] = &qhs_i3c_ibi1_cfg,
+	[SLAVE_IMEM_CFG] = &qhs_imem_cfg,
+	[SLAVE_CNOC_MSS] = &qhs_mss_cfg,
+	[SLAVE_PCIE_0_CFG] = &qhs_pcie_0_cfg,
+	[SLAVE_PRNG] = &qhs_prng,
+	[SLAVE_QDSS_CFG] = &qhs_qdss_cfg,
+	[SLAVE_QSPI_0] = &qhs_qspi,
+	[SLAVE_QUP_1] = &qhs_qup1,
+	[SLAVE_QUP_2] = &qhs_qup2,
+	[SLAVE_SDCC_2] = &qhs_sdc2,
+	[SLAVE_TCSR] = &qhs_tcsr,
+	[SLAVE_TLMM] = &qhs_tlmm,
+	[SLAVE_UFS_MEM_CFG] = &qhs_ufs_mem_cfg,
+	[SLAVE_USB3_0] = &qhs_usb3_0,
+	[SLAVE_VENUS_CFG] = &qhs_venus_cfg,
+	[SLAVE_VSENSE_CTRL_CFG] = &qhs_vsense_ctrl_cfg,
+	[SLAVE_CNOC_MNOC_HF_CFG] = &qss_mnoc_hf_cfg,
+	[SLAVE_CNOC_MNOC_SF_CFG] = &qss_mnoc_sf_cfg,
+	[SLAVE_PCIE_ANOC_CFG] = &qss_pcie_anoc_cfg,
+	[SLAVE_QDSS_STM] = &xs_qdss_stm,
+	[SLAVE_TCU] = &xs_sys_tcu_cfg,
+};
+
+static const struct qcom_icc_desc eliza_cnoc_cfg = {
+	.nodes = cnoc_cfg_nodes,
+	.num_nodes = ARRAY_SIZE(cnoc_cfg_nodes),
+	.bcms = cnoc_cfg_bcms,
+	.num_bcms = ARRAY_SIZE(cnoc_cfg_bcms),
+};
+
+static struct qcom_icc_bcm * const cnoc_main_bcms[] = {
+	&bcm_cn0,
+};
+
+static struct qcom_icc_node * const cnoc_main_nodes[] = {
+	[MASTER_GEM_NOC_CNOC] = &qnm_gemnoc_cnoc,
+	[MASTER_GEM_NOC_PCIE_SNOC] = &qnm_gemnoc_pcie,
+	[SLAVE_AOSS] = &qhs_aoss,
+	[SLAVE_IPA_CFG] = &qhs_ipa,
+	[SLAVE_IPC_ROUTER_CFG] = &qhs_ipc_router,
+	[SLAVE_SOCCP] = &qhs_soccp,
+	[SLAVE_TME_CFG] = &qhs_tme_cfg,
+	[SLAVE_APPSS] = &qss_apss,
+	[SLAVE_CNOC_CFG] = &qss_cfg,
+	[SLAVE_DDRSS_CFG] = &qss_ddrss_cfg,
+	[SLAVE_BOOT_IMEM] = &qxs_boot_imem,
+	[SLAVE_IMEM] = &qxs_imem,
+	[SLAVE_BOOT_IMEM_2] = &qxs_modem_boot_imem,
+	[SLAVE_SERVICE_CNOC] = &srvc_cnoc_main,
+	[SLAVE_PCIE_0] = &xs_pcie_0,
+	[SLAVE_PCIE_1] = &xs_pcie_1,
+};
+
+static const struct qcom_icc_desc eliza_cnoc_main = {
+	.nodes = cnoc_main_nodes,
+	.num_nodes = ARRAY_SIZE(cnoc_main_nodes),
+	.bcms = cnoc_main_bcms,
+	.num_bcms = ARRAY_SIZE(cnoc_main_bcms),
+};
+
+static struct qcom_icc_bcm * const gem_noc_bcms[] = {
+	&bcm_sh0,
+	&bcm_sh1,
+};
+
+static struct qcom_icc_node * const gem_noc_nodes[] = {
+	[MASTER_GPU_TCU] = &alm_gpu_tcu,
+	[MASTER_SYS_TCU] = &alm_sys_tcu,
+	[MASTER_APPSS_PROC] = &chm_apps,
+	[MASTER_GFX3D] = &qnm_gpu,
+	[MASTER_LPASS_GEM_NOC] = &qnm_lpass_gemnoc,
+	[MASTER_MSS_PROC] = &qnm_mdsp,
+	[MASTER_MNOC_HF_MEM_NOC] = &qnm_mnoc_hf,
+	[MASTER_MNOC_SF_MEM_NOC] = &qnm_mnoc_sf,
+	[MASTER_COMPUTE_NOC] = &qnm_nsp_gemnoc,
+	[MASTER_ANOC_PCIE_GEM_NOC] = &qnm_pcie,
+	[MASTER_SNOC_SF_MEM_NOC] = &qnm_snoc_sf,
+	[MASTER_WLAN_Q6] = &qxm_wlan_q6,
+	[MASTER_GIC] = &xm_gic,
+	[SLAVE_GEM_NOC_CNOC] = &qns_gem_noc_cnoc,
+	[SLAVE_LLCC] = &qns_llcc,
+	[SLAVE_MEM_NOC_PCIE_SNOC] = &qns_pcie,
+};
+
+static const struct qcom_icc_desc eliza_gem_noc = {
+	.nodes = gem_noc_nodes,
+	.num_nodes = ARRAY_SIZE(gem_noc_nodes),
+	.bcms = gem_noc_bcms,
+	.num_bcms = ARRAY_SIZE(gem_noc_bcms),
+};
+
+static struct qcom_icc_node * const lpass_ag_noc_nodes[] = {
+	[MASTER_LPIAON_NOC] = &qnm_lpiaon_noc,
+	[SLAVE_LPASS_GEM_NOC] = &qns_lpass_ag_noc_gemnoc,
+};
+
+static const struct qcom_icc_desc eliza_lpass_ag_noc = {
+	.nodes = lpass_ag_noc_nodes,
+	.num_nodes = ARRAY_SIZE(lpass_ag_noc_nodes),
+};
+
+static struct qcom_icc_bcm * const lpass_lpiaon_noc_bcms[] = {
+	&bcm_lp0,
+};
+
+static struct qcom_icc_node * const lpass_lpiaon_noc_nodes[] = {
+	[MASTER_LPASS_LPINOC] = &qnm_lpass_lpinoc,
+	[SLAVE_LPIAON_NOC_LPASS_AG_NOC] = &qns_lpass_aggnoc,
+};
+
+static const struct qcom_icc_desc eliza_lpass_lpiaon_noc = {
+	.nodes = lpass_lpiaon_noc_nodes,
+	.num_nodes = ARRAY_SIZE(lpass_lpiaon_noc_nodes),
+	.bcms = lpass_lpiaon_noc_bcms,
+	.num_bcms = ARRAY_SIZE(lpass_lpiaon_noc_bcms),
+};
+
+static struct qcom_icc_node * const lpass_lpicx_noc_nodes[] = {
+	[MASTER_LPASS_PROC] = &qxm_lpinoc_dsp_axim,
+	[SLAVE_LPICX_NOC_LPIAON_NOC] = &qns_lpi_aon_noc,
+};
+
+static const struct qcom_icc_desc eliza_lpass_lpicx_noc = {
+	.nodes = lpass_lpicx_noc_nodes,
+	.num_nodes = ARRAY_SIZE(lpass_lpicx_noc_nodes),
+};
+
+static struct qcom_icc_bcm * const mc_virt_bcms[] = {
+	&bcm_mc0,
+};
+
+static struct qcom_icc_node * const mc_virt_nodes[] = {
+	[MASTER_LLCC] = &llcc_mc,
+	[SLAVE_EBI1] = &ebi,
+};
+
+static const struct qcom_icc_desc eliza_mc_virt = {
+	.nodes = mc_virt_nodes,
+	.num_nodes = ARRAY_SIZE(mc_virt_nodes),
+	.bcms = mc_virt_bcms,
+	.num_bcms = ARRAY_SIZE(mc_virt_bcms),
+};
+
+static struct qcom_icc_bcm * const mmss_noc_bcms[] = {
+	&bcm_mm0,
+	&bcm_mm1,
+};
+
+static struct qcom_icc_node * const mmss_noc_nodes[] = {
+	[MASTER_CAMNOC_NRT_ICP_SF] = &qnm_camnoc_nrt_icp_sf,
+	[MASTER_CAMNOC_RT_CDM_SF] = &qnm_camnoc_rt_cdm_sf,
+	[MASTER_CAMNOC_SF] = &qnm_camnoc_sf,
+	[MASTER_VIDEO_MVP] = &qnm_video_mvp,
+	[MASTER_VIDEO_V_PROC] = &qnm_video_v_cpu,
+	[MASTER_CNOC_MNOC_SF_CFG] = &qsm_sf_mnoc_cfg,
+	[MASTER_CAMNOC_HF] = &qnm_camnoc_hf,
+	[MASTER_MDP] = &qnm_mdp,
+	[MASTER_CNOC_MNOC_HF_CFG] = &qsm_hf_mnoc_cfg,
+	[SLAVE_MNOC_SF_MEM_NOC] = &qns_mem_noc_sf,
+	[SLAVE_SERVICE_MNOC_SF] = &srvc_mnoc_sf,
+	[SLAVE_MNOC_HF_MEM_NOC] = &qns_mem_noc_hf,
+	[SLAVE_SERVICE_MNOC_HF] = &srvc_mnoc_hf,
+};
+
+static const struct qcom_icc_desc eliza_mmss_noc = {
+	.nodes = mmss_noc_nodes,
+	.num_nodes = ARRAY_SIZE(mmss_noc_nodes),
+	.bcms = mmss_noc_bcms,
+	.num_bcms = ARRAY_SIZE(mmss_noc_bcms),
+};
+
+static struct qcom_icc_bcm * const nsp_noc_bcms[] = {
+	&bcm_co0,
+};
+
+static struct qcom_icc_node * const nsp_noc_nodes[] = {
+	[MASTER_CDSP_PROC] = &qxm_nsp,
+	[SLAVE_CDSP_MEM_NOC] = &qns_nsp_gemnoc,
+};
+
+static const struct qcom_icc_desc eliza_nsp_noc = {
+	.nodes = nsp_noc_nodes,
+	.num_nodes = ARRAY_SIZE(nsp_noc_nodes),
+	.bcms = nsp_noc_bcms,
+	.num_bcms = ARRAY_SIZE(nsp_noc_bcms),
+};
+
+static struct qcom_icc_bcm * const pcie_anoc_bcms[] = {
+	&bcm_sn4,
+};
+
+static struct qcom_icc_node * const pcie_anoc_nodes[] = {
+	[MASTER_PCIE_ANOC_CFG] = &qsm_pcie_anoc_cfg,
+	[MASTER_PCIE_0] = &xm_pcie3_0,
+	[MASTER_PCIE_1] = &xm_pcie3_1,
+	[SLAVE_ANOC_PCIE_GEM_NOC] = &qns_pcie_mem_noc,
+	[SLAVE_SERVICE_PCIE_ANOC] = &srvc_pcie_aggre_noc,
+};
+
+static const struct qcom_icc_desc eliza_pcie_anoc = {
+	.nodes = pcie_anoc_nodes,
+	.num_nodes = ARRAY_SIZE(pcie_anoc_nodes),
+	.bcms = pcie_anoc_bcms,
+	.num_bcms = ARRAY_SIZE(pcie_anoc_bcms),
+	.qos_requires_clocks = true,
+};
+
+static struct qcom_icc_bcm * const system_noc_bcms[] = {
+	&bcm_sn0,
+	&bcm_sn2,
+	&bcm_sn3,
+};
+
+static struct qcom_icc_node * const system_noc_nodes[] = {
+	[MASTER_A1NOC_SNOC] = &qnm_aggre1_noc,
+	[MASTER_A2NOC_SNOC] = &qnm_aggre2_noc,
+	[MASTER_CNOC_SNOC] = &qnm_cnoc_data,
+	[MASTER_NSINOC_SNOC] = &qnm_nsinoc_snoc,
+	[SLAVE_SNOC_GEM_NOC_SF] = &qns_gemnoc_sf,
+};
+
+static const struct qcom_icc_desc eliza_system_noc = {
+	.nodes = system_noc_nodes,
+	.num_nodes = ARRAY_SIZE(system_noc_nodes),
+	.bcms = system_noc_bcms,
+	.num_bcms = ARRAY_SIZE(system_noc_bcms),
+};
+
+static const struct of_device_id qnoc_of_match[] = {
+	{ .compatible = "qcom,eliza-aggre1-noc", .data = &eliza_aggre1_noc },
+	{ .compatible = "qcom,eliza-aggre2-noc", .data = &eliza_aggre2_noc },
+	{ .compatible = "qcom,eliza-clk-virt", .data = &eliza_clk_virt },
+	{ .compatible = "qcom,eliza-cnoc-cfg", .data = &eliza_cnoc_cfg },
+	{ .compatible = "qcom,eliza-cnoc-main", .data = &eliza_cnoc_main },
+	{ .compatible = "qcom,eliza-gem-noc", .data = &eliza_gem_noc },
+	{ .compatible = "qcom,eliza-lpass-ag-noc", .data = &eliza_lpass_ag_noc },
+	{ .compatible = "qcom,eliza-lpass-lpiaon-noc", .data = &eliza_lpass_lpiaon_noc },
+	{ .compatible = "qcom,eliza-lpass-lpicx-noc", .data = &eliza_lpass_lpicx_noc },
+	{ .compatible = "qcom,eliza-mc-virt", .data = &eliza_mc_virt },
+	{ .compatible = "qcom,eliza-mmss-noc", .data = &eliza_mmss_noc },
+	{ .compatible = "qcom,eliza-nsp-noc", .data = &eliza_nsp_noc },
+	{ .compatible = "qcom,eliza-pcie-anoc", .data = &eliza_pcie_anoc },
+	{ .compatible = "qcom,eliza-system-noc", .data = &eliza_system_noc },
+	{ }
+};
+MODULE_DEVICE_TABLE(of, qnoc_of_match);
+
+static struct platform_driver qnoc_driver = {
+	.probe = qcom_icc_rpmh_probe,
+	.remove = qcom_icc_rpmh_remove,
+	.driver = {
+		.name = "qnoc-eliza",
+		.of_match_table = qnoc_of_match,
+		.sync_state = icc_sync_state,
+	},
+};
+
+static int __init qnoc_driver_init(void)
+{
+	return platform_driver_register(&qnoc_driver);
+}
+core_initcall(qnoc_driver_init);
+
+static void __exit qnoc_driver_exit(void)
+{
+	platform_driver_unregister(&qnoc_driver);
+}
+module_exit(qnoc_driver_exit);
+
+MODULE_DESCRIPTION(" Qualcomm Eliza NoC driver");
+MODULE_LICENSE("GPL");

-- 
2.48.1


