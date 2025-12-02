Return-Path: <linux-pm+bounces-39075-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id DC440C9B97F
	for <lists+linux-pm@lfdr.de>; Tue, 02 Dec 2025 14:28:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 11E8F347C1E
	for <lists+linux-pm@lfdr.de>; Tue,  2 Dec 2025 13:28:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F19FA315786;
	Tue,  2 Dec 2025 13:28:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Uh2B1dnl";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="edaX3CSg"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7820C314B96
	for <linux-pm@vger.kernel.org>; Tue,  2 Dec 2025 13:28:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764682088; cv=none; b=TEI8oZa1hb0H8Km2wsbouHQNNzhUbWeLyWdlz4EaEUvX2Wd5wkl9oW0y6s6S4cvod6HF+La9UoRkXPBZTD0aQGxSNEz0RwezPjSTxn7UxF0pyoixf/eM6y81dYB/aZT8qZVUnT+5bnmWCXFJaRNCSaglviLqkD1yCZPP8lKcpTU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764682088; c=relaxed/simple;
	bh=omEADPEFpCtodFUgCY7F/Xae9OmSA4gE2tWXlmUU05E=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CSpP6mIpsjGUlbp+JbVk/krcHWHEyG1UfkqiCqOShOBrv2Q53h4Y9Uv4d4b0uyh5I6kIc7QxTU9gsY9GHxkLqYrOGU7DCeb/PkqGjAoGhcOEbwhGpjC8FpOvW4J8W5bMcaAdZ5qbK80qTEkreYbCeBjZrAcVkRyUsZ4QmXqYOBo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Uh2B1dnl; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=edaX3CSg; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5B27M2XW2692832
	for <linux-pm@vger.kernel.org>; Tue, 2 Dec 2025 13:28:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	cGSZe87CZjxr7Wk/kqndn3Caz/wNBKP+z4zDP6I+8Jg=; b=Uh2B1dnlxaBY9yux
	5+X68KQrLjS/X35pJJMt19asVdm4bvm1I7xG91QmYyTzuqe9KaFZpcMcA9r8fLfm
	hSKZWHLwVjx+7bVsUYuIm4by0PXSClfqXM9wr1rsMP8c8jmV87AfEWTOsiFlPWg8
	tqF5EcotpU4Kkyr5CCDfbt00krB2542m+ccxd65r0jstIlp4kNLIPj9dgIJ08NSo
	30+Bfa2THF5jsS92wLUmYe+v38GeVd6L7fsHTFr+m64vEHYA+j2BNM/Uj8pV5K+Y
	ql/F8/1rOMlrvfY2nbN3OXZzQlT2N6roPxeM/VK16xm32k8tmYSNq2CreeUSkWbs
	FuRYsw==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com [209.85.222.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4asun913gx-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Tue, 02 Dec 2025 13:28:05 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-8b10c2ea0b5so183464585a.0
        for <linux-pm@vger.kernel.org>; Tue, 02 Dec 2025 05:28:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1764682084; x=1765286884; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=cGSZe87CZjxr7Wk/kqndn3Caz/wNBKP+z4zDP6I+8Jg=;
        b=edaX3CSgRvvL7x1QiUnh7I58GH0Zi91PqOdiuvQSCZuQopkxjbpwphKOfvqxfBwUP7
         J6/+NpANZDbAyDf4qMwDbt1teg+AlVZ9yW0FihC7wpwHIz7Ejnkev87SAJjRZDSLwtGp
         PGW63GWQgNLw1wxZt6GQass31VwmaOVZETS7tkMWtxFpzC1Deae9wDlUWYW13W1FmIk4
         Rwk7l1GeMReKGVgV5Mu1hDaCY/qtDPla95DUwUD86U7RccmoHkjtSh2O86ay/C0AxnxD
         OpHaMoMuNo1i3ICAYsjhGSYBseo9TEuU3/YsEanb1QijciG4/26YDVn3Wj1Y0AivMWsE
         NFUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764682084; x=1765286884;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cGSZe87CZjxr7Wk/kqndn3Caz/wNBKP+z4zDP6I+8Jg=;
        b=gRNsYn54HheX7cCmUaqdiysLYSGv8aWZuEDBHlyZQDevoj0IHKmYe7Y0Rudoc8JKh9
         XyoNYK78+79Y0uMvl8Bnpln6Ni90qwc0ahdVpYIADEFEVHnPd9vQkTLXDS+9QI3hBWLX
         cA23gM773FiYWtWCmhsgZgViESzbAm8yj1MHHexD00n0dJ+PDDFlGmhaowpxl0yvI9lT
         2utO3Cns3AP+vtaWGQSRf8cmQm+KFzEh2IdPp9PlthZRXZDf6Kak9DbKVpuSmb2zEVa8
         BkbanXQqSbEQu63RM6Y2ftx10LUuKMWtmIcasY5mQ3c7T/+GncepjXhvRnfUg2FiSLPL
         1E7Q==
X-Forwarded-Encrypted: i=1; AJvYcCU5yHYyMpHIjp/jrc2GsYBhnY3VFUU2xKBQId3RLI6VQkYAnFQxwCJvnQXQ2PAN7EFGid11IbkHZA==@vger.kernel.org
X-Gm-Message-State: AOJu0Ywll8mlsiXzUS1LQYLRTo7dx6WbTAWpCbJ8ANGkbpwWQBJ88xZb
	fez5iK6jkfBglRPy82Bti1GApom+hWL6tRyJAAauaPoTf/AEB5A8kNkw1MoXPNP2kWh9VsLz47K
	ABzu6mm6H6yvkDkIGVv2MSm/OYpYEwOXEd5ZN2fh+PlcsH7MDvFEjW34/buLWfg==
X-Gm-Gg: ASbGncvHmutMom/PIcVCCezZkvFk8Hg29KEfzW29mjvY24WD9sm7MmEuonrERZ1IQVm
	OQkfWClNjzsFOD7evT0hEPo1bSf9y+mr7qq6uDP41Iya/spnAth+CHMFTtG/XwO4VKV2sQAeoqg
	SegkSIQF451K6N3gpH6ce8NIqH9AgbavmL3paU5a8u/77MvbDAtOevr6aJDD5pg852yp5K7MVOs
	HaDOy6AkZKaeaShQXvD5M2Cdbgw/pEogqvZhsmRfsz/lpUOzTlEzewPn8uK+CUFNnt+/tLse5ok
	0W1xWOzHCyFRlhAyQeOJDfN3utKiRecLaxymVmhw0WS1OOXwiTidaoCd+XsvF9PjK7ugjhI+Yik
	cdQiJcpE5jLcIJkoMWLmKz+wthi9Vk433Q3mZuP+BQaL84ILq0L2mtS6ihflJBHla5A==
X-Received: by 2002:a05:620a:4490:b0:8b2:1f8d:f11d with SMTP id af79cd13be357-8b341bafcb7mr4289438985a.2.1764682084008;
        Tue, 02 Dec 2025 05:28:04 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHDne9RM5gYuYyIL53Is5J79nlq/wsUZ8mDjrDMvIP+gfH9ZVz1YXpUMUnVdDE7teba51LEBw==
X-Received: by 2002:a05:620a:4490:b0:8b2:1f8d:f11d with SMTP id af79cd13be357-8b341bafcb7mr4289433685a.2.1764682083415;
        Tue, 02 Dec 2025 05:28:03 -0800 (PST)
Received: from [192.168.119.72] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b76f5a7afb4sm1500312866b.70.2025.12.02.05.28.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 02 Dec 2025 05:28:02 -0800 (PST)
Message-ID: <bb6f83cc-4f6a-44f8-9997-fb91e7c2b4cb@oss.qualcomm.com>
Date: Tue, 2 Dec 2025 14:27:59 +0100
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: (subset) [PATCH 0/5] Define VDD_MXC for SC8280XP
To: Ulf Hansson <ulf.hansson@linaro.org>,
        Bjorn Andersson <andersson@kernel.org>, Rob Herring <robh@kernel.org>
Cc: Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Johan Hovold <johan+linaro@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Manivannan Sadhasivam <mani@kernel.org>, Vinod Koul <vkoul@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd
 <sboyd@kernel.org>, Taniya Das <quic_tdas@quicinc.com>,
        Imran Shaik <quic_imrashai@quicinc.com>,
        Vladimir Zapolskiy <vladimir.zapolskiy@linaro.org>,
        Jagadeesh Kona <quic_jkona@quicinc.com>,
        Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Krzysztof Kozlowski
 <krzk@kernel.org>, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-remoteproc@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-pm@vger.kernel.org,
        Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
References: <20251104-topic-8280_mxc-v1-0-df545af0ef94@oss.qualcomm.com>
 <176418784438.1591314.8587929353938909456.b4-ty@kernel.org>
 <20251201201440.GA4041208-robh@kernel.org>
 <CAPDyKFoGQJA5UY-96HvfoA7WMb5wYFXFFfFREpMmK29GE7-Nag@mail.gmail.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <CAPDyKFoGQJA5UY-96HvfoA7WMb5wYFXFFfFREpMmK29GE7-Nag@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjAyMDEwOCBTYWx0ZWRfXxpwjl4IvMRdT
 1qXy8IpDBuIIszTcoYwtMZOBHTBO2FPjom+QPiEAJPpkHFB4bbAcgMGCAnkRSSiQNm2o7OeS7YG
 jIBNWYetBGIpNjyPJh9IdLERbQkCw9m4YaQHUZO92zKAmAXnfOQbnKScSLw/WZxjfMk7uFbyrBh
 +zOI2wSbUDfF3gs16MFG2mTv/zoA7l9iSwbQjUnL+XCAgEuGdag5CWPstyaRDkETadZmmpBiFMb
 oov2u0mN/QaFlPazODcM64o4C2xRtG5slawXpRJou9sGTn9dSYY7PzVSP4OyzFlGYssYZlANOsU
 AFvnrVPMWVMH2wpb3WK+MejNzFSVskaSWbNs1g9gsm1uBt/Mf4IXzKPuO2dhjdkFXZId+tcHOEd
 SUEog05gqKYR79O1N5u9mONwgRy2HA==
X-Authority-Analysis: v=2.4 cv=DKOCIiNb c=1 sm=1 tr=0 ts=692ee965 cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=wP3pNCr1ah4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=VwQbUJbxAAAA:8 a=Dp_8vvBim0L4lL-PpiYA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=NFOGd7dJGGMPyQGDc5-O:22
X-Proofpoint-GUID: UWjPQQKwfp1t-CJnaQa3JjABS7P57Dq9
X-Proofpoint-ORIG-GUID: UWjPQQKwfp1t-CJnaQa3JjABS7P57Dq9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-01_01,2025-11-27_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 lowpriorityscore=0 spamscore=0 suspectscore=0
 malwarescore=0 bulkscore=0 impostorscore=0 adultscore=0 phishscore=0
 clxscore=1015 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2510240001
 definitions=main-2512020108

On 12/2/25 10:19 AM, Ulf Hansson wrote:
> On Mon, 1 Dec 2025 at 21:14, Rob Herring <robh@kernel.org> wrote:
>>
>> On Wed, Nov 26, 2025 at 02:10:41PM -0600, Bjorn Andersson wrote:
>>>
>>> On Tue, 04 Nov 2025 20:31:05 +0100, Konrad Dybcio wrote:
>>>> This has somehow been omitted, leading to potentially stale votes.
>>>> On the flip side, the domain will now be powered off, which will
>>>> uncover any omissions we've made in the DTs so far.
>>>>
>>>> Reasonably tested on an x13s without pd_ignore_unused (camera still
>>>> works).
>>>>
>>>> [...]
>>>
>>> Applied, thanks!
>>>
>>> [2/5] dt-bindings: remoteproc: qcom,sc8280xp-pas: Fix CDSP power desc
>>>       commit: ca079ec3ebed19a12c1bf080496dacbc6fdfbb39
>>
>> This has was picked up, but the .dts change was not, so there's a bunch
>> of new warnings. What's the plan? I know it's separate trees. Can you
>> please take binding and .dts changes like these together if there aren't
>> driver changes?
> 
> I was planning to pick up the driver (pmdomain) and dt doc changes, as
> usual. Although, I was waiting for the discussion to reach consensus
> around dts patch (patch5), maybe it did?
> 
> Björn, perhaps easier if you pick the series via your qc-soc tree and
> send them as fixes? If so, feel free to add my ack on patch4 (the
> pmdomain patch).

FWIW the part where the CDSP power-domain list changes still applies,
even though I was wrong about the CAMCC requiring that too..

I can resend if needed

Konrad

