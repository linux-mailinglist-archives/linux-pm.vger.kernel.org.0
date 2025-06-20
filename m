Return-Path: <linux-pm+bounces-29169-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7DA81AE208D
	for <lists+linux-pm@lfdr.de>; Fri, 20 Jun 2025 19:07:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9A612165F48
	for <lists+linux-pm@lfdr.de>; Fri, 20 Jun 2025 17:07:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 809F72E8E1D;
	Fri, 20 Jun 2025 17:07:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="jGFbBnwr"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA5D52DF3CF
	for <linux-pm@vger.kernel.org>; Fri, 20 Jun 2025 17:07:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750439266; cv=none; b=sgwO+ACqrl1gpyq1YWaqt/DHmxI1Wwn3MQcTTGQVrIlwoyWpU4Ff0+AJDmeXEFnqyBPlFcGvnsEytAwroJt9jeSMfXkrMaYuQkym7UnRJuly+7WEkOni99YywI0psRSgWG6dHRea6Ftk8YFZswgGbuNtOlwU4bJdBzZcjsC7XTs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750439266; c=relaxed/simple;
	bh=TJoa2xPImS4wAM1uUVWoOFg2ZyzLr2gFfx8eCrn+wM0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=a14Kns4wt1F2hCg0VhGrztKwvDlELDm/AJP/lcAlk4jKrWe/ghnDTksMTrtLwP0lNKSvrE7trI6bo1TxGZmx4Tf36YLemVDRbiEjbbARsZVeSZPmbxrDKOY1D/yhTUWXKPNZtsiEK3j9UUen3Vz/fE+L71IYg46sZD5U5Ebu7So=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=jGFbBnwr; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55K75VSu016711
	for <linux-pm@vger.kernel.org>; Fri, 20 Jun 2025 17:07:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	hKKwQ1dKYiwuL/gFRwwSIgyThK0XHURSCnVrX9k5gJg=; b=jGFbBnwrmAaYrBWh
	0xzZGscS1uyi5Kkfttcn23aT9G8l2Rm+6h0wVa2FWYAxlCSHsrN+K6+AVY9Vo3i4
	B67RczhwXtXSPBUggERRf2kSNESIGDWPQ4bN53te4EnYjnLbLzOoC2LoLrIMAQ5T
	f4zz2zR5SK2FeIj62BUGC3ly6O1DF72RH9+wbt5Cfz96BOJaHz/4AznNj7EAVMj6
	ESsiyHmo0bWm5zfZJJ7eL2W6BfwOhcPoMp9Z3p2np17DhKDPhQiaTe+rJSvcuyiq
	qiDF1RABlLwmL7Ec51bOyE2nVy1mWfhM+1oUc3C4LQnBPTSrH21iu/J7V/rVMB2c
	zdgdHQ==
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com [209.85.219.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4791cs3qyh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Fri, 20 Jun 2025 17:07:43 +0000 (GMT)
Received: by mail-qv1-f72.google.com with SMTP id 6a1803df08f44-6facbe71504so4615146d6.2
        for <linux-pm@vger.kernel.org>; Fri, 20 Jun 2025 10:07:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750439263; x=1751044063;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hKKwQ1dKYiwuL/gFRwwSIgyThK0XHURSCnVrX9k5gJg=;
        b=EkKjqYVOT3gIdV61Ck6GhYkvQmGIfh4UQMbjT4n8wc1IZY2atlZ285XBQWqDTnW3Mn
         p97ESOITnENCC7EcWl3sDFiJPRrvkee0u3hNgM7NoRZA9SxQuhCNwwhEmGPCqUEfI9tt
         7FAIgPpaH8YCUaiRee2i7M0HXL8Fzl1catFlZREW3gDLcLcRAy0bH0v/izASIC8bhOeq
         NbN3E0I2zHGQnR816JbcohRNfxvR1GFt7KD00c1DYVQutU2yTJ5wHOuHoSw2MqXhbRIM
         2Vk8WEKt/q5XrkhWd722b0eW5B7yInXjZDV+w9GJHZDxMPLXs3Nuiw+MsU/ZwkalLSg9
         kc2A==
X-Forwarded-Encrypted: i=1; AJvYcCWAZQxcZ6GpAWRDFmDaCsHohZkrTtNTaKnKlJoFz0nYvbRfYdx2TTipuNn3lah88uGcsU1/jW/wLw==@vger.kernel.org
X-Gm-Message-State: AOJu0YwC/rKC5CeLD1ninv6BknYGohho70URt+PQQVYcOCB8c3pqBzrk
	dsTyuCNnf1rjtqc18d0daxN6uYnjekExzj/7otJ95i0Cja1IS8fBvjl/0iDOFGdeDpF21mezdk+
	50TmqPXcWCYMdOIjRU8xMxzLvQ3mBgIYkRR5H5UFOU/6frxVip1KKMj0enZl5qw==
X-Gm-Gg: ASbGncsagAV6AqDnA6uHc8+LKixLtzeZmue9+7Xv/piWB7FWV2m2UyKnlMYeBiy5N9p
	YeMp1TGVTLS8WexDfASAyppjoQPDzkN0UKQB987ZIjTBPVAj5CDJLsMwU6zGEjWx8ZuofUUW/Cu
	4yvXJ8894kfJPCsae6PtdDPxZDYtFr1d9c6JuYSEeYNy35zrVs2bYb+XeMZ2afM9kb9hoFn3zeU
	ER0FefzzNs0pjPXJPhRtf5wKOF9BWyJ25FOOSBiF1svkmcq8yo+4ql9TQwuImwMuCh61kpAnBYh
	3kiib7uyoiHMQX2nZd0kXktFHineCXvtWWM2Y85wuf/1ewdJYOuMlKlgb0/8z0ujwy1Unq9xric
	UmIU=
X-Received: by 2002:a05:620a:f10:b0:7d3:8e88:dc0a with SMTP id af79cd13be357-7d3f9916bfamr156998885a.11.1750439262665;
        Fri, 20 Jun 2025 10:07:42 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEVSWLQFC0kpw0PBqz9gCS9IFs8NVF3u0lcuSEdXmZtlYNC6FTQskFyKD9xoz9LSWWobdlLxQ==
X-Received: by 2002:a05:620a:f10:b0:7d3:8e88:dc0a with SMTP id af79cd13be357-7d3f9916bfamr156996185a.11.1750439262103;
        Fri, 20 Jun 2025 10:07:42 -0700 (PDT)
Received: from [192.168.143.225] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ae05433aa56sm188279866b.183.2025.06.20.10.07.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 20 Jun 2025 10:07:41 -0700 (PDT)
Message-ID: <efa03e46-35c1-468e-a188-8e857ecd4b8b@oss.qualcomm.com>
Date: Fri, 20 Jun 2025 19:07:39 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 07/11] power: supply: qcom_smbx: bump up the max current
To: Casey Connolly <casey.connolly@linaro.org>,
        Sebastian Reichel <sre@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Kees Cook <kees@kernel.org>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Sebastian Reichel <sebastian.reichel@collabora.com>,
        linux-hardening@vger.kernel.org
