Return-Path: <linux-pm+bounces-27168-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 00A85AB7C74
	for <lists+linux-pm@lfdr.de>; Thu, 15 May 2025 05:47:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BA36A1BA4438
	for <lists+linux-pm@lfdr.de>; Thu, 15 May 2025 03:47:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BCF9183098;
	Thu, 15 May 2025 03:47:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="ZW0JM7Wn"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B8911361;
	Thu, 15 May 2025 03:47:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747280858; cv=none; b=BH3aB1/CZLkK2bi8j07Qy30XLdCOtmRMJLk1HSzvE91pBcPy0tjTKq09SRX6Y2NLGOHyRI6+Qvj13ZBLQJ+0SozaWLozbQABHgzctYv9UFqlVU+JlLklIllp+dk1+DNnADr4YYZZG9+Y+JwP+oT3XSOzN7YIp2zTBHluDVMFHGk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747280858; c=relaxed/simple;
	bh=jusEkXQPdT+EmYOtbUapz0vfxgv/rJOyiAD+Rz2I7p4=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Rk4bH+bvJ/dPlT4tjTI2AhOad8J15WVEtaNQSHocKlITBoXiML2SMmQRqC1KY6FJ51nQJygF2i5MeGj6FhuvM8t4YChrXFw84a8nB6j/MqRzZwkL5IvPN0zOnQLerV3+Jg5fHiyPJIwNa8fNo2B8VHpxmpaOiBZNrTBxLdYVrBg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=ZW0JM7Wn; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54EKPAuj013086;
	Thu, 15 May 2025 03:47:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=zGTC0pl80cZTRh+KrVwQmdum
	JQlUqqo0pnHsL1UmezI=; b=ZW0JM7Wnr+AfhIkQ6S1RyA3LKAoI6FRjwkPhf3wH
	HBFyvz8gxywzhYX208+3o6xZUhgm7VIxcJXR8eTxiecJs0ZyEGqC/48mHel+4VWI
	Szi3Si0pG9M4M12nPX1nSEW81epCwCNOZG8oxjHUSPvBit5bne6kZqHN1+Q4M4qS
	JsgjrIHVpoK25BydioheTjM3Q+KJxO90LBfhNsEFAIsX0IDsHqNyzZbG4cHio7oP
	1gbqEe5+NvGhMbUOeADWjFt6ttUDwCk2ylQ9uYYWCjfmi+A4EAOruKdwdoQ8R/Ng
	35PbWXc7ylmkW32czePTuBbIWcgdTWNccy9LPdHr4Eu7gQ==
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 46mbcmmv4r-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 15 May 2025 03:47:19 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA02.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 54F3lIIg000483
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 15 May 2025 03:47:18 GMT
Received: from hu-mdtipton-lv.qualcomm.com (10.49.16.6) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Wed, 14 May 2025 20:47:18 -0700
Date: Wed, 14 May 2025 20:47:16 -0700
From: Mike Tipton <quic_mdtipton@quicinc.com>
To: Sudeep Holla <sudeep.holla@arm.com>
CC: Cristian Marussi <cristian.marussi@arm.com>,
        "Rafael J . Wysocki"
	<rafael@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>, <arm-scmi@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <linux-pm@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, Peng Fan
	<peng.fan@oss.nxp.com>,
        Peng Fan <peng.fan@nxp.com>
Subject: Re: [PATCH v3] cpufreq: scmi: Skip SCMI devices that aren't used by
 the CPUs
Message-ID: <aCVjxJB6dUzIAyPJ@hu-mdtipton-lv.qualcomm.com>
References: <20250428144728.871404-1-quic_mdtipton@quicinc.com>
 <aBtLMYqcnwacGJuy@pluto>
 <20250507-analytic-practical-carp-5cddaf@sudeepholla>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250507-analytic-practical-carp-5cddaf@sudeepholla>
