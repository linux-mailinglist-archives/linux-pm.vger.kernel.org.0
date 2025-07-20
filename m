Return-Path: <linux-pm+bounces-31111-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EBF4BB0B634
	for <lists+linux-pm@lfdr.de>; Sun, 20 Jul 2025 15:15:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2E3673BE263
	for <lists+linux-pm@lfdr.de>; Sun, 20 Jul 2025 13:14:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CEF2213E6D;
	Sun, 20 Jul 2025 13:15:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="IMaWHWnB"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43507211499
	for <linux-pm@vger.kernel.org>; Sun, 20 Jul 2025 13:15:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753017314; cv=none; b=pRiMd0RhUDPlNAOBbu+OHzZmkBHcrqjFVeMpdNaJJfRta+cXsL4+X7Iayfv52/FNSC3M8y5t4jfxMuN9KqZld6LU2GCH6CHrZWoxoiD9hb0pyIh9fRUGLDJ/xW4+mFwKa1EtVY6IXB2zsphwjYs/duZe+dIbzRdqFXLc0+bepz8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753017314; c=relaxed/simple;
	bh=a+/9yQt11K3VithUaPvA5gO2rBEnkjNtJ7gkK8eJqIo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tyRq5Xr9GZ+r4MMdoAR32fKRZO6FyHarVCF9p9zMEHSV0b+uuqDgkPMVIQRaN9ro+b0mnYpsq4BBqHy9a0FWaKp5Ry09NNxyXqpXA5rGWu40GsMtByv1Hwpl87SlvqwybuvFYl8TZNviEcgutlPdlzWFyL/sh79YQw5544mCF2Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=IMaWHWnB; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56KAVn7P016977
	for <linux-pm@vger.kernel.org>; Sun, 20 Jul 2025 13:15:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	a+/9yQt11K3VithUaPvA5gO2rBEnkjNtJ7gkK8eJqIo=; b=IMaWHWnBCHMw9zSG
	jGCyqjPx0M+qhwMzCf1ACrW7t6ln3YmGSNhkpnA5aI6KPJK6QNpRU7ksWq+nabna
	cT1vUXXHhFqjyIEpyAfLruMADmFlAMjPE20xVIxuEQdlV+Y+EYBLnhxtvjJZksph
	0qhN+Zqq71W+nu8RXhRourKtYckgH29VsHnoFRFWPONKF7X9smcuQrIeppj+kS+G
	DTiKpMcRtoKGscoCYXxW+SlCfux9k1SNAt49kpMasOByQMju2Y4VGXBdt+LT905K
	avsuFDNLry6Evac5qIgK9svtcwHZvKtWS1f9vMsY/38LZQhN0de8bZ+ndP3GSwgj
	1fgvMg==
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com [209.85.216.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48044fa97s-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Sun, 20 Jul 2025 13:15:12 +0000 (GMT)
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-311ef4fb5eeso3564607a91.1
        for <linux-pm@vger.kernel.org>; Sun, 20 Jul 2025 06:15:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753017311; x=1753622111;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=a+/9yQt11K3VithUaPvA5gO2rBEnkjNtJ7gkK8eJqIo=;
        b=hW1NgKff27EwhLBbnDopTPzRHcx12OxB4dJuKR6HCwmktLtMokQePSBkczdG6nMpnf
         IC8QHXDnBlJze2VxxDxVm6I/nn0rXOz+FgX0Uy/+Y9swXecv6zwPjZ3WlSE3aWXXBtH/
         jAPzY83QaIvdVxnP5TJwj5sRXFxiTEZBe0EXdsYrjjF1ydciMymC5g43GeUAdqhbhmYv
         uUNlcicO5nCKqo3sYie7f00PGALbXIxePNwialch4n/KX1t4pd7BXEvTW2zg1IcL+4Jk
         XXoQJimq+E+aY5V+XIG+0uLs8/Pbs/XaKwuWhD9TCY/8+vs3UvtePWX/uGe/glPgF/5z
         f45w==
X-Forwarded-Encrypted: i=1; AJvYcCUUSXH8XHMNCHClrHZRp7DsPuN8Xx4dH7v3bD9sw45mgMPk0X2iyQcFoeCp2jHmKIVghTdL98QPlQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YxEi5XU0Umw2qSeyGzo6+aw7SO/itfA4o8n/N8LO9Ee/wcXTyBM
	C8GX6dXIn397VeIsG3qmC2LL8NbjOrMbMKARINE/Z9b5q+mmf1G5f9Y1uqPoHNP6Q/VdoN01VO/
	lLezkHoTHvEqXwVvkS2JIgcFpkqjOSUyWktifgUHMlMbW1V6BshlC+b6dLtMBxw==
X-Gm-Gg: ASbGncuiBDktj6+LCD7e+UP+VYjFK+p/9SWobkKLIxEOFObc4J8tsSpyhaygZuhpwAg
	Z6k0eAK4jt1GUW1z3fZxEV0bhupS3yi8NPgId3PtnDd3fbF06olE4nzYG4X+pAOyGEb1W5joQgT
	de8yj9UJPUe17MbIHpFtJPckgJ2UCs2H8Z4Y+Cf1Ql4hFGWIqyRrhxywEnoXr0o4FAhe1OrSQiI
	dbsi9o8Rz0TU70MXcdmLJd9Hy54wY7s8ZQchwPJuCuXO5LRV3rFXwln9WIwAfwsPPFyJX4AmH5Z
	3PRMcSRqbh2FTHXha2pkyZ5DAZ55Xx3nQB5YWBW+EEzyj2Cw/mvb+DbVCcemCRPgVYQ54u5Y/Hf
	xHAoO2Q==
X-Received: by 2002:a17:90b:3f84:b0:2ff:4a8d:74f9 with SMTP id 98e67ed59e1d1-31caeb94318mr19574366a91.10.1753017311150;
        Sun, 20 Jul 2025 06:15:11 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGAUVIdg3VfO/chezPNcdAQfGrPXF/HeTMrNxiX6naKgNf1iAKiYVgWsV5q5SnS7nUk8OkSQQ==
X-Received: by 2002:a17:90b:3f84:b0:2ff:4a8d:74f9 with SMTP id 98e67ed59e1d1-31caeb94318mr19574324a91.10.1753017310705;
        Sun, 20 Jul 2025 06:15:10 -0700 (PDT)
Received: from [192.168.0.168] ([49.43.231.217])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-31cc0be8707sm3942525a91.1.2025.07.20.06.15.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 20 Jul 2025 06:15:10 -0700 (PDT)
Message-ID: <a4369d76-df44-4281-a2a0-cb6d32197302@oss.qualcomm.com>
Date: Sun, 20 Jul 2025 18:45:04 +0530
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V2 2/3] arm64: dts: qcom: qcs8300: Add EPSS l3
 interconnect provider node
