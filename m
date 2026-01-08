Return-Path: <linux-pm+bounces-40431-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 07BD3D01FBF
	for <lists+linux-pm@lfdr.de>; Thu, 08 Jan 2026 10:59:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 9FB5130021F8
	for <lists+linux-pm@lfdr.de>; Thu,  8 Jan 2026 09:59:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6FA034575F;
	Thu,  8 Jan 2026 08:43:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="RjoH112P";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="eP3Tw6tW"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDF9833C1A2
	for <linux-pm@vger.kernel.org>; Thu,  8 Jan 2026 08:43:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767861820; cv=none; b=Q0HtvyDAHHrOgjZMalePV0VFoPYzvhyxu9hekTWj9npZeEc9PrVtWP2DPFaAsgWo/E1kij2xvrCUltQl7P0AAkPQkUzYIkrKkX3CYuGnKzcr3VwQsQadcbx8NNgLhmrFgixw913nF7CHSZ1Qs86yEb1n7XCwqSyU0EABDHTGyl0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767861820; c=relaxed/simple;
	bh=/L1RBGqyxwzt5zmuUJHrm7b2Dc7plZB+AlIdSaEjd6M=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Y+RrKe2xU1BL/5wJeIudJ9E4CpG0KlDkkVWjcbU/50vPu7aTOJHBXo8X72L9LMcXqXzMujRUrALFmYID/s0/oxtchdyHWqOAdIdZ9viTSTLjPNyk8aupUD3upo/0GPfkh5NELj92hmt6ERZ3j081notT3rmbjh7eg6eKe9UzGnQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=RjoH112P; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=eP3Tw6tW; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6083uOvv2593330
	for <linux-pm@vger.kernel.org>; Thu, 8 Jan 2026 08:43:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	BPOoQG1/WLrFfJKEWQFWmYdIx6qCpvKkLYYmUCq7tyA=; b=RjoH112PsEKCbZqA
	1lVrTTkjDcW6jFRSQnjmeixO+/vKjNcCqVx9RASfzWPIOXc6/uS6pBs8Gxxlu3PT
	ku867K3/CqnHoNxmNqa6tYGjc0nwWN0BTOBm/7mO0erS9F6OSxWsGXsAYyVANkjD
	AtHQnVUYfTxOmdnHCySJsXk8j6psp3ksM6uVz8utIdHVod8+17pNs8haG9bMaAe5
	6I50hCB4dmk1VMemCiszWkl18gsfL7RYhKcZpGGB7z+/BzE3QkRENkrwfibn2l6k
	qhFJxzFtWQ8hVhUZ+feslP2DO6fpFgjcvygeTOfGN5NZrYLJ4M8qMtP69zVPr4te
	viRPsw==
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com [209.85.210.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4bhn293yr9-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Thu, 08 Jan 2026 08:43:20 +0000 (GMT)
Received: by mail-pf1-f199.google.com with SMTP id d2e1a72fcca58-81c68fef4d4so1549505b3a.2
        for <linux-pm@vger.kernel.org>; Thu, 08 Jan 2026 00:43:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1767861800; x=1768466600; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=BPOoQG1/WLrFfJKEWQFWmYdIx6qCpvKkLYYmUCq7tyA=;
        b=eP3Tw6tWayt2KMjL12H5vXYIH6driyXwNk6+z+oTG6p449KM5gMHLfL4G0lTNCldXE
         ZYEYcFLBCCqKiD46AG+R1i8unf1yNOL+MG2XfMLX22QawuAP1pc1hJgKAseCeORQj0uW
         QOekzUQOkQoTs5JzuKDYRkx0tfyOKkKloyra3rzHsZRP92o6EpWRLhzSkZqZnEV2eZKs
         Q+DByYXp8fi9gKnlCaLwl6vrXaD8h6H9AsrUYDOj2cEYdZTSl73XFHp7oxxyr+xGA8dk
         gJIPSf8BDF4zMg1e65ywKDts0DXeq46R86vdFYZBdCn4++e1c8Djjgp9F1x7rZz+geSd
         4T3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767861800; x=1768466600;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BPOoQG1/WLrFfJKEWQFWmYdIx6qCpvKkLYYmUCq7tyA=;
        b=QsE6PD70HLS+f1rrOz/DIhZlPKFmxsQVBmx77c2zSaiwdnTfB+2reqUFx6joAV6d8x
         MSBEdsdPtanzLudjrft+VxGkTYoiV6PWFkYF4N31OorGiGIEN17n8TaEVhfWb2Wj64cr
         8401x8Usxcqymq0APgpWf5ht2tkVEQTNC6sWCn2TRGtXODAIaAiscMIpZK9OfGM3bFaW
         2sNl6lz1TbrEW0JqXnbL6mZ0Nb8AXIS5npoGr5v41DwQe55Q+BE+Khorqjbasrdgs2Wc
         6roV7cE1QYjOjgocyWTO4tx6mA0ZEfKGn1U3TYn7wOHJh/dzfOXY9HkkqmcZC6nA9WST
         8w1Q==
X-Forwarded-Encrypted: i=1; AJvYcCUCq7QzTIzSp/9QuOzpTMF7/ezlwb2QGqYBf+GEa1sv7W88x2IVPCS8fW1WwqC6UazG3mMAddPi2A==@vger.kernel.org
X-Gm-Message-State: AOJu0Yxlfs19mkMwH4aT1zO3J08SxEAjR1l8ik6fXMDF+HxPkszWzugL
	kY5x2ZQTa8UU3d/eRcbSrY/aTUmHs6Jkb66IcQL2FI3RyV6p/uq0n8pPvvbFM3vODx/Znxf71Iw
	Klnn0AQ4rPpsUR8yQU6s7vEWnI56tvnteoYN92tuJQ6UDmG9OwWAOPcB34epqmA==
X-Gm-Gg: AY/fxX6kLrC0CKSNd/I3SCH676KrP7F8Nhff+C1QxnrYn2Xmq9yUld67MWh29yaDwKr
	9aEsj0GZm0fT+oQZYAFnzRhhXYEu+UjiEMavx50ms9ktVazwCgoDL+jhX3DFG4EmM5u5XXm+R7k
	Y38QUHUow4AbStIDsyRd0xhBhc8aDDnzRw70mtTUcCD7eE34lVNE2zS9UcBmbyBu3WctG1rszxs
	vGY3ZriTHU13+dmzibnZ59XelqlCOwVCekJjGtPGz9y96+07E5HJnYxXXUuBMong51SlBxACWav
	d8XeQmA9c1BkVQx7PkPfn3dEENHZDUuGyHvIercyJcYjmEo9HTu7/xzIii9S44Zi2fs9+LtoAqu
	yxPQ7g/YcB2wFZ22ezwp7jjmOWdi4JO23xm1g0Mo=
X-Received: by 2002:a05:6a00:8d8a:b0:81b:1a87:9eb9 with SMTP id d2e1a72fcca58-81b7dc62248mr5173607b3a.25.1767861799612;
        Thu, 08 Jan 2026 00:43:19 -0800 (PST)
X-Google-Smtp-Source: AGHT+IH7uaKjXBvAUuSttJfVLqA14vM+b4APrPJU3uKuYVZNZwLgKvmkpMc+SlUXd+RMdyIv3uhYpg==
X-Received: by 2002:a05:6a00:8d8a:b0:81b:1a87:9eb9 with SMTP id d2e1a72fcca58-81b7dc62248mr5173578b3a.25.1767861799093;
        Thu, 08 Jan 2026 00:43:19 -0800 (PST)
Received: from [10.218.27.120] ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-819c5edcf34sm6934022b3a.67.2026.01.08.00.43.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 08 Jan 2026 00:43:18 -0800 (PST)
Message-ID: <98804ad4-a481-4125-8911-965e3376be83@oss.qualcomm.com>
Date: Thu, 8 Jan 2026 14:13:12 +0530
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 3/8] dt-bindings: thermal: Add qcom,qmi-cooling yaml
 bindings
