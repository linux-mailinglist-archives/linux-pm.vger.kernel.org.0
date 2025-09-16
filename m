Return-Path: <linux-pm+bounces-34732-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 592CCB5985F
	for <lists+linux-pm@lfdr.de>; Tue, 16 Sep 2025 15:58:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0480E188BFC6
	for <lists+linux-pm@lfdr.de>; Tue, 16 Sep 2025 13:57:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFFD331D73E;
	Tue, 16 Sep 2025 13:57:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="osr0DlN8"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 480BDFC1D
	for <linux-pm@vger.kernel.org>; Tue, 16 Sep 2025 13:57:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758031043; cv=none; b=N0K3HbidwllAliU+9dGZbrHfqPgat7fxMqD871CF7g3NftDAUeTOAYAw6cdxgu4V8zAdO9brkSaeaqcsxNvhsrgdYfPQBIC+4CjJ1UwzP00EhL6XeGcaqcKNLRY+nOK5LEHOOf990p4xRSu7wUtqMekYEvMtkJBBIHdmyCJGjt4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758031043; c=relaxed/simple;
	bh=EZixtvrl1rqBKt+UGIfg0P0b7+HT9wRSGmhgvCNmej4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NMo1MN42PlupEZfnulvzmEzjwJvt1WtrfRhXm/iiRObWb9+3yaxg/R/ty7JgfUzJ1GruZnaiRsIjjj/+rLZGZIgb2aVCM86lv7vbaKDpLZqPgNIh3wEfa79zJ7MJwi4uxjeqIBc7j0g+nNI2daXe/k5Cmph3My514rmPEJEUVHA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=osr0DlN8; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58GA4kkH019791
	for <linux-pm@vger.kernel.org>; Tue, 16 Sep 2025 13:57:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	GICyQL3CHMsQbYNvbBfWi61BrYKwCgI38BYL5tUJcxo=; b=osr0DlN8eEm/LYjO
	p2aYTKBFdbjlOuhYriHYjC1HEk2yWXuZwszWVhlsMiyFMa7/6HXQgHm17j/88u7f
	xB2rvfha76uO0oRf7CZCH/aR3/sN5gNibwnsdlqceYyDUpp7DnhG/ztMj9LZR6vM
	MmzwxO554+PvpfcXtrrybhcRPHiPWjKYMRg6/b5sSi3HpVQWCIda5yChWm0t2884
	rrfaRZeLwa10BJ0vR1jTFJiV9Sj6yljg/6DoK1CTewzuxYl+358L9AhYgNTrQ2qj
	c/ZXCB9kIB5K3M4KSjC8lhUbvziMTDYhcjWKW3rLbq1yD4Ye/CSs7eirFcmWfgmr
	x/MVzQ==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com [209.85.160.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 494yma9248-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Tue, 16 Sep 2025 13:57:21 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-4b822016cd2so1425501cf.1
        for <linux-pm@vger.kernel.org>; Tue, 16 Sep 2025 06:57:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758031040; x=1758635840;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GICyQL3CHMsQbYNvbBfWi61BrYKwCgI38BYL5tUJcxo=;
        b=c2laX9EsfDlEy9IyxWAM0POzJQmH4oWE4jvsrpWHBQRTU+Xkqs9SdmUSjjdJxsUJJM
         h+GhTr5oyp7d/Eg62uM7Vkx++rzYTWifTZSdt/tf9TlXvUFQ4Yw6uKh8Nm3XMJrsk+N8
         wwjCCVbhYGRLajxsrCpo+OmHcRfYK6EF/cnuvZOHj8S5htZ5bkw2Vdxc630ACthmXPqH
         FkICRNlcgwE72pD+ZL3UO80yOUcuW3zxNtu5H2TIBusF5k9XkFqN0y+aKSUOnJykBKoX
         +OWDvuTlax5aFLdA5Rsj/OdIjEC4o1DGO8dt8xwNvIuuxnObxZSNActVWYv+zVjj1XPd
         IJjg==
X-Forwarded-Encrypted: i=1; AJvYcCUIjFHd56li5SqeSacZ1K34htVEdasVKDb9RZkXhKCsPnbUUEWg1PxxYD8UivZkkMAOGZYOi1oQVA==@vger.kernel.org
X-Gm-Message-State: AOJu0YxHWabyMcbDYsgIBKXQb0Kqn3/5k6RcZacNhu51KYazBkGJppqm
	OEitjDKkKfE+xikrvNY0ceZ9NoyhDgoUr1kdhdgUy3u9npwq/9PcUs5eeYJzxUHeMU9aOrdkEqw
	YJt2dGz1Iy7LlcJHaYBpB+2T8NiQpio6cS9yWMss39ZPM7CGSGWhiqOyNJohRCQ==
X-Gm-Gg: ASbGncv4FmGqMyDQeQmuUwq+VEVQ/6mXzpRZw2/iHL066yITZtxFNezCMBuUVSdWPhA
	eA1zKATYcPcd32ByiUsLsseg1ozDWlwDy8vKmt5gaRXApjEHz6VpNQn4lNFVBIp3G7Xz2wsh5vz
	mWqHYfgXt0dqPQtDyt6N6GPphoaieYMxD/ssF6ZzTqyXnY9U4cacziDeIy2c5S+zvgeY8zKSR1f
	vVjjRWIcXu7mtsxaX8QUXPt3hHmXo7aftXzyS7lOQt8z+3NVQBCPVmc9ZiWdvEhiCdl0O8UNUeT
	ZagmwuVN5bQkey0jw3/J7VmokttMvDNewvdO6U33LTdErCaik1tqHF7EmtxHPp9wd8MSlxdG3yy
	wb9680qJVs1OtxP2ee4j15w==
X-Received: by 2002:a05:622a:1ba9:b0:4b5:f68b:86a0 with SMTP id d75a77b69052e-4b77d06cb12mr133428411cf.5.1758031040127;
        Tue, 16 Sep 2025 06:57:20 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEx/IVvun0KQAKtNqHCv75Rapju/SmJgazDgix/mPxZhD+7Qis2vnTHkkgiNCjklXyICvOOjw==
X-Received: by 2002:a05:622a:1ba9:b0:4b5:f68b:86a0 with SMTP id d75a77b69052e-4b77d06cb12mr133428091cf.5.1758031039594;
        Tue, 16 Sep 2025 06:57:19 -0700 (PDT)
Received: from [192.168.149.223] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b07b32ddf93sm1149921166b.69.2025.09.16.06.57.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 16 Sep 2025 06:57:19 -0700 (PDT)
Message-ID: <4d83b7af-ec45-43c6-aac4-148580a81924@oss.qualcomm.com>
Date: Tue, 16 Sep 2025 15:57:16 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 3/8] power: supply: qcom_battmgr: Add resistance power
 supply property
