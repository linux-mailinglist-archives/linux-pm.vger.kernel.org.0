Return-Path: <linux-pm+bounces-31740-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 47008B17E47
	for <lists+linux-pm@lfdr.de>; Fri,  1 Aug 2025 10:28:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 101A91C8006E
	for <lists+linux-pm@lfdr.de>; Fri,  1 Aug 2025 08:28:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D84F21B9DB;
	Fri,  1 Aug 2025 08:28:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="BxIVFVQu"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BBCC2147EF
	for <linux-pm@vger.kernel.org>; Fri,  1 Aug 2025 08:28:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754036892; cv=none; b=KuEyom5GGRs+vuuvspHpWuypI2V19YSVnN7/PgkoSODJajN5sTPsLpQjxx7kkqCIAuLZax7MTHnGKhm+rwf7hsw0+1Pt99W3mfX4fm9d0JyNlLDqmhyky8Izd9dbFHcN5yz3yaMH4u2k2YyZfPzYRbUVg9dGux1IbSdiJ8Mx2Xk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754036892; c=relaxed/simple;
	bh=n21FYt0R2MUIO2Qf1PzQwL42JjC+OUvtksC+UTS2eYo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UDg2otNuOk8I6u5QNkelVN2EGsVVcnlOjd1vkm9QedhxK8Ju0KTBXbstkdrLWl6aaB761PJScRB1DY9NFadhpFyuBafZ104loj+hY50P540lX2EZY0ZIdkhSA2dk7YjCGB8P3B2rwI5dNsm4jctmbq0fex69s37J8kxoLstTNco=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=BxIVFVQu; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 571116wb018848
	for <linux-pm@vger.kernel.org>; Fri, 1 Aug 2025 08:28:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	maSw2CmMyXYMAvKmdoOc+yYzrI3pcEaJZUjifnEuM/o=; b=BxIVFVQuqV0jyujy
	yHXB+wfkRrSKT9aqMVbG1hqlQELgHhIU31sT9BQBmkigZh8NjIwCOHnODCmxojIY
	Gfy2ZJPhYzSTY3CRBhu9ZbavBhYXZa8QcaqBE2pfcfjfvgbUePgFM1I7cMpPt1tw
	zytn4BNQ6goS4nTh1UZ0W7CrGekoKs8dbm2Ch9fQsgIC90gKTCj4Wb5MSSuoD0+N
	tKHXl/Q7dpaHp5IFWzq8rcv1U33Pd4/W81yOWNiH/bK3MvUH8eYdkxmVDr9ltYfM
	nULozSQZwOj6UluFGaBsoZrYYqmNp21Th9zb9KOAUvMs3iCZtXgoaSZZyNGoaZxz
	r9WgIQ==
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com [209.85.215.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 484qdaaxgj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Fri, 01 Aug 2025 08:28:09 +0000 (GMT)
Received: by mail-pg1-f198.google.com with SMTP id 41be03b00d2f7-b38d8ee46a5so1753612a12.1
        for <linux-pm@vger.kernel.org>; Fri, 01 Aug 2025 01:28:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754036888; x=1754641688;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=maSw2CmMyXYMAvKmdoOc+yYzrI3pcEaJZUjifnEuM/o=;
        b=dWLtCCBTfnkDZ7xDXVjL41rk61Tke12wx47BZtA/20xLs8EgH5QBkUtKZHO/OS+bS1
         /qxX5/b7p9puVlBDWAfYhbR4Di+2j6f//mQCBt2KFVbF2ni7iBHsnKlFREjnMqTXDSMe
         BtjYFrc5y6/J1pwJlbfc7P+18RxXHbs/UyMrHiR0P/n5NyHYy+ZMeqiqJ+JWeX1vHKBi
         aHHQZSjN1HLNEaM8iTHRmTaYMsXmCIu/UCVET96943T6KL43lnFnNd2fTHNi+++fqOZx
         QDSvwIHoYtMe5gWF/futDxv/zm9tJ/41W599TQRbPzdIJ7DBJVyhPO42nqzsQ2koWqte
         j6Ig==
X-Forwarded-Encrypted: i=1; AJvYcCUq8H/74aMzMNwiLZ4O73sYwBh95BsX+Qjvj6eWGDOPRh9WZ0oQ7Y20be5i/Y6a7gCSvmJi8F9m+Q==@vger.kernel.org
X-Gm-Message-State: AOJu0YxbpZv0z4Y89R2Q/bx2Lti5abDk8VjVT8yms1OyrttbHEGr9pR6
	PwPdixnqPEZgMnAUTDohk+AQP3Ko0zrtZ+eJ+DNvAB2qoaqkK0/qqEEljcY2gmLT7YXz9hagHnR
	Az9i+4cqg/uTjYNX7i1sTHraupp9mxbGyGKJykgqZvSfi/hmjeVbkni3Sl/9YHA==
X-Gm-Gg: ASbGncsh42yzvC8ztJCUAOgY93oujdYqDD6CAescY3pLM6N1ZaxpR2U2tU46aLzpoOJ
	OqYea8KCtIygHn+lwcReSDbGHTearqDDGz6ftSZ3kUWNgMY4o2nxOmTOzVqlMw/pZQgD+AIdP8v
	TYTu1ws0rrghGA3jcO8lGCiHunVEEcDnrxVBMhNsJMGV/B3mrMnjRt7mFLp/IYpjceKXAobin++
	vMwWy7HlhySpMb+smzDjuN9osWdWwKZhxZUlxFvA/sT8D9leHwCxXVfru4ArJWM7L9PqOIJQMbE
	mOfDzv2pjCk/9hGNh077wApBpMWJ/lT6hv/DXNHhwu78gS4XllMl5wAWl7dSHUA2dzMru2fusA=
	=
X-Received: by 2002:a17:903:283:b0:231:c3c1:babb with SMTP id d9443c01a7336-24200b0f9f0mr71691855ad.18.1754036888073;
        Fri, 01 Aug 2025 01:28:08 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFXzVMpoNTOUr+QJdVXJ84SNHSBTQYxIJbq36BDLV4wmlovxf8sqtvX2B9vl9qw1lN1AHJg7w==
X-Received: by 2002:a17:903:283:b0:231:c3c1:babb with SMTP id d9443c01a7336-24200b0f9f0mr71691545ad.18.1754036887597;
        Fri, 01 Aug 2025 01:28:07 -0700 (PDT)
Received: from [10.218.42.132] ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-241e89a3acfsm37009225ad.146.2025.08.01.01.28.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 01 Aug 2025 01:28:07 -0700 (PDT)
Message-ID: <7bac637b-9483-4341-91c0-e31d5c2f0ea3@oss.qualcomm.com>
Date: Fri, 1 Aug 2025 13:58:00 +0530
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/3] opp: Add bw_factor support to adjust bandwidth
 dynamically
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
        Stephen Boyd <sboyd@kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
        Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org
