Return-Path: <linux-pm+bounces-37088-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AB0AAC1FA82
	for <lists+linux-pm@lfdr.de>; Thu, 30 Oct 2025 11:54:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BF5A11887D8F
	for <lists+linux-pm@lfdr.de>; Thu, 30 Oct 2025 10:55:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3163351FCA;
	Thu, 30 Oct 2025 10:54:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="okcTaOwi";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="anz8CrSS"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D6A5350D52
	for <linux-pm@vger.kernel.org>; Thu, 30 Oct 2025 10:54:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761821687; cv=none; b=i/YNFnu9Un2/0arwbU/bBLosgpjTI79wvHZML9Pk77+dNiBBJFLEEmKau6Q5Z8RrRHU4LEEdq16XWpO8G/3fu+/rgIKjgnmsjJYClR2uWRxtPgNgNbqVnj+Ab960qAk5vg1SKce8hIzv3bJ5dZVziG1c1qai0oCCe5qT940WwYU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761821687; c=relaxed/simple;
	bh=x6ubY0xKm7Gv909xQycMEQpIwpOBfuZgYU0dS4xiN8o=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Gr8vsT0yQ/iVlzMa0FbPmjI4iyU9qPG5Su1qdbr+Ec/b25Wk5T1xGeZXuSI9ZMuSfNm9xbwYkCBf8FdMwSkGlGHo8tC+zNKXUKWCiEFU5WKQydeCVEU0SosUygtKbru2BlUX3iPkZ0XR5RVorXcN3Ux/XmpS7tHYYAAr2KjNVSE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=okcTaOwi; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=anz8CrSS; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 59U7Nwlm1599121
	for <linux-pm@vger.kernel.org>; Thu, 30 Oct 2025 10:54:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	PT4tKn/R8h2W4C0ZG4ZvRE73+O5zr/xSAQM0yc++plc=; b=okcTaOwi/XrjrMKN
	KhMXAW2c+sD454OmZGxWBBDXXYW68er9PX6bBxp2XyQBNOcezGuXzCxhhXo3J62N
	JowHPIr9sBAHikxNDMw0DcWyUZ6lmreiYfkjqRLmZexzuVEj8ZJRGMBvb1Otq9Wj
	q2NHlXntvV/4X50SgnRz75ctZbewCLyYeabK82gT6dNxzd2T8ND4MyZHB7fHhJN1
	SBrp8Hn0TJMSuUpP8VivVDUTqXY1qovWP3aRekL5e6Qgcd/Fl5V5tpt3Im2Apxzj
	LM9zqld0qnw8d9FWU3gmvDkknz6bTcHIn5xo55VVQhFfzxBp8p7ZH39j+CUl0j5k
	NUyxeA==
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com [209.85.219.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4a3ta7t60m-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Thu, 30 Oct 2025 10:54:45 +0000 (GMT)
Received: by mail-qv1-f71.google.com with SMTP id 6a1803df08f44-8800460ca8dso3377166d6.3
        for <linux-pm@vger.kernel.org>; Thu, 30 Oct 2025 03:54:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1761821684; x=1762426484; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=PT4tKn/R8h2W4C0ZG4ZvRE73+O5zr/xSAQM0yc++plc=;
        b=anz8CrSS9blaHgVsGDN7kyfAMCU+MAm6zK1lgLN+JCMcydpYWnzM8y2RyXq2zofpgh
         pmea2EPWhPQvfrG9/Y5BFKTTgG7ewnVDRm67GQzPtkAPOGg39GLFJzvQ0YTwzovePcm2
         pArGUfxBDRM06gkajffFZzXsbtKRuvI6ewSAYUwKDpKvp8d7jGqKd0YBzRIzTd5nFHPS
         ovzq21gbnHu3wopnsMFAqw4ep80vXI3kn+athK0m0b6hl+BSioaAT2onF3McaEyYJuTo
         Y4qxyeswSxpN+7DYoTTTfiZH1M7Cy6ZA6Ptu0YMNzzQGrICWzDTlGaqCrIjH6QHi256w
         IfDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761821684; x=1762426484;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=PT4tKn/R8h2W4C0ZG4ZvRE73+O5zr/xSAQM0yc++plc=;
        b=aMeovIslGXN6G1jfqHZ0RH0VYBAOdl3KstJYzZb/cqZTqvV0PxcOg6pEc3AvSmsmYd
         M6PT5r/mDYD4Bb/EEAZgIXWbBAaT6Gtr4YYsvrR12YC/ryk6OEyD98bA7IajTF5yDCCW
         zvXGejvKZrWgRuDg/xsVROwbL0isH7WXpsgAgbXcpSWEUe3LFRR/dlPOYn9uogbhxhFl
         R6+B3HtYG98o4kbIrc4G0sZOGVxxpQ4N6/zoAM76/SHF1F+LRtlwJMaIk9gSOBuf350B
         hg+vHHJlQYglfsS8HDDS7oij/WktIVXFIYIKFnJxDdRjW/31BCDW4aXHFFbfbZuZK5fb
         cmxg==
X-Forwarded-Encrypted: i=1; AJvYcCUM36Oo7/FQJZGVpzmdarQnOpvT/hvP2KsxHZBi9mBRJkZLHDOJqqvAVNlYoNctOX0fiVDzbdbHZA==@vger.kernel.org
X-Gm-Message-State: AOJu0Yx2mm08W2mgKz3C9LHvCyOvHRCxzawf7msBzhFiUD1aPHAouB4B
	CmasMvqu0mrZj9jciCii8wcA2ac0Gc5umay3TSePfQfhuGipgChJRp3/x/BkK8N/O3B7BsSAdo/
	U8yOzJ8BV+2xbMX/TTLBE8tsEzBs41lgAZ126F1rnRKtOVzPyCL74854Ulnm3DQ==
X-Gm-Gg: ASbGncvR7VWgAwV5iuIFV8lMqqHegT1zwjh5MF4oeYD5Rqtq8r+l7sexI5chg6L7vqr
	smorAv56YkDWwlZ4ISc0fgVPktB4A0bQhx2o5xj011qjc4LlJI9jVjsCFCoBicZ1ZlmD+PWKxcV
	zdhAg7NN05IvqrxM62mU0Ujb8ksCNb98S6iQneikec6YBDaeqQzwADjsIV2hhcqUrHKul/HnmDH
	UUp1zXPpEw75jk59lBqghhBNjW0b0EliPeoD2BKESUJncRMwVn4hO1f/kpmfuGJujLkjJ+NyvOk
	PHitFwDFie6hmzS33e1rUmKVfdYdttNqAMPUp41nu2ZVO1e6aQVTL6YfUOWY0NS6uYC9vST49kF
	g6UIpD+LGQUGyKmyzgPWJDNd+8ZDPUxcxa3EvU9K95KoJNY4AA+EQWvJ+
X-Received: by 2002:ad4:574a:0:b0:795:c55c:87de with SMTP id 6a1803df08f44-88009bfacf8mr55052326d6.5.1761821684503;
        Thu, 30 Oct 2025 03:54:44 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG/PbghJ+epgDdI+nm7Jz9SHZWn98Ad1jChd12W+AwLx6K9fklYXdtyeIhB/z1yWb3Fz7Jx3A==
X-Received: by 2002:ad4:574a:0:b0:795:c55c:87de with SMTP id 6a1803df08f44-88009bfacf8mr55052076d6.5.1761821683905;
        Thu, 30 Oct 2025 03:54:43 -0700 (PDT)
Received: from [192.168.119.202] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-63e7efd116asm14852614a12.33.2025.10.30.03.54.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 30 Oct 2025 03:54:43 -0700 (PDT)
Message-ID: <c9801322-2184-4f04-9459-960580ecf6a7@oss.qualcomm.com>
Date: Thu, 30 Oct 2025 11:54:41 +0100
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] cpufreq: qcom-nvmem: add compatible fallback for
 ipq806x for no SMEM
