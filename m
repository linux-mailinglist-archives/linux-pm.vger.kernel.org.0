Return-Path: <linux-pm+bounces-41549-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WGycA5/eeGnytgEAu9opvQ
	(envelope-from <linux-pm+bounces-41549-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Tue, 27 Jan 2026 16:49:51 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F03797146
	for <lists+linux-pm@lfdr.de>; Tue, 27 Jan 2026 16:49:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id D0A9F30DF0D5
	for <lists+linux-pm@lfdr.de>; Tue, 27 Jan 2026 15:28:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F2EE361DD4;
	Tue, 27 Jan 2026 15:26:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Fa5sMzRE";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Ehd0aGn5"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D491361DA1
	for <linux-pm@vger.kernel.org>; Tue, 27 Jan 2026 15:26:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769527594; cv=none; b=S0wLZtX80J3y3gdtRzR+3p+wqsEbLT+k0Bt3FSuHSNNiImMsrsecyfd6wJJXpLL2eIUXfneDgdKYPJMqDJsSyRgqpkPrjlz4ZUrwysj5/ZxTxkM+n0tfWuPSkH7nKBmY+P7juaZKuYNpP71Xlf7gDgJvwtAQpz2GnpyesKtNdpg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769527594; c=relaxed/simple;
	bh=EgqLcXuTlGZv2agsjvJlq+LOofnAqNhpL65qt3SuLak=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=P7hmZoo8jkXOXAjDiMeEZQgxM5IFf0k2UXpDB9yvnOefu2IG1UtcslexUMCaZabdHzTQ66WQculc4e/DeFzgfcK0yHEtolv7FZQJt6xfLs7EXf2U+lc3j/wrL5PCVYnGbT6h2Y4iXTEceuX3dpiomEvyRcThxiYNvpWTLZi2/BI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Fa5sMzRE; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Ehd0aGn5; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 60R9qLjM1268770
	for <linux-pm@vger.kernel.org>; Tue, 27 Jan 2026 15:26:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=H/d2bi3+JkpzVQUWLv9/+M
	MlTlvgE/L0hzA72n4pIyM=; b=Fa5sMzREWyXigzcGfSu3gYn6f6Ux/Mm6AHkSo2
	9MjDsJn0nptwLZhoOCU5ksqdAImMfWjNhwtp7oJUPCKuX5uTQwqENW4eGsA7imTH
	xFfm/J5Jb9uYrBYJKliqusVcllb4SAZ6WSntlAgeZqcevzl2k51RwC1dKcrZUPJO
	rXwG8AvE1b9I3YsutcZKaUo31aE7zDQdRtrRwG+PpIxeoYPyF7jfzOTKGtBM5F/b
	0cBhEfmGtCzKJ+J1SHD6mpRyfPSw6xstDtPaY99W1znCVRgYZ5IXAz+dOsbfvSid
	0zmzsekHGYKOSYxIQo8bMprwnW6OqZA745HP/LgOAPDH8t4Q==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com [209.85.222.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4bxnyat75m-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Tue, 27 Jan 2026 15:26:31 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-8c70cff1da5so132549885a.2
        for <linux-pm@vger.kernel.org>; Tue, 27 Jan 2026 07:26:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1769527590; x=1770132390; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=H/d2bi3+JkpzVQUWLv9/+MMlTlvgE/L0hzA72n4pIyM=;
        b=Ehd0aGn5yRhGGTqS6GV9X5ru6aThFv9X/Pkf+U07iXAlMVsW5Mpi8eL3jyBCa8HJ9m
         kXIlg8A17Rd+0Mpr+l612os4F7fg2biLgNbgaTaYZWDlJ3KtJbKggNMGnEgNilT1yF/n
         Uoi7qO5UyY1no8tvKuJ9Prhg4mu6cSKBJDOlsl25nKAGmXIl9ZdSDoNWvaUh4lhKxVUN
         opLTSeFCB5g+VvZOrog7XLbtaKj8dAJ2306UV6P3sMoBYK5ir5jRY6KRtulTikiFspMB
         QDxJC2GexjkhoH1MXKTJjSoHTMZhyMzHlp3uUdsyJL9oioPzbmy/EnJPWBvBMWd2UrpJ
         6E8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769527590; x=1770132390;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=H/d2bi3+JkpzVQUWLv9/+MMlTlvgE/L0hzA72n4pIyM=;
        b=a5wBs3IxUuPbp5Nfy/IcIE9PvGynbgFOb2g2pMOlThaTK/rv+FgFqFgC5fswBBv4zm
         XAK11d3zgMNXNVDXOWnanuzWVrflnNDRhAk9hLIVh8qsWU92Pm1KUJKHXEJvPNiKMWr7
         Y5hxztJccYrldiv7t/e1jG6shZC4VZrow0XnE9wsC8qe2DvwtDUpSAzOmmeF4mFfMdIw
         fUX3MVoDsiabZlFU+nn3tEdE8xvsMPJw+RRTJkLQaD2rzru/LU7ffkYOLOH7ArLjPK2h
         pmFTCXYtqpyyOgeeNE8d0iKI290/8h9bLcL2g1uhOazmlauRPUASYvlWBjrFDiNhVDOR
         fFEA==
X-Forwarded-Encrypted: i=1; AJvYcCViHWSTf2dFkrtxEx6fb8vyMTLI03KQMoI7oty2AJtQypXh//taGsvrpdJ8Oky+VsRaRDjBo8YTTw==@vger.kernel.org
X-Gm-Message-State: AOJu0Yw5ykEno1YURwSYDBllVVicC3Ff8XB3z67ASbXyqoiRnVHWp3jV
	h5hwfYN2mM/ox5Co6Ekhp0yiUv5GcO1KzxXxM5OJgTYVBY2gXUIRof3vTd0s97gzpiC3pkBlh+z
	+8/YP/EVlDAfbwajCs0cvyqcYByYSjhe1ynMH2397+NAMQLICrMgLCqjoBvYnok6xCQLfFQ==
X-Gm-Gg: AZuq6aKpL954w5BmgnHauypsQx+RbY2issBsMBRUhTKFZsyKl/eyTIhdWW6vwV3KDnr
	NlBgkTqL+hEjJGork+7qEA01Z4RPrciobMfrDZMNmwiIfvOszWafRM4o5n8Was1tnVVAJFaSQ/F
	5QWwPyF1dCMDqwF1N6cGkl/syx6LDQ2Rw5VQoBgHXulB1sFGF7979NxjA6lYMOSTk6/dQMKvzHb
	6lsGOyUFOz0uM+e/BvzULcEHEXpXehaQ6MkdDJMnL+4LtCQPYDdhKkp33iXKQSAcuM/Ub3x55PE
	OrpNz+2bdENA8OKJvZ4OWRJtUG0sGAWcYjH3/oWr4H2ONCKPm4teeXnpBZdGYVh0VHfJR0/JzUs
	IoG+FZDXCGjNhu29JWQ==
X-Received: by 2002:a05:620a:2984:b0:8c6:b19a:5a46 with SMTP id af79cd13be357-8c70b8d142cmr248708485a.47.1769527590078;
        Tue, 27 Jan 2026 07:26:30 -0800 (PST)
X-Received: by 2002:a05:620a:2984:b0:8c6:b19a:5a46 with SMTP id af79cd13be357-8c70b8d142cmr248700585a.47.1769527589206;
        Tue, 27 Jan 2026 07:26:29 -0800 (PST)
Received: from hackbox.lan ([86.121.162.109])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-435b1f744e2sm40967260f8f.31.2026.01.27.07.26.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Jan 2026 07:26:28 -0800 (PST)
From: Abel Vesa <abel.vesa@oss.qualcomm.com>
Subject: [PATCH v2 0/2] interconnect: qcom: Add Eliza support
Date: Tue, 27 Jan 2026 17:26:16 +0200
Message-Id: <20260127-eliza-interconnect-v2-0-b238a8e04976@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIABjZeGkC/32NwQ6CMBBEf4Xs2ZJtCSqe/A/DAcpW1kCLLRCV8
 O8WvHuZ5CVvZhYI5JkCXJIFPM0c2NkI6pCAbit7J8FNZFCojihVJqjjTyXYjuS1s5b0KOpTZsw
 5V1mTFxCLgyfDr330Vv44TPUjqtvSZrQcRuff++ssN+/vwSwFCpRoDDYSURdXF0L6nKpOu75PY
 0C5rusXzlr1oc0AAAA=
X-Change-ID: 20260123-eliza-interconnect-b73ff8523d59
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1059;
 i=abel.vesa@oss.qualcomm.com; h=from:subject:message-id;
 bh=EgqLcXuTlGZv2agsjvJlq+LOofnAqNhpL65qt3SuLak=;
 b=owEBbQKS/ZANAwAKARtfRMkAlRVWAcsmYgBpeNkgNa/0D3eJGsl1tdMo8j5ZENDAM2/ohfFJb
 Q3u4HMTGK+JAjMEAAEKAB0WIQRO8+4RTnqPKsqn0bgbX0TJAJUVVgUCaXjZIAAKCRAbX0TJAJUV
 Vt8pEACJ1wNstEMFb9EZ8hWPGNm3OoroJ/a7pouLwqR7GPZQEGIaHgw6ZXrJkyjweHWlppqssEt
 Ql4Afc8DezPhYcvqUhS3RyewpUcknsEMCjmaL80ysDcZZzh7Y+gxvcvtRz/Xdn8iBxIucEyqCsN
 kcV9AvS7mNY+HP2gSI5TD/NcqjD6Sd2c+2SXQ5g5Ty3vsFTaX50MsHe52qEgoA/Kst+1CIteCJw
 V+XkUqaE3dsr4yXjTIdxLOXsx0LTNlq2/72iXyTvfs54hzY8j7/I9nWK6DdeQebWh42LqTNnd6u
 rpaVouCvq5bmCbDKH8Gh4ErrIv0k72JOnS9lX9l1RAyk7xabB2Uz276IFawZVXMUamr4qBszVGi
 JmH3a20bIzTa7KzoEkUqvPdS9uOPxzr1rrEEmoKPZHOfFuJXCJuGkuJuWC7VebVvWN+2j4QPH9U
 mR/EZEW4wJ+PrM/p12cCr8gK9MKaApIfhqZOlpl2bCddclUY7GZVmRGNq/NIr4XmpiDOKeL724M
 HUiHY0vmzzg5vxTK1hdlmp/bMzAHLp2qISgISgwbLq+5f0LwAP20Lk+FcNYScC2A13fabmTSI20
 MZ2bVg7LFQfOeXZwqWf79MzmH9BdV12U2si3fvQQlVN53ROx7wsaMXVm6IdOrpEA1LVmTQoRj3Y
 ia4UPSF1Nw/qzDA==
X-Developer-Key: i=abel.vesa@oss.qualcomm.com; a=openpgp;
 fpr=6AFF162D57F4223A8770EF5AF7BF214136F41FAE
X-Proofpoint-GUID: wBnRhUR4Sm4p2t1WqkKJ84bjAfjkWsyh
X-Authority-Analysis: v=2.4 cv=JZqxbEKV c=1 sm=1 tr=0 ts=6978d927 cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=oauzzCmhM186DRC0Y2yWPg==:17
 a=IkcTkHD0fZMA:10 a=vUbySO9Y5rIA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=bC-a23v3AAAA:8 a=EUspDBNiAAAA:8
 a=uy7x88RTe6HEIydgH8AA:9 a=QEXdDO2ut3YA:10 a=bTQJ7kPSJx9SKPbeHEYW:22
 a=FO4_E8m0qiDe52t0p3_H:22
X-Proofpoint-ORIG-GUID: wBnRhUR4Sm4p2t1WqkKJ84bjAfjkWsyh
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTI3MDEyNiBTYWx0ZWRfXyqNYe13Aifya
 fIKladLNuO/4cQN4jH0qCVODdZkDstjJ/AdMGPkNUGeX88chSWpfqyrpA2Y0kggWzyjcGfWQ8/G
 4OZ8vAXXqATv2xH9oO5tErQQKXuZirYy0D/whGs3SE5AjtlCxjzwvfbUilxKHUXjmLR0DO4CTrS
 RNyuQ8BRbznlzbcuugfbZW8GzixylbDQWq9j+HQH+t8y0f82AHvzI1YVM/SlrR3AlopwyzoxavC
 Iwk8KuOuKiLGVNVT3UBXkFCd7sRMM97XwnOAziCxRRDnFaeQ8DW9yUlCYf5zlIHP35GKMFIjE2q
 fRh9JTQuu8ZAuWk7nXXctKnHzkSyy70tc5M+Iu0YTDjtpHyKNd8MpQ50/p5S/HHefcU+6s/XtHT
 ZFhct2c6n9c2cfM4GcLeOt+arPqgWuCKfA0V6z2KDI1w3JJcEx4FfJxaCjSyaKig+gvfff2vXfL
 aUwhZbqnUMHCr1EOIYQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-01-27_03,2026-01-27_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 impostorscore=0 suspectscore=0 lowpriorityscore=0
 malwarescore=0 spamscore=0 adultscore=0 clxscore=1015 phishscore=0
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2601150000
 definitions=main-2601270126
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[12];
	TAGGED_FROM(0.00)[bounces-41549-lists,linux-pm=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[qualcomm.com:email,qualcomm.com:dkim,oss.qualcomm.com:mid,oss.qualcomm.com:dkim,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,msgid.link:url];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[abel.vesa@oss.qualcomm.com,linux-pm@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-pm,dt];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 9F03797146
X-Rspamd-Action: no action

Signed-off-by: Abel Vesa <abel.vesa@oss.qualcomm.com>
---
Changes in v2:
- Picked up Dmitry's and Konrad's R-b tags
- Replaced the all-caps SoC name everywhere
- Dropped extra empty comment line, reported by Konrad.
- Link to v1: https://patch.msgid.link/20260123-eliza-interconnect-v1-0-010ff0d100c9@oss.qualcomm.com

---
Odelu Kukatla (2):
      dt-bindings: interconnect: document the RPMh Network-On-Chip interconnect in Eliza SoC
      interconnect: qcom: Add Eliza interconnect provider driver

 .../bindings/interconnect/qcom,eliza-rpmh.yaml     |  141 ++
 drivers/interconnect/qcom/Kconfig                  |    9 +
 drivers/interconnect/qcom/Makefile                 |    2 +
 drivers/interconnect/qcom/eliza.c                  | 1585 ++++++++++++++++++++
 include/dt-bindings/interconnect/qcom,eliza-rpmh.h |  136 ++
 5 files changed, 1873 insertions(+)
---
base-commit: 615aad0f61e0c7a898184a394dc895c610100d4f
change-id: 20260123-eliza-interconnect-b73ff8523d59

Best regards,
--  
Abel Vesa <abel.vesa@oss.qualcomm.com>


