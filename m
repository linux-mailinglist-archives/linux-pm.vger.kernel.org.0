Return-Path: <linux-pm+bounces-25478-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5065CA8A47A
	for <lists+linux-pm@lfdr.de>; Tue, 15 Apr 2025 18:45:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 40D167ACC95
	for <lists+linux-pm@lfdr.de>; Tue, 15 Apr 2025 16:44:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B2C729B780;
	Tue, 15 Apr 2025 16:45:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="Q6oA97FC"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4879429E05C;
	Tue, 15 Apr 2025 16:45:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744735512; cv=none; b=UlKX7b9WcfrvB4RZHzaF7j+i1HRstwki+8IO9FpI0B/YhLZyopOw44iF4nEeGsKv1fqwS1tzzqdTMD/urn16HoZahKyoYyx1VG8WKivco/0ayBsWe6f7djKveQNci4+0GsrdEUPgYVqa9jcrBPCmKkb1nJpgIiOXbcsXRolv8BA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744735512; c=relaxed/simple;
	bh=VOnDxQaAKRWw2IKlU/+VitLZInyTZ7+P1ECUBgtIElI=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RZuEsRRD1mzZma9kYWuXXOnGDEqO3FKlx5Ki2NklR7oO9dg/5L0fnET8CKE09fOQOcaQvPE65gbo+LkvM6qsX6PSlyJqDThgziMwdxz4qKiBG7Xcbt1KCAZbB4NFam1hlWR4Q9ThiSfw9Y6Jm6VsMaed0sh5Ol55tNw4JJon9MQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=Q6oA97FC; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53F8tCtH025071;
	Tue, 15 Apr 2025 16:44:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=+kDB+MDxRVThD8Eyv10zNktc
	2R/pYfeT2l4xLH5sq0c=; b=Q6oA97FCcAITogJh02z4K9O3Oh77YbOdAt0jViLC
	GsRzb7YcHmSMJT7flsasQeNge24zxRQqa0esofn4G9vjwRyv6tikvC4UpQDKgp6W
	I2fmDiAq2tI8tQRoOn1ZNYa/yc1a+8g052Rq90KUrbwSEGsjliOjIEaafTmL/aLz
	pk2B12DJ9eVvPdoiYKrGixaBkDufi2YVPHNoFWggFo2uQET6Bf3UF/49lDRNmIH7
	uQ3fLzSAiSCy8f71mE2Ig7LnHgrXcxyqRFrGom7wrPW6XxZ3kDbaknGZ9wgtFbbc
	rizWfVdhmIDePT6lwrFM/TOT7G4j5tk0ZZ4gmT9afd1F3g==
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 45yg8wgu3x-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 15 Apr 2025 16:44:57 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA02.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 53FGiuiK019612
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 15 Apr 2025 16:44:56 GMT
Received: from hu-mdtipton-lv.qualcomm.com (10.49.16.6) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Tue, 15 Apr 2025 09:44:56 -0700
Date: Tue, 15 Apr 2025 09:44:55 -0700
From: Mike Tipton <quic_mdtipton@quicinc.com>
To: Peng Fan <peng.fan@oss.nxp.com>
CC: Sudeep Holla <sudeep.holla@arm.com>,
        Cristian Marussi
	<cristian.marussi@arm.com>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Viresh
 Kumar <viresh.kumar@linaro.org>, <arm-scmi@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <linux-pm@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] cpufreq: scmi: Skip SCMI devices that aren't used by the
 CPUs
Message-ID: <Z/6NB2QRvRrqwgcQ@hu-mdtipton-lv.qualcomm.com>
References: <20250411212941.1275572-1-quic_mdtipton@quicinc.com>
 <20250415090655.GA10243@nxa18884-linux>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250415090655.GA10243@nxa18884-linux>
X-ClientProxiedBy: nalasex01b.na.qualcomm.com (10.47.209.197) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Authority-Analysis: v=2.4 cv=E9TNpbdl c=1 sm=1 tr=0 ts=67fe8d09 cx=c_pps a=ouPCqIW2jiPt+lZRy3xVPw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17 a=3H110R4YSZwA:10 a=kj9zAlcOel0A:10 a=XR8D0OoHHMoA:10 a=COk6AnOGAAAA:8 a=nqZ6nTEg5KUHkvYbfU8A:9 a=CjuIK1q_8ugA:10
 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-ORIG-GUID: 6zJdl26a50mbWxYTiGA4Xw4GOcA4slVa
