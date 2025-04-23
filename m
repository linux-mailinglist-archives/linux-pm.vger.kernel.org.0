Return-Path: <linux-pm+bounces-26065-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A1EEFA99C10
	for <lists+linux-pm@lfdr.de>; Thu, 24 Apr 2025 01:31:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9D8AF7A7EEA
	for <lists+linux-pm@lfdr.de>; Wed, 23 Apr 2025 23:30:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0223D1FC0EA;
	Wed, 23 Apr 2025 23:31:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="WqsIJHZY"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 547F87F9
	for <linux-pm@vger.kernel.org>; Wed, 23 Apr 2025 23:31:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745451084; cv=none; b=fjTuoOIfHmOdIllxNDqZ2Q+V7SKca8D139l7apaBsSzeni2iQLFYYy9G9P3BKk0ew2yNb+Xst8YtUpbEMg8OFQr/m+H1oKjjiQYr6dP/sHLWvVVhXleW79viLRNv92ynA2F4MCkRS+P59XqKDcTEVrRdVzLF0lyvQHpkCE7eZ4E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745451084; c=relaxed/simple;
	bh=8bj6txe88RrRNnvkhnNcHWHokC6XRjqHx/nVoIunHyI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=POdixwGxMm3TZ8WgNyNI2nVGltB+7p/w1bsJJ8+9dwe1KVB1xVuEoMuZViEO38YM442jVmTML5xQ0W41sEpfxMOMh3HRGy3sVY4E0s5pJ9b4zUVez6HDwEsShwMF6D9P7F6kqpV+CjRszx21NnLOi51QcCIufEKn7IOXQoMJYHs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=WqsIJHZY; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53NLHdUr007721
	for <linux-pm@vger.kernel.org>; Wed, 23 Apr 2025 23:31:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	zNqo2yw+9GHctE0ZAXYaJlAMnBK53myrD4k9IkxFlX0=; b=WqsIJHZYSY0uKeYk
	XxoFYxTMr8ujWKSvMrxku83Qv/Yb5inJe8cpuHDdt0XlrLMDgxq+jkzyN2BiC4o+
	aTlf4xpcmPqwGBpwk6vzoCMHEg3pG+LbDV6dF2qOt2ZsEPkEpIjLnKUMT6suR9Tz
	9RBISoorfGFwNxMjLuFlHTizC+ELNjgqPBKD2ernEY5TYUDNaSjm1MNlZcqK9BLL
	xngS7kFAsS9qaKplHM2O/W0yO5TBGYbALtvitB8IMGil2cH3aSEq/0K2g/2rtEVa
	0S/+kT351YYyHSCxna7SBr0WOaV5533jUbIm6EfH/ws9I6fx2NLBUrWsSCia14wm
	LS9UNQ==
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com [209.85.210.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 466jh5bn44-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Wed, 23 Apr 2025 23:31:22 +0000 (GMT)
Received: by mail-pf1-f199.google.com with SMTP id d2e1a72fcca58-736b431ee0dso224590b3a.0
        for <linux-pm@vger.kernel.org>; Wed, 23 Apr 2025 16:31:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745451080; x=1746055880;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zNqo2yw+9GHctE0ZAXYaJlAMnBK53myrD4k9IkxFlX0=;
        b=LIlJPuN324mJByQz17gl8wb+8V2jSNaXjX2O0+q5VdRXy5bPyboThAts2wuM95B0tO
         v0fN3dCekRnkjxuEC0HBOqXeNhaP7/cqVVLH/Efmv0ELfFfqQ9VOuriODH9cQBCZIgz+
         5KUW8rRVV0xfzKe98sG7kgoOR+xeIoBs55nUgOFdxDzIGcvFj6Lmds/3rbiEGXOMBcvP
         FsP7ZiN0Cuw24hCKXkRPs83mZUAm9vLYb4WoFuAzvbOaImrdzTb+BR9AigbbqRFel2Dv
         58ovXdJbpoBkJ8ovNGLS1RgZfg90o8v4238FXARJavTouXj5mR87D2aGUBByR34gYxHv
         ZNXQ==
X-Forwarded-Encrypted: i=1; AJvYcCXFGPXzSCsV/py71L3dHSzkkeiarxc2d2kywFR1np4YyrxzB7GEKL50WHaeV/4vywV3rMx3lll50w==@vger.kernel.org
X-Gm-Message-State: AOJu0YyNk2oEs/VzdUhsw6qEr67owrMksGBVzcKkzf16EQ8q5PMDUHVI
	3gH3rcaZ3QWHOVlnxPD2nlQYkzJrKpu58jrFl22aT07HvHI6gdJnqGrMYUm/03LYm7u0mprY/X7
	bqF91LRJCrVHC873kPNndByxql6b5Y6eDpMVVddRXWMDCgE8djEhJUcuWzOWBGRoePQ==
X-Gm-Gg: ASbGncs2zCix+2fv7jgcpGtZf5r+wDO0R0D0MqpciLmiukUiPmwx6R29triNY4BlaXV
	RMb7BCd0i88Hg2JrN856W6dJY5qBfVF3v7yy8qHNXNxta5Y/y+Fu4eaF7XN1bbh4FYVh86dEKbb
	JSHeOZ4NMcqH5ZZ9d2D0kbEuUAsgoITMoeuIjs+IIbCNGYB5jO7dZLTMUCLt/nKinBYXVw9klTz
	aCWm8l6D8XUjyE0O8aWQkZpCyv+qPVTCgUn2Aek1v/MMHc60nMWK8EcLZT2cz6Wj4Ue1qRpv1/P
	+BVco8U5frl3LS240meHCxY8K1+jYXdqQzOLMhE87h5guo8e7xhLAjBuMA51/lfqzJjfsrJSOTD
	g
X-Received: by 2002:a05:6a00:ac0b:b0:736:65c9:9187 with SMTP id d2e1a72fcca58-73e245e4080mr732974b3a.9.1745451080596;
        Wed, 23 Apr 2025 16:31:20 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEDwwjEzdPvaN6z0apVE7LcGy75yAZV4sL84cdUlyEpqpBfKRQxyAwfdO3tZrKoojwHH7my+A==
X-Received: by 2002:a05:6a00:ac0b:b0:736:65c9:9187 with SMTP id d2e1a72fcca58-73e245e4080mr732960b3a.9.1745451080266;
        Wed, 23 Apr 2025 16:31:20 -0700 (PDT)
Received: from [10.71.112.43] (i-global254.qualcomm.com. [199.106.103.254])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-73e25a9a0a6sm141767b3a.138.2025.04.23.16.31.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 23 Apr 2025 16:31:19 -0700 (PDT)
Message-ID: <6031624c-9c65-4df8-88db-96800d58c910@oss.qualcomm.com>
Date: Wed, 23 Apr 2025 16:31:18 -0700
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 4/5 RESEND] thermal: qcom-spmi-temp-alarm: add support
 for GEN2 rev 2 PMIC peripherals
