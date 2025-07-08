Return-Path: <linux-pm+bounces-30360-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F866AFC996
	for <lists+linux-pm@lfdr.de>; Tue,  8 Jul 2025 13:30:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6DA7F5631BB
	for <lists+linux-pm@lfdr.de>; Tue,  8 Jul 2025 11:30:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCB792D3729;
	Tue,  8 Jul 2025 11:30:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="ZGHS+AXF"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 456232153CE
	for <linux-pm@vger.kernel.org>; Tue,  8 Jul 2025 11:30:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751974223; cv=none; b=WCsL4xQeQjQ2LVQB8sKIsUgPfNkKH9mZr/Hj3w/hhx69nyFJDGW2GaSNWk1UJhM9iE6+5AVyWUi9e4TnVEQIbIEMZ4rcIRpQjvDVQRXolI1c3nCmw2Z43+URTb9n/TufL7+NAfeZgGDt/MlVaC25FH7xyytIap0VcT6h/sqe4Y4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751974223; c=relaxed/simple;
	bh=klGJi5IRMEy+zJ/wOTbkEcbW04rsRXiKayvKLjZ5JwQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=erfKpvNxm/e6IoasYBfX24wNhdzg4k/GQI8ip3mpYMdfGGmvSgq5q1XHD+JGcUoO1dfpj0YcY9rfGl4qDK2dud/F4L3R1/BKBow9uTLJTVU6ItaqYvNs+1MxYtDPhJJ/75SISKvab7dY8RPBKB4tOwqz/xfxb1VMFsBbkhtQCCY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=ZGHS+AXF; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 568AAOZp003376
	for <linux-pm@vger.kernel.org>; Tue, 8 Jul 2025 11:30:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	gtrnTCa72vdba6TcO72tSZeB/6DLMVbveL6Baz70m+4=; b=ZGHS+AXFU5y2JRxX
	vWjW1aWgVvntUtRgBBOMutrFJO4ENV2inHm147PVqUIvp3FmU4evvEyw/L9TmXSM
	Vngx9fdfYtGAY0/PfH5vCF3x1yrEjYWbuKBzvbdMRN8BuwzkVM1xnoQo+IVyCQp5
	/TaYB5NIYbsa0KdHAcARvWO150opKHmTg/pW0Fihu/WCbbvE8w2Bw47Ugjim8Za1
	d7Dn5D2lMOCSPFNTP1XPZK+4G5yyArqU2RUjEkVA1tWqwqY0Y2Yy0GkukAX+iyW6
	pFF+KTabdUGk7aGr7X+Ve7sLSGZZPeC6t4YRT9PM0yQiXbkijJrkD50k/mqohZWW
	w0iZYQ==
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com [209.85.219.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 47pvefd186-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Tue, 08 Jul 2025 11:30:20 +0000 (GMT)
Received: by mail-qv1-f71.google.com with SMTP id 6a1803df08f44-6fb030f541bso15831936d6.1
        for <linux-pm@vger.kernel.org>; Tue, 08 Jul 2025 04:30:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751974220; x=1752579020;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gtrnTCa72vdba6TcO72tSZeB/6DLMVbveL6Baz70m+4=;
        b=Uli4+eTE4t+/TTovUsYthRU7wKlghXM1/l9jFe7a2i+pPtxUo8UCQ2+Vj/NxxaTDmH
         ZnadncT7QRU+R/N90v1G2zTTBj3elLJTXmCIUL/+g7DE0qn/RwH8eqqkWK/F+NSIdNKj
         /l8eA5q527MBxMp9btBR6EKE0hI85k8m/y5HTVAwcHOA4YZu+ddefdq4uN2dOZWp4EFI
         Inveo+GTZwkwbuexaqyktqVdwW6xqsRVLIkRXe+MfgrvYAy3BoKIxTJzurdYGF9YyDpq
         yqF4FpGboM9A7LQv3ynGg7hS7u19yRTimFNlxzP25kEXAk3dVKXP7y9C//kRVE7D7meD
         IL9w==
X-Forwarded-Encrypted: i=1; AJvYcCXToLWNEaTmtsolDtFsc7ZbitwWa1Ba8hpvO6AJBU5GS+UxbaUrFhUaINpgMAjJiBsXq0GWJpVM6w==@vger.kernel.org
X-Gm-Message-State: AOJu0Yw1bruWl0A9P1BsI3fSc0mAxIs8vZVk3cKWf/FX9kewLZhat+SH
	x27Wj1OTCONS5p3OlKlalIEpyOfu/2Cx7THSFiZFYCKIYgryCNIuywWkZGX3boThyLV0qUJliBD
	AQxThnmB0noMkG5CDSz3vk/+d531gl/U99jI5cgdd7bMQrmwl9vcL7rjSfRZb0Q==
X-Gm-Gg: ASbGncvG6YH/Y/OOox3JEE3JNza7jbhqnHVlpm3RfmtuCUPInCrpX4G6zsshd7QC0l2
	pFjOTQ1ylahrolYbQeIxgbk2oFXnpZsz4AmYGwlttcv/q5diKMsFt8Jh2iJdKU/G0AKHTDwBSgb
	hRc9G3Qx5+x0D4ffm1muBH57djZYvfWqdbiPwju2CnKhp5AfJMkZIc3VSVuf7Nf3iZjlfUtFf9d
	aKlnNip5fOrmM0/xEPrx0uGH5YL57AhEkQ99QIJcXDnS3k1J231vVOi1VQO++sroTm63Lila8qm
	hfJ/gizfKiSR2Hpy5Ry5aOHzbnQhohrpJJlCX+lA4UhditR3oBtYWc083o8T/KhUpIBy+CDlJMK
	WCyk=
X-Received: by 2002:a05:622a:4acd:b0:47a:ecd7:6714 with SMTP id d75a77b69052e-4a9975d0949mr94377601cf.9.1751974219830;
        Tue, 08 Jul 2025 04:30:19 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE1F23966ZtLAdemkWX6cjqDae6AFYWaUPA2/p/PB3EepYmlXUPOU0//eXUxa+wOGcNN/hbKA==
X-Received: by 2002:a05:622a:4acd:b0:47a:ecd7:6714 with SMTP id d75a77b69052e-4a9975d0949mr94377161cf.9.1751974219165;
        Tue, 08 Jul 2025 04:30:19 -0700 (PDT)
Received: from [192.168.143.225] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ae3f6ac67bbsm884840166b.96.2025.07.08.04.30.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 08 Jul 2025 04:30:18 -0700 (PDT)
Message-ID: <0a09fbc8-8835-4e94-862b-0baaea5ee251@oss.qualcomm.com>
Date: Tue, 8 Jul 2025 13:30:16 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/2] interconnect: qcom: Add Milos interconnect
 provider driver
