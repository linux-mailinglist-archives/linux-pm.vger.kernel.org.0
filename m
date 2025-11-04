Return-Path: <linux-pm+bounces-37357-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 43F64C30F27
	for <lists+linux-pm@lfdr.de>; Tue, 04 Nov 2025 13:17:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 8B9C24EBB7D
	for <lists+linux-pm@lfdr.de>; Tue,  4 Nov 2025 12:14:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2CB52F0678;
	Tue,  4 Nov 2025 12:13:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="O0lTtuMK";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Sx9Gy9tb"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CEC42EDD51
	for <linux-pm@vger.kernel.org>; Tue,  4 Nov 2025 12:13:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762258438; cv=none; b=erl3M0THOkCCU1AAxEEG00S48E3fPC7p6MjvP/3v/eRMi9LTJNCGQvZW/Ev11eVA2sUD0pnMmRVFc6voUk9Vl6vyltZHEUMTyIdlnhctxmflgiYAyl2N/jrVJJCRPR0ZrIRJ5JkpkF1AFY59pSzA7oP3XtiF8WzE9hABCDqoi9M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762258438; c=relaxed/simple;
	bh=JE7DOtpr7ITJlPf8byrRLaTgyDpLMDlPpNKa7BnbAaU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=foqE4kz/H34hc1PyWECa61Ikynujl5EsqzmC3WV/TB6nCazMS8TTizEVmNtSr9+F4nqgDu45AUXea0pa7rQvkMtQ8FnNMXsSVWgnm97Ci+Ovgcka5ef83LyTUDigmDz/5/n6VzgWFVNtsBdAOkBIiCQXTPOAYvKIqnHVfiqVha4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=O0lTtuMK; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Sx9Gy9tb; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5A48gNRT1395462
	for <linux-pm@vger.kernel.org>; Tue, 4 Nov 2025 12:13:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	C6bQ2/OXa3s0d++jskzDVbMIDhfmlWkdwhbo6GHDRt8=; b=O0lTtuMKRaVw+kkt
	IGYhvZAE1FirDAzLs7//Pi0pqIbYcm607gnhP6aauo5gQ701w6uEoKOi02wKKYBS
	TcK+sXoEXIaGX7/oV+D4fQE0Y1+clJB7w6yl6daU6srsRIOl8Zo84u3yvDlu5Vst
	kjfoTPK0z+SA+/ZQ/scad8c8gV7KR+HGjPRpg3JIXvpyjU4AwVWuH78COMahXmGr
	9pU0AEFAIyo7fEcW7DSi0vItwRIoSbFJYxh4TKlFNJo2Q1pqrv4wrlPjk/s/cUNN
	pyfXln6+AvYKXh16jn+lg0GN/nz/JksyUmloh6+HK7p2sTFhlwWwphU0/WxK5XFJ
	kbviIg==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com [209.85.222.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4a70exjuc6-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Tue, 04 Nov 2025 12:13:56 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-8a79a3e23d5so105625185a.1
        for <linux-pm@vger.kernel.org>; Tue, 04 Nov 2025 04:13:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1762258436; x=1762863236; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=C6bQ2/OXa3s0d++jskzDVbMIDhfmlWkdwhbo6GHDRt8=;
        b=Sx9Gy9tbIGVBlTNJotCJNsQHFNeKr7YvCEPwen8EtjCN7qqRA0KRT/jLwjvM+ecbqj
         msPW/7UaAheYwvJ6B8QHy6bdpg0QmI7nBmssmzJG/Z5xtVguIqXgc1G2SUDpkvJ8AxiN
         Wb0v3MbaQqLir/nTwD47KarK/4rwxjOklMTY7xg5N2GS6pJeW3I3hPUjceBn3ISQfGH5
         TsuhHCRYiaKFhFE/CBzE8+iASKLajjNVIm0oDBlKyGAANR0Sh04njyGxdak66oF2emsE
         8j5vgkrA/dMX8+HF0fMTSBgNNWfoaec80J6gALVBnsbLVidWcyGnHpFP9W2KM8FzLqk6
         uQug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762258436; x=1762863236;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=C6bQ2/OXa3s0d++jskzDVbMIDhfmlWkdwhbo6GHDRt8=;
        b=COO8+sAxpoDJJ3qAtV8mrGxEDWagKahwn4CGGHP4aOflxSz1OomRKDxA9rO4Yxzyxx
         61ywi0fl1oCY2llP7v7YCSSaTF15uO8J1nFJDfJSUsQiOZ35tjgEU1AD1z/hOMCpzb4K
         rLp44ShsPjtGNTMjCsCineca413aAmpbmlZux8BJaDF0X3g9zUz1zpJOBo9zIlcyPu1B
         zXogiGyRxjwGy0vTsPqAZ1SqhpWx6spyvYn5CaggFt+YB+tY9HtMmwtTGpgsN9lVE0NK
         1F/RB1+L9sFt6+7Ns7bcpicEVpWarxtHULV4UScv01VYEhPh4AL0OVJ36cAh/6GtIJnG
         xMKw==
X-Forwarded-Encrypted: i=1; AJvYcCXcyZ1Ke6LSiOL4JYH67jT3c82XrUVQv+pMgMfcRfPe/ydirU+28QtU81UFE2NwmdlQduub9yZkhQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YzdLEG+UD0j8osDJawnUSQI2N0CUAfakvrLsN5aWYD7iHxgPxSu
	PfN6VZMSQYmzPdrM8hX5Q7Liuys1O19DwemW0HT+qCgP/j4+7P+Gs/wzDuH3Qtc2hnBT3WCpT7h
	EQJJK+KezL93LGV1ogcNY1Pk/cfcxx5BJzmRtnIW7G9doMWqwemLv3MnMFAoXAg==
X-Gm-Gg: ASbGnctKW+W+4v4Qji8k+7EO7mk6nbIpru8aicjpiGtxXYOuNbaJUhw2Lvr96q4JhBF
	5NvC2g/Bax2cZSZQ+9kpY4AVkTAKnqxYufIC9DS/Tw4QNI7tMluZUvDCiYtc6ABnrP349OFlQzc
	519qKxNnH8/1Sf1TKOwigIOwcUxNKcDUj84tgUWVjf/AtQlM96bQqS8tqJdv0/UF8hlqLjb8EUG
	WZrE6rYLPWpBfizzqwysPmjPmNAMnKsfnbrw8xMeviQCEzeVjm/8tOmuvUwZmhIE/4ZNE70aOk5
	4Giq31CGITYbdK07OWvIG7auiuwiYMMjMp2q4ytOulwIA8x9gJZdju1/WeyMbSxD6a/tww1ehN+
	7qhnNxFkll0rmzExcPYGz56a7cBKG7Hcuz99/cjOvc1+Z/eNersC0VDBd
X-Received: by 2002:a05:620a:4493:b0:89d:4a69:1502 with SMTP id af79cd13be357-8ab98ec0098mr1526323685a.3.1762258435521;
        Tue, 04 Nov 2025 04:13:55 -0800 (PST)
X-Google-Smtp-Source: AGHT+IElJoqWX2xrJV5ag5CnmreVfKvqZQk0wt43HdbcV3tEqeG9gBU7GfIBlEbi5qoANhqsgYZfbg==
X-Received: by 2002:a05:620a:4493:b0:89d:4a69:1502 with SMTP id af79cd13be357-8ab98ec0098mr1526317685a.3.1762258434614;
        Tue, 04 Nov 2025 04:13:54 -0800 (PST)
Received: from [192.168.119.202] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b723d3a336asm197311766b.7.2025.11.04.04.13.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 04 Nov 2025 04:13:54 -0800 (PST)
Message-ID: <1bd7da17-ae41-4d86-9f80-960f68821ee4@oss.qualcomm.com>
Date: Tue, 4 Nov 2025 13:13:51 +0100
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/3] cpufreq: qcom-nvmem: add compatible fallback for
 ipq806x for no SMEM
