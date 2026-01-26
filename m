Return-Path: <linux-pm+bounces-41463-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aJ3tEfNCd2mMdQEAu9opvQ
	(envelope-from <linux-pm+bounces-41463-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Mon, 26 Jan 2026 11:33:23 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 289A487050
	for <lists+linux-pm@lfdr.de>; Mon, 26 Jan 2026 11:33:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 40363301571F
	for <lists+linux-pm@lfdr.de>; Mon, 26 Jan 2026 10:31:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CCFB330330;
	Mon, 26 Jan 2026 10:31:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="QKR70joQ";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="D3y+EZ31"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2297C3009D4
	for <linux-pm@vger.kernel.org>; Mon, 26 Jan 2026 10:31:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769423475; cv=none; b=YoiJ2CanDmATs+aGEhsB0xXobKC9CniPmx1oDy3lNXbVQya5YZTsTEj8Ef6K/FrY9QVcTZEniH9HQqsZf5CPLPysjeu0eYZ6MJSHvPf48I0mCZ+VlJ1cuid6fnrUos3PyI64lIjVf6E+W2+ZwsuwDb0CG4OmHDjpOeS98L0crs8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769423475; c=relaxed/simple;
	bh=nVJg7imRYSQSdLhTTEqD6KfatiTBtOhegBV0vcXcPu0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=N7cA7vdPG0WB8Cvl9KajoJ57zUFAO2iyLRjuNf0xSpSnxA5GwjYexSrZu7Xizhe9XFlm5XzlJwhPrv5xSbOEcyFy9AnrTU5N5ZU/U1p920yTPsT4OpNuxZmVDBVlpR2Zi7CMEknGtfuIUg7OZgC5ndtfp5RIjLdY/rWoijxhHPE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=QKR70joQ; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=D3y+EZ31; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 60Q92ArH1258051
	for <linux-pm@vger.kernel.org>; Mon, 26 Jan 2026 10:31:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	Z6AltB38+W/aWrXEYhQXQSSpZIGF1tOyOzJmfK5LASI=; b=QKR70joQILhfhaC+
	I5nLZUkGeMSg2+aIxwk16k7IDmjACzaRhLceN6QG/97b5G5I9HuW28SAEl6BSpyZ
	PEJn63g/BhvFSTS1zYL9m0iB37WedsaRjDyRdxSlbSXmHpGBoYj9EanXEPVNw6x6
	2Lci56upxT4Gj0mEgBQQsrh2a3ei9rG3fKb7ABjY+OpsZbeSwsoWx/it2O/HCjY4
	4izBdbVWKtwENfO/MszLPaqqUBlbQ6gg+/hAuU4EdSGgCmACk7lKfM85LPN/3lEk
	/zOwUNe9T8r9Tz8//uik62rnXDcckIaf8ySsFQcRmoqneWgI+M6VPeXY9T+ZY2e9
	5KSyIw==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com [209.85.222.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4bvwtybp0s-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Mon, 26 Jan 2026 10:31:13 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-8c523d611ffso78158985a.2
        for <linux-pm@vger.kernel.org>; Mon, 26 Jan 2026 02:31:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1769423472; x=1770028272; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Z6AltB38+W/aWrXEYhQXQSSpZIGF1tOyOzJmfK5LASI=;
        b=D3y+EZ31SS+RYK9FZaO4GYVln76xUB3Cj0xoMBe+2UY++kAbk2irs7IBQoLVKKEXJU
         OrtZtr5YNdebsSl2b0kq94NgDoN0Ano+s4CBz5M5r5+hryNZoV02sLR58q+gHfZz0MHf
         ftNbdTi3JKMZqb64c6Ew9FLtLJJTa7Dy+0G80fSKQ2CnkLX7aeq5q82qClPmi1yWzZcw
         jDS60USSNPwrLZTqYsvwptvwRRB2Gh1sHkYc01Zxxlgwg+QxRaahriYdtkJWZ4mdkK9O
         Ckwbm45DkoTx82G8yevWWXeBMSjY9+bR9OD891BRIBT5RviLzripGqlTP9r2zQs9sGpB
         vgJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769423472; x=1770028272;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Z6AltB38+W/aWrXEYhQXQSSpZIGF1tOyOzJmfK5LASI=;
        b=jPfnSws0DAn45mJJcvWIvdEeQNXd2LQjbDAqd8tKEJ/uUmVTR9HH6WGdIb/IM71pt8
         rRgeXWxDYVpaBJR1IYuvTOJGn+D69d5n8sWoqvhz7XZYBr01cpf9OYd7m7YQd6J137AA
         l07BSKqwZpJOiMAfNiik3+3S7RD6eiDpS4P5+YYv/cMsLanAQzfzjU20HiVKlA+BfxVr
         pER/neW3CF+khacGN6cFxATvaKDUcWXfq4+CfHyC2gt6x5a66fwtExIFuqW9ns6sKAXz
         p7lcvYhKasYVjGfPTOmE7wlMDCopyb/oI3CiznG/jOLTTqzOT4K90s7HSZihpCoWWmZT
         X8Iw==
X-Forwarded-Encrypted: i=1; AJvYcCX6SbSuxDEy6bnA05G1w+80VIyf2OdAZNZraa2Y4p9vQE2VQWc8erGmU+ZOUqDIN1lBQeUw/dAqhg==@vger.kernel.org
X-Gm-Message-State: AOJu0YxThud+J5aWrt7BxtTzrROLit+gpHSosx3Msi40RVPktaKlDULM
	A8+lJ2Zx2TdVjfA9XaYlOn/oQKBuuRuDq4fdQMpmuzw9nOLpeIT+p18JGcCVNdcsurTXkbrwcZ8
	8IF4YMaWafmPszQqb7j6U4OVup4HNx07X5VCHz1L8TdWxgFci7g4ndV7mBIUjhVU1tWrV2g==
X-Gm-Gg: AZuq6aJr1ZFtrefEhm4EIJfCynSpgiNzGWexah5ypnD3yr0YLr3Ork+XyJSmWE28zqS
	kv9QZ5HuLGbqSyv3y4HHWY0DDIl0bRUxFLElntneoWc89VyI3JAYKFYbxSCrocB5Q/0DqonuF7M
	iZ3beOu8mupfqv3RWuQ2kG+oz+j64NZZ3shIJMTCqj1wMt+aHE7UuyM8qAdZwuSefNoYNv8Yvn9
	W/pTooKbcU8LaVnzl9/1Qlb9ORYaKticn/z+/Oo3SQjYhDvuV58sDqOM4poZDrx4PEfmdLMBwLd
	Ik5a/zSVeaOTBMkpH+xQUcSB3nZMMXRSOsvS0lfqe6SDrXMwxP9ZUmYAw2bi854+vqbTbgatC0J
	5i4hHV2mYKBpsNvMfXP0LRW8/p0DG1THZ2LO07LxMESb8uskt+oKZeH9QLYuWaGc15wA=
X-Received: by 2002:a05:620a:2588:b0:8c6:a707:dae7 with SMTP id af79cd13be357-8c6f95790c0mr358336285a.1.1769423472357;
        Mon, 26 Jan 2026 02:31:12 -0800 (PST)
X-Received: by 2002:a05:620a:2588:b0:8c6:a707:dae7 with SMTP id af79cd13be357-8c6f95790c0mr358335085a.1.1769423471971;
        Mon, 26 Jan 2026 02:31:11 -0800 (PST)
Received: from [192.168.119.254] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b885b6fc4c5sm621398766b.40.2026.01.26.02.31.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 26 Jan 2026 02:31:11 -0800 (PST)
Message-ID: <c488e092-2319-463a-b73d-68e487cf3770@oss.qualcomm.com>
Date: Mon, 26 Jan 2026 11:31:09 +0100
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] interconnect: qcom: glymur: Add Mahua SoC support
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
        Raviteja Laggyshetty <raviteja.laggyshetty@oss.qualcomm.com>
Cc: Georgi Djakov <djakov@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>, linux-arm-msm@vger.kernel.org,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Odelu Kukatla <odelu.kukatla@oss.qualcomm.com>
References: <20260123-mahua_icc-v1-0-bc82cb087f1e@oss.qualcomm.com>
 <20260123-mahua_icc-v1-2-bc82cb087f1e@oss.qualcomm.com>
 <vpaz7jhnuagfl24dow3ktyhjtzktmhiiwh2rnflub3jbc3pgu2@2ydlmugmqgbt>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <vpaz7jhnuagfl24dow3ktyhjtzktmhiiwh2rnflub3jbc3pgu2@2ydlmugmqgbt>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: edAVxq72MDDspPRDBBwZqZGGmXVlobsM
X-Authority-Analysis: v=2.4 cv=BteQAIX5 c=1 sm=1 tr=0 ts=69774271 cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=vUbySO9Y5rIA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=EUspDBNiAAAA:8 a=aHkru73TLWHWJvrfeGIA:9
 a=QEXdDO2ut3YA:10 a=IoWCM6iH3mJn3m4BftBB:22
X-Proofpoint-ORIG-GUID: edAVxq72MDDspPRDBBwZqZGGmXVlobsM
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTI2MDA4OSBTYWx0ZWRfX4LTTcOxoOSiR
 +sfngbrJP+NyNYswmb5f49HGhkSLvStfWUQ+zk05fRp9LdAHPR9a/F3vGC3YmoH8b5tLibXzDxz
 xR1dWUc56G1hkYX23ufLgbAmLzsrIh9CpEcl4f5sNoCH1OJTLPpcaJJEguOY2mxmM3upzGwO7LG
 QVh3STVGcAvu27lqLUKKfoesGmXC8sw/Ltf2+N4q4dD69x9gPbHslR+hOKXNzGZpnLeD6j+YgQ4
 W03l1ub1xyIP7WCgDMiq+K6A4oBZYpelqgnvZYbzqA1o/tnQFZAOMJe15bqCjz1/9EIgtDKRaEz
 OQTeKdR3D7bJi6/0KudK+eXqZ2TbCYPxZ+2nRygqujgpbje1efocJA/obQ6M4xVnBcHNF4TSGgq
 B4/Y0rhk1klq/0kbJWGJaVtIRernMePM3FOGyyXJi9vUCa9ZTMF4MBw1xQdHW85bseLTDACqi2u
 oNb8J543HOcXCpkMxzQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.20,FMLib:17.12.100.49
 definitions=2026-01-26_02,2026-01-22_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 priorityscore=1501 suspectscore=0 clxscore=1015 phishscore=0
 lowpriorityscore=0 adultscore=0 spamscore=0 bulkscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2601150000 definitions=main-2601260089
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[qualcomm.com:email,qualcomm.com:dkim,oss.qualcomm.com:mid,oss.qualcomm.com:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-41463-lists,linux-pm=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-pm,dt];
	FROM_NEQ_ENVFROM(0.00)[konrad.dybcio@oss.qualcomm.com,linux-pm@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 289A487050
X-Rspamd-Action: no action

On 1/23/26 6:58 PM, Dmitry Baryshkov wrote:
> On Fri, Jan 23, 2026 at 05:12:36PM +0000, Raviteja Laggyshetty wrote:
>> Mahua is a derivative of the Glymur SoC. This patch extends the
> 
> Documentation/process/submitting-patches.rst, look for 'This patch'.
> 
>> Glymur driver to support Mahua by:
>>
>>   1. Adding new node definitions for interconnects that differ from Glymur
>>      (Config NoC, High-Speed Coherent NoC, PCIe West ANOC/Slave NoC).
>>   2. Reusing existing Glymur definitions for identical NoCs.
>>   3. Overriding the channel and buswidth, with Mahua specific values for
>>      the differing NoCs
>>
>> Co-developed-by: Odelu Kukatla <odelu.kukatla@oss.qualcomm.com>
>> Signed-off-by: Odelu Kukatla <odelu.kukatla@oss.qualcomm.com>
>> Signed-off-by: Raviteja Laggyshetty <raviteja.laggyshetty@oss.qualcomm.com>
>> ---
>>  drivers/interconnect/qcom/glymur.c | 153 ++++++++++++++++++++++++++++++++++++-
>>  1 file changed, 152 insertions(+), 1 deletion(-)
>>
>> +static struct qcom_icc_node * const mahua_cnoc_cfg_nodes[] = {
> 
> As you are patching other instances, why can't we just patch out the
> PCI_3A out of these structures?
> 
>>  
>> +static int glymur_qnoc_probe(struct platform_device *pdev)
>> +{
>> +	if (device_is_compatible(&pdev->dev, "qcom,mahua-mc-virt")) {
>> +		llcc_mc.channels = 8;
>> +		ebi.channels = 8;
>> +	} else if (device_is_compatible(&pdev->dev, "qcom,mahua-hscnoc")) {
>> +		qns_llcc.channels = 8;
>> +		chm_apps.channels = 4;
>> +		qnm_pcie_west.buswidth = 32;
>> +	} else if (device_is_compatible(&pdev->dev, "qcom,mahua-pcie-west-anoc")) {
>> +		qns_pcie_west_mem_noc.buswidth = 32;
>> +	}
> 
> Right here, set the node entries to NULL.

+1

Konrad

