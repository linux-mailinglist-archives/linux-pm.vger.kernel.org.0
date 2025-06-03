Return-Path: <linux-pm+bounces-28007-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 887E0ACC4AF
	for <lists+linux-pm@lfdr.de>; Tue,  3 Jun 2025 12:52:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 412D316B168
	for <lists+linux-pm@lfdr.de>; Tue,  3 Jun 2025 10:52:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D209F1531E3;
	Tue,  3 Jun 2025 10:52:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="WaB5EMNC"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D7A918FDBE
	for <linux-pm@vger.kernel.org>; Tue,  3 Jun 2025 10:52:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748947922; cv=none; b=opMnWaTWmkAvzjexAyobzq3kPHuE1WcSa0LXXcsJfchZntPSrQb7RVkM0lK+lgRX4WLrfqMFiadokivCrOfZDtNih45XGIyzZVZGsVSOtawFVX6WRwGuslMLx3R8nyWn9ya2Z5gvkabJgkh3jsjaKKzX3v/MDqagBxbvUnCWf9A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748947922; c=relaxed/simple;
	bh=xksPMyRBHmUawJmvrqG72dG1bQL/nqL7/zl7hnCq6mE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=O09oUh0YYzgBdkFjuHBDwVIRMbYB9iajy7CZL8cAK0ub7KBOFee4N7I3clKH4d7wG4XcEU8A1nM9t7Y24qiwlI8OHA/paZwhCXu7dXA9sQqnnDqC3uBbxlJlmaW2wR70jsQl8ApJ3UiFq/AYh2v/xBzTaSzBms5Rd8wdnFJ1hug=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=WaB5EMNC; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5539JGkB028357
	for <linux-pm@vger.kernel.org>; Tue, 3 Jun 2025 10:52:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=gG6LcmYQ46WfznvSwyEBH55u
	Vk21hBJH1RbGwGrUNAc=; b=WaB5EMNC6oRdUMCoP7WZm2YeOQ/AFgfgY5GTWEiU
	1HEBNjw2exJ7dmFwO3Jna7RhzSVVK39cWNeSw5RT09LTIapclaN+Lz/dKfWdJPMR
	HG4ODwFfCb42HbLbx9T0n2BuyveEq5PXhNAkO3pip5m0a96tfEouC8oaZt/+MnbE
	ZWo872rV2Pnw7IDciBzN81TDR2Pd4MRAIjSafSz524LaOF8KyZZ8IsEQBHmjPFWV
	wDMSt5ZS5DJfhtcNOcRF5GkVpLgsoUc31UQq5tP4gWODTV1bmkJMINsvs4dBXSyv
	WIJaUvFVjnabVsTbvPR030PIh3mQm4H/mazl9ItsAlt3yw==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com [209.85.222.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 471g8tta4w-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Tue, 03 Jun 2025 10:52:00 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-7d09ed509aaso798160085a.3
        for <linux-pm@vger.kernel.org>; Tue, 03 Jun 2025 03:52:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748947919; x=1749552719;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gG6LcmYQ46WfznvSwyEBH55uVk21hBJH1RbGwGrUNAc=;
        b=Dq5w0Kix2BhZ81qrRnNt/p0rSu6CyindXkeQY7TG9hRh9PACeRrwYw5+fVm/XLUWyB
         fpPzbDA6r1HVsgtos8jtT0nm5JdoS4qEDcIFxVXEfOtHi1OtRoPWBE35MfC67s0jz6YN
         6Zc4YW1wF+sMHVBZwcHym2m02gN+Mv1xxRLArCMKJkNeRFr7CSu0Ierjm0c6xgKYbF/A
         O76zYAqVfBd56mRDN3JSfvXluiRzeECiDttbbSLcsn/p0Hnvg1TykzzqIZFqj1+TCrnF
         Q/N/wMDAmdEPBD25DbvWhMLKg6w0AS0H/EW/5ap3zx2UxzCWkQtgbdEAoB4VYfAcoe+Z
         hVTw==
X-Forwarded-Encrypted: i=1; AJvYcCXn9ZO1KxhOtoVAWTUkac8pzNlS26vQH/MUqgRRurKsvWerrAhpMQPDq4kPcbrDQqa2hylU/AyZsw==@vger.kernel.org
X-Gm-Message-State: AOJu0YxEM8q0OukFUeVMi1IN7UoeHmFP19cTtVnqkiEHVaThrcAYm+gj
	2JiqezftXW0Q8G/FIs4zxLwfesSoOLGyRG8Y+TT/JDLS+zL5PNBjTXxAunSRe4RIEEBHpaipmwl
	eWRE5QrGwPsT35TOP6S4IFb87jZ744sxXHAkou0McUn/gb87NidoskCloBoeQpg==
X-Gm-Gg: ASbGnct1xELgF1ol0SWk2veZJA//N9tg2ldfhfHIttAnL+FdgLqUIKF2lGRsy0lmJsi
	FdpLYoESOizfn+F89ZO3jsnnPFj3x/KXyYZuXCAZiGHVE9v4BjmSYAbjw77CynfaYavbVQArTe5
	N3jTRRYFvFqb4b9YSNQmjHeqexoXDECJrCRKMiV5NGNQBgSuSBjuBhvDJXYKLHyvp+eQDmKXicN
	yfkT5/q9y6SjtL4PGd65cjxtuD/OzR69PS9lHief8NVSKhSgCR36SMJvqmSGFy0sG5NNeKYPRE3
	fwAIVqKDdOXHnJw7wloOVqIJtIUnTNTfu8rM6BMUBZ3+XyP7xP/O/Pp0GdxY6CZP417H26p8Vno
	=
X-Received: by 2002:a05:620a:190c:b0:7c7:9a85:d395 with SMTP id af79cd13be357-7d0a201cae3mr2458425785a.44.1748947919261;
        Tue, 03 Jun 2025 03:51:59 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE2GiN9U2uANhBh2sl7jgw3VrcRzOZN+8sBe5jX67so9Kh/4ZlV1XnhUls63lXZyPIojeacfg==
X-Received: by 2002:a05:620a:190c:b0:7c7:9a85:d395 with SMTP id af79cd13be357-7d0a201cae3mr2458422285a.44.1748947918924;
        Tue, 03 Jun 2025 03:51:58 -0700 (PDT)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00--7a1.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::7a1])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-32a85b35cb6sm17578341fa.43.2025.06.03.03.51.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Jun 2025 03:51:57 -0700 (PDT)
