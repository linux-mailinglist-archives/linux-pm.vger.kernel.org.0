Return-Path: <linux-pm+bounces-10392-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 83C4D924C3E
	for <lists+linux-pm@lfdr.de>; Wed,  3 Jul 2024 01:42:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CC058B22704
	for <lists+linux-pm@lfdr.de>; Tue,  2 Jul 2024 23:42:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A379617A5B4;
	Tue,  2 Jul 2024 23:42:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="SXySJUsh"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C9D615B0FA;
	Tue,  2 Jul 2024 23:42:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719963742; cv=none; b=CxER6jNBXg6QSI3rvP7rPp5fuL1Slv/4Fpmi6Uzx2tgWV9mxDC2tds+Y9ZYY10Twb6Lqhmcsma22rHGpSd2sL0bwzvw9kFlfvVyVwJuyUNP2GHdQfFOgxsHKSbMT7y5IE1371QV7VTqAykVmGDW158jJ99WvgrOMX9L1lkHljPM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719963742; c=relaxed/simple;
	bh=jlWxBxFk+HCXJYnmffwKODc013vrhbNl2Nc0J2JH3Qg=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=b6TpNFg48+R/5Op41gwabsqIcO+8F3Uk8qXuFSoAHczjakeoHRJEtvQvV3jQKHlwTvyZW4Mz1k1N+EPDeQG77/kmDu4WeN4EF/EB8GkTKVhNLOjcsd8boKIkSYT82m3T9lkazFvNpMLcd2Za+IiEKEFiyA12Cpr9+8pJtLcd5kE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=SXySJUsh; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 462EVDhb028831;
	Tue, 2 Jul 2024 23:42:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	pifJmqE360Wi2ZlB+7FyAUTiHz21CDAqRbjc2BGXkF0=; b=SXySJUshwLJIEUZ5
	TFez692Js580eVCKbfs3aNEO8vFX3TdD0I3fue5aif0SaaZUQt34xxdpxcO+uqjb
	NBuFF5jPovwvP4uHFuel5shR1pfUYAZjOBJR+LEUUhfLPB1KWD1qWTEMh0vipS3V
	9ZYsb+AoXZpUhzvIZkUbzISrjc4Gb1ZEdpJxqe6UdQaJgfIHTCIF2/GO4vyOuwQU
	eW+tT0WNzzEofL+i4HOQkab+DnOEK2YD/fjnciE4SY+gjiCj/sWlCtrxBUQS0Bx5
	vp+ioK9IRVj3tGuM3fkHbnqiY6zRILFzTK8MSty+NzeBC6AVT9GEf6vhOvJ+zh7a
	JtNs0g==
Received: from nasanppmta01.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 404kcthgmt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 02 Jul 2024 23:42:06 +0000 (GMT)
Received: from nasanex01a.na.qualcomm.com (nasanex01a.na.qualcomm.com [10.52.223.231])
	by NASANPPMTA01.qualcomm.com (8.17.1.19/8.17.1.19) with ESMTPS id 462Ng5pi005312
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 2 Jul 2024 23:42:05 GMT
Received: from [10.110.10.43] (10.80.80.8) by nasanex01a.na.qualcomm.com
 (10.52.223.231) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Tue, 2 Jul 2024
 16:42:05 -0700
Message-ID: <1bdc4d4c-9cf1-a8bd-80de-7463cecd2c78@quicinc.com>
Date: Tue, 2 Jul 2024 16:42:04 -0700
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH v5 3/4] firmware: psci: Read and use vendor reset types
Content-Language: en-US
To: Elliot Berman <quic_eberman@quicinc.com>,
        Sudeep Holla
	<sudeep.holla@arm.com>
CC: Sebastian Reichel <sre@kernel.org>,
        Bjorn Andersson
	<andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring
	<robh@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>, Vinod Koul <vkoul@kernel.org>,
        Andy Yan
	<andy.yan@rock-chips.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        "Mark
 Rutland" <mark.rutland@arm.com>,
        Bartosz Golaszewski
	<bartosz.golaszewski@linaro.org>,
        Satya Durga Srinivasu Prabhala
	<quic_satyap@quicinc.com>,
        Melody Olvera <quic_molvera@quicinc.com>,
        Shivendra Pratap <quic_spratap@quicinc.com>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        Florian Fainelli <florian.fainelli@broadcom.com>,
        <linux-pm@vger.kernel.org>, <linux-arm-msm@vger.kernel.org>
References: <20240617-arm-psci-system_reset2-vendor-reboots-v5-0-086950f650c8@quicinc.com>
 <20240617-arm-psci-system_reset2-vendor-reboots-v5-3-086950f650c8@quicinc.com>
 <20240619135143.kr2tx4ynxayc5v3a@bogus>
 <20240619080933071-0700.eberman@hu-eberman-lv.qualcomm.com>
 <20240620162547309-0700.eberman@hu-eberman-lv.qualcomm.com>
 <ZnmTtmZB8epgbUTN@bogus>
 <20240702155630416-0700.eberman@hu-eberman-lv.qualcomm.com>
From: Trilok Soni <quic_tsoni@quicinc.com>
In-Reply-To: <20240702155630416-0700.eberman@hu-eberman-lv.qualcomm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01a.na.qualcomm.com (10.52.223.231)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: NKwRwjM6Tcs4eLOciR9alWglevT05tc5
X-Proofpoint-ORIG-GUID: NKwRwjM6Tcs4eLOciR9alWglevT05tc5
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-02_16,2024-07-02_02,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 adultscore=0
 bulkscore=0 mlxlogscore=999 priorityscore=1501 impostorscore=0
 suspectscore=0 mlxscore=0 lowpriorityscore=0 clxscore=1011 malwarescore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2406140001 definitions=main-2407020175

On 7/2/2024 4:06 PM, Elliot Berman wrote:
> Hi Sudeep,
> 
> On Mon, Jun 24, 2024 at 04:41:42PM +0100, Sudeep Holla wrote:
>> Sorry, I completely missed to see that you had already answered those
>> in your commit message. As mentioned earlier I haven't looked at the
>> reboot mode framework completely yet, so I can't comment on it yet.
>>
>> I don't want to be blocker though if others are happy with this.
> 
> I think folks are satisfied with the other parts of the series and now
> looking for your conclusion on the PSCI driver part.

I will be nice to get these patches picked up before 4th July holiday in US :).

-- 
---Trilok Soni