To: Christian Marangi <ansuelsmth@gmail.com>
Cc: Ilia Lin <ilia.lin@kernel.org>, "Rafael J. Wysocki" <rafael@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Raag Jadav <raag.jadav@intel.com>, Arnd Bergmann <arnd@arndb.de>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20251029133323.24565-1-ansuelsmth@gmail.com>
 <20251029133323.24565-3-ansuelsmth@gmail.com>
 <9343108b-7796-4783-afb1-afe758f78414@oss.qualcomm.com>
 <69033de7.050a0220.34ea6.780b@mx.google.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <69033de7.050a0220.34ea6.780b@mx.google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=aaVsXBot c=1 sm=1 tr=0 ts=690343f5 cx=c_pps
 a=UgVkIMxJMSkC9lv97toC5g==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=Oh2cFVv5AAAA:8 a=BxZim2421LoXUn75QUsA:9
 a=QEXdDO2ut3YA:10 a=1HOtulTD9v-eNWfpl4qZ:22 a=7KeoIwV6GZqOttXkcoxL:22
X-Proofpoint-ORIG-GUID: pDVUpc88R1F2AIyN6ETfQPo2kh7ISluc
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDMwMDA4OSBTYWx0ZWRfXyN+5/uRSxbAa
 /BN0k3tQu9/GYM+EbtocOIqmBYpFeL7mtQDjw99ZBDVGumkhQlDsrAA750/tA5nWm1pX21yju/a
 HWWlu4jjSKih0x9uN51zk8AzZpxinASAQkDgcciV/injo4Wcri8dDNY1LSBoaGRPCa3+CanqKBm
 pSKEnyP5tVEsYBkFFjAUhiqhk4kdAobYrMvp89NlgdweQavkKqkreRdf32wrELsotcRUbbJcgAq
 JNJMLKzxeEsCwCyXLAFkVbkyaRMFnFzaqyzSObuRwlhhLQfrFaYRebsdZpsgaF6g7P49Ekl9nmF
 hKXJKGSnCm+8ArhyPqE5tHmXRwCdnzQtvJNBUaYF9kycPx4fKYFldcBAYT9abW0IDg1X9Mri1fo
 R3kIaAn95SRac9szdGtx8/3TBNryxA==