To: Christian Marangi <ansuelsmth@gmail.com>,
        Bjorn Andersson <andersson@kernel.org>
Cc: Ilia Lin <ilia.lin@kernel.org>, "Rafael J. Wysocki" <rafael@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Raag Jadav <raag.jadav@intel.com>, linux-arm-msm@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20251031130835.7953-1-ansuelsmth@gmail.com>
 <20251031130835.7953-4-ansuelsmth@gmail.com>
 <qael7opoqary2n5iqefxxp42v3qoudfhfvcgjyxfe3t7353zge@ahgvniscxl7v>
 <6909eabc.050a0220.54944.cd03@mx.google.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <6909eabc.050a0220.54944.cd03@mx.google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=APHuRV3Y c=1 sm=1 tr=0 ts=6909ee04 cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=6UeiqGixMTsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=pGLkceISAAAA:8 a=VwQbUJbxAAAA:8
 a=CWkO6e9Jn2YNH3FdQYoA:9 a=QEXdDO2ut3YA:10 a=NFOGd7dJGGMPyQGDc5-O:22
X-Proofpoint-GUID: CwUhRhHD6bwq-YX6RtCpQzsZQCpg1Iz2
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTA0MDEwMSBTYWx0ZWRfX9wp+AVWYLiwB
 bTJP8FGf6bhvhABb78iabSqzH1V/55IzgwjE5p2r4nmhuoifGtf53W7axbqLtMlxY/0+8oacKMi
 KyVwfrc7mSXpbVoutm2dHxC0ad/SjDRF8d5a65ksViu/Ae/vtNgeGBS7W48rwVsumvHfjt9NQ6M
 FvoVpOEf187xPXNl4XDW+wjBMmOpzpoOzxyrEyXzbTANkezyFQzOFlnx60HIfKNIwrDwyELZeIE
 GNNnfDlIaoCp3HgmudrXSbEN1MsaFtfrshVMWwNQqbLLlXnwMurgkKAoJ31J2DcCKe6MuMdsI+X
 f4rnyTBhAloxYgR8ig857aiIWV2ifjpykImDeZz/wMlXMPJSWZ+rG3wE8zMLtlvEad+rejlsZM1
 um36v4Rj4JiCerGaJo21f42kqlOnEQ==
