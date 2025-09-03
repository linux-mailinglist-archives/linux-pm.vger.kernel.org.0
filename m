Return-Path: <linux-pm+bounces-33751-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 52003B42878
	for <lists+linux-pm@lfdr.de>; Wed,  3 Sep 2025 20:01:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F3DC24832E7
	for <lists+linux-pm@lfdr.de>; Wed,  3 Sep 2025 18:01:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C8BD362066;
	Wed,  3 Sep 2025 18:01:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="j4ceDE7d"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E1BC35CEDB
	for <linux-pm@vger.kernel.org>; Wed,  3 Sep 2025 18:01:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756922503; cv=none; b=dDPGSB2XsBuj0Bb1I32mnn2/gmqTpN9hcTVCnJ2Z9wAhSelCD7RiBgzgH2P96aYS9rhwJbapYOXt23Sx4KB/S2rmGCZQC/vQET2TV5JL9lw3PUMEq/KlbZc3fv6nkAuaC+I3RQ+Xb6RvdRmuQ49C3L5RGW50B34ZOoMdLCQ1Zok=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756922503; c=relaxed/simple;
	bh=7pnDp9VhTyE3htCGAVgMQLhag197BUUR1H7lClQJXHk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Pw6sXY4vQEUJ8BHOQZKISAOX+7DHTpx33hDE95OvzedeIzl3mBvGN5V3U5P0lNsX1ODczrUX9W9uXDdE8LlOcscOkBlpTuz2B4Gnq9/Roa8cMIpKLVPnnkCJ6FIYbQ17ZiuOIAatbSYJGoFthdC1VcKYPNtXVYcvxQ1YsYH1pKA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=j4ceDE7d; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 583Dwq9D005254
	for <linux-pm@vger.kernel.org>; Wed, 3 Sep 2025 18:01:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	e/p6NQMyBBmLey3xjPGP/xYfDYla1BUyFB6KTGlNvQY=; b=j4ceDE7dGvyAemkZ
	CRwsJwmPM7rg/FpONIX/f3c9qs9NwhXkXZxENiVJ8wD+2cTwRj4EDfqTQ2kB9L4t
	wG/gLq4r9g6ywmf4IZjotAEI/Z+TOjzSDZKo2eo2XMbgstm3sqX46sMnfVb8qACI
	jzl1PVtSscG+pIVykfyEE2HAqMOU5ty8qlC1hCjn2oMvmdWMvz3DwFwakG04RzhR
	X1sOaln/i252utxL6KjL3uvkS8BvlRwStcT0VhtZiTCoeYzzhir0xL67xGDWjhIU
	QDqBeUeTcUnsZzwVefnTn/2B1fLySSqwLoAKwcMUCtBLTIHO9KzItooslQwEXF0H
	dZHv0A==
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com [209.85.215.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48urmjmp5x-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Wed, 03 Sep 2025 18:01:40 +0000 (GMT)
Received: by mail-pg1-f200.google.com with SMTP id 41be03b00d2f7-b4fb25c2e56so68979a12.3
        for <linux-pm@vger.kernel.org>; Wed, 03 Sep 2025 11:01:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756922499; x=1757527299;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=e/p6NQMyBBmLey3xjPGP/xYfDYla1BUyFB6KTGlNvQY=;
        b=OP+0rV0Z4FsUXZHkfUbuG19moi0ZMXgzvzjWMGqP/kYjSbXyp4O+41RpbwlOygtoeR
         /T9EbhO7lk2yoH8KX83o5Nma+iNlUUGfUVYqcO3oNhQoltiOGz+J4Zd0UyiidpCPy24+
         hFQqZYWP4RWNYrQlNgauMr0UcJ051sj5OajDeRo3zVZV7Di/m/mf9MEh1ZIpoKvaoEkJ
         GazQpZ19djr2w3Qk98ZPjJsspYkfTosnMrWfZ5WqBD1mHRb2GEckv3h50PCznMM9TSDZ
         1rTRjH53TVUtDsOWEOsd7rRMz11w1ubMFw2TE759qTWFyRZNv6DotD4h4phuxn2mdNmS
         x3jg==
X-Forwarded-Encrypted: i=1; AJvYcCXwdEZw+czbIBWy2YxTMsTLlS10p6xck5NHlq8fCxeawXLQsvOhHramwDxfg55m9NJrVw4/wKra2A==@vger.kernel.org
X-Gm-Message-State: AOJu0YzDPtp0icbEacbhiOm4fOO25ITE+dtDQOM2+p/6lC7EDDaZ2ciK
	cdE/jtzuf5n1iJkacGypua9sLIV3HOrftVh/AvtMDbWJuVCUvhW7xwdpQxBEOpszHKtAfnD6Ua0
	+yYNAIS8yviaqgVoAHR00yiegb3q1K4UjDNW3M6XxH9DLTwBNtpZER9c8kTlmEg==
X-Gm-Gg: ASbGncvtQ0uujLfgy8P2bPYlyr20oYmW48bmVT/2ghC7br3iBC34hOXVuJFiCRa1lJb
	C439y08ctddxU7/ARxrmzqO/7/U2Ob2OLeyunPNId5/MYG0IiCyz9zGUQuffdJ72mrOWxHRI8zs
	TRKRswgc35yXWhfQxM5Oe5p5oOHeGOmNOMFAzLDm1TWWF0tIBGpyJof2T8BD2B/VDrlyHjZi8TP
	SxE5vRGXYronEhxyVGjPfwVqVUXo/cwdd32bQSv/rIkrUKc6FcIzMiUlOfWvIyaMbktH4XrWReR
	ACB1PFEaxwmNJ24xI7wK2USxu3P3lOfRHrmq77lUp23KzR5qD5E2Sw8Ua64ZOXAh6/QFO8U=
X-Received: by 2002:a17:90b:1b12:b0:327:7c8e:8720 with SMTP id 98e67ed59e1d1-328156e57demr19444729a91.34.1756922498369;
        Wed, 03 Sep 2025 11:01:38 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFeb9eLZArrjeEJcIg/7Rx3a/Fa169OALXNV2q0nNF+8FgBvv+z9E0vUippWGNtAeLloBrrCg==
X-Received: by 2002:a17:90b:1b12:b0:327:7c8e:8720 with SMTP id 98e67ed59e1d1-328156e57demr19444658a91.34.1756922497588;
        Wed, 03 Sep 2025 11:01:37 -0700 (PDT)
Received: from [192.168.1.8] ([136.185.244.63])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-327da90e423sm18122214a91.20.2025.09.03.11.01.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 03 Sep 2025 11:01:37 -0700 (PDT)
Message-ID: <6cdeac85-a803-4b75-8fb5-c9d485ae374c@oss.qualcomm.com>
Date: Wed, 3 Sep 2025 23:31:30 +0530
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] dt-bindings: interconnect: add clocks property to
 enable QoS on sa8775p
