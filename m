Return-Path: <linux-pm+bounces-37674-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DCF3C4329B
	for <lists+linux-pm@lfdr.de>; Sat, 08 Nov 2025 18:48:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 71FD34E73FA
	for <lists+linux-pm@lfdr.de>; Sat,  8 Nov 2025 17:48:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50738264617;
	Sat,  8 Nov 2025 17:48:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="lsOJbx0U";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="GJLMsb8Q"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED7E5231A32
	for <linux-pm@vger.kernel.org>; Sat,  8 Nov 2025 17:48:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762624125; cv=none; b=l5AeFXiwbJ8G1/q5gPbNfS6r7u8iBZTkTjRraCsIXs7sHJKsm2lsVVrN3Hc0bUegIaQKwPLHAdfa+CMy/xq9LyBU0v217Cv681JuGq2Ikn08UktJlIE+X8hRhR37y3p9ijulLoQlf909uzo8AR/dH/CwcefUSXMwnsl+iHw8xVk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762624125; c=relaxed/simple;
	bh=wstHiNMcujFNhx99Jgc6AiOxnCPcdqeq3Vo4mwlMDPc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gkUbXj3HEl+I7JgiXqm+bJN8V3ZPSaOFvcs2dMjpEtiI89p42fRCiBpVX/YOqSUXvXBbcPp82ryQ+q6EBZTlYZvtAoCrKVTTwgX9TPbXgFwFV6SXvWg6MwkFXr2lUed3tXkEdwhJht6jO3noEcnM6SenGU1NvG+uibPFiVRLE8I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=lsOJbx0U; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=GJLMsb8Q; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5A8CKnOB1949956
	for <linux-pm@vger.kernel.org>; Sat, 8 Nov 2025 17:48:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=p9VIITPBI6FH+3MumQYzHuBc
	LCwlSNsZGEMhVh7NkDA=; b=lsOJbx0UxlWHi0jz+ZnkYAcMJpTnqcX61J/4qV+E
	lzoNA53n4mHp4HKHDXsEMCEcaE4MruwYoUhU6tQ8E8eXrfk4ZmoPFOieZ5fCVRK6
	64kSDZS2CWDYjpl0dUhCjDKwCEAINF+iqDALjTuEMyJfO20mDjy98F58GRjmvO7h
	l32SC6YDW1VcBEsZtcLvr8iMJbYagArFo5NBjgw5PQvEas/QzG9RrBNvdouENtjd
	qtikQD7T1mCOp5aZ7wS2iVtMfQU3e6JLnADn0QRAzbE+H13QTjFk741s1WgkPrpR
	X58+5u4US9ouZaWoNZoIgP7sFKd2W50XHsz79tkTxF15mg==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com [209.85.160.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4a9xuegxrt-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Sat, 08 Nov 2025 17:48:41 +0000 (GMT)
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-4ed6ff3de05so59491541cf.3
        for <linux-pm@vger.kernel.org>; Sat, 08 Nov 2025 09:48:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1762624121; x=1763228921; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=p9VIITPBI6FH+3MumQYzHuBcLCwlSNsZGEMhVh7NkDA=;
        b=GJLMsb8QadwOsi6lldyEE1bab6qwEVp8EOa3xUllUl3rLtflefzxU/pXLO1UphfA0V
         iy2SLBoF9ssr4pwp1hGfDyDtLLAc7oCCROlwoVEZZAMRdIpHJcTbx+DJmnPeWi3OEcc6
         koIlW7QAyHY/gXpcOt0YoYKaLy30LUUfN5UeNI/UFLHE5k4O32XTcCFCnMpxHiWpNlJQ
         u9VI83w5yDxbtvR3rSC1ws7CsbgXH9+xYX5LYU2tUmFiw1HB0GR5mjDkoeRGsUPTJE2A
         WqACD+EPkV5gk30bVQiSDgYFJBZPjS3UbjNCc6Qch/IX/EA01PZTZFwuaJDuFmY3AK0R
         MnrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762624121; x=1763228921;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=p9VIITPBI6FH+3MumQYzHuBcLCwlSNsZGEMhVh7NkDA=;
        b=sdiV7HWW2W6kio00Ul8wkwu8Tlua7CVRHcYWpIX1Og/BVFGbtggg3R9Uea2PCEf3sd
         OOPFbGQuto735QAEWvaGb1Vd8Sr0OgWiM5dCtRqWhFlz6u5I+wjTNLYo9iSuTShJ9FV2
         b2ThIXco6lqqPFkIkytcUcrLlXX4HzaLz4JHEhD8+rAdr1lvVp+fDFLcDm2WfIs/3TcT
         TpPSzU4nmmCEqqY8UTcLQ2J95i2PQH14SxaBcyWppAsIDUmtzsvd22o4xKNwXxEVnd/D
         tMznTqwdeCvPcDhzclfjW87aOH3OPBvRxT0eAp6bD6oJdVtDPGh7bWPiB8t5ifq2aSp1
         dazg==
X-Forwarded-Encrypted: i=1; AJvYcCVclw7HUAUkzOWZIdF8MTCQwDhJQTN7S5rflxcPvtw/Uoo6IH5i3MATUjwQQ+jbhj5euIcEnOwreg==@vger.kernel.org
X-Gm-Message-State: AOJu0YxD66XqlTYuPjok7+qX6YXZH3YA9gxMp7kcI+SN2X322oMvpDJ2
	udZ2F9SsVO+i9As1D9/P1iKOtWM5IeBQWd6axusWvOY/r7G34AmuuFpYlF7JqoTeeS72cPyl5pN
	ZBInaXe4V8hNU+qYmBMcnYbqEL8+YTALxStAkEyT1WJrhnFP5O3Z+KbMXstOZEw==
X-Gm-Gg: ASbGncvKq4wD0+ZbVhy4lyxCcul7y2dkJ0GbYNIwpujSoYX/xz/fn8h6jTulHsIt1QV
	SCym0g/XdGYilclGVx4SVQnJH+SKLWyeY/ltvSJjwe7RdsoQIHjoRdU6QIjTyGmqy/iXy8I8331
	A6fWj9wwnWRKHSKGl/or6TVYjZ5REGbidBWlMh+Wkz0YIxozdVvQ5vjGznVkhiTP4G8s8vNVsKt
	140SaLpiTkpBTZksWAyiusgW7HRYAdawANWPpzOEOHhlcgaEu3NDmSz25NSxOhME21CR7r5Kd/l
	OqVAXE6tfL6MKHOzBloqIhuEVQSZQhYjL53niAZH9CIm+NjOXtCcZWKikopFK53RiSaF6bmRR8J
	9Z1mmdb0Em2i/C0GIeZVMNvmtZIWyITrt9f2IuN7TUOaO+UUqUlwAMYKBOSYE3AwYIXJrDC/Pt2
	1PnW81A8D/kGiM
X-Received: by 2002:ac8:7f8a:0:b0:4ed:2edb:92b9 with SMTP id d75a77b69052e-4eda500b39dmr44706461cf.81.1762624121129;
        Sat, 08 Nov 2025 09:48:41 -0800 (PST)
X-Google-Smtp-Source: AGHT+IE3UX8GkmdwTy3sgfmRIRR485zCV767sy17zShEsRHghjOuKXUPgDs+3aiNzzZLVzaET00gqw==
X-Received: by 2002:ac8:7f8a:0:b0:4ed:2edb:92b9 with SMTP id d75a77b69052e-4eda500b39dmr44706331cf.81.1762624120724;
        Sat, 08 Nov 2025 09:48:40 -0800 (PST)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5944a594e2fsm2334143e87.99.2025.11.08.09.48.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 08 Nov 2025 09:48:38 -0800 (PST)
Date: Sat, 8 Nov 2025 19:48:35 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Luca Weiss <luca.weiss@fairphone.com>
Cc: Georgi Djakov <djakov@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 5/5] arm64: dts: qcom: sm6350: Add clocks for aggre1 &
 aggre2 NoC
