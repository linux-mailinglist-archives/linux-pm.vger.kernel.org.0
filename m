Return-Path: <linux-pm+bounces-42430-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wBn4HlIBi2npPAAAu9opvQ
	(envelope-from <linux-pm+bounces-42430-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Tue, 10 Feb 2026 10:58:42 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id CF43B119458
	for <lists+linux-pm@lfdr.de>; Tue, 10 Feb 2026 10:58:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 30B1D3034785
	for <lists+linux-pm@lfdr.de>; Tue, 10 Feb 2026 09:58:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE57334253B;
	Tue, 10 Feb 2026 09:58:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="mgqPkqGP";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="A1lGwSfB"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53AF6341AC7
	for <linux-pm@vger.kernel.org>; Tue, 10 Feb 2026 09:58:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770717519; cv=none; b=f3XQ5kTfCS8vLSqFtSDfJM0dNnJbeaWuuL0H3aljF/p6lScGio6Ru4G1jlBbz7n34RKJHYJXXspc6bSy3vZ6WrQFkC1BLE1wawWvV9trXjbp65ME10y80oo4KfqohVc6Ia6n84YNqNsKUh4eYqYmz+uTTHjIpPfyEwQ86bEZhyE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770717519; c=relaxed/simple;
	bh=O633pzcpYpaVv0iUzzYIagk/jGUaHFDdI2DqNIk4ytg=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=TUBvGKILHDI0RIN0SPHW3DnM4AtWDhATMQBCtwXxb6Kc9XuRYiKFvN7DNSsPjixxkokHjg7Mmpw+6nsAA/jcFywK9D5qqVFmv+6V3MmBil1xb2igR5icfjD8yEIkVuB1iJ0VSzYx0svLN8EWqoP5RuMuj1lGyVdYSWPGR352bEg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=mgqPkqGP; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=A1lGwSfB; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61A7Z9Ud2169426
	for <linux-pm@vger.kernel.org>; Tue, 10 Feb 2026 09:58:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	J02eDS5+OrtFybete0MtrhNyMJZo6fotYJ3t3dv6qwg=; b=mgqPkqGPjdq1Dt4C
	UaX7wwyZ32sGgWTuR8t/jHHDXXVUPaPQCa1tMTdCiLp1mXjw+TwnOIYtAw9zHEes
	X+rewkVYueDYxXTaavIWkJ96LEx+tJf/PF+/JxqzosWL6N0gniQpX1kU8kcnRDhf
	h+4ViGNqifDk8zscwmQwTnnIkPVE6Cg3JzgI/VpiPYmQmd7m7uIrck3THh3u7Xks
	N9NjFbcNwr5qtWWFZJadldc85sQqepK2p5/yhq4mvbvQE3fcpJ2GizUdlsrGHYEx
	j7m/QMSlR13QWFAqYO61U7X1cc55CcmcQ9V/xwKDCX0pdaHFiR+IIrYN8ttxc2Bj
	WijUtw==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com [209.85.222.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4c80drrfyd-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Tue, 10 Feb 2026 09:58:36 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-8c6d6b0f193so119675685a.1
        for <linux-pm@vger.kernel.org>; Tue, 10 Feb 2026 01:58:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1770717515; x=1771322315; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=J02eDS5+OrtFybete0MtrhNyMJZo6fotYJ3t3dv6qwg=;
        b=A1lGwSfBPoFrZRIaPFck0F/Dx7dMkFhRJgXQ1dwKfVal2wqjqhBJ8TBfXe1pWPilnx
         I/aWmPeiUg1d/d3VqzPk3lXfokBG3zHTJM0GBR8a0AXOzyrjuyAhSYzG6n40mk1nIygn
         0T7E326COeW2yZEP7xgAU17ywFfXrC1jnSfCoVUoTGxkLxa0T/xjeXr01cPbk5/TmlAi
         vyR1qebI1DGsH/3VRJgYPykE2Q3lSKmaUgnyKbfQlPLMRJhQ9ZcH27C2gb5Q/KPNXvZX
         sGfR3sP4AY9iaeXoXlSELs2LQdhbvZIYnvIvSRfozv+QFNLxJ2QTyT104GQieZIO56xH
         pn9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770717515; x=1771322315;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=J02eDS5+OrtFybete0MtrhNyMJZo6fotYJ3t3dv6qwg=;
        b=XgL6yUYi9/sSjRevnvFcQygCPhgg1+Qwd29VV6iiQ860XaCBy+Xav3ZEI3I8B+VIuT
         jInSyeE1vVcE7an988EyguhTtqm1TU3pX8zajmdJecprM+1OdQRXFTH9fcrmnV89CWGi
         Y0RJUrWmteN1+UYOJWjCt9FfcRtOH62z4+H+fwiLrimtAixWQxs+SfaZKOic2+vHtR1N
         b/Of0FuQ7Dl8kVOi2cWngEDds8iha3kOsYjng7T/WDdZjNxvdfVsrgbZ+wNTZqydadLJ
         pgzatjange+XwocFoqnGXKrLxRv0mIc28IbOwi2kAH4UXC/u3Wa1ZKw4n+egyPlQTY72
         6pRQ==
X-Forwarded-Encrypted: i=1; AJvYcCVJvnLw4zX/d/Sxf1AMQ6EFthBQwTI1+Imy0QMqxQ3/ep1TK0amam7faxiu4fPFdUpErTar4VogVQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YxH6ckA4Hb60p9d3wTur/ujB/9hxyWOabBxw9gfL6g1nCF/wwLC
	/zO29wGOVw8wR/4eEMEb8PYcScOsQOr/1r96ksJzpQjPQUcTIRZcKCDadMW5S9KNN3lyH7zGO9f
	MNxiHsMmvn8GVeEpJT+16BCLFBiGNn/5ss/U79/eldLCWAcCD9txenL8gpRwkvg==
X-Gm-Gg: AZuq6aJWQsSR6ZLBC1tRh38+KIz4j90TNKVHHNIkZCOgRJvR1DVd79FiQXEO1VkKVB9
	Uz+X+1R1t2YbcXfIS3iYRevYOvgnhYGkjOyspl4rOg7fq08tdkzfNk8UUyeV3s+deYk0Ym3s6M0
	vTa6EVG7bHHl8Q1whoxJwO1C7CUHkmb/2SsBh766cVVVMBRtTu3oCT+66DYZAXxDo0QfkuLKcgf
	G7Dr/ffKXiFw90WAi3CHwc33rwFqbwaBUayzyE09o923YOXTwCszUH4hPNo/ROd3G8w5K8hAIoW
	mgiy8YARIOqYH/9gKJY51vpb3qPJObBYHG8609zY2KeVh4ufdmelik6IyI49e4b+I8BuK1lKRoq
	FM3b50TsAIs9RVTlshWXYYk2KZ4RzM6Ux0qv5YA+46PSIRRcSB9Za/tRns4UQj+0DKJY5tTZFeN
	9L/EU=
X-Received: by 2002:a05:620a:45ac:b0:8c7:110c:762f with SMTP id af79cd13be357-8cb1fee2ebfmr111383685a.4.1770717515561;
        Tue, 10 Feb 2026 01:58:35 -0800 (PST)
X-Received: by 2002:a05:620a:45ac:b0:8c7:110c:762f with SMTP id af79cd13be357-8cb1fee2ebfmr111381685a.4.1770717515161;
        Tue, 10 Feb 2026 01:58:35 -0800 (PST)
Received: from [192.168.119.254] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b8edacb18aesm501973166b.41.2026.02.10.01.58.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 10 Feb 2026 01:58:34 -0800 (PST)
Message-ID: <cb5c4a0d-9f4e-4338-9c49-8f13c2a5eccc@oss.qualcomm.com>
Date: Tue, 10 Feb 2026 10:58:31 +0100
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] thermal: qcom-spmi-adc-tm5: Correct the voltage-code
 scaling for HC
To: Richard Acayan <mailingradian@gmail.com>, Lee Jones <lee@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Amit Kucheria <amitk@kernel.org>,
        Thara Gopinath <thara.gopinath@gmail.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Zhang Rui <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>,
        Stephen Boyd <sboyd@kernel.org>, Dmitry Baryshkov <lumag@kernel.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-pm@vger.kernel.org
References: <20260210021819.12673-1-mailingradian@gmail.com>
 <20260210021819.12673-3-mailingradian@gmail.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20260210021819.12673-3-mailingradian@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjEwMDA4MyBTYWx0ZWRfX3D6cGCK9OGiR
 c4o96AoOJlCaBKVka6M/HVn9yox5F4fZYryKWkpFKL8syIfn04NNt8f35UgilL5JbbbY1vz7eDl
 swiuuWBTY5LGbtUksq4xgfPhmtpnMjKAyxIxEaPINdYmMqA9GxOpZ8F3UYceClw4YMLN7pNg/zz
 pfRDP+wsEqwsoIfS1Mmz7hitVOloMuUrSVynmGNR3sftqrn/8ohFTUnLHwf0VLXM0oSe1idIH9a
 uymzuG7/2lg0jokIyD6rVuUWsPBNc6gEh01/7dKhpvU2K/XIxzrjaQsRmgaRlkr5HvY/E8FS05Q
 5ygFHnkiWfnD0N8wcxpoeVgzB2W6Wat6MeXhsr7TRX2cUa/42rP1ro7474tE5yO6njwtr2QFEql
 00pgQ44ylqhBpqj1xsArj2PoFFM9WhM270O5uydvx8pEUXihR4tyx20vm+CimKQNDnLovxzrabj
 iqvz6xUW62JfUfE8DmQ==
X-Authority-Analysis: v=2.4 cv=fd+gCkQF c=1 sm=1 tr=0 ts=698b014c cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=HzLeVaNsDn8A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=Mpw57Om8IfrbqaoTuvik:22 a=GgsMoib0sEa3-_RKJdDe:22
 a=pGLkceISAAAA:8 a=EUspDBNiAAAA:8 a=am3lAksc-JuIhvUlS-gA:9 a=QEXdDO2ut3YA:10
 a=bTQJ7kPSJx9SKPbeHEYW:22
X-Proofpoint-ORIG-GUID: zg9HIxE3FUCyzvdGAcIs3sOptXNvr33b
X-Proofpoint-GUID: zg9HIxE3FUCyzvdGAcIs3sOptXNvr33b
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-09_01,2026-02-09_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 phishscore=0 priorityscore=1501 suspectscore=0 malwarescore=0
 bulkscore=0 lowpriorityscore=0 spamscore=0 impostorscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2601150000 definitions=main-2602100083
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-42430-lists,linux-pm=lfdr.de];
	FREEMAIL_TO(0.00)[gmail.com,kernel.org,linaro.org,intel.com,arm.com,vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[18];
	DBL_BLOCKED_OPENRESOLVER(0.00)[qualcomm.com:email,qualcomm.com:dkim,oss.qualcomm.com:mid,oss.qualcomm.com:dkim,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[konrad.dybcio@oss.qualcomm.com,linux-pm@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-pm,dt];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: CF43B119458
X-Rspamd-Action: no action

On 2/10/26 3:18 AM, Richard Acayan wrote:
> When support was added for the HC variant, the full_scale_code_volt
> value was copied from the tm5 variant. From the downstream kernel, the
> scaling value is 0x70e4 on PMI632 (tm5 variant), but it is 0x4000 on
> PM660 and PM8998 (HC variant). Correct the ADC code to voltage
> scaling factor for the HC variant.
> 
> Fixes: f6c83676c6097 ("thermal/drivers/qcom/spmi-adc-tm5: Add support for HC variant")
> Signed-off-by: Richard Acayan <mailingradian@gmail.com>
> ---

nice catch!

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Konrad