References: <20250717-opp_pcie-v1-0-dde6f452571b@oss.qualcomm.com>
 <0dfe9025-de00-4ec2-b6ca-5ef8d9414301@oss.qualcomm.com>
 <20250801072845.ppxka4ry4dtn6j3m@vireshk-i7>
Content-Language: en-US
From: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
In-Reply-To: <20250801072845.ppxka4ry4dtn6j3m@vireshk-i7>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: pYrRMxDIRHX5f4pjTfA2ddn_XmF9meN9
X-Authority-Analysis: v=2.4 cv=Pfv/hjhd c=1 sm=1 tr=0 ts=688c7a99 cx=c_pps
 a=Qgeoaf8Lrialg5Z894R3/Q==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=2OwXVqhp2XgA:10 a=9P8yD98ns4tQo_T1VPoA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=x9snwWr2DeNwDh03kgHS:22
X-Proofpoint-GUID: pYrRMxDIRHX5f4pjTfA2ddn_XmF9meN9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODAxMDA2MCBTYWx0ZWRfX2lMVebAy56Jh
 7J2KlABsd9yShEQOteMGJwsR6RBkilGqj3OzQQTHnPnHAoj6g1H7J4IetDkdFTDV2kNoNvEIBlF
 gljJXtJYMTbUebTNxTHcFNU/Rh1CD3A56ZMvuT7anuqwvINF7bN9EVVZUKvl8JxMXJ0xV838O/t
 QBmeJ2qXeV2RUZgnft4P4KADQuxqHyD38ypdoR4Pl++bdmfMPASRyR8SRyaEH6/+A3WbMT4vEvt
 6N+1Py/pxrN1n63qHj+HxuYC+X3qE1Mi4GuDqiwlhfX6Jph0EQHGBP6Er7RE1tOYeikjGlbctah
 vMvAvJCCz1FB1fUJdOJgYET+fTv/3Nm3NJeMqx8aRTycSsjGy3uMCp+0A7FgZhjhJqmybxXt7gP
 mYmPTTvJT5s02wnUwh6UM8XaP4yyZ9Efn5REqYJE/1N31Q6mUb3kb9Sde/Bc7ApvFfAOArh3
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-01_02,2025-07-31_03,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxlogscore=859 clxscore=1015 adultscore=0 priorityscore=1501 mlxscore=0
 spamscore=0 suspectscore=0 phishscore=0 lowpriorityscore=0 malwarescore=0
 impostorscore=0 bulkscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2508010060