References: <20250619-smb2-smb5-support-v1-0-ac5dec51b6e1@linaro.org>
 <20250619-smb2-smb5-support-v1-7-ac5dec51b6e1@linaro.org>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20250619-smb2-smb5-support-v1-7-ac5dec51b6e1@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: t_0azOoPKBLVtHZyHdRw9d41-SsYFy4-
X-Authority-Analysis: v=2.4 cv=BoedwZX5 c=1 sm=1 tr=0 ts=6855955f cx=c_pps
 a=7E5Bxpl4vBhpaufnMqZlrw==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=6IFa9wvqVegA:10 a=KKAkSRfTAAAA:8 a=rhSfmRiNZEirnHGn6ZAA:9
 a=QEXdDO2ut3YA:10 a=pJ04lnu7RYOZP9TFuWaZ:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-GUID: t_0azOoPKBLVtHZyHdRw9d41-SsYFy4-
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjIwMDEyMCBTYWx0ZWRfX8gUk5QSbXmgf
 ckxrL6TSz6xR6INc2o4qBKBjHsUiQA+1Zdj7gVWBZAAoKuJ4hSgT5cJK8IQphIQqZ/8VCB3FiaD
 dCBGDDZ/F3H8kqFQXlSUKWvq5Xh8zXzDeOYuUyCLF23ysi4t2z5z7Rp4b9qoRYBkG8yKmo82/JH
 rw5XKYsLbua1cP2j7G+uoayLD7IIf55p2ODLVm64F2prmpkjcctzVneq+OaZQ39VDsvYNvChf3K
 D59MJ+x2a1WZOO4EOx5kZ/ofd0xNcldrHh2BuW5it+i7qEeABIK7kqTp0Zl5mN437z/9DpNwyUq
 TWv+F50RBiXt8gVQDQY/+v74wA+AWEWaMQQ4faUFvcJWddzQ7GJlMHk9WGmDAFG9VrM1SDQiUQ+
 neXtwI91K9gpMPUZ4cIeU2UL4n9xHlT6Xi5S0U1pEh7W0prWOV4uo1M8X/iJQFybXqTxnUHT
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-20_07,2025-06-20_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 mlxscore=0 adultscore=0 phishscore=0 lowpriorityscore=0
 mlxlogscore=999 bulkscore=0 malwarescore=0 priorityscore=1501 clxscore=1015
 spamscore=0 suspectscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2506200120

