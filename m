Return-Path: <linux-pm+bounces-41081-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 76035D3A510
	for <lists+linux-pm@lfdr.de>; Mon, 19 Jan 2026 11:31:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 14387308686B
	for <lists+linux-pm@lfdr.de>; Mon, 19 Jan 2026 10:28:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C6CE354AC0;
	Mon, 19 Jan 2026 10:28:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="KJ6EYiIB";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="bneaf11M"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F29DD33B96B
	for <linux-pm@vger.kernel.org>; Mon, 19 Jan 2026 10:28:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768818494; cv=none; b=OQ1+NBRksYEScldi0X+nf60/Gzv7TTZQLbCwv8ct3AwhegxEgoiFFWjl3ktovsDUitXogBjrDlVFc/EJqUYLBv+L3igmuJ6mC6VJ/jgNdxeAo4Y7HsoCJPuHdWgLuxFoa+T2MQjwXcRxxiV4T5qmvwMtE/xDWLWQ7Hf5Rt8lGyo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768818494; c=relaxed/simple;
	bh=1TTWxLD//vavcXET3qSN3d3YFlnSmRQXg+2dMp5AMPw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fQOkSMiycKz/ATuXt5MfjZk0kZDkr/BrTYHGuf0Ye9p1UCxo7s94LzynpAUKwOQEsFp+GpW1sIU1rP4M5K0HVM8dOSU2BMn9pe0u0x2fiYuN+S6Cgioa+JDANjFK4thkdMs0oP03eQlADkphHvZu3BhNpL9gop6AVqhTEvgtQe0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=KJ6EYiIB; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=bneaf11M; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 60J91KqG1562341
	for <linux-pm@vger.kernel.org>; Mon, 19 Jan 2026 10:28:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	zgDTgsCTahWEZhB03zi/3mLe2SOyw+84BxrjADPSQeU=; b=KJ6EYiIBH9g/wBvf
	blTbe9NYeUJNfqqFVn4I9dtUNpR7ceqayuliLQUyXH+o5DhTGup2z2bKdUyb7YUr
	VQRF7Ji2GLwn4GyvBpQ/+IH1sw4NVSCHk7RqM++uUIsC511cuc3PEqodetbcst4N
	Yjk+h7qvvlzqWndVNmdn2PHY2R1FtZNMN95i8gpeTCdejeWIcT93gkT3W+naKN4p
	CdcN/Zn35rV0TtyHKHDqaFbJ89S6MS4XTJhut1/GMmLBOFTqONuoo27JCm2b5Pc1
	aK65wS0t8JJAxmuecwsyznaWBnwe6hEzz/EtEBxOfY4702nikrlcLU/7ZoAA8FQ3
	bskqtw==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com [209.85.222.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4br36dcpwp-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Mon, 19 Jan 2026 10:28:12 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-8c532029e50so148489485a.1
        for <linux-pm@vger.kernel.org>; Mon, 19 Jan 2026 02:28:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1768818491; x=1769423291; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=zgDTgsCTahWEZhB03zi/3mLe2SOyw+84BxrjADPSQeU=;
        b=bneaf11MsD4AxTKjXsR/L8WOZRHN5Kxpgq2iq76jzJdKuoY5rwHnj4HUOAO2OG+8Nr
         8Os7eZjFGVbW0HeM3eDZHSAjMqiEvXVNbB3jcuYHgq97yjZhA2Z9+pwhwNmpdYkO6MNN
         /8Uevkg4/rL4d4mhUYKCOotyoh5cZzjv3JpHsclS22W0c5KAdYFaX2/4adNQjuUHS4QI
         +mBu49hsNJo5h+30m+ZQT6AJZfvu7H+CKWb3tG3Kc5LA6jTZilHG5/1LgVHoKpCEofF1
         jPyAnjwZ8lqjPX5Qz3fiZWESjPaDCKAEjF29fga17t1rdvq2R61ofCw8pFqqyBIVgix8
         VMYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768818491; x=1769423291;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zgDTgsCTahWEZhB03zi/3mLe2SOyw+84BxrjADPSQeU=;
        b=K4xWZFflG9ZxEBfZKLZcXiJOV37Pv6sq666kpsvFXpGGSWV7JdlWWrIuC3mjMhmN9v
         KS3RZNReR6H9GmXiO1PHRy5DlAEiPbx5qCg5i6RAiePYZ3CJkDlDghLcOt3hAB/5eUFY
         sPtyk6Jbn36u2vXpH/lMpCUHRphqofUOvbMnYYRhEErYYg0MRlq54jde/T3LuVyhUA/D
         9p66ddP3K3FnOqvEu6HvrH8az3nZNasMP4MJ8k3AvG3ZfzSsftW3+c7YUhtlAy1GQogp
         a8w6l3+s3dK5WQzTGqcV+kJjiq2vG2sL4ROuqu7CTgDT5rw9SyVHMVLWM4mY3Rq3tsGX
         S9ow==
X-Forwarded-Encrypted: i=1; AJvYcCXDa5iZNrVOUCzWFk7gI7x8GOyfBoYHUGrYEHw6F0TXlQzyQXLnYx0kaRhNAwQnBqe/oFAQHLchDQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Yx/z+eYhzciPo+pTyUImyrTBZ+nx257WG2ry4Iru0EGGHkufKwZ
	eCLbZjkEx9daAvc9t57kgM/hhGlFYI0jv9WfsB9eAT48PLwQ3UAM17oAUkJlNHQYNZMdne2dmEE
	nObEZaHv7gDNBYw3zp8skxHUNvOr0VC4wIK64vE6KAdaUpVzcgoWHmBpp59niRQ==
X-Gm-Gg: AY/fxX5OVcrI9Sxi8BFYHQ2fohZ95iGvLa3zl+AO8MJpTCIl9tKQ1abTUeYcFVbPqi8
	kC1fuiKgC1wMMoWc+OBcX5B+evn82Q52YWLxT6QeV+M9Oa3H41WfbmN/yajV2F3cmvLp7QtCb8h
	wSxvw2nbXRCg0/6SCLm/PAdoYz67EULsaIwq9QKr13BtpN8KOBIUU03w59Bm+ujXyzQnfIZsKMy
	Gp1yCybhXS8u7jdS2CkLanmke+OVhvpzaND6Cv7Y/KVOymwMK+NpfHJOyEM4SPRNr9p8HWSqeMP
	o31bhq/fjDzJlq5/+bbcJ/fe210Uen8j4Hbr3Dg3cvbhW/bj7WFsDKgXPl2EDSC9144PlM3McCp
	/rlxpw/f9hu1tYvJhXFo1Kbec/z/FYG5EMV1bsQIlttw2rrvDDwkmzTJ9tGQDisWqxc0=
X-Received: by 2002:a05:622a:1794:b0:4f4:b372:db38 with SMTP id d75a77b69052e-502a1603f71mr117659241cf.5.1768818491156;
        Mon, 19 Jan 2026 02:28:11 -0800 (PST)
X-Received: by 2002:a05:622a:1794:b0:4f4:b372:db38 with SMTP id d75a77b69052e-502a1603f71mr117658901cf.5.1768818490586;
        Mon, 19 Jan 2026 02:28:10 -0800 (PST)
Received: from [192.168.119.254] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-65452cdab55sm9920707a12.10.2026.01.19.02.28.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 19 Jan 2026 02:28:10 -0800 (PST)
Message-ID: <9f8619d4-43ac-4bc0-9598-c498d59a27b8@oss.qualcomm.com>
Date: Mon, 19 Jan 2026 11:28:07 +0100
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/5] dt-bindings: clock: qcom,milos-camcc: Document
 interconnect path
