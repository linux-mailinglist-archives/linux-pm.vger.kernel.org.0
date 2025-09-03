Return-Path: <linux-pm+bounces-33712-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 895B1B41F6C
	for <lists+linux-pm@lfdr.de>; Wed,  3 Sep 2025 14:42:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4963520111F
	for <lists+linux-pm@lfdr.de>; Wed,  3 Sep 2025 12:42:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41B9D2FE56B;
	Wed,  3 Sep 2025 12:42:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="KPvTAbyx"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B78362D1F61
	for <linux-pm@vger.kernel.org>; Wed,  3 Sep 2025 12:42:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756903329; cv=none; b=qzjEu+5R8F70qpMr24mRF1D0yW2slgY9a5rSEwhojNyQdUcsqME1k9SCssOvRJDHRIxgiM7ZkcxbGhXfT5J3zqdgC2dU4aNycOSCltPitm54H2nJIV5xdDNwvbnKoNS0o96P3in9xXY1n97J02v/fS2JUsCZpjKDiwTgf7zq51I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756903329; c=relaxed/simple;
	bh=E1Cna2N6t9JI+222gYwxRIEMiszhSQiq7OVsmw0ymsc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=EagaTxhdZkDw+xR9XI63chENb/fjB2/yxQOwgzBS0KPvfoHERC5fRT5SqHiKWI5NpEFXJlKEYwuTirvYglaUBISsn/B9DzZteDy5ta0Vf/7trKZnG4LQ53HqSnwvGtl8F3vQJETLcSFbR4hTOmTkqbxkYR4Dg7Q3L28R3JqT3ZU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=KPvTAbyx; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 583BEx62000809
	for <linux-pm@vger.kernel.org>; Wed, 3 Sep 2025 12:42:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	UyKqXw+ysFsFYLn6dUcHiY+1la1eKIWGJlMEPy3Xe1g=; b=KPvTAbyxdOAR12ei
	60xecrPb+TPyiRkSD0snqlxUlWPHcUjFg+H7+9e/NY+3CbtQGIYpB4SUyrivMvXD
	mbVDZrMl/Dyq9FQvNxH/MvuLhT3y7oefheUXcplUlgiNn6ak7+EVxa/2tOlOZRXO
	ieQTIBmI7YCIXXNP+DjYp9sEiLOjzWX1jRccygpo8I6Y4PoMLDIvfOYeaCej4V+L
	fhudvYGhNSJsbiaQ91ibNbCx9SwT/QlKkZhgFn6YBUOtCOty1dL5FmUo7T5NWVMr
	VOg5+1WzMxU0JhTwukeWO0CdxEM0LYz61pn0rqDY9NtNyA6oN9vdTXMlqYPnUGE1
	wdLVhQ==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com [209.85.160.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48ush33j50-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Wed, 03 Sep 2025 12:42:07 +0000 (GMT)
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-4b4bcb1e32dso669211cf.1
        for <linux-pm@vger.kernel.org>; Wed, 03 Sep 2025 05:42:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756903326; x=1757508126;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UyKqXw+ysFsFYLn6dUcHiY+1la1eKIWGJlMEPy3Xe1g=;
        b=AdZOqOVOeYL/p5Ol39wfkZRzO2uGaUBEKy7bEDjju0Bdn4UEuCuMiWhtAGit9upO2s
         oybbQnPkZBO84OEoEh1Ejb3KfaDapgXsROBN3Naxyekye6H2XK+QE20zKIsYBUSftdYX
         asXeYN3HCnMJwmxCjYZ96wVDCcZESma4GwjFCyn1SHftHSTzZ5wCcegKoAxvvyERqhVr
         L1jGaVZYa7Iq3BAU7W4Rp2+wzoygk8LeFVSJgPHxnkF16D2jxu62QZByY92rYc+ixNxg
         9LYkKv9U3RogU6yx1RJ8nSdfVHMY9DMQqDQPLjS8maTE8aoBuEgaiPpbFGp/Q6CDEkbu
         N2uQ==
X-Forwarded-Encrypted: i=1; AJvYcCVYiiYYOZtfQx6mOR3PMSpcxV7kgR5XeAb0jv3mloemcCJE2iCwGWuKec2FKWkF9Vz6oj5/shhxng==@vger.kernel.org
X-Gm-Message-State: AOJu0YzHdmr3wv4liSX9ifNFuwdKhPam/sWguioEs09l9K2K0hlCWfCp
	88cYJPAfs4arb1By3hYZ+ZGWMO1IDMzR+KzMt/v5R2vDtZKIXn6RS1JwpQ33WiUglDPOZFyAcYo
	ijgviZ0sIJAr/il5sNfIEhCpOLBMnFuFq5jfph4AFduY6By5gvRQn8kYLwQCwGQ==
X-Gm-Gg: ASbGncueWq5WRxAvGzMOovUDbjYM82Si0+6qO+jl4PT97BcbhUTprOxV11DmkkG79JZ
	Z7D4a1ubLqUJV3sazA5SdrAKvUI49h2z6pn6BbB1JdC9c8OW8pq0K3WCx1Qpr0H01LS9NEPj2yf
	lzw6vmrtQyBDrfudy4+e0XVU60jZRzilFffZcryThCzV8dkPTeBQDPxcMPqWXivPrtjvb0+iYxc
	uw8RYVfH2GWeEM40EH/DCn1her7Oygrt1PPjpc2X6UoNI+ggi7V4VsWnlq+/DDsZmkdVkzrG9od
	izmm7Oth7KMLCTBDEMV6NpKfcARTgsquB326xBYXc/NV3uGFjf15TkwCZ3flaQruPcB1BthKklf
	Fi/yZTTzyBjZKtw1lk+9jQQ==
X-Received: by 2002:a05:622a:1992:b0:4ab:7633:c58e with SMTP id d75a77b69052e-4b313dd0295mr147827331cf.2.1756903325640;
        Wed, 03 Sep 2025 05:42:05 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEsWMsoVz20vZMifq7gvXp5WENey2TR6INKN0I9TlYR/V7hgmuniZ60zIFTZtgxCrX1f0kK6Q==
X-Received: by 2002:a05:622a:1992:b0:4ab:7633:c58e with SMTP id d75a77b69052e-4b313dd0295mr147827041cf.2.1756903325090;
        Wed, 03 Sep 2025 05:42:05 -0700 (PDT)
Received: from [192.168.149.223] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b0467f47d4csm173799466b.11.2025.09.03.05.42.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 03 Sep 2025 05:42:04 -0700 (PDT)
Message-ID: <3c4751c3-52d5-408e-ae80-df22bcff5d8a@oss.qualcomm.com>
Date: Wed, 3 Sep 2025 14:42:01 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] dt-bindings: interconnect: add clocks property to
 enable QoS on sa8775p
