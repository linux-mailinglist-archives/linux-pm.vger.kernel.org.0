Return-Path: <linux-pm+bounces-40096-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 05256CEBEF2
	for <lists+linux-pm@lfdr.de>; Wed, 31 Dec 2025 13:18:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id AAE853019373
	for <lists+linux-pm@lfdr.de>; Wed, 31 Dec 2025 12:18:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CD80311C2E;
	Wed, 31 Dec 2025 12:18:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Cfge0or+";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="MUVcpUsd"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C919C2FD1C1
	for <linux-pm@vger.kernel.org>; Wed, 31 Dec 2025 12:18:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767183505; cv=none; b=lNYeQ3JAwoRqYUlkvpJcCM+Unfs55ZWt1zFFkG9okMxTZKM8GBESq7nmRLZZBrQ7AWjG2n9Tx0FuRJV1srToqifYnXkY+un7W7GXRd5fNUVy9eZIakiDYLVl/eNvdC7f1BZWYebomgv91LFr7HCC4d2ZYKlJ0MtgPOEezpyqMaE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767183505; c=relaxed/simple;
	bh=vR25SYRzjiDlqhb74zWnpwbujse6EwlvQv4/tQfE+48=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=IgmAfnOWYTRKNg5KOpvkBojnrVR6hhA8s15mtxFCJwRnCXWX/+Fjg9VI8gTgcPOU3jrwZBUAuw7BHGRztFtz0XenxOeScCqydk+Encqk0Z/UzoCSmDkHNxo09qNCkidDr97M1k8CtTnWEOj/1nRNRpyjHU7gFIWpMXiIkzAZl+c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Cfge0or+; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=MUVcpUsd; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5BV79AMA2734956
	for <linux-pm@vger.kernel.org>; Wed, 31 Dec 2025 12:18:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	IWPcobs6vfaZsrdB9wU8wUq6VCm4lbG0X06J5zTpzNA=; b=Cfge0or+FimIZ4ft
	ZoIjV+UUEVPWXYDwflBGfqx/ADLwjuqjmy/4pUXz3Z6OOVLH5Y1ruf1ePI+7x4iG
	pRctGSEw7CBbNBYDNtq6+6h57SIP7R3UWtOWY70q777FurXmKvMw4+Jrhf7pY1Pe
	WfKawEip+biCJpKDBF9/Lid9N8Lkp30j0fvUT/lJGTybiEyeHctmwrRryWyzAgg6
	O/Qr7FlRPitFUhNA9nyEzJ2FBAm0z/m0LUKHemdl6BEcyrpHgyLnF/jlfMkuC8D6
	C42F9WMkEVa9NqyScVZT7GLpeZFfpjkcVIyo0S56cECuPdPpYmtVReoLpDIU+Dht
	Ka8jBw==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com [209.85.222.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4bcy6aggjn-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Wed, 31 Dec 2025 12:18:22 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-8b9f3eaae4bso352714185a.3
        for <linux-pm@vger.kernel.org>; Wed, 31 Dec 2025 04:18:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1767183502; x=1767788302; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=IWPcobs6vfaZsrdB9wU8wUq6VCm4lbG0X06J5zTpzNA=;
        b=MUVcpUsdJAXVOQYX2HPwIvc3fP1shH3V1eQo2zmQWR8bACzyDYd+NJhHNXZG5cKatU
         L3+PHnTcr0pax6KcMnXDwymw/Pq0kMTYkfMSZaBoRO7g4ZsDHR8BUsZyNzUbBCbPeW29
         ab2Q6HWrugt5juBCgpVCYlk0NZkCER45vxl+IMzPOgp4WqwCGPTCxmDq+5SWhIEfVgY0
         Pa26NS9LRRYjWCkrpLF3OnWbL4pXRNHlhta3hRs+rwGNx+WPyDiiE6Mw4yAwpJmPRto+
         24GiGj3JFWx9jfnoTOeOjfTp34TVxomOjYUCG48eklHxAoOXU8Af1TxpcHkDfxgwO0L6
         /Q/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767183502; x=1767788302;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=IWPcobs6vfaZsrdB9wU8wUq6VCm4lbG0X06J5zTpzNA=;
        b=rA6wbnOptaQE7LnXUy4V5sTpLb0DwphRIkr3x/6XAV+KfEQOBPaZZq5fXnP425A84u
         Tdk4l6Ce7gENnh9EHVyGflMKMfYwtqw+XvPa9v0XlAMMu9MqNXAMWkIF6TC9tg71Y3yw
         8kvrgXrPYXwwoTubj50xE+jr8ftXHBEOw/0Hmg2Hid775q0+sp+DjYoVIzyxUbPuuxFi
         LIyCzVxNX4jfFU1iXi2Gp865eimxE8AgC0ZP3wfbNTulhDEBQB+HMNwlWWECHa6jsQEc
         87n40pL/a1G1SRVFIa1hOD4LjsRufP5QsX/UzHJkfsixUkziqB+0pwE1ux+5tJlbzO5y
         NhMw==
X-Forwarded-Encrypted: i=1; AJvYcCUl4TMkPbEFiw1b6VqAnrLXj+oVTHZfEr0EElfLksjVlUFMxja41tIBENcqA0Op//FeyEgQ8wnvVA==@vger.kernel.org
X-Gm-Message-State: AOJu0Yy0UvjrZZnurKCvN4pS1yjkfS3qOnpICMbmLYn6hs65mZCB6GuY
	pM2MSCHm30z92xhgT6c9pEBZIzeWZJwzA7pXZ3xIHZpoJSte1xdFp4PuDYiRSVvg64lqapxtQE2
	MN2ocBWUUK1ms9Ea3zqJYDrnDOqXERYWhfDVOdb4OrarwC0z+AM+KBcIr/cAsCQ==
X-Gm-Gg: AY/fxX5IOxrEdHr6aZZny6pkEy2Zsv7JtX1KepOEqoEIJEL2vphASvx6oKDKWYW64Q6
	BHOVL8pxvpJ+JlYNA7TITOXYXj8god4BPg6UhF/thceQCpzv0LaYKZrNOaeAhWgp2Gsvz73apBZ
	p1sv3xhwo00VFbpjfbsAHNrw60J4uuZxsEJEFQOu1P2gxqaYd1HkMOZvJpsKQPcdYmbf0D8rzgC
	/+x3WOfy8EXAC4F5cTYTtOPugCG4RktaF/wjmFjD/j9UetrAFBXFfSrYbASrUmB03jdIqRxMVNI
	HXd5vIz6UvbTn/HlEKMfqTbJwYUJ50k46GhjvMzACHCvNZEvmpDz8xLyjyUxfK6x/MCfhGsSmy9
	b97qfxSqq6MsXy6SuLM+9eBlL2ZKJrywbQmdEkd6HVCLUBKqKnAfeHMV1vxtBSKX4qA==
X-Received: by 2002:a05:622a:cc:b0:4ee:1db1:a61d with SMTP id d75a77b69052e-4f4abcf3ba4mr419688941cf.3.1767183501916;
        Wed, 31 Dec 2025 04:18:21 -0800 (PST)
X-Google-Smtp-Source: AGHT+IF4xZ0NZV6OIB9S/tTaZX8Jwqb+5SJHZnAnR3CZjAFhy6aj42iDY49quAMU/SvRZ9mwZtROpg==
X-Received: by 2002:a05:622a:cc:b0:4ee:1db1:a61d with SMTP id d75a77b69052e-4f4abcf3ba4mr419688441cf.3.1767183501315;
        Wed, 31 Dec 2025 04:18:21 -0800 (PST)
Received: from [192.168.119.72] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-64b91494ce2sm37741474a12.17.2025.12.31.04.18.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 31 Dec 2025 04:18:20 -0800 (PST)
Message-ID: <9c3cfc5b-a036-4f40-9121-5e00893f4301@oss.qualcomm.com>
Date: Wed, 31 Dec 2025 13:18:16 +0100
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 11/14] arm64: dts: qcom: qrb4210-rb2: describe WiFi/BT
 properly
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
        Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bartosz Golaszewski <brgl@kernel.org>,
        Marcel Holtmann <marcel@holtmann.org>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        Jeff Johnson <jjohnson@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Manivannan Sadhasivam <mani@kernel.org>, Vinod Koul <vkoul@kernel.org>,
        Balakrishna Godavarthi <quic_bgodavar@quicinc.com>,
        Matthias Kaehlcke <mka@chromium.org>
