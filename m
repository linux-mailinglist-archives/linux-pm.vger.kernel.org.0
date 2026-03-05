Return-Path: <linux-pm+bounces-43674-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MKA9BtdiqWmB6gAAu9opvQ
	(envelope-from <linux-pm+bounces-43674-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Thu, 05 Mar 2026 12:02:47 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 89F5B2103DD
	for <lists+linux-pm@lfdr.de>; Thu, 05 Mar 2026 12:02:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 483163013B76
	for <lists+linux-pm@lfdr.de>; Thu,  5 Mar 2026 10:57:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5258637F8B3;
	Thu,  5 Mar 2026 10:57:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Tw124HDZ";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="aI0DBvyE"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37E992ECD32
	for <linux-pm@vger.kernel.org>; Thu,  5 Mar 2026 10:57:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772708230; cv=none; b=Sbvm1PAWB4TKAOPBV6VTD6+GEwM2rKrTQLsn8XPPKQY53wiHUDxf6xvHLL02dMT638NuG2928EhMfBr5LWdFQqZ6UJcYm9kjBtRClhOuE62U10VY8pSKe6ZloKf9bTU60AYYToOP55e4gIZVpHILXVwD17S9XegfCbKsWIYQXXg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772708230; c=relaxed/simple;
	bh=WvhMDdJEqXsBieHTg4qjo45DhftgJst3gBgjhZUT0GY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=X3f7X4vqVOwAMQ85m3LjfZjMi74lSWorQCopbicmeaPAG5Ih822apq3ZmztxZkkhGQzpK9SYtYJDzWKJwGtvKQEODR0n8FR5nmqSXOXZFMb1Ev5RxsV/44d84rAPgfoZkn+fFI6MOwD/QU26k/Ur1VmJXU4nQsxDU7MNZdhRy2E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Tw124HDZ; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=aI0DBvyE; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 625AFn5D4171050
	for <linux-pm@vger.kernel.org>; Thu, 5 Mar 2026 10:57:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	BhLz5z0Vpfhm4H83owUtlVJk+BAJ6aTwTqUMB6W4aJ0=; b=Tw124HDZ5WZZ+WdD
	NkgiskmJRIVeVUyq0S97hI9IoGIjLrDmq1Hhi4ecL3vL/WXWTkhRn/V51ZU6zlJh
	Yc97hRqYllWyniyNoahXTp0sNtVwO/kcJa+GZxDvo/Slc1dyrYD/+AHtRohAWRSe
	bMQi6SuY1WVpwr9dp3huGaIEoi1dUhOmzbcIfx5yZdInx7koGA0kcarA43qXveFJ
	7xISEjxmNzS0ue2SlfraiB61t0eRl8bLRmgNOG5De0vvvtVVsJcuny4m3rasZevN
	EJgJwPxmQrmlnnzPABhDsiOWLsZVZCwIHN5KjTuTVlXgEoi+bcBUSq7sVx1Xnoe+
	Bp3TCQ==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com [209.85.222.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4cpuhb2f4w-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Thu, 05 Mar 2026 10:57:08 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-8cb456d53a5so616059785a.2
        for <linux-pm@vger.kernel.org>; Thu, 05 Mar 2026 02:57:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1772708227; x=1773313027; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=BhLz5z0Vpfhm4H83owUtlVJk+BAJ6aTwTqUMB6W4aJ0=;
        b=aI0DBvyEzXfRPpT+dgqND4iAUpqPQYojY67IEVPftWRPV/pCi4W2E50NHQY2/gWMvZ
         9xxTklcEfTKX5DYEIIObMVyXLi3ScV87F40ctGNc5DawCEsDrakt+94lgiGWKDogFgv+
         Vo4ga5g6gZQ1NP1UxTlK7AxtXuccbDEwfkz46V539gOBbNpISC+IJ88ChbVuUosntm1y
         HRI2EE85CJlSh0jahNI0FUjvu8aNw3JtIHvBNOFV+p03RZHHgbVWzGs+S59DLbjd8jMA
         XfcE9AtrGLsngu4a5lq8yZSlJ+1HNgnHVHAQO0x/nMMUg5kVVFETJ69akMGvKR4/UlM+
         hfeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772708227; x=1773313027;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BhLz5z0Vpfhm4H83owUtlVJk+BAJ6aTwTqUMB6W4aJ0=;
        b=XpNZQlTxgAbqSU3m2TOObfKZluHzDzGAmkBCt7namHxLUbfpRGCJivfpLmhnu5G3Fb
         OEFTegQ3Cb6WeaEZSThwlR4xBFfAUKjX6XueIXP/fDTTGnXScPCD8YW1CNK4ZstTLJlW
         6YI7133VtNi05C0XcVKmU7de9uXpQbd3cCM+P1Px3NccQ7bjw01eOw0USUebf2o2mnmn
         c3ZVddvQ/Wm01+eLIYdZRUC3glrWQqRqXKYllZZ/7AHN57C7vcT+CH//4DODfmQXuHHB
         BtfY1Pt9lzKdPjraEfjXmBWPf9HnuUeVUl4fnZPEseDokX36wmtFO4114V8qUGUvyypk
         owIw==
X-Forwarded-Encrypted: i=1; AJvYcCVkk8ndU9tgyZ3tZmiePTYozB+yan6R64g0J7mYg0ezclhjsgmPB5n378c482B2hlphPTmM1mOZXw==@vger.kernel.org
X-Gm-Message-State: AOJu0YxU7aqhK2KCNQSZBXD+RCE+u3jMHIOya5cB249hLRAILRY1i219
	hJwz/ojmdE+Ba1GU13SJQ5/DSWZCggrIIfgcsiakD+5WuONk1Vd+ZdyEuNkhQE815t7F8ZtmDAu
	+purKSz2EhZvEtI/BJNemOpm5r06XGK6gfCYYIu/Mv4HlLLW943lSTrPP55P7/A==
X-Gm-Gg: ATEYQzzru5xz7XLH4Fz8kqvxbRa9+38YG8sj4DaotG2ybWwpZbwbMBMAce+oRjpLaWd
	DyfecP25Hq9Q3Lb0VbtQGbpIjrAFlRLr9mSm6UyZ1oKuw+f/CnJyZx+Hm8YxPjdqyMyEByTx12H
	FgR7CC5ysDH0MwTfEmrlkOqeekfBVfIeeduos4WnX7Bb9lJ0VyrMDPxzGOWhNHS3cS76eh8nqQv
	nyNdCVDd4Y5Q5ppvyQcXCimPxMtyidjLjKhh5CaG5WrBTlxEQcc2L72pUSak//5MKuRJ2BaZ+Hw
	LB8rN//NDqf9XAYjNFLEyvJSVu8cmwO2DaLITB0XwQay2TXIE2+hU9z++f3NE6OZRRNjHDkpE21
	wLo2KdM9yiy1T0ltQ5hoJXiSZHkl/kbl2/Htc6b21Cyi+QDn8gqeGXdYDr091eQ/VeBsxNYUqmR
	B8h8w=
X-Received: by 2002:a05:620a:3f97:b0:8c6:a719:d16f with SMTP id af79cd13be357-8cd5af1e137mr550342785a.4.1772708227092;
        Thu, 05 Mar 2026 02:57:07 -0800 (PST)
X-Received: by 2002:a05:620a:3f97:b0:8c6:a719:d16f with SMTP id af79cd13be357-8cd5af1e137mr550339785a.4.1772708226576;
        Thu, 05 Mar 2026 02:57:06 -0800 (PST)
Received: from [192.168.119.254] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b94061b1426sm98165166b.2.2026.03.05.02.57.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 05 Mar 2026 02:57:05 -0800 (PST)
Message-ID: <686932a7-4070-4d6d-885b-a3dc57e3ecfd@oss.qualcomm.com>
Date: Thu, 5 Mar 2026 11:57:02 +0100
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v20 07/10] arm64: dts: qcom: qcm6490: Add psci
 reboot-modes
To: Shivendra Pratap <shivendra.pratap@oss.qualcomm.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>, Bjorn Andersson <andersson@kernel.org>,
        Sebastian Reichel <sre@kernel.org>, Rob Herring <robh@kernel.org>,
        Souvik Chakravarty <Souvik.Chakravarty@arm.com>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Andy Yan
 <andy.yan@rock-chips.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Conor Dooley <conor+dt@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        John Stultz
 <john.stultz@linaro.org>,
        Moritz Fischer <moritz.fischer@ettus.com>,
        Bartosz Golaszewski <brgl@kernel.org>,
        Sudeep Holla <sudeep.holla@kernel.org>
Cc: Florian Fainelli <florian.fainelli@broadcom.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
        Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>,
        Andre Draszik <andre.draszik@linaro.org>,
        Kathiravan Thirumoorthy <kathiravan.thirumoorthy@oss.qualcomm.com>,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, Srinivas Kandagatla <srini@kernel.org>
References: <20260304-arm-psci-system_reset2-vendor-reboots-v20-0-cf7d346b8372@oss.qualcomm.com>
 <20260304-arm-psci-system_reset2-vendor-reboots-v20-7-cf7d346b8372@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20260304-arm-psci-system_reset2-vendor-reboots-v20-7-cf7d346b8372@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzA1MDA4OCBTYWx0ZWRfXyVXE2DtsJOm7
 vKn38TWhPwF3G7TLYPW15b9gc6ufdOHONUUfndycyR54HQl63Vq3+gemQ1Y+zKuM1pPW8ZzWBkr
 6X6LDGfS5Bw2IDw4mycH/4fcYpQjzRO26c3kr9f801qr+5GMnWHIPSKdLJx2zkBn2JoMUxakBVv
 Cm9CQh5mMmuUSJnwCy7Ya8QXghOKjgJl9SxU0Yizb5x5mZDVDpfRgzy+Ylv8fiCZ6SI5K1nKwp5
 iF2/fIBxQk5x1Zca/6B/TU0LoZnuiYxDK+12fUCVRyWw6SB+uik+AT6N2SpFxIRVNka+BuL/gk9
 VCbJrcKRHO/oEDfmH/yKUpDL0mHVxiaLh8II+Tb943YbJfLkRcpj6quKKCc8MGUZ5bHW7KGx24a
 bIJolMu97UWUaNMmfpcRk//r6BmuxhK4NYBaYJPwxjn53K9oGAs9fZKPtgIjYybqQciQH+ez25l
 nsp+eFqHd15bofJ399w==
X-Proofpoint-GUID: 0AufMislKedgSS8bA6DJmmvv-fvOct6O
X-Authority-Analysis: v=2.4 cv=SqydKfO0 c=1 sm=1 tr=0 ts=69a96184 cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=EUspDBNiAAAA:8 a=4wuITOyn1pdjjq_Hru4A:9 a=QEXdDO2ut3YA:10
 a=PEH46H7Ffwr30OY-TuGO:22
X-Proofpoint-ORIG-GUID: 0AufMislKedgSS8bA6DJmmvv-fvOct6O
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-05_02,2026-03-04_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 lowpriorityscore=0 bulkscore=0 spamscore=0 suspectscore=0
 impostorscore=0 adultscore=0 clxscore=1015 phishscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2602130000 definitions=main-2603050088
X-Rspamd-Queue-Id: 89F5B2103DD
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-43674-lists,linux-pm=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[qualcomm.com:dkim,qualcomm.com:email,oss.qualcomm.com:dkim,oss.qualcomm.com:mid,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo];
	FREEMAIL_TO(0.00)[oss.qualcomm.com,kernel.org,arndb.de,arm.com,rock-chips.com,gmail.com,linaro.org,ettus.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[29];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[konrad.dybcio@oss.qualcomm.com,linux-pm@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-pm,dt];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Action: no action

On 3/4/26 7:03 PM, Shivendra Pratap wrote:
> Add PSCI SYSTEM_RESET2 reboot-modes for qcm6490-idp and qcs6490-rb3gen2
> for use by the psci_reboot_mode driver.
> The following modes are defined:
> - bootloader: reboot into fastboot mode for fastboot flashing.
> - edl: reboot into emergency download mode for image loading via
>   the Firehose protocol.
> 
> Support for these modes is firmware dependent and not available across
> all sc7280 based boards.
> 
> Signed-off-by: Shivendra Pratap <shivendra.pratap@oss.qualcomm.com>
> ---

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Konrad

