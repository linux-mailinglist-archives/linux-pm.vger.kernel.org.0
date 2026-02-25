Return-Path: <linux-pm+bounces-43206-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GPg7BNDrnmk/XwQAu9opvQ
	(envelope-from <linux-pm+bounces-43206-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Wed, 25 Feb 2026 13:32:16 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FE03197644
	for <lists+linux-pm@lfdr.de>; Wed, 25 Feb 2026 13:32:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 70BFB3056B3D
	for <lists+linux-pm@lfdr.de>; Wed, 25 Feb 2026 12:27:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6489B3AEF40;
	Wed, 25 Feb 2026 12:27:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="EI7sR4ne";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="TIAxpzeM"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90EF83AEF24
	for <linux-pm@vger.kernel.org>; Wed, 25 Feb 2026 12:27:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772022460; cv=none; b=l0o7wRPqKRiKsYqUS5ThzO0K+pZmjpnAzxUKqgGXffCWE+yLll5pJD18oumjKfZBIz56OZqDiLy8TyeeS2M3720cIEX4KLz/cnydgpgvdrZbOmdq4wixIoKkU2ZzgLjfAwpBUwKIOF0MG/HrsSnugxpjoRGNKRV3C6hlsw0vtJ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772022460; c=relaxed/simple;
	bh=lmOP14Bu15hKCJcfJsFNbgjaGMAN1gKX6Xs1zRpvce4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Vn+UXzpdJ54+W5cu/b3YaEqiX+QswixVIDMwiBL3ivZRMuxVPXbeWVdFSiw6UuWMBswxUG3WTTltxSvv2syYNacamLFk6SV1P9ahN8oSfAeoTRv4vnGFtljGMx8358d87TYPV82BFbN2TKgV7+ib00nWkpsYvtpkzxUN5T6QGUE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=EI7sR4ne; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=TIAxpzeM; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61P9SiA11088217
	for <linux-pm@vger.kernel.org>; Wed, 25 Feb 2026 12:27:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	djR0gnFvb7yIczPMk8GCLKch2PIYdEZoalq5Lw+87vg=; b=EI7sR4ne5eOf2ZiU
	6D0P2IFvmhlNlxjBUN5Pp8NMmU33e1+tOLMprWPlPClzlBiY8+4Bu2vjqnYdYGFK
	vheYblEHDKcSe3LwhyWESWj1+LKDdj5zdkbTvuyp77rWSJXldmEBW/g6M2CdlwA4
	sO1UXMq++TODBKHLW5eAi2KhOnez16/1abbpwQulJHCbntfzXVFeSE8i1k4acVrz
	Jwj4Kn289tVZl7Wtd2k5OH21kMtXgpHkB9Tqj81N1iRFwHJBZDZw5aBV5ALXn778
	u1HVDSm8lDACb98/yWvubx+kymNvl0+89VRWX8Pi/ZDD0t0rhq0ybGWdn0raE70T
	lIlpXA==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com [209.85.222.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4chh472wrg-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Wed, 25 Feb 2026 12:27:37 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-8cb38a5dc3cso600168585a.3
        for <linux-pm@vger.kernel.org>; Wed, 25 Feb 2026 04:27:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1772022457; x=1772627257; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=djR0gnFvb7yIczPMk8GCLKch2PIYdEZoalq5Lw+87vg=;
        b=TIAxpzeMPXLT6mjrTNqzxoTVQF0+ABTEbrrX6zEF/aPBNyaLe4KmFiKXOECOYd9C2t
         qMMA8Jf0Rt5aN93aOhZRd1P0hdwCy8gDtCOQGqzvITUX0lKgp0V6IB4bf5GU6zxgRoA2
         JLf3BJjilGmEMPhAsTg3L/b76hGCHCWmJGA9rRB6wpUGCRwjh+760djWghQv1dCZU3gO
         /kt1dPHLc/Y+M72quSyMZIaFc9jpXQ01EH0i+4M25ymGXeodLgr2hfZZ1g3Sdn+Osv4R
         H9OJtJEgI0CyE+Az0IVF/QgtwlZzW0uaHozpks6ZJdkkzpbpyJ9G0NyShClyfM6VvYVU
         HM/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772022457; x=1772627257;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=djR0gnFvb7yIczPMk8GCLKch2PIYdEZoalq5Lw+87vg=;
        b=OdEQnVj8zjjP1urW+FheD4qI8mES8CiyOQLlebrNUEZh0FQDfAZnd+HIcsC5KHzmu7
         mQzPWET7/DV9Kk7F2zPyh+p3b+VHg9b4J2cLAOjxoLkFXYSb7YS8Sjy++g7gOZ+AyoID
         wQjbfb8a17zukLIMyg8EI3P9IXMIMxk1bpDNGuQ1CxpWCqGv/i1oBn1Q6fxwoiq33XzV
         a3XpYtUlRGY+wyAtLALZR+g9Q6AaxbBKB9KsahLfnkgl0wa8aXMgYp8294imaa/OydBL
         g4v/O6Pu/8u3LL2Q2ichH+m3H1S0Znn8v/QlvxuIs7ETwd6MxtXe69qqabPqhI3yy3xt
         g/Bg==
X-Forwarded-Encrypted: i=1; AJvYcCWEkAUsUJInQ6NBR/Wrt1LPSTLQBVMU3JgATURzhDJDiyPvffJW+h9HM7GM8pwAaX+sET6fuSVDcw==@vger.kernel.org
X-Gm-Message-State: AOJu0YxHnZbKTHa9cH7Fwm6apVaHvrDKzmNHf39AuwlFoTVIhPMdGhvG
	ycfsSs6GOn3B4plIVszdxKTa2vn9CgIkU9w3zz2RnIL+jXFjxoU61i8amBcDOWZRQFn5Nxqa/Ab
	ItEyzQauOWLbzh90uwZyVZ6oddBxmGQVFDFz3Z4YpraYnXA3I3ekEwDQ/G1wedg==
X-Gm-Gg: ATEYQzy8xSz0S4TFKc6q7ddAvMI/olZWSbIYgta7Qe98lqTxxH/N5jjpx3nnLlzfwqf
	tAo0pgBrPJt2/pxD7rI99iQHS/s1B7Ukuwq3LxNs8LVo479nG0g0BfB/5SAbnyDYTwr4KrXLZ6v
	O3FUCqdKJMyRdRzknBH5XlkHRE3NVRnxuO1fZbICLAA6c27UvfNATr/dn/NLOI2izOyslU9lGvM
	ltgWpXA0IC1WeKrVLRr6fK07EWyDJiY0LcoIakJfdLKXkBSt949bMRQ1Iq/ugH8kPdrplCG8/2w
	uXk1Pjq2cmCeRGYq+ugoq2BURNQN/r78/vXL0sBSqno21yFteFdqAhh3+U1qMHUrEZ8NwLYPk8A
	2muyeMK5pGryyjOxm6MJOp7KEpURXdOAH8IRm6PXFiHCQAK6dY4pVPC20D5V61xqcxsgqobni31
	1cJs4=
X-Received: by 2002:a05:620a:6910:b0:8cb:52c2:6f19 with SMTP id af79cd13be357-8cb8ca764b3mr1502773385a.7.1772022456825;
        Wed, 25 Feb 2026 04:27:36 -0800 (PST)
X-Received: by 2002:a05:620a:6910:b0:8cb:52c2:6f19 with SMTP id af79cd13be357-8cb8ca764b3mr1502770785a.7.1772022456370;
        Wed, 25 Feb 2026 04:27:36 -0800 (PST)
Received: from [192.168.119.254] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b934c9a645csm15099666b.34.2026.02.25.04.27.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 25 Feb 2026 04:27:35 -0800 (PST)
Message-ID: <954f6a53-b597-47dd-926a-adb5a7513edb@oss.qualcomm.com>
Date: Wed, 25 Feb 2026 13:27:33 +0100
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V3] arm64: dts: qcom: qcs8300-ride: Enable Bluetooth
 support
To: Wei Deng <wei.deng@oss.qualcomm.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>,
        Bartosz Golaszewski <brgl@kernel.org>,
        Marcel Holtmann <marcel@holtmann.org>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-bluetooth@vger.kernel.org,
        linux-pm@vger.kernel.org, cheng.jiang@oss.qualcomm.com,
        shuai.zhang@oss.qualcomm.com
References: <20260225091700.286108-1-wei.deng@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20260225091700.286108-1-wei.deng@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: ei7XxgRzdvJ9uTfx6UEO91vnQNf0snba
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjI1MDEyMSBTYWx0ZWRfXyq2udfdz/StG
 i3puWzjs+7b1BuCzE7+D/3vDzx/3RKhWv1j56xXoKV9hWxCjF0WcbfmRnpSoSpJVRiuF0UrT4WQ
 n1MUsVuuE8+kZFd3X9pKabeY5b9UiKigS9mY4HjKvOYTnlS6HZoFGj/DsdDZhEu+57y06e/kGJn
 wSfi1xb+L4yVy3TTHFwemS79MxYZJSosv28ePlqmZDhDzl0VDf5eaOBfXihrdWISB62NPh8jGsB
 6tpizBvSPHN0XK7uV7bcy3Yl9ALKbGYyESy62jlQqO54pqEio8ho/6olHdpaZAZl/0+xSdvZ6H7
 lSAdl4yjMhfHmPnRaPNUKrMINaiHmjKg71RDjBtePHy2zrqWTvn1ZGiO/qEyljNRxXE5ezPBhwz
 htfvad9KffsBGC5Rq+QZYxBK+HPk3RfzHabpJtrQ84tkTeLevUYPz1y/1ZCpWsYuqgm8y5r5lRd
 csJDzdR/IEEpqMeXt6A==
X-Authority-Analysis: v=2.4 cv=fvDRpV4f c=1 sm=1 tr=0 ts=699eeab9 cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=HzLeVaNsDn8A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=ICuIv3KJ-OCJFd6aZL4A:9 a=QEXdDO2ut3YA:10
 a=IoWCM6iH3mJn3m4BftBB:22
X-Proofpoint-GUID: ei7XxgRzdvJ9uTfx6UEO91vnQNf0snba
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-24_03,2026-02-25_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 lowpriorityscore=0 malwarescore=0 priorityscore=1501
 impostorscore=0 adultscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2602130000
 definitions=main-2602250121
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-43206-lists,linux-pm=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[oss.qualcomm.com,kernel.org,holtmann.org,gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	RCPT_COUNT_TWELVE(0.00)[16];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[qualcomm.com:email,qualcomm.com:dkim,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,oss.qualcomm.com:mid,oss.qualcomm.com:dkim];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[konrad.dybcio@oss.qualcomm.com,linux-pm@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-pm,dt];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 5FE03197644
X-Rspamd-Action: no action

On 2/25/26 10:17 AM, Wei Deng wrote:
> Enable BT on qcs8300-ride by adding a BT device tree node.
> 
> Since the platform uses the QCA6698 Bluetooth chip. While
> the QCA6698 shares the same IP core as the WCN6855, it has
> different RF components and RAM sizes, requiring new firmware
> files. Use the firmware-name property to specify the NVM and
> rampatch firmware to load.
> 
> Signed-off-by: Wei Deng <wei.deng@oss.qualcomm.com>
> ---
> This patch depends on:
> - WLAN
> https://lore.kernel.org/all/20260122053624.4068718-1-wei.zhang@oss.qualcomm.com/
> 
> Changes in v3:
> - Rebase patches
> - Remove unintended 'output-low' from bt-en-state pinctrl
> - Use prerequisite-message-id to replace prerequisite-patch-id (Konrad)

Only now did I realize you're the author of both patches!

Next time around, please keep them in the same series, for easier
tracking (since they're very much related)

[...]


> +&uart2 {
> +	status = "okay";
> +	bluetooth: bluetooth {

Ideally there'd be a newline separating the properties from the subnodes

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Konrad