Cc: linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-bluetooth@vger.kernel.org,
        linux-wireless@vger.kernel.org, ath10k@lists.infradead.org,
        linux-pm@vger.kernel.org, Krzysztof Kozlowski <krzk@kernel.org>
References: <20251231-wcn3990-pwrctl-v1-0-1ff4d6028ad5@oss.qualcomm.com>
 <20251231-wcn3990-pwrctl-v1-11-1ff4d6028ad5@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20251231-wcn3990-pwrctl-v1-11-1ff4d6028ad5@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: etV4R6GXnqWdg42NSH9AVKoLga8g27AT
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjMxMDEwOCBTYWx0ZWRfX0YDmtAYzn5ao
 bagyXOqZzwOTazT/CKSXezy0cAsBlq2fdyw1dJJfMwUrhPK6lzx3Usp/p+TAIs7zI5PCGP3B6LE
 bULsvfVYQ/TPpSEVh4ZjN7e3jlgu3NJfQGxjTvuyXx22yB+Yw0t22ouVXbwYAxsBSAV2aAVHhs9
 yR5XQRhT6qZQi4p9obLo6ZkPbGuoSiZFN+zmhJfjp8Zd+yUyb41j/SIoGwbn8DL4t310SJanzfU
 xyc8FzOvIDI25yzzgAjxEOwL31PKGC3iFiKTaysijNl9IvTYkD0PDPus2Cx6tqfD+i4Vh1TYVV5
 jdh1MOEHgEnv+8oXpkAOafyKkvskcCXEeAQbLW2U/qY1NRrkAOethEahk56F79mcjyfLxDWyqaS
 EQkNbY9OmJwts2Ev//Bh5Wmiq8CW4CwBZXnW6zVnxm7glI+gP3Ail1n/+wSnvjQ+/YtcH/FNL2b
 c4KK0thBqjLK8r776pQ==
X-Proofpoint-GUID: etV4R6GXnqWdg42NSH9AVKoLga8g27AT
X-Authority-Analysis: v=2.4 cv=J9GnLQnS c=1 sm=1 tr=0 ts=6955148e cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=wP3pNCr1ah4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=EUspDBNiAAAA:8 a=YN4nVyxdPvXl5XCbABQA:9
 a=QEXdDO2ut3YA:10 a=bTQJ7kPSJx9SKPbeHEYW:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-31_03,2025-12-31_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 phishscore=0 adultscore=0 impostorscore=0 spamscore=0
 suspectscore=0 bulkscore=0 malwarescore=0 priorityscore=1501 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2512120000 definitions=main-2512310108

On 12/31/25 12:36 AM, Dmitry Baryshkov wrote:
> The onboard WiFi / BT device, WCN3988, has a simple on-chip PMU, which
> further spreads generated voltage. Describe the PMU in the device tree.
> 
> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
> ---

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Konrad

