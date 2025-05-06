Return-Path: <linux-pm+bounces-26708-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C8809AAB8DA
	for <lists+linux-pm@lfdr.de>; Tue,  6 May 2025 08:44:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BD2C85068C3
	for <lists+linux-pm@lfdr.de>; Tue,  6 May 2025 06:42:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C05261DDC2A;
	Tue,  6 May 2025 03:59:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="lLWokG/o"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DB0F1E1C02;
	Tue,  6 May 2025 01:26:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746494771; cv=none; b=Y5sLNkEZtPZatnjJB++MssKeimbNKYp/x2oucB48nf1tTsTI30R2hwX3WfioMSZ1tJ3dODN8xoVqKldAue9zAac0/kZQzj9fDc/6PHUIC1dZM87kaSUwJhX8qTWWye2x2A/0UcowWP9YicP8k0L06Hkvk7PWMP4J6DLV6pRHY7Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746494771; c=relaxed/simple;
	bh=lMA9xqdteBtAICMBE4dR29eHiKv0C8YGXInXwEg4QJs=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=g3w4ONzWY1B2N52eXpaGiN2xdwvLklu4E7nwTA3AyA00I6R7D7Ck+V/as7s2ja78oZE8Bz/EORdtlkAxnqozOz8QfUhHsqIr74Vbu5fEeq2BrViFQgo+cVOlsN0Re9GAaZIK5bnmXqfeOpY1UQOhv/kk0t3EfNr5I7Iy9BnKfoQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=lLWokG/o; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 545KTahu007918;
	Tue, 6 May 2025 01:25:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=a+3iGwj/hO6S7Q34SFvoBpBv
	Y/YCE7J0Uke+mqkFKdM=; b=lLWokG/oTSHi6rlDNIPU9NU/6RtsEIwXEn99+Dqn
	LGbfLebmWVRwfX8hTtAcN7uZbSYiMAOA/AUYrQqtyCfph/eFNFR55B+AmYfuzskK
	qp9s9QvxkXJinwdh+1fV975rl16fxG3SChI4GGuEOuecfDdQvB5KFuCvURJbyyes
	jmP4zE7fewYkZJ4xEe0WIWzuJSRDLXSX4bG7O3WyMIJ093QPwzuLeXdllALpbqZe
	iRvn392OydCJLw0J8O31CeLzBY1dMO/8P+RJSOUurXGQ+2PKtUVzi98/4CEP2DkW
	gcjQLH3yPwFILQh4k+DmL3zF+j3P4SxOD1rkAgE9KyGDnQ==
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 46d9ep5xbn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 06 May 2025 01:25:52 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA01.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 5461PpoR000950
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 6 May 2025 01:25:51 GMT
Received: from hu-mdtipton-lv.qualcomm.com (10.49.16.6) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Mon, 5 May 2025 18:25:51 -0700
Date: Mon, 5 May 2025 18:25:50 -0700
From: Mike Tipton <quic_mdtipton@quicinc.com>
To: Sudeep Holla <sudeep.holla@arm.com>,
        Cristian Marussi
	<cristian.marussi@arm.com>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Viresh
 Kumar <viresh.kumar@linaro.org>
CC: <arm-scmi@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        <linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Peng Fan
	<peng.fan@oss.nxp.com>, Peng Fan <peng.fan@nxp.com>
Subject: Re: [PATCH v3] cpufreq: scmi: Skip SCMI devices that aren't used by
 the CPUs
Message-ID: <aBllHt7A2nP/9x3N@hu-mdtipton-lv.qualcomm.com>
References: <20250428144728.871404-1-quic_mdtipton@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250428144728.871404-1-quic_mdtipton@quicinc.com>
X-ClientProxiedBy: nalasex01c.na.qualcomm.com (10.47.97.35) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Authority-Analysis: v=2.4 cv=EOUG00ZC c=1 sm=1 tr=0 ts=68196520 cx=c_pps
 a=ouPCqIW2jiPt+lZRy3xVPw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=3H110R4YSZwA:10 a=kj9zAlcOel0A:10 a=dt9VzEwgFbYA:10 a=COk6AnOGAAAA:8
 a=8AirrxEcAAAA:8 a=yJaCyoTPdldMf7LLIq8A:9 a=CjuIK1q_8ugA:10 a=ZXulRonScM0A:10
 a=zZCYzV9kfG8A:10 a=TjNXssC_j7lpFel5tvFf:22 a=ST-jHhOKWsTCqRlWije3:22
X-Proofpoint-ORIG-GUID: xQyI9TTY1mL-lT4GgZf6t5ZYvE89kQxv
X-Proofpoint-GUID: xQyI9TTY1mL-lT4GgZf6t5ZYvE89kQxv
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTA2MDAxMSBTYWx0ZWRfX0c07hmmoRyzu
 LDWrWnnWv0/IlnrcjiVXRgnYvkD5HQsp5bdZIcTS3Ww3dRnV6+lb3FHQzRn0Nu4CE5ohLo35EE3
 MKWpVsDkWPL7//XRwgO1B5Ap0ztm9P674s9K5i4ifZIqFlhXWCbSIc9r5ABVp+gZjTfGb0tUbRX
 tplERRuJtyhiHFdJkXtIfrRcmuWfMWUtvQqH9IyzS+B7z24iL8mT2Uitj7uf/LCk8tCHk0My3yu
 9bOsebPbHJWneXjaOU674k3uq0f0ax1pgOOQ/HLaF/3yMt/V+qK2tDRbQ9TDPhMMZXuUt/3/iRY
 iUVUEF9bHJ3gqd78jAUeDbRZM8AkFGjdDvnbqJhp6oUQIfhzS12fZ+JxzDVF3KKdkfa9Pyyvbkb
 KznSbL3vilQGSjCN0mGXpeB7U4v3hct0eDyZenBiokuEQJs7RfQKSxAzer5ybRqNDw4Kbexz
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-06_01,2025-05-05_01,2025-02-21_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 clxscore=1015 impostorscore=0 spamscore=0 lowpriorityscore=0
 bulkscore=0 phishscore=0 suspectscore=0 mlxlogscore=809 mlxscore=0
 priorityscore=1501 malwarescore=0 classifier=spam authscore=0 authtc=n/a
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2504070000 definitions=main-2505060011

On Mon, Apr 28, 2025 at 07:47:28AM -0700, Mike Tipton wrote:
> Currently, all SCMI devices with performance domains attempt to register
> a cpufreq driver, even if their performance domains aren't used to
> control the CPUs. The cpufreq framework only supports registering a
> single driver, so only the first device will succeed. And if that device
> isn't used for the CPUs, then cpufreq will scale the wrong domains.
> 
> To avoid this, return early from scmi_cpufreq_probe() if the probing
> SCMI device isn't referenced by the CPU device phandles.
> 
> This keeps the existing assumption that all CPUs are controlled by a
> single SCMI device.
> 
> Signed-off-by: Mike Tipton <quic_mdtipton@quicinc.com>
> Reviewed-by: Peng Fan <peng.fan@nxp.com>
> ---

Hi Sudeep / Viresh,

Any thoughts on this?

Thanks,
Mike

