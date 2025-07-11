Return-Path: <linux-pm+bounces-30680-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E3ECB01BBE
	for <lists+linux-pm@lfdr.de>; Fri, 11 Jul 2025 14:16:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 84C995A59CB
	for <lists+linux-pm@lfdr.de>; Fri, 11 Jul 2025 12:15:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FD8724676F;
	Fri, 11 Jul 2025 12:15:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="g6k/UOfc"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FBDB1DA4E
	for <linux-pm@vger.kernel.org>; Fri, 11 Jul 2025 12:15:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752236112; cv=none; b=dxpY4dcSOxcgxJlkTHPPrXCTvLQW9lOETJeQKAJQYj3Y5lq5PotAQJXdpS5lgCj/Pwz9pB0tJ9GMD3ZlN4dPoyPpmbMf7PToIUTfHkNXDvzSHTCK1njzGujW4Y7fZuENRH3RqxDfE1/XjKid7r3G0pXUf6J1qmSv8YrWFWVOylg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752236112; c=relaxed/simple;
	bh=Xjn5ySGEMA9LsrxbMTZ6SdqT5i31QukUV4A0p1xnku8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JkpN0JLCI7tie8XNe0UdScbm23f+QYmzyK1oAi+BHtFTXl76RiuwKqvNFfNntlPq9hk9Ke/dA67mD7wMkZGgJF1KeXamTMG9hK3XTtxuqe7xX+WQHedFdGN/NqEnOO/ORHqrGb1Gd+UL/y8P+mIniWwMNjZnfpf4J8T9f9MoX+0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=g6k/UOfc; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56BB3J9Y031220
	for <linux-pm@vger.kernel.org>; Fri, 11 Jul 2025 12:15:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	5WmSJVa8+LyzMZ7AuALMmZArLhe9+Oxn8lyjPgHFxns=; b=g6k/UOfch29P5CwI
	pqtIbwhQNYh5wJ/FG+d5qTLMv3uOF9J4rZS8PlXlw4ARvQYZ96QHgm3DQFKi2uAz
	v8rd+pwUwbnPMKXl/IyIel8uZh8YOw2CcTn9SZQMGQyQleDmkft5vZE2lYuss0/N
	0HZWFHax5VC52ZJguWDzh5L/tBw9jOjjEMpR5Lieo0mOqKVvvdSTNqTuckwroswg
	MvPwRtZeg1AAEOXG92f9aU+B5xtiRvfVbzo2fVY5JIr+qidvo+E3IboRLrDrEVtX
	3H8NO0Ot3lxVFcNUvMbC+TThfLfawJliw6yrbBHTNGmVZCRiUyfBfZX1oqLCpCda
	FmRWPw==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com [209.85.222.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 47smberjhp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Fri, 11 Jul 2025 12:15:10 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-7d3eeb07a05so31664885a.2
        for <linux-pm@vger.kernel.org>; Fri, 11 Jul 2025 05:15:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752236109; x=1752840909;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5WmSJVa8+LyzMZ7AuALMmZArLhe9+Oxn8lyjPgHFxns=;
        b=hpYLAmOs2HxPanH5mIxTw0Ro+9OSZeNvz/pE112oA7FTqqNKuzA60hwjaSjohsno7t
         sW/FDRPKxFy6UPDNnmq6QKWNA7SgWU/iDpgoOu0yh/7HEb9Rrx4RLWhQzDMcy2eKTVnU
         OFu8g1qefA9U1pfSHHV/8lS5nrYub9MJvbzgDfCkKBPMrnB1qq+Tjpkt8WUXzQNA4dGy
         TKny8BbonQMZ4azoWu4CSOH85xnvj6Jt7B/pGd+HQgFDnnXQ9h0DYxc0w09FyO3MXcE9
         EqoQSdWhCsW6de74FljckWZ9xVgRxcLDOgkZMLcRHuHnL7WNGhUZ4qrRbSkId88o1wxH
         1uqg==
X-Forwarded-Encrypted: i=1; AJvYcCWTdSbzz0kS/fwxh3ZeCqH25a8kV7Aq/8aIpzs6V1njguMu7B33vZxoch2NtcXRbF24PanVHsIpXQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YzFjauphlAjbhl1w+CkW6a6DiMhRgDAIGLMOQR4H/aO4mrONcZD
	0+7igA8TsIRyal8vMBKzJvRkF3qwNz4gLVvBCfQy4N2gOiUOpyps40+CJdfiKa/vrCxHGPWB2p9
	mc0afTh2U1aGOXZItv6ZDKqm6JZ2bQ6CpyoFkSOun5IJxmUSRcQAuorXKW78Agg==
X-Gm-Gg: ASbGncuGsWCYHiyyv5ThWX2eX+W+7FK0LnOS7W+nUf8NQMMSRLChYOWCEt5upHy8823
	WT27BXq4Eq25wDYSM4mdBDDNaa9kjE++L1JA9JTyhHypfx8cnQ2ZuTOJvgF8YtUmYofWG7NP1Vi
	hOfrXhIlCj+cnqaUWzf5rBGvq6/JEhGd0t8qa9Gg4zzVpJOV0AeuB7/kbBb5y8EcY1ezboYPGjo
	O0lNh+3UouScSwBAMFq6sQZTQ79OsdAKauGtlj5HjM9HfEIX5+0MgIP/A70AgcxOLIhgnl5Btx9
	SeIIclAdegkzg6APSmyMwIysxXjOV7MILAr9YLbbWKvP01UT27hWCEjzxzsrZKypfLhUs+Cauit
	fL65ZtSvB9nrGFwJ905bc
X-Received: by 2002:a05:620a:438c:b0:7c5:8ece:8b56 with SMTP id af79cd13be357-7de989b3079mr130008585a.4.1752236109105;
        Fri, 11 Jul 2025 05:15:09 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE9IlpHxAb7R4TrzGfVeGwtAC/FU5V/+FMIw/QGwRVWYeM3sTSRsEHYiAI4QhJLyZVlXQj3Zg==
X-Received: by 2002:a05:620a:438c:b0:7c5:8ece:8b56 with SMTP id af79cd13be357-7de989b3079mr130003685a.4.1752236108508;
        Fri, 11 Jul 2025 05:15:08 -0700 (PDT)
Received: from [192.168.143.225] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ae6e82964f5sm293248466b.143.2025.07.11.05.15.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 11 Jul 2025 05:15:07 -0700 (PDT)
Message-ID: <93082ccd-40d2-4a6b-a526-c118c1730a45@oss.qualcomm.com>
Date: Fri, 11 Jul 2025 14:15:05 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 05/10] dt-bindings: clock: ipq9574: Rename NSS CC
 source clocks to drop rate
