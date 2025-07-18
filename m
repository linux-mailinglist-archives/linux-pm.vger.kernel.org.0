Return-Path: <linux-pm+bounces-31056-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 94C17B09F94
	for <lists+linux-pm@lfdr.de>; Fri, 18 Jul 2025 11:28:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 21C63A444BC
	for <lists+linux-pm@lfdr.de>; Fri, 18 Jul 2025 09:27:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7287D2989AC;
	Fri, 18 Jul 2025 09:28:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="HRxMhSIS"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F0C6221F04
	for <linux-pm@vger.kernel.org>; Fri, 18 Jul 2025 09:28:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752830900; cv=none; b=lkpW0SsEPh5HJKUqfVFJNCIgFeezrVDjvUalfJNuB94pdZa0L0yP4FKwCKbKxGsIP+E/fyeWkyknUrmVsCn7DqQ3FSHdP5LrjbcXGL6phtIlLUXkkFseL9IctQ517djsBTBUj6GEhhIIkTCDKHDhRiQ0TiLSW2MbzXOJ4eixwEA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752830900; c=relaxed/simple;
	bh=NbnKZfzGqskNbEfXayr5hGk/GwKuQRNSeP/X0NfYCeY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fRMTmtHMi9fYpxUNbDm9QFgx7v9i3AwsWvzVGSZRq3UUGddZynMl/j05ZH0YLAMxziZE77Sc8Y7gx7iBrY6Eo7jEkfRJwkYp2+zIhmnEuU6igLSSCSm3prfc8RhmdqxMjW9HsFXkVMTkR+XXi7S9khoVB8x1wJI5YBYuCtGwQqE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=HRxMhSIS; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56I6wFvv020667
	for <linux-pm@vger.kernel.org>; Fri, 18 Jul 2025 09:28:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	1+VRe0Ju/sp1iGJc3RkyEXgFVAS/G2F4yjLjeyBrp8U=; b=HRxMhSISSIU/oC2I
	fbV7H+d23qjgP3ITqLd6VHqpcNpA1JPdwO4DhtdRFd/Cio4n93BywGXELX8Ck3/7
	oVixkQM2nHiG3W20ztqBz4RWvr9tIqpBucgGLvldcAcWgtaTQtDMRUSu6sNFdCAE
	1KGyGGtiiF64hAFz2wzmx4pUBusBkKAD4Z0n5VM2CVvQC22WEsfQ888XrCkz5/f8
	FZfNI8uuS3u+G6vJT18ZiEDtcmofujrxe5AuzCqElCrvxAnPjnoDY/SEzv5UdlUU
	/c50vngyayo0IQE83pyZfflmEy/Iz1Dk2VeNK5ck5hRu6UGamiuJk/LzLcylGzSo
	T81KzA==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com [209.85.222.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 47w5dpp19n-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Fri, 18 Jul 2025 09:28:18 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-7dea65840b8so30626985a.1
        for <linux-pm@vger.kernel.org>; Fri, 18 Jul 2025 02:28:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752830897; x=1753435697;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1+VRe0Ju/sp1iGJc3RkyEXgFVAS/G2F4yjLjeyBrp8U=;
        b=Kosi0cZvukrc7NS+xCJz8CtHVi53OFJk5EuPhxhGMHDXQF78VKIfhtcRFjXu/W83JT
         ct45asYV+WmyopQRWCWReEr2KUHIUXVw2t/p4dVEqUYdcYmulMImYG6DSxvyMrZLDLuz
         Wse8QKahaTFO8kWCbNJBl9O3Y2v7M0JP7k7KDMTU2xex8fB1pwYpm5kbQGhxW/rNVyUo
         N+IWPE97s+cyEgArkjeq0Rx8M9KjGJIiy4D/nDqGTXO9Dpq+ZtJuWFGB8dq/bCXOGl2z
         +Z1GsgYNATlQbqIkaPdKdpJfZng4z5oIpYLrBNz8AJl8aPGJABjM4WrlC3NHn5dGCpL0
         mlUA==
X-Forwarded-Encrypted: i=1; AJvYcCX/BO0CyYIIzoeHSix/05Wazm65XV0tqai7pSjbbveYmkG6ipQSWLbm8lT9u9XqR6Q0Kn/KLn78kQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Yx8mP0j/bh0zw4UeSvmkw6z0BwQmBejTL6awDU32fJBgIs6SwE/
	cfimLsL2vflPZfBGcDn2+8pmt/4GOiDGKUrd5WklY/bVWGndozPTSE4kNl7o/k4HUu/7PAJfq2D
	jrvpq0WNp8MEjkyWUlKnCd8iBOz67lEvLmjWhbAMLY+i1fGP/yszTsAULtYxwBA==
X-Gm-Gg: ASbGncui91oiVNVh3QC+o0nHbxXOT3zQ+x4+AQXzUAXvrU6eC/T+CoXmCEB9cztDuTM
	RRfKFVCEZVjKsS71tfqrgzEAJQFScZdyGvsWnY+rHzAv+jnazDjxvyCHT99h9NHyl6JbksZczZl
	qxcCBSuSR197CtlfSrCe/+joOqbGOZN6YYfb4RvNjBtQE9UCwacFh2+M44+e0WHHs6aBt2+Eud2
	yBC7zLtbd36GyeXWZ+zSIQBCHXR53tEk9eFfK+6G5vqu+rNAXjTvqSYQzhEsb1i+U8TrdbuLtvd
	TYN2UADUN6/ZVtT63u+lubRErp5CnfqsNfHZgrTbU9IFcGkSDCt5y9AkZoUtJQ9yDV8gEVBibQb
	MMUBKVqi4Iotsv1ji1kfm
X-Received: by 2002:a05:620a:4153:b0:7d0:9ded:31e0 with SMTP id af79cd13be357-7e3429d39b2mr559974785a.0.1752830897016;
        Fri, 18 Jul 2025 02:28:17 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFC1R6EIQ1c6MEMXvvejqhCbTPlrLcU2EQqZ1eX8XkE7MU2u6NGRZ77ayYNHvIednR+yi5YWg==
X-Received: by 2002:a05:620a:4153:b0:7d0:9ded:31e0 with SMTP id af79cd13be357-7e3429d39b2mr559972685a.0.1752830896492;
        Fri, 18 Jul 2025 02:28:16 -0700 (PDT)
Received: from [192.168.143.225] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-612c907bb58sm696134a12.57.2025.07.18.02.28.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 18 Jul 2025 02:28:15 -0700 (PDT)
Message-ID: <a383041e-7b70-4ffd-ae15-2412b2f83770@oss.qualcomm.com>
Date: Fri, 18 Jul 2025 11:28:12 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 05/10] dt-bindings: clock: ipq9574: Rename NSS CC
 source clocks to drop rate