On 6/19/25 4:55 PM, Casey Connolly wrote:
> I set a super conservative current limit since we lack many of the
> safety features (thermal monitoring, etc) that these drivers really
> need. However now we have a better understanding of the hardware, it's
> fine to bump this limit up a bit, devices can additionally set the max
> current via devicetree instead.
> 
> Since this is common to smb2 and smb5, move this write out of the init
> sequence and into probe proper.
> 
> Signed-off-by: Casey Connolly <casey.connolly@linaro.org>
> ---
>  drivers/power/supply/qcom_smbx.c | 22 ++++++++++++++--------
>  1 file changed, 14 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/power/supply/qcom_smbx.c b/drivers/power/supply/qcom_smbx.c
> index 7fc232fa7260a7422ac12a48686cd7d396edd9a4..d1607674d291d6ef5762d35acd3330e2116f41a3 100644
> --- a/drivers/power/supply/qcom_smbx.c
> +++ b/drivers/power/supply/qcom_smbx.c
> @@ -875,16 +875,8 @@ static const struct smb_init_register smb_init_seq[] = {
>  	 */
>  	{ .addr = PRE_CHARGE_CURRENT_CFG,
>  	  .mask = PRE_CHARGE_CURRENT_SETTING_MASK,
>  	  .val = 500000 / CURRENT_SCALE_FACTOR },
> -	/*
> -	 * This overrides all of the current limit options exposed to userspace
> -	 * and prevents the device from pulling more than ~1A. This is done
> -	 * to minimise potential fire hazard risks.
> -	 */
> -	{ .addr = FAST_CHARGE_CURRENT_CFG,
> -	  .mask = FAST_CHARGE_CURRENT_SETTING_MASK,
> -	  .val = 1000000 / CURRENT_SCALE_FACTOR },
>  };
>  
>  static int smb_init_hw(struct smb_chip *chip)
>  {
> @@ -1029,8 +1021,22 @@ static int smb_probe(struct platform_device *pdev)
>  		return dev_err_probe(chip->dev, rc, "Couldn't set wake irq\n");
>  
>  	platform_set_drvdata(pdev, chip);
>  
> +	/*
> +	 * This overrides all of the other current limits and is expected
> +	 * to be used for setting limits based on temperature. We set some
> +	 * relatively safe default value while still allowing a comfortably
> +	 * fast charging rate. Once temperature monitoring is hooked up we
> +	 * would expect this to be changed dynamically based on temperature
> +	 * reporting.
> +	 */
> +	rc = regmap_write(chip->regmap, chip->base + FAST_CHARGE_CURRENT_CFG,
> +			  1950000 / CURRENT_SCALE_FACTOR);

In surprise to no one, I'm really not sure..

1A is not a bad default value if no other information at all is provided.
I'd say deferring this to DTS would be the best, so that if the programmer
knows that e.g. the batt/skin temp sensors are there, it takes an explicit
addition to allow more current

Konrad

