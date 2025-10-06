Return-Path: <linux-pm+bounces-35720-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D071BBD6F4
	for <lists+linux-pm@lfdr.de>; Mon, 06 Oct 2025 11:25:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 997E04E9BAE
	for <lists+linux-pm@lfdr.de>; Mon,  6 Oct 2025 09:25:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21D99266EE7;
	Mon,  6 Oct 2025 09:25:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="OP8VYXp1"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B390265CA8
	for <linux-pm@vger.kernel.org>; Mon,  6 Oct 2025 09:25:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759742729; cv=none; b=itomBHsRPQ5k7UHvtZd9WgiuUnPPV9MHeIdx7mHI4N1vNr9AqrGMgwFcU4uacO4qtigBHUa4u43/4ctHeVCH56YsL5IRJweDhYOOKUmBSxhZSB912LgLf2xUUpmWq1dpnmS/7NOPHJEPodZCcsXIClgR87cGJncRemYwtekwoFk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759742729; c=relaxed/simple;
	bh=Edw6e0og8KO+pLnhJlzP7tQrwfS/fTioEQtVFejS+5Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=t6EjjWMM4IpVyNq3+zTHzV+TmynD+HzPlhTXuYL1u66BEcTDowMa6cQhPonu5vmvJagFrDItXtBrNDLbSv35QcPdNGxAPldDmBkWD1dQEylCJ4/uO27I2eXqpkNjts3BVPRTX2YooypZzGvgK0ipGydUSAh1JOk1vdd5Rr8oaNE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=OP8VYXp1; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5960d3xu004323
	for <linux-pm@vger.kernel.org>; Mon, 6 Oct 2025 09:25:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	bPnKDCAknnlQ5K1Y7MBqxGeVWc0/KKrFnvmpGWEd/iE=; b=OP8VYXp1NPHQZ1DC
	PZwp1qm8s20FDro5w/TnwQ6vniSCPH1P1DeqqkSveXDbexOPAHUnEFxByrU1F+qL
	VFsInYZ4ZXn9ARWgs9bCB4/o9A78k9jNzDliUyoAhBl+4wVusNHD/R4bNjbqmp2O
	Z8jsHX/SvhbfBX3hZkJ+zndpwEfCFhrVi7ldLJz7RgQRqOYHtymYe8fja64allX2
	0WXsZO1S9HRy1RvJ0HTqfWLDdaOmK3IVchBYc75kSW0CS6SN3sVzauuNrilh1lC+
	C9w3hwv945uGMvLrJqPXXAIbUFHz1cZiFfG4kSzdkbeES1UNycF+aB6Z/slejDo3
	dAQNPg==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com [209.85.222.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49jtwgkh9q-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Mon, 06 Oct 2025 09:25:26 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-87d8621e4b5so9394485a.1
        for <linux-pm@vger.kernel.org>; Mon, 06 Oct 2025 02:25:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759742725; x=1760347525;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=bPnKDCAknnlQ5K1Y7MBqxGeVWc0/KKrFnvmpGWEd/iE=;
        b=e/5WHRQdVuJzKqkhqhkjQpogJPMasSSRDqqquUoQlXKpnxpZxim95Z1VPGLwjW9uLZ
         5iezdg++yTNMunoHsjI1uxHoD9Bhs13BSIIRugSI7W5ptrjK5e8WkLGTtYSgAPd1QT+l
         TZVPbouhmW+bnZSH9fC48FxwVPKF9dVk1/73Zr9OqWBL16YUY+iiYdfgqniHzZnXodqi
         3bDKLvTi/U2HkKYPhPING7GOgKmbkAyy57g3hS/fg8r2ZVfoRgF7eGFX0Z/oDTMex1C+
         SLtQ/kjrUc1Ok22n3naRRpgoC12RTMiMrMJKRF4pLBy2/MH0v6QVyv1MocgFOvKSI4Ep
         C8fw==
X-Forwarded-Encrypted: i=1; AJvYcCV58CzKF2owQ/hSa7KRLjyyxfFgdpU14EAUb9gLC69P1DF0bwEC3zTDksbpqtVFShmWLUcumejdtA==@vger.kernel.org
X-Gm-Message-State: AOJu0YzLV1s4nm8Vv60OXkdfTwFplvvPctelm1a+R06vbAsrLW6agdCm
	89m3NDGErplHFXHBKdW8BnMfqhL09FvcPnlDHOYrTSdauvg2tUTgjvyQ5wZPEZjeTgpFnm71AqP
	9Bfn2Ax4KK00TqI32zETNlJWxFVGNwWPpaDP7UgySpWwX10DPxRM0g0n7DUK0+Q==
X-Gm-Gg: ASbGnctafqBN7VTtKgZCwmYa2E+jRyM++u3SeBHRtfVOuBfLqIx2NVex035Rv3N3nc3
	YvBQcpQG9gnjkBwGpVCqHMbcB2asxPlkv4Z0DEv2fsg/gbXpYam7sTQWY8RvXVHyu+QQBs1Nl38
	IbOKz4YrzJWe9t8Ryh4J/toItPIq5Qb8rR9SzCYSE6sk0eNCqKKY73b0GTr9k4Gx3exS/McfPAv
	x9NwmpDq4mA0Er9kVKRj3ZH9TobA6lqvCwO2bHpdKmwrbnEe+WKAobqwyLIFLp2E2F6UaM4Cc7w
	XhlEEJB/KyO6OIIXaBotlpbO7PskrbDOb/ly714ephLvzR3RlwIXIQwvMqG+EVxEANv2TA+aZNk
	Diu4x0c8Ls+bkOsSD+pQDMtp6ZB8=
X-Received: by 2002:a05:620a:2808:b0:878:7b3e:7bbf with SMTP id af79cd13be357-87a35ce66c1mr1023296785a.3.1759742725327;
        Mon, 06 Oct 2025 02:25:25 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFvRfoZ03L6zTgPa9LKXYBO9blV6+FdfAe7dQyAmQoPVuIdAmyD2DdczNNxPH7bp8ruibwQLA==
X-Received: by 2002:a05:620a:2808:b0:878:7b3e:7bbf with SMTP id af79cd13be357-87a35ce66c1mr1023293885a.3.1759742724700;
        Mon, 06 Oct 2025 02:25:24 -0700 (PDT)
Received: from [192.168.149.223] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b486970b422sm1113154466b.54.2025.10.06.02.25.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 06 Oct 2025 02:25:24 -0700 (PDT)
Message-ID: <fde00935-6475-470d-bfde-4341d15c8441@oss.qualcomm.com>
Date: Mon, 6 Oct 2025 11:25:21 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] interconnect: qcom: msm8996: add missing link to
 SLAVE_USB_HS
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
        Georgi Djakov <djakov@kernel.org>,
        Yassine Oudjana
 <y.oudjana@protonmail.com>,
        Dmitry Baryshkov <lumag@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
