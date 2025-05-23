Return-Path: <linux-pm+bounces-27599-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EB294AC28FE
	for <lists+linux-pm@lfdr.de>; Fri, 23 May 2025 19:43:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 660181BA3317
	for <lists+linux-pm@lfdr.de>; Fri, 23 May 2025 17:43:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DD28298C1F;
	Fri, 23 May 2025 17:43:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="HEXjFRO9"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B366521C9E8
	for <linux-pm@vger.kernel.org>; Fri, 23 May 2025 17:43:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748022207; cv=none; b=J59qUn4W5KF25zHZYkwpj7tE/8CT7/RtjMEY6PM80TRAGSUuML6s5NxboGxmT7Oyno+bBYaRIYdu9F+/0D63iR0ED35bI46xF7hFxR5S1tR/9exdtsXaKohzTZ5Kptkaw0balRs/vHGzlNkg8m1D52ijCYaqi/eXQGpHiGWhttM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748022207; c=relaxed/simple;
	bh=9UF4qGLZiq0idzoWE1m8oF9RUy8Yh/CMuJaLEFmdnns=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=e32SsQOq2jtz7ka7q6ArY62g2HPuSnaQLXLlwFFCg/DdWEHnrE+8ud/yDz59A8i0JnHHIIHMWeuTiTenPTvcSeeICTawV2a+dxXuP/HE/MqDir+ow8bibmwSLgzkFjMMO4q1XsnmI6XzvyUrNRw+FU/fpjACpvSkNamrS/e7XZo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=HEXjFRO9; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54NFKPxL018127
	for <linux-pm@vger.kernel.org>; Fri, 23 May 2025 17:43:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	9UF4qGLZiq0idzoWE1m8oF9RUy8Yh/CMuJaLEFmdnns=; b=HEXjFRO9jPvDtuJa
	FXlRQn2QGZV8jk7OyFyRbi13daVQlElNsVO8Tiz3zLVvkJDRp/FMCGiKbzkoCOJX
	Y+B9OjXs7r5LESjz6iAmNRUuJDxmdg4IXDgTVTAZqZRw6+tlgd3zuDUrCBksiDpF
	FDWBDcRj+1zLR+4/0C/9k8yEhV+jSeTnhXTmccCqOGDTRZLrPstDMuVxwB6RS1PD
	qPRadv06oc1Tl71NPPHISv/ARMMKm3WGW8lTO3x8Ncd/Tc3qeKXdGUyocTlYJ/XG
	FCXYHE/1+m2p2Y8UpgO/yTmLzeVS0y+nbP7aapa2+vo6oLrM1wqUUohSLkMHaHR3
	DE6W1g==
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com [209.85.216.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 46rwfban68-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Fri, 23 May 2025 17:43:24 +0000 (GMT)
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-3108d4ea2edso139225a91.0
        for <linux-pm@vger.kernel.org>; Fri, 23 May 2025 10:43:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748022203; x=1748627003;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9UF4qGLZiq0idzoWE1m8oF9RUy8Yh/CMuJaLEFmdnns=;
        b=Xpicp7OwjEZkzf/wy+lff3GvIrR5lW8FKuL+hFiOuhhX8k3JDCE7i6h+JEELQlHZSO
         L530Xv6nJVbHvF9vuRk8O5LiXoFYfnysH7/V7F4U5UfZKdA3JcZ84+ynwwU7HhI1bknQ
         zwg/4r/LRVin5hCvR/0cPnCxkejYVP9vnm50Rohy6VPzErTRN+WpZO3MK/G6n5DzEIv2
         TP2Za/CQhUlj8stcjpBFWbroV5sx6KEL54vSjno4gpwpDBjaOWuShjcWzEdyVnhoa3Ir
         IVFxFSmdzTO7NNGG/XsWfM1gjUX7HByXYk5KsztRldVKm+zbtZY6g2g19toCDYcl2ToN
         GqEw==
X-Forwarded-Encrypted: i=1; AJvYcCXXbxdaxbWblgu5bq5NWMFPGhT8PbzuZqh6gyuXyfm9/jZ03xEtU2G1+4LgjwzSB9AO4ERNZq8q/A==@vger.kernel.org
X-Gm-Message-State: AOJu0Yx8o2dnpgaqOkeWLeVINIrfsJ/doqvI7jMKE+pK6rAgRJmtGx4G
	2GeP0Th1HCRZ/t5hZf/jQVFDUgZOqpEX43+wWPMMlh3AALzGifHCa/57yauBDsplaeg2PkfdF/t
	vKw3o1d0DtTpK34brzQx3c10cEx+mpKlteaYZXRAWuwIlVzuuWaWmhS8IIWHgZw==
X-Gm-Gg: ASbGnctDuaEsrjZGCJXUbBfRcP9Onwb51O0Ex+XbB4ZmLCDVq4o4V+aAkZx1fLfblzZ
	Jj//Ll5t5u9tONTicpOCJVMf7RAA+MFSh63X05lJpAaLRQHaziCpFbDJC4m0J2JjLBCV1GVArJE
	GMEstKT+zd2sFBLnxoZ/x/+GzXBRR80XXf2SjhDrGJoJTB1tNprUKJ9cUwnzFWpHODQ/2aSg8JJ
	kE6FIGIGqFjfA4kcKrCuXkEu0S+4JQBzwRgouKSuACm4jJgkxI156UCWY/R9FHQZ45DQAkzEKy4
	iO2fgcokhGFPG6NbakGxUgvW2x1grrTD3H+3qp2CXsxrn3Q1vR6/txXo9AzdkA==
X-Received: by 2002:a17:90b:1d88:b0:30e:9349:2d8e with SMTP id 98e67ed59e1d1-3110b474800mr381219a91.7.1748022203005;
        Fri, 23 May 2025 10:43:23 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFh6FmZvN2wDt+QwdBOJDJe3T9GYQ0xi8SDzcPBpN/rTp+Xf3P8d/oUww+OUE5d5vC8LyamXg==
X-Received: by 2002:a17:90b:1d88:b0:30e:9349:2d8e with SMTP id 98e67ed59e1d1-3110b474800mr381184a91.7.1748022202589;
        Fri, 23 May 2025 10:43:22 -0700 (PDT)
Received: from [10.71.81.158] (i-global254.qualcomm.com. [199.106.103.254])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3110444d54asm356896a91.30.2025.05.23.10.43.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 23 May 2025 10:43:21 -0700 (PDT)
Message-ID: <36608326-52c6-4d82-a51a-b802920312b0@oss.qualcomm.com>
Date: Fri, 23 May 2025 10:43:20 -0700
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 2/2] selftests: Add perf_qos selftests
To: Daniel Lezcano <daniel.lezcano@linaro.org>, rafael@kernel.org
Cc: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        ulf.hansson@linaro.org, arnd@linaro.org, saravanak@google.com,
        deepti.jaggi@oss.qualcomm.com, prasad.sodagudi@oss.qualcomm.com
