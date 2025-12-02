Return-Path: <linux-pm+bounces-39044-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D136C9A8AE
	for <lists+linux-pm@lfdr.de>; Tue, 02 Dec 2025 08:47:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1EBC33A65EA
	for <lists+linux-pm@lfdr.de>; Tue,  2 Dec 2025 07:46:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BCDD2FE041;
	Tue,  2 Dec 2025 07:46:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="EHFGlgX0";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="CG1goVKN"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5DBA25BF13
	for <linux-pm@vger.kernel.org>; Tue,  2 Dec 2025 07:46:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764661581; cv=none; b=KkDnIPVxF4Vb8esmbZijOHr+tSo/nwozM8PHWtpWicjVuTvBk/A/XNu9Jbz98JXb/lnwkU7tgreNApZPpqLQqHhHdgOs12pY9GHmhuMQKOURkD9JsXdShqGCzwmdKFUbVcgH2uByrlYjqC4jxGwtIBBViBRQU5HA+7dMMzx82sY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764661581; c=relaxed/simple;
	bh=d/2BZjmIEzBvFQVwm3mbgEak9vBocF8DSyDyQlVO3sw=;
	h=Message-ID:Date:MIME-Version:Subject:References:To:From:
	 In-Reply-To:Content-Type; b=rYGgPNsB4Oo3sIo/rHqtGMK3T2cB500RT0jz8Sv01xFyFyMvnKCMaD/0ecxVVTiExKFYREthRBDdLW7KtVhaPoUc8YWqRxlReCeWEiqMIKHbaBjoRwAoLBUhl7AlUV2LIY+LuEWMfKDHiBYD7cVKt2oYuqO6/3SM3tk0IIRwOwk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=EHFGlgX0; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=CG1goVKN; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5B27M2nK2692832
	for <linux-pm@vger.kernel.org>; Tue, 2 Dec 2025 07:46:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	id76BGdt0nrk8tS4r6DIJzrzlaIfFZcLjq7vmsuLOWs=; b=EHFGlgX0clYmO3e3
	tb/+JaxYMFry7Vl2+dS0VC6R/V4pxQKPeTLeCmt3LWcNSPZEvtqrwf5bHOK2T5f+
	TQMmQZ0W4sCJMUloSA7flwIfm9NVAqtyKz2tyX8CYPfWS5A5XNhmEyhoEOsCYY8x
	/M7OzTYR5z/1Nu9yH4V8pGtYVsZMEmsDuLq8PRT4A1o6K8mbc/2k2ScE9Kc5XQLr
	VltYinEoPp2hnZgQvn33zUoSiK8ckZILvgwJ8jizsZM3EWnC3oIlHXoLd8iXcw6B
	lJZ4Tf9O2mC4cjOm9pmFnzui4/MtzvpZkHME+BNLjT0ewQMQeQB5qEHkKpcOcB17
	/oIGmw==
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com [209.85.210.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4asun902hh-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Tue, 02 Dec 2025 07:46:19 +0000 (GMT)
Received: by mail-pf1-f199.google.com with SMTP id d2e1a72fcca58-7b873532cc8so4051517b3a.1
        for <linux-pm@vger.kernel.org>; Mon, 01 Dec 2025 23:46:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1764661578; x=1765266378; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:to:content-language
         :references:subject:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=id76BGdt0nrk8tS4r6DIJzrzlaIfFZcLjq7vmsuLOWs=;
        b=CG1goVKNZ4AuaCuO4vtQnCam7DeWTachM9S6JVSz16D2htfSc4alkaf3hwJCDEg+7Q
         MfzH7Vgql8JjUIerhSJWtW4A8XOnb9F0CPg3SOwN7UHkq/sgrnCSiaINP6KsCZ4Ydy6K
         zOe2DinKc9tAjpKTg1S3GoMrn+tS/If/kEGTcTd2qZIiY0N0x8iScXJ2pKmId4Z22Yk+
         HdC4srfXZisPKd3pCv+7h3tvcWF0KnQbPfSfpIlY6Vc3egx09yyfqxaryJtsmksHc7wf
         mEncQr4r/X2Vs4zK+eF/d8U3t14Ar05vZiLXuJaubPWNlb7L3TzMBS2wOkt37jmeAdhX
         Iz2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764661578; x=1765266378;
        h=content-transfer-encoding:in-reply-to:from:to:content-language
         :references:subject:user-agent:mime-version:date:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=id76BGdt0nrk8tS4r6DIJzrzlaIfFZcLjq7vmsuLOWs=;
        b=Uv3VKMr6JvORmK8gqIsDssiZTiKA5zdIhKwnOMEQOn3WlDN03yi1UDCzPGMwqOYrpu
         ZcQUxs9T1+WAVF64ATBz5HdKPBS6ONcWzxydTuzydlM1DuPH3TZowfixG21c3n/h0d4Q
         oDwwKDb3D1IMMZDYlhKGfgV7bSDtOFRm1OhMSy2DsgjbamCemkDrnZXsmyxfsTNV/Qvn
         6LkzlY1W2bxoPHNue4xGptwcj6keQPj22j5dNZYra5z1smbxVGxf0HqXT2S5gEvuEIzC
         9v4gm2Vxc3Zu4/PdPfL4HU0H333mjnsR/g7smKUbojKfhX9MscKCj9ONrGjM/JO4ELhX
         zvTA==
X-Gm-Message-State: AOJu0Yzv/Ji3T8LdTF1AsljYo6ApDvThZHassAy5oV+gzJ5Xcr7sVOa+
	jSXu95ZkOyjKiaEVchIb1JcJPwlkrJvgvaEavHTMNqjynJ5TxpFLkhgMQGo90iGKG6MzAluMWf6
	8xsneyKNvshSrBUrHs57/xsakN7kBUxx/TgGg9a/RoxSmYaNleeHhaxnC2hHibO3fsfXmL5vR
X-Gm-Gg: ASbGncuE0yGIo6uniJEGg6JRXLfBMUQqIMxOmmVSNQaMpH8zKUrnHR6JFSLav+dWrcj
	pajfFuQFH6M+SVSCjHctn2Et3AabPz4FelVa9yzX1GpjdhwE+mkbh6qac7h8pkYWAfl02o2yvGW
	MxwSq3E1w8vBwsYveewEJjdC+eoj7rQCG4NlJ2q2v0awTZB2vrawA+dtlFw/8uZEmTkVO4pR+S1
	/zc9H7tHImhrXWjMMlQDz1Et5gbbU8/W3Qk0B05JBlAWltpuwdXbYP+ZUQMzoGrcYvb333hhcIB
	tFYQJah1Qqy4kVTVkciLKuYSCCK5bVA+uaDFJzYnoEfGi+rlyc7TzbFsXfLIuLWHWCUwPlKjrz6
	eXBi1Bv7o4fZpfNo17Ru2zVaFntvPLB7tgkZM1ET7YPlypivzbTwoMmiiLdNR5iImL5PU1Ng4gw
	==
X-Received: by 2002:a05:6a00:2e18:b0:781:1110:f175 with SMTP id d2e1a72fcca58-7dd788c50bbmr2088099b3a.14.1764661578273;
        Mon, 01 Dec 2025 23:46:18 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHm79XYk9z/+eZc94gRo3b5kgQhD/j5Xo6YUtkEE1wENbEY4x/Z1sS11g0rwImVrsIPXPFSfw==
X-Received: by 2002:a05:6a00:2e18:b0:781:1110:f175 with SMTP id d2e1a72fcca58-7dd788c50bbmr2088067b3a.14.1764661577764;
        Mon, 01 Dec 2025 23:46:17 -0800 (PST)
Received: from [10.133.33.100] (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7d1516f6c47sm15938310b3a.18.2025.12.01.23.46.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 01 Dec 2025 23:46:17 -0800 (PST)
Message-ID: <371e1dcd-c18d-49db-a45c-e8cc7ec147f8@oss.qualcomm.com>
Date: Tue, 2 Dec 2025 15:46:13 +0800
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: test-by-test
References: <62eb142e-329b-4faa-8750-2d92d4a37d3c@oss.qualcomm.com>
Content-Language: en-US
To: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        quic_okukatla@quicinc.com
From: Yin Li <yin.li@oss.qualcomm.com>
In-Reply-To: <62eb142e-329b-4faa-8750-2d92d4a37d3c@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjAyMDA2MSBTYWx0ZWRfX0U26VyDpTCOA
 iGDzUQdJs38RPao8gBb/kF26yhzC15d0DyTEoSREQBRt9zEs/k5g/DROZ4OlohofOn4RrVuAejr
 VzrOD19pP+XKvxE9Bdpn/O1bwnP2Om5kdvxRBp2c6s2mofBr2KQCawf4/Sg5bgZv8OcHXjDe0dG
 WwKHEZp41B69fwx6a5Ob8u8HQSBrVOi9YXUo2Xayn+wBD9oHpRSJoaTq4JiLOFcSdT/04PwFRDo
 cFOAuTq8EgPaOTVXeH+Q4pSYCaZa+sFFJthKBt31Q9zndPVnPplZmLr/zkxw+BJGvOye7lLAlG/
 BO+USd70H9oQakwzKv9Obdic9I21HRlm+myvG/qo8Vp3GdCut2tANONLfvtzrTWIoJjJAdsE+sK
 kzq9YRYwm9mlZNz/bCHXBln8y4wKEQ==
X-Authority-Analysis: v=2.4 cv=DKOCIiNb c=1 sm=1 tr=0 ts=692e994b cx=c_pps
 a=WW5sKcV1LcKqjgzy2JUPuA==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=IkcTkHD0fZMA:10 a=wP3pNCr1ah4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=_ACZHSV4MdW8pSOez1gA:9 a=QEXdDO2ut3YA:10
 a=OpyuDcXvxspvyRM73sMx:22
X-Proofpoint-GUID: EbDUZrpXRDLjHWjkA9VfPovPm0sGPHZC
X-Proofpoint-ORIG-GUID: EbDUZrpXRDLjHWjkA9VfPovPm0sGPHZC
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-28_08,2025-11-27_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 lowpriorityscore=0 spamscore=0 suspectscore=0
 malwarescore=0 bulkscore=0 impostorscore=0 adultscore=0 phishscore=0
 clxscore=1015 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2510240001
 definitions=main-2512020061



On 12/2/2025 3:13 PM, Yin Li wrote:
> Hi Georgi,
> 
> on 16 May 2025 18:50:15 +0300, Georgi Djakov wrote:
>  >Hi Mike,
>  >...
>  >
>  >> To prevent this priority inversion, switch to using rt_mutex for
>  >> icc_bw_lock. This isn't needed for icc_lock since that's not used in 
> the
>  >> critical, latency-sensitive voting paths.
>  >
>  >If the issue does not occur anymore with this patch, then this is a good
>  >sign, but we still need to get some numbers and put them in the commit
>  >message.
>...


Hi all,

I'm sorry,I realized that the previous patch I sent was incorrect due to 
an email sending mistake.

Please NAK the previous patch, I will resend a corrected version shortly.

Sorry for the inconvenience and thank you for your understanding.



-- 
Thx and BRs,
Yin


