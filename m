Return-Path: <linux-pm+bounces-29166-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C2B2AE2070
	for <lists+linux-pm@lfdr.de>; Fri, 20 Jun 2025 18:55:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AA2DB6A0B01
	for <lists+linux-pm@lfdr.de>; Fri, 20 Jun 2025 16:54:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDFFB2E613A;
	Fri, 20 Jun 2025 16:55:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="mL52/1Jg"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 600351F03C7
	for <linux-pm@vger.kernel.org>; Fri, 20 Jun 2025 16:55:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750438508; cv=none; b=tcqeN0H72pcN71A+0FOyS4QA9xrHbQmbLs11hfiPGUorfOWjaHXifZ0e40FpU9ledFOtfuaZnIcnd3laOjLlqL2284HJKZ33boh08jO/vRYsbjrK2D5aq5+QKiHPm/WIAEnik4PpcaYdD6YxlkGa3Wr/7skBk2X2xXuiuz8yyZU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750438508; c=relaxed/simple;
	bh=2PjTMHy5F3iPIngcSswDszD1rmfKQu+pVIhzm5QlxFA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kZOoc3hXn1x9Y5qIDL2LsZlJwRQvYtoDoHorz2/KO+eqc9GQj3cOIenrCw5kyT1WmXGNkOAsT1j48NnkHbfDPTwOHulRA5l1gGfVV42sXrXhXGBmG3gRhTvRnmAewRGHS0U5D3StX3+rzke+tOqFRSsleaY5woObi4pFdQVkmVw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=mL52/1Jg; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55KERF1T020800
	for <linux-pm@vger.kernel.org>; Fri, 20 Jun 2025 16:55:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	Y2I2QseFJ0gr5gYIqnnWqNCwwaaSonPDD1prW4PD/A4=; b=mL52/1JgJoGggS/i
	4nE0Id8O6uM8LFH1ZMyXi7NeB3vdT6P8lbIFSEnmBwu3rzG4TnYW0rxA1xFxS3+W
	A/Tgk4sn8UFRyQIW5n1uqiNNwDDdajBTWa2ZlgRkISB42kKMQHJ5ABp1jctCXIGQ
	YCyslYKe/DLbQDQqKginB7+66PmR7fFYeEEYjqFvt2uuK+TectPsye++pn+Qq89H
	pREE28Mh/QbYDV6DvduAzzu2dEf1oMN8lpyGHtb1hAol/MKMhteC6rA0/WCCOLM/
	PbJJ4dGYl6lVD6j2NN6fzToXbDNkYYk9QsolwWP2uYfkXWPXr9N+QEwMRSxULpk8
	UAx32w==
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com [209.85.219.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4792cac4a5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Fri, 20 Jun 2025 16:55:06 +0000 (GMT)
Received: by mail-qv1-f71.google.com with SMTP id 6a1803df08f44-6fb030f541bso4979076d6.1
        for <linux-pm@vger.kernel.org>; Fri, 20 Jun 2025 09:55:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750438505; x=1751043305;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Y2I2QseFJ0gr5gYIqnnWqNCwwaaSonPDD1prW4PD/A4=;
        b=gbaeeR8MGbvnryl6/S/X2+SfmvrYB1HNMiKMZr07r/8pbrYv9taQba4dF2CaSCaJe4
         ub4RXC33K8q/lRy87DRwqh4i3UImgkKH18GuHcvqYVGT5Zu9m11CM2TviHY/8UuyuZfV
         MQTReAV8AD7LslXMiIV5PJW6UKnv0BBlsihlRzgAics0Xilj824iivWQ7rI+sPrL9WWg
         63kOOVq4L3zioS/ztJN0rUjbU3Ea5qPkjoJ9YH7jPHN7Bj+R7Tmu1mlP7qv9gvohyBkw
         iqILoFOViolT632db2HdrukY4ACzSu1xij7FSpEkHHOKHQz4Pu/5LYD32rseyeWpV5kX
         juVQ==
X-Forwarded-Encrypted: i=1; AJvYcCXgvWpolxNUZLI1VNfBzlhE/hyJyqNdYDQoThMOaPckFOEo3lb0naTCkP6JVTJrbakL4GfSkYV0Vw==@vger.kernel.org
X-Gm-Message-State: AOJu0YyrdslIfqg6K8tFoIiKU596PBv4rcKyQ+t1AGmH6WyiLkA5L4Xg
	hX7w0OWzAjU8yTMtYHD//tck5+9gcsRdxZzFBCd2ZWF0ZAjqTAx5A1l00Y4isT58cd3/PC8UyHK
	BZ+rlv0lCKillvN035nzjyaSEtuViOJUjd0tPxSejisFwv2ckU7Kxgwqwf9+Q9Q==
X-Gm-Gg: ASbGnctBq1ZmsWJO/jOPdqeg9/Svj7MXVIuRf+Zv9iN6ZZ9j7toFWB/QBTSGAMa17N8
	OECV51cwdu5K4Evcr2a5xfhvuZvnVGA0m5VRpWgdn2a27ZyM1Th76qpNmCEIa9uiujx0v96BSVb
	fAJ1focqu9eyT7Km1E95OigRmh3Oow4ZVU/ywIhFMULwHI0AFANbHdY2LWp7DtpDNC4dOCL+X2l
	yQCor5CCGMn7AaC55yPwo7XiUEgt7lTbNO4vrdXs73QQD1+AcUzBP6XYTW09WImVMoO9a91He7w
	SV5ZQ7pDfZMA+s8+UyuYJGndODxKEl7o6fiqhk0ed4BMips6LBpY3SWQM32AsF+DJOkvJiMhySp
	Twf8=
X-Received: by 2002:a05:620a:1a84:b0:7c0:c42a:707d with SMTP id af79cd13be357-7d3f993a910mr185106885a.15.1750438505165;
        Fri, 20 Jun 2025 09:55:05 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFzroywSyK0lLak+kmGhL7I4nUbTDl//l0+nE20iSxOE4K84JZ9jklmLuZwJGAH+b1r8H4Iyw==
X-Received: by 2002:a05:620a:1a84:b0:7c0:c42a:707d with SMTP id af79cd13be357-7d3f993a910mr185105185a.15.1750438504725;
        Fri, 20 Jun 2025 09:55:04 -0700 (PDT)
Received: from [192.168.143.225] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-60a1857c124sm1603889a12.36.2025.06.20.09.54.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 20 Jun 2025 09:55:01 -0700 (PDT)
Message-ID: <2864033f-5f1d-4026-9bed-6a79ca917701@oss.qualcomm.com>
Date: Fri, 20 Jun 2025 18:54:57 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 05/11] power: supply: qcom_smbx: allow disabling charging
To: Casey Connolly <casey.connolly@linaro.org>,
        Sebastian Reichel <sre@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Kees Cook <kees@kernel.org>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Sebastian Reichel <sebastian.reichel@collabora.com>,
        linux-hardening@vger.kernel.org
