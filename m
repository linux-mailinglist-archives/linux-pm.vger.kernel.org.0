Return-Path: <linux-pm+bounces-43119-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YCSKLWJ0nWmAQAQAu9opvQ
	(envelope-from <linux-pm+bounces-43119-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Tue, 24 Feb 2026 10:50:26 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 328FD184ED4
	for <lists+linux-pm@lfdr.de>; Tue, 24 Feb 2026 10:50:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 7918330364F7
	for <lists+linux-pm@lfdr.de>; Tue, 24 Feb 2026 09:50:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B452374722;
	Tue, 24 Feb 2026 09:50:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Jh8oLH3x";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="MOTHVjWi"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AB29372B4A
	for <linux-pm@vger.kernel.org>; Tue, 24 Feb 2026 09:49:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771926602; cv=none; b=VwkxPe29HxiTQ3krJacm4m9K9Udcj2NYUEkXnm0OFNSVoidir83rN5JGGGC9tzXW7J4nmQsHw1HKiajvooQAcbEiL0UxNIcM+xmzd3OHlhzsuxjIhXoISGG54JBMR/VsOLkH8Ynp83+AxglC9u8szNEsbxi6Y1sNiLrRmV+QYAY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771926602; c=relaxed/simple;
	bh=JmCKMSZ99k52JgM1yUT7vCu4cn9pkfemr21UsbLLGFI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=bbzIZlh+P4jSC2MFwe1de2TYlqQhO/849W79dbUld4Dgdxnx6ZytZn6/Bm+gbOOUODU9k9I3qyhMiVU2SDheAJ5xTyuvagmqUOQEakELXJhKxq+jah0M7biz3BWs3E8A6RuJnDGE5B9r+E5n7wRi6uRlMmnaKCsA8UbDmvtPUgA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Jh8oLH3x; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=MOTHVjWi; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61O4Lgah694209
	for <linux-pm@vger.kernel.org>; Tue, 24 Feb 2026 09:49:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	oY8+PqH7o/csX+69/fLbUX81Ekr2b1hKUFSvV8uMb9E=; b=Jh8oLH3xv5LA24Gg
	jcMFHCAdwUqoW46MdMY2Mx01Sm/EPmkQ+u9Y21GeNVCxE8YUhklzu8ipiB4+Umvi
	DYe/iv+LebktC4yrqAxT3T8Q16obaDOXLUQSru+GxnjDH8t2tQb7WMk9KHR6fiYd
	174zrI3StZdjWinYWirEFvXDTphORbfXZzrb9s8eX6Kl6hURHA9knBzH3KrG9f9K
	Z4t863nXt9Roxt0ZHodh6GX7DDJj9yEheooJfphloSG5jAxguptmgPxaBFEh1R1y
	mWCCMTJvgZxUY2w9bdYsDeXZDj7KsUPaa5GRs5aUgHdzwpEQNxV8MJ0I+UeeU4wV
	942XKg==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com [209.85.222.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4cgtv9tnc8-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Tue, 24 Feb 2026 09:49:58 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-8c70ed6c849so4472919085a.1
        for <linux-pm@vger.kernel.org>; Tue, 24 Feb 2026 01:49:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1771926597; x=1772531397; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=oY8+PqH7o/csX+69/fLbUX81Ekr2b1hKUFSvV8uMb9E=;
        b=MOTHVjWiF026CmpkoUmSj3IBpiopHCP/J8ufvuu6vzBBZHvF+2w1ucEJWk8CdYd6NL
         lmwwz6IXqfGtHHrX6fupVT9j2Z/HkUm07Bgedp/phO2L/5jeZrMWpCXYY+aCSIfoMjwk
         wDUr+/asycnEetygtcwqjcRTjFqOL9Ubi7Yrig/q2eelhaFYkdMqNwKX/DvTIKvj58e9
         vLX+Fjv+bhDKOTB2waWA9JvGE6eVFlfT3KIRiJsmwBiTrIiC3KoxYvszr1REZjMI5jmH
         CvT8b0wZZTv/BFgvIc/Lr+BmbwtLHHO6g8MLbBpMYvosskgA343xJ2w7JdVxe809KZzJ
         eD9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771926597; x=1772531397;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=oY8+PqH7o/csX+69/fLbUX81Ekr2b1hKUFSvV8uMb9E=;
        b=ncMC/CI0DTePUZkCojC9meWvxxv/xnhMmAjnW/tHOvqJS+RLn+46cNJ/1olpqjqDEx
         RaLIGus8qhlQ4dvdb6iYP4uKHkW/sDsC7Ju8YzmP/FnNVEVQUBN2qpx8IMWwyqXV0YWC
         olAWm+NNIwZMvc+IhP/ueMTJ5DoAVOo1s2bhpP8tAJQCGiL+FCWP4SeClkh4IivPS5AM
         OXUNiZdRvF+G6H0BwVN7XHxub1Y4N15Avfki2oWbLt6qNhivgAgUuJzX6v+xTzPkfa1e
         AO+G6EsxI9+TCWCskUOCgW8a189DMlCxZcIMa0doaFoDVhoD6llIDkrtXsn3ujig0lHV
         gdGQ==
X-Forwarded-Encrypted: i=1; AJvYcCWZqW1w6UMUzOkQv8bj76geMFi/sc3LwX7qm6Ceq5+ArS6EHc/oowuymKaMPX78rb8/sBR1MaiW0A==@vger.kernel.org
X-Gm-Message-State: AOJu0YxeVDxEDKJdy084ZzAemFM/vCuxghmkzJqLy1Fcy+V1c2qLd9zF
	hOl8Ro5UL8N5L53C7TvBEuL2Hcmaq/orpK5jzKkt4oPL8xIAqHRIW23OEsMAuVrpNjtpH8VS3Fh
	OoSHEjQ6JYq/UYGL/kgUGDsLep33NxTJV7OotHqXZ+w15gLdgtUQx4gtul8SsKA==
X-Gm-Gg: AZuq6aIm8426/8fIWhV0RJeMRtHwVPkdlnzMcBMsiV038+cuvR9wTtWeKsGvXEr4kR+
	SQYYhIjkkiV8FnvXPK2f7UlV6yyNlsLYnm3JbpPdiQv98KtCIpQAmkpD0nEvvTpcyAUYbeVJD5X
	K4+o0y3NQwdGD2CiiOByzmNHchdTYc1YK0elul8xFEqRfqTt83FiT3cbYei4kopS5SESyyMkd9W
	2l8ObHXYwybe65LakHbHv5M+nddWPETG5XpMJiknfKxpzDgnT33UMrXeK6mxU8HoCxkUGwgQ5lm
	8zXqTQnNBsLi+FK3AQPA2gNWP1YFUEswtMlrEtRNSUItmgz8RuD7JHaSBKa+JiO6gkofel++9Po
	1EhUR7uo6WMC2WxaYMXlKgXePMEVE6g==
X-Received: by 2002:a05:620a:29ca:b0:8ca:41af:32d6 with SMTP id af79cd13be357-8cb8ca83227mr1557566085a.70.1771926597214;
        Tue, 24 Feb 2026 01:49:57 -0800 (PST)
X-Received: by 2002:a05:620a:29ca:b0:8ca:41af:32d6 with SMTP id af79cd13be357-8cb8ca83227mr1557562185a.70.1771926596456;
        Tue, 24 Feb 2026 01:49:56 -0800 (PST)
Received: from hackbox.lan ([86.121.162.109])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43970d3fdd0sm25912206f8f.19.2026.02.24.01.49.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Feb 2026 01:49:55 -0800 (PST)
From: Abel Vesa <abel.vesa@oss.qualcomm.com>
Date: Tue, 24 Feb 2026 11:49:45 +0200
Subject: [PATCH v3 1/2] dt-bindings: power: qcom,rpmpd: document the Eliza
 RPMh Power Domains
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260224-eliza-pmdomain-v3-1-6e13d3aa70a1@oss.qualcomm.com>
References: <20260224-eliza-pmdomain-v3-0-6e13d3aa70a1@oss.qualcomm.com>
In-Reply-To: <20260224-eliza-pmdomain-v3-0-6e13d3aa70a1@oss.qualcomm.com>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        Abel Vesa <abel.vesa@oss.qualcomm.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
X-Mailer: b4 0.15-dev-47773
X-Developer-Signature: v=1; a=openpgp-sha256; l=911;
 i=abel.vesa@oss.qualcomm.com; h=from:subject:message-id;
 bh=JmCKMSZ99k52JgM1yUT7vCu4cn9pkfemr21UsbLLGFI=;
 b=owEBbQKS/ZANAwAKARtfRMkAlRVWAcsmYgBpnXQ/IMPbPQ3feF87hnK8THL0pKDNMKVaJw9GK
 89QdlCN/CqJAjMEAAEKAB0WIQRO8+4RTnqPKsqn0bgbX0TJAJUVVgUCaZ10PwAKCRAbX0TJAJUV
 VoWXEACahivmdMAFXGL4lnKmzb4RhIQmH56AgDbtktlxkAKBCWiUxjsyJay6wCbg6Vw5RUoVlKG
 mxm2468Ue+79+Zj35ALqnZE66kqHXpn2gSW9oMmCfGTxD2mHZIft+OLaNDPmTgc1L1qCXgmdIO0
 6Czh6g0bpbS+Awi/bAN578gAxrnF6u2ja4zqB2yz6LG+Cp8M2+J4Sc6nEhEe+ZRjdF8Oro59jvE
 dafao+Ig15af1DKdI1Hna2p5+8mPtfsGrDMcw5RNaPejj5/MiidwueR6i36teafp8JRxsnPa/5j
 yf53MsrwQJPhMDS84MSHO/Za78AjAMI5a4669r0SsI5/8W0T7Y/EkYVlEOsDwuKTaqiCTqFzu+I
 +RKBtXzNqYqUJjdJHivAUizWXZlNlKH+6GpiAt5D6Vtt2JMVJP3I/+RPaw34yOaUk0I6sr8y3Df
 K5wAV0oeNiN7ORwZpgX/5FkavmE5tI1Pq9Fo8e63mlnR/q/uAaoo0t99NN9U1OkhlWb+EU24mjk
 JvscADUlHn07FZ2QqLjADfHfTiKyGilIO8WCsw4TtzSqmeRDyKG1khEL+Kq+5kNTygVurey/bKB
 e64XsP0GF8gW9O3jD3MXmuMWfPttErapxhKPz9PggLkmPtSFQ8kl+L4yRcv6RYZM+/teJ2bB0eC
 U4KCHwIWxgmXWdw==
X-Developer-Key: i=abel.vesa@oss.qualcomm.com; a=openpgp;
 fpr=6AFF162D57F4223A8770EF5AF7BF214136F41FAE
X-Authority-Analysis: v=2.4 cv=Vaf6/Vp9 c=1 sm=1 tr=0 ts=699d7446 cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=oauzzCmhM186DRC0Y2yWPg==:17
 a=IkcTkHD0fZMA:10 a=HzLeVaNsDn8A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=EUspDBNiAAAA:8 a=-qkovbBEdaU6HcigwZ0A:9 a=QEXdDO2ut3YA:10
 a=PEH46H7Ffwr30OY-TuGO:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjI0MDA4MiBTYWx0ZWRfXzT7B5OR2zFXm
 yLM0mWQJRn3KUMPM0cbgIz9HCMnYy4TuxyDYdK3M3nwYqwU1IjbacPU//gqMn400NGyZTCxQeya
 t7zjLXvtFZw+OADrmB7T9KvJy2hqx0nFnMV9M+Bxfyx6YHC5psaV/tO65Whrolbo2W1TJMslri5
 A67HFZU88TJyhZRmJC6FUuI2MA1yOABKFxt5FLusuRUa5RE6D3KWrC8iBGdbyBKFqpgr7LxCONa
 sd5CbeVqyuQKXXx3dCWZCgv9sd7i+uvvjHd3pC3ZYWrZwTxVnYGE0GFWaz5CQmTEDXvFEJoKgqe
 GzYh2m1ZmndSaJILS8lhYN/U/Eo6Aje51s+VdLGGR+Q/N8gyWj9pZVEAdwDWYUTrZbZiTopo8DO
 EK7GgwrrAOEriRX/Q4Ae6Uveu7VlJ29Nu1b4vaTftE0qGGqxc4BjrAlwsfEFBVaAkQ5Ipe0mWSZ
 dVllPw1i4792z+D5fvg==
X-Proofpoint-ORIG-GUID: Z26OoUPs7lG3G7w1J_jyxFMxcV2zTi6n
X-Proofpoint-GUID: Z26OoUPs7lG3G7w1J_jyxFMxcV2zTi6n
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-24_01,2026-02-23_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 phishscore=0 bulkscore=0 malwarescore=0 suspectscore=0
 clxscore=1015 spamscore=0 adultscore=0 lowpriorityscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2602130000 definitions=main-2602240082
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[qualcomm.com:email,qualcomm.com:dkim,oss.qualcomm.com:mid,oss.qualcomm.com:dkim,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-43119-lists,linux-pm=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-pm,dt];
	FROM_NEQ_ENVFROM(0.00)[abel.vesa@oss.qualcomm.com,linux-pm@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 328FD184ED4
X-Rspamd-Action: no action

Document the RPMh Power Domains on the Eliza Platform. It is not
compatible with any of the previous platforms, so dedicated compatible
string is needed.

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