To: Konstantin Ryabitsev <konstantin@linuxfoundation.org>
Cc: Fenglin Wu <fenglin.wu@oss.qualcomm.com>,
        Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
        Sebastian Reichel <sre@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
        Subbaraman Narayanamurthy <subbaraman.narayanamurthy@oss.qualcomm.com>,
        David Collins <david.collins@oss.qualcomm.com>,
        =?UTF-8?Q?Gy=C3=B6rgy_Kurucz?= <me@kuruczgy.com>,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, kernel@oss.qualcomm.com,
        devicetree@vger.kernel.org, linux-usb@vger.kernel.org,
        Neil Armstrong <neil.armstrong@linaro.org>
References: <20250915-qcom_battmgr_update-v4-0-6f6464a41afe@oss.qualcomm.com>
 <20250915-qcom_battmgr_update-v4-3-6f6464a41afe@oss.qualcomm.com>
 <gk2ho7ugp35kb4x65meqsm3aufnry6srr4p7jspf6xyn7ywzkh@vd5ca7txjdk6>
 <0cf4b0fd-e468-4aab-9ec2-38da93435557@oss.qualcomm.com>
 <5736df73-c90e-4f11-b461-c38da4e811e1@oss.qualcomm.com>
 <20250916-almond-pelican-from-vega-a8d01d@lemur>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20250916-almond-pelican-from-vega-a8d01d@lemur>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTEzMDAxOSBTYWx0ZWRfX5LSvPDutxKom
 WaJ9hXTweNuOSrlQtmFrpZ/4IOgyq4Udckhl1wdWY/pSFgJOY0DiEkUnr6/B85N6kOdEap1YTbA
 xJp87JcOpa8hoiv3eECffxVJ8zfzaZ1UdIQ1u1YBFYJU3RpWGCeYa9cNkLk0jnBk31hkwOiPk06
 njRow56MBwgScXgwE3ydZ8I2xMNbaw2thIzHjwNMP0TrxJzku/jdCcGQVacMVnJi9TGEzRAKwAV
 OZAEXww3gMuEEwffgMe6Vr4phZABypx9Ph5Oh5Jr6HkIPtPCFGLpDNSddkCk8PXYQODXMGOrIx3
 KUieJzAFeVxYMg0oqS1+W+RzFVwqxbaWR1aFL3Y7eJAjPIqBbs/oPziydNYxrnkm4yQ7OgDbL5c
 iVfSFmba
X-Authority-Analysis: v=2.4 cv=cdTSrmDM c=1 sm=1 tr=0 ts=68c96cc1 cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=-oxkEHOTVg5AFfsLEusA:9
 a=QEXdDO2ut3YA:10 a=dawVfQjAaf238kedN5IG:22
X-Proofpoint-ORIG-GUID: LCG9xu8EpnC0jDpuiZyk6vzHw11kGTBQ
X-Proofpoint-GUID: LCG9xu8EpnC0jDpuiZyk6vzHw11kGTBQ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-16_02,2025-09-12_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 phishscore=0 priorityscore=1501 adultscore=0 suspectscore=0
 bulkscore=0 impostorscore=0 spamscore=0 malwarescore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2509130019

On 9/16/25 3:37 PM, Konstantin Ryabitsev wrote:
> On Tue, Sep 16, 2025 at 09:59:04AM +0200, Konrad Dybcio wrote:
>> + Konstantin
>>
>> It's quite common to see someone leaving a T-b on the cover letter,
>> trying to say "I gave this series a spin" and then seeing the tag
>> appear on unrelated commits within the series (e.g. bindings or some
>> cosmetic fixes". Maybe some sort of an interactive (opt-in is fine)
>> dialog for "which patches to apply t-b/tags to" could be worth the
>> effort?
> 
> The plan is to add interactive mode to a few commands, including to the
> trailers command. This will open an interface similar to interactive rebase,
> where you can mark trailers as accept, skip, or ignore. That should do what
> you're asking for, I believe.

That is amazing to hear, thank you

Konrad

