Return-Path: <linux-pm+bounces-31586-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 635CBB15ACD
	for <lists+linux-pm@lfdr.de>; Wed, 30 Jul 2025 10:38:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7EA7016B455
	for <lists+linux-pm@lfdr.de>; Wed, 30 Jul 2025 08:38:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CABC41F4E59;
	Wed, 30 Jul 2025 08:38:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="HeCycuwz"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5750C1EEA3C
	for <linux-pm@vger.kernel.org>; Wed, 30 Jul 2025 08:38:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753864711; cv=none; b=bbyXXOV99kol40aAkJaRWdHbmwP54//7oI1jSz4NbLcGAI+EOSkK9ueRdhWOQXt+hRIrCkjMJqDNeKkJ2fCe4264Ij4GGnWOQRxCeVI05w2/jtAccKlog2q0q9OrodQ63AwqxRQYOVSuXdbAlyuVNr9j+tO+8Kml0GtedjZbP1g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753864711; c=relaxed/simple;
	bh=Q6l3IpqKbOqB7OSeobIhjRaEzAZYWHwA59c2iSf50F4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=s5flxi6PcX4s6BR371vpuTWZKxFjL5e6jQiiE7AjaLrYdpaAziHcOJzr2KBaf4P1aQxbBnbcyeAUafIYobTZkMPko+laJuRRoXbRoLP0qdaUlyg01i5XnA8JFDDsKmZl3oG2xngwO9K2Rrst9iJzHIA93Ffkl6jpwAe5ZeKeKWw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=HeCycuwz; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56U5bkYR027687
	for <linux-pm@vger.kernel.org>; Wed, 30 Jul 2025 08:38:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	iI/nNXs+f9KkWZ1yxsWzsQrCvk0IJuyKWclGYTpMJOM=; b=HeCycuwz3XWsPdv8
	Akbyi5AOL1FtXNcdQTs1bdp0TEP5J7OJ6tyxBOlHhZwSrbD8GuAQwc8n9+BACdGZ
	fMaULoIxcbDVH+tRz9uIcT5bDCJ9hEInhxDUQEBh0FRqA1mOohlKiJSIMEMm0lst
	uKJ1ODSrcKBKHUaHvq18x0EnwLKYvRCS9Wz9+upoPN8isvAeRcxGj0FqXah5SB8a
	gvLu9NXezJEdFDirAYU6nuP8j/PRrudLFyXsgxEfVOqt+WututFRi1MmUmA1BERK
	gwIbvdzLNfeee06RtunxhsIsSvM5WvdE2RF+ndcNx5GhAk4aB1RHRFfc5gpMts+Q
	5ylz6A==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com [209.85.222.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4860ep0bss-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Wed, 30 Jul 2025 08:38:29 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-7e2b5396898so42105585a.0
        for <linux-pm@vger.kernel.org>; Wed, 30 Jul 2025 01:38:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753864708; x=1754469508;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=iI/nNXs+f9KkWZ1yxsWzsQrCvk0IJuyKWclGYTpMJOM=;
        b=Fe2dioTDxdQVFw1P7LJ3o6j8DDyEa5ClwC19y6yFewrhhARsn8DVezOTbVdfdYExVm
         s3Z4Gm0Iw3ZFOM7HlkvLLh7iqOeMN4X3XfAoWP+DI8QwV1nJaoNXFfRswBdz5bBuVpWA
         J9mu+iOl9Qg+0PmxgenbCxFOJnk1p9m31UgHzZRNDEek54O9yZQii6gf2qTr2tcWwYkr
         W/iK4wOxiJyMm6X9g5JZ6XZZ1LbK5k2Go6YX0h2jsH8nqAK8ciBuUC8gOI8QGnDm9kwf
         qh+Lg2+2g/+V1VpMPTktcCn+1fEYEyKodtN1o6Gqu/6UIK+PAXjHy80rfX1y8DdoiCou
         S65g==
X-Forwarded-Encrypted: i=1; AJvYcCUW+JATCJKSEehn8bzRzAPW6FC3hPrmVtMqrwMU3AQ0p2pFy6DzmsFNVujpHA71hcd16E0iu7lGig==@vger.kernel.org
X-Gm-Message-State: AOJu0YxqJuVbrer6dkcmwEDGRXWDMZME91xEESmiPT0nNmAIz8kJaXQ3
	XSWAjhx5QZFgYUahhmr9kKHJcw5JKDRZkTRLZMnIRmCWnYoYEDVDw/GajbhcOTnGkh6SdmJdXdO
	LJ7Xpt7Ua1hlZljUkqoezOLjOocdAydtd/w7pn4v3LZlt9r9/mxwv47UvlDKQgw==
X-Gm-Gg: ASbGncsvarzCIaJYc4NsOSmf5hWBwBONaSVbSbFfGWeecnGffOn6mz6DWj6JSxYWMN0
	ejaKeh8hXfs4AMfvev8IovC9unn8z20uEu1sOWWnAYdk9BZZlBRY/Mwjj+MwIfEEDO3FAQdHB/e
	VK1VH2ragxvSB1euC2O2hTXEz03wZCttwqEqXbYN9FRpOTFer1iL341Faez7i5AftituFbjQ4iF
	9opi3dW8m9/Y+CAZbnJK8Ji062uN7PGAQQjHEGdHnMEADBSx8NVacClXG0zIurFb5kDlQaaw1cg
	1VP8f15lGkpgft+6wmEC/lZB8qyRH3BgJa5gNAJvrzUnlBCLPwFf5VwnSduhRBm1WW33fiPH+6i
	fDXcvkJolQbTYXzydlg==
X-Received: by 2002:a05:620a:2892:b0:7e3:328f:61fa with SMTP id af79cd13be357-7e66ef91861mr169462985a.5.1753864707671;
        Wed, 30 Jul 2025 01:38:27 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGVI2jZ37bBekKEznTg/czn6Oni5IYIGSxIKihzZfZqwE+jSvddcQoWat/7kn9i13M2e0uZOg==
X-Received: by 2002:a05:620a:2892:b0:7e3:328f:61fa with SMTP id af79cd13be357-7e66ef91861mr169462085a.5.1753864707288;
        Wed, 30 Jul 2025 01:38:27 -0700 (PDT)
Received: from [192.168.43.16] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-61544a81df7sm3370018a12.59.2025.07.30.01.38.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 30 Jul 2025 01:38:26 -0700 (PDT)
Message-ID: <134a6436-18b1-4b21-aa19-5e7411c1678d@oss.qualcomm.com>
Date: Wed, 30 Jul 2025 10:38:23 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 3/4] cpufreq: qcom-nvmem: Enable cpufreq for ipq5424
To: Viresh Kumar <viresh.kumar@linaro.org>,
        Varadarajan Narayanan <quic_varada@quicinc.com>
