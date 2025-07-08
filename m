Return-Path: <linux-pm+bounces-30389-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EF121AFD242
	for <lists+linux-pm@lfdr.de>; Tue,  8 Jul 2025 18:44:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 296801890D66
	for <lists+linux-pm@lfdr.de>; Tue,  8 Jul 2025 16:41:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABB292E54AF;
	Tue,  8 Jul 2025 16:41:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Wo5L3PDA"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F3D52DC34C
	for <linux-pm@vger.kernel.org>; Tue,  8 Jul 2025 16:41:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751992866; cv=none; b=Dpm+JMGuysLznXxPBPfKYJ9e5A9G8c4clVNqLWwE4iIqigBEhg5B8m+qJ/YQQ0IokxOZm3C9N5+9Bu5rAqn/zZyKrZpnPfNqyoCVe+5igcjkfwsNjyeMrbGDW6+Rh/KtkJefcsRW6dq0XjnP1WI+Rycy6QQfedxJiu0y1tyDFOk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751992866; c=relaxed/simple;
	bh=oUwfhuQJI3rCG3DAr+iSLjbJAl+uDXbsV+D/ZN31zks=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dOoCoC5E3YHLmTX8tXr+wM/KXMASgIXul7NtF7+5oxdsPaybFSJ768qJMY+kxvo2PUJXcDTkqhslmPoRrXmeeLy/YjFW7Kui8V3KdlXmGDo+p+pE/0lXkbwVRwlMz7CQePmcfwijXxlTYRdknLd9ePAH48LcLZn35/AFogHj86M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Wo5L3PDA; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 568AAS5n025441
	for <linux-pm@vger.kernel.org>; Tue, 8 Jul 2025 16:41:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	UKf7w5qtpfoZKrAvtc6t6RnK95VeeAC8USeqACfTOu4=; b=Wo5L3PDAPgTieNfr
	qjMi8imoAi591T9GRi3Tv2MnsSdFFDe8v2DII0Ca6WfNPfCZ/o56cKKyG1HEr/75
	Yk9TPiE+ZmVmMu3WVRyIiDxZjBk5HHYUEajN4YaFfTX58qGJ2iutnBCIEbKj7ykh
	qEAF5YJUadFBGvaveMYhQ2NkHNLaQQo0jFzkkcxJ4B4iBExzAm8t0gFCWsDpznEz
	h7ckJrIhP/W4EySvyNwuxOimlBlLgTTRdskzPGXJSXt/uOYdpYKkD4Ro8ki0tRWz
	0yX/JdwkSFJOlGx1B7Jx4btfJJwURtMiVLVdxw76Liz/R0kxCH+JTKIAU3WS+qvZ
	+Aaz5Q==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com [209.85.222.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 47pu0wfhx8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Tue, 08 Jul 2025 16:41:04 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-7cfb7ee97c5so27214985a.1
        for <linux-pm@vger.kernel.org>; Tue, 08 Jul 2025 09:41:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751992863; x=1752597663;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UKf7w5qtpfoZKrAvtc6t6RnK95VeeAC8USeqACfTOu4=;
        b=C06xTYHejEueAS2nYmQ5t6QgfFYA9fz0FlPkd3q5589Khy6Fz+dkc/cyfFuJBf9IFz
         3VF2C6a9nIx73PChanjrgVwyUwQNoZR/XIihBIBkxV1C348Mtbp5Vqp7NXv8jH4jh/E9
         73FQdk1YPBW5RzhJ8lToQxjleTb0Ylus6UCvv3ggnZp8KPinAMN2A5q52T84oeA9MtqN
         rUoF5mBkrK6MZ7O38uE1Z5Uzy7GqftvO7aM6PJT3R/bw3pmjkatqj3oxo1YKurIjBoiO
         BMfNJz8JfCiLncAgm6ARrE0mdt5IkFh7N0cu8i2o+PxT+M7gtkGI2gRBsZL5bGxXk87D
         3jHg==
X-Forwarded-Encrypted: i=1; AJvYcCWISUXysqZu5itQJv0/W6ERYf9adRPmZGs133ly9PVZuuO/hEiOnszQDnrddvSwybVbBm70fLjsdA==@vger.kernel.org
X-Gm-Message-State: AOJu0YxMSAAoDCLGB72o+2o0apcPmOwYmpDfJWni9yajMP9+JQ3Wl0Vv
	C17mTYOkHwGjT+7MEKLkPJGr5JtjYqfAJ/JKqrXW/0XFTAZQpAXwQ0F5BWyYWlpsRpnnsF00VX/
	ZmHYqsfVI779uT4vW0mQssJOA3S58/pU8O4fb7/g5UXoLkuOYYh8v3EBqhiIfZA==
X-Gm-Gg: ASbGncvopaIqNM6u+kDCrgzur+l7xEuW5py/y1hfoY7fnCIALTvRRRIAZ6ZNJ1vco+j
	RWDIw3exOk0nZJ9VuUbkALA0a4OJ+bHb9MAMtEkC36zh30scr3iTcipjI4d/vM36C2e/wOduK8b
	/vWnKt37hji+K6Lh5SUFnucy36fM9wgOh0KHSq/v3mKsSB3foXJt+7gqbCHRTZuotJjBH1ra2Ls
	zcyPrHKmJ3CkW3AxCMGh5b6ZJ765CAfzL+HZ0b6RMoIxIJEt2LluCBiDvOlhy1EahNWIOScFTRh
	4Vsy0qVRQYNoP4WjTgHlVSRrJY9yqXGTVlUTcAlnh/es2H4v0W03805scKUWBydaWn4ROreO2e8
	+mLk=
X-Received: by 2002:a05:620a:40ca:b0:7d3:cec3:3ff with SMTP id af79cd13be357-7d5dda100eamr831389185a.0.1751992862863;
        Tue, 08 Jul 2025 09:41:02 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGQxRkEb/Wae9gi4E7WPavVxS7JCL4cmOBv4z6rnMmST8IxGjfLZDNtY9CT/To3psedF6/+Nw==
X-Received: by 2002:a05:620a:40ca:b0:7d3:cec3:3ff with SMTP id af79cd13be357-7d5dda100eamr831387785a.0.1751992862462;
        Tue, 08 Jul 2025 09:41:02 -0700 (PDT)
Received: from [192.168.143.225] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-60fca6640absm7510130a12.12.2025.07.08.09.41.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 08 Jul 2025 09:41:01 -0700 (PDT)
Message-ID: <c8626ba1-33aa-4fe9-926c-704f0d7910d3@oss.qualcomm.com>
Date: Tue, 8 Jul 2025 18:41:00 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 03/28] interconnect: qcom: rpmh: make nodes a
 NULL_terminated array
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
        Georgi Djakov <djakov@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20250704-rework-icc-v2-0-875fac996ef5@oss.qualcomm.com>
 <20250704-rework-icc-v2-3-875fac996ef5@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20250704-rework-icc-v2-3-875fac996ef5@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: a3h3PVds9Ms8xTq9L-VaJaFabnKAqPcd
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzA4MDE0MSBTYWx0ZWRfXxBVh8UQIxEWp
 Pn9jlBROjT3ZqazgwcetSM8UITxymrmNqSjgjb4Ywz30TxgJ9EzuAbfqsR+UwM06Qn7QFGxJVtr
 4Nko7+23VccAmY8jkeKmcn4whxzt1ovrMpMVWgnyxS+h2+b+UQC4QLXrt8blO4xA+6zcdtkk1S4
 bReIWhcp20chc74oEaeUGybVawzwjl68Sd0czyxnDwl6bkkDazO8/vZpN+C47rgmxv333eULVsj
 JnO4wylsTmBsLapOVMQDRoQaWYVxUm9kY4D9bGjuzp1TQH1n/B0k25C+Yx5f/CCEQgX7ZN+aLv2
 MzseDUyTEfkwwp2WflsCyyO0gvo7TT1wQu5c+5Rh3uRYPFYflrc/d5oub0PRISpB5rFw+fRpMNh
 ggO8Aksi4g43b7IoeJbtl4BQYEI1tIU81bnsB0j0PrehpUPcYs5p75vj1tph80pkUsgf5MrH
