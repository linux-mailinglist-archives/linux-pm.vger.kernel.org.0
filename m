Return-Path: <linux-pm+bounces-35338-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 17F62B9F4DD
	for <lists+linux-pm@lfdr.de>; Thu, 25 Sep 2025 14:41:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 38D997AAEDE
	for <lists+linux-pm@lfdr.de>; Thu, 25 Sep 2025 12:39:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9ED77258CE7;
	Thu, 25 Sep 2025 12:41:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="U3fPaKv+"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 282961A8401
	for <linux-pm@vger.kernel.org>; Thu, 25 Sep 2025 12:40:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758804060; cv=none; b=KiOvaAgQkQXyW9G5K3xad1MCiipF23pWRJDrLgsz11Dn0t5Yh6zhL1SE1RYiG4oUfAQgGENATCYX8XJ0vDIOJkafCSeqxXs8kpGqJX/jFEu8VVIVIiKEYUHDsEn9SlgVwdwtmIyOZ2XYirFjaNVyt5H00PMyP5IpHbbDXFF+Jrg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758804060; c=relaxed/simple;
	bh=/OW6lUzbxwLTin4WGTyiZmS+jyErbQBXnuGUK9x0WhA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fW8hNUE/llxgbNjcholoJWX5Rs+QIQAnWoVf3ISc6hxtDdlxD3T7REgCEeMc/gv2P0/wiAkV/nUqCNDuXPFpPVqbG8nfFgKh7unAvTt/E+FbRagCQisVCnvBUkSvJCR+sJ0BtTMr46iqn6XxZDyhXQMxxpmTj99o3SZ3e9d8CmY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=U3fPaKv+; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58P9YPmD019923
	for <linux-pm@vger.kernel.org>; Thu, 25 Sep 2025 12:40:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	dX+D1iEBGYVg/0mxMRj6tDbZ+sqLumaACcaW1rJwVnE=; b=U3fPaKv+C8fOIdnw
	t5i1BryuxendNApb3lk/owoc6A5CE4t0vAa3NI8mDAAC3qHAVtaBhSFTLGqNz3EB
	tP5g8V2xNQetfm3aA3RrP9O8h3w0TkDYST0iHxwNh9AXOGN6FDgv0BI9KAF4OvMp
	TGTdXl//VhIgrh4BNBU8JjdVMq5s80ErxArZOVk6paM2Ds+3JSbCQTWTEHQWR0oI
	0M++lemmEHjGYwkgjbKZuB6E8HyGadPzrIM3kJ4RKFY7E6NxkIsdzOc0lrEPdxO1
	DweyXwInQwxYE6A80i99eY93gkQFMz9ioplLTHPapeY3OJd6mpR3N0K3+zEOtyqa
	W5jaKg==
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com [209.85.219.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49bjpe1aj3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Thu, 25 Sep 2025 12:40:58 +0000 (GMT)
Received: by mail-qv1-f72.google.com with SMTP id 6a1803df08f44-7c51f566163so2606476d6.0
        for <linux-pm@vger.kernel.org>; Thu, 25 Sep 2025 05:40:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758804057; x=1759408857;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=dX+D1iEBGYVg/0mxMRj6tDbZ+sqLumaACcaW1rJwVnE=;
        b=NIoSeRi5QpPMiwwN465FMZnrbGIaVaFkHhUTKS8GXm0iDN1Row7esAaPnJnRQQQbKj
         Sb9c3aLe+rmfdk2FaBe7XhRJw0PKe90IQm0hW0v6a0dY7AvbrfU35bYCVzZaz9Mb5Pv3
         J6EVHEkQchk/H+zIB8PNlpi4SrjjVDfQpbZXhGGIrT7rgv59t/pCs6fFJcqifeP+SPlj
         7RZxv0oAxajS7yfCbIezqekP2890Hf7hm0eS+jbvPqQ6+3Jk6fuyiP075oTYFrIepw5H
         ffxvQCptJqoWIlJYnqO3/0UkzpchgA1utmZWVo9hbhhBmTkc5gCkitSM0CwYTKxZartj
         1QCQ==
X-Forwarded-Encrypted: i=1; AJvYcCV2wRK2/RSr0dhCxegC7mIl0lIo4dKuvUsWlN0E5IKgMSzNQsfFHo3efs3RHEZkjGJqCZjEwPIzOw==@vger.kernel.org
X-Gm-Message-State: AOJu0YzUhM5sEqP+/AKJo1TKePb83zq442APkPnwMvZaynBOdAA4tbqR
	QjEkVYDG34DGaQqphChhs1sCoqxz7osdiKuOzo0ExqeOIK7NvlvGtiPdJIoH8fdpUHd1BO5m+g9
	MyzHLmpfOgAIQWjcEDkwkTzpSyNYIqsLGC1GTlRqeHEu16HN4iEy/gchGR9aiHF5hD0au3g==
X-Gm-Gg: ASbGncvwWrcPxQFxWQJtR52138UREv2VNi1NertWuXNtKizgk4RxsfZJMOnuUQuKajx
	1aKRMXYxGz4spnMT6pwWRJBmLmG7zY7JevHUBE6WzdlTfpNh78ZnksZuHZIHg6v1Dl9npC9kUFi
	26Nck+YVEmBoLjPtER8BUPRAU+dCPRdujh+ctHR4qEdptxs2WkrmNdcJAW3jNWzFbS4n/JcSrj5
	NmwhGF0zgD2KVZOtN/8waSvPTCInMyKbK8UO0Q74wJcNrgQie9fiW5GAIHXUgL+0HQHo/NDIMSX
	njG2ztytZ5YuScN4043yjK6GX2w3mNI0+g0OdmdNiXDPotpOEC5LcxqO1YdRFKJhx009V7s6Yyj
	4eEJfMak9D4NsfSkiY+l9cw==
X-Received: by 2002:a05:6214:ccd:b0:78d:5496:9c37 with SMTP id 6a1803df08f44-7fc4517a623mr30484356d6.3.1758804056887;
        Thu, 25 Sep 2025 05:40:56 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFXVJM0xECADX1ZAwjsmy3/RHWCnfUiY4Eb/4L8Ww/2YsN/Z1WGetVGzxOOKsKP6XRMousjmw==
X-Received: by 2002:a05:6214:ccd:b0:78d:5496:9c37 with SMTP id 6a1803df08f44-7fc4517a623mr30483966d6.3.1758804056184;
        Thu, 25 Sep 2025 05:40:56 -0700 (PDT)
Received: from [192.168.149.223] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-634a3af4cccsm1148079a12.37.2025.09.25.05.40.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 25 Sep 2025 05:40:55 -0700 (PDT)
Message-ID: <f4e7a388-54fd-42a7-8960-be6a3de7ec6a@oss.qualcomm.com>
Date: Thu, 25 Sep 2025 14:40:53 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] dt-bindings: interconnect: document the RPMh
 Network-On-Chip interconnect in Kaanapali SoC