References: <20251002-fix-msm8996-icc-v1-0-a36a05d1f869@oss.qualcomm.com>
 <20251002-fix-msm8996-icc-v1-1-a36a05d1f869@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20251002-fix-msm8996-icc-v1-1-a36a05d1f869@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDA0MDAxOSBTYWx0ZWRfX2+9rASUMUrmc
 f5NKAriH3uRHAmzddxHUaACex4xQmZoHo3JXhdsFSEvWHgxvlA3vTlAHGXEGeR4Cl0M6PaTNxoI
 SV6tm3sJ/3gzw033ytPdRDTyP5wwqogcBsUXiOt1eP2BVM9YBhAVduwS3tuIXDAe0srEOoPLFpL
 wWelmtU2r7UNoD+87IEfO0k2q5zpK8cDLhlAQfUhbH5Oc/GAsgOPW4bsiSOTlzF2FvUpm0fQeDs
 YysyWkfaKR8CR5VeyGUDTngtfYfvYsOY6Q5z6X2gfRnNVJAyr8vX1ICaAgmI+B0RwXeOO9DLMh+
 7vDqqxmrABOJaj+DeNa1CwEDeAxBnVCUEVojxF7vo1abaAxVL2okTFEtuf/wuK1YVJfrj34VNXn
 v84rtgyypLxMksXvKi6ifkAaBr70Hg==
X-Authority-Analysis: v=2.4 cv=B6O0EetM c=1 sm=1 tr=0 ts=68e38b06 cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=EUspDBNiAAAA:8 a=WPDsOxgxYxYm0iCLz50A:9
 a=QEXdDO2ut3YA:10 a=IoWCM6iH3mJn3m4BftBB:22
X-Proofpoint-GUID: aYQCMuhIqPlRv_bUkl3Ygf2n5C9xxLG-
X-Proofpoint-ORIG-GUID: aYQCMuhIqPlRv_bUkl3Ygf2n5C9xxLG-
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-06_03,2025-10-02_03,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 priorityscore=1501 lowpriorityscore=0 adultscore=0
 impostorscore=0 spamscore=0 bulkscore=0 phishscore=0 malwarescore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2509150000
 definitions=main-2510040019

On 10/2/25 10:53 AM, Dmitry Baryshkov wrote:
> From the initial submission the interconnect driver missed the link from
> SNOC_PNOC to the USB 2 configuration space. Add missing link in order to
> let the platform configure and utilize this path.
> 
> Fixes: 7add937f5222 ("interconnect: qcom: Add MSM8996 interconnect provider driver")
> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
> ---

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Konrad