To: Rob Herring <robh@kernel.org>, Luo Jie <quic_luoj@quicinc.com>
Cc: Georgi Djakov <djakov@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd
 <sboyd@kernel.org>, Anusha Rao <quic_anusha@quicinc.com>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Richard Cochran <richardcochran@gmail.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, linux-arm-msm@vger.kernel.org,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        netdev@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        quic_kkumarcs@quicinc.com, quic_linchen@quicinc.com,
        quic_leiwei@quicinc.com, quic_pavir@quicinc.com,
        quic_suruchia@quicinc.com
References: <20250710-qcom_ipq5424_nsscc-v3-0-f149dc461212@quicinc.com>
 <20250710-qcom_ipq5424_nsscc-v3-5-f149dc461212@quicinc.com>
 <20250710225412.GA25762-robh@kernel.org>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20250710225412.GA25762-robh@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzExMDA4NiBTYWx0ZWRfX0JAN82njbX/i
 MI1/ZBbt2LslvcIG3YH/v93Dns+tVZQL5+ANn2HuBGXZgufoAgkA3mwl78ZC95GV7/t19nUQR9F
 JGlAd857HozFp9Zbkl+o9dinAQxxOIiOTEUHum92btNIjekLRDKh062442x3KCXwUtuBVpQo0sB
 M3soBZQptXPa1iVtf1b8L4UwJMQ7cfMepXVk5a3brxE4Ja2Pv+UxhW8hRY9wgxa0UP0mQOWhu7S
 JESqaa6+o4vwzQi1HSplXw+Nf5KP8fzlM1PRSRxyTLPWaa26F/UGaY86i1IdE/kh0l0Hglen5TP
 5TK0hGbJp0ad0qrfm3vOu9pgoe4pDSSd9YphLCTArAisvJP5v+5I8/HPMQZ2QKh1QNsM58BwXBQ
 IVoN7yVxWGKHl7WedAqDawrvE8pAfrCFdqdSVJ4uAON7oTczCQSpVurjzA8rfXalwb+YCifi
X-Proofpoint-GUID: PVrtC2axcaIGJZrYdJRzGcuX5EJGqq2l
X-Proofpoint-ORIG-GUID: PVrtC2axcaIGJZrYdJRzGcuX5EJGqq2l
X-Authority-Analysis: v=2.4 cv=VpQjA/2n c=1 sm=1 tr=0 ts=6871004e cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=icw32r7lKnDoEl_Wh00A:9
 a=QEXdDO2ut3YA:10 a=IoWCM6iH3mJn3m4BftBB:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-11_03,2025-07-09_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxscore=0 malwarescore=0 suspectscore=0 clxscore=1015 impostorscore=0
 phishscore=0 mlxlogscore=999 lowpriorityscore=0 adultscore=0
 priorityscore=1501 bulkscore=0 spamscore=0 classifier=spam authscore=0
 authtc=n/a authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505280000 definitions=main-2507110086

On 7/11/25 12:54 AM, Rob Herring wrote:
> On Thu, Jul 10, 2025 at 08:28:13PM +0800, Luo Jie wrote:
>> Drop the clock rate suffix from the NSS Clock Controller clock names for
>> PPE and NSS clocks. A generic name allows for easier extension of support
>> to additional SoCs that utilize same hardware design.
> 
> This is an ABI change. You must state that here and provide a reason the 
> change is okay (assuming it is). Otherwise, you are stuck with the name 
> even if not optimal.

The reason here seems to be simplifying the YAML.. which is not a good
reason really..

I would instead suggest keeping the clocks list as-is for ipq9574 (this
existing case), whereas improving it for any new additions

Konrad