To: Georgi Djakov <djakov@kernel.org>, Krzysztof Kozlowski <krzk@kernel.org>,
        Odelu Kukatla <odelu.kukatla@oss.qualcomm.com>,
        Rob Herring
 <robh@kernel.org>,
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
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <26e5309e-3705-4d70-a2e7-3f0e9344816b@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODMwMDAzMiBTYWx0ZWRfX3XocFNYsBsVC
 g3HV7kh9HSTEMsLTFnq39xEIl/gfOV6/6GCykUvy+03tlfeXn0reSnJ33Za62HhAwxITwVIOyD6
 ejAtWf+SxzonFM891Rx8g+WrM8Xysh6byGIuQt7SZGEZ1/BfHTFcgjRgY4GfENf2Vc00ptit58I
 nLT3oVX/GCHoDiPCTjihKXOllXFMU3QIhppFOsbewbo28mCNtISP8BpmSVfpgTFuGq83YBMth/3
 sZEm5saYboAtAyVGvMk0fgrQqnLtqpoxQIdoplwtkEdYHqmg3vhgCEQ+dAuGuoXDcMYJfkQsdUG
 RJiU8tF9LoW7dqBLGI6qvh1p8xTbM9HgIZDOJVLw8inRJSuBsbyaG7pggj3gsF56Lm0QWSuaauU
 HU+EDDjB
X-Proofpoint-ORIG-GUID: 4siLAsa7ZxTvqjdnfk0aImzqjsrpI274
X-Proofpoint-GUID: 4siLAsa7ZxTvqjdnfk0aImzqjsrpI274
X-Authority-Analysis: v=2.4 cv=M9NNKzws c=1 sm=1 tr=0 ts=68b8379f cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=XlH8FPY39J8rQsCe0dUA:9
 a=QEXdDO2ut3YA:10 a=uxP6HrT_eTzRwkO_Te1X:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-03_06,2025-08-28_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 adultscore=0 spamscore=0 priorityscore=1501 malwarescore=0
 clxscore=1015 suspectscore=0 phishscore=0 bulkscore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2508300032

On 8/28/25 11:59 PM, Georgi Djakov wrote:
> On 8/28/25 9:20 PM, Krzysztof Kozlowski wrote:
>> On 28/08/2025 20:16, Odelu Kukatla wrote:
>>>
>>>>> QoS configuration is essential for managing latency and bandwidth across
>>>>> subsystems such as CPU, GPU, and multimedia engines. Without it, the
>>>>> system may experience performance degradation, especially under
>>>>
>>>> So how was it working for the last 2 years?
>>>>
>>> The system may function normally without this feature. However, enabling
>>
>>
>> Huh? So you agree but keep continuing the discussion?
>>
>> I don't understand what we are discussing in such case, but just to
>> close the topic from my side and be explicit: based on above you cannot
>> break the ABI.
> 
> To be even more specific, if we already have some DT binding without any
> clocks and reg properties, we can't just suddenly change them from now
> on to be "required". But they can still be "optional" and this will not
> break the ABI, right? The old DT is still valid and the QoS will be
> active when the new properties are present and this is handled properly
> by the driver.

Correct and this very approach was used to retrofit QoS onto an even older
sc7280 icc driver.

The icc-rpmh core already ignores QoS configuration if the clocks are not
provided.

Konrad