To: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Luca Weiss
 <luca.weiss@fairphone.com>,
        Taniya Das <taniya.das@oss.qualcomm.com>
Cc: Georgi Djakov <djakov@kernel.org>, Bjorn Andersson
 <andersson@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>,
        ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org
References: <20260116-milos-camcc-icc-v1-0-400b7fcd156a@fairphone.com>
 <20260116-milos-camcc-icc-v1-2-400b7fcd156a@fairphone.com>
 <20260117-efficient-fractal-sloth-aaf7c2@quoll>
 <59d9f7ff-4111-4304-a76c-40f4000545f5@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <59d9f7ff-4111-4304-a76c-40f4000545f5@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTE5MDA4NSBTYWx0ZWRfX30iw5SwGWvCa
 IuGiKt1xpnmYS6D4BQhNRWtFjcaPODlQx3sUUmbMFxsGr90SPKJhxL7Eia6z2KeKCllymjDK/5S
 /201tEbs6bELXGS/mcZmBkxYx3Xe4JXo4izFc9fJKHpgvId1yYKh0eXlJXfruRvRQg60MrVt8xL
 EzBRPuJNuKxghVBcpaAdSK2Q4UGZFjBfVLJY790+B7XUjnBMK4JQbc1B1ZtNRdGImgKQOkifd96
 KvU8BQ0ItFOcDFXslpMNVckTSa5qHTDWTE5K32LNqbrjcL78+nfSdxH2UqQhO3qoD6fnluEgq1J
 ymVEbsSFOCx+fLWpsmTBnFj3OL8h4OoTGjAga0JnUUK1pzBAu24V/oAXLeVZ26pOAmYs8ojyoTi
 73qWa08TfdiVeRFLQzwboG0FU5gXbOqZIm7dUsHROEw1vcpKCpPPxlboAHnH2Kk1Xsz6Xtq1MGm
 J6Km+zmJHDbU2vvjOgA==
X-Proofpoint-GUID: PXQ3SgHyl_GhmIUbDwDRXoOedNO2myNa
X-Authority-Analysis: v=2.4 cv=GJ0F0+NK c=1 sm=1 tr=0 ts=696e073c cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=vUbySO9Y5rIA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=RTbhy0NO0nWS4SIPpYQA:9 a=QEXdDO2ut3YA:10
 a=IoWCM6iH3mJn3m4BftBB:22
X-Proofpoint-ORIG-GUID: PXQ3SgHyl_GhmIUbDwDRXoOedNO2myNa
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-19_02,2026-01-19_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 malwarescore=0 spamscore=0 lowpriorityscore=0
 clxscore=1015 phishscore=0 bulkscore=0 adultscore=0 impostorscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2601150000
 definitions=main-2601190085



On 1/19/26 11:20 AM, Konrad Dybcio wrote:
> On 1/17/26 12:46 PM, Krzysztof Kozlowski wrote:
>> On Fri, Jan 16, 2026 at 02:17:21PM +0100, Luca Weiss wrote:
>>> Document an interconnect path for camcc that's required to enable
>>> the CAMSS_TOP_GDSC power domain.
>>
>> I find it confusing. Enabling GDSC power domains is done via power
>> domains, not via interconnects. Do not represent power domains as
>> interconnects, it's something completely different.
> 
> The name of the power domains is CAMSS_TOP_GDSC (seems you misread)
> 
> For the power domain to successfully turn on, the MNoC needs to be
> turned on (empirical evidence). The way to do it is to request a
> nonzero vote on this interconnect path
> 
> (presumably because the GDSC or its invisible providers require
> something connected over that bus to carry out their enable sequences).
> 
> Taniya should be able to explain in more detail

We'd have a better chance of her responding if I didn't forget to
extend the recipient list, fixing that

Konrad

