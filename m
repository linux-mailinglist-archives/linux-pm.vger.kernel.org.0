Return-Path: <linux-pm+bounces-37290-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7509EC2ADC7
	for <lists+linux-pm@lfdr.de>; Mon, 03 Nov 2025 10:52:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 364683A6E25
	for <lists+linux-pm@lfdr.de>; Mon,  3 Nov 2025 09:52:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3ED722F9DAB;
	Mon,  3 Nov 2025 09:52:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="awVu9mZE";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="cqZQESdH"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E035D2FABF7
	for <linux-pm@vger.kernel.org>; Mon,  3 Nov 2025 09:52:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762163542; cv=none; b=gF1gsToeeJxDwyz0JRbqJVyaISM5A4IbtqJfWZlU1SNmbVF2s/o6tymaW5vz5hWYvdlbd9KbqcHUsreRWHkvnkd7OdIt3vnVG2icigQPfeLc8halkI799aiJZllnddNKy3EcTodVYnFHed5RnL3vu6CDxu1LH44ThxvHrMR9CEM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762163542; c=relaxed/simple;
	bh=ilouYp44rCS2DbXYyq7hh9q0vM4P/bamUocBhybD/nw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=iuc5I9RDMbSB/u422pvzXOOa3hdql/9zduxffjkjjkAcJ0ys/whsFjdgpHM9qRtIUnETUpeWLQGQyJw1vsA8qKQFWuz8xOA0ZLQ8uzYN6kJIu9c0Y3GnpouOI+O12fpA09DPhOehhcVoWRDOso9qfZDwXSudBHRX5/XnD85UkLY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=awVu9mZE; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=cqZQESdH; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5A38QwZo1381634
	for <linux-pm@vger.kernel.org>; Mon, 3 Nov 2025 09:52:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	b9/hMynrjGoov5sKXV3QPhZeYgKZmJt12Z9R/C9Mx04=; b=awVu9mZEgPmSkXkX
	vuhMKMbQnQu4DPR1WIqoIJQM6MD9p8+kuaCMa4XlCSzY7XiRPIeEXiNo6z+S0HhJ
	gyB+HTvxEjet2wZnVCcMYpf+yRXN23b9T7CWWwautB8Em3huG1CAlbpmA04UJv+F
	6jN5CBzO4nXnwsykJybFvbU0oX3BGwSvermAk+qe+XFT+ieAt2RDyCRv+27oX2D3
	1102Gxk275LkAt9hIfm/086UufQDYJk79aQdrhsNEPFLKbXHXkGECe6FYqDg0mNn
	zFajXZbsoWuqi39TqUKbqKInwJoU4/P7BtF7qIIOZfAmu3sVp6Fd8UIWpNnQidZF
	VEXwGQ==
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com [209.85.219.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4a5977c8yn-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Mon, 03 Nov 2025 09:52:18 +0000 (GMT)
Received: by mail-qv1-f71.google.com with SMTP id 6a1803df08f44-87ff7511178so10678406d6.2
        for <linux-pm@vger.kernel.org>; Mon, 03 Nov 2025 01:52:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1762163537; x=1762768337; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=b9/hMynrjGoov5sKXV3QPhZeYgKZmJt12Z9R/C9Mx04=;
        b=cqZQESdHgIn6iRNr7K73W3+1WM/C1fcZjIIkDvpd1OFeDmR+aUN5gpsRd9NyxHggHg
         CPnlCSqGFzqTomUen0xWVneED54hRy1ET/wzbUgPoH6W1DSYtoxRF5DrS6yEZvjHPV0j
         J2dRDJ6TnNtvgORy79ZeDwchu+3GnUL1XXxx7UGUw9ttKj7BB8saBbhHvQ4c+nTpTnQv
         h+/7nh/rFuqUhCv1HkGZvYYgabQGY47ueP2AejFnqDEzAw3Iz2iwfsd8cC9BWHCWloY6
         PW1smVfx/iIpPwKlyfVX33LW76RCGCwLVRwzTklSVLbJF3yN1jtyLIha1DFV/6L8mun8
         DUaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762163537; x=1762768337;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=b9/hMynrjGoov5sKXV3QPhZeYgKZmJt12Z9R/C9Mx04=;
        b=uPFNulmsKRV0kZ0tkR3RDiABuwGd2ivk8OtprigbqUcElrL9SO6IGEJcb7bJ7UovCE
         ArkOnSbcUqPD181IJBX9ZZH3o6s9UTdkTlr5YOgmCHrHuDAgkF4KQAl5z4D2cv0S/gZB
         kPsXGuhOTkXgnXziH3Te8Zq4jPc7APcdr6PXWYLGSZCtYZh3qIR6pkjPuE2pyFcbhhr5
         LjzzW7pg2UjEhTxGCfbjTn5nbHzESB4OQUVzHApmVgL3CafH01LUWfh95/BphT/fN/fR
         okCJbwRvgRL1zfvKumfJgCutu37BZSOXLwN99v0ZJhtSyubrnQFSed5tDpD6JyNqB94A
         s7YA==
X-Forwarded-Encrypted: i=1; AJvYcCXDtXh0PhVMIHlCo0z1rjZFud/j0IuNetu21GC3+pO1S0egDijabWO0M3THCC7ULN2u2wXNzPjTIw==@vger.kernel.org
X-Gm-Message-State: AOJu0YwjB2gjzNaPntN+Xxaxt+/pyP1gh3Mt0Blin4IVNs5KwRaYekoL
	oEMYgJB+m2qHnFRi8Gjf7qDUgu18lYxJXVpbEnHcCvtFzvBOZutYoi/IfTYqV0CjKBSFpylfK0b
	lOVSy/zPORE+dMw7HZGEYvTs2wKXdLqGA3bDeC6piWfjmuPLBx+zOn0GExZM1OwLQTuveRg==
X-Gm-Gg: ASbGncuyHEjVl31gzhFLyNr5Eu1dgucmGX8lX3bzEBepNddxZXDJZx9HpBFJhtGeOYG
	GCFyXCMsNipYgDgs3gqiQW5VyhnFQqGu+5HA1/PCvxNDYsxPzUG3TMqdML1WTAhVn9Fdxn3zwPi
	PzysPGwOJQlrk98UGOzrUOeM2IazEFOria4SNXzCgjScxsK1TIVVO1DcoydagVrpakqe67QtkEg
	cG5KLri1kSsP63aaQI8kl+4WC8gp7/6aqiFiS9bJY2KKPn0h8ZCVSCiGiN87811Nw5rAmy7L0mz
	DeRbhsC9xKC4i2BemfCwXVEiro7ZiybVOlFTLd4DHzwHzo3B28YHTVhgDFiXIXfpcobTnc/cU1W
	0I/DEf0MeDytX1m+B+M/wROcIPRvJ7qH/+6YqA0Qkk71jmUeypp10rT/S
X-Received: by 2002:a05:6214:19c9:b0:880:51f0:5b92 with SMTP id 6a1803df08f44-88051f062e8mr36977046d6.1.1762163537403;
        Mon, 03 Nov 2025 01:52:17 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGMuJXaeDPuSQb7uyKLednlPXSsjDtFnz5mwdcOTCCfsl7GSBy4eQ2+uDGZPWhbH7VIlYSjtg==
X-Received: by 2002:a05:6214:19c9:b0:880:51f0:5b92 with SMTP id 6a1803df08f44-88051f062e8mr36976806d6.1.1762163536701;
        Mon, 03 Nov 2025 01:52:16 -0800 (PST)
Received: from [192.168.119.202] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6407b42821bsm9228053a12.22.2025.11.03.01.52.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 03 Nov 2025 01:52:16 -0800 (PST)
Message-ID: <e5d7654e-91da-4662-9055-df3a9d9d7bd5@oss.qualcomm.com>
Date: Mon, 3 Nov 2025 10:52:14 +0100
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 25/25] interconnect: qcom: icc-rpmh: drop support for
 non-dynamic IDS
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
        Georgi Djakov <djakov@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20251031-rework-icc-v3-0-0575304c9624@oss.qualcomm.com>
 <20251031-rework-icc-v3-25-0575304c9624@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20251031-rework-icc-v3-25-0575304c9624@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: 2v5KfWmTusugK89iM2zD1tN2Vav5BefO