X-ClientProxiedBy: nalasex01c.na.qualcomm.com (10.47.97.35) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTE1MDAzNCBTYWx0ZWRfXzGvfqREIeNlu
 mK6PGnMZr0Z3NEH+vaH9JvW+HwiRH1nF5lnM4DuOSxGqcVLb07N1qD0AaDACMjg18rUGUa/VEeY
 S7ldd1wxFSZ2rmHAYKaRn9jwD7W2ERYr5xTH/iL5VFWrP/e12oxkXSa4zZj1kX5NStmlVpS3h7U
 4cn+1c0z0C8XkQeNHOfTAPANWIOcP/MmE0ORIMdNB452CtjyOk5kADIsrlp0wHemX6gGPSODK+b
 eO1LordZDsYUl0HQJlhFmXavKtP1I3bXescCjbuLf+jARaLqdCYIy7E5QXMSVw/KW8tmWr62Jb5
 RmDYsB7Fw+a6VFnQu0aL1XTNgvsWbulChQjTdpyMKaZyzuLK10wLYdOtuLW2RONpT0rO9O7AHhi
 /jyn97wi1tSxi/XE/kOW9w73p0Gm6OzaenUSomuMtxtoDC/xKf0EEaJq6ETAbBCMT/e6n2xZ
X-Authority-Analysis: v=2.4 cv=G5scE8k5 c=1 sm=1 tr=0 ts=682563c7 cx=c_pps
 a=ouPCqIW2jiPt+lZRy3xVPw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=3H110R4YSZwA:10 a=kj9zAlcOel0A:10 a=dt9VzEwgFbYA:10 a=7CQSdrXTAAAA:8
 a=Ml6eQ6jI9tVgauyEpOUA:9 a=CjuIK1q_8ugA:10 a=a-qgeE7W1pNrGK8U0ZQC:22
X-Proofpoint-GUID: 5PJ48GxnBVuJhvW7hiJVMppIztQxFO7i
X-Proofpoint-ORIG-GUID: 5PJ48GxnBVuJhvW7hiJVMppIztQxFO7i
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-15_01,2025-05-14_03,2025-02-21_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 mlxlogscore=717 clxscore=1015 phishscore=0 bulkscore=0
 suspectscore=0 spamscore=0 impostorscore=0 lowpriorityscore=0 mlxscore=0
 malwarescore=0 adultscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505070000
 definitions=main-2505150034

On Wed, May 07, 2025 at 02:12:36PM +0100, Sudeep Holla wrote:
> On Wed, May 07, 2025 at 12:59:45PM +0100, Cristian Marussi wrote:
> > On Mon, Apr 28, 2025 at 07:47:28AM -0700, Mike Tipton wrote:
> > > +static bool scmi_dev_used_by_cpus(struct device *scmi_dev)
> > > +{
> > > +	struct device_node *scmi_np = dev_of_node(scmi_dev);
> > > +	struct device_node *np;
> > > +	struct device *cpu_dev;
> > > +	int cpu, idx;
> > > +
> > > +	if (!scmi_np)
> > > +		return false;
> > > +
> > > +	for_each_possible_cpu(cpu) {
> > > +		cpu_dev = get_cpu_device(cpu);
> > > +		if (!cpu_dev)
> > > +			continue;
> > > +
> > > +		np = dev_of_node(cpu_dev);
> > > +
> > > +		if (of_parse_phandle(np, "clocks", 0) == scmi_np)
> > 
> > Shouldn't this, on Success, be released by an of_node_put() (or, BETTER,
> > by some OF-related cleanup.h magic...)
> > 
> 
> Good catch, I missed this.
> 
> With the above issue fixed, you can add and post new version:
> Reviewed-by: Sudeep Holla <sudeep.holla@arm.com>

Thanks Cristian / Sudeep.

The cleanup.h __free() logic gets a bit cumbersome here, especially with
two struct *device_node to free in the same scope. And since there isn't
any complicated cleanup logic to unwind, then I'll just go with the
direct calls to of_node_put().

Also note we aren't calling of_node_put() in scmi_cpu_domain_id(),
either. I can fix that in a follow up patch.

I'll send v4 of this patch shortly.