X-Proofpoint-GUID: 6zJdl26a50mbWxYTiGA4Xw4GOcA4slVa
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-15_06,2025-04-15_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 adultscore=0
 mlxscore=0 bulkscore=0 clxscore=1015 phishscore=0 lowpriorityscore=0
 suspectscore=0 mlxlogscore=999 spamscore=0 priorityscore=1501
 impostorscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2502280000
 definitions=main-2504150116

On Tue, Apr 15, 2025 at 05:06:55PM +0800, Peng Fan wrote:
> On Fri, Apr 11, 2025 at 02:29:41PM -0700, Mike Tipton wrote:
> >Currently, all SCMI devices with performance domains attempt to register
> >a cpufreq driver, even if their performance domains aren't used to
> >control the CPUs. The cpufreq framework only supports registering a
> >single driver, so only the first device will succeed. And if that device
> >isn't used for the CPUs, then cpufreq will scale the wrong domains.
> >
> >To avoid this, return early from scmi_cpufreq_probe() if the probing
> >SCMI device isn't referenced by the CPU device phandles.
> >
> >This keeps the existing assumption that all CPUs are controlled by a
> >single SCMI device.
> >
> >Signed-off-by: Mike Tipton <quic_mdtipton@quicinc.com>
> >---
> > drivers/cpufreq/scmi-cpufreq.c | 29 +++++++++++++++++++++++++++++
> > 1 file changed, 29 insertions(+)
> >
> >diff --git a/drivers/cpufreq/scmi-cpufreq.c b/drivers/cpufreq/scmi-cpufreq.c
> >index 944e899eb1be..7981a879974b 100644
> >--- a/drivers/cpufreq/scmi-cpufreq.c
> >+++ b/drivers/cpufreq/scmi-cpufreq.c
> >@@ -393,6 +393,32 @@ static struct cpufreq_driver scmi_cpufreq_driver = {
> > 	.set_boost	= cpufreq_boost_set_sw,
> > };
> > 
> >+static bool scmi_dev_used_by_cpus(struct device *scmi_dev)
> >+{
> >+	struct device_node *scmi_np = scmi_dev->of_node;
> >+	struct device_node *np;
> >+	struct device *cpu_dev;
> >+	int cpu, idx;
> >+
> >+	for_each_possible_cpu(cpu) {
> >+		cpu_dev = get_cpu_device(cpu);
> >+		if (!cpu_dev)
> >+			continue;
> >+
> >+		np = cpu_dev->of_node;
> >+
> >+		if (of_parse_phandle(np, "clocks", 0) == scmi_np)
> >+			return true;
> >+
> >+		idx = of_property_match_string(np, "power-domain-names", "perf");
> >+
> >+		if (of_parse_phandle(np, "power-domains", idx) == scmi_np)
> >+			return true;
> >+	}
> >+
> >+	return false;
> >+}
> >+
> > static int scmi_cpufreq_probe(struct scmi_device *sdev)
> > {
> > 	int ret;
> >@@ -404,6 +430,9 @@ static int scmi_cpufreq_probe(struct scmi_device *sdev)
> > 	if (!handle)
> > 		return -ENODEV;
> > 
> >+	if (!scmi_dev_used_by_cpus(dev))
> >+		return 0;
> 
> Should 'return -ENOTSUPP' be used here?
> There is no need to mark the probe success.

Returning -ENOTSUPP will add noise in the logs from probe failures, for
example:

    scmi-cpufreq scmi_dev.4: probe with driver scmi-cpufreq failed with error -524

These are "expected" failures, so this would be misleading. However, we
could return -ENODEV instead which doesn't log anything by default. It
uses a dev_dbg() in that case:

    scmi-cpufreq scmi_dev.4: probe with driver scmi-cpufreq rejects match -19

Returning -ENODEV seems more appropriate. I can make that change.