To: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: amitk@kernel.org, thara.gopinath@gmail.com, rafael@kernel.org,
        rui.zhang@intel.com, lukasz.luba@arm.com,
        david.collins@oss.qualcomm.com, srinivas.kandagatla@linaro.org,
        stefan.schmidt@linaro.org, quic_tsoni@quicinc.com,
        linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, dmitry.baryshkov@linaro.org
References: <20250320202408.3940777-1-anjelique.melendez@oss.qualcomm.com>
 <20250320202408.3940777-5-anjelique.melendez@oss.qualcomm.com>
 <aAI1JnQ2yCjtJL9u@mai.linaro.org>
Content-Language: en-US
From: Anjelique Melendez <anjelique.melendez@oss.qualcomm.com>
In-Reply-To: <aAI1JnQ2yCjtJL9u@mai.linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNDIzMDE1NyBTYWx0ZWRfX+P1c8ULwPyBU 6SHShv8RRFYlk+dLJR+/HEr3V7+y5Oi7ak0DyDlUCSBytNkyrMR70DaYlgrLBYPF97kISGMogSQ +0N1jll2An/xNdS4ZHjWgH60x6tw3rA6T7y86gNimTIBqDRBRZ6AvVQ7WkTWcX5NRgONkRF1jV5
 qi3TaPEhaJC7+YBWcNwUz9NddVjlGT/VirWML/Wtf0CJtNt8y9iUZc3Q5Fxx3RunyWWp3j3MIkh i2D01l4xiGuqUnxn1A+AyzLK14O2tM8GFnApRTDamEEb1uCedovpme3G2tT5dMtwyDZiyOYy6t0 jgEJI57mmPsmVn3F3iBI4qFIJuIFOZr1fMQ5OmL3mxb9RZhxcfDEpRN/JKr0r4xBiFNnyrS+K12
 ManH19yxZo1Jlzz7nbsoP/deJo4BZJQqLlwyitJ700+vUM3pMGCHZOyft2PZSopiE9+Qj2Gd
X-Proofpoint-GUID: YxL8-QcF_8vveX-o_7_PeBq0OirHOjmT
X-Authority-Analysis: v=2.4 cv=B/S50PtM c=1 sm=1 tr=0 ts=6809784a cx=c_pps a=WW5sKcV1LcKqjgzy2JUPuA==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17 a=IkcTkHD0fZMA:10 a=XR8D0OoHHMoA:10 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=PCcEw_Bt9sndwEor8soA:9 a=QEXdDO2ut3YA:10
 a=OpyuDcXvxspvyRM73sMx:22
X-Proofpoint-ORIG-GUID: YxL8-QcF_8vveX-o_7_PeBq0OirHOjmT
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.680,FMLib:17.12.80.40
 definitions=2025-04-23_12,2025-04-22_01,2025-02-21_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 mlxlogscore=999
 lowpriorityscore=0 bulkscore=0 impostorscore=0 suspectscore=0 mlxscore=0
 priorityscore=1501 phishscore=0 malwarescore=0 spamscore=0 clxscore=1015
 classifier=spam authscore=0 authtc=n/a authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2504070000
 definitions=main-2504230157



On 4/18/2025 4:19 AM, Daniel Lezcano wrote:
> On Thu, Mar 20, 2025 at 01:24:07PM -0700, Anjelique Melendez wrote:
>> Add support for TEMP_ALARM GEN2 PMIC peripherals with digital major
>> revision 2.  This revision utilizes individual temp DAC registers
>> to set the threshold temperature for over-temperature stages 1,
>> 2, and 3 instead of a single register to specify a set of
>> thresholds.
> 
> Can you elaborate what are the different stages in the QCom semantic ?
>  
Stage 1: warning
Stage 2: system shutdown
Stage 3: emergency shutdown

This is the same as was outlined in original driver documentation: 
https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/commit/drivers/thermal?h=v5.4.281&id=f1599f9e4cd6f1dd0cad202853fb830854f4e944.
Will add this info to commit.

>> Signed-off-by: David Collins <david.collins@oss.qualcomm.com>
>> Signed-off-by: Anjelique Melendez <anjelique.melendez@oss.qualcomm.com>
>> ---
>>   drivers/thermal/qcom/qcom-spmi-temp-alarm.c | 136 ++++++++++++++++++++
>>   1 file changed, 136 insertions(+)
>>

