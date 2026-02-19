Return-Path: <linux-pm+bounces-42862-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iCxGBcbdlmlJpgIAu9opvQ
	(envelope-from <linux-pm+bounces-42862-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Thu, 19 Feb 2026 10:54:14 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 6229415D8F2
	for <lists+linux-pm@lfdr.de>; Thu, 19 Feb 2026 10:54:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 583B1304CA62
	for <lists+linux-pm@lfdr.de>; Thu, 19 Feb 2026 09:53:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04D1F30F921;
	Thu, 19 Feb 2026 09:53:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="QKS//hH8";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="eVSNI452"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C041B329384
	for <linux-pm@vger.kernel.org>; Thu, 19 Feb 2026 09:53:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771494809; cv=none; b=hVoNsHBC8/R55ppzztwXb6KpnpDL6ai/jf4/Y4h6rti035gP4ARJ6cZIeW2sQRiGY/WMhshNE3xn7Q8CE5DYKcAXOYGGI2kMwL6AByHeHVb7HvCFKNtQFlzXyzzQkrD7Jwttf/imr6jRGj7/e2RrjTIgu4IbCRHYThTFj6Zs6t0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771494809; c=relaxed/simple;
	bh=jyz8fGOPhJXs5M8u8EL9CPuvfnxX7XjzIftKRkztPqc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=V4m9XxSsNUO8z1MbJ4RD+F8BX+qn/KRLWlxSV+KY21iRLdN4daTb5pojUedU4Gg6sryD28rHOhvFXe/j0wjU+8p+6Cjllskwi7w8Tj6qUgHs5ZWGX6T8cbPERljZK01GbJlq6zLwbOVBjh/cFd1h8lOGcM0btqfdVFFYWNz9XyY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=QKS//hH8; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=eVSNI452; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61INlfdd1924952
	for <linux-pm@vger.kernel.org>; Thu, 19 Feb 2026 09:53:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	+NuR4TSOxkAzQBRW+Uk49z7th0qef4OVsy9BAp4AlxU=; b=QKS//hH8ngbSjH5A
	D6Oo1jn84n3DIzoJDukdpaUYPSfs1CqP0eTjQpENmYDTKgtY7Bb9YKS2V7C+4R0j
	8fQe6KAklJTst1+AvdB3E3AS/VvuXHMH9TRhCy5/v6qojvV2QA3PuHEuInrkjiC8
	QnmPfsXCoyrjUxKAQ/ngOK2cp4VlZcliggAS402U32wT1XMFxKQhFinbOZiGO4e3
	L69bTOA64io5ZmbgBGjhoLjFkSH+GoKEczOLVWXg/8aqwvxNW45btSZFedGKL4Af
	MIEkvEl9Q2EMGNz4WsrQ4CPFZkOUTLMRYB+fxOHGxSw+By2FL77lbE8ZbgZwF7F6
	Fp+CMw==
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4cdqdg966m-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Thu, 19 Feb 2026 09:53:28 +0000 (GMT)
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-2ad4a8c1f5aso13538465ad.0
        for <linux-pm@vger.kernel.org>; Thu, 19 Feb 2026 01:53:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1771494807; x=1772099607; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=+NuR4TSOxkAzQBRW+Uk49z7th0qef4OVsy9BAp4AlxU=;
        b=eVSNI452rxIA+S41IX1VBn+5iPJi3yc2KgtPNcf7f51j+JiFkIiv8kL6m36fR8a+dn
         71GUwO+CrO20VxtiXigBRl1TN7G3DpqM5otqFXfobmevwb1rgCgEdDICyDwmEDrVUDz/
         +t+h4MPgXfQZqevI3k05YDiKiLBw6JKO/2e1hGzG1L7HijKVhezeB4nlmk8wq0bBeb92
         Xr6RkDoRP0s7y8UPPwKMyfUGTdPm9yxZNTtQ37ceQgWDHhzwD5nDxzg325MQzYzvVspe
         AP3lXSTEKzjsre6cHPuNhzSujKtj/uxXAQB3LqLC1yGO7K5H8/38k0gDCHehszCboZz0
         LDVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771494807; x=1772099607;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+NuR4TSOxkAzQBRW+Uk49z7th0qef4OVsy9BAp4AlxU=;
        b=w3iOK16OAFuQjkK+a8TxsfAH9UM3iiBxi1F88L238gFBsxKgVQUr2jMLh4Ssx482qz
         EAyx28ru57UUWljcn03QUVxTJlkan5oqF9HOBTUayodIC37Wghglxr14iOPV/DuJCs3X
         QtCFvSqR6OoHNQa7MrNwOXbIw7Ga+UTS+FqtzVceZdf8RLOTKezDFP5nqjYC9Zg2CPPu
         Mr/PTnvwSWd2tRU32esTy+XFovS8OTeH1/ambGQ7uWuKpv5U88tLZ3bw0WUvjQuE1Mzm
         NmeDOCpTf/fAsm4dK15gL3KyRr/nFHqXyF40rZJ/ydalH+cVOWKvx3CUt8bVxaBxsRqF
         TiQQ==
X-Forwarded-Encrypted: i=1; AJvYcCUzOG1F7uXuAhn84gyYnaMaIBPII4jXNmIbf2lDMXS0pI/gD4syjPyBYeNonQc8PP7I0alPcNE2QQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YydouoibpsCUtDIzH83qWGmP6VLR48ONQ/XhWXvM1cDnUJ1dmSG
	r3D5P3l4XksUMLfAbi6PIcyxymUNtkJRHuz5sjlushjtR2t3nyOkGRecC222fmDjm7yUXBkF1OX
	5aJ7SBdvN21pxFCBTK2DjL83QfzTKcpTgzZKm4u2pe5DXISZa8Gt+o+p6QwszPA==
X-Gm-Gg: AZuq6aLij7J93auvh2CqBYVvGHYoblTcuTOsPgIV60J3+wK+vAt1jBy+IRkLevL6KYp
	NEA7YwgDV4NVhMfaQEnQUpI0Updba7aD5sLVrJ+hmJJXc3U45ebJPZpzLQw3ynno3OcRrBzNJ9Z
	rrBUUDO3ppTjQMSGzqaEEL68jH2nuhIOsxA0pB7jyfiGgaI5HzTlnfp8bo7HtxJiymzoEJjqu0A
	VGAYGSJrk7zR0cwDydsEeq1+z+Ea8EzAqIJtRSK2j5oDd32sGrt25yqgIj5HUCn3ZDm+WjX3XNf
	77g5N6ps8Ln0b5dzupFagy+lU0SHUBV5yMDCwlCPDL02WuwKcHFCpcQwmTHyqiFBaZxIImtUlrz
	5cZDGJnHbxNi2ITjhCb8Yt54KzTt0mI5LSq+tVZWN1bdrrKDq
X-Received: by 2002:a17:903:2390:b0:2aa:d327:beff with SMTP id d9443c01a7336-2ad5f701d04mr14625535ad.6.1771494807250;
        Thu, 19 Feb 2026 01:53:27 -0800 (PST)
X-Received: by 2002:a17:903:2390:b0:2aa:d327:beff with SMTP id d9443c01a7336-2ad5f701d04mr14625315ad.6.1771494806808;
        Thu, 19 Feb 2026 01:53:26 -0800 (PST)
Received: from [10.92.198.80] ([202.46.23.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ad1aadca84sm158860315ad.70.2026.02.19.01.53.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 19 Feb 2026 01:53:26 -0800 (PST)
Message-ID: <dc7fcaad-73f2-44a9-99c0-b0a13a856239@oss.qualcomm.com>
Date: Thu, 19 Feb 2026 15:23:20 +0530
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/3] arm64: dts: qcom: sm8550: add OSM L3 node and cpu
 interconnect nodes
To: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>, webgeek1234@gmail.com,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>, Georgi Djakov <djakov@kernel.org>,
        Sibi Sankar <sibi.sankar@oss.qualcomm.com>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        Taniya Das <taniya.das@oss.qualcomm.com>
References: <20260218-sm8550-ddr-bw-scaling-v2-0-43a2b6d47e70@gmail.com>
 <20260218-sm8550-ddr-bw-scaling-v2-2-43a2b6d47e70@gmail.com>
 <aa5f536a-41f2-47e7-b80c-8559c13a69b3@oss.qualcomm.com>
Content-Language: en-US
From: Imran Shaik <imran.shaik@oss.qualcomm.com>
In-Reply-To: <aa5f536a-41f2-47e7-b80c-8559c13a69b3@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: RVwqeOiEY_SgNDvlQUgT0xVWhYjEVF7F
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjE5MDA5MCBTYWx0ZWRfXwuXDMtyErafX
 r2pUM/EC1ZcXuG+p5K1dHpCHIainXHhdZcNOO/xTltAumIytbljt3mV3I2rx0/kTInVu7ZGiOGa
 ZzJsYGHBDE4GN5PMETycSAsZjEqG7/Q0Mue72Bn7ybf+M5u0NNhJfN++yezvos5fFkqPP6OjjvB
 hBP7OqRZnyGGnKRUDae4tpGwwZnApImYvkLU9YjWZSZFTvNlJ49b27GQTUNSEBj8CqWs5ztgGxY
 ctx1VK6bQOE66rvfFFlNoZJhMXQzZfvtKbqNFWAr/NMLDIltnrlK/CeWGw0TgR9Ah16WYETLwOM
 UmW07/JaRc5Ns53EXlEmoSv5+hCeqxOBLzwx7AoJ2SWNjnje2dp9I5NkzzT4TCmF2rQbfm1fkUj
 1yMWK1RFO9HC9B/2vUMeIAL+tv3WW4RJNPshhSE89va5RkATiDzRVu98vYGLJqruAlwBmbr2WPm
 5hU7rG4Y0M4FpB2VG0Q==
X-Proofpoint-GUID: RVwqeOiEY_SgNDvlQUgT0xVWhYjEVF7F
X-Authority-Analysis: v=2.4 cv=W/M1lBWk c=1 sm=1 tr=0 ts=6996dd98 cx=c_pps
 a=cmESyDAEBpBGqyK7t0alAg==:117 a=j4ogTh8yFefVWWEFDRgCtg==:17
 a=IkcTkHD0fZMA:10 a=HzLeVaNsDn8A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=Mpw57Om8IfrbqaoTuvik:22 a=GgsMoib0sEa3-_RKJdDe:22
 a=VwQbUJbxAAAA:8 a=pGLkceISAAAA:8 a=ICX6NJ6XWj8aWO6CY-EA:9 a=QEXdDO2ut3YA:10
 a=1OuFwYUASf3TG4hYMiVC:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-19_03,2026-02-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 priorityscore=1501 adultscore=0 malwarescore=0 clxscore=1011
 suspectscore=0 impostorscore=0 lowpriorityscore=0 phishscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2601150000 definitions=main-2602190090
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-42862-lists,linux-pm=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[oss.qualcomm.com,gmail.com,kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	RCPT_COUNT_TWELVE(0.00)[14];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[oss.qualcomm.com:mid,oss.qualcomm.com:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,qualcomm.com:dkim];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[imran.shaik@oss.qualcomm.com,linux-pm@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[linux-pm,dt];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 6229415D8F2
X-Rspamd-Action: no action



On 19-02-2026 02:59 pm, Konrad Dybcio wrote:
> On 2/18/26 7:16 PM, Aaron Kling via B4 Relay wrote:
>> From: Aaron Kling <webgeek1234@gmail.com>
>>
>> Add the OSC L3 Cache controller node.
>>
>> Also add the interconnect entry for each cpu, with 3 different paths:
>> - CPU to Last Level Cache Controller (LLCC)
>> - Last Level Cache Controller (LLCC) to DDR
>> - L3 Cache from CPU to DDR interface
>>
>> Signed-off-by: Aaron Kling <webgeek1234@gmail.com>
>> ---
> 
> This should still be squashed with patch 3, as while you wire up the
> CPUs as interconnect consumers, they cast no vote, leading to the
> situation Krzysztof mentioned where the performance actually majorly
> goes *down*, since the icc core sees no users present and assumes it can
> send a zero-vote (which probably translates to F_MIN for the cache)
> 
> Konrad
> 

Yes, this is required to be squashed with patch 3.

If only the interconnects are there, without opp-table support, then the 
cpufreq driver probe will fail while adding the opp table, due to 
mismatch between opp-peak-kBps and paths count.

https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/opp/of.c#n779

Thanks,
Imran