To: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>, andersson@kernel.org,
        mathieu.poirier@linaro.org, robh@kernel.org, krzk+dt@kernel.org,
        conor+dt@kernel.org, rafael@kernel.org, daniel.lezcano@linaro.org,
        rui.zhang@intel.com, lukasz.luba@arm.com, konradybcio@kernel.org,
        amitk@kernel.org, mani@kernel.org, casey.connolly@linaro.org
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
References: <20251223123227.1317244-1-gaurav.kohli@oss.qualcomm.com>
 <20251223123227.1317244-4-gaurav.kohli@oss.qualcomm.com>
 <d6396ed0-8529-44af-9d2b-cf0bf03f17f6@oss.qualcomm.com>
Content-Language: en-US
From: Gaurav Kohli <gaurav.kohli@oss.qualcomm.com>
In-Reply-To: <d6396ed0-8529-44af-9d2b-cf0bf03f17f6@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: SHMc0Tvy8ChMdSOZUHTQYfJM2gQFQLrO
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTA4MDA1OCBTYWx0ZWRfXywid1ZS3fsSG
 yGxgD8zg4Ky6LTo0gR+xYlEDj6O34+YgxKsNFCzs+uj+2ZEcCiZfubl8q9+6QiVhUEMctgGC7Hx
 01dTgfi2cWUHWQOEU1BUaPHph0HbUcfmrqDrcfIHoJUjTohIpye7cQVGAte7ZsXcKVp4MWfvk5W
 ZQnoO/2+9Nrlpo3nh9FoFDXdGvwZqdYh/G1VQH6P8i5fWLT43aNVwVvT6RsfrwwAXP3HNe3cc+W
 HfJrAVddcgiJJcaidBI1SjcJhT4BagqYc5P+Hq+jCTjVQobR9pHSOwFJmD62yK1AYgViYgYEuQV
 3umpnJI5gFUFWQRJDQ78FX2nOGClRdGlb8yAOEUrOjtYxY18cOqOtLq368ZDs0x5ujUcMXqZB0T
 8uBE3XjXHNEiP75srgQHJeHd0CKxY/UhI+y7RTYyKvVxGvcHZ7DGE2bgdMfOcVkA++vakarHnY8
 rdQGa8V0oXYlhe+LeGw==