To: Eugen Hristev <eugen.hristev@linaro.org>,
        Jingyi Wang <jingyi.wang@oss.qualcomm.com>,
        Georgi Djakov
 <djakov@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>,
        Raviteja Laggyshetty <raviteja.laggyshetty@oss.qualcomm.com>
Cc: linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        aiqun.yu@oss.qualcomm.com, tingwei.zhang@oss.qualcomm.com,
        trilok.soni@oss.qualcomm.com, yijie.yang@oss.qualcomm.com
References: <20250924-knp-interconnect-v1-0-4c822a72141c@oss.qualcomm.com>
 <20250924-knp-interconnect-v1-1-4c822a72141c@oss.qualcomm.com>
 <ea291acc-bfdc-4a04-ba60-fc59a55ada28@linaro.org>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <ea291acc-bfdc-4a04-ba60-fc59a55ada28@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: B18_2smF1K2Jl9jUZzQQ1RbMUgRJDxfZ
X-Authority-Analysis: v=2.4 cv=Pc//hjhd c=1 sm=1 tr=0 ts=68d5385a cx=c_pps
 a=7E5Bxpl4vBhpaufnMqZlrw==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=EUspDBNiAAAA:8 a=o1Okg1vRPMB1M1hlrKAA:9
 a=QEXdDO2ut3YA:10 a=pJ04lnu7RYOZP9TFuWaZ:22
X-Proofpoint-GUID: B18_2smF1K2Jl9jUZzQQ1RbMUgRJDxfZ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTIzMDAyMCBTYWx0ZWRfX8m8Xg6DVeFbh
 qsLa/6Q5IHsTooQNjVIq+d1QGDIg3dCbtd2mD/RPiVeSADj/xKJydvhHf54q5TFF7yEukbs40gI
 eWY0Pa+lhf1ID4AVZCpFA5oCKeyNVJUFyUcmMgEo9o0/vAGRF4HMTIxpaefjOkrQyUWF5BpBJjn
 NcygD2CtbOMtZCn0bvjYzRX2HxqSErqzZV7n01cutrCZKNl1zz27L+gwMWdWfNeAvruY5BPG36p
 geRVK4Ikg0yLSUXMuBrFIl8C4Ho7OxcQLA6KMWKV0o3lihZXe9nMbXmqDQIMh7orgZYpLBSRxvM
 hjygwi3hMvLgxOABnXH8EiJXRuaAO7XwaEVYDNtzI4wtz+GVASXEqAGMrmCFQMHFHfSnoZDwYPe
 +p/qVgVK
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-25_01,2025-09-24_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 phishscore=0 bulkscore=0 malwarescore=0 impostorscore=0
 spamscore=0 suspectscore=0 clxscore=1015 adultscore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2509230020

On 9/25/25 10:57 AM, Eugen Hristev wrote:
> 
> 
> On 9/25/25 02:02, Jingyi Wang wrote:
>> From: Raviteja Laggyshetty <raviteja.laggyshetty@oss.qualcomm.com>
>>
>> Document the RPMh Network-On-Chip Interconnect of the Kaanapali platform.
>>
>> Signed-off-by: Raviteja Laggyshetty <raviteja.laggyshetty@oss.qualcomm.com>
>> Signed-off-by: Jingyi Wang <jingyi.wang@oss.qualcomm.com>
>> ---

[...]

>> +properties:
>> +  compatible:
>> +    enum:
>> +      - qcom,kaanapali-aggre-noc
> 
> Hi,
> 
> Does Kaanapali have a single aggre node, or there are several ?
> On previous SoC, I see there are two (aggre1 and aggre2).
> Also in your driver (second patch), I notice aggre1_noc and aggre2_noc .
> It would make sense to accurately describe here the hardware.

They're physically separate

Konrad

