Return-Path: <linux-pm+bounces-34743-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 226E6B59F32
	for <lists+linux-pm@lfdr.de>; Tue, 16 Sep 2025 19:24:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8C4D61BC23C7
	for <lists+linux-pm@lfdr.de>; Tue, 16 Sep 2025 17:24:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68D2325B1DC;
	Tue, 16 Sep 2025 17:24:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="YbShnk+E"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA4ED253B67
	for <linux-pm@vger.kernel.org>; Tue, 16 Sep 2025 17:24:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758043449; cv=none; b=WPvy8/l7y/0O67Y1blhHXeu7qKcPm4zLnPM82kY29gvUfAV8921xPanqs1egJD5U9Sbesj4ZdNiM4vhjby6a2sdx7hYkBVrAHW/S7Mr/kBIloyD64nKmtbq43PZFKBrJBo/ig9DBu6boHcR+01KTx/LoBj6SoJ/q+erTlQklCf0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758043449; c=relaxed/simple;
	bh=MMRDsv7F3L4iVwuItvJKhX/lkgNUMkwNnqMAXa51eJY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=a4uvfHp5ITsdynMQoaDqAscMj6/ADh/Fh1+17D2tNJY7kurKfbHqlMpOVJT91hqIqs7R4zLDcXrAnfULQsv9i0EjnzGL0P/vy+1XR9OsNuw8VSv4oT+ZlPh0fc214DIgeZvWHHvi14lGHgM6uJhWdOr6NPvr4ZHunzl9QgjuuSI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=YbShnk+E; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58GA1kBF005612
	for <linux-pm@vger.kernel.org>; Tue, 16 Sep 2025 17:24:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=hVJaMFI5Gjh/Baa5ktag1wf6
	hKqheSFU5lQBIMVpCak=; b=YbShnk+EmtE1J0PdqrUXlMR+1KrcppSpR9QOdcfx
	fj4qZNAWj+IZv+8RcHn1hpjzU66oZC40SA7f04qf+CDhhq8H9bYYo/wZ7jYUVZaq
	h1RwDTq5GFgmxYF62pTFCSmBB2b9IXCtGSo7uTrbvxAGwTwukAxxXClxD9J/eZOl
	XQjLp9wAisqLN6fuFIqaLIfDg5atgGfwrvF3PKbavB++hlCR88kSHiTxQFykL0ic
	Qb3Dbi+AiumxI4pOvug33UALfQkPAXpCC6GqWGlfE7gaFVt5QE8gcBi2+jH0se/I
	rGoN/uePn//t1HPlsOq1bYYKLx3LK8gKKqsnaDAY9r4RSw==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com [209.85.160.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4950u59rb8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Tue, 16 Sep 2025 17:24:07 +0000 (GMT)
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-4b5f818eea9so109596741cf.2
        for <linux-pm@vger.kernel.org>; Tue, 16 Sep 2025 10:24:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758043446; x=1758648246;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hVJaMFI5Gjh/Baa5ktag1wf6hKqheSFU5lQBIMVpCak=;
        b=A3h5S7yLtDTNhfT6ZKS7yY4QQY9+t8TkAU4qjwV5eKF2dpBaqz6crqiTiA5z8DHTUd
         UXhgvYfjfiyQ/xzsDh3zqCLVn3zMxU14WVm8vnIpIj3uhEPkz2f7mWA2kxPHGReOSg1z
         t0eiVsIAzz3KCMy9sXnfenkZptjWeJSSDxTB22AV/XiNkC8F/tj8wYB5mIDpzx/1e037
         bFQCVtbuG54g2QTEK/mM8UGcip9K0DlS7aVloJKa6lel9H6R1wAHMuZz7R7SvX2cmkqA
         I/ohMUYImZHV4WzRMY5BCb5xH4kdh/spSLqzAvnili+iefKangWHtwbZMJ49QASwVmgz
         b0zA==
X-Gm-Message-State: AOJu0YznqzCdH1Uw0ukpuXcoZ3+nUwcWOlND1o7eyTPhqntr1z+NXthC
	ByHWhYuAojGvPzX4uCBj8d/hz8Yl+9a0r+siVpd0iGgRdpOMQFKKfbTFbrgjRz3qh5zrsNZF+dK
	TgVBlFh3KMsrZHvxn/m6FlRyyOyXQAuuXN1u0vPlMbYlvcIcn3kLw9OP7QLRTNA==
X-Gm-Gg: ASbGncs0tLPLu9HPNRoEu26yovwH5pC7SIQHquSesbq7P/96uBBgaw1F0hxfJdUrXmf
	ovA7YOZ34uzXLMvw3wf9WduP509k2N53UvZbsFV0BDsgkL2I830c6wOn+4GAemWFFrvGBy60wTQ
	tkaMBlJ0kzZSKFgVJJ/N9THqcVUZUwwrhwOrsmDbZY7fu9eAKa6n8+jSBR5taVdnPxBlf7tSIC4
	cfLe7ZVAhPE9MPnNFBYR8uzCknDYtGujC3mTmFStdPmMzDKCBsBh48mHB6GnpRdvmjk5LOzy8eS
	95FpOm8P+yeX4V3CCaSEjtPqtUYyVSxLiIEqCQmCJlmQa6CB3x/5gnsA0b4vR03xkREF6Z+P9Y0
	neC6CqDKnfSXKyQ1SGdgHZGpZaXo/MhM4uUIfvZV/wNQdvrWGHYbQ