X-Authority-Analysis: v=2.4 cv=P7k3RyAu c=1 sm=1 tr=0 ts=695f6e28 cx=c_pps
 a=WW5sKcV1LcKqjgzy2JUPuA==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=vUbySO9Y5rIA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8
 a=1smkeVCflDFu9ac9zQYA:9 a=QEXdDO2ut3YA:10 a=OpyuDcXvxspvyRM73sMx:22
 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-GUID: SHMc0Tvy8ChMdSOZUHTQYfJM2gQFQLrO
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-08_01,2026-01-07_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 spamscore=0 phishscore=0 clxscore=1015 malwarescore=0
 lowpriorityscore=0 impostorscore=0 adultscore=0 priorityscore=1501
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2512120000
 definitions=main-2601080058


On 12/31/2025 5:29 PM, Konrad Dybcio wrote:
> On 12/23/25 1:32 PM, Gaurav Kohli wrote:
>> The cooling subnode of a remoteproc represents a client of the Thermal
>> Mitigation Device QMI service running on it. Each subnode of the cooling
>> node represents a single control exposed by the service.
>>
>> Add maintainer name also and update this binding for cdsp substem.
>>
>> Co-developed-by: Casey Connolly <casey.connolly@linaro.org>
>> Signed-off-by: Gaurav Kohli <gaurav.kohli@oss.qualcomm.com>
>> Signed-off-by: Casey Connolly <casey.connolly@linaro.org>
>> ---
> [...]
>
>> +    remoteproc-cdsp {
>> +        cooling {
>> +            compatible = "qcom,qmi-cooling-cdsp";
>> +
>> +            cdsp_sw0: cdsp_sw {
> I'm curious about the meaning of the name - does "sw" here stand
> for "software"?


This is same like cdsp DCVS capping from firmware instead of hlos.


>
> If so, does this essentially mean "a software toggle for throttling the
> CDSP"?
>
> Would all such occurrences essentially always have a "sw" suffix?
>
> Konrad

