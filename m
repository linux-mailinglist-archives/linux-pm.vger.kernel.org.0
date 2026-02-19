Return-Path: <linux-pm+bounces-42864-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +DWJFvfelml9qAIAu9opvQ
	(envelope-from <linux-pm+bounces-42864-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Thu, 19 Feb 2026 10:59:19 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0551915D97E
	for <lists+linux-pm@lfdr.de>; Thu, 19 Feb 2026 10:59:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1C0443023DE4
	for <lists+linux-pm@lfdr.de>; Thu, 19 Feb 2026 09:58:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 806EE31AF2D;
	Thu, 19 Feb 2026 09:58:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="cWHA1eWy";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Mmd2HkWw"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5668C2FE57B
	for <linux-pm@vger.kernel.org>; Thu, 19 Feb 2026 09:58:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771495134; cv=none; b=YaURo44J2eV4gKfSkuKbR0Lfa9/RZugzZQw/PimQTGafhxIY9uujsvx2Tv9ABZZpitNCnPJmtgrM7QReli6hpgZHXLyR4A5S4PaKaztg7Y0rrY549Wt8N31eZEZvjUB0iq2cYCeU2BVs974OPRPzwrPhNDWpzMavYJl9qWGOKeA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771495134; c=relaxed/simple;
	bh=pdfpoC3jVEsg2mTi9NV5+lcx/3u5nMQepBsWbZrdRTg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HHhJ4VBuH26RgVZZOkZtV9nbMkV0Rfi55siAD9y1ez5FR1Atki9umOBssHNk6ZJ+k45gwNu1T/E+RzriTF9/SB8yJlb9/RQq2Xz4MZiG0mQFepMvkUvsF71S/Te2UsLWm2N3lZubBo4MtL3mgqZEC+ghnGU2dngzRAc7/gfYMAs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=cWHA1eWy; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Mmd2HkWw; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61INP1Tg1167951
	for <linux-pm@vger.kernel.org>; Thu, 19 Feb 2026 09:58:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	dp6lkKnOQAqyAsl7Ok59pbcSrf7YRsjhfIHiueCYf98=; b=cWHA1eWyOwzvfz6q
	lh3Fe1jp1wHjvxgNo4thGOeHAb7SY+jtYGMjmOhlojzUxWiTs0dJiBEvsBVAD4RG
	LKwZHoV7/fY/GnuuZsNzcl7SlPpPHgRzoeJauve8p7572GDz0jif9kpSds8NQ1hd
	zJcUmzRgeyuQV1eBSMdDBvfl5KsOJv9aE/w8oSvDeNn7wn7EdfOwgn7XjUMojSdX
	kRH4h+TNLkhPFSGUkmwO3kn6d/rahn2V8qpZTyAbI6VI/bm4M4j6F3jOx1BBYmC4
	z2ElB5xops+fmzVP6D0tknKHNFLt2rfMddWQ/52QkAuwYXWXRq3forJN6Rdgvks4
	KNdgAg==
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com [209.85.219.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4cd3ahcgvb-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Thu, 19 Feb 2026 09:58:52 +0000 (GMT)
Received: by mail-qv1-f70.google.com with SMTP id 6a1803df08f44-8960257db65so6990126d6.3
        for <linux-pm@vger.kernel.org>; Thu, 19 Feb 2026 01:58:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1771495131; x=1772099931; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=dp6lkKnOQAqyAsl7Ok59pbcSrf7YRsjhfIHiueCYf98=;
        b=Mmd2HkWwsH79SojZ+NebTrIWywN61KmT+vfQ772WibbiBWyj/Sk2PvXqNokh278iZB
         4jo1IvHNDZq0E9LAMeqTLsq3nHzxeDNdRzgYQmbEZopyl7F+xPgF3/04Q3mKg57wqXjy
         /I23G5OeEifL9cDpZ9s9aA8C/T0TYV+gUSSfr7UOPfrihIs3Oe29w5aP/uuJCVMPMdz3
         sGDM5c4i09DXvWcMBGtymU0DPvmNK+J6fTCrvRsN7BSAvxqZBV1TphukWr2+Yz1XvAKa
         iEpV8vVu6myobirIZQhpRuP8/KKMFJ4YKeUALKf4kD2rnj5LNH21bIwlHAuRxRDqxbKl
         3NCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771495131; x=1772099931;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dp6lkKnOQAqyAsl7Ok59pbcSrf7YRsjhfIHiueCYf98=;
        b=C4ppoDQobONTW9H+JI9V2dFqBs1+lZTdlVJnb56jlRK1E9ouL0NOLjle2JrxrTzQoS
         9ZrrKDH7uxDjL7PXpuK/ycDaDN2s//THDj+4lPYSoWiYQKD8SuyYYOc3mY26AgR80ODZ
         hskRBlWJqXX+wumbeUcOIlTL9H1s0Sp7q4kYH2rnYSrVUaAgfxbnlxcLkMQl7Gqx/OyT
         /1UP+yf8as5Jn4r4zsQhPLZHiTKntvtURX0VvWFep1Bhk8XMr9/Efy8bxEu1Ra0EQc2G
         xGjY141upi0BK8emY6KvMp4vaO/Fk3bs6v9rr2/5JhaFb49/xbGdRvPX1F9fsFLMHtFK
         PdoA==
X-Forwarded-Encrypted: i=1; AJvYcCW66L44/uZ/ttrsCwUFpIVJEkGcVef48UD4QgF4yJ922RC0eoFWljjSeDhWof/XCrC/0zI+71pYOA==@vger.kernel.org
X-Gm-Message-State: AOJu0Yy9RlCpS19/D6YaBrx8zFxwOhOX+VOQ2NYsDvDmoex1x7cPXR7X
	bHj7GpKIMn/54zHq51lXZbxXA8qx1eXgUMJqj5fIty/CZQVzPBlkmoclM4Sa4ZdCorzN/97gJ6+
	BRa2xZ1MBT37YzLFuzzz2e+6qNAuejO2DZsRCHKq+Fg1kDDW4GUOJgnTRUt9rsw==
X-Gm-Gg: AZuq6aI9JNro1EeD3Z4S6qeYhzhBU9WIQjTBNV0KaAz6pk0JuvCRF6hL7xAO1M78Rcs
	el3qfRsFCUfTlS2QulFJfW6ej1AlpbBCTJYfZZ5xZLd7+V85QSdX0X/ctw5M4xTauSiZyduDexN
	8GHUMXaLhwiU+brxwrSTjI05nKVVP7/twfMoMzWeMoUZeqLBuj00l4F3W4wM+jtxEfJKnjlGM1f
	S5LtP/wVFkmG7Fc0NwWaPuWe6PUSzhcUyOQq7t2m33EaLg1/qLDtvLOizO7eqY3pb+S8Wecglm1
	8dE0VN+50rRQlXaHsOFCUeLwQuIvpQsUUm5FzokvL2aRDkY7DMkZg4W4QKsOEVq3cgSzl8iyPOA
	jJ4WylsAn/VVk5onD0TY1QfUWGShJURwmziA5IxtVwLhqV9a68dRpA9phWRevWggFnVOdcXOOHg
	JJZKA=
X-Received: by 2002:a05:6214:8095:b0:896:f9ed:bea1 with SMTP id 6a1803df08f44-8994ac78794mr89723306d6.7.1771495131475;
        Thu, 19 Feb 2026 01:58:51 -0800 (PST)
X-Received: by 2002:a05:6214:8095:b0:896:f9ed:bea1 with SMTP id 6a1803df08f44-8994ac78794mr89723176d6.7.1771495131050;
        Thu, 19 Feb 2026 01:58:51 -0800 (PST)
Received: from [192.168.119.254] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b8fc7627fa7sm562549666b.38.2026.02.19.01.58.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 19 Feb 2026 01:58:50 -0800 (PST)
Message-ID: <1c43591f-ffc3-433e-94b2-8cc7bdb3ec62@oss.qualcomm.com>
Date: Thu, 19 Feb 2026 10:58:48 +0100
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/3] arm64: dts: qcom: sm8550: add cpu OPP table with
 DDR, LLCC & L3 bandwidths
To: webgeek1234@gmail.com, Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>, Georgi Djakov <djakov@kernel.org>,
        Sibi Sankar <sibi.sankar@oss.qualcomm.com>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
References: <20260218-sm8550-ddr-bw-scaling-v2-0-43a2b6d47e70@gmail.com>
 <20260218-sm8550-ddr-bw-scaling-v2-3-43a2b6d47e70@gmail.com>
 <f8c2fe29-9e38-487c-b32e-7ce151403a7a@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <f8c2fe29-9e38-487c-b32e-7ce151403a7a@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=Zo3g6t7G c=1 sm=1 tr=0 ts=6996dedc cx=c_pps
 a=oc9J++0uMp73DTRD5QyR2A==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=HzLeVaNsDn8A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=Mpw57Om8IfrbqaoTuvik:22 a=GgsMoib0sEa3-_RKJdDe:22
 a=pGLkceISAAAA:8 a=EUspDBNiAAAA:8 a=XEhIh8xtOs_--jVvVqkA:9 a=QEXdDO2ut3YA:10
 a=iYH6xdkBrDN1Jqds4HTS:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjE5MDA5MSBTYWx0ZWRfX9mzDXzLiSNNs
 WhIo/oln0hfAaEQRp9kM139mgNDI7vhc0Zi9PfuiDkRcquDSpUchAyuoa6c3vqoJq6GKm+oWLio
 eQHh9xCthy4ZcjFf/1I3MnmoACaTQVNpjekUn+ll2j+FGrMRQMNW/muUW71gPn6IfDqdYK/A36u
 bSlpijzurdTS7IJPDPY35P1KsWnozemavcEEmytXypagyDqqJQGDOeLt+2QKwMIU5AP0IZhzqO3
 J/3ODVfRaAzR7LS7utND4RHmc0u9SUsyRKt2LRLBnnxLiMSbo6hN9p1/C31hh7njyptseu0q+33
 G5HUntoUCt5OaQ59zVrZlnpV/HUccpCSNhzMafb15muqcToSSB5CU7EkPP3EtIw3DgZWwOJ+aji
 cM6s9EZiOkrBi1b417tqPMh53hHUAEEUXKnGjda53NtozO39zKv4wEvIm0NoWPKw4ixcT0eIGYi
 NjHHVY2oZR5Jpp9E9Mg==
X-Proofpoint-ORIG-GUID: RXsagplf7oa60j-QdoixlOifBdzYw6-7
X-Proofpoint-GUID: RXsagplf7oa60j-QdoixlOifBdzYw6-7
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-19_03,2026-02-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 spamscore=0 suspectscore=0 phishscore=0 clxscore=1015
 adultscore=0 impostorscore=0 lowpriorityscore=0 malwarescore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2601150000 definitions=main-2602190091
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-42864-lists,linux-pm=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[qualcomm.com:email,qualcomm.com:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,oss.qualcomm.com:mid,oss.qualcomm.com:dkim];
	FREEMAIL_TO(0.00)[gmail.com,kernel.org,oss.qualcomm.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[konrad.dybcio@oss.qualcomm.com,linux-pm@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.998];
	TAGGED_RCPT(0.00)[linux-pm,dt];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 0551915D97E
X-Rspamd-Action: no action

On 2/19/26 10:57 AM, Konrad Dybcio wrote:
> On 2/18/26 7:16 PM, Aaron Kling via B4 Relay wrote:
>> From: Aaron Kling <webgeek1234@gmail.com>
>>
>> Add the OPP tables for each CPU clusters (cpu0-1-2, cpu3-4-5-6 & cpu7)
>> to permit scaling the Last Level Cache Controller (LLCC), DDR and L3 cache
>> frequency by aggregating bandwidth requests of all CPU core with referenc
>> to the current OPP they are configured in by the LMH/EPSS hardware.
>>
>> The effect is a proper caches & DDR frequency scaling when CPU cores
>> changes frequency.
>>
>> The OPP tables were built using the downstream memlat ddr, llcc & l3
>> tables for each cluster types with the actual EPSS cpufreq LUT tables
>> from running a QCS8550 device.
>>
>> Signed-off-by: Aaron Kling <webgeek1234@gmail.com>
>> ---
> 
> Once squashed:
> 
> Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

FYI I did notice a couple of "trip points" in the downstream DT that
refer to higher than described (i.e. >3 GHz) OPPs, but I can't find data
about them internally. Anyway, this is good and if someone has a "very
fast 8550", we can always extend that

Konrad

