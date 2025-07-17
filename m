Return-Path: <linux-pm+bounces-31036-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B08FCB09641
	for <lists+linux-pm@lfdr.de>; Thu, 17 Jul 2025 23:06:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 443353A16BD
	for <lists+linux-pm@lfdr.de>; Thu, 17 Jul 2025 21:06:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D08922E3E9;
	Thu, 17 Jul 2025 21:06:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="CCQ6Zj5t"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E8301E47C5
	for <linux-pm@vger.kernel.org>; Thu, 17 Jul 2025 21:06:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752786384; cv=none; b=O0qVZXNNtVKd6iNVCCZ+xQetnIEya8f6LRfL0/ZiMFjkubt5VDsHTqn5LjukSapqqY8/HtlzqF+R/VB7RPIow1mXcvFRskgY7Ofxzvv4dc0w4G52Tw7xee2js7Yuos+DuSIUnv5Xie9IFH6lwg6nDM/mnKMC4uYvUHWqMyAJ8Ao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752786384; c=relaxed/simple;
	bh=Fu5f1KYcPNBKXbwBLRZ4Cig1/7uNC4oBZT6MsGsCCXY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SQQOHvms2W42FwVRqbYLoCEA4xCwE2e4aocDMg2uGcn58EXaw7vk9frorZSHZ3XqF8qzXcnclJRLBtY7c90kbsVPSorIRrpZzf1Xy0Ss2MhlPmtsyn6HourF7fp40GDThN3VVDIGqQwBeaWd8gF5cp9LXY2qH7whp1J9RE9f30M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=CCQ6Zj5t; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56HCZ2oo007297
	for <linux-pm@vger.kernel.org>; Thu, 17 Jul 2025 21:06:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	0pHw80GM2tQXK/P5MspgwmNzeXrdomfpLEtnn34M6J0=; b=CCQ6Zj5taIIZgg77
	BjsrbRhNCnxCoHw75tzik23Z5SkOjFbzC3ZWStbyKsGNyAA/8nYux/lu0Gdwf/EW
	F/FadNR3e4hcsj/VB53T+14onJAyrVEondsZBKolYuQGymdKLSABgFCT9rPZ3yez
	0BVC8k3zrT3sMnUxN+05vHZX8BGVDhUZ7MNuObkXxagKVeRUfFHuthRc+Pk2PvO2
	uFEKBcvvsFQevJDztr3weGvJqNWkUsRWnusS7W5tfSf69ECcOrSWR9LiOaRoIe+e
	lfdZ4WWm+mgi0hE9jTKA3ud+aIcxLDy4bgzq0McXapnCbw4I2pd6aVwOABwgVtzb
	hAFFdA==
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com [209.85.219.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 47wfcaabks-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Thu, 17 Jul 2025 21:06:20 +0000 (GMT)
Received: by mail-qv1-f70.google.com with SMTP id 6a1803df08f44-6facde431b2so3842406d6.1
        for <linux-pm@vger.kernel.org>; Thu, 17 Jul 2025 14:06:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752786379; x=1753391179;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0pHw80GM2tQXK/P5MspgwmNzeXrdomfpLEtnn34M6J0=;
        b=JJHh6GujCXWJe+4lpBcBK0cV3rGnOQCPVc4cYQsW1YZnNrZmI1zFLSdO4ALZ2miedX
         C28c55qdRQkU7dq61NLnRWWs7WhL2bJeAF7bbf/9VVsL+vwaiR7Uwy55lmXFR9t9050C
         GmdOxgC63CeCXJB1QHzgKWjjgmS+MLQ8zK9kQPiKIZnldtNsWStz6ysJAclYgvyrqQ1c
         Tnox6CWwfbbEuuFdoIVePcC7LwjKzptmu1+xdbCxdvkeDpYBYbO2bVbx0jP4Ckoau2H8
         GsJuqoWoPK0leWQ8oOiC7z5dh3J6B19P5xq5LtP7X7k86swMgYNTJZQMyUGSBB7t4NLx
         thFg==
X-Forwarded-Encrypted: i=1; AJvYcCUepBUXEbUoIvXiOQpT75I0xqNychWQiYHFh9BhGtYdKlJkKSdQnYAdfmEvw8iCJZo7G6BPAjo7QA==@vger.kernel.org
X-Gm-Message-State: AOJu0Yy5ksKcjmi1gKTMrGTqrSdmGJMLkfm0ErlIeNIJ0ZuubLCIp/8f
	3ECpA7RZLzoV7526YPLo9tYlLlQGx3ut/LHos0M7wLQgIsWGtlL6VR4pdLuDL0k7elR+GYNg1bu
	qcBpfD1wNiLSchqmo/jPIhA3gR1U90OvXd8XSXh/veohPUhXOprAIe35BCTN0LQ==
X-Gm-Gg: ASbGncsR40Ivd1pTHil8FWQaunw/IDfErYUFNT3Dz9SX+N3SYXcXdPbt6xje7YFVmnU
	HZMfOfFt/FTWgJ7pFYVoeRPzbDZtJNO/S750LKoCu3D3npJB9N9rBiZNNMjvV/7ziLt54kgWDO1
	hn+SuT3PnArBNtHnlBGWqUZ5X5nRsAqHRu4q6qARBZFvmEc1TlfmG10t7RPi5dL99/vuO5e7zB2
	joCtCb4+2Bq7+DD9zWjOPZYWJEFL6Duk2qeF2EsscIkQACB367vrXw8U8X7pp6RpR20LA8Sosbe
	aL2MmJIARiPiAoc5JlixK1CfI6vVYTspbIRb/LhYdl6ntIfxSBIfaZPOTZvZonCEO+l8rr+Ggy+
	cNGKCpF1tppBCGd0YWnMb
X-Received: by 2002:a05:620a:28c1:b0:7e3:297d:ec32 with SMTP id af79cd13be357-7e342b37074mr503117685a.10.1752786379382;
        Thu, 17 Jul 2025 14:06:19 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFgsvETj4x558m5O4J1Q3oaDXiBHmdl68wKzu5lszhWnL8Pa+XlDwiszt+zOKmmwEGKjcAMgg==
X-Received: by 2002:a05:620a:28c1:b0:7e3:297d:ec32 with SMTP id af79cd13be357-7e342b37074mr503115285a.10.1752786379004;
        Thu, 17 Jul 2025 14:06:19 -0700 (PDT)
Received: from [192.168.143.225] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ae6e8294bfdsm1408812966b.120.2025.07.17.14.06.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 17 Jul 2025 14:06:18 -0700 (PDT)
Message-ID: <b5a1314e-6733-41e3-9258-c3a88b2c90e7@oss.qualcomm.com>
Date: Thu, 17 Jul 2025 23:06:15 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V2 2/3] arm64: dts: qcom: qcs8300: Add EPSS l3
 interconnect provider node
