Return-Path: <linux-pm+bounces-37580-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 4302FC3E52A
	for <lists+linux-pm@lfdr.de>; Fri, 07 Nov 2025 04:16:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id BFE6B34ACD6
	for <lists+linux-pm@lfdr.de>; Fri,  7 Nov 2025 03:16:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C67092836A6;
	Fri,  7 Nov 2025 03:16:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="akoRC4Mu";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="aUAkbeUY"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 207D91D5151
	for <linux-pm@vger.kernel.org>; Fri,  7 Nov 2025 03:16:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762485389; cv=none; b=rOV2Z/PAbYM0bHeoGnH6mbOSBFulBD/Dtg/47SwkrVnX7As0kI5wUW+dUG3hRkidokg+Cx68OXD0/O9ZXG7QOxlyicxxdb9pbp1ojtK+DjU3cpr/9vdKAG6YIQA0hhhGW/vjXGkolZHmTIg128jYcglORCLF+jCdwG7jD/NCPG0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762485389; c=relaxed/simple;
	bh=1morzm8NYa0wAvKPrknK4exKQLvQ7AJODwCifEu2fT0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Q/sQRvOcvgux/vLEGmRr7QKXSxkpz7FhC+5Q4598ldYq9S82uiR1oim7JAzk93u+zw+VtcHi3SiufP2MJdOTeGgjpNOh00Zruyd3QrrWdAfCv82+9Le9ettWZATpcrUtel30NsV4wj+iz8RG6J9HRn7uvWvvAIQBo/OeIyU3y0A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=akoRC4Mu; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=aUAkbeUY; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5A718FSN1709810
	for <linux-pm@vger.kernel.org>; Fri, 7 Nov 2025 03:16:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	prIk2oxefhTBMGizLe5VBrcTGfPiFu9uI/8uXkNkJYM=; b=akoRC4MuJEYOHcOn
	GOEn/RdiVZ7pF80wuWp1tK7XtyCbDnPhVvV5K3NlayL39B5GLS7OVb0OPNdyxT0L
	UwlgfdmR1BjFq0wfhVEVCFiKlGUEBscmUObbhU6iO0ubpIMbjM5bd4E5zZ9OIj/X
	M5sESt2ytsYmiRF9TZzGrnbfCGUz9t5UFOM0LLFFFQZ1Px0dlIwUfHkLEc0iZu5J
	C8PQpcWoDpAL8QbKj/ol9Er8atBO+i01LkHnRLNc9NwK4T9KJoGjhZqUvV45MzJ1
	jeXa9gBi3NS9yHmaKTLj0vUUWVkMeUOZRSitKpdZW3qD8yQVQTZr4APjMCvGtMJ1
	ULCOfg==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com [209.85.160.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4a96ue0axr-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Fri, 07 Nov 2025 03:16:26 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-4ed74ab4172so8826891cf.1
        for <linux-pm@vger.kernel.org>; Thu, 06 Nov 2025 19:16:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1762485386; x=1763090186; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=prIk2oxefhTBMGizLe5VBrcTGfPiFu9uI/8uXkNkJYM=;
        b=aUAkbeUYR2CzB1FT67n+T3F2ltWI+PArEtEEU8txJTmTc8ivPVxERb1agImDues9mR
         TC/SIxDSnzdeX2xxDu03Dz7S0+2FijpQOqxPqAayXzROEs4x3khG1NWRRfHheZxnV9jC
         PKgIjsVEGSQc0so4QDwvWYlRY3fIEjjga+lrHyiq11/Q/CJi4JMSgwQyUEWiR7l4yiuX
         ThAxTYLiUePZraKJMeUMF8E9L16lvNLjPwj1slpeS3bi021hJPrGw834J6PK/saaOP07
         iq1rAMSUpWn4EaGuuMS3ix75cwA6RRSSf454nXn+6phlz6imMZKr2hirY90JaslG91F7
         7jew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762485386; x=1763090186;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=prIk2oxefhTBMGizLe5VBrcTGfPiFu9uI/8uXkNkJYM=;
        b=QA1hRCpINoBgno/UuyrsZNEyID9He2r2+2+w78qVroUmTjpSKnrz7cAxURExidkkWt
         Rgt2NB3m3mtM30xfuXobHyE8FO7h5bukfgFHyCD2gFDgQU8wRICj8g35zc7I7QkHK6u0
         tO/R6+P8qkquh+T+vdev+7md4gczTu9+uvArG1WQVqj5aTfnOjSiJLTtjLlISUdEYO+L
         pUwKNV5BIITmRv2NNERwflJuvCK6zWg5aMmbuJ5tPHtGn0xWmMf3skMGY3tXC/kn1Vnd
         EGGkiNa3HWZwqVT4uj5YgcFSWGRiuxr0EcifkVb+R37dPn8mxsMz3HnJxdtbiniZnsl+
         LKcA==
X-Forwarded-Encrypted: i=1; AJvYcCVHr52yo6vqKIR++gLIuyIi7+ywnn3GbrClUURNn1/LtNsHHiwi3iy/4NTySZrXlvyjRy+xtezMDg==@vger.kernel.org
X-Gm-Message-State: AOJu0YzDjzuAIZTIUJKhv45OH2mXZR461XKBkxNNsVRmq10+s2UsYmwi
	JdrLds37cwwg29WP0CWNRtqLGuFOji6mKcsTlPNKvr55PxeySqXEiL7X3+dOtSDHuzHbilcEXa5
	TMuSeHaz3g3a+xQ8z+fsoOzHGHJj8Tye6UpDTAgs82H8w9SBs4sofv+qm/VhwWQ==
X-Gm-Gg: ASbGnct/cc9IWblJurJvLF0AiO8TNViA9aUs3Ju4vIsCZDmhsd6/jt64mlCm2DjRjlB
	6CaagKvDqzjC4cbW1kRipiA5vaCdOd/PjgLVpvYLoik2l0uG7BMsCgI6Q1DkUR62PismciwclUv
	vmFsfwXzDLGdXYNKZsNLBr6qTUiykQIcjvibzJ1JskdaW6lEXy91Vlf3SolJmndz4iWaeGEloF9
	/c2jgiqUC+ksqZZlsoRvDt7+4RsdH1+a2XWUunOrjPMOBySkLuv1wNpeOda3pLyCe+WquwFO/fe
	0gKheADz85qDnyNWq5KvXMQD/ZHQsTTlIGN1S6rUZ0EzwgDOr3Ahdv4Xd0SQa/7B5E1YVBIS8iN
	7pZmM3otowiR0o9O4q+Zb6iU0Ha5IbcJGFkl2EyCSH8/CFpYgJVR4aObpg3Z3PI5bs6U/xFJeuk
	LOHn/Mmbgvjovl
X-Received: by 2002:ac8:578c:0:b0:4ed:23df:6a4d with SMTP id d75a77b69052e-4ed94a83250mr20198731cf.68.1762485386342;
        Thu, 06 Nov 2025 19:16:26 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGrhuAniX3epDvEEwBYOamZ5qOgePgMzHNWTJLDWUcznPxtnIGIxwFlzJYufCft4rDvBY1XrA==
X-Received: by 2002:ac8:578c:0:b0:4ed:23df:6a4d with SMTP id d75a77b69052e-4ed94a83250mr20198521cf.68.1762485385913;
        Thu, 06 Nov 2025 19:16:25 -0800 (PST)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5944a0b779fsm1134734e87.56.2025.11.06.19.16.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Nov 2025 19:16:25 -0800 (PST)
Date: Fri, 7 Nov 2025 05:16:23 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: MyungJoo Ham <myungjoo.ham@samsung.com>
Cc: Kyungmin Park <kyungmin.park@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Dmitry Osipenko <digetx@gmail.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>,
        "linux-arm-msm@vger.kernel.org" <linux-arm-msm@vger.kernel.org>,
        Robie Basak <robibasa@qti.qualcomm.com>
Subject: Re: [PATCH RESEND v2] devfreq: move governor.h to a public header
 location
Message-ID: <cdzlgnun7kpn24hziut23njsnlnzl465hdquq4zfmur7ylt5id@ioaqt5ilixwt>
References: <20251030-governor-public-v2-1-432a11a9975a@oss.qualcomm.com>
 <CGME20251030182636epcas1p2b332b417c1c42fb559a6f34e9e9f408c@epcms1p5>
 <20251107005809epcms1p5f33e9560755367f0ba4b7df82c87fc85@epcms1p5>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20251107005809epcms1p5f33e9560755367f0ba4b7df82c87fc85@epcms1p5>
X-Authority-Analysis: v=2.4 cv=fYKgCkQF c=1 sm=1 tr=0 ts=690d648b cx=c_pps
 a=WeENfcodrlLV9YRTxbY/uA==:117 a=xqWC_Br6kY4A:10 a=8nJEP1OIZ-IA:10
 a=6UeiqGixMTsA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=NEAV23lmAAAA:8 a=EUspDBNiAAAA:8 a=40jZUBKxUhFIhurt5UIA:9 a=3ZKOabzyN94A:10
 a=wPNLvfGTeEIA:10 a=kacYvNCVWA4VmyqE58fU:22
X-Proofpoint-ORIG-GUID: 0ez2anKnt5VYIzwECNRoWPr0I0HvXNYE
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTA3MDAyMyBTYWx0ZWRfXxGiQG0lCa3DC
 gefkzmvES9/LRvvD5+rOuzD0tOBG2pPEB8VL+x+fFfS3I2Mpdo8C7mjPgB7r05KUFyNK6pQbRWD
 RnNhc/RhdwsknYGoFLYHRVpaE9WFbG30jv/NoOzGG5YWIpvzhBIlNN50AN84Q4hhHCrDYKSdGp9
 rw5ZqXxN3M+LKHuTOaRauWovNIe+NBj9Qgj1K2+21sYEiRnP5M7g2Knk6SQylswA1/SXP5HBAcZ
 2sZXLUc7oLXWT2fufdBJJacELnN3MWzSt4iZXqOgIFHm9nenp8kOMvSN0QRaqvOC7V3NW4owLp2
 vpsovlcFimDdTAGBPO4rgr04UkULdlWPjpxgq5uMVQpnvKbt1H4dFimhkZLMDp9IlSjb7r5OBoy
 oS7SENGzPEXcf6dXtapxRwlKs+115w==
X-Proofpoint-GUID: 0ez2anKnt5VYIzwECNRoWPr0I0HvXNYE
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-06_05,2025-11-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 phishscore=0 priorityscore=1501 malwarescore=0 spamscore=0
 lowpriorityscore=0 bulkscore=0 impostorscore=0 clxscore=1015 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2511070023

On Fri, Nov 07, 2025 at 09:58:09AM +0900, MyungJoo Ham wrote:
> >Sender: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com> 
> >Date: 2025-10-31 03:26 (GMT+9)
> >Title: [PATCH RESEND v2] devfreq: move governor.h to a public header location
> >
> >Some device drivers (and out-of-tree modules) might want to define
> >device-specific device governors. Rather than restricting all of them to
> >be a part of drivers/devfreq/ (which is not possible for out-of-tree
> >drivers anyway) move governor.h to include/linux/devfreq-governor.h and
> >update all drivers to use it.
> >
> >The devfreq_cpu_data is only used internally, by the passive governor,
> >so it is moved to the driver source rather than being a part of the
> >public interface.
> 
> Hi!
> 
> Could you please direct me to the governors or drivers needing this?
> (Qualcomm drivers?)

This has been prompted by the Qualcomm KGSL driver:

- https://github.com/qualcomm-linux/kgsl
- https://github.com/qualcomm-linux/kgsl/issues/11

But I think this issue is not limited to the KGSL driver. Other
out-of-tree modules might also implement device-specific governors.

-- 
With best wishes
Dmitry