To: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
        Georgi Djakov <djakov@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>
Cc: Raviteja Laggyshetty <quic_rlaggysh@quicinc.com>,
        Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Mike Tipton <mike.tipton@oss.qualcomm.com>
References: <20250808140300.14784-1-odelu.kukatla@oss.qualcomm.com>
 <20250808140300.14784-2-odelu.kukatla@oss.qualcomm.com>
 <90b51e31-3217-4483-bb5b-ec328665a723@kernel.org>
 <28b97952-1b67-411f-a7fb-ddd558739839@oss.qualcomm.com>
 <ac83c453-c24d-4c4d-83bc-9ed13f2f9d1e@kernel.org>
 <7d3e5cf7-4167-4005-ba4b-c1915c254705@oss.qualcomm.com>
 <00f50d92-e4ea-4805-b771-147fa5f5ebe4@kernel.org>
 <249f8109-31b1-4cb8-a5a4-b30c27b2e987@oss.qualcomm.com>
 <6e036d6a-f2d1-43d6-bb35-54467edd7ec9@kernel.org>
 <26e5309e-3705-4d70-a2e7-3f0e9344816b@kernel.org>
 <3c4751c3-52d5-408e-ae80-df22bcff5d8a@oss.qualcomm.com>
Content-Language: en-US
From: Odelu Kukatla <odelu.kukatla@oss.qualcomm.com>
In-Reply-To: <3c4751c3-52d5-408e-ae80-df22bcff5d8a@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=OemYDgTY c=1 sm=1 tr=0 ts=68b88284 cx=c_pps
 a=oF/VQ+ItUULfLr/lQ2/icg==:117 a=yA1qRYK8n1cH6pNkam3zVg==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=8_klXzSyxtcaGXXTCUoA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=3WC7DwWrALyhR5TkjVHa:22