To: Luca Weiss <luca.weiss@fairphone.com>, Georgi Djakov <djakov@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc: ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250708-sm7635-icc-v2-0-e158dbadb29c@fairphone.com>
 <20250708-sm7635-icc-v2-2-e158dbadb29c@fairphone.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20250708-sm7635-icc-v2-2-e158dbadb29c@fairphone.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzA4MDA5NSBTYWx0ZWRfX0npPdt4clEm9
 TWJKFdKMWQ31RNYZS9zBSSzf8N4wbl56znoxRAHH5R3VFNimTHN/SVvFCBaS4vetZCbc4p5rHQJ
 e90KkIDO0m3ZkPmJlqrBhnjdV78QubwC/S4cTbDpOLCjhii8L8TBWPL/+1UTz7kTcHa7Xhk3ZAc
 XybySxOz7AcY0A6mQ+g/Hvvbn09Bs84npjLhG0i0WmHkv4mJ72lgRB0HQGfF0w94HavzRVCQI8m
 q3ZtiuoP54iw9iSHYYR0wz3JMleq7kJXDg09LIs34ZRaoMIKdd1zj93acdHR8fZVR7zXE74sYXr
 a6QSyDLczhR90hKp2ONxnU8RiDtejQEiORgM6QL64t7J98v7SBzCSffsHTKuogY41DIp7cIEZOZ
 jwl1Cf2mBqhZf6jbAEIHMy3aqNbxKc4eNcrO1D4X5xjK1LGRu/08RxmOerPmgWvk8A0k2idD