To: Raviteja Laggyshetty <raviteja.laggyshetty@oss.qualcomm.com>,
        Georgi Djakov <djakov@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Sibi Sankar
 <quic_sibis@quicinc.com>,
        Odelu Kukatla <quic_okukatla@quicinc.com>,
        Mike Tipton <mdtipton@quicinc.com>
Cc: linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250711102540.143-1-raviteja.laggyshetty@oss.qualcomm.com>
 <20250711102540.143-3-raviteja.laggyshetty@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20250711102540.143-3-raviteja.laggyshetty@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzE3MDE4NiBTYWx0ZWRfX5W89Sqs/Ff5L
 BVzBeFYVbsMK+SU3KkAVkQfluDr436r+GZp3dvE+/4SgJmVRY91aWCpHXS/qcgbJeCbfHLpT0J6
 tRV5JrNn0b3U3TjQZIFZfqhx9fF1sZtlzGUY7QNsGGLMb6GdW5Une5R7CQ5VkyQEi7FK5yDy2Z6
 /BzESBA4R1PtXnL0v9ohRlYpazhREdBFteVlsWvjiqY+eJUz8oi+W1L/MBiyL23MN1nXN02CtfC
 J9O07ubFUC0xs5CuDKeDBH6UPvV0fct28FSCVUMuniMta6+9VJQIkDYfC5n19ivJ1DkRv6lgmO+
 eDn9dYO8BPdVly/YJvdhb1S5a7OR6s/TuB4KpBmrAAupytdh6hV3UDh/GruyLjKQib4t4o908Js
 GCKxxbKTEDeX1gVD1SjSU2evrzqbHQ1PKuAJn0F+k8KbxZeeZXYFGbwNVCu9reQdRmsrIJ4E
X-Proofpoint-GUID: G6IYatXSLjIVUCLGDxZpuek7-8ytXFK6
X-Authority-Analysis: v=2.4 cv=SeX3duRu c=1 sm=1 tr=0 ts=687965cc cx=c_pps
 a=oc9J++0uMp73DTRD5QyR2A==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=EUspDBNiAAAA:8 a=yqcj6WI3IahE-w5yY7AA:9
 a=QEXdDO2ut3YA:10 a=iYH6xdkBrDN1Jqds4HTS:22
X-Proofpoint-ORIG-GUID: G6IYatXSLjIVUCLGDxZpuek7-8ytXFK6
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-17_04,2025-07-17_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 mlxscore=0 priorityscore=1501 bulkscore=0 phishscore=0
 lowpriorityscore=0 mlxlogscore=999 impostorscore=0 clxscore=1015 adultscore=0
 suspectscore=0 malwarescore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2507170186

On 7/11/25 12:25 PM, Raviteja Laggyshetty wrote:
> Add Epoch Subsystem (EPSS) L3 interconnect provider node for QCS8300 SoC.
> As QCS8300 and SA8775P SoCs have same EPSS hardware, added SA8775P
> compatible as fallback for QCS8300 EPSS device node.
> 
> Signed-off-by: Raviteja Laggyshetty <raviteja.laggyshetty@oss.qualcomm.com>
> ---

Squash patches 2 & 3 together (because otherwise you'll still be hitting
the issue I described the last time)

With that (modulo me trusting the numbers you put into the OPP table):

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Konrad