On 8/1/2025 12:58 PM, Viresh Kumar wrote:
> On 01-08-25, 12:05, Krishna Chaitanya Chundru wrote:
>> Can you please review this once.
> 
> Sorry about the delay.
> 
>>> The existing OPP table in the device tree for PCIe is shared across
>>> different link configurations such as data rates 8GT/s x2 and 16GT/s x1.
>>> These configurations often operate at the same frequency, allowing them
>>> to reuse the same OPP entries. However, 8GT/s and 16 GT/s may have
>>> different characteristics beyond frequency—such as RPMh votes in QCOM
>>> case, which cannot be represented accurately when sharing a single OPP.
> 
>  From the looks of it, something like this should also work:
> 
> diff --git a/arch/arm64/boot/dts/qcom/sm8450.dtsi b/arch/arm64/boot/dts/qcom/sm8450.dtsi
> index 54c6d0fdb2af..0a76bc4c4dc9 100644
> --- a/arch/arm64/boot/dts/qcom/sm8450.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sm8450.dtsi
> @@ -2216,18 +2216,12 @@ opp-2500000 {
>                                          opp-peak-kBps = <250000 1>;
>                                  };
> 
> -                               /* GEN 1 x2 and GEN 2 x1 */
> +                               /* GEN 2 x1 */
>                                  opp-5000000 {
>                                          opp-hz = /bits/ 64 <5000000>;
>                                          required-opps = <&rpmhpd_opp_low_svs>;
> -                                       opp-peak-kBps = <500000 1>;
> -                               };
> -
> -                               /* GEN 2 x2 */
> -                               opp-10000000 {
> -                                       opp-hz = /bits/ 64 <10000000>;
> -                                       required-opps = <&rpmhpd_opp_low_svs>;
> -                                       opp-peak-kBps = <1000000 1>;
> +                                       opp-peak-kBps-x1 = <500000 1>;
> +                                       opp-peak-kBps-x2 = <1000000 1>;
>                                  };
> 
>                                  /* GEN 3 x1 */
> @@ -2237,18 +2231,12 @@ opp-8000000 {
>                                          opp-peak-kBps = <984500 1>;
>                                  };
> 
> -                               /* GEN 3 x2 and GEN 4 x1 */
> +                               /* GEN 4 x1 */
>                                  opp-16000000 {
>                                          opp-hz = /bits/ 64 <16000000>;
>                                          required-opps = <&rpmhpd_opp_nom>;
> -                                       opp-peak-kBps = <1969000 1>;
> -                               };
> -
> -                               /* GEN 4 x2 */
> -                               opp-32000000 {
> -                                       opp-hz = /bits/ 64 <32000000>;
> -                                       required-opps = <&rpmhpd_opp_nom>;
> -                                       opp-peak-kBps = <3938000 1>;
> +                                       opp-peak-kBps-x1 = <1969000 1>;
> +                                       opp-peak-kBps-x2 = <3938000 1>;
>                                  };
>                          };
> 
> The OPP core supports named properties, which will make this work.
Hi Viresh,

When ever PCIe link speed/width changes we need to update the OPP votes,
If we use named properties approach we might not be able to change it
dynamically without removing the OPP table first. For that reason only
we haven't used that approach.

Correct us if our understanding is wrong.

- Krishna Chaitanya.
> 

