Return-Path: <linux-pm+bounces-25678-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 845CEA92ED4
	for <lists+linux-pm@lfdr.de>; Fri, 18 Apr 2025 02:33:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0B2F719E617D
	for <lists+linux-pm@lfdr.de>; Fri, 18 Apr 2025 00:33:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A36242A1BB;
	Fri, 18 Apr 2025 00:33:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="afaS14Z9"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9CA870809;
	Fri, 18 Apr 2025 00:33:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744936384; cv=none; b=Z05CWiCK3VcHbjNX1VPDXBkj7A+riT9twDxXDEqzqz0hEwgFx69jogumqjNPr5rq/JQRXftzzZOY3+mdmOpXLIwNAs6UjDJzJuuGgzgGOa1DCG0iwtF1l9sKeVHaqVW9bumF2RQsqRcgxZdNCjBF21HTTpJudIPJ+eg7a1E3FCU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744936384; c=relaxed/simple;
	bh=X56rnsjlDCuwL+1MMz+5gWk6fCKSQBrk7LTX893DDIM=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=I4mvWoHAkbWDMeeY+VxFrf4XTMf9C3RwzQxiVvas0LGxw/3+ud2A0zPKvH5Q0srjbOPcK6EyvF0XiFuaXlACTGK3ysW6MTpdIjh3SQgnOENo4JVNsbSC0mSB2/XBgx+ivXgime91en9FYu5zL9Gx/FxlJaN7a66JW9OUml7upAg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=afaS14Z9; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53HClU2j005239;
	Fri, 18 Apr 2025 00:32:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=WoKQ1Gf4RTzaW58T3r2Dxthd
	VjtUH2sR3JuHdtrWZE4=; b=afaS14Z9614nTbLSMnZNvuUcCAZHUbmbgg2oRvJO
	cS5kg/QrWu4VIEMPhmRlUcWd4kj7sDVHerwgPBBikdgnFKCsHuBbYwBLBLck/GCV
	apNyPGuT4kpY/o1mgAFSmvAypWHiCZqlmd3aaIuzbDG+sC1gqE2FsUvlj29DmPhG
	ebmtWRLlef73D5jmYiePSx+6RdQQOBHyGA7j4ibN38e/a9ywSArRrywWipkS4Fz7
	dz+lj/7jqUV6YNWWz0e6WAiRPxEBkZVfluurofYNariB1eDzHwAzD9JUQnrEhYYd
	j90AkhwFA1VohHKb0byKtX00RkSZqkcjdPZKz8OkV4sBLA==
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 45yf6a0jyb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 18 Apr 2025 00:32:58 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA01.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 53I0WvKh024971
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 18 Apr 2025 00:32:57 GMT
Received: from hu-mdtipton-lv.qualcomm.com (10.49.16.6) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Thu, 17 Apr 2025 17:32:57 -0700
Date: Thu, 17 Apr 2025 17:32:55 -0700
From: Mike Tipton <quic_mdtipton@quicinc.com>
To: "Aiqun(Maria) Yu" <quic_aiquny@quicinc.com>
CC: Georgi Djakov <djakov@kernel.org>, <linux-pm@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <quic_okukatla@quicinc.com>
Subject: Re: [PATCH] interconnect: Replace mutex with rt_mutex
Message-ID: <aAGdt7GftthwJ1+6@hu-mdtipton-lv.qualcomm.com>
References: <20220906191423.30109-1-quic_mdtipton@quicinc.com>
 <3c8965c0-3bc0-252e-381d-bd057fd02af5@kernel.org>
 <20220907145916.GA2368@hu-mdtipton-lv.qualcomm.com>
 <bda36907-d7eb-4969-909b-697eebe14941@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <bda36907-d7eb-4969-909b-697eebe14941@quicinc.com>
X-ClientProxiedBy: nalasex01a.na.qualcomm.com (10.47.209.196) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: QBeyfsDkBDkMLU_criEAjohgrjVJMtDZ
X-Authority-Analysis: v=2.4 cv=JNc7s9Kb c=1 sm=1 tr=0 ts=68019dba cx=c_pps a=ouPCqIW2jiPt+lZRy3xVPw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17 a=3H110R4YSZwA:10 a=kj9zAlcOel0A:10 a=XR8D0OoHHMoA:10 a=PhClAm8El1gnTNPeiugA:9 a=CjuIK1q_8ugA:10
X-Proofpoint-ORIG-GUID: QBeyfsDkBDkMLU_criEAjohgrjVJMtDZ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-17_07,2025-04-17_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 malwarescore=0
 suspectscore=0 mlxlogscore=758 lowpriorityscore=0 bulkscore=0
 impostorscore=0 clxscore=1015 phishscore=0 adultscore=0 priorityscore=1501
 spamscore=0 classifier=spam authscore=0 authtc=n/a authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.19.0-2502280000
 definitions=main-2504180002

On Thu, Apr 17, 2025 at 07:13:52PM +0800, Aiqun(Maria) Yu wrote:
> On 9/7/2022 10:59 PM, Mike Tipton wrote:
> > On Wed, Sep 07, 2022 at 10:35:26AM +0300, Georgi Djakov wrote:
> >> Hi Mike,
> >>
> >> Thanks for the patch!
> >>
> >> On 6.09.22 22:14, Mike Tipton wrote:
> >>> Replace mutex with rt_mutex to prevent priority inversion between
> >>> clients, which can cause unacceptable delays in some cases.
> >>
> >> It would be nice if you have any numbers to share in the commit text.
> > 
> > I can try to dig up some numbers, but mileage will vary tremendously of
> > course. Improvement is really only seen in certain high-concurrency
> > scenarios.
> 
> We need to revisit this thread because the issue has been reported again
> recently.
> Here is the data I can provide regarding the performance issue. Please
> check if it is sufficient for the commit message to understand the change.
> The CFS normal tasks holding the mutex lock were runnable for
> approximately 40ms in a busy load scenario, causing the RT task to wait
> for the mutex for about 40ms, which resulted in the RT task not being
> 'real-time' enough and causing janks. Changing the mutex to an RT mutex
> helped the caller of the interface, such as icc_set_bw, to ensure that
> RT tasks can deliver RT priority to the current RT mutex owner quickly,
> thereby improving performance in this scenario.

I'll post an updated and rebased version of this patch soon. In addition
to the display use cases, it was recently reported for certain other GPU
use cases as well.

> 
> > 
> > I'm not sure what an alternative, generic solution would be. We have
> > many clients requesting many different paths. Some are more
> > latency-sensitive and higher priority than others. If these use cases
> > overlap, then we're subject to these sorts of priority inversion issues.
> > Bumping the priority of all clients to match the highest priority one
> > isn't really possible.
> 
> Based on my understanding, rt_mutex is a good API to solve this type of
> issue.

I agree and still don't see any generic solution aside from this.