X-Proofpoint-GUID: pDVUpc88R1F2AIyN6ETfQPo2kh7ISluc
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-10-30_03,2025-10-29_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 priorityscore=1501 malwarescore=0 clxscore=1015 impostorscore=0
 suspectscore=0 spamscore=0 phishscore=0 lowpriorityscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2510300089

On 10/30/25 11:28 AM, Christian Marangi wrote:
> On Thu, Oct 30, 2025 at 09:56:24AM +0100, Konrad Dybcio wrote:
>> On 10/29/25 2:33 PM, Christian Marangi wrote:
>>> On some IPQ806x SoC SMEM might be not initialized by SBL. This is the
>>> case for some Google devices (the OnHub family) that can't make use of
>>> SMEM to detect the SoC ID.
>>
>> Oh this is (the unpleasant kind of ) interesting.. Is there any sort
>> of uboot/kernel tree for these machines available?
>>
> 
> There is some sort of source but quite confusing. From the info they use
> coreboot and chromeos.
> 
> Looking at the source they comment everything related to SMEM
> (confirming the fact that they actually don't init it)
> 
> [1] https://chromium.googlesource.com/chromiumos/platform/depthcharge/+/refs/heads/firmware-storm-6315.B/src/board/storm
> [2] https://chromium.googlesource.com/chromiumos/third_party/coreboot/+/firmware-storm-6315.B

Hmm odd..

The patch itself looks mostly good, although you e.g. assign
qcom,ipq8069 -> QCOM_ID_IPQ8065 even though QCOM_ID_IPQ8069 exists

This doesn't cause any difference in behavior within this driver but
looks slightly funky

Should we perhaps do this patching in smem.c instead, in case other
drivers try to retrieve the ID in the future?

Konrad