Date: Tue, 3 Jun 2025 13:51:56 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Anjelique Melendez <anjelique.melendez@oss.qualcomm.com>
Cc: amitk@kernel.org, thara.gopinath@gmail.com, rafael@kernel.org,
        daniel.lezcano@linaro.org, rui.zhang@intel.com, lukasz.luba@arm.com,
        david.collins@oss.qualcomm.com, srinivas.kandagatla@linaro.org,
        stefan.schmidt@linaro.org, quic_tsoni@quicinc.com,
        linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 5/5] thermal: qcom-spmi-temp-alarm: add support for
 LITE PMIC peripherals
Message-ID: <wsvdkte56d2avhhnte2r4udxpdaluz2jegwajhlik72ajk3nw3@l7daoy2lqvd2>
References: <20250528235026.4171109-1-anjelique.melendez@oss.qualcomm.com>
 <20250528235026.4171109-6-anjelique.melendez@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250528235026.4171109-6-anjelique.melendez@oss.qualcomm.com>
X-Proofpoint-GUID: _VzTySBFvDLRxHo2HnNLBAc0ZrRFtccW
X-Authority-Analysis: v=2.4 cv=Qspe3Uyd c=1 sm=1 tr=0 ts=683ed3d0 cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=6IFa9wvqVegA:10 a=EUspDBNiAAAA:8 a=C_YEPuUXS4kB9x-TF1IA:9 a=CjuIK1q_8ugA:10
 a=IoWCM6iH3mJn3m4BftBB:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjAzMDA5NSBTYWx0ZWRfX5x91m+ULWyPL
 MPseMeRRQyL435ZURMthYBr/tIPMnIrKK3e/ZoBU7UyrSehJfnzKAuH5x9DpPUN7Oi/U2jIAjgB
 /iTYxAL9QWnl41Q5FM0/H2YMV5dRpTiSS2PYLeFWb2qRzdfKotGomDCFZwrdV2/47S1MyEEfRq3
 lX0FwlYex6UqyU/LzCiqjDmrJRG3U0Tu9iespBpBBW2yjFU7xr8rNG0vjaIuFn9CQUTVQa+ObnW
 0w4BcKGFZSQFu6/wdavAygMPQ+cbFwVjCp22pDajvKQZ8LAFoEV6xaIdV/zGPzh14zzx+PW8xcC
 YTYy87LsuAFeKmtPxKdMFT5KKLVlcO12Cz+drkCCabox10q+RmArEEQdWZKhHciT971kX9YRaP0
 RtmZpYgJzoFvA77HcLTRcRrpfXl+QgfqfcTl7EZRyosh89ZWsVtdEFZlhH8/oWFiWPifG7+G
X-Proofpoint-ORIG-GUID: _VzTySBFvDLRxHo2HnNLBAc0ZrRFtccW
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-03_01,2025-06-02_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 mlxscore=0 spamscore=0 priorityscore=1501 mlxlogscore=999
 lowpriorityscore=0 suspectscore=0 impostorscore=0 malwarescore=0
 clxscore=1015 adultscore=0 phishscore=0 classifier=spam authscore=0
 authtc=n/a authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505280000 definitions=main-2506030095

On Wed, May 28, 2025 at 04:50:26PM -0700, Anjelique Melendez wrote:
> Add support for TEMP_ALARM LITE PMIC peripherals. This subtype
> utilizes a pair of registers to configure a warning interrupt
> threshold temperature and an automatic hardware shutdown
> threshold temperature.
> 
> Signed-off-by: David Collins <david.collins@oss.qualcomm.com>
> Signed-off-by: Anjelique Melendez <anjelique.melendez@oss.qualcomm.com>
> ---
>  drivers/thermal/qcom/qcom-spmi-temp-alarm.c | 208 +++++++++++++++++++-
>  1 file changed, 207 insertions(+), 1 deletion(-)
> 

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>

-- 
With best wishes
Dmitry