X-Authority-Analysis: v=2.4 cv=dciA3WXe c=1 sm=1 tr=0 ts=686d014c cx=c_pps
 a=UgVkIMxJMSkC9lv97toC5g==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=6H0WHjuAAAAA:8 a=0e8QCNbYJG8j8A-s5v0A:9
 a=QEXdDO2ut3YA:10 a=1HOtulTD9v-eNWfpl4qZ:22 a=Soq9LBFxuPC4vsCAQt-j:22
X-Proofpoint-GUID: Hmm_uP8-KDfbL_yaEGejy3LqR3WG539o
X-Proofpoint-ORIG-GUID: Hmm_uP8-KDfbL_yaEGejy3LqR3WG539o
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-08_03,2025-07-07_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 malwarescore=0 suspectscore=0 impostorscore=0 phishscore=0
 mlxscore=0 mlxlogscore=999 bulkscore=0 lowpriorityscore=0 adultscore=0
 spamscore=0 priorityscore=1501 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2507080095

On 7/8/25 12:20 PM, Luca Weiss wrote:
> Add driver for the Qualcomm interconnect buses found in Milos based
> platforms. The topology consists of several NoCs that are controlled by
> a remote processor that collects the aggregated bandwidth for each
> master-slave pairs.
> 
> Signed-off-by: Luca Weiss <luca.weiss@fairphone.com>
> ---

[...]

> +static struct qcom_icc_bcm * const aggre1_noc_bcms[] = {
> +};

You can remove the empty bcm arrays and .(num_)bcms assignments
for them

[...]

> +static const struct of_device_id qnoc_of_match[] = {
> +	{ .compatible = "qcom,milos-aggre1-noc", .data = &milos_aggre1_noc},
> +	{ .compatible = "qcom,milos-aggre2-noc", .data = &milos_aggre2_noc},
> +	{ .compatible = "qcom,milos-clk-virt", .data = &milos_clk_virt},
> +	{ .compatible = "qcom,milos-cnoc-cfg", .data = &milos_cnoc_cfg},
> +	{ .compatible = "qcom,milos-cnoc-main", .data = &milos_cnoc_main},
> +	{ .compatible = "qcom,milos-gem-noc", .data = &milos_gem_noc},
> +	{ .compatible = "qcom,milos-lpass-ag-noc", .data = &milos_lpass_ag_noc},
> +	{ .compatible = "qcom,milos-mc-virt", .data = &milos_mc_virt},
> +	{ .compatible = "qcom,milos-mmss-noc", .data = &milos_mmss_noc},
> +	{ .compatible = "qcom,milos-nsp-noc", .data = &milos_nsp_noc},
> +	{ .compatible = "qcom,milos-pcie-anoc", .data = &milos_pcie_anoc},
> +	{ .compatible = "qcom,milos-system-noc", .data = &milos_system_noc},
> +	{ }

a space before '}' would be neat

Konrad

> +};
> +MODULE_DEVICE_TABLE(of, qnoc_of_match);
> +
> +static struct platform_driver qnoc_driver = {
> +	.probe = qcom_icc_rpmh_probe,
> +	.remove = qcom_icc_rpmh_remove,
> +	.driver = {
> +		.name = "qnoc-milos",
> +		.of_match_table = qnoc_of_match,
> +		.sync_state = icc_sync_state,

Are there any issues with sync_state? (hopefully not)

Konrad