X-Received: by 2002:a05:622a:5e05:b0:4b3:4a3a:48b8 with SMTP id d75a77b69052e-4b788414644mr167556641cf.73.1758043445441;
        Tue, 16 Sep 2025 10:24:05 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGr6odQMGAixWJo4XzHRfYcfzQgqZWK3iutuTIsVhQhJR9bb22IYTwsejar9wedxbDu/asfUw==
X-Received: by 2002:a05:622a:5e05:b0:4b3:4a3a:48b8 with SMTP id d75a77b69052e-4b788414644mr167556171cf.73.1758043444718;
        Tue, 16 Sep 2025 10:24:04 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-34f1b2a925dsm33908831fa.46.2025.09.16.10.24.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Sep 2025 10:24:03 -0700 (PDT)
Date: Tue, 16 Sep 2025 20:24:02 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Dmitry Osipenko <digetx@gmail.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-tegra@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        Robie Basak <robibasa@qti.qualcomm.com>
Subject: Re: [PATCH] devreq: move governor.h to a public header location
Message-ID: <3shtevnohqcwjr7zho75brhx3ffbluwtaimzst2kkonohdzlwu@2myszcxun3gl>
References: <20250903-governor-public-v1-1-111abd89a89a@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250903-governor-public-v1-1-111abd89a89a@oss.qualcomm.com>
X-Proofpoint-GUID: X1RVeJ3oC0OIpQsTSd2tBkC4YvAV2o3A
X-Proofpoint-ORIG-GUID: X1RVeJ3oC0OIpQsTSd2tBkC4YvAV2o3A
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTEzMDAzMSBTYWx0ZWRfX+MIzG5kyh+dx
 IbHOiDBupVAMTOACsIqxL0+I6lBxqwaHPPjN8rPt7i/zpEVh8kNV7hDzo4SElJ5qZGl+2/xzEux
 TpJVVRhYmRUz6O1gnrDW8KQRwiB7jFJuazfwOYNP9pDItQZZfISEz0/Yl4nc0LXr89o/NfGDooR
 PM6hX4wP/jbF0wvvBQ7FbMLUitkylDd3jKVPDH5ad6a7QUMF7SbHu5cN79yF4HYjAHJn2I7I90t
 HqtHwIGO0/JvZERq6lY6ZndggEENFicHMV74C+62GutBit54LEWH70Im2avqtp0WLEjAjdiUVPd
 lc4ZQT38Mvt/Yi69a1dMJCA8gXeUsfCG6Su7HrLRegrLD+DDEOJCVf5vJdSmKvWyndDsTFocc7t
 YgJMs/Kd
X-Authority-Analysis: v=2.4 cv=JvzxrN4C c=1 sm=1 tr=0 ts=68c99d37 cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=yJojWOMRYYMA:10 a=EUspDBNiAAAA:8 a=N0a9waa89YCdHAc7B7sA:9 a=CjuIK1q_8ugA:10
 a=uxP6HrT_eTzRwkO_Te1X:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-16_02,2025-09-12_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 phishscore=0 suspectscore=0 clxscore=1015 impostorscore=0
 spamscore=0 adultscore=0 malwarescore=0 bulkscore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2509130031

On Wed, Sep 03, 2025 at 04:43:04PM +0300, Dmitry Baryshkov wrote:
> Some device drivers (and out-of-tree modules) might want to define
> device-specific device governors. Rather than restricting all of them to
> be a part of drivers/devfreq/ (which is not possible for out-of-tree
> drivers anyway) move governor.h to include/linux/devfreq-governor.h and
> update all drivers to use it.
> 
> The devfreq_cpu_data is only used internally, by the passive governor,
> so it is moved to the driver source rather than being a part of the
> public interface.
> 
> Reported-by: Robie Basak <robibasa@qti.qualcomm.com>
> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
> ---
>  drivers/devfreq/devfreq.c                          |  2 +-
>  drivers/devfreq/governor_passive.c                 | 27 +++++++++++++++++-
>  drivers/devfreq/governor_performance.c             |  2 +-
>  drivers/devfreq/governor_powersave.c               |  2 +-
>  drivers/devfreq/governor_simpleondemand.c          |  2 +-
>  drivers/devfreq/governor_userspace.c               |  2 +-
>  drivers/devfreq/hisi_uncore_freq.c                 |  3 +-
>  drivers/devfreq/tegra30-devfreq.c                  |  3 +-
>  .../governor.h => include/linux/devfreq-governor.h | 33 +++-------------------
>  9 files changed, 37 insertions(+), 39 deletions(-)
> 

Gracious ping, I haven't heard anything back.

-- 
With best wishes
Dmitry

