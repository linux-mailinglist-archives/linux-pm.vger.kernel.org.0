Return-Path: <linux-pm+bounces-38105-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5AA3DC6265E
	for <lists+linux-pm@lfdr.de>; Mon, 17 Nov 2025 06:23:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 627813B1666
	for <lists+linux-pm@lfdr.de>; Mon, 17 Nov 2025 05:23:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BF4830E82C;
	Mon, 17 Nov 2025 05:23:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="V3Da/Bf4";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="X1U5p7+D"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67F0B30E0F5
	for <linux-pm@vger.kernel.org>; Mon, 17 Nov 2025 05:23:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763356981; cv=none; b=tRNGHBIvHlVQxY10Q6olBSXNJYa30i1bGQi6fX+cu2XsEs6yp65/MwPkDMGjat9EA53Xbk+LasM66H7fpUnso89PMpLTVs2Wf4pGbWVzHPAfte6ZByNy/jHfOza14vPd32bx6ShL1pjt+umO2+qYlZ3Pd4EyRcie+Lmsf7ldJ7Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763356981; c=relaxed/simple;
	bh=w6wiug95Uep2sy5YF1FeMxWbhb0PjR6EaPR77uu3r9I=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QMhRKaYtLvIPSzdlDpRwlW3I29JhW4R9xt13PueVf1UWWGmySnawSiCPqx+YSBLlVVhcTkxDmQfZwwdYipjQsHzbsMa8TSfP0gVTaX/UrC0zblMGzzFTrpsumhxPLA+imWWmONxmndWWU48amdOeZhVJ9PYmixumo4m+ZeK1LlA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=V3Da/Bf4; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=X1U5p7+D; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5AH4nuoa3318434
	for <linux-pm@vger.kernel.org>; Mon, 17 Nov 2025 05:22:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	Gor2wK9jXbtsJbqjtAgbnKhqnzfjD4B3yGBZu9lQGLo=; b=V3Da/Bf4KpAbk9zE
	0S16MAr7Hiu+5dz+MNj1x42j8NwoZ5fvGQeGcxJGACT0/jzGXvWyjLeJol+t7Dnb
	NiZBSKILWDiI5+8fRddONEJHG69L7qXZ9PZk1Ybw8aaKi+VLFvr5KX4zNfJVrXJK
	MK9PcNBK+MOieQicUvynnnHK6W/sQJo9UQx7uSPBtcvNNCB/yaWKTsOVVl3yGnHL
	dE07IVN3IR/fOtCADoZhQ1opJ0DY4fExZm9axyfB0WzU8/bVVheQTg5JcMOHkszL
	rCLnREdgtkM3wXDiMAOFl15E1Kk0rYpFxCEEk/8RrI+CXSK7OpJ02p34GdxHkv9S
	B/9tWQ==
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com [209.85.210.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4aejm5bef2-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Mon, 17 Nov 2025 05:22:59 +0000 (GMT)
Received: by mail-pf1-f198.google.com with SMTP id d2e1a72fcca58-7baaf371585so1922996b3a.0
        for <linux-pm@vger.kernel.org>; Sun, 16 Nov 2025 21:22:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1763356978; x=1763961778; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Gor2wK9jXbtsJbqjtAgbnKhqnzfjD4B3yGBZu9lQGLo=;
        b=X1U5p7+DtqY7RhozpNbF/4NsUPGx4/pm78oKX3LD8b1r/PC61P59fnmOt1DCMHs+DB
         I7e4M9SP9AHeI/VVKDpe8EyriiCgkX2mrG/yhSqlzccqefL5saTa99zy3NQ6NqF/a1vV
         GmXYQ4PE/oU8TvAPmqBU7r5loMH7zvt/QMlghEtqUB1ITaNe0qFLEvT6pIjBkTTYAAba
         9mltIAk7orHUuaGGal+X7PuLxS69Rs85mXKK+rJ8CmD2UCndDPwVqQdquke7C9bVfJyW
         IAJ4VjsICGDvFRRYt4CJbhApwS8V1kc8UUde+T02AlAZRwqGddZZpIgiX93wqJYSW1t8
         vjZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763356978; x=1763961778;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Gor2wK9jXbtsJbqjtAgbnKhqnzfjD4B3yGBZu9lQGLo=;
        b=O1PJ/HwD0X9P4HzGXPSGaIbFHbGrU8mCTZUtSfrPmWIrIXeCsIHTs4M3wygbHPooG/
         Qizf6GCBq0wj3iudrZYEhrT2pMM0Z1hz3bDPBnuqAu/dr8pVrO31QMYHxS4J53fKL3v7
         pFca3gYkwPkpkKS209KxjJVMOC+K8a5tpvPGPuEz3GMleDkn2ipwa+xaMIavMGYh/nco
         RRQOvv/C8FP0QmbLy4a9XqrwYIKOoOnbVBt1iLMHyWoCUfOfV4HhZBdfkOCzWThZtzUY
         p8xJzenkHbcBTCYp+v2N0v8ZhXbxuNEF+OnpGTzISjA7x7WilWFkanp1jt8fV9MLXshw
         0RAg==
X-Forwarded-Encrypted: i=1; AJvYcCUOTDkAr4F/KyFoB4aTyO68xa3KeHcLfaGSy14EF21dn7PbdlO1YWBBJl2cGD027f6rqA1rxmHexQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YzfSORU448+ZZOyLkmTEZvKhhonVRKrgz1EOuz/kvxMRt8Rnj4M
	fJ1e8cBethJij33TF9XquwC1dvvc6tDdtNvodslrSukgeyTKGwZl1+G9DN+Yf2yQHkLyyk5pYK6
	RczfpEMiFPn92O7R7+LzHBiucCkKO7JefvmmsASVo2LW6C4o6G8XuG55dCdZ2Fg==
X-Gm-Gg: ASbGncuPJBu/7vImlzRj+5hSaf6bjdhHvK2GH1ip4RVxUMq5tpC7zBwrINcD5rk/xvn
	iDWXwhr7nQz15yAY9LQxTXe9vHs1Cq4GQuYLxFEZOvm4vvTG2bedDukeFI8zCKZJX8M39iIZwjE
	LQLPm58N0ZUIhfJwHBG2mBWt0cG8Z4vw28dco+w2ywfO+P/XgaaVxbMRhasaW00PIENpVAe3yiQ
	BhXukNGt3iVBUKuJmrNQMDTu77sygXpW7RzcK3EMSDLYq64RQwnz/nfgxUBebhoz07d+dkS/tuI
	ieudKJbszRfjEz2Ug4TUMW4sKuXHnBO6aWI0JKpHZV9NrkR/2h8DqexpblIE5EoQ6/zFLsXHyaG
	RyTyi88cuVbYP4krB1kT9CZkJKr0r6Dwo9dh19nc7HzMvXTGpX4ZLqF+G1gedPJmRxcWh
X-Received: by 2002:a05:6a20:2587:b0:35d:cc9a:8bc1 with SMTP id adf61e73a8af0-35dcc9a8d2fmr4842115637.27.1763356977995;
        Sun, 16 Nov 2025 21:22:57 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGyqruXMe9cRMlaR2MRqRPfjUA0+sSI3KlT2wMD9cgAUh7FbBipxgghyFbOyvMu+Y0PCnyIcw==
X-Received: by 2002:a05:6a20:2587:b0:35d:cc9a:8bc1 with SMTP id adf61e73a8af0-35dcc9a8d2fmr4842099637.27.1763356977458;
        Sun, 16 Nov 2025 21:22:57 -0800 (PST)
Received: from [10.133.33.145] (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7b9271505acsm11701649b3a.35.2025.11.16.21.22.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 16 Nov 2025 21:22:57 -0800 (PST)
Message-ID: <88535058-f385-4fb0-9b4a-bf6d854f7107@oss.qualcomm.com>
Date: Mon, 17 Nov 2025 13:22:51 +0800
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] power: supply: qcom_battmgr: support disabling charge
 control
To: Val Packett <val@packett.cool>, Sebastian Reichel <sre@kernel.org>,
        Neil Armstrong <neil.armstrong@linaro.org>
Cc: Sebastian Reichel <sebastian.reichel@collabora.com>,
        linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20251012233333.19144-2-val@packett.cool>
 <20251012233333.19144-4-val@packett.cool>
Content-Language: en-US
From: Fenglin Wu <fenglin.wu@oss.qualcomm.com>
In-Reply-To: <20251012233333.19144-4-val@packett.cool>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTE3MDA0MyBTYWx0ZWRfX8VawI6i7I6xI
 O1n2DtK6OAWhSgk4qe4K2mT8ow/vIacpXz42lbwqS5U61p1p4d08YcZuPvunoHHAbI7eP9tPInW
 5NR+/skyaZ3+ZRhs5BoA8SRwWALZUOk7k/P4bFHI8yE1XYM/CH3hmOCxaj3Tvtiw1z2pepH7cfs
 zfwTR5Vq5sBHgdKGmfmG9VGmAT1G520co0oDYl51Mi43Ggbo2Aw0PRWZosTxlHXQ9YrI+I0njSi
 SAomBtr9wtxslK6FVLJaDe7iI2X6beNfcWT0dGKAxuut7XXjbeUFawCPkM2ATYp0/+cUaJkDrFh
 skPkCN69UA77pKpRCW7ri6lTjKiS0NUYst2omr3EljrIBmCMgT1oi0MP91M5RH/JVcfvQ6BX/7A
 rNNJJnOeqVb6rQKt58qIxMXj1fh2EQ==
X-Proofpoint-GUID: xHzq4KGsKtn_4nX571UhHUz8CTt4XC28
X-Proofpoint-ORIG-GUID: xHzq4KGsKtn_4nX571UhHUz8CTt4XC28
X-Authority-Analysis: v=2.4 cv=Pb7yRyhd c=1 sm=1 tr=0 ts=691ab133 cx=c_pps
 a=m5Vt/hrsBiPMCU0y4gIsQw==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=IkcTkHD0fZMA:10 a=6UeiqGixMTsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=q9oTrLaHPds-TktH9FUA:9 a=QEXdDO2ut3YA:10
 a=IoOABgeZipijB_acs4fv:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-17_02,2025-11-13_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 adultscore=0 lowpriorityscore=0 spamscore=0 clxscore=1015
 priorityscore=1501 suspectscore=0 bulkscore=0 impostorscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2511170043


On 10/13/2025 7:32 AM, Val Packett wrote:
> Existing userspace (in particular, upower) disables charge control by
> setting the start threshold to 0 and the stop threshold to 100.
>
> Handle that by actually setting the enable bit to 0 when a start
> threshold of 0 was requested.
>
> Fixes: cc3e883a0625 ("power: supply: qcom_battmgr: Add charge control support")
> Signed-off-by: Val Packett <val@packett.cool>
> ---
>   drivers/power/supply/qcom_battmgr.c | 12 ++++++++----
>   1 file changed, 8 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/power/supply/qcom_battmgr.c b/drivers/power/supply/qcom_battmgr.c
> index c8028606bba0..e6f01e0122e1 100644
> --- a/drivers/power/supply/qcom_battmgr.c
> +++ b/drivers/power/supply/qcom_battmgr.c
> @@ -257,6 +257,7 @@ struct qcom_battmgr_info {
>   	unsigned int capacity_warning;
>   	unsigned int cycle_count;
>   	unsigned int charge_count;
> +	bool charge_ctrl_enable;
>   	unsigned int charge_ctrl_start;
>   	unsigned int charge_ctrl_end;
>   	char model_number[BATTMGR_STRING_LEN];
> @@ -659,13 +660,13 @@ static int qcom_battmgr_bat_get_property(struct power_supply *psy,
>   }
>   
>   static int qcom_battmgr_set_charge_control(struct qcom_battmgr *battmgr,
> -					   u32 target_soc, u32 delta_soc)
> +					   bool enable, u32 target_soc, u32 delta_soc)
>   {
>   	struct qcom_battmgr_charge_ctrl_request request = {
>   		.hdr.owner = cpu_to_le32(PMIC_GLINK_OWNER_BATTMGR),
>   		.hdr.type = cpu_to_le32(PMIC_GLINK_REQ_RESP),
>   		.hdr.opcode = cpu_to_le32(BATTMGR_CHG_CTRL_LIMIT_EN),
> -		.enable = cpu_to_le32(1),
> +		.enable = cpu_to_le32(enable),
>   		.target_soc = cpu_to_le32(target_soc),
>   		.delta_soc = cpu_to_le32(delta_soc),
>   	};
> @@ -677,6 +678,7 @@ static int qcom_battmgr_set_charge_start_threshold(struct qcom_battmgr *battmgr,
>   {
>   	u32 target_soc, delta_soc;
>   	int ret;
> +	bool enable = start_soc != 0;
>   
>   	start_soc = clamp(start_soc, CHARGE_CTRL_START_THR_MIN, CHARGE_CTRL_START_THR_MAX);
>   
> @@ -696,9 +698,10 @@ static int qcom_battmgr_set_charge_start_threshold(struct qcom_battmgr *battmgr,
>   	}
>   
>   	mutex_lock(&battmgr->lock);
> -	ret = qcom_battmgr_set_charge_control(battmgr, target_soc, delta_soc);
> +	ret = qcom_battmgr_set_charge_control(battmgr, enable, target_soc, delta_soc);
>   	mutex_unlock(&battmgr->lock);
>   	if (!ret) {
> +		battmgr->info.charge_ctrl_enable = enable;
>   		battmgr->info.charge_ctrl_start = start_soc;
>   		battmgr->info.charge_ctrl_end = target_soc;
>   	}
> @@ -710,6 +713,7 @@ static int qcom_battmgr_set_charge_end_threshold(struct qcom_battmgr *battmgr, i
>   {
>   	u32 delta_soc = CHARGE_CTRL_DELTA_SOC;
>   	int ret;
> +	bool enable = battmgr->info.charge_ctrl_enable;
Can you initialize "battmgr->info.charge_ctrl_enable" in 
"qcom_battmgr_charge_control_thresholds_init()" based on the value 
reading from the nvmem cell? Otherwise, it would have a false value by 
default and a single write to the end threshold would result disabling 
the charging control instead.
>   
>   	end_soc = clamp(end_soc, CHARGE_CTRL_END_THR_MIN, CHARGE_CTRL_END_THR_MAX);
>   
> @@ -717,7 +721,7 @@ static int qcom_battmgr_set_charge_end_threshold(struct qcom_battmgr *battmgr, i
>   		delta_soc = end_soc - battmgr->info.charge_ctrl_start;
>   
>   	mutex_lock(&battmgr->lock);
> -	ret = qcom_battmgr_set_charge_control(battmgr, end_soc, delta_soc);
> +	ret = qcom_battmgr_set_charge_control(battmgr, enable, end_soc, delta_soc);
>   	mutex_unlock(&battmgr->lock);
>   	if (!ret) {
>   		battmgr->info.charge_ctrl_start = end_soc - delta_soc;

