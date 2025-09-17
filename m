Return-Path: <linux-pm+bounces-34843-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FFC4B7D8C7
	for <lists+linux-pm@lfdr.de>; Wed, 17 Sep 2025 14:30:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 91F7A3AD6B9
	for <lists+linux-pm@lfdr.de>; Wed, 17 Sep 2025 11:14:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 425932EA740;
	Wed, 17 Sep 2025 11:14:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="m2+PVpD+"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EAB02DA769
	for <linux-pm@vger.kernel.org>; Wed, 17 Sep 2025 11:14:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758107674; cv=none; b=kNdYtJES2msaJngl2Ttd6PpieR7G8ejpzH5RH78yOAaNhnb+RK77nknOmPKBK52j32HPvzmeG2FHyQqnhsC1exQxaYM7KAam5VA/W7BLJGQG9OL2yeV4T8L7TQMF0zVYj1T9lC+adCHEnn7OvmkBsWktPpKePWebkhJQV0NdDVw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758107674; c=relaxed/simple;
	bh=gr9F60Me7a60bNWj3SiJcwOQULQ8APfwa1823sZVpIo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XuMgZPJ3mloB3p00eQE2sjgzNLVcHpf6FNnBh/Vyq7HUHT2bmX6U6XIlzjXZFnkzilb/98ZEeE5oy2kBimB8bzjxQdO7F4fprf3IdMcyWAHhoqgqqbq3jekz+LlkQJ8AhQlJ/V1TT91SlXQNva/Zk332GC5L749wIOYROo9uLK8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=m2+PVpD+; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58H8XaUR029904
	for <linux-pm@vger.kernel.org>; Wed, 17 Sep 2025 11:14:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	SjIVIub8Wket+d8VfqHLW16P1fmhDt81FIBdsCC9eCk=; b=m2+PVpD+JX68xdNA
	e6xGaMzZ2V9W8QeokHqxPURe4dJtCFtGFHq+OxOmaPE4rRv1UxUwfKFmYx/A7XiQ
	cvcPvOILvHD/y1NpaWwONYtYw1bEObfadFOhPRLB0iq4eyFVmx4PYk7ONHW1uHXP
	iIdjyKxmkhqBYTpMoZNFFQwhkaAEW8SnyRrL0x/jxWEKvUl46MBd9LskkdSZbuj8
	5ro/SMmh9Rcrr+GQGChDUbLYQVvsM+U1ImXl1yrubRtPlJNHQOak0cZW3nENXU49
	xISItLnkeQzXKnixLD9usp5TqPO22lsZBIk6swlTbQjefYxhivU/nHBHI1k0zlMA
	AIL1Eg==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com [209.85.160.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 497fxxj3kn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Wed, 17 Sep 2025 11:14:31 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-4b79d4154c9so13872531cf.3
        for <linux-pm@vger.kernel.org>; Wed, 17 Sep 2025 04:14:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758107671; x=1758712471;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=SjIVIub8Wket+d8VfqHLW16P1fmhDt81FIBdsCC9eCk=;
        b=P1SXbZbBcwRCKKKwIUW4sIbMM0WoY1BtB0ailbl0h3jG7UHvp7jDLy78k4aqgEaQNO
         d6m/jpIaFE5FEvpzBLzPRRRVVW8pI052URSPGBO4agYB5grix9lghIxyif3Q6E83T8xh
         0AgUVtP3oa1aiHhuTATXu6SDB380jWPZER7Qc0MYNLP1x0hcUHpMzMW5xZBjxVKQxg4i
         R9iERRt8BEhNlddEhdwWH8EVOYt05J31AWqxy5qcDlnE9rae0wBZTdyZgHkg/kmr76jG
         uXJqx0pe58RjFTqBOliXxhxujWsR0si160amQZF+JbzHmxDUBlclaRPuB5WPymcIdexf
         CZZQ==
X-Forwarded-Encrypted: i=1; AJvYcCVhDbSVKzWnqnD63q1rqxkmAwxLTOKTyk5srp4DzVDkwfgcfm88r+AMktjm6dM7ebwT90y5xI9iaQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YwXuYvUEW+/cuLXQ9h011LD28oHQLX+YlYywF0J5yiPE2gsvC6r
	zcTc5JrsBkFMwIhXlTISAyQlhhs1tKoQ4hJZBkgwQa47XrJPWW1/NEwWw+NQhavVkf0N0BCCJDI
	Uo07gEoMx8e32kfWQPn3VGLOKpy8xC0Pr9FRbdQF0uqTHF6N0LxtfhchLAn9Xqw==
X-Gm-Gg: ASbGnctW/IAB8fWnKD8wvDZPkJ3JvAgMMvn/RtUulhY0tSUs1KuDEyorTIZ1hpAVrd7
	vCHiG6WouJ7f2wSVPA8dPhYtPyVxvKIqf9lNB1c/dIHLVFsaj1CDqbSFBFbNxgnPuYGghXh8Xl+
	nmJxOM9hWm/FCFo6zoOcO8IufeSJfD9328M88Z/STwKcWsfVWRHObkCZ31AarWcI+j5GnzMTrBN
	MYL1XrR3BeRMeKP/mKBKu+DvcCOjR7jJt0eDD+payhSZIAKE+29xDnnFEcuw91nb6x+4oWtAUbp
	EDmO1YhnJ9/TCDg18VPFbheHXZ5Sj+HGlDg+Sej86ujua/m3rAvBtACLh7aHypEQL+n9paYY8gn
	ggsTh3AexZV78vJA121kjWw==
X-Received: by 2002:a05:622a:342:b0:4b5:a0fb:59a4 with SMTP id d75a77b69052e-4ba671e5e91mr10613651cf.1.1758107670654;
        Wed, 17 Sep 2025 04:14:30 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHUZWiiFXjANyc5iNlBf2sAU8oL2kw0kwLhnJKg6xlVKg4vTUbDuuDVuoJ15JMc/ewmK01gkw==
X-Received: by 2002:a05:622a:342:b0:4b5:a0fb:59a4 with SMTP id d75a77b69052e-4ba671e5e91mr10613251cf.1.1758107670045;
        Wed, 17 Sep 2025 04:14:30 -0700 (PDT)
Received: from [192.168.149.223] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b136ee12326sm485898366b.51.2025.09.17.04.14.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 17 Sep 2025 04:14:29 -0700 (PDT)
Message-ID: <fa258ad4-1efa-4fe8-9636-d70c5ea9c8e1@oss.qualcomm.com>
Date: Wed, 17 Sep 2025 13:14:26 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 9/9] power: supply: qcom_battmgr: handle charging state
 change notifications
