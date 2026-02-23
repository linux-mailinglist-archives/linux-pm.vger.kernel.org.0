Return-Path: <linux-pm+bounces-43027-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mClLLzpDnGk7CgQAu9opvQ
	(envelope-from <linux-pm+bounces-43027-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Mon, 23 Feb 2026 13:08:26 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 836E7175E69
	for <lists+linux-pm@lfdr.de>; Mon, 23 Feb 2026 13:08:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 8895D3026AAA
	for <lists+linux-pm@lfdr.de>; Mon, 23 Feb 2026 12:08:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26508365A1E;
	Mon, 23 Feb 2026 12:08:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="eW8CJDJ4";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="BEMcHmDe"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62B453659F7
	for <linux-pm@vger.kernel.org>; Mon, 23 Feb 2026 12:08:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771848495; cv=none; b=VbnxUEGZr5mIlbJzmoeUxMls+CdUyge32fB51Ot8GtjYGqLYHFGiwpq9SVXDatNdxg6SB23Of4s3JtGv0Fuy1djv1hoZwxCFzVNhQ8pE2tWpwBGnGDYKRCG40r15hNE5+xjPs+IFCJx1v25qpaQ4q07Vrs07Lq7E414OhXgeVRk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771848495; c=relaxed/simple;
	bh=sSYP89Z8JomH21HJk5Yj2suzL+Jwq9KlybgMDnBolRY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=l+lwiaX/8vHWbr+NwdJLpaBa6YCmwe6eIwu5CDYGUQGrlGWXW3QvuJdfrdj5eV8y6IWWQdBW515PLI/8YcvDi5OjPGfTUb/r8o5XsBBIfJpOrGWadVzNJ6sa5QBy0XR9Xbzj9fPFMSo5pzTTqQWi2WfYFtjCzSxmf0LYZ2tKVvg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=eW8CJDJ4; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=BEMcHmDe; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61NAH0ao2061057
	for <linux-pm@vger.kernel.org>; Mon, 23 Feb 2026 12:08:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	0ldZyJ1c5TJehS+F2KkRUcZr9NMKbSXHp6zHeXOoE7M=; b=eW8CJDJ4t12AvLQP
	yfpwgVHyPlAN7PK5JPEHX5XDJuMPb5bbkXlMjgkyL75qeaqhT8pzJNPplSRJTCh0
	H9izECj/ZWH5cPEG68p1u3eE8aEL5X/SOEmfEFq1nVhUkyajvUG1jBk1S8EZloZ+
	YELqq5lj12xkhxXS0RU8jjLxXWOl3q2wjYwH1AZdseZqL1JH2O9aZIz6SL8QFmZX
	v63A9vh9+/ctjF3grZ0PDDC3dyLIe5zA62h3Gp3Yctvvzf2T5pH8PwAqc3mY0qA3
	qVdaPM5NAGZ98WApA6M3ot7GHidAWSztLhhnsSG3+lGCJvXjdrH0D8oNjpg0uesX
	GaswcA==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com [209.85.222.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4cf5wavng6-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Mon, 23 Feb 2026 12:08:12 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-8cb5359e9d3so4299915385a.2
        for <linux-pm@vger.kernel.org>; Mon, 23 Feb 2026 04:08:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1771848492; x=1772453292; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0ldZyJ1c5TJehS+F2KkRUcZr9NMKbSXHp6zHeXOoE7M=;
        b=BEMcHmDefTPmzO1Dr9SBqk4UbOKElUxeXTTmQE0+ozoR/k590WFxl4nvM8EKZ3qzRA
         9uaB7EmiYuCk5eyAusohgqOg+HYZK3ipVvc51xCd23osoBgpEU+EIN6duC8yIuV/Cxik
         wUReC1rVY8RlGOSAYKNrDGFMqz5QMQQUCVQT7JayrSyzsJ1elIlhM9/mvn5fEHWSEakB
         XjurW6rcXbVqDiLWa3LnPDMhBdUNrE1HeK1VUBvU+zohkQKVei7p0hPirhc9j8pIncGz
         NUZ7IaUcMW6YxmJzSlVmOAPr5x6oGjCRvqQcV5A1qwPl/Abdy2VrM3UXUtsCReMJjKyq
         w+ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771848492; x=1772453292;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=0ldZyJ1c5TJehS+F2KkRUcZr9NMKbSXHp6zHeXOoE7M=;
        b=rWOiip12BYxNh3RrJC6p7ot0vrq72BNnquYeoGhAZEC1VN6pZnC3XXuN9XD7Y4C9AY
         6ZLNJ/xg2r2c40QfPCw31cwEdrAwmi3Fti4bjpQ2sE6KUxgSUz/5kLUWsvqsJ1e6rVmg
         aUywG5ao6muGz3ODbqXF1llihIvPbzZYYYEgiEUTEwXBU4ScTI34BT/U3dCA0Kfdm2C9
         +Ku+VSmyUf/y8AGw6sAYX/noNIsiAsRlFyRuDfXafahAvBye32kD7CwjDRkvad6HaPk8
         FmGRWEsihdKX9W8OHKBD17H4UFxVlEwzv1PPZ/yOxml0zLMYnP73iH4qO72DI6Kkj9bD
         hx1w==
X-Forwarded-Encrypted: i=1; AJvYcCXFXZzLUrIYkM4PA6TKLswobaCrBNig6gcBJKyur08W/DqcowIaz47rdQz9Ccw+UMyQV50pSKXw5A==@vger.kernel.org
X-Gm-Message-State: AOJu0Yzhj4xZ3dUHGSFPyrauCzTmzCR/hCH2oqYbPdu02lxFtxU9j4Ii
	NQPEZa9RyrN1teFaHQy2SKyDf0jhDWaKyhXxY7lbniX6ePWRpMqS58/G+pRTL2vzY6Dae+lCWmF
	ObzD3tzQj1YnRKmzBcREhRNZiK+4Hui7hgToB8zo012b9R5lls09xlk7RB0qAvg==
X-Gm-Gg: AZuq6aI9xeyUENNeHrqrBeEs0+6a0tXiGBStyX+f972TrTBk+2PPbHYws4O9jVKdbyq
	VcR5kYsMnQO0rckE+NGusKs6iOH2/mt7XD4bJ8sJDTO9eIZei/SuEZti1TPcuMuXQ3Qqvzd0mjW
	e2vXOuTlKm4TVGt9bkr10iJoBWFhZoVGbMQKPPODK7cdmWoyKExAVkK7LohzzZD2vUIBoMsKjtH
	5tBus20uPV3myskHwECuAREhE8xxnWyg1zPvo3uVTivesrGUg9gpiSeedm1cVe+jNTSPnHBQrd5
	p0khNZKyM7Ju6JVPL7upQKucmsz4mkFfIWYzqJkMUTXnfJ7Zf04/Dl/AxMVtLPfEcSP+bQFfMtG
	tVB5DrMHiqgMpbSaSPR+fYQ8DTMN94Q==
X-Received: by 2002:a05:620a:29d1:b0:8c6:e8f6:2c7 with SMTP id af79cd13be357-8cb8ca6e5f5mr998436185a.38.1771848491678;
        Mon, 23 Feb 2026 04:08:11 -0800 (PST)
X-Received: by 2002:a05:620a:29d1:b0:8c6:e8f6:2c7 with SMTP id af79cd13be357-8cb8ca6e5f5mr998432985a.38.1771848491126;
        Mon, 23 Feb 2026 04:08:11 -0800 (PST)
Received: from hackbox.lan ([86.121.162.109])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43970d3fc12sm16522603f8f.24.2026.02.23.04.08.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Feb 2026 04:08:10 -0800 (PST)
From: Abel Vesa <abel.vesa@oss.qualcomm.com>
Date: Mon, 23 Feb 2026 14:07:55 +0200
Subject: [PATCH v2 1/2] dt-bindings: power: qcom,rpmpd: document the Eliza
 RPMh Power Domains
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260223-eliza-pmdomain-v2-1-23fb87eb70ef@oss.qualcomm.com>
References: <20260223-eliza-pmdomain-v2-0-23fb87eb70ef@oss.qualcomm.com>
In-Reply-To: <20260223-eliza-pmdomain-v2-0-23fb87eb70ef@oss.qualcomm.com>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        Abel Vesa <abel.vesa@oss.qualcomm.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
X-Mailer: b4 0.15-dev-47773
X-Developer-Signature: v=1; a=openpgp-sha256; l=810;
 i=abel.vesa@oss.qualcomm.com; h=from:subject:message-id;
 bh=sSYP89Z8JomH21HJk5Yj2suzL+Jwq9KlybgMDnBolRY=;
 b=owEBbQKS/ZANAwAKARtfRMkAlRVWAcsmYgBpnEMk/2OkHJsTDoa9e4HTmnyC+zYgcOwHyrL2Q
 yvfZIDAZpSJAjMEAAEKAB0WIQRO8+4RTnqPKsqn0bgbX0TJAJUVVgUCaZxDJAAKCRAbX0TJAJUV
 Vu5WEACtAPGv3MQ61wNrJmnfh4/74kwgdieJ4bZARvJggcdNq1Lpa1evHOGrNUvNb8FGr3/tIY/
 vXTv1MLno7c3dozMJ80mL+ir4SjG+lquMDQDiheZRxYMispV+swbGs665AnyG8SKMZBnU/prNJe
 MG0IkJJnLGxLhzR2RuUBsDkH/5DprfzAAGbfuPMZCGR0dPfG2CcaiJsiiUkGu2V/ZMenS3kXT9B
 BnJnzFtCVxHyd4npRFlzxVLOiDc1+sVwLk4/7CpLQZv459PVh17u11+vo/NUD0y5o18ta1KGqe8
 X/0fBINCZjpmTLgaxx4ltRG6fmDVOyo7cdLvSS59V+KDL8jdtF9f0wpbgLfsdNwK01IVeg7tcm/
 iNLcokJr2XfxN62KtRGrDtzWHx4Os3zoWXOLsOXDm65W/RaISf7GmmQ1dzcNHH+sDyGIHfTSx1H
 2E+8gm+aJZagXLpMn/fk/SY1cFzJH52Whjv/u64OFf80nt14U2Xtp3ccVdilFNvq3ZKCHBQ2Evk
 lV6TzOxHxvOadoTxuOIrh4pNn8HuWLOI6+7I3e/QQQ7j8fV7XNoCoKebviMV3ypVY4Qvhp+3rPk
 tcZ+4Zum4/QH0Qe0nyWZdtpRpNUn8luhYH26yG7+gYjG4KBCYW+5JErh8WtP99dtVbBMc25NixA
 hS1OQQ0kO65LXgA==
X-Developer-Key: i=abel.vesa@oss.qualcomm.com; a=openpgp;
 fpr=6AFF162D57F4223A8770EF5AF7BF214136F41FAE
X-Authority-Analysis: v=2.4 cv=KJVXzVFo c=1 sm=1 tr=0 ts=699c432c cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=oauzzCmhM186DRC0Y2yWPg==:17
 a=IkcTkHD0fZMA:10 a=HzLeVaNsDn8A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=EUspDBNiAAAA:8 a=-qkovbBEdaU6HcigwZ0A:9 a=QEXdDO2ut3YA:10
 a=IoWCM6iH3mJn3m4BftBB:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjIzMDEwMyBTYWx0ZWRfX/r0L7+rbBDwH
 YKK7yHNuib+uMarcK7T/2HxIjDh9r4SAkAdYpTnueLnb2HBk4PGtUU35I72sMbybOuGadE74J+P
 Wl5V814C9iyZtDzNb8oaOClnjjK54IXQWIESl6eiS4D+zNZeylOmKURsc9LrEpEHXTlh0DPpDZV
 ZPTQFiRTwuYwcuWDxCNsF935SqJgImz6H9sJq+nDUVoXgYVFeVt0jq4+Kme50SsddeHbeEN3An9
 I02WEBQsh+OtNijwL4lJmtYeIppCpOPYh2PWBgc+0amNGfs6IenrwUV83FOrLHzTAYnOKqXxi1b
 CoFkeMA2T009hcb5sZjifVWeEzvsY58YjtYAbJ9vA2ZhpP27cGNj/0ysUXxkSnrNY1GvHFykJLd
 OxdWW5pjSusnRLltUbkzvchPJ70AJW5Vyuqrs8EiVbht/ChMkGFObfCxN7TH4ARwSwtyLLkZ41w
 45+hChLEZ7pbCgMyuVQ==
X-Proofpoint-ORIG-GUID: xRUQNsNuv90RoDoU9V1eIycyY7z6JE-R
X-Proofpoint-GUID: xRUQNsNuv90RoDoU9V1eIycyY7z6JE-R
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-23_02,2026-02-20_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 phishscore=0 bulkscore=0 lowpriorityscore=0
 priorityscore=1501 clxscore=1015 spamscore=0 malwarescore=0 adultscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2602130000
 definitions=main-2602230103
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,qualcomm.com:email,qualcomm.com:dkim,oss.qualcomm.com:mid,oss.qualcomm.com:dkim];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-43027-lists,linux-pm=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-pm,dt];
	FROM_NEQ_ENVFROM(0.00)[abel.vesa@oss.qualcomm.com,linux-pm@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 836E7175E69
X-Rspamd-Action: no action

Document the RPMh Power Domains on the Eliza Platform.

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Signed-off-by: Abel Vesa <abel.vesa@oss.qualcomm.com>
---
 Documentation/devicetree/bindings/power/qcom,rpmpd.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/power/qcom,rpmpd.yaml b/Documentation/devicetree/bindings/power/qcom,rpmpd.yaml
index 27af5b8aa134..8174ceeab572 100644
--- a/Documentation/devicetree/bindings/power/qcom,rpmpd.yaml
+++ b/Documentation/devicetree/bindings/power/qcom,rpmpd.yaml
@@ -17,6 +17,7 @@ properties:
   compatible:
     oneOf:
       - enum:
+          - qcom,eliza-rpmhpd
           - qcom,glymur-rpmhpd
           - qcom,kaanapali-rpmhpd
           - qcom,mdm9607-rpmpd

-- 
2.48.1


