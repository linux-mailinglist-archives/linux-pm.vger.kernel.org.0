Return-Path: <linux-pm+bounces-28006-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D11EAACC4A4
	for <lists+linux-pm@lfdr.de>; Tue,  3 Jun 2025 12:50:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F06671885E1B
	for <lists+linux-pm@lfdr.de>; Tue,  3 Jun 2025 10:51:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3EF9922A813;
	Tue,  3 Jun 2025 10:50:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="BQ6o68R2"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5BD822A1D5
	for <linux-pm@vger.kernel.org>; Tue,  3 Jun 2025 10:50:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748947849; cv=none; b=UEeF80FcZkhUmdmTGyoUVpwszRxr4MPLwqSR7f5OJvEotNMWLuRA80h1aikccMB+LuTlqgkXI9Qds0vHw68+3+6/40BaPnq3IUIJBgfIY1sDaQRoFELrH8Bg5HI4/XkIK0d0Bk+Wd9Fgi6MG11i/zqkuhE5V9pNyw8pSEa00w8M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748947849; c=relaxed/simple;
	bh=RzXQoeY8OBWNIwxdR6qtplFIQ/IFmhyVe8iUNlNmbNw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WYcp/pxUQAv741OMeiMxJH4O1Z4rTRnwXrBggMAh6QkkQ/WEdt7qHkf2NLCeftjbDBWuu3SDQgUYeaGx1sHi6oH58rMXWsK8A9KVtg+sDK2FNTl9OEnst7GCL1nOG/5lzvt8og2KSLQLDzYz/KNsNr/8k5xlzcoFsfa4vyLfj4Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=BQ6o68R2; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5539JKc2013530
	for <linux-pm@vger.kernel.org>; Tue, 3 Jun 2025 10:50:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=Vm4mnfktEosvn9wSbQ9LX58d
	m00u7H1ye4NwgmSgVjI=; b=BQ6o68R2EVlEg4rFOgwuwxSoiRjVBsRq27wya4JW
	YKU9gIg4ALQHg+OKo7go6U2oh3N6+7vwwOWR3XVI9pQxFp/RE4wUPleaq4u/ycYD
	czm/qWHttrhfiFbssW1TBhHUEWuJVkfSSd0w4CCyJ6UpSg/JDFjmdPT39WNRU/aF
	o45ZM3QGESGbAmUN6W9s84k5OHyh0Fw7SnDc2TUOaLyVEzhHPvgWrer9dUEjHZ/p
	/1S0U5fD0xiQ5mtSCFzNhdg4iAUfCOrgkdYCY8yFY/j9eYTECDz26vg1/Nkes8KN
	eivAkNnVG9TBxK5z6xtW5srrzIgjmBAJKOhcOiWkRtl6SA==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com [209.85.222.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 471g8nja0m-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Tue, 03 Jun 2025 10:50:46 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-7d097fd7b32so1253785085a.2
        for <linux-pm@vger.kernel.org>; Tue, 03 Jun 2025 03:50:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748947845; x=1749552645;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Vm4mnfktEosvn9wSbQ9LX58dm00u7H1ye4NwgmSgVjI=;
        b=IvQ1A07VrEHMNqYhqeQQdnOhr3qJoeo64XQeWE5MPwrjqXg2MGOmz33aikYnhN5cB4
         y++XASXHQ1JoePFjspp3m7Y7m3jo9D2nDAbyMfFgkmzriNDYGwCWhJQOeBJSf8qqs4tm
         CDsoLkQ9cYVh8qjms+WKcEXmbXicDY5bnSvWdue8ywLyRkctmnWVEA97btuYBoiLiSiK
         HrA+K7g5OTA5ozVN48mZyUDuDldaETYGySUH2gN6vky7RJhwIIuXqksrtoMH0sKYojxR
         VPpWcX5eHEjInB/tJV+AmsIgCsw7kTX2sh0odOQ6v3Mhirbhx9YHPqMyb+4StkaECsXL
         UeHg==
X-Forwarded-Encrypted: i=1; AJvYcCWPnI53Z07PoqKk8BYL8GLGhnxQ6zTuZEgC8uKl9D+UwY1jT0MECQ+bJLFCwJMQ1wo0Rc9myw6jTQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YxkdVFF497kc7D+NqwqCAoW+d7B5n8WEnKnYtw/TyuP+nGroopV
	oQYh9ljNxclR+6b2MwPZOPiI6973zzh/QDawosMVAAXw5vFiPrw+8bLQlohcXkD8ypMuFtYDqHa
	tyCwVssJvkx8l6XBZHYZLBIHi/L2ixCZE3zIsZGsCYg5z2YzpqSAbKkL9TPhPKA==
X-Gm-Gg: ASbGncsmnhZo+LOu6hBuod7u1b9tE8mXWAPv7PmDTw6rq4CCugKxBjwUderE+9Rv4gT
	UR9ENacLc2OLaJSndtZ+oenW/xF0siBspjSO15xoZMuR0PWQdP/Gflp1OIeNmI94qOZmIR4Fspf
	A4l3w6f6d/zVDKQzX5rrjcCw8x/Wp/11UfH3Xnn+vPsOyTP82JJ+LyalEcd28OYOlWpmGH81a3t
	EiHf2TET+rViOrImyuzDekGSJFgFVA6QSJETXyWOXcmiJE79TEDRgH3e4Vqzj8zzUoXTJzWBz7h
	TvkdbQO5mjh6MjxhztcfFKhCVU6I0qNj1NfDvKQftlc9w0wfKJEMP7Radna5UclX4Zj22nb2p2o
	s/4AXViaaVg==
X-Received: by 2002:a05:620a:1a83:b0:7c7:b60f:ebd8 with SMTP id af79cd13be357-7d0a4af321emr2309210285a.24.1748947845568;
        Tue, 03 Jun 2025 03:50:45 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF6/Ai8VNOZ5j/lNeuLKY2LQit0DXGz1yVy635bM9pzD1rNIoOXopJpQt0KqrADunHS/Py7IQ==
X-Received: by 2002:a05:620a:1a83:b0:7c7:b60f:ebd8 with SMTP id af79cd13be357-7d0a4af321emr2309207385a.24.1748947845077;
        Tue, 03 Jun 2025 03:50:45 -0700 (PDT)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00--7a1.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::7a1])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-32a85a30c9esm18242121fa.0.2025.06.03.03.50.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Jun 2025 03:50:44 -0700 (PDT)
