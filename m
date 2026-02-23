Return-Path: <linux-pm+bounces-43028-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GJC9DVFEnGmRCwQAu9opvQ
	(envelope-from <linux-pm+bounces-43028-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Mon, 23 Feb 2026 13:13:05 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8425A175F1D
	for <lists+linux-pm@lfdr.de>; Mon, 23 Feb 2026 13:13:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 450403081BE3
	for <lists+linux-pm@lfdr.de>; Mon, 23 Feb 2026 12:08:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6A90361DCE;
	Mon, 23 Feb 2026 12:08:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="K8g3z6r3";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="dCz9JM2g"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34669366044
	for <linux-pm@vger.kernel.org>; Mon, 23 Feb 2026 12:08:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771848496; cv=none; b=Ap/CkHuzzTDEYn/j7Ox6o6qtCtBqJNTG5Qn5PNSDH9klEaFuzvufe+ojKZW6yX1euQEN1Ido1GCdSFN/SlPrMcq3c9Uf3ZnKu4ZehGNQ+AkYZOt8ZFnExt+pR/WApPE1VwKhiG8+akP9WM37nkkNSN0H0w/eaQziuAJq2ubZwr4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771848496; c=relaxed/simple;
	bh=vFx3zcq+G1obITePSUcons2gQA0eqU0zhiapnZAxazE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=TcDwaMeIOzNpQceVjJR59Z6Xep9HyXuVoRWa3o2oyx+fqIYoCnn/u+vkpteYvyhp6UH+H7DD+aVR3Gv3C1ViNR78cIxZfqZTn/Ft3oOW9A3535lrz/7bcSqAR/EYUYLL5TNWHT8UTpwgnk8FHzdpFblitxGabSgSXbp7i/o7Zhc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=K8g3z6r3; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=dCz9JM2g; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61NC2jCa3151846
	for <linux-pm@vger.kernel.org>; Mon, 23 Feb 2026 12:08:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	/svfk13y7ieSR4ljEyX1tQi0dsjsat1uLMry8M6o+zk=; b=K8g3z6r3kLgozE6J
	tTdfjOOhlrL9y/PtqmKS1nizlYORwqv0hqY4WiZQzxPj73tGLTlqz1WWdW8tJkZD
	WRE/3QMsMm0c6uNAIxHSx6Z35z8b0wjh/zItH5FlncxwbuyBMSu62/pBXvnnf+ik
	3lfiTB1AdMuaztODkCpq0vfb5PTQ1AoZxtiT1F2UO1Lc55KBWtn5R7iPKO+c7vaT
	8B+2IBTNZN/FJAqk/p7NiR5d3acYjqcGGPzUwOLGoHZQ3cWAaRFxHjM2oyl8Q+be
	zSiuyxDThgC4Aw+TppTcOpTpTt4fKYJsTwwlNx6g2iqenMEZoA+Aeh6LrDspdDeE
	jdDwQg==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com [209.85.222.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4cgpj880ky-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Mon, 23 Feb 2026 12:08:14 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-8c71655aa11so6573694685a.3
        for <linux-pm@vger.kernel.org>; Mon, 23 Feb 2026 04:08:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1771848494; x=1772453294; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/svfk13y7ieSR4ljEyX1tQi0dsjsat1uLMry8M6o+zk=;
        b=dCz9JM2gpO33lqT5X5aLzjQKcsCrgBpLyyQnELhlJTWn5/9APIclAJLFifb+6egf53
         n06JCfHo0QwdX5JeCXNSUm7nhqOqvAMQseE/U2UpxZ0tFNUT+q9hza9HkbP/o5qyaB+v
         PKiw6XMFPrNj/2H482drrpotFaE2oWCC7FEU3UuTSAb+h7dBDU9G5NILPIxwua9V88mj
         WNXkx9bZ0Z2I2+61DM4UClxCYf+kwwwHkKZRo2inJVzA+ax8HWP9QyT5fd6uWaFfqB/Q
         B1ivIdt5JBWEdjWe8R2WOtNKti5F5pG3s6/z5zcimYAYRWlLDhDF5Rsx5KSa+YHXFcfy
         X+FA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771848494; x=1772453294;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=/svfk13y7ieSR4ljEyX1tQi0dsjsat1uLMry8M6o+zk=;
        b=JjzEEaRds0hlb2FCWSHbcBd5GQVIp16OgXjOgtFf6zAPXDMouNO7d13j5pz1ybgddv
         tqWrjQ1kmu8qdoWKuHZltQ5z89Aq/uQ6F7hhvBaF4xNEAnCH7oDy8RHYjNICCBvnRqgN
         OCam9jq5xo/oziEmbOaJOiRkDYk8xM3AVaPspM2LJrR8WeYy4l/YktbXaxlSJSZUF+zF
         o2JfPc1dLeGe4D6SLhjDtgcFoNghLQg/aAX3CNlJJpdtMow55qHmaypaMIUGruOEKugn
         l0AQjDK/UMP5rzqMwlSqFlmpsvnQY3S2FeW3e0TvZSUA0PiuWCVIxyduBNEzu13YVcOX
         zIMQ==
X-Forwarded-Encrypted: i=1; AJvYcCVKPsTM4A7LoI15J9NJE9NjP31Z9ilQbVNoRn9G3sXmOrKdRVLhRADw0a3rbmlcNl7bcxZctnZn0g==@vger.kernel.org
X-Gm-Message-State: AOJu0YyrwUW00vGX0IbtmzJBvecT/SzA+CjsX0qoeKRH3XqsHI1vvPY8
	TSmST7UxtrdAn90LIXc1OGD9AC5yH3Z92dSur+J9T6UkWqZpGbSL7X4wBd3+EhOjj2c8C+A9pdo
	7hT0AUNJx6LXYbHEqKtAgPkJXfbfRKcy/US7rsesQ3YHUGfQ7H6XKZtGPuaoWIQ==
X-Gm-Gg: AZuq6aIEAZLjS1nM2N92bUh1ingeLcQ6eAfLncbTYsJjza2aLOzxazVh7hdD/lTPfB7
	kHobXIJgMfEUBCd+dGVcirmFHiL0QcbaxryvhDazxFtouEwP5/UnX/znCqXstMF5EFNsfSMycKJ
	kmQaZKHreYRjiNUhB2xBXDTNXt9R8yUu5RV1aplZuS8IvPNiKcFX44FpYeieelYu8Tnat8ZeFMS
	tOoBEmZdMGjCz7m/ngNDBkKE5X7YVJjqI5a8jt1H7V53pzmKmnENdfq9TCnGMk+TNE73xP3SvW8
	Nz/+MbkPGmeYzDIwMZMRxmUstku1A+8UC64l/prBRcid01xYo6w57Z1W9lkYT+5hj7U4lA4H3vp
	4gBppClUs1J4D0um41GNrAdX81KZeeQ==
X-Received: by 2002:a05:620a:199a:b0:8ca:44c8:3540 with SMTP id af79cd13be357-8cb8ca8c41fmr917868685a.64.1771848493530;
        Mon, 23 Feb 2026 04:08:13 -0800 (PST)
X-Received: by 2002:a05:620a:199a:b0:8ca:44c8:3540 with SMTP id af79cd13be357-8cb8ca8c41fmr917862585a.64.1771848492914;
        Mon, 23 Feb 2026 04:08:12 -0800 (PST)
Received: from hackbox.lan ([86.121.162.109])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43970d3fc12sm16522603f8f.24.2026.02.23.04.08.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Feb 2026 04:08:12 -0800 (PST)
From: Abel Vesa <abel.vesa@oss.qualcomm.com>
Date: Mon, 23 Feb 2026 14:07:56 +0200
Subject: [PATCH v2 2/2] pmdomain: qcom: rpmhpd: Add Eliza RPMh Power
 Domains
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260223-eliza-pmdomain-v2-2-23fb87eb70ef@oss.qualcomm.com>
References: <20260223-eliza-pmdomain-v2-0-23fb87eb70ef@oss.qualcomm.com>
In-Reply-To: <20260223-eliza-pmdomain-v2-0-23fb87eb70ef@oss.qualcomm.com>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        Abel Vesa <abel.vesa@oss.qualcomm.com>,
        Taniya Das <taniya.das@oss.qualcomm.com>,
        Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
X-Mailer: b4 0.15-dev-47773
X-Developer-Signature: v=1; a=openpgp-sha256; l=1773;
 i=abel.vesa@oss.qualcomm.com; h=from:subject:message-id;
 bh=vFx3zcq+G1obITePSUcons2gQA0eqU0zhiapnZAxazE=;
 b=owEBbQKS/ZANAwAKARtfRMkAlRVWAcsmYgBpnEMmgc+LSgjrrCwaLVdCWvsqig0JuuSjhArRS
 ir7yqGuePiJAjMEAAEKAB0WIQRO8+4RTnqPKsqn0bgbX0TJAJUVVgUCaZxDJgAKCRAbX0TJAJUV
 Vq8PEACs6VK2c92PkxYnOLsfBky95fuRGU8aKBAe23RN0TREi4nR/UKx7QfVXdsgx5Slm/+zgkQ
 Mg72mwuAJv3fqNJTIlEVAz7epRmshKeq9bjOxFnE8sKwf0l29it7X7EacDKMAYDvpa1/bSboJA3
 Rlhw0jeIVXwiaO7I9vyjNpQAr3rtiZ5aZIeE1SfYDnrcSUc8CQ3GDay7HsREW1000fSLxKAgwcN
 Dx7SLVTgV277CwxReopPOVEaQg1RO8vgDQqT3JKsacqSEEZpijx3PNtypcOVVeSg1XzX4GEoSCD
 AXC8yfQVbn6uQUmgSbEj0+dtVlh6Ou35THUSixV5J9kEpMb6vsLmiFE1yMjPX8dkuDYh9LVFDTh
 KxMEIuHW1qs8yp4uG4R/Me2ZdaCABQ/ClQdyYNevMMfHSSlnjlMJv5WeRH8CF20AsLAgJ0lEHMm
 0iAGcAlegFcMlpWoVRfkeVyvtmfTxC0IVJUcIG0pAOZnStt7dow8iVF9vb3rmVa1olpJMM8Sqn9
 nDxk/qOiL9zxRdM3kLUhXbZjNdBhJbgULe0GQsSh0NUsX5oQoAfB6wj/rDn0FV30DJA8ZMJw4Kx
 DYPn/Sy/XpwgSgUDDwtgjwpFO6H7Gr9OiiHLGXU4CNMMp5ALMJNiuNyDpQUHiyV6GVK6IEgLu/q
 e6al2wjhA48BI6Q==
X-Developer-Key: i=abel.vesa@oss.qualcomm.com; a=openpgp;
 fpr=6AFF162D57F4223A8770EF5AF7BF214136F41FAE
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjIzMDEwMyBTYWx0ZWRfX5iVRkrW9s0pT
 G45NC1uuhe+6u37KMakUDhgcJrZd+CTpxacElpb6OINlbpJgNcfAKb370RN4Qgykb+cs3+3Mygw
 Je8gk/yrmrAOuCubLXg4OAEBV01RjNAPrJ4D5rPIhiwhEgBPkNJ5KDMmnVK5qAqfvZVUGWXNcOy
 aK5R1PdfdpxjfJzIrn5TEIBJ2fhaDN2TJmMI8aPLzTr4XtZJPbbKeIwdyflmKN5QKAR9f0abBmu
 PxmSu8+MCzqEqnc8qXYt014el+fcq8lVMM6LaWUlgdjNAeT/rb6AFC0nSKflztOTlB28wUfJ1Bx
 MOdsb26VVSUd9m6JNdCTACnEeu8g3m5NDCk8WNwhM2rkm3GzwE4aqz0y2LR9otxxX1XEmKTFPSV
 0HHttVgy3Xl9NHSERsk5GrWNCpLw3opy6aT/VgNj8CMTV0x8L8huJ28s+6G80tUClofumLLlhUM
 OTnZWueNInJuUZDdirg==
X-Proofpoint-GUID: V_ARqAoB79f1byVLjrxeGr4_0W0Ptb14
X-Authority-Analysis: v=2.4 cv=Z5Lh3XRA c=1 sm=1 tr=0 ts=699c432e cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=oauzzCmhM186DRC0Y2yWPg==:17
 a=IkcTkHD0fZMA:10 a=HzLeVaNsDn8A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=EUspDBNiAAAA:8 a=dWhSLnTLbNPvjsjzFE8A:9 a=QEXdDO2ut3YA:10
 a=NFOGd7dJGGMPyQGDc5-O:22
X-Proofpoint-ORIG-GUID: V_ARqAoB79f1byVLjrxeGr4_0W0Ptb14
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-23_02,2026-02-20_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 suspectscore=0 bulkscore=0 adultscore=0 impostorscore=0
 priorityscore=1501 phishscore=0 spamscore=0 malwarescore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2602130000 definitions=main-2602230103
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[12];
	TAGGED_FROM(0.00)[bounces-43028-lists,linux-pm=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,oss.qualcomm.com:mid,oss.qualcomm.com:dkim,qualcomm.com:email,qualcomm.com:dkim];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[abel.vesa@oss.qualcomm.com,linux-pm@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[linux-pm,dt];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 8425A175F1D
X-Rspamd-Action: no action

Add RPMh Power Domains support for the Eliza platform.

Reviewed-by: Taniya Das <taniya.das@oss.qualcomm.com>
Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Signed-off-by: Abel Vesa <abel.vesa@oss.qualcomm.com>
---
 drivers/pmdomain/qcom/rpmhpd.c | 26 ++++++++++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/drivers/pmdomain/qcom/rpmhpd.c b/drivers/pmdomain/qcom/rpmhpd.c
index 19849703be4a..89d9c251df38 100644
--- a/drivers/pmdomain/qcom/rpmhpd.c
+++ b/drivers/pmdomain/qcom/rpmhpd.c
@@ -217,6 +217,31 @@ static struct rpmhpd gmxc = {
 	.res_name = "gmxc.lvl",
 };
 
+/* Eliza RPMH powerdomains */
+static struct rpmhpd *eliza_rpmhpds[] = {
+	[RPMHPD_CX] = &cx,
+	[RPMHPD_CX_AO] = &cx_ao,
+	[RPMHPD_EBI] = &ebi,
+	[RPMHPD_GFX] = &gfx,
+	[RPMHPD_GMXC] = &gmxc,
+	[RPMHPD_LCX] = &lcx,
+	[RPMHPD_LMX] = &lmx,
+	[RPMHPD_MX] = &mx,
+	[RPMHPD_MX_AO] = &mx_ao,
+	[RPMHPD_MMCX] = &mmcx_w_cx_parent,
+	[RPMHPD_MMCX_AO] = &mmcx_ao_w_cx_parent,
+	[RPMHPD_MSS] = &mss,
+	[RPMHPD_MXC] = &mxc,
+	[RPMHPD_MXC_AO] = &mxc_ao,
+	[RPMHPD_NSP] = &nsp,
+	[RPMHPD_NSP2] = &nsp2,
+};
+
+static const struct rpmhpd_desc eliza_desc = {
+	.rpmhpds = eliza_rpmhpds,
+	.num_pds = ARRAY_SIZE(eliza_rpmhpds),
+};
+
 /* Milos RPMH powerdomains */
 static struct rpmhpd *milos_rpmhpds[] = {
 	[RPMHPD_CX] = &cx,
@@ -795,6 +820,7 @@ static const struct rpmhpd_desc qcs615_desc = {
 };
 
 static const struct of_device_id rpmhpd_match_table[] = {
+	{ .compatible = "qcom,eliza-rpmhpd", .data = &eliza_desc },
 	{ .compatible = "qcom,glymur-rpmhpd", .data = &glymur_desc },
 	{ .compatible = "qcom,kaanapali-rpmhpd", .data = &kaanapali_desc },
 	{ .compatible = "qcom,milos-rpmhpd", .data = &milos_desc },

-- 
2.48.1


