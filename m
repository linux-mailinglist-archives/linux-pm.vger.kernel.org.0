Return-Path: <linux-pm+bounces-41528-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gMWRLRCpeGnJrwEAu9opvQ
	(envelope-from <linux-pm+bounces-41528-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Tue, 27 Jan 2026 13:01:20 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 50A5093F4D
	for <lists+linux-pm@lfdr.de>; Tue, 27 Jan 2026 13:01:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 705153004D24
	for <lists+linux-pm@lfdr.de>; Tue, 27 Jan 2026 12:01:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C882730F938;
	Tue, 27 Jan 2026 12:01:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="dK7+b+Qi";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="ZV6tLxXb"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C93D2D7D3A
	for <linux-pm@vger.kernel.org>; Tue, 27 Jan 2026 12:01:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769515273; cv=none; b=AXvJ58PANqTBQVohOHFOosdSE4Ad3WDJKM6fA9AB4RAEry/v46RXB8ZTDgnQO8wGc4+2pHNRZDWgEtUvxG2wT6EbklbKzeLDVoKTUL0AQr2VS2I3iRZ95ApkszyzOoUZdrawAIcpji/6lWa5a+W9telo0FZSqQGnoOBqdigF0GM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769515273; c=relaxed/simple;
	bh=59jZC3zVM0ODzHrMCPvgBuMQDB3OwB67FU4fWRwKHGQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fmqjsnPtd4dPCag4/nsm8hw0Tf7zA09qy7hXKyb9afq34G29gYp0RPWgSdS0z6cz4OA/ijwpBbtT69up8wBcXVKHW6bB1vSI0YOkS6v01sqrXTLmYjKiDUT/hrJ4uqzL2HKAy+JOor8YSjha1Dy31SYTeU3O69pH3iCUdPlEMUY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=dK7+b+Qi; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=ZV6tLxXb; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 60R9vYZ1171435
	for <linux-pm@vger.kernel.org>; Tue, 27 Jan 2026 12:01:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	zoZb2MS7iH8UWFdtI0bG1tG2Hg+LVF5otZHfxHqr3mU=; b=dK7+b+Qi4tE7j2zc
	tsVzwmAQTaQryCovB5979t1lkteqtjSlYu740iqhZy/olDqRR9r0Kzy16fA1v8yC
	vdyPqRJuSd8EX+Nr4qs8p9iL+AZW7BIQW+NSiiKvPoFRUWx2cGIZhrVsPoOfrHnd
	iur+rHLYOLdAu/Nk2e7llsjqyxwzwJ0REa8250QEehuqBob/t8IXQhEIOAtGjZaR
	3jmB0+OcAEKOZaa1rTWxEmARKHh3MFySbGRuUktN4HiGcmAIPHG4imcfe+cwN96T
	aMWNEpgIPH0rNI2QcV00yDpMsLRdh2Iqo3vGH1/DEYXhzwkYQ6QDNyiFBljySDSi
	UZo0XA==
Received: from mail-vs1-f70.google.com (mail-vs1-f70.google.com [209.85.217.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4bxf3a2q2n-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Tue, 27 Jan 2026 12:01:11 +0000 (GMT)
Received: by mail-vs1-f70.google.com with SMTP id ada2fe7eead31-5f52555c106so1070605137.3
        for <linux-pm@vger.kernel.org>; Tue, 27 Jan 2026 04:01:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1769515271; x=1770120071; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=zoZb2MS7iH8UWFdtI0bG1tG2Hg+LVF5otZHfxHqr3mU=;
        b=ZV6tLxXb3SeExH/UbE/ejJR7CrbnJfOY1ruVy7GhDm9tl6SXwzsnu7NCACRry/wACA
         c4HwqReQH/iKoT3QW37W3Z3d9JUYNkYyx/T8tmApC+RnSi/nZIYckapf9C3CLAF8fwFt
         noKnUuwhd1cAaUWgeGdrPpqPDcbS6lZV8d1VSgaOwcHysMOqM0Wzsw8LHe5hV0YLPQKb
         EljfHNIWx4hw6Krx7tRmF2lSXqVg4imCa+igRGP3PMFUo9nbols6VV6xwoVhwl7cWN8Z
         dcVM8W5MEUB21tB2J/QdvCl+TxQg/zILxLynRMIrfYJhQXeZdsKtCAM/FNlFn2GYVNpF
         FVdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769515271; x=1770120071;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zoZb2MS7iH8UWFdtI0bG1tG2Hg+LVF5otZHfxHqr3mU=;
        b=jJZZATds77tWMM245vu9hM5wL18ul0Mc95iSPSZpTlgPpcHygNBExSsAlGaYVXE+Ku
         kbHXMouiUOdoRaHFi1Um9K3hSR3+pvI0IDR+qHrhvgbnvlFFRIQwIOnwRUvd7wujCLc6
         bElDFaEWRc6pQJCA+QiuAhTxEag03F4xn5/su24i/q9shLxbO5l+iz5eMwjKWqXXaSFB
         WSiZizRuGkVCRqp52E9dSpCKJk65qNOvNQQikzoyLsSF55ca+vzVHcYDpFY/nhqbdfCn
         rkY5JBpqiGX8Pjxego6S6KIHHqEBYpotS/p/x/Q+Jnwl5vIv5alfNE/tvU/Ii8XAFVD/
         AreQ==
X-Forwarded-Encrypted: i=1; AJvYcCXZM/8HPNVjCLP7Z6EPEviq9vYBa4xDv28gBjz24GpD2QELbL8HbB4kT80hkTpNSvyMhDcN+BYVYA==@vger.kernel.org
X-Gm-Message-State: AOJu0YyODFk0Bow5LX0Xt3vtO4HNPhhtc2qudI+jr+5BPkoDEp3BU+iv
	Bs8Y0XoyceDyQxNQhySXUksSzGoO8AFX9jiu2ahGhcLAGRdLAuUpJvIpZpkDj/nxOglWXhxJkzz
	jq/jYNNdOTgorl9TpPr8xZj69LslMZ5NahNsh+FIyTIeHQPGHDGm9V/05s72lgw==
X-Gm-Gg: AZuq6aLxP98GbTI3MpJ/LJRBJCAVjCSYB6Ne7Esir3HvWwAi6tovKNmRMmxcVbqWeAd
	pXFe0EbvxQDwmsrZsj8ywLiW0k+rWTZOUWZeS+KHF+3BrqUfVDbFks/6vgiyJa9hPyfBhlNetro
	AQzMJ48PHcO9lebLkHCJ/iORx1CHN59OvmUy4S9rXNI0S3ShSFWkntt9MyCkPd8uYutYlFQ9BwL
	RO8OWo/oYmTBvCM3kqbDRtn6GsU4jGx6vULsNskNqzrUmNqZrfnhCIXT4eySMYHHUn5UFusFaPO
	HAbSw6NsF8PTu2S2tB0wjYizdWkESPJdB1/kWQvYjiPmozbShT2u4S4J8aoc2Zmq5GFG8KpS84x
	LTOrUUwv0FsXd9FpsicboyK03NSGCdc2f5VIm3htmDfQcw5CuC9+wyfr29KN4lI847DI=
X-Received: by 2002:ac5:c752:0:b0:563:3eb4:74de with SMTP id 71dfb90a1353d-5667935b563mr172591e0c.0.1769515269112;
        Tue, 27 Jan 2026 04:01:09 -0800 (PST)
X-Received: by 2002:ac5:c752:0:b0:563:3eb4:74de with SMTP id 71dfb90a1353d-5667935b563mr172568e0c.0.1769515267987;
        Tue, 27 Jan 2026 04:01:07 -0800 (PST)
Received: from [192.168.119.254] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b885b3dac6esm810273266b.7.2026.01.27.04.01.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 27 Jan 2026 04:01:07 -0800 (PST)
Message-ID: <c01b5b95-2aac-482e-80d0-89cc1599bc1b@oss.qualcomm.com>
Date: Tue, 27 Jan 2026 13:01:05 +0100
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/2] interconnect: qcom: glymur: Add Mahua SoC support
To: Raviteja Laggyshetty <raviteja.laggyshetty@oss.qualcomm.com>,
        Georgi Djakov <djakov@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>,
        Mike Tipton <mike.tipton@oss.qualcomm.com>
Cc: linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Odelu Kukatla <odelu.kukatla@oss.qualcomm.com>
References: <20260127-mahua_icc-v2-0-f0d8ddf7afca@oss.qualcomm.com>
 <20260127-mahua_icc-v2-2-f0d8ddf7afca@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20260127-mahua_icc-v2-2-f0d8ddf7afca@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTI3MDA5OCBTYWx0ZWRfXz5Wt9X5OjpvE
 8l4hnRdXpY7iw2Ey8A2VMV/emrEabsAstGWQN05UgyTK1iJSUvFbLUzaeROpnYAtJlzovpkLqLQ
 ifgDpgqsUq2Gqmd11D+UGBTQ0RORpvj77i2uDOn6udRikN99g6MSJFhqsNY/o8z00rGfnAqEk+u
 +yRgNsWppf4YFBliHzJ9GI931umGcrVut7yHB+BSefDldlDcsOqteOiFyxcOw3MTp3V9+CuzaZm
 oKL2fiUBBSIS6L3X4ExzAE0WB0ndbgi3JKrOKNVWVToI2lBMLx004rGCdrBvz4qg901bCg0Xux2
 YFcpJQ15i0jIsldd3ZK227+zMreICvrQSfLw9tlWJ70J3xQZJ6AedFbtWY/ZMkek5nfYiU04tt5
 sHecUc4lxSsW1Mdyrl5fTiZJPkWLIXJpU5jCN84tLB7OqmuTTE+LbbPdnEftbPsISaD6rzhbIWs
 619icjBTKhugbuNjpQw==
X-Proofpoint-ORIG-GUID: gVrLh1KOnBHN4BCREa1fH5vRmc3IJxeP
X-Proofpoint-GUID: gVrLh1KOnBHN4BCREa1fH5vRmc3IJxeP
X-Authority-Analysis: v=2.4 cv=a6k9NESF c=1 sm=1 tr=0 ts=6978a907 cx=c_pps
 a=N1BjEkVkxJi3uNfLdpvX3g==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=vUbySO9Y5rIA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=EUspDBNiAAAA:8 a=GtF0_HNWVELJq49vNZ0A:9
 a=QEXdDO2ut3YA:10 a=crWF4MFLhNY0qMRaF8an:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-01-27_02,2026-01-27_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 spamscore=0 phishscore=0 lowpriorityscore=0 adultscore=0
 priorityscore=1501 bulkscore=0 suspectscore=0 clxscore=1015 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2601150000 definitions=main-2601270098
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[qualcomm.com:email,qualcomm.com:dkim,oss.qualcomm.com:mid,oss.qualcomm.com:dkim,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-41528-lists,linux-pm=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
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
X-Rspamd-Queue-Id: 50A5093F4D
X-Rspamd-Action: no action

On 1/27/26 4:22 AM, Raviteja Laggyshetty wrote:
> Mahua is a derivative of the Glymur SoC. Extend the
> Glymur driver to support Mahua by:
> 
>   1. Adding new node definitions for interconnects that differ from Glymur
>      (Config NoC, High-Speed Coherent NoC, PCIe West ANOC/Slave NoC).
>   2. Reusing existing Glymur definitions for identical NoCs.
>   3. Overriding the channel and buswidth, with Mahua specific values for
>      the differing NoCs
> 
> Co-developed-by: Odelu Kukatla <odelu.kukatla@oss.qualcomm.com>
> Signed-off-by: Odelu Kukatla <odelu.kukatla@oss.qualcomm.com>
> Signed-off-by: Raviteja Laggyshetty <raviteja.laggyshetty@oss.qualcomm.com>
> ---

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Konrad