To: fenglin.wu@oss.qualcomm.com, Sebastian Reichel <sre@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
        Bryan O'Donoghue <bryan.odonoghue@linaro.org>
Cc: Subbaraman Narayanamurthy <subbaraman.narayanamurthy@oss.qualcomm.com>,
        David Collins <david.collins@oss.qualcomm.com>,
        =?UTF-8?Q?Gy=C3=B6rgy_Kurucz?= <me@kuruczgy.com>,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, kernel@oss.qualcomm.com,
        devicetree@vger.kernel.org, linux-usb@vger.kernel.org
References: <20250917-qcom_battmgr_update-v5-0-270ade9ffe13@oss.qualcomm.com>
 <20250917-qcom_battmgr_update-v5-9-270ade9ffe13@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20250917-qcom_battmgr_update-v5-9-270ade9ffe13@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTE2MDIwMiBTYWx0ZWRfXzQWuiKrpxsb6
 X3D4p3SsyZjjnAy3aw1KdkmuosYGVcnjMri6yDwtd+uyO0ugyi1fj/cTMCw5/u/rL9/SzjhIV3B
 Y2fBNHAAT6/flK9cY2GM8xXt9Ei+9W2BIXOFTIkYGWv0QHIjM3jgHHXcVAtLzfS3Ay8tc5zm0aG
 qptrSnk9FjuJIPvIn+7zcgj+yFRv5wEb/xs4N+JcoIEk8lq9MR02KkRx1dCXGXOnU5sV0n0QFL4
 p/+zmGApDYFmqaYKj6ReLYNmyna+T3SOaOW/pb3JeIY+c/MxA63gDOPlLG/shNvBm98eE4jminq
 6wKp17dG7QY7sTwLI7jbI5zxLevFDpVneePKYY3TJRrO3q2d2vc4cRZ6X7O205SnZWhaJaXBOZf
 U/PcnVz5
X-Authority-Analysis: v=2.4 cv=MMFgmNZl c=1 sm=1 tr=0 ts=68ca9817 cx=c_pps
 a=WeENfcodrlLV9YRTxbY/uA==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=EUspDBNiAAAA:8 a=QX4gbG5DAAAA:8
 a=DHQ_eFf6vkL4qwDZSiYA:9 a=QEXdDO2ut3YA:10 a=kacYvNCVWA4VmyqE58fU:22
 a=AbAUZ8qAyYyZVLSsDulk:22
X-Proofpoint-ORIG-GUID: xzHJpeTF5NS66AqXrD5KlceOvyypktVv
X-Proofpoint-GUID: xzHJpeTF5NS66AqXrD5KlceOvyypktVv
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-17_01,2025-09-17_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 clxscore=1015 suspectscore=0 bulkscore=0 spamscore=0
 malwarescore=0 phishscore=0 impostorscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2509160202

On 9/17/25 12:15 PM, Fenglin Wu via B4 Relay wrote:
> From: Fenglin Wu <fenglin.wu@oss.qualcomm.com>
> 
> The X1E80100 battery management firmware sends a notification with
> code 0x83 when the battery charging state changes, such as switching
> between fast charge, taper charge, end of charge, or any other error
> charging states. The same notification code is used with bit[16] set
> if charging stops due to reaching the charge control end threshold.
> Additionally, a 2-bit value is added in bit[18:17] with the same code
> and used to indicate the charging source capability: a value of 2
> represents a strong charger, 1 is a weak charger, and 0 is no charging
> source. The 3-MSB [18:16] in the notification code is not much useful
> for now, hence just ignore them and trigger a power supply change event
> whenever 0x83 notification code is received. This helps to eliminate the
> unknown notification error messages.

Thank you for explaining the technical background.

Please hit enter somewhere in your commit message, this is a very
long paragraph, making it difficult to read.


I believe this maps to:

0 -> POWER_SUPPLY_CHARGE_TYPE_NONE
1 -> POWER_SUPPLY_CHARGE_TYPE_TRICKLE
2 -> POWER_SUPPLY_CHARGE_TYPE_FAST (or _STANDARD, I see battmgr code
reports them both as 2)

However, we already set it to none/trickle/standard(taper) based on
the usual notifications, so I'm not sure if these are more common or
arrive outside the normal state changes - if so, perhaps we can take
them into account as well?

I think it also warrants a:

Reported-by: Sebastian Reichel <sebastian.reichel@collabora.com>

Konrad