X-Proofpoint-GUID: 7i3hwDGXtR4VIa4lI4pj7stdovK-SJny
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODMwMDAyNCBTYWx0ZWRfX/MnOatTJLNS4
 cJJu9z8/rzBId+WpsenYTdqPzs8AH32eaLIGaiP/Lc8jOmYVN0JYzkeWjG0uU/W4GnlRkU+1EES
 m7Zlw7NbFnt7CSR9wqNk7rRtwKM3UjqFSEQ3mGMcsrrBI3Qhg3SRTc3w32c6zEvJ3Ugv1T5xfiK
 8jWgaGoUdvsx8S5he4t3g3piJC8VOrrpsEwJpmO0tD3zbIcaX2nohbu2oYl3CpBigIomK/ouk+6
 LQ7YjRIBLLqIA59u+hAnsQDYW5bA+7nLsxpHIBPiZs2MWBik5mJN6AhA3k4tGiFyM/GRHVG+3t5
 5LEHgnP9MBy0UPd9v0NM3aIstNdT2Fuima5QsLbdbgw94vx1JHZ7p4xHJKQJJIJIctVDk4YfvSX
 M9I0EKS0
X-Proofpoint-ORIG-GUID: 7i3hwDGXtR4VIa4lI4pj7stdovK-SJny
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-03_09,2025-08-28_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 suspectscore=0 spamscore=0 bulkscore=0 priorityscore=1501
 adultscore=0 clxscore=1015 phishscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2508300024



On 9/3/2025 6:12 PM, Konrad Dybcio wrote:
> On 8/28/25 11:59 PM, Georgi Djakov wrote:
>> On 8/28/25 9:20 PM, Krzysztof Kozlowski wrote:
>>> On 28/08/2025 20:16, Odelu Kukatla wrote:
>>>>
>>>>>> QoS configuration is essential for managing latency and bandwidth across
>>>>>> subsystems such as CPU, GPU, and multimedia engines. Without it, the
>>>>>> system may experience performance degradation, especially under
>>>>>
>>>>> So how was it working for the last 2 years?
>>>>>
>>>> The system may function normally without this feature. However, enabling
>>>
>>>
>>> Huh? So you agree but keep continuing the discussion?
>>>
>>> I don't understand what we are discussing in such case, but just to
>>> close the topic from my side and be explicit: based on above you cannot
>>> break the ABI.
>>
>> To be even more specific, if we already have some DT binding without any
>> clocks and reg properties, we can't just suddenly change them from now
>> on to be "required". But they can still be "optional" and this will not
>> break the ABI, right? The old DT is still valid and the QoS will be
>> active when the new properties are present and this is handled properly
>> by the driver.
> 
> Correct and this very approach was used to retrofit QoS onto an even older
> sc7280 icc driver.
> 
> The icc-rpmh core already ignores QoS configuration if the clocks are not
> provided.
> 
> Konrad

Thanks Krzysztof, Georgi, Konrad for the detailed discussion.
To summarize: we can’t make reg and clocks properties required now for
sa8775p, and making these properties optional ensures backward
compatibility.
I will address this in the next revision.

Thanks again for the comments.

Best regards,
Odelu