X-Proofpoint-ORIG-GUID: CwUhRhHD6bwq-YX6RtCpQzsZQCpg1Iz2
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-04_01,2025-11-03_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 clxscore=1015 impostorscore=0 priorityscore=1501 phishscore=0
 suspectscore=0 adultscore=0 bulkscore=0 spamscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2511040101

On 11/4/25 12:59 PM, Christian Marangi wrote:
> On Sat, Nov 01, 2025 at 12:42:55PM -0500, Bjorn Andersson wrote:
>> On Fri, Oct 31, 2025 at 02:08:34PM +0100, Christian Marangi wrote:
>>> On some IPQ806x SoC SMEM might be not initialized by SBL. This is the
>>> case for some Google devices (the OnHub family) that can't make use of
>>> SMEM to detect the SoC ID.
>>>
>>> To handle these specific case, check if the SMEM is not initialized (by
>>> checking if the qcom_smem_get_soc_id returns -ENODEV) and fallback to
>>> OF machine compatible checking to identify the SoC variant.
>>>
>>> Notice that the checking order is important as the machine compatible
>>> are normally defined with the specific one following the generic SoC
>>> (for example compatible = "qcom,ipq8065", "qcom,ipq8064").
>>>
>>> Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
>>
>> Reviewed-by: Bjorn Andersson <andersson@kernel.org>
>>
>> And as mentioned in v1, this (cpufreq) patch can be merged independently
>> of the first two patches. So please merge it through the cpufreq tree.
>>
> 
> I will send a new revision just for this patch so I can use
> of_match_node()
> 
> Should be ok since it hasn't been picked right?

Yes, this is desired, even

Konrad