To: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
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
 <b5a1314e-6733-41e3-9258-c3a88b2c90e7@oss.qualcomm.com>
Content-Language: en-US
From: Raviteja Laggyshetty <raviteja.laggyshetty@oss.qualcomm.com>
In-Reply-To: <b5a1314e-6733-41e3-9258-c3a88b2c90e7@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: Y0l3-95IPwkXX6_40Tel_wWuzYNZqjS0
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzIwMDEyNyBTYWx0ZWRfX4jWiBmVjmQa6
 cKPieGVu8aLbmtpjuhhIug/tqamO4ix2p8hYAfQhbkbhTcP/kemjRsjS4NtaS7Bj75Sr/7AZRCz
 CMPBdT3+zpU+Fm2jKV22LpBce1CbxJrwMA2+UPvJ/gfLSvqsH5MeX3dlUR8vddj39iAl0qZnYlT
 rP3Ut0O9IpXq+g30vyNASzXnM/A386Ny8YdaGgvQBHbaMe2zRGX9xtdUXa7+9Is21rjt38akySY
 PDaz7YvKEtA5TBCl0rLlriFlzKNM+y47I1TJmNfcm8LqcvAYYGBbgFGaAMfhjkTs/y/ZTj9ngEa
 ENe6azCZcHcnkzfaNwn1oPVZCRT0/6V849xE2v/8XMvKjEGXAg+hMZ+BdUi+yr4U8e1zFAAMHtd
 XUaOaCrFB+2PqDgzFKjQLkdmy3Ky9SDEQ96Efp5qqG4lSrYlW94bgIt9isdQKoj6OZAuwf8f
X-Proofpoint-GUID: Y0l3-95IPwkXX6_40Tel_wWuzYNZqjS0
X-Authority-Analysis: v=2.4 cv=YtcPR5YX c=1 sm=1 tr=0 ts=687cebe0 cx=c_pps
 a=RP+M6JBNLl+fLTcSJhASfg==:117 a=zhpjAwSWsGC/MCksz6s7dw==:17
 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=EUspDBNiAAAA:8 a=69bba5Txv9aQVdJV0a8A:9
 a=QEXdDO2ut3YA:10 a=iS9zxrgQBfv6-_F4QbHw:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-20_01,2025-07-17_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxscore=0 priorityscore=1501 malwarescore=0 lowpriorityscore=0
 impostorscore=0 mlxlogscore=999 suspectscore=0 clxscore=1015 spamscore=0
 phishscore=0 adultscore=0 bulkscore=0 classifier=spam authscore=0 authtc=n/a
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505280000 definitions=main-2507200127


On 7/18/2025 2:36 AM, Konrad Dybcio wrote:
> On 7/11/25 12:25 PM, Raviteja Laggyshetty wrote:
>> Add Epoch Subsystem (EPSS) L3 interconnect provider node for QCS8300 SoC.
>> As QCS8300 and SA8775P SoCs have same EPSS hardware, added SA8775P
>> compatible as fallback for QCS8300 EPSS device node.
>>
>> Signed-off-by: Raviteja Laggyshetty <raviteja.laggyshetty@oss.qualcomm.com>
>> ---
> Squash patches 2 & 3 together (because otherwise you'll still be hitting
> the issue I described the last time)
> With that (modulo me trusting the numbers you put into the OPP table):
>
> Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
>
> Konrad
Sure, will merge them as single patch. Thanks!