X-Authority-Analysis: v=2.4 cv=Rd2QC0tv c=1 sm=1 tr=0 ts=686d4a20 cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=EUspDBNiAAAA:8 a=NIC3D40qKzNtBD7CQNsA:9
 a=QEXdDO2ut3YA:10 a=bTQJ7kPSJx9SKPbeHEYW:22
X-Proofpoint-GUID: a3h3PVds9Ms8xTq9L-VaJaFabnKAqPcd
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-08_04,2025-07-07_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 suspectscore=0 mlxscore=0 malwarescore=0 lowpriorityscore=0
 mlxlogscore=986 impostorscore=0 spamscore=0 phishscore=0 priorityscore=1501
 adultscore=0 clxscore=1015 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2507080141

On 7/4/25 6:35 PM, Dmitry Baryshkov wrote:
> Having the .num_nodes as a separate struct field can provoke errors as
> it is easy to omit it or to put an incorrect value into that field. Turn
> .nodes into a NULL-terminated array, removing a need for a separate
> .num_nodes field.
> 
> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
> ---

I'm not totally sure.. failing to NULL-terminate is as easy to overlook
as failing to add .num_nodes

At the end of the day, potayto/potato, even the memory footprint doesn't
change.. But if you insist, please make sure that the mass-update didn't
miss anything, so someone in 2 years doesn't decide that actually counting
the items is a better idea instead.

Konrad

