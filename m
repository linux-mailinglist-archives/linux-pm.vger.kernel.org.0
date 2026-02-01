Return-Path: <linux-pm+bounces-41858-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2DAhDcMvf2k8lQIAu9opvQ
	(envelope-from <linux-pm+bounces-41858-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Sun, 01 Feb 2026 11:49:39 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id AC93EC5948
	for <lists+linux-pm@lfdr.de>; Sun, 01 Feb 2026 11:49:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 56552301DBAD
	for <lists+linux-pm@lfdr.de>; Sun,  1 Feb 2026 10:49:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB4AE329E5E;
	Sun,  1 Feb 2026 10:49:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="fbdc4tQo";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="ajjIfPsh"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98429326944
	for <linux-pm@vger.kernel.org>; Sun,  1 Feb 2026 10:49:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769942957; cv=none; b=NX84Xk2+rzh2wb1uR3Rgbvb/wxh35PZ204l4YtpxYN01mmHDZE/GWQfFgHqz6BerMsvwwWEb8K1pRuU2YE+MyrhTrAU4Rcbu/NsDXWVkzinwO2imLQEKAv8QBMR4lY2x0O6TQ902/PxvUxkdd2iiRDj1FLJN+ZXMoxGTUfik/4c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769942957; c=relaxed/simple;
	bh=1ki1Bg2wVBxPRRsl6mVjpi8HB0xkrxipGcALh4K6IgU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=EKGPQOrtYpKwSDcEFqgd1w9hcGQQsjQln0w6CEK3llB1Kifh4vO6z+1WQSPEbTyQgFySRM9To01kKSyGvCkjxIUx1FkRAUA8O/ygGcvU87T+V0hLhV/hDHuvK2sUcQo7xjzLMcwypsdSNu+g2g4cm74a4gq7Z90UZgAqJEJ0wNw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=fbdc4tQo; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=ajjIfPsh; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6119ePLZ1154880
	for <linux-pm@vger.kernel.org>; Sun, 1 Feb 2026 10:49:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	kJ8DGyjpwaWzCDRoQPsm7pPdBa+snsrNkp2GGDNUQaw=; b=fbdc4tQoPZP/2jUB
	OPCwJcdfpk/02Gl7I9w6+KyAAl5tV6rhVfA6Uv3eeLEUnN32X09oDDmyU54qdebw
	DWIl4k/V1A8MPd9oWHRSP1pVn66ZMwJeR77KMc5LXPM4D2O/UpvRZ+9pmnTthYur
	TwrbPPOfXx8luaoKXXMZRx8y8TRgbfhqgvVO5xkVL+zRcEGJNlznpnr0VYg1FD7E
	1VBU9h+O4i0uibTN0NTSKo1NQ6AynKmhRnmA1M9NVGGCtJ+Egca5SGF8JjdlyEd7
	P5C9AY4uuOAKaMtH6H2BsfNK9xLIB6DYv9CZTEM9n1W7YAPoQsXOgh/aaf/pKXAG
	82HaXA==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com [209.85.222.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4c1awdaf94-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Sun, 01 Feb 2026 10:49:14 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-8c6a2ef071dso704689585a.0
        for <linux-pm@vger.kernel.org>; Sun, 01 Feb 2026 02:49:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1769942954; x=1770547754; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kJ8DGyjpwaWzCDRoQPsm7pPdBa+snsrNkp2GGDNUQaw=;
        b=ajjIfPsh31E5hJtoLca0OwKdi/Vqsf0c/wiTNTako6HIxKa2ZAta+7RvV5oo43LfTO
         xLsJk5jlaM2omhmRxuUohKSmCPAULZ1hRVv6TxFBI9GZy0cXWeIWZ3TBZ2K/paWmRYan
         0xuEBiCkcMcxNDsk37o3WdfIdZsgSlRS9Ej3m6W0LCP6qV3f7r6ZZI3h3rYTvEBDWg1H
         abOSm5FY7q7t9/7LJfMWlC6Ml4uvaOAgodk2xvJTPzsBlqEjklFNUML8QVP5hoI6IzHr
         y6RK8zUu+3kcn9t5UkzE9iYDbgEUrtADfdzn306xNRoUdEQTmk/y2xszYeZEB94JwMBO
         BSNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769942954; x=1770547754;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=kJ8DGyjpwaWzCDRoQPsm7pPdBa+snsrNkp2GGDNUQaw=;
        b=CJ9P3J0PPSkcw6xcz5yKXQDRZxsMWIo4+xTpVRgJiChDG8EALotvMbmlUDsiNgOzgu
         xkd55jfDNJisUF6smkNFjK6yogZ1sQVSbiEr/wp21XHJLduhM5Vrqi8thc+gbLjZZUa/
         lk+6P7A6V0FN/v3HcU3DHoCN50zh/IhFUWUT/E63z9lbBtEpWIzsdgf7XTCR17gGnVYy
         7nLPgBsqhIDKDPh6hTdRBsmGUHO3dtgIIY28R5sYO8w0NrApjL/IeuSaJRz8+3ZXxpKB
         CD2eE8Ct14qUWGSEa1ih/txI75KuL4tJJySi5MP4S4I5yg0RYRy6WQ7u6pdw0dMQbTDm
         Z/Rw==
X-Forwarded-Encrypted: i=1; AJvYcCWQaQd+xHOXqK9TB5RpTY3Eeh2rNFqGdloSgWSsISBhFWpQC8JaiibT4t2MmXji7i0EJqjcGY6lfA==@vger.kernel.org
X-Gm-Message-State: AOJu0Yx2RMvrhuPHHKvNOszm548uoto6U46XFXeAji07Ngoo8vlhgoJZ
	nzaRabHyyb4uwLgzae9V3whz3Ux8NBv1Ds6P7OSsJCuXRRve3LweSc+e7V11/9kEP1cQz8bjCcN
	zUFWGYUFTc26OBh9PrWTX8+HSHYBjtWBFG3ADgqOv7oyf1Y4xok/PglaBT84nKQ==
X-Gm-Gg: AZuq6aKL7KNnp9GlX2emed+OzVmT2EHPnRYW0s1lTTYjCe8KONKXbzgv15SHS4HitEi
	hCT4nWFvu5F3vaQATWO9d9RbF9qos1raOS7sidG32RNNOgaoazTFbY+6dWm77khP3GQosZLWmfy
	ZGadOA19shxNcLjO1Vz8kS9QMVNgI56gQuuee8P+LeJc++PxOlZfjCfoaavpdnuBuwL8CIuYrEU
	riedKBiAjvCBz8To2z+x3H1rhkmzC4ftA4sFSTSwWoQRTnLhXXWzHw0ZQtva50AVKhFF1meU2dl
	GrmbZ5epVK46vKtSfKg99KBE158n2rPFD3qTkg/DI9sVG6lbhFLiuQ1NeD9K4n1htWk+Tr1KgoG
	FgkfxR9Rkk5xUa6KFTzGyk/2UI2ZnEHgD4Si59th6M0pcScBrDt5hmOERAL3dA5pyZMKGPXbU2f
	H/wFHRN314uz5cALuHmrYP0v8=
X-Received: by 2002:a05:620a:480e:b0:8b2:f269:f899 with SMTP id af79cd13be357-8c9eb2fb1cemr909752285a.56.1769942953680;
        Sun, 01 Feb 2026 02:49:13 -0800 (PST)
X-Received: by 2002:a05:620a:480e:b0:8b2:f269:f899 with SMTP id af79cd13be357-8c9eb2fb1cemr909749285a.56.1769942953227;
        Sun, 01 Feb 2026 02:49:13 -0800 (PST)
Received: from umbar.lan (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-59e074b7a8csm2835006e87.77.2026.02.01.02.49.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Feb 2026 02:49:12 -0800 (PST)
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Date: Sun, 01 Feb 2026 12:48:58 +0200
Subject: [PATCH v2 1/8] dt-bindings: clock: qcom,sm8250-videocc: account
 for the MX domain
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260201-iris-venus-fix-sm8250-v2-1-6f40d2605c89@oss.qualcomm.com>
References: <20260201-iris-venus-fix-sm8250-v2-0-6f40d2605c89@oss.qualcomm.com>
In-Reply-To: <20260201-iris-venus-fix-sm8250-v2-0-6f40d2605c89@oss.qualcomm.com>
To: Bjorn Andersson <andersson@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, Taniya Das <quic_tdas@quicinc.com>,
        Jonathan Marek <jonathan@marek.ca>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Bryan O'Donoghue <bod@kernel.org>,
        Vikash Garodia <vikash.garodia@oss.qualcomm.com>,
        Dikshita Agarwal <dikshita.agarwal@oss.qualcomm.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Stanimir Varbanov <stanimir.varbanov@linaro.org>,
        Abhinav Kumar <abhinav.kumar@linux.dev>,
        Hans Verkuil <hverkuil@kernel.org>,
        Stefan Schmidt <stefan.schmidt@linaro.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
        Dikshita Agarwal <dikshita@qti.qualcomm.com>
Cc: linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-media@vger.kernel.org,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=4611;
 i=dmitry.baryshkov@oss.qualcomm.com; h=from:subject:message-id;
 bh=1ki1Bg2wVBxPRRsl6mVjpi8HB0xkrxipGcALh4K6IgU=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBpfy+k+E7nliqC/tQLpcL6CgGG/FY0ZWVmZM7Pe
 2N2trNxc52JATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCaX8vpAAKCRCLPIo+Aiko
 1fxnCACE6iMDwLTdqsEJLhMI2whyvAq5n+x2xnXU7pfyfyKDMEA824OazFhEVtsI4Y97mWe4mLZ
 98ujHL24NJ9Ee+Jb3Vkwx+dJm9M+h3WdLnPlhFVHksQJtgdgL0EIfMvMR7woSZFXFL48i2rd3KH
 e4a8lcptcmoTiaNof67hiKfADjme/B2EzMswL7HEEsLbMhk4fEScLSrUXuJiLniz5LTN4o67N0G
 CdI4pjPMB/2fvzkNZmLdzgtAb6p5cSCsASNz8vDtbkUq/KZN2roBK9A5UK8hYPCrg3yR6aNb0a3
 KIrXkDrXfyDH68cvwLHwopd/oFwQy9pQPj9avy92FdhW4Q3t
X-Developer-Key: i=dmitry.baryshkov@oss.qualcomm.com; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A
X-Proofpoint-GUID: tmqGbv11G70L91AsyM5yhy0fs_jVZXKD
X-Proofpoint-ORIG-GUID: tmqGbv11G70L91AsyM5yhy0fs_jVZXKD
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjAxMDA5NCBTYWx0ZWRfX7/zLrZcJvsJC
 QQGjmEWWY8/RUWPxfJ9U1QnF7L082dqfOCLJHO4osGYD1k0etwJK/MaO9HgwrCYMw2D9PkFsjLF
 jQxI4FHKpbTmrftys4greoGj0UAQPcK/+13FfcundfLPysrXb+q21N8WGk8kQ+g6uLRd5utyBig
 Hz6r3EhfKga216druP3wnmcHeyZTueAwMArX0CDH/Wr5gYSLSvXapzXyPDkG866TOFsuTzXt/hY
 NEUZOFWz65wuCbqlld1rmD2BbzN3zrhSmAzpPZPCjw5u8Gz19At9M8jsEengmwAOKFvPGsfJquc
 gbxOwkXosH/45s1X/sbj1JyStrNglV/uVxlFkaamMgzZno9iTy92+/vLRsrhIAguRsX/aikI/2b
 RpFBC28CilwI7TlLqczklG3RZs3FKTGVejBO7oBKQQpAwouNdbngEIJn9AIvcBeXUgDgcmY1v7r
 9ioGGadsX0fGwJxnAqw==
X-Authority-Analysis: v=2.4 cv=T8OBjvKQ c=1 sm=1 tr=0 ts=697f2faa cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=HzLeVaNsDn8A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=gEfo2CItAAAA:8 a=EUspDBNiAAAA:8 a=COk6AnOGAAAA:8 a=-c0xKrEOHdUQarD6WDgA:9
 a=QEXdDO2ut3YA:10 a=NFOGd7dJGGMPyQGDc5-O:22 a=sptkURWiP4Gy88Gu7hUp:22
 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-01_04,2026-01-30_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 spamscore=0 clxscore=1015 suspectscore=0 impostorscore=0
 bulkscore=0 lowpriorityscore=0 adultscore=0 phishscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2601150000 definitions=main-2602010094
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[28];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-41858-lists,linux-pm=lfdr.de];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[ab00000:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,quicinc.com:email,qualcomm.com:email,qualcomm.com:dkim,oss.qualcomm.com:mid,oss.qualcomm.com:dkim,devicetree.org:url];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dmitry.baryshkov@oss.qualcomm.com,linux-pm@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-pm,dt,huawei];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: AC93EC5948
X-Rspamd-Action: no action

To configure the video PLLs and enable the video GDSCs on SM8250,
platform, the MX rail must be ON along with MMCX. Split the bindings
file in order to provide separate file utilizing MMCX and MX power
domains.

Fixes: dafb992a95e1 ("dt-bindings: clock: add SM8250 QCOM video clock bindings")
Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
---
 .../bindings/clock/qcom,sm8250-videocc.yaml        | 85 ++++++++++++++++++++++
 .../devicetree/bindings/clock/qcom,videocc.yaml    | 20 -----
 2 files changed, 85 insertions(+), 20 deletions(-)

diff --git a/Documentation/devicetree/bindings/clock/qcom,sm8250-videocc.yaml b/Documentation/devicetree/bindings/clock/qcom,sm8250-videocc.yaml
new file mode 100644
index 000000000000..341d3cbb7cbb
--- /dev/null
+++ b/Documentation/devicetree/bindings/clock/qcom,sm8250-videocc.yaml
@@ -0,0 +1,85 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/clock/qcom,sm8250-videocc.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Qualcomm Video Clock & Reset Controller
+
+maintainers:
+  - Taniya Das <quic_tdas@quicinc.com>
+
+description: |
+  Qualcomm video clock control module provides the clocks, resets and power
+  domains on Qualcomm SoCs.
+
+  See also::
+    include/dt-bindings/clock/qcom,videocc-sm8250.h
+
+properties:
+  compatible:
+    oneOf:
+      - enum:
+          - qcom,sm8250-videocc
+
+  clocks:
+    items:
+      - description: AHB
+      - description: Board XO source
+      - description: Board active XO source
+
+  clock-names:
+    items:
+      - const: iface
+      - const: bi_tcxo
+      - const: bi_tcxo_ao
+
+  power-domains:
+    items:
+      - description:
+          A phandle and PM domain specifier for the MMCX power domain.
+      - description:
+          A phandle and PM domain specifier for the MX power domain.
+
+  required-opps:
+    items:
+      - description:
+          A phandle to an OPP node describing required MMCX performance point.
+      - description:
+          A phandle to an OPP node describing required MX performance point.
+
+required:
+  - compatible
+  - clocks
+  - clock-names
+  - '#power-domain-cells'
+  - power-domains
+  - required-opps
+
+allOf:
+  - $ref: qcom,gcc.yaml#
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/clock/qcom,rpmh.h>
+    #include <dt-bindings/power/qcom,rpmhpd.h>
+    clock-controller@ab00000 {
+      compatible = "qcom,sm8250-videocc";
+      reg = <0x0ab00000 0x10000>;
+      clocks = <&gcc_gcc_video_ahb_clk>,
+               <&rpmhcc RPMH_CXO_CLK>,
+               <&rpmhcc RPMH_CXO_CLK_A>;
+      clock-names = "iface",
+                    "bi_tcxo",
+                    "bi_tcxo_ao";
+      #clock-cells = <1>;
+      #reset-cells = <1>;
+      #power-domain-cells = <1>;
+      power-domains = <&rpmhpd RPMHPD_MMCX>,
+                      <&rpmhpd RPMHPD_MX>;
+      required-opps = <&rpmhpd_opp_low_svs>,
+                      <&rpmhpd_opp_low_svs>;
+    };
+...
diff --git a/Documentation/devicetree/bindings/clock/qcom,videocc.yaml b/Documentation/devicetree/bindings/clock/qcom,videocc.yaml
index f4ff9acef9d5..8676c7e22b4c 100644
--- a/Documentation/devicetree/bindings/clock/qcom,videocc.yaml
+++ b/Documentation/devicetree/bindings/clock/qcom,videocc.yaml
@@ -19,7 +19,6 @@ description: |
     include/dt-bindings/clock/qcom,videocc-sc7280.h
     include/dt-bindings/clock/qcom,videocc-sdm845.h
     include/dt-bindings/clock/qcom,videocc-sm8150.h
-    include/dt-bindings/clock/qcom,videocc-sm8250.h
 
 properties:
   compatible:
@@ -30,7 +29,6 @@ properties:
           - qcom,sdm845-videocc
           - qcom,sm6350-videocc
           - qcom,sm8150-videocc
-          - qcom,sm8250-videocc
       - items:
           - const: qcom,sc8180x-videocc
           - const: qcom,sm8150-videocc
@@ -128,24 +126,6 @@ allOf:
             - const: iface
             - const: bi_tcxo
 
-  - if:
-      properties:
-        compatible:
-          enum:
-            - qcom,sm8250-videocc
-    then:
-      properties:
-        clocks:
-          items:
-            - description: AHB
-            - description: Board XO source
-            - description: Board active XO source
-        clock-names:
-          items:
-            - const: iface
-            - const: bi_tcxo
-            - const: bi_tcxo_ao
-
 unevaluatedProperties: false
 
 examples:

-- 
2.47.3


