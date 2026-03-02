Return-Path: <linux-pm+bounces-43406-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MI6RNyySpWmoDgYAu9opvQ
	(envelope-from <linux-pm+bounces-43406-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Mon, 02 Mar 2026 14:35:40 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id A0C9E1D9E1F
	for <lists+linux-pm@lfdr.de>; Mon, 02 Mar 2026 14:35:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 627D5309C9EE
	for <lists+linux-pm@lfdr.de>; Mon,  2 Mar 2026 13:30:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFEE03EBF02;
	Mon,  2 Mar 2026 13:29:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="EuVDjkhn";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Qgx4MtIQ"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3F233F23A9
	for <linux-pm@vger.kernel.org>; Mon,  2 Mar 2026 13:29:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772458185; cv=none; b=Q/OB3zxrJyGS5sLlE+3kNzFt6nl5a0Qia00ZCSQh5FOLHsOiNPm8oTbDTmSzSyIX7HpIYfCwMerD86ymVQV2yF3xqs6Nsev4Y+Qv47r+sZxb0zvPaBorwnHMSRiwDoZdLbz97KWzOCAOta3Zpd6+XJexUDPgmCGnZoD4MCSuAU0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772458185; c=relaxed/simple;
	bh=fi6uaGAmA7DGVwWvrmCtmISOorGGj07N/O3QqrUNVOQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=a9ewEINa4BrIw1ip6WXHrpPQTdp72vCMvv2gLn/JAoptZCe5IW6izoQTt/W0krgKt40dZSeHXWVpa9+LK6CnIvZYD0iSuemMUqiQ0UPGbLR050hQb5OcyyIn6Kqkk/97y4+bhHKJiMXC2FWAo3XTfizA52+eeO8mue3jEKgVR88=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=EuVDjkhn; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Qgx4MtIQ; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6229EwKR3630903
	for <linux-pm@vger.kernel.org>; Mon, 2 Mar 2026 13:29:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	3q16zfx2mmMwO27Q7GQOWC8LUecL6PAFePZk/OZ8ti4=; b=EuVDjkhnsfk8r12x
	KlYsWA8xBKRzeQfEqGI2eQTTC0o0NYoqBcLSEgfxe0Wx9+jStVK/hY4x1tN4Xwjo
	EYyoK5cTzR4RCeLocliv1ooDuAkyGIcjKi6PU0+PjvcVjL5m23QPTgCj/OG72sQu
	2m0CP3lDAlg8sr+8eoBAdCxpeTdvAXFvbiMwfjQNXfBh2TY6K0mW9xUDyIP1RSal
	uphQK3gwVS44BOi2/fei3MZ4/qudiujhgRGV6ntll/64C6D4G4odqkEq+pSguLMR
	4WsGJGbCLe4/XzFb2oaZArhlASghBPjAJWTJa/OP5Fcp1TwexRMN+FkPmixc9O6K
	eBarDQ==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com [209.85.222.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4cn7rhrted-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Mon, 02 Mar 2026 13:29:43 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-8ca3ef536ddso4306004485a.0
        for <linux-pm@vger.kernel.org>; Mon, 02 Mar 2026 05:29:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1772458183; x=1773062983; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3q16zfx2mmMwO27Q7GQOWC8LUecL6PAFePZk/OZ8ti4=;
        b=Qgx4MtIQYEY6i8CVkhCPDG+Pr2KTd7AhpmvBERnJ+3+rX31xMoZN7PsN9nDFTCxPyp
         pfV1TB33d+SXpKsf1wqQGTgs16nYR7CcZoA9MgIXtKN7z7cGqsLAc56saH4v0p440QHQ
         TT3QgU+vlnCyYmnSTWW8VaxpUubsoKsmWA+lNrhuz37fhnJANVYEmrxPzTAh3K5kWUJi
         CTRWqVxvEH3LQ8VJCehrsuWa4DWgC6jVCk32A/ZhUP9CHB5Q0o4aFxwxP3mEsk/ztQx2
         7Wa5uw6ArGkXZ1y3q+xhea1vNjQxfvp5zjGzuRCdlNwRrdVsVBlKhvjPHhaxzwh5Tspu
         U+Kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772458183; x=1773062983;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=3q16zfx2mmMwO27Q7GQOWC8LUecL6PAFePZk/OZ8ti4=;
        b=fcXhNZBeWrNqFavE8LwRfYQbbaZZVVuEIxbvK9aHiFPUNV44zg15Sw1AxMAzHL9h03
         yUDAF71qHIPm4buXXUbPUs9zgtRCFokhxx8LY5llb60yLqClEdwEPRxQspTER5mgLIwm
         whFnpiEfLBfezNJ5lReSNa4CIkQPaouFQu5EnBXRT6lPOqaIKiWCL/XvKm4NHcqkDw0n
         vNA+YTVXBpxjKL06UxVNcS5ydwao/6MLUds8EPLoJTJEfLaWC/EqZ7msKkwbY20Uhbh0
         x30vD98hzPjbCOjTohhvLtKynK8rczmTuD57h6ot1G3NmpsGcyVLz4nmRsN+EXwANx9r
         BRWQ==
X-Forwarded-Encrypted: i=1; AJvYcCU6a9ig2oiNFb3HkhHAQvwTLmy/PqOq5FcJNh6DfU6oOUNOpzD2/2B7WsKq3n0Euv+kE2zI0OC7iA==@vger.kernel.org
X-Gm-Message-State: AOJu0Yw8JWQGp/Y/fRDjFT9xCG2NXOUi4scYE6BtHHyJKD1ary+zBEaO
	Uidm5sFepwdugQM/2VBRDpTFghXSp+4Qro3pH4o3aB9KleXmf5Akp2Jb4ReZb35zg8bYFLlBaNt
	8MrrRlPEnB/3ncgjOguOCQHYaS3Vhk0Qmb1Wwy28B7S5Ec5dZMZUbuQ1dn3ZpoNqD5fe4nw==
X-Gm-Gg: ATEYQzzcr/oNhWuuGaXhAt+2uiUnlA/kRbX/s38gBt7fdOH+eMpQ9sCxQVPv8rMssvD
	ES1kpqv3hligg5dnLIfk4ItNtslYoVcaAoInWN3TE4p4dvbnCG9qzLEKMAJy2a2qbeFZeaG3mvd
	onInUD5n03hxSDdx7TG1Vw0aM89umR1Oe88rImtynK4R8zjPJfc2WJg4aUr2Cy/ux0UojjaByUP
	9rBm9dLu+yzFUzb9OxmTyzYPr7wa5+cy3sIAHy8q3W2a+8X461YjT3hHBuQpzpX/yWDgCXjMDPz
	z40rhb4CndzT1RUolT3TRUo5FZ/aqcR5SY9z4XDPSd7c3kWFFoiZbbkSwvQLio7JmZf9wnH5d08
	5Kf0tZBAA4b8v6DZoEJN8BBzV4ZZ/Fg==
X-Received: by 2002:a05:620a:bd5:b0:8cb:79d3:e925 with SMTP id af79cd13be357-8cbc8e3452emr1645424785a.69.1772458182677;
        Mon, 02 Mar 2026 05:29:42 -0800 (PST)
X-Received: by 2002:a05:620a:bd5:b0:8cb:79d3:e925 with SMTP id af79cd13be357-8cbc8e3452emr1645421185a.69.1772458182007;
        Mon, 02 Mar 2026 05:29:42 -0800 (PST)
Received: from hackbox.lan ([86.121.162.109])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-483bfcbf894sm133471575e9.16.2026.03.02.05.29.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Mar 2026 05:29:40 -0800 (PST)
From: Abel Vesa <abel.vesa@oss.qualcomm.com>
Date: Mon, 02 Mar 2026 15:29:32 +0200
Subject: [PATCH v4 2/2] pmdomain: qcom: rpmhpd: Add Eliza RPMh Power
 Domains
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260302-eliza-pmdomain-v4-2-e61ae2bac805@oss.qualcomm.com>
References: <20260302-eliza-pmdomain-v4-0-e61ae2bac805@oss.qualcomm.com>
In-Reply-To: <20260302-eliza-pmdomain-v4-0-e61ae2bac805@oss.qualcomm.com>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        Abel Vesa <abel.vesa@oss.qualcomm.com>,
        Taniya Das <taniya.das@oss.qualcomm.com>,
        Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
        Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
X-Mailer: b4 0.15-dev-47773
X-Developer-Signature: v=1; a=openpgp-sha256; l=1798;
 i=abel.vesa@oss.qualcomm.com; h=from:subject:message-id;
 bh=fi6uaGAmA7DGVwWvrmCtmISOorGGj07N/O3QqrUNVOQ=;
 b=owEBbQKS/ZANAwAKARtfRMkAlRVWAcsmYgBppZC+NjlEc/Gq4ukFIlWLdFD37vGyEGDXgrKM3
 gjPHBOruk2JAjMEAAEKAB0WIQRO8+4RTnqPKsqn0bgbX0TJAJUVVgUCaaWQvgAKCRAbX0TJAJUV
 VibSD/4hmGCXyP29o7PqJ6x0YPS/ktFXkHcTVNhvyw+1J5MCFnxnW4WzxcVFBZNvWOI0ZsQ9RPe
 y7f6IA/sZSsSQTe5l/o0CMasppM0mUvS4zelZhSI8abTzmnfYed+NONdiR3Wp9aZomHv4sVBYdU
 b5YT4SwyYkPRGW3EMGlkDXjrC3KUvWazh3sA7o+WZkIW1xf5iSsnWIPv52hspNG4JU84U/FV3Cl
 HBfMbgMyr8ZzQzespwnVDJkbr4wtShreYmj49sXa5xg4sVuc9WJNFWH/FEh5i1In4f2Eq/LGn9M
 08kNJpQKoEz36N+KjrExY6ACsQ4JsWTtt0LgNhgzJeDxdiA4+Kg+vufmpZrpoi4sxC/hlGKn4se
 QLikG/1l3eoXIlH4iUIbX8nwA7x4wJwAsDYGVlReGBpJp+crZtHjnFkRV9DOWP+bbIkpHErCTAE
 dA0rAb9snTkutbZYtP6eg/mTMl0c5RkGw/OVoTvzdQb3lC5OMnajQPURZAWcKSbjjX1j34IbXKe
 MyoGHDLIWazuz5DFSipTZs5bnLms08COos3CWxk+phjbPHNAd+GEvN/6aJH3G8amXXH6n9RNb6l
 iyEYHQS7bfIE1fFbrQMxfaMBtANmiICzmYLZRZCjnRO96mlrtAQK1d9C4OaOANlrm/ktnkHhXI2
 vQETPVEM4VeDG0Q==
X-Developer-Key: i=abel.vesa@oss.qualcomm.com; a=openpgp;
 fpr=6AFF162D57F4223A8770EF5AF7BF214136F41FAE
X-Proofpoint-ORIG-GUID: wM_UpWMpAPQDdfF6oW2skWvYbsAOFOHn
X-Proofpoint-GUID: wM_UpWMpAPQDdfF6oW2skWvYbsAOFOHn
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzAyMDExMyBTYWx0ZWRfXw7UdUkrjetq2
 U8KkiPz2loljKSYt/6rxYkLnixn5uega7e0Po7gW3/pzbQS85QLHUkQfrNY55EcZJsuz6he3pfx
 kjLkoumQiVeeWHsJuDsP6wMPo1Uu0WxsVNatnVq6MeOexxXfES1oN4UnjDtq9A+eH6ZwZML+gpB
 Zl/nkPp5JqsFXjaIA5uvnAanWLXr1Wk9wrxU4v8UrHEiDrRohekXG8nVNbz32c8CrCEp4vjvM9q
 jdrgOtGNdUF5kTCIhTlRWjZEIXbiq3ax1GFju7ClZbGTtqWOUT3oleB5YjhmrVtIMfx+VqtSF/o
 u7EwlbwCq9XyhbLM1SnO8CJae9Q7ZwXx1znyJUfEcAEzuu3jXoIsfcHqmUlxb3mD7U/YgpUzIUT
 VLt06GnnrELVef0W8YzZguYfMQAKXcQc1BgxjS8gRA5DJwX5jqpV4NajCeI/2a3Cd35DS84XDDp
 XvUVZPV4yEN8rgSo62w==
X-Authority-Analysis: v=2.4 cv=cLntc1eN c=1 sm=1 tr=0 ts=69a590c7 cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=oauzzCmhM186DRC0Y2yWPg==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=EUspDBNiAAAA:8 a=QNDN7hzWmUzYeR32aaAA:9 a=QEXdDO2ut3YA:10
 a=bTQJ7kPSJx9SKPbeHEYW:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-02_03,2026-02-27_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 malwarescore=0 bulkscore=0 clxscore=1015 lowpriorityscore=0
 impostorscore=0 phishscore=0 spamscore=0 suspectscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2602130000 definitions=main-2603020113
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[13];
	TAGGED_FROM(0.00)[bounces-43406-lists,linux-pm=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[qualcomm.com:email,qualcomm.com:dkim,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,oss.qualcomm.com:mid,oss.qualcomm.com:dkim];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[abel.vesa@oss.qualcomm.com,linux-pm@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-pm,dt];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: A0C9E1D9E1F
X-Rspamd-Action: no action

Add RPMh Power Domains support for the Eliza platform. The list of power
domains is taken from downstream. Even though the cmd-db does list MMCX
and MXC, they are not used, so they should not be describe.

Reviewed-by: Taniya Das <taniya.das@oss.qualcomm.com>
Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Signed-off-by: Abel Vesa <abel.vesa@oss.qualcomm.com>
---
 drivers/pmdomain/qcom/rpmhpd.c | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/drivers/pmdomain/qcom/rpmhpd.c b/drivers/pmdomain/qcom/rpmhpd.c
index 19849703be4a..b0c80e4bd86c 100644
--- a/drivers/pmdomain/qcom/rpmhpd.c
+++ b/drivers/pmdomain/qcom/rpmhpd.c
@@ -217,6 +217,25 @@ static struct rpmhpd gmxc = {
 	.res_name = "gmxc.lvl",
 };
 
+/* Eliza RPMH powerdomains */
+static struct rpmhpd *eliza_rpmhpds[] = {
+	[RPMHPD_CX] = &cx,
+	[RPMHPD_CX_AO] = &cx_ao,
+	[RPMHPD_EBI] = &ebi,
+	[RPMHPD_GFX] = &gfx,
+	[RPMHPD_LCX] = &lcx,
+	[RPMHPD_LMX] = &lmx,
+	[RPMHPD_MSS] = &mss,
+	[RPMHPD_MX] = &mx,
+	[RPMHPD_MX_AO] = &mx_ao,
+	[RPMHPD_NSP] = &nsp,
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
@@ -795,6 +814,7 @@ static const struct rpmhpd_desc qcs615_desc = {
 };
 
 static const struct of_device_id rpmhpd_match_table[] = {
+	{ .compatible = "qcom,eliza-rpmhpd", .data = &eliza_desc },
 	{ .compatible = "qcom,glymur-rpmhpd", .data = &glymur_desc },
 	{ .compatible = "qcom,kaanapali-rpmhpd", .data = &kaanapali_desc },
 	{ .compatible = "qcom,milos-rpmhpd", .data = &milos_desc },

-- 
2.48.1