References: <20250505161928.475030-1-daniel.lezcano@linaro.org>
 <20250505161928.475030-2-daniel.lezcano@linaro.org>
Content-Language: en-US
From: Eric Smith <eric.smith@oss.qualcomm.com>
In-Reply-To: <20250505161928.475030-2-daniel.lezcano@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: It3BvBG17s82r_oN3TEpZc72CtHoA-jB
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTIzMDE2MSBTYWx0ZWRfX8z/qCxpJ5028
 oCd5PMglyR74m+Q3AAG9aJS+O0ZLIjcWrtpXXLFIv2BY8S7feHMpRBPHowGiqRlUndbFtVG0D4s
 mgW8aGcyHtk0l1616VfEzlmhouQGK1Uvi+k6xPOZaiQM2Zp30y/0SVQT+RaZasQsN2AuHyyx0Yh
 rZCtPVrHy9FrEL4IOMj1Nf04fWyVdOmCW0i9akddn4gyM9HtSqBBcnrrVDwxNuS2zzK4LrV8AbE
 +yNOOj5Q1mpIXZTM16rlVs3vtdMBSpfKODPerhcuyndtT8Hoh2WZbJC+1FG7ZEkQInS7Y9CIppv
 NSVOL75vP+q3tWsD81dXRK4bDLvPQ+TJnubMZ6stfhMKoO46tJ+BUiuU6WVJhPHs+rURCSnqPCi
 QcNHXwVH414Wj3Ke+xzPxb/TcIRuC+q/B7v1rbCneoHIAYSWAUr36apfOQ+QX/TBG563FbDo
X-Proofpoint-GUID: It3BvBG17s82r_oN3TEpZc72CtHoA-jB
X-Authority-Analysis: v=2.4 cv=dLCmmPZb c=1 sm=1 tr=0 ts=6830b3bc cx=c_pps
 a=vVfyC5vLCtgYJKYeQD43oA==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17
 a=IkcTkHD0fZMA:10 a=dt9VzEwgFbYA:10 a=ySd55krBe5uuJlf9SWAA:9
 a=QEXdDO2ut3YA:10 a=rl5im9kqc5Lf4LNbBjHf:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-23_06,2025-05-22_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxscore=0 clxscore=1011 adultscore=0 bulkscore=0 phishscore=0 suspectscore=0
 impostorscore=0 malwarescore=0 lowpriorityscore=0 mlxlogscore=961 spamscore=0
 priorityscore=1501 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505160000
 definitions=main-2505230161

Hi Daniel,

On 5/5/2025 9:19 AM, Daniel Lezcano wrote:

> This patch provides somes tests which depend on a kernel module
> creating a dummy performance QoS device. More tests will be added
> later.

Thanks, I did not see a test where the perf_qos_is_allowed API is used.
In future patches, can you add a test using the perf_qos_is_allowed API?

Best regards,
Eric