Date: Tue, 3 Jun 2025 13:50:42 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
Cc: Anjelique Melendez <anjelique.melendez@oss.qualcomm.com>, amitk@kernel.org,
        thara.gopinath@gmail.com, rafael@kernel.org, daniel.lezcano@linaro.org,
        rui.zhang@intel.com, lukasz.luba@arm.com,
        david.collins@oss.qualcomm.com, srinivas.kandagatla@linaro.org,
        stefan.schmidt@linaro.org, quic_tsoni@quicinc.com,
        linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 1/5] thermal: qcom-spmi-temp-alarm: enable stage 2
 shutdown when required
Message-ID: <i6xy6b2seaxkrpktpyh32fqyxctcvvpk2u6ptpjs727n5fnlak@jcvlqg3ooaxg>
References: <20250528235026.4171109-1-anjelique.melendez@oss.qualcomm.com>
 <0nJRx6-RgYybx3jhgUDcxC9hIxr02feRJuYYgLa6lpO3DOSuQidQkRKKoqvQoV0x26UVeiV6G5XN8cMTZ9Ol5g==@protonmail.internalid>
 <20250528235026.4171109-2-anjelique.melendez@oss.qualcomm.com>
 <895a0004-04df-4b7e-9855-bc0033ca650b@linaro.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <895a0004-04df-4b7e-9855-bc0033ca650b@linaro.org>