Cc: andersson@kernel.org, mturquette@baylibre.com, sboyd@kernel.org,
        robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
        konradybcio@kernel.org, rafael@kernel.org, ilia.lin@kernel.org,
        djakov@kernel.org, quic_srichara@quicinc.com, quic_mdalam@quicinc.com,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org
References: <20250730081316.547796-1-quic_varada@quicinc.com>
 <20250730081316.547796-4-quic_varada@quicinc.com>
 <20250730082852.oxy3tjjtdrykrzne@vireshk-i7>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20250730082852.oxy3tjjtdrykrzne@vireshk-i7>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: DRnnuZBQmmBzsUWhG3jCS5j_BSccocXg
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzMwMDA1OSBTYWx0ZWRfX0hAWwgqCpCvo
 Sld7ewqVE4AOa/I6FZaAO1ML7LBf6u7sxalmPg4WoLd5ZrlVND2QfU8BowT4kZdpLaF/WxZmMyR
 VjizTv3ZLmptpjo7QKrv0imAzsZD/6p570axFeTVCgJH24lJqIGC1XD7fpwQeUY1nTJaCTC4+pt
 d54hCeBc9Xi3QycpncxcuZ4avxGP1PSxrcChcDWiC0uaUfupjlNHX+LqWsgsGMwO1keVso5fWDg
 FbNu3dAJBPLzYkVKXusu0hkvWlXk71nwVsLPbuz0CYRcg4mkZ1oQqbUNtRn+or0ahY9DB8LxtkE
 Idy8+hV0rvKzx/KHa91BigkUo95FDXO5/D+jsd3i2zjjC1F1ROE1sHVKv3R3Ku3BtiCMQi2Za38
 MmS8D8qKMgAj5LRdTF8TAvr76aJb0GPz/Y02R0jH7ZhcDGK0WF/i7Mscw+nrnfXEoVf1b8LB
X-Authority-Analysis: v=2.4 cv=DIWP4zNb c=1 sm=1 tr=0 ts=6889da05 cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=COk6AnOGAAAA:8 a=EUspDBNiAAAA:8
 a=KKAkSRfTAAAA:8 a=-57h1Q5dCNsLzJNHLckA:9 a=QEXdDO2ut3YA:10
 a=bTQJ7kPSJx9SKPbeHEYW:22 a=TjNXssC_j7lpFel5tvFf:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-ORIG-GUID: DRnnuZBQmmBzsUWhG3jCS5j_BSccocXg
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-30_03,2025-07-30_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 clxscore=1015 bulkscore=0 mlxscore=0 mlxlogscore=999
 spamscore=0 impostorscore=0 suspectscore=0 malwarescore=0 priorityscore=1501
 adultscore=0 phishscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2507300059

On 7/30/25 10:28 AM, Viresh Kumar wrote:
> On 30-07-25, 13:43, Varadarajan Narayanan wrote:
>> From: Md Sadre Alam <quic_mdalam@quicinc.com>
>>
>> IPQ5424 have different OPPs available for the CPU based on
>> SoC variant. This can be determined through use of an eFuse
>> register present in the silicon.
>>
>> Added support for ipq5424 on nvmem driver which helps to
>> determine OPPs at runtime based on the eFuse register which
>> has the CPU frequency limits. opp-supported-hw dt binding
>> can be used to indicate the available OPPs for each limit.
>>
>> nvmem driver also creates the "cpufreq-dt" platform_device after
>> passing the version matching data to the OPP framework so that the
>> cpufreq-dt handles the actual cpufreq implementation.
>>
>> Signed-off-by: Md Sadre Alam <quic_mdalam@quicinc.com>
>> Signed-off-by: Sricharan Ramabadhran <quic_srichara@quicinc.com>
>> Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
>> [ Changed '!=' based check to '==' based check ]
>> Signed-off-by: Varadarajan Narayanan <quic_varada@quicinc.com>
>> ---
>> v2: Add Reviewed-by: Konrad
>>     Change speed bin check to == instead of !=
>> --
>>  drivers/cpufreq/cpufreq-dt-platdev.c | 1 +
>>  drivers/cpufreq/qcom-cpufreq-nvmem.c | 5 +++++
>>  2 files changed, 6 insertions(+)
> 
> Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
> 
> Lemme know if you want me to pick this one.

Please go ahead

Konrad

