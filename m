Return-Path: <linux-pm+bounces-42743-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ILZdOlhmlGkFDgIAu9opvQ
	(envelope-from <linux-pm+bounces-42743-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Tue, 17 Feb 2026 14:00:08 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 9764614C3C6
	for <lists+linux-pm@lfdr.de>; Tue, 17 Feb 2026 14:00:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6ABA3303AAA2
	for <lists+linux-pm@lfdr.de>; Tue, 17 Feb 2026 12:59:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3980C3563EB;
	Tue, 17 Feb 2026 12:59:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Bfq+l6qg";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Ovbpq5os"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 243BE3559F5
	for <linux-pm@vger.kernel.org>; Tue, 17 Feb 2026 12:59:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771333170; cv=none; b=i5aMem6/NA8gJVvBvv7QUBz2y8Bu5RcBF8fK655RJLEPnn5s56llC0v6fb5b+IDzS01AHrKdbxiHKuXHHEP3g68qAg/rTAqtRByC9UmGNyfusb0oae3QCdi8GPR69+M6pVS7h9KO4QgucQ69Nbhw1BfHCAw+vBU9VIEGr9AOXsc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771333170; c=relaxed/simple;
	bh=f+be1kKb7iTBhEbLcPLQfpNAkmIeI76TNnj9qD1y9EM=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=Y3JWE7Kvg3CUUavhcYEY30PgZfk/PZZ/lVoZKcg4xPhtd44nlvqFi204JGhmwYNAb2/2AvVBS+6an57NV6uYlfFxyHhhOWEFYDzKXTn8Kd2gbvTf/c7IWFTojmNZ/ivWzbEEq79Q/Z8pnSHEGn8OXGtOXQZCBzng3h4S2Uwo1RY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Bfq+l6qg; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Ovbpq5os; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61H54KJv2111149
	for <linux-pm@vger.kernel.org>; Tue, 17 Feb 2026 12:59:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	kDV+tE8xmcz2xVLI249DtmDhh0WqkdGqcssFz80x9tE=; b=Bfq+l6qgP1gITKMe
	eBawV23fJOoZG26MxqUe+gokeS1d7JX3hlTOB2dijZue014pa0DsX0g0t1u8YExQ
	C0HWCIinUejXjiWGymuz420BqkYp+wLb0dmGiEfdZbl9n89GkLB/O/PT/UnKoiAR
	0FMTLKOJaXik4/XftGAzXNgmiQkUo18aIiru6QD+AAHXf9TwCP4vzUy3Lbx6V2Xj
	Rv2BhUnzVXj8iPOxXffO6NiCBDTK1G1/+NYCVeMFrZ6iDgc5ocZkBnrFjlkUgde6
	CH9/g4yvPFrMiPRYHpkjyMqkJenrcD1k4tHPTq4YSU/K6aE7lCp0N2SedbbpAVIE
	3/goJA==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com [209.85.222.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4cchv4h4b8-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Tue, 17 Feb 2026 12:59:28 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-8cb52a9c0eeso3423220885a.2
        for <linux-pm@vger.kernel.org>; Tue, 17 Feb 2026 04:59:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1771333167; x=1771937967; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=kDV+tE8xmcz2xVLI249DtmDhh0WqkdGqcssFz80x9tE=;
        b=Ovbpq5osjW2NnrDnXK1BNRmV5q+LGuYsTYG/cKPkP3kh2n5BWUq1YoGp9e2e2FxpFl
         onr6bYgdBAcPBkEAU8xQig3p02Hz1B1LOFUJEIx9Kh5Tkf5QRtTq5soRn658pbkBxB+B
         VI0/0v2yriJbeSLlMSA7wH6jtVSR4a7986lx4ax+QlL3LK77TQi3nWXjLZ50BqqWkNLt
         ygZ3AgkA/haKdBcjU4F4k875/uaFVvRVwZap+T0UIb1SOGbZ4VlXjkJzrx2tGvE7km4u
         /s4RvQnBk5g2fI4OWSs+exNlSSrrmW8axxm7Ns6pEm+efWcUkPqw5MGOSHsNMUVeVzhZ
         6kIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771333167; x=1771937967;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kDV+tE8xmcz2xVLI249DtmDhh0WqkdGqcssFz80x9tE=;
        b=aqvM5C3P5/ruTx+/z5UY1sX7U95Vhz97aLdNQLDqIYgof3Me/9yfKSoVHWcWZfbDjc
         XelPHRQgnFCaZj4K0zy+LinNBgV/Emg8hDIQ7jaEqY40vRYhwJMKmQPf8ElUQUS+1+bX
         kk6byZeeLTxpE5nV8irsjsGDN2+PPF848DgGqmf1/GYWp/lI/qbOmUDlqG7LAQDNhe5c
         n3l1zzalVy4A0awXmnFo/gGM//1QR3PlPJEucUkoM4RPNotuD1/wnYpivJnXl8otMScy
         LqJTvmVLQaGnVe2MvfdOpeT5gYTMhgyiDVrr+xnP54f22WzG3yyRhBIjfNfey42I0jmS
         IquQ==
X-Forwarded-Encrypted: i=1; AJvYcCWQLsSm3qWXREiRxJT6sgtzj94dNWdvMyKeX5CErJ1ocpBXhZDLCG64CMt9/Ht5W+gvg/cbC/RoXg==@vger.kernel.org
X-Gm-Message-State: AOJu0YzBM8fUAi1PkFHDAidm1ZiOK2+NJEgepmRiQNSXeaLDQp9tW3qX
	tRahHka1N2tR/lWqURgbFHa1GpdCGpW/NFAawYV52Hh9CGGNS8z/vNwquoYTTlb0zg9feU3uInf
	rYdCuX8DwOvfd+wknKOuIjQH+BORXnwIXnB8qdxBPUzNW+nlPu5vZHgtpBjr+MQ==
X-Gm-Gg: AZuq6aICdjYmeuPsCWlVq1bJx9FV4jlPsRpGBHz3uAzXK5Qq3Z3OpTTwGhYMaMmpS3h
	1JlOLxLBZk3hDH1UEAfBPHV3yn5ZNR7vxtkx9VGXL7rWzT0mLxid5QJZGRPxPJA/xCfU0EKnm1A
	bekgwIJK7vpt/d4PWek9B9iPHJXUt5mMSrYwJV5tZf1bBS7vbKouiuTOxMwtpThm/vQLbjSfmdC
	GHNYVuXVKngSEryLlC+vopMwP8+n65T9dtRPBETe74QS1kqLlXheC+L2zCV80xUXJyXSpSP510l
	vKrykof/kHWYMB5QnmMqApddP27gr78bW/2IgcLHxkJPBJEBogfbcDhI7KJaYVmG4rv73sGNV8N
	cxUCOvVj208KkuvKSkNL/4ElmKAgtnDMAZC+0ew+bkJ+e2J1cdg==
X-Received: by 2002:a05:620a:1a86:b0:8c7:f79:bd7d with SMTP id af79cd13be357-8cb4c006608mr1365684485a.62.1771333166797;
        Tue, 17 Feb 2026 04:59:26 -0800 (PST)
X-Received: by 2002:a05:620a:1a86:b0:8c7:f79:bd7d with SMTP id af79cd13be357-8cb4c006608mr1365682685a.62.1771333166432;
        Tue, 17 Feb 2026 04:59:26 -0800 (PST)
Received: from [192.168.1.29] ([178.197.223.140])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48371a34d66sm129927125e9.20.2026.02.17.04.59.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 17 Feb 2026 04:59:25 -0800 (PST)
Message-ID: <f633c9b0-8773-499c-91af-3cf438ed52a1@oss.qualcomm.com>
Date: Tue, 17 Feb 2026 13:59:24 +0100
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] dt-bindings: interconnect: qcom,glymur-rpmh:
 De-acronymize SoC name
To: Georgi Djakov <djakov@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd
 <sboyd@kernel.org>,
        Raviteja Laggyshetty <raviteja.laggyshetty@oss.qualcomm.com>,
        linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org
References: <20260217125819.281209-3-krzysztof.kozlowski@oss.qualcomm.com>
 <20260217125819.281209-4-krzysztof.kozlowski@oss.qualcomm.com>
From: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Content-Language: en-US
Autocrypt: addr=krzysztof.kozlowski@oss.qualcomm.com; keydata=
 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
 cwzYbmi/Et7T2+47PN9NZAOyb771QoVr8A==
In-Reply-To: <20260217125819.281209-4-krzysztof.kozlowski@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=eYAwvrEH c=1 sm=1 tr=0 ts=69946630 cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=6nO30s3o7FuWeffXwhKHTA==:17
 a=IkcTkHD0fZMA:10 a=HzLeVaNsDn8A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=Mpw57Om8IfrbqaoTuvik:22 a=GgsMoib0sEa3-_RKJdDe:22
 a=EUspDBNiAAAA:8 a=Rh8BIR2qzSpX2dRZ-WwA:9 a=QEXdDO2ut3YA:10 a=Qzt0FRFQUfIA:10
 a=NFOGd7dJGGMPyQGDc5-O:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjE3MDEwNiBTYWx0ZWRfX0JX4DAGMlJDT
 Oi36B6E7rPW6/5m1ceI92HwGV3TXUjNfIWYI9YAXZootRkWRQxzTBwGp28LDzNzbEU2m4jGenvQ
 C0rZrh33lY8I6CSXkVxZRhqJwuOvf/mlWc5bQ0h50BBueS8w55UhgVfp/oSAEo/EJGurlMksdU8
 VX/DETMyy23WpjvJogWGYNzGtKBsQ2ov4EQMabZSZxP6BcPjEFTJvpGkMwg4N7KEOGDlakmqLEX
 /zoh+Egd0Ta53SgMOC+RojMg0r2h+wLBhjlCm7oLQQC/GdfsQTih5zOsVIFvkgHbFhaPgFfTNs6
 WGQabR1GUyiUDXAO91E9jpUUILe2K+vxYF8tgWXOBRvJu8XFYyQBu6MVfj5sWyM65sCA1xH94GB
 Qxrc4axIMzQwzocNorrmFrG87Vzi4s/kAfu+ctDvBUbKNXg93oi2KkHf2roo2y/oH+jVT/O+Vf9
 +TPKEEcGPqA3f+JMqkQ==
X-Proofpoint-GUID: 1M0KgHdpxeeJZHz31pSe_kArdHQ--8Xa
X-Proofpoint-ORIG-GUID: 1M0KgHdpxeeJZHz31pSe_kArdHQ--8Xa
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-17_01,2026-02-16_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 bulkscore=0 suspectscore=0 priorityscore=1501 malwarescore=0
 phishscore=0 impostorscore=0 lowpriorityscore=0 adultscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2601150000 definitions=main-2602170106
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-42743-lists,linux-pm=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[qualcomm.com:email,qualcomm.com:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,oss.qualcomm.com:mid,oss.qualcomm.com:dkim];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[krzysztof.kozlowski@oss.qualcomm.com,linux-pm@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[linux-pm,dt];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 9764614C3C6
X-Rspamd-Action: no action

On 17/02/2026 13:58, Krzysztof Kozlowski wrote:
> Glymur is a codename of Qualcomm SoC, not an acronym.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
> ---
>  .../devicetree/bindings/interconnect/qcom,glymur-rpmh.yaml      | 2 +-


Uh, apologies, please ignore, wrong patches combined into one patchset.
I will send a v2 for this.

Best regards,
Krzysztof

