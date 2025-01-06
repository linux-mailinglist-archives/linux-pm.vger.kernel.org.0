Return-Path: <linux-pm+bounces-19996-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 92DDDA0334E
	for <lists+linux-pm@lfdr.de>; Tue,  7 Jan 2025 00:27:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 165653A1835
	for <lists+linux-pm@lfdr.de>; Mon,  6 Jan 2025 23:26:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46F991E1C11;
	Mon,  6 Jan 2025 23:26:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="O/V1AtkE"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C57771E1A33
	for <linux-pm@vger.kernel.org>; Mon,  6 Jan 2025 23:26:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736206016; cv=none; b=U/dlMevNueIMYFk74+o/7WFxXeBMNJlMk7rwSNQ/dSVuSyz78GIu9p1//aB7191ouFsraCNb97v/Zs5zyI/jKqJ5V7LekcQWvec2wB/nHw9N5HrPcXg4WweOwYhaxMHkr5QJtStsA8FhaN0yzywawrLN+vBVWlFQZHKzpIp5ihs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736206016; c=relaxed/simple;
	bh=CScU65F031qQqaiweB+T7sXCuQF+ER/uPWY9SACzlHY=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=CahLc+3cQ9t+usCXPy5gX7u7Av2ClfkoKVYH0YMO+9ZUhmuJr6uCSFaXbpRNjfChdt7i7xVmEHckaZl8Z+83ZABDQmbowtTsuLhHsIwE1D7zYpK3l9qzlpogPmWBajDpAL7KsSCT/WsWx67M+vojQk6wjNk8s9OF9+562aWL+AE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=O/V1AtkE; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 506I3egb022614;
	Mon, 6 Jan 2025 23:26:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	CScU65F031qQqaiweB+T7sXCuQF+ER/uPWY9SACzlHY=; b=O/V1AtkEcvy0lrzT
	b8pQw51YDo1l5Zw0dnjQ88dythJqp7uV0WLB+76cOyn4KvQf48vGjbCSW2Yn809w
	4JPs0QlniMjfzZ9qlg0k2IrWgFa/VfZPaKg+K+e/nrwLeL3RAe7NpAOH/OKYpB0i
	iBGMISK8Jm/00rTimRU87BdVLMtz0mL0Y9cNSYe7kBrsZ1FjN1SIqQ02PLQ8obXw
	19LTqNEUqXyI9MYrtLXtIyb5CHyYVo4Z3k6nqX2c5BftLj0qnMr8t9obsfCCMLuk
	9f5sZ5MAIGCFhdC5AOlcpqKrA2RpPY0dySki9txFehi5SdforBMoS0t8lh0cUCNM
	1Q8lDQ==
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 440m4a0k8f-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 06 Jan 2025 23:26:50 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA05.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 506NQngk005752
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 6 Jan 2025 23:26:49 GMT
Received: from [10.81.24.74] (10.49.16.6) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Mon, 6 Jan 2025
 15:26:49 -0800
Message-ID: <c6af6fb4-50a1-43c0-88e5-f541fa5dd4c7@quicinc.com>
Date: Mon, 6 Jan 2025 15:26:48 -0800
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/8] power: supply: Add adc-battery-helper
To: Hans de Goede <hdegoede@redhat.com>, Sebastian Reichel <sre@kernel.org>
CC: <linux-pm@vger.kernel.org>
References: <20241215172133.178460-1-hdegoede@redhat.com>
 <20241215172133.178460-3-hdegoede@redhat.com>
From: Jeff Johnson <quic_jjohnson@quicinc.com>
Content-Language: en-US
In-Reply-To: <20241215172133.178460-3-hdegoede@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nalasex01c.na.qualcomm.com (10.47.97.35) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: djX4PWWzz25DlSAi_RVrfnDsdW9QWvqA
X-Proofpoint-ORIG-GUID: djX4PWWzz25DlSAi_RVrfnDsdW9QWvqA
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1011 mlxscore=0
 lowpriorityscore=0 mlxlogscore=892 adultscore=0 suspectscore=0 spamscore=0
 phishscore=0 priorityscore=1501 malwarescore=0 impostorscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2411120000
 definitions=main-2501060204

On 12/15/24 09:21, Hans de Goede wrote:
...
> diff --git a/drivers/power/supply/adc-battery-helper.c b/drivers/power/supply/adc-battery-helper.c
> new file mode 100644
> index 000000000000..1917e92ab1eb
> --- /dev/null
> +++ b/drivers/power/supply/adc-battery-helper.c
> @@ -0,0 +1,359 @@
> +// SPDX-License-Identifier: GPL-2.0+

...

> +MODULE_AUTHOR("Hans de Goede <hansg@kernel.org>");
> +MODULE_LICENSE("GPL");

Sorry for not noticing this until now -- holidays...

Since commit 1fffe7a34c89 ("script: modpost: emit a warning when the
description is missing"), a module without a MODULE_DESCRIPTION() will
result in a warning with make W=1. Please add a MODULE_DESCRIPTION()
to avoid this warning.

/jeff