References: <20250619-smb2-smb5-support-v1-0-ac5dec51b6e1@linaro.org>
 <20250619-smb2-smb5-support-v1-5-ac5dec51b6e1@linaro.org>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20250619-smb2-smb5-support-v1-5-ac5dec51b6e1@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: yW3WYRe-RPZKlIBZbxXA5rZeeOEuXZ9P
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjIwMDExOSBTYWx0ZWRfX7GvJgG7cFBJ9
 gHBfo1Q/oOi7flCVq4WvBuDiAtPv5ju2WdCkUO45aeqelG49y73M+sJjuLbJPMhEURZr1nu52fB
 t74G6kC5/oTdx1Qc1vnT/sU5l1zlxCsrmdBLoDeyfmyrOnjbZs1vXMtH3c5+lTXY2sC1UobTU1F
 luGrZ1CGmUXvE+rQ/LO+QpL/fgHF9nz7vkIfk6WKANLcmVrLIPkW+qGnMcTII591jj6H/nfVEEl
 FtGLRLpECZJD6TEfYEMDixa5IG1NDjNb1x1DDBTJus84S5WWjcNU+L3FZ9QI2cHMw7e67dB8Zoh
 Y/yy3xnIkjU2AUUkAT6vdvCIJtPJYtMtvLbD/5KeU8jLjiodvqDpyfxvOUTjUjC1/JwCXu9o11r
 3Ftg4tQkIMU3rlnwmL75L9Slr1MwSlVg1klNLbX/mBOBJj07plsHt7qqtAB/3DnG1CY6aEKc
X-Proofpoint-ORIG-GUID: yW3WYRe-RPZKlIBZbxXA5rZeeOEuXZ9P
X-Authority-Analysis: v=2.4 cv=etffzppX c=1 sm=1 tr=0 ts=6855926a cx=c_pps
 a=UgVkIMxJMSkC9lv97toC5g==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=6IFa9wvqVegA:10 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8
 a=XZI00cIVyT1STSWTZ2QA:9 a=QEXdDO2ut3YA:10 a=1HOtulTD9v-eNWfpl4qZ:22
 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-20_07,2025-06-20_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 impostorscore=0 adultscore=0 spamscore=0 malwarescore=0
 priorityscore=1501 suspectscore=0 phishscore=0 mlxlogscore=861
 lowpriorityscore=0 bulkscore=0 mlxscore=0 classifier=spam authscore=0
 authtc=n/a authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505280000 definitions=main-2506200119

On 6/19/25 4:55 PM, Casey Connolly wrote:
> Hook up USBIN_CMD_IL so that writing "0" to the status register will
> disable charging, this is useful to let users limit charging
> automatically.
> 
> Signed-off-by: Casey Connolly <casey.connolly@linaro.org>
> ---

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Konrad

