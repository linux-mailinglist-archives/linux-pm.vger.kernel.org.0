Return-Path: <linux-pm+bounces-11722-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BFEDE942312
	for <lists+linux-pm@lfdr.de>; Wed, 31 Jul 2024 00:44:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7EA3E2883A4
	for <lists+linux-pm@lfdr.de>; Tue, 30 Jul 2024 22:44:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D043B1917D8;
	Tue, 30 Jul 2024 22:44:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="ptv5EuxX"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F4AA145A11;
	Tue, 30 Jul 2024 22:44:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722379476; cv=none; b=QmAaHlYUpRcVGqvKrLC5bxunehrexoRatMdcw81nI25gq3vxvqkHkGYCmnhi7A+q9oTU8YC9zlqXq19Eca7UoIs+UcDpDPKWQfAJ4DjQ0tv0+BkUjH7a5VGOM972/Vb6/dR1mtI9pBJgMpXcfex7hj+7YS6b5/wyL0/RsCVx/E4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722379476; c=relaxed/simple;
	bh=g3i1r6sz4u6swLwricrOGwLtZUE/aR1WYBX7piT3zk4=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=C7iuT/eApBPcMcJv8qfgm30um3TvGAJOyB0/HSGVuEc6BF9o2d6DEvGb5CbnWGhMYsPsoQFsMY9E8pePi+kLL4FtzX13miAcsL/Guz2YA51SO2LOC/GaEKYsf1GSfbQ9D5EROZIJ3JwW630u91rYJ7p3aIDICBM7WOPEF1dGiYM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=ptv5EuxX; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 46UGa5Ol015122;
	Tue, 30 Jul 2024 22:44:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	8Ml+kASE5kxe6i1s8298aQxOVGMC1WE/aeiBMirvJfU=; b=ptv5EuxXBuK0Erv5
	0TDxoOqO0cpgKxHgmWOFq/5NHzc3sy33jXszoiq3VN2RyXl9UAZMhHoF1R0kK/NE
	4t/eBPVY8dnrGpl6uBK3exzbLaFBVekFLbeDyE0e+T7IKUwISMS3KmHmmxQxXE92
	DxHt1sTTLipjVzmeAWdNua/HTiI3zwUBaHQmFwaFUB2KGis1QaiMK8JGLpLyrkTf
	rAr9fv5UDR//oYdRVYhkNLozn9ela3zLlkJS2oQLTGF9Y1Dzct0KH3ZgMXuxc9Kf
	z0dcAT5AyIFMrYQg8ycRJ5K9c/uEdnEP6lfuDHXPl0wUX5K/B6Btx758x1k5rKtK
	xlWPtw==
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 40mqw796qq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 30 Jul 2024 22:44:20 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA03.qualcomm.com (8.17.1.19/8.17.1.19) with ESMTPS id 46UMiJFX019644
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 30 Jul 2024 22:44:19 GMT
Received: from [10.110.63.167] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Tue, 30 Jul
 2024 15:44:18 -0700
Message-ID: <35402164-dce0-b972-bf98-c025fe5620f0@quicinc.com>
Date: Tue, 30 Jul 2024 15:44:06 -0700
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH 4/5] thermal: qcom-spmi-temp-alarm: add support for GEN2
 rev 2 PMIC peripherals
Content-Language: en-US
To: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
CC: <robh@kernel.org>, <krzk+dt@kernel.org>, <conor+dt@kernel.org>,
        <amitk@kernel.org>, <thara.gopinath@gmail.com>, <andersson@kernel.org>,
        <quic_collinsd@quicinc.com>, <rafael@kernel.org>,
        <daniel.lezcano@linaro.org>, <rui.zhang@intel.com>,
        <lukasz.luba@arm.com>, <linux-arm-msm@vger.kernel.org>,
        <linux-pm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
References: <20240729231259.2122976-1-quic_amelende@quicinc.com>
 <20240729231259.2122976-5-quic_amelende@quicinc.com>
 <pzu2ijzkofzxpehpc4yphj5567ijdrxngqrepaq54njdagjenh@3vxmezjoepqg>
From: Anjelique Melendez <quic_amelende@quicinc.com>
In-Reply-To: <pzu2ijzkofzxpehpc4yphj5567ijdrxngqrepaq54njdagjenh@3vxmezjoepqg>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: fYnkxKTnxcwsEnfeiuEGqL0KpYdOSqRH
X-Proofpoint-GUID: fYnkxKTnxcwsEnfeiuEGqL0KpYdOSqRH
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-30_18,2024-07-30_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 mlxlogscore=999 spamscore=0 impostorscore=0 lowpriorityscore=0
 clxscore=1011 bulkscore=0 adultscore=0 suspectscore=0 malwarescore=0
 phishscore=0 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2407110000 definitions=main-2407300157

>>  
>> +/* Configure TEMP_DAC registers based on DT thermal_zone trips */
>> +static int qpnp_tm_gen2_rev2_update_trip_temps(struct qpnp_tm_chip *chip)
>> +{
>> +	struct thermal_trip trip = {0};
>> +	int ret, ntrips, i;
>> +
>> +	ntrips = thermal_zone_get_num_trips(chip->tz_dev);
>> +	/* Keep hardware defaults if no DT trips are defined. */
>> +	if (ntrips <= 0)
>> +		return 0;
>> +
>> +	for (i = 0; i < ntrips; i++) {
>> +		ret = thermal_zone_get_trip(chip->tz_dev, i, &trip);
>> +		if (ret < 0)
>> +			return ret;
>> +
>> +		ret = qpnp_tm_gen2_rev2_set_temp_thresh(chip, i, trip.temperature);
>> +		if (ret < 0)
>> +			return ret;
>> +	}
>> +
>> +	/* Verify that trips are strictly increasing. */
> 
> There is no such requirement in the DT bindings. Please don't invent
> artificial restrictions, especially if they are undocumented.
> 

This is not an entirely new restirction. Currently the temp alarm driver
has hardcoded temperature thresholds options which are "strictly increasing"
(https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/thermal/qcom/qcom-spmi-temp-alarm.c?h=v6.11-rc1#n44). 
The threshold values are initially configured based on the stage 2 critical trip
temperature.
For newer PMICs, we have individual temperature registers for stage 1, 2, and 3,
so we instead configure each threshold temperature as defined in DT. In general
since stage 1 = warning, stage 2 = system should shut down, stage 3 = emergency shutdown,
we would expect for temperature thresholds to increase for each stage
(https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/commit/drivers/thermal?h=v5.4.281&id=f1599f9e4cd6f1dd0cad202853fb830854f4e944).

I agree that we are missing some documentation but since the trips are defined in the
thermal_zone node what is the best way to mention this requirement? Will adding a
few sentences to qcom,spmi-temp-alarm.yaml description be enough? Do we need
to make changes to thermal_zone.yaml so that dt_binding_check catches this requirement? 

>> +	for (i = 1; i < STAGE_COUNT; i++) {
>> +		if (chip->temp_dac_map[i] <= chip->temp_dac_map[i - 1]) {
>> +			dev_err(chip->dev, "Threshold %d=%ld <= threshold %d=%ld\n",
>> +				i, chip->temp_dac_map[i], i - 1,
>> +				chip->temp_dac_map[i - 1]);
>> +			return -EINVAL;
>> +		}
>> +	}
>> +
>> +	return 0;
Thanks,
Anjelique