Message-ID: <5vrvuegqb4jbd5o7ipghrhxpfx57e4toj4vsplh4imupkc5emo@2qto6v4ftqz4>
References: <20251107-sm6350-icc-qos-v1-0-8275e5fc3f61@fairphone.com>
 <20251107-sm6350-icc-qos-v1-5-8275e5fc3f61@fairphone.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251107-sm6350-icc-qos-v1-5-8275e5fc3f61@fairphone.com>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTA4MDE0NCBTYWx0ZWRfX1rti0DurM5bF
 V9vKCT3Cpbg/XTggB9wLkeh3wLcFLq+RJsMF5BNJUJ3qw6Ff+beRNZXrU+c4JXgplbB8eQdoDmz
 3NFfGpZ4bOx01MwrFY9Uzg67L+04GOqqlW3e9V4cPs3tj+9viYhjcD+YU6FJFlA+5FaSueXWN74
 Fjhn35fZKaHmmmVuUwnKxOkBwxHgbpVLbVdM8WxrrQIJFka/1srhYKl/kmr6Sh4JB3psP3jeuiK
 3b+v0smSjxGzBwPN6sydGsDTmd3YYYeLrBXlkuHnk+FhLtNn8RiH+P+RcpVtLax42Kv41Wlqh/J
 JTIOXtJLhyFyTuMqhVDnmP+uGo1OhYQFPAEMDIxA9xzK3e46mGFvSxWwx/lEUKwdk9ruTpMwjO1
 s84E2xHvGD3kIKPmz0irvcd66oMJhg==
X-Proofpoint-GUID: 9G9wddSc9tm-Ud0V52gY-c5zpdp140er
X-Proofpoint-ORIG-GUID: 9G9wddSc9tm-Ud0V52gY-c5zpdp140er
X-Authority-Analysis: v=2.4 cv=BOK+bVQG c=1 sm=1 tr=0 ts=690f8279 cx=c_pps
 a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=6UeiqGixMTsA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=6H0WHjuAAAAA:8 a=EUspDBNiAAAA:8 a=B5yIxIZ4dO-XZLLuwIMA:9 a=CjuIK1q_8ugA:10
 a=a_PwQJl-kcHnX1M80qC6:22 a=Soq9LBFxuPC4vsCAQt-j:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-08_05,2025-11-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 bulkscore=0 adultscore=0 clxscore=1015 suspectscore=0
 priorityscore=1501 spamscore=0 malwarescore=0 phishscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2511080144

On Fri, Nov 07, 2025 at 05:08:51PM +0100, Luca Weiss wrote:
> As per updated bindings, add the clocks for those two interconnects,
> which are required to set up QoS correctly.
> 
> Signed-off-by: Luca Weiss <luca.weiss@fairphone.com>
> ---
>  arch/arm64/boot/dts/qcom/sm6350.dtsi | 3 +++
>  1 file changed, 3 insertions(+)
> 

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>


-- 
With best wishes
Dmitry