X-Proofpoint-ORIG-GUID: 2v5KfWmTusugK89iM2zD1tN2Vav5BefO
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTAzMDA5MCBTYWx0ZWRfXzQ96YQlVEWGu
 GOnEAqsDdneVCiorgWrGODHNI6Pn7zBW328+dTwG3glECgcxyFs5Ck4NCxGRA5+XGShwu8XcZBw
 ZLJ9ksVi99KFnACgSGKB3F4DZOek6NdJ+XSj/sKfiRrjmoHpOXMs+6HyVYr4QJwGrFH9trAFsUK
 WMW5MsDL4tMN5kuhH+6+3N3gA8SNPsR7tBkc+Ok5PEbtNm5Cn/cnALWrPhwdOWH77hel21pJ1Bu
 oiTBzcH4GFbI+I6z0Qqr70urd1+1uwCeMRRJVU9faeBOAVlsInXjK9De1s0DgEuclT8KlSXzzPL
 Uo98HfxbqCanqPfTdeaxbl23GjJp2hwxLwVHGxTFrN4GzQoLCBO1rxYHGq9QJAkqGqCxanZmi5S
 uGeZTQ6LuBSlN2mumUwRO2Z0NM7Y2w==
X-Authority-Analysis: v=2.4 cv=WcABqkhX c=1 sm=1 tr=0 ts=69087b52 cx=c_pps
 a=UgVkIMxJMSkC9lv97toC5g==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=6UeiqGixMTsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=EUspDBNiAAAA:8 a=--u-uVyheMlGKQUkfXoA:9
 a=QEXdDO2ut3YA:10 a=1HOtulTD9v-eNWfpl4qZ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-03_01,2025-10-29_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 lowpriorityscore=0 adultscore=0 priorityscore=1501
 impostorscore=0 spamscore=0 malwarescore=0 clxscore=1015 suspectscore=0
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2510240001
 definitions=main-2511030090

On 10/31/25 3:45 PM, Dmitry Baryshkov wrote:
> Now as all RPMh interconnect drivers were converted to using the dynamic
> IDs, drop support for non-dynamic ID allocation.
> 
> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
> ---

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Konrad

