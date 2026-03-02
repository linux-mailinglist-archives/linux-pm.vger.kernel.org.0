Return-Path: <linux-pm+bounces-43392-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KAFZAKlmpWmx+wUAu9opvQ
	(envelope-from <linux-pm+bounces-43392-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Mon, 02 Mar 2026 11:30:01 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 6EF591D685A
	for <lists+linux-pm@lfdr.de>; Mon, 02 Mar 2026 11:30:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id A09D830B46AC
	for <lists+linux-pm@lfdr.de>; Mon,  2 Mar 2026 10:21:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70DD5375AD2;
	Mon,  2 Mar 2026 10:20:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="YKxgqBwL";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="EfI+dQCT"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48AC939A81C
	for <linux-pm@vger.kernel.org>; Mon,  2 Mar 2026 10:20:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772446829; cv=none; b=YSxR2AfnMKwAFw97DimFyY8vUjkR7XY9bNQnsmI72S47tJMqdbIxupUuIqSH5nX/4McWVnfeVdZmgMzNvCUyBIJSxedwuJ+W+Kc6WHISRKyUcSK4D0KlmILKm95EVtKc1lwnz9sGRXRCztwLqj1n2FIblFqXgEi/F42YitfhZBY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772446829; c=relaxed/simple;
	bh=CSwsYOD6drWBC+BpkO5jzAuz+Ok5L6cqTE/xt/LghKs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ffKCrtKd1ciYUFimMm78sO6hdlB8oN30fu7E/kP8ZCGaqDxPD6Z/znLJZ/5/TTzPBSPbD/+1enNuZbP6CVSsrIeq/KMxXxHpQGuC57zRNob7P/7S2w9iobFV/2KY+jgROY0HTGpgDCTzA2T4TUY3o4y4H372le8d7207sYY51kE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=YKxgqBwL; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=EfI+dQCT; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62285X8o662201
	for <linux-pm@vger.kernel.org>; Mon, 2 Mar 2026 10:20:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	aDm37Yksdkf6+5HA//0dYI0M1pVt85JYFuBsUovDM5Q=; b=YKxgqBwLq2xVnD80
	lFN1CVM0u+nyL27CQY4fVm8p/4W1dnw/SNo8KfgEhhgZA8UIhCNsm34iU6+TWaMc
	dDemMH3DbzpHa/1vkLtpOZkD2nlXEyy2HdAXZrlEpP3T0YxXpG7IObzwHeWWk/Ru
	BlQovogq8T8nqLdvHA4Kiz6eXlVfZNOyBcPKTILb6h1pvkA8Hw7J8Meg9mCjck3H
	mxv/qCaKlftje9sgWYet2P21l1RUPE5wo8ogpA83A9PtkAarwaVxOTKqyOXCdTJ2
	E0Pu2NURCjUscpIDGWEJ7TnO8iov4d6I6RG17ZE7rOzHt/Aj2/thECsN/QI8Xtgq
	4Qhs3A==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com [209.85.222.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4cn6r2rjj6-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Mon, 02 Mar 2026 10:20:27 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-8cb38346fdbso416983385a.0
        for <linux-pm@vger.kernel.org>; Mon, 02 Mar 2026 02:20:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1772446826; x=1773051626; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=aDm37Yksdkf6+5HA//0dYI0M1pVt85JYFuBsUovDM5Q=;
        b=EfI+dQCTq48K0WyPV6u4Z9Jqt4ivJLk700KJ2qL76vDViu+325HWwKKEvICIfjT2xE
         sR7ffpiLObmdy5F0Fyh2njyA2NmRBoHUXaRZQTjI9D2bTfN2EnzHdF9v4GRgl0spzcov
         cXYk8pQatvupn0BKKxU+06iOI4vxuCyc2LNOOmCOS8hjUYueZVu9VaY8WCKg3IZ1kXfE
         FkmJzjBLNUL3jjLltEtxNID1kwU/DTaEIIf65WGTQJX0LttRq86uTe4tbUvhBa5sQXwN
         IZtH9a4fmvQbKf9H8Hy6YgrkNyaUjIT0NmlSAt/RSwwSAoDjwbFF2+2Qt4hgjvtojH1q
         61Kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772446826; x=1773051626;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=aDm37Yksdkf6+5HA//0dYI0M1pVt85JYFuBsUovDM5Q=;
        b=Awa7nTpftKC6As+1dGydEUD4jIHvu7dASlWLj2hxspmSR+o8MEqdknThlzyPrrzdDO
         eMA/kIsrBlJ0VhCMBui/976DtMo8JHk/aTUiw0Pe+Y5oNIOs/WGm6xdljOpzNcjpONEo
         E6yLDVz0w8fv44mlH8I935YcNU+ciJap19vi0xgNhsTpDEBS0s5+b0a6Frriz7OnrQu/
         n2W5rfsfGoKUj1OI33e8so1zIBnm/HknA8Aj95R1VTYLuSLDCcHYCY1agRQfu6etrQx/
         f0SIr5PFFsy5udxKEs31wbNLK04yyVPOtLXXwa39SnIb39W8O7OOeHAgu2fo3LctfRHi
         f3DQ==
X-Forwarded-Encrypted: i=1; AJvYcCXI5yfDCUkLHZAMRZs+NUylXQhqSHX77SnaNgCixnKXkDCt1e66Aak/XNK4kEdIa82yD6LYwRyeEA==@vger.kernel.org
X-Gm-Message-State: AOJu0YxTZA69rhXZvNxuu5ddGJe5h6jy0enf8BPQsiUohgoRTOK5uE14
	tTGD3QRTA6qQx1XjUEUW07ABzz5uElhcyF4Hb/c6yGZW9PODxf98t8+nSJXoNfm4qsMiuczJpdJ
	ytMfmiJ582fkMRNrZ1uuK9hmLmfooJ2lE0hZnlj7aJ8uB1tTi3W+NlDrICvVaXA==
X-Gm-Gg: ATEYQzz1uCo/BO+LGafdX+j4MOxsEBxyuAgWbmfrgAFAlwW9jDrIfjUYl84P/5XsWBI
	Mm6XygGuA+x2jIKvH1324UH4fhSOFOw/Edg8I2tLxcx5RcDRYm4L2SSym7szs9QWRacvyFgLXs/
	y0lZDRDL7lVtPvri8PwMjBrcDW8lG1ewNBf/s2c8vuplzEsVEjMGDOD2kDBZ7JZPz0gUS4iHE/4
	+H+6wHNheVap7/E/e6WUOK4WFK5z+q+Pqs/Zjj0g4fl/ewkA5sMxRHGCj+wAXz6QyjY6UKhgk/B
	G3Gv4O/nXaQFtmrTDn3r0FcjNDhq9TfktxBa+mObbkqpWCE0mBinLuv7AVTUAR0l9ICurC54xKk
	9P6b88vAY0r6CiYN2MhGq6ZfIi6VFBlUBuB3rMNzAc+jv0OVmhTfXEu1GrFbZKKheH7bOE8xbh7
	hGNr0=
X-Received: by 2002:a05:620a:4628:b0:8c6:a719:d16f with SMTP id af79cd13be357-8cbc8e7c8e4mr1131129585a.4.1772446826533;
        Mon, 02 Mar 2026 02:20:26 -0800 (PST)
X-Received: by 2002:a05:620a:4628:b0:8c6:a719:d16f with SMTP id af79cd13be357-8cbc8e7c8e4mr1131127385a.4.1772446826043;
        Mon, 02 Mar 2026 02:20:26 -0800 (PST)
Received: from [192.168.119.254] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b935ae613ddsm453210766b.33.2026.03.02.02.20.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 02 Mar 2026 02:20:25 -0800 (PST)
Message-ID: <6a304d0d-61b1-422f-bb65-8f8055095c39@oss.qualcomm.com>
Date: Mon, 2 Mar 2026 11:20:23 +0100
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/2] dt-bindings: power: reset: qcom-pon: Add new
 compatible PMM8654AU
To: Krzysztof Kozlowski <krzk@kernel.org>,
        Rakesh Kota <rakesh.kota@oss.qualcomm.com>
Cc: Sebastian Reichel <sre@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>, Vinod Koul <vkoul@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org,
        Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
References: <20260227-b4-add_pwrkey_and_resin-v3-0-61c5bb2cdda9@oss.qualcomm.com>
 <20260227-b4-add_pwrkey_and_resin-v3-1-61c5bb2cdda9@oss.qualcomm.com>
 <20260228-polite-swine-of-potency-56e61a@quoll>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20260228-polite-swine-of-potency-56e61a@quoll>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: hFUKZbJ_6s2iuyWnaZn2RdcoLreLwO6H
X-Proofpoint-ORIG-GUID: hFUKZbJ_6s2iuyWnaZn2RdcoLreLwO6H
X-Authority-Analysis: v=2.4 cv=Hpp72kTS c=1 sm=1 tr=0 ts=69a5646b cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=3-tsFgwzAueeEB3SUXoA:9 a=QEXdDO2ut3YA:10 a=PEH46H7Ffwr30OY-TuGO:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzAyMDA4NSBTYWx0ZWRfX94MvQIbA2CCM
 +hn6rmjoH0oxwUZC/7rjuNhDqYk09zwelspZjnQk4sRSPmO9ebHdMkpOjfk4UrVpUSjpLKr1ISH
 ikBTX6UNo7aSaK+xlVtBtgdyM9DyJ72u1swQckcXsfr4vFwobFkX50z6HxnRZwWyQTptfqD/I42
 hM31t9UQ8CX7StT4mRrjUygD3okXQgVBihqH87gK5IqG94uECP1Dqsswr1uBpfH2a6NOVY5g3pY
 679pHJnQhbNDqSq+tFxf6N6CaFUypbP5P3hJZaMbCKCeKSfGNWlhRl+25ZBZcuXM7fqw3bTWQPD
 0FIu0bvM2UF3N7UG+8coLRwxRi0I41Sym4HCOhswC0mVmSdblKz365Vb2vFNGYR9GkBQE3T3cVJ
 0B3r+/Glxq/RGuMaqDkk7LLkIQ66Yku5kwQYcP5oiSNOtbYz5YIUEkNCwJ2d8O57UlVeTwY1ozz
 DWpgeTnBt7hv+IyIr9g==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-02_02,2026-02-27_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 suspectscore=0 impostorscore=0 phishscore=0
 priorityscore=1501 adultscore=0 bulkscore=0 malwarescore=0 clxscore=1015
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2602130000
 definitions=main-2603020085
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[14];
	TAGGED_FROM(0.00)[bounces-43392-lists,linux-pm=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[oss.qualcomm.com:mid,oss.qualcomm.com:dkim,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,qualcomm.com:dkim];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[konrad.dybcio@oss.qualcomm.com,linux-pm@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-pm,dt];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 6EF591D685A
X-Rspamd-Action: no action

On 2/28/26 11:17 AM, Krzysztof Kozlowski wrote:
> On Fri, Feb 27, 2026 at 06:02:28PM +0530, Rakesh Kota wrote:
>> PMM8654AU is a different PMIC from PMM8650AU, even though both share
>> the same PMIC subtype. Add PON compatible string for PMM8654AU PMIC
>> variant.
>>
>> The PMM8654AU PON block is compatible with the PMK8350 PON
>> implementation, but PMM8654AU also implements additional PON registers
> 
> So does that mean that PMM8654AU has 2 address spaces and PMK8350 has
> only one? At least it looks, so I expect fixing the last if:then: - you
> need to drop contains from PMK8350 if clause and add new if:then: for
> PMM8654AU.

The delta between them is such that within the already-described reg
ranges, there is some additional bits and/or registers (can't remember
but it doesn't matter for this point)

This doesn't impact the described size, as all QC PMIC peripherals are
by design allocated 0x100-wide windows

Konrad

> 
> Although the binding says "pbs" and here you say "PON".
> 
> 
>> beyond the baseline. Use the PMM8654AU naming to match the compatible
>> string already present in the upstream pinctrl-spmi-gpio driver, keeping
>> device tree and kernel driver naming consistent.
> 
> And all this is partially confusing. This is reset/PON, not SPMI Pinctrl
> GPIO binding.
> 
> Best regards,
> Krzysztof
> 
> 

