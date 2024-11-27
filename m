Return-Path: <linux-pm+bounces-18154-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B919C9DA84F
	for <lists+linux-pm@lfdr.de>; Wed, 27 Nov 2024 14:16:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7E68A282409
	for <lists+linux-pm@lfdr.de>; Wed, 27 Nov 2024 13:16:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89F411FC7ED;
	Wed, 27 Nov 2024 13:16:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="Y6BxhUiv"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0F171E51D;
	Wed, 27 Nov 2024 13:16:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732713377; cv=none; b=JjpaRHDmZEKwq/dTGUhRUDb0KkCCN76YqwVLj2Jv8niQjCY5Xk6oQa7vauJepNnMc9BYnSEFSAOiQjjojvmRdvYEBG/aGWyB5qd6NFrGRj+aN93O6k82bdEzaeiLDgbefAppWOFEHwT/9tGJZxne2PK9N1asp8IcLc1p7SbfBrM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732713377; c=relaxed/simple;
	bh=8eknH6HXT3j6JDaNc/49pIIgqgFs3QKYYO3WJO7uI4Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=g8G/hhbu+sEV7yxVVtk1FXjjQHmfzdLpd79JxZscDuC1hri2Qe2wsUplJ7KCtHufumEWoC8yF/rodw4zDYgchfy+izdnKkjsPTQLxn1OT+r0tbb6xz21gMw+uSWPJHyMLV8Mxv4klV3WDe1j62atWKimmB6NC3D7PPk2bd2YeBI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=Y6BxhUiv; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4ARAgJoh018035;
	Wed, 27 Nov 2024 13:16:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	nXQNR/PhjDT4rqjrOPi0Dkq4eZ2Sql4vyc8VAKlFBVc=; b=Y6BxhUivofZ3/Wbn
	UNqCtzTiYSODM6w08nJ9vv7Ta4rmtwwdt+r8D8/Yxg2KgfbWk7zGYkVrUPc75P3A
	WSxM548BADc69gF0d41sz0e4bVAfM0IacI3cRYPO/NhfMe6Ydybz0KCZMgMjDZBC
	cKCj8b3DLFnqHvOH34mfa9Y1oOGd107CYGQ/KnOOdfjz3fqpqyEE5OuGledloS38
	mSub1MGep9H6PSSSax3c6Wnm+RQ6PLsxxUp0Bvt4/uD8XapkRgZbSUvg7ayyxLpq
	LbhhdYOA+0l+6lIRcuLrU0OynlKtscTniQVzmD7td1n1ys5hnNXVWGhP8MpSyw2Z
	jitO8g==
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4361wcgexh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 27 Nov 2024 13:16:06 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA02.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 4ARDG5wK015473
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 27 Nov 2024 13:16:05 GMT
Received: from [10.219.1.29] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Wed, 27 Nov
 2024 05:15:59 -0800
Message-ID: <c3d3efa7-13cc-4b84-b60f-4d25c272321c@quicinc.com>
Date: Wed, 27 Nov 2024 18:45:56 +0530
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 1/2] arm64: dts: qcom: qcs6490-rb3gen2: enable
 Bluetooth
To: Bartosz Golaszewski <brgl@bgdev.pl>, Krzysztof Kozlowski <krzk@kernel.org>
CC: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
        "Rob
 Herring" <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        "Conor
 Dooley" <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        "Konrad Dybcio" <konradybcio@kernel.org>,
        Marcel Holtmann
	<marcel@holtmann.org>,
        "Luiz Augusto von Dentz" <luiz.dentz@gmail.com>,
        <quic_mohamull@quicinc.com>, <quic_hbandi@quicinc.com>,
        <quic_anubhavg@quicinc.com>,
        Bartosz Golaszewski
	<bartosz.golaszewski@linaro.org>,
        <linux-arm-msm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-bluetooth@vger.kernel.org>,
        <linux-pm@vger.kernel.org>
References: <20241127115107.11549-1-quic_janathot@quicinc.com>
 <20241127115107.11549-2-quic_janathot@quicinc.com>
 <873e45b4-bcca-43fa-ab90-81754b28629f@kernel.org>
 <CAMRc=Mf-cO9M9=P50mhPDvRRBSYVZUDrEVa1jcMvAsjdAq6VLw@mail.gmail.com>
Content-Language: en-US
From: Janaki Ramaiah Thota <quic_janathot@quicinc.com>
In-Reply-To: <CAMRc=Mf-cO9M9=P50mhPDvRRBSYVZUDrEVa1jcMvAsjdAq6VLw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: YZdlLkyafYCL5wp0UYVzao7Iasy1tSJn
X-Proofpoint-ORIG-GUID: YZdlLkyafYCL5wp0UYVzao7Iasy1tSJn
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 mlxlogscore=999
 malwarescore=0 priorityscore=1501 clxscore=1011 mlxscore=0 phishscore=0
 lowpriorityscore=0 spamscore=0 impostorscore=0 adultscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2409260000
 definitions=main-2411270105



On 11/27/2024 6:38 PM, Bartosz Golaszewski wrote:
> On Wed, Nov 27, 2024 at 2:05 PM Krzysztof Kozlowski <krzk@kernel.org> wrote:
>>
>> On 27/11/2024 12:51, Janaki Ramaiah Thota wrote:
>>> Add a PMU node for the WCN6750 module present on the qcs6490-rb3gen board
>>> and use the power sequencer for the same.
>>>
>>> Signed-off-by: Janaki Ramaiah Thota <quic_janathot@quicinc.com>
>>> ---
>>>   arch/arm64/boot/dts/qcom/qcs6490-rb3gen2.dts | 174 ++++++++++++++++++-
>>>   drivers/bluetooth/hci_qca.c                  |   2 +-
>>>   drivers/power/sequencing/pwrseq-qcom-wcn.c   |  22 +++
>>>   3 files changed, 196 insertions(+), 2 deletions(-)
>>
>> DTS is always separate and cannot go via the same (driver) tree,
>>
>> Missing bindings.
>>
>> Missing changelog, it's v4 so what happened here?
>>
>> Best regards,
>> Krzysztof
> 
> Ah, so this is where the driver change is at.
> 
> Janaki: the DT binding lives under the "regulator" namespace so it's
> Mark Brown who typically takes changes to it via his tree. I pick up
> driver changes into the pwrseq tree. Bjorn takes the DTS changes. Luiz
> and Marcel are responsible for Bluetooth changes so you will have to
> split all these changes into separate commits.
> 
> Bart

Thanks Bartosz, will split the patches and update.

Regards,
Janakiram