To: Luo Jie <quic_luoj@quicinc.com>, Rob Herring <robh@kernel.org>
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
 <93082ccd-40d2-4a6b-a526-c118c1730a45@oss.qualcomm.com>
 <2f37c7e7-b07b-47c7-904b-5756c4cf5887@quicinc.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <2f37c7e7-b07b-47c7-904b-5756c4cf5887@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzE4MDA3NCBTYWx0ZWRfXyx9BfC5m2knw
 eFu0DQHfjZ/JcCP7OFDlA17IzPFuOzNG2NsjmBoOybWrp0e2qlwpdMfhWeUNrDoKETecOY4jpV2
 x84CimWZ7Q5RjeM3TOM+KjYCK/7J55y73mG3P8deWfp55GRZ7iNzl8GdyZemQ29LK0n2QtsxLgb
 EkYtkCZ0i586iJNZkeGifTOYdJhinK1mf1L91FnR7s9AaaDaHlMVHRRD+okJqqRghEZRvRIY8hF
 kQDmm6/sap3yO0ahyR7PBsqRlUBJjD4p3trQk09+UXcAfDGzfwPFfqMgcADcEmstAc3Zpo4aLJI
 EZiFgk91Ni7tH4zU/Hcp1FSWB67Nn3fbcA+Dsk5854eze3JblOMAky29XKNaMLZb5vZQq+SvKwI
 2UCD+1Y00DdY3PP2QzLQBM9hzy/9X1XizrM+TFNMoL2bhij0Vr9Gt+UJsZhgHOw6ofNxhV/n
X-Proofpoint-GUID: ZT4rTmbyS_zJVEwDHFIqsQGZN4EJJ3jh
X-Proofpoint-ORIG-GUID: ZT4rTmbyS_zJVEwDHFIqsQGZN4EJJ3jh
X-Authority-Analysis: v=2.4 cv=Y+r4sgeN c=1 sm=1 tr=0 ts=687a13b2 cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=VT5E6NTcuoebdF1Bc4oA:9
 a=QEXdDO2ut3YA:10 a=PEH46H7Ffwr30OY-TuGO:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-18_02,2025-07-17_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 mlxlogscore=999 phishscore=0 malwarescore=0 priorityscore=1501
 adultscore=0 impostorscore=0 mlxscore=0 suspectscore=0 lowpriorityscore=0
 bulkscore=0 spamscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2507180074

On 7/18/25 11:12 AM, Luo Jie wrote:
> 
> 
> On 7/11/2025 8:15 PM, Konrad Dybcio wrote:
>> On 7/11/25 12:54 AM, Rob Herring wrote:
>>> On Thu, Jul 10, 2025 at 08:28:13PM +0800, Luo Jie wrote:
>>>> Drop the clock rate suffix from the NSS Clock Controller clock names for
>>>> PPE and NSS clocks. A generic name allows for easier extension of support
>>>> to additional SoCs that utilize same hardware design.
>>>
>>> This is an ABI change. You must state that here and provide a reason the
>>> change is okay (assuming it is). Otherwise, you are stuck with the name
>>> even if not optimal.
>>
>> The reason here seems to be simplifying the YAML.. which is not a good
>> reason really..
>>
>> I would instead suggest keeping the clocks list as-is for ipq9574 (this
>> existing case), whereas improving it for any new additions
>>
>> Konrad
> 
> Thanks Rob and Konrad for the comments.
> 
> "nss_1200" and "nss" refer to the same clock pin on different SoC.
> As per Krzystof's previous comment on V2, including the frequency
> as a suffix in the clock name is not required, since only the
> frequencies vary across different IPQ SoCs, while the source clock
> pins for 'PPE' and 'NSS' clocks are the same. Hence this ABI change
> was deemed necessary.
> 
> By removing the frequency suffix, the device tree bindings becomes
> more flexible and easier to extend for supporting new hardware
> variants in the future.
> 
> Impact due to this ABI change: The NSS clock controller node is only
> enabled for the IPQ9574 DTS. In this patch series, the corresponding
> DTS changes for IPQ9574 are also included to align with this ABI
> change.

The point of an ABI is to keep exposing the same interface without
any change requirements, i.e. if a customer ships the DT from
torvalds/master in firmware and is not willing to update it, they
can no longer update the kernel without a workaround.

> Please let me know if further clarification or adjustments are needed.

What we're asking for is that you don't alter the name on the
existing platform, but use a no-suffix version for the ones you
introduce going forward

i.e. (pseudo-YAML)

if:
  properties:
    compatible:
      - const: qcom,ipq9574-nsscc
then:
  properties:
    clock-names:
      items:
        - clockname_1200
else:
  properties:
    clock-names:
      items:
        - clockname # no suffix

Konrad