X-Proofpoint-GUID: 92Rw8g3lnp8XxLFPaVkFNw1-KUXVUQeC
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjAzMDA5NSBTYWx0ZWRfX95dqhcDeHhYj
 +XQAN/AEZSr8uGCeCRTc3TXI1mDZNPELnhaW+AFlZf263cOsuMhDEEScVa3O1x9IA1RxtuXJcnT
 nx3u/OT64q6UwcI0wYkGXBEZ0tD7f+imZXsYSA2mUh7EOgGqb3+ljdr6/Wt0gmXuiFFwb/uWex2
 g4inoHcZOtKxi3C0BiCh4PsGfWSGUCu4i7Ue6EQbymuuwevsNmw8WiYk+tMXEZdUEP4/tlMSuPl
 3frv7OQjxF+GlnnrJ+PMM4Dgud005mnF4DYXfnsSk+cbV0aP/00VfzovjOhSpDgAROzA1LRC+8S
 pUWg1p60r4r9yLIXHTSFWeXGy/02Hi/wtCikMxdmnANJ3jNM0GuaCaqprrQW8kez/RA8KdVKpAE
 +nffqhdXWcC5FS1dXK86ZhO/nZwePyShWEpWkDC9TUHNopEUAsDeV2BDz4Y6VKHnJP4/FC9B
X-Proofpoint-ORIG-GUID: 92Rw8g3lnp8XxLFPaVkFNw1-KUXVUQeC
X-Authority-Analysis: v=2.4 cv=UphjN/wB c=1 sm=1 tr=0 ts=683ed386 cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=6IFa9wvqVegA:10 a=EUspDBNiAAAA:8 a=7P3EZGi6tQuJdicK0tQA:9 a=CjuIK1q_8ugA:10
 a=NFOGd7dJGGMPyQGDc5-O:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-03_01,2025-06-02_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 spamscore=0 impostorscore=0 lowpriorityscore=0
 phishscore=0 mlxlogscore=999 clxscore=1015 malwarescore=0 adultscore=0
 bulkscore=0 mlxscore=0 suspectscore=0 classifier=spam authscore=0 authtc=n/a
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505280000 definitions=main-2506030095

On Thu, May 29, 2025 at 11:34:27AM +0100, Bryan O'Donoghue wrote:
> On 29/05/2025 00:50, Anjelique Melendez wrote:
> > From: David Collins <david.collins@oss.qualcomm.com>
> > 
> > Certain TEMP_ALARM GEN2 PMIC peripherals need over-temperature
> > stage 2 automatic PMIC partial shutdown to be enabled in order to
> 
> stage 2 should be hyphenated to stage-2
> 
> > avoid repeated faults in the event of reaching over-temperature
> > stage 3.  Modify the stage 2 shutdown control logic to ensure that
> > stage 2 shutdown is enabled on all affected PMICs.  Read the
> > digital major and minor revision registers to identify these
> > PMICs.
> > 
> > Signed-off-by: David Collins <david.collins@oss.qualcomm.com>
> > Signed-off-by: Anjelique Melendez <anjelique.melendez@oss.qualcomm.com>
> > ---
> >   drivers/thermal/qcom/qcom-spmi-temp-alarm.c | 32 +++++++++++++++++++--
> >   1 file changed, 29 insertions(+), 3 deletions(-)
> > 
> > diff --git a/drivers/thermal/qcom/qcom-spmi-temp-alarm.c b/drivers/thermal/qcom/qcom-spmi-temp-alarm.c
> > index a81e7d6e865f..47248a843591 100644
> > --- a/drivers/thermal/qcom/qcom-spmi-temp-alarm.c
> > +++ b/drivers/thermal/qcom/qcom-spmi-temp-alarm.c
> > @@ -1,6 +1,7 @@
> >   // SPDX-License-Identifier: GPL-2.0-only
> >   /*
> >    * Copyright (c) 2011-2015, 2017, 2020, The Linux Foundation. All rights reserved.
> > + * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
> 
> Should have the year in it.

Not per the new policy...

> 
> grep -r Copyright * | grep Qualcomm
> 
> >    */
> > 
> >   #include <linux/bitops.h>

-- 
With best wishes
Dmitry

