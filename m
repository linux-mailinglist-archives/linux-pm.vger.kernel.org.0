Return-Path: <linux-pm+bounces-43382-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6Oy9HP4FpWnwywUAu9opvQ
	(envelope-from <linux-pm+bounces-43382-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Mon, 02 Mar 2026 04:37:34 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 105501D2B4F
	for <lists+linux-pm@lfdr.de>; Mon, 02 Mar 2026 04:37:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id E6DE0301324D
	for <lists+linux-pm@lfdr.de>; Mon,  2 Mar 2026 03:37:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A68702D8379;
	Mon,  2 Mar 2026 03:37:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="KwBDcgwW";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="AczxR5P5"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19D561F4C8C
	for <linux-pm@vger.kernel.org>; Mon,  2 Mar 2026 03:37:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772422639; cv=none; b=P8/ovEsbTzaaPkM6pxJ2icCKP4isJlMC8PnDr9pYMnp0i38I11+8SIF0mBFcmQZK/fG2C5CHl+8IAJenPO+pLIgWNdynAYWv1vOUQ9wjwqDlRep9S3j0JVvuuUJWKivf8soDBResM3/CJqNbNUteOo6NNkYPocVw0fxyJBCIZK0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772422639; c=relaxed/simple;
	bh=Km0XZppyhKFAYHU7tnd3Tat2vlNPO2+dozqCa1t8EHw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rI99tW1BNfQ/r7Rpq7Ajn0nD2rxGYgbBaog0LrpMZxQGlajHKe2LfQH0vEQyXORGF7L+0xJfvchRTaPJqueQ2njB7Dk7TdA1r/NgbRW7IGZsGM/ZS4pq+WkoqG9bYNr0bBXToYQreX3Gb7JbWE4SOht8D7AxFaBlULa2svZlDPw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=KwBDcgwW; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=AczxR5P5; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 621NZrjE060653
	for <linux-pm@vger.kernel.org>; Mon, 2 Mar 2026 03:37:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=B4GTjokSFJILP32w/FE5dmq7
	r/adkdlDF7ttrd2vI7Y=; b=KwBDcgwWtkSrfLiezy5PG7TsRicJt8JPTRsNzXxm
	WwOPiPs5ZMXDJlXMPpSPgKumbxCtEcmracbebzsgdqRfelOKe1idx8yaL3j719ly
	uoUDuDIu9KDM3bgz1t71sveVXKziNFGoEhe20wTiYRdhPM2IR1G/yUEDjJ0VQgFo
	7rlj/Og9Xi4oshwmeK4+4IjyduY4iFHPWyyznrFyZAUnJDx9XRyChoU7CyOQFg1y
	Vl/L9oMz7xd5kjN2IImDpcGgCn0lD9bUcPddFj5m7dFTvhyLxZFRtRGbZqDvTvfJ
	k+/Kdw3lKW9ovFRaqujlXLZ00O8DR+M1PFKjOb7UAeoLxA==
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com [209.85.219.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4cksf6ks42-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Mon, 02 Mar 2026 03:37:15 +0000 (GMT)
Received: by mail-qv1-f70.google.com with SMTP id 6a1803df08f44-899f619264fso62442566d6.0
        for <linux-pm@vger.kernel.org>; Sun, 01 Mar 2026 19:37:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1772422635; x=1773027435; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=B4GTjokSFJILP32w/FE5dmq7r/adkdlDF7ttrd2vI7Y=;
        b=AczxR5P57jBnuvD8Mh5zRuOglzacWPeM0qRIozKzUX1xDm6XVKlxzTjqKcys+5wv6N
         N3UBioZeP9mx61Tsx1dU3Y+bYPzarxvl1COld50DY4QTtLR3DJcyj+49czBaNVurdChm
         Qc3p+QuCRqLITQ2MoTC3Nh7XyTKSwYYnpx3lMmgBdJN6fQEV0ZAGH3PBaZtBVjG/1uNk
         0DwVP9WyCwcihO6cTj0VDRSTdwIrhOVdZih0wCpvE5cvCdzHyi33BP8lAqqtsdRfuMdM
         ArArvRwjLUyln0Alrlt3SZg1Bi6CfEUUKAHpFrYIRgr49TFiM7AWpixaZ0PneIvSsCnq
         jrNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772422635; x=1773027435;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=B4GTjokSFJILP32w/FE5dmq7r/adkdlDF7ttrd2vI7Y=;
        b=iZQuNcxTR7d/FuwDbDXWECBjT4qrbi8A3bmw01cHb5N2jwM8an1zpxoBp4DSr0BRjS
         MTLgd78NmQXlu7/PI6jstrVANgszhya7jB3p84f+ycvdQ+lj0DfSTagFL+Y8kIcGN8XW
         5WvOml5IbocRl/x7atGmgEpCWi3DOj6Ve7mfM7niUyDeh5wNCJKLVBs/efYKeWXmGmQQ
         eD+KVF8MfjRdD7ZjYR09hVScaejZseiEfe2O1b4y7PMCXRUFfD7fP8BiPq5eElhREM+x
         kzHMXs2DDC/rA7qTcPipzxVEgA8LKP8qnvndkbGVCZ82Kw0eH4SbLUILrjFo5h66mqTc
         ZkEA==
X-Forwarded-Encrypted: i=1; AJvYcCXW99Jp1CGxGwPZJOMSvSyaHUpQM+7hfcdpAYZu1t8lMoMLHVQSKjsX+or23roSxjPLbkWK00Rvdw==@vger.kernel.org
X-Gm-Message-State: AOJu0YzZq75WEV+0xwbfU79K+7WhCyUf2pLZKnPeg7Q7aqe3qxz+AqAz
	lr0ScxhZxehqf7xVSsESZQjdM6X0sImKr8KvU8FDASG6/29UxeAHvUs0qINNYv1V/hA0bySRia9
	vVK7rrW3mdKpcY7FSH5UgZEbk20RY2h6L6Lng6b7zNemAIauzPO/D95fXJWcT5A==
X-Gm-Gg: ATEYQzwS0G64NIUzHbI94HmkqO3JoxYnbaWalduvAe7eKC1uhanbzbGbfmGZxP2kpYD
	2qBsIt64hsLELUwXzN4cipAURVS0OY2jQC8cgSTZ09WS7ysuUOPvJ6msdwbOHBnGB4X4PucXFHc
	5B99uuF++7lNatR1mit/5356dVE6YjAdHABBW4LXzueEG9aHusqjkr66cDc12BQ+Zz2ljYXFgrV
	Z7NgDEMLaMBZMvJzjEz4mTikEjV7rX1TwicdvmVM8W6XwdGg3Vg2usdtny7upizHbZnIb2Iq8VY
	GXWSZGwHQMJ8J0ddK1PWB9M/ASJbrg+CCkVDIcDZRM7xk/eU6OEBvj0ZofjqsMbet7YnIjZtyfB
	Bu1L7hLQnOtUKVpm/8aSILJCm0mh2CjwvV0lVg1nD48kGsFXnVfOSLJtM3xV6vauNL4keRcD7Ge
	6bteaPwfWcWeK4REPI/aBCFzSXfezgy17gUIE=
X-Received: by 2002:a05:620a:d85:b0:8cb:43a3:8b6f with SMTP id af79cd13be357-8cbc8e1afe4mr1234202985a.67.1772422635305;
        Sun, 01 Mar 2026 19:37:15 -0800 (PST)
X-Received: by 2002:a05:620a:d85:b0:8cb:43a3:8b6f with SMTP id af79cd13be357-8cbc8e1afe4mr1234201885a.67.1772422634805;
        Sun, 01 Mar 2026 19:37:14 -0800 (PST)
Received: from umbar.lan (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5a115bd5a7csm1350913e87.37.2026.03.01.19.37.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Mar 2026 19:37:14 -0800 (PST)
Date: Mon, 2 Mar 2026 05:37:12 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Wei Deng <wei.deng@oss.qualcomm.com>
Cc: Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bartosz Golaszewski <brgl@kernel.org>,
        Marcel Holtmann <marcel@holtmann.org>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-bluetooth@vger.kernel.org,
        linux-pm@vger.kernel.org, cheng.jiang@oss.qualcomm.com,
        shuai.zhang@oss.qualcomm.com,
        Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Subject: Re: [PATCH V4] arm64: dts: qcom: qcs8300-ride: Enable Bluetooth
 support
Message-ID: <muqlhuorantvzml5xx6vrsoe4ufxlwtd2yhyxnbyaye2c5iqwt@ucitw425ghtz>
References: <20260302024658.2836798-1-wei.deng@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260302024658.2836798-1-wei.deng@oss.qualcomm.com>
X-Proofpoint-ORIG-GUID: EHsF8SZJGj_4Zy5lss1KBSpFFKnFZbUK
X-Authority-Analysis: v=2.4 cv=JoL8bc4C c=1 sm=1 tr=0 ts=69a505eb cx=c_pps
 a=oc9J++0uMp73DTRD5QyR2A==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22 a=EUspDBNiAAAA:8
 a=dDEM-9S5bOE7Kyg1U10A:9 a=CjuIK1q_8ugA:10 a=iYH6xdkBrDN1Jqds4HTS:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzAyMDAyOSBTYWx0ZWRfXyUZyJBw6sssR
 xUr+jXUe3cx6yTsWPcfFrq8FTuCXE6ND1yB7cD1Gyb5jZ+r67dlf1E6VTJxNH13petjD+oHpU03
 xUHUDQB+R7ZEaVIdSMRph7G2Dz6Oro3NuTjszofykFUHwd0adVpbsplgJaxmXbwUfdcBHjOrctC
 iDmngvA6i3vzmzIGKOfwFiF+vueLKRdNXbmRzC6nfaL+/YOegter5EUvX7p4dF90a9iNpuiouCm
 QEYqIaJF7l4md/ItNPQkJ0MwDtjz9xDr6krjynwfn8YY3AzY2FwH/vqPojC945+WfLcUdmCG0si
 XwTgvu8rJkWFcX+c3hFnLzKggrjIyeNjTD7QMxUcO7x5ZZXE415GlY3PT3Fld+qA+q07GXOhYAH
 xGC7d5EJcP/ZVPV0j0dVCYTVHeL9cVNuhm5MI8l/i4j+iWB10OvhWxkeFc4HWeCH5hQxwXdurCF
 /MW02lh5IpVjBW15Gtw==
X-Proofpoint-GUID: EHsF8SZJGj_4Zy5lss1KBSpFFKnFZbUK
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-02_01,2026-02-27_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 suspectscore=0 malwarescore=0 priorityscore=1501
 adultscore=0 bulkscore=0 clxscore=1015 impostorscore=0 spamscore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2602130000
 definitions=main-2603020029
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-43382-lists,linux-pm=lfdr.de];
	FREEMAIL_CC(0.00)[kernel.org,holtmann.org,gmail.com,vger.kernel.org,oss.qualcomm.com];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[oss.qualcomm.com:dkim,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[17];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dmitry.baryshkov@oss.qualcomm.com,linux-pm@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.996];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-pm,dt];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 105501D2B4F
X-Rspamd-Action: no action

On Mon, Mar 02, 2026 at 08:16:58AM +0530, Wei Deng wrote:
> Enable BT on qcs8300-ride by adding a BT device tree node.
> 
> Since the platform uses the QCA6698 Bluetooth chip. While
> the QCA6698 shares the same IP core as the WCN6855, it has
> different RF components and RAM sizes, requiring new firmware
> files. Use the firmware-name property to specify the NVM and
> rampatch firmware to load.
> 
> Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
> Signed-off-by: Wei Deng <wei.deng@oss.qualcomm.com>

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>


-- 
With best wishes
Dmitry

