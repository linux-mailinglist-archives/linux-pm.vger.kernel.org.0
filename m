Return-Path: <linux-pm+bounces-42932-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QGQPBo89mGkWDwMAu9opvQ
	(envelope-from <linux-pm+bounces-42932-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Fri, 20 Feb 2026 11:55:11 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id AD839167106
	for <lists+linux-pm@lfdr.de>; Fri, 20 Feb 2026 11:55:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 35E95308AB30
	for <lists+linux-pm@lfdr.de>; Fri, 20 Feb 2026 10:51:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D97D33F38D;
	Fri, 20 Feb 2026 10:51:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="BueSl0t8";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="TOAoSrj1"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32D0D33F362
	for <linux-pm@vger.kernel.org>; Fri, 20 Feb 2026 10:51:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771584683; cv=none; b=aXfQMOUgrBqE1550/qLdNHFf+iKW9BTfRqM6PeJC9aLX2zvhPyCMXjCq87vQJtoLDl82Xby86uQuUmzie4Vy/lJYeUKhr1tkmxDEZcxXVaesSo1P25alkMoX9juuRV6jUn9nQEYppZmD6xMx0k0bZKLWHC6ZhPdbg2bsEg2q6GY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771584683; c=relaxed/simple;
	bh=ks6OJSw/UwvvF2/JUxSnt1Tii4VaTCXNdvHN7i3pd2A=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=oe6cVRGUKR1nqGR3rmmF+M0skz4pbxu6lKX2YKvk3BANXPKCmso9s5gN4wUC9MQ2Uw+0/FRrLetlXOJm61C2A3dXCAHF7lqi0jX1AZ6YxV7ct6HqcRKhZCAdaPOZigNY7O8rE01aEvVNFLe2KJVHJOOvqLzEWOCvXlUC+eQTEz0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=BueSl0t8; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=TOAoSrj1; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61KA3wnO2218909
	for <linux-pm@vger.kernel.org>; Fri, 20 Feb 2026 10:51:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	n8sjIgXFVYbyhkWb9bMVXULx3YRL8NxHkkz55sJrEfA=; b=BueSl0t8sjkgfsHn
	wC7Y86DW8R4z7S7OJvfXyn63FWvSwGwK7Aw5kaTXqbRl5sKFXMyMsSQjnbxCWTmj
	rUjY/rIZsGmuO7o1wqw3c4Tg7ZdTlD9bfxLX1mjDVt6igrJywqilZSzEBkveonSZ
	pPGjO7qbXLMqS3ugXsM8Khq5iBz5CQ6XxJQnIGdnU1nbG6tJhSlTxlDWeAL4k8xn
	2uPaXcgiHZxRGsBDjeLKnQ47M6LICWxs9vjuiUFFutKhAvUvfaqE1MhwjaQ0Sv5w
	Yer1MYHRQdgD8QSJCOA57odnydXR4D9mIlw82J1ENBp7hW+JGkMAvt0ehRHAFrT0
	MVO47A==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com [209.85.222.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4cenhgr3nc-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Fri, 20 Feb 2026 10:51:20 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-8cb50dfd542so186022985a.0
        for <linux-pm@vger.kernel.org>; Fri, 20 Feb 2026 02:51:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1771584680; x=1772189480; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=n8sjIgXFVYbyhkWb9bMVXULx3YRL8NxHkkz55sJrEfA=;
        b=TOAoSrj1pNkW7zgtDRYPw94vSxGl0hqBTtX6EvM23ImSfc9jflEHE49s0yAvsnyeVf
         xOJjXJNEX/+g/UGB2pRQvfoCQQr833HuLzGW3kznQ9dfMC2o+WY+O7nENcCZOzLRsHsf
         iOc2OeDgfCv42QJjcAZufB3piORJ8iF855qphpPvnbK6V95GBqQIz0ctFMMK/8yAGDnf
         NJeNnE5/MZweEa+JeUzxfpdTb7LNtV5jX5f5+VD+HMCQ5EWv2PfoJ2l4pSJmzM4MS1Am
         dfwmHXvC9KDSa1chIGbJxslEnh6yW/txijue8KCXqZvyoFhNUr6a1OnRad1DZG3QTCvT
         q6Ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771584680; x=1772189480;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=n8sjIgXFVYbyhkWb9bMVXULx3YRL8NxHkkz55sJrEfA=;
        b=t6f9+qQMhBTW5MBv5VUnllyjlYm0c90srkbopoGs9AMT6PlIerNKaxcIQ1yHUdCRN4
         C4opeqMmf3A+zV8j9NYXEi75YiJA60MAySpkzxy8mCUwDwDr1wW2TYAPJG7M8F6Yhz0G
         u3AE4Heg0NSIXpfcVdvQZyoV3I0SeBSVuCuhumtbEdXMGGc4lfabWTadcnEi3KbVsTdr
         eJr8W4LgZVSRWaJcs6Jya7Fbw3OcQO2i5LxYQWgKx5wBkVbUE0K+hK8bfQNGJVsIGvtY
         OZ98vXGgM35GwsENRCChQy5GUE5x1xF9m3LkeWtn/pCEL4KUNV7HDV+C47yKnNaivFqq
         wiYA==
X-Forwarded-Encrypted: i=1; AJvYcCV58tr8tfe6+nbW3la2bwS+knsahZ4LgRB8RrsDpPo0K1dyFKnbgwn+mzjtVreN8a9BiTcv3H3hIA==@vger.kernel.org
X-Gm-Message-State: AOJu0YzXdAHRzHws7tMNTVIYDt4D+XHRW4CRoQzyCbp9t/dW/t2mR3hC
	jUDhsKlSNTk7OVTrNvLzX0WfN+wfIPl6kaMx53ynOZqQKTiLjEm9SRjZaSp15TGwFLoxoaTl4cL
	tCkMaw0+eTbs6jKGLaQavi/Il+SB3u3IzQReAEABFma6LKzSMsc/XOyTuHXEKVw==
X-Gm-Gg: AZuq6aLkPYe9kBOLvJoEWQoEKbKNx93H6tZUdUQ3HAFOFOdsu/cJSF1EAnimOA67GiU
	VOa9fPFV0ynjvMGR5VL5IIGAFWVIU29FF9FcJdiZygQVyN2AArNGHfSLw+vaW+n862BOt+X3p52
	zzQW2begRlb33Lcc7QyGBTAgsf8hLc3egksNQrhnc1mssP0UlT5oCgFVlYSKjiJ9I7R+aL9TliU
	Qgh7PTs7cFKkD9kuQXnUnTLJBxRnNdcWXThfkuZW/QUI80nfGVReAtpA0hK9i4WJCNxbP/3Phnn
	15bVvGoCo24EO+GK1j5pq2Puwt7ilXymt6TfwsEdSb2EI/Hf5TTcnAO02tAaq+UEKUrwFd2HRyk
	rOl7hI+lHTJXO4VXGQJUzVPws3C5ILuw5d7PEX74uYDvjdqTA22vOUvjxE2JACPdXM+9nbSsJYx
	GtIw0=
X-Received: by 2002:a05:620a:7006:b0:8c7:1b40:d096 with SMTP id af79cd13be357-8cb408e956dmr2404929885a.9.1771584679739;
        Fri, 20 Feb 2026 02:51:19 -0800 (PST)
X-Received: by 2002:a05:620a:7006:b0:8c7:1b40:d096 with SMTP id af79cd13be357-8cb408e956dmr2404925985a.9.1771584679248;
        Fri, 20 Feb 2026 02:51:19 -0800 (PST)
Received: from [192.168.119.254] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b8fc7665345sm664435366b.53.2026.02.20.02.51.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 20 Feb 2026 02:51:18 -0800 (PST)
Message-ID: <a422e087-a91c-4bb2-9d95-e1cefc9a91bf@oss.qualcomm.com>
Date: Fri, 20 Feb 2026 11:51:15 +0100
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 5/5] arm64: dts: qcom: sm7225-fairphone-fp4: Add
 battery temperature node
To: Luca Weiss <luca.weiss@fairphone.com>,
        Jonathan Cameron
 <jic23@kernel.org>,
        David Lechner <dlechner@baylibre.com>,
        =?UTF-8?Q?Nuno_S=C3=A1?= <nuno.sa@analog.com>,
        Andy Shevchenko <andy@kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Zhang Rui <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>,
        Laxman Dewangan <ldewangan@nvidia.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Hans de Goede <hansg@kernel.org>, Jens Reidel <adrian@mainlining.org>,
        Casey Connolly <casey.connolly@linaro.org>
Cc: ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org
References: <20260220-bat-temp-adc-v2-0-fe34ed4ea851@fairphone.com>
 <20260220-bat-temp-adc-v2-5-fe34ed4ea851@fairphone.com>
 <85ce1f2c-f5cf-4e97-9611-4aed03f69cd7@oss.qualcomm.com>
 <DGJQ4WLIML3H.GAO7T4L3MCJM@fairphone.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <DGJQ4WLIML3H.GAO7T4L3MCJM@fairphone.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=TJVIilla c=1 sm=1 tr=0 ts=69983ca8 cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=HzLeVaNsDn8A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=Mpw57Om8IfrbqaoTuvik:22 a=GgsMoib0sEa3-_RKJdDe:22
 a=6H0WHjuAAAAA:8 a=ftgFGzw_iv9xBS2N3wAA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=NFOGd7dJGGMPyQGDc5-O:22 a=Soq9LBFxuPC4vsCAQt-j:22
X-Proofpoint-ORIG-GUID: K3eiXflpcChjUSn29zSJInMbFl_jpCPd
X-Proofpoint-GUID: K3eiXflpcChjUSn29zSJInMbFl_jpCPd
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjIwMDA5NCBTYWx0ZWRfX+OXrhlDAqc3a
 wV8rcxEB7srwnrj2udNdr/4ggwX8Xl+7yGTWvKAPlRCjmXMzwHM4HgG6CqZ6kQx0lm2IXbBsym2
 mdEuj5Gs7IdIR/CLmfRIHl8r3psuPhkOJl3QtIZ93pRnLy6jOQP/jy7bHoGkdlau9yegGYhcJrK
 Z2rwmn4YdZvFxY57NVgN4TN0V0jFuCitJB6Igfyp9loelqeeCJflXNiMMN3aD5gk3UUtGtyr26j
 bWScBOZx0dcq06MsegJ4a+z1Mq7HMnUbxSu/hjiNXAXTqPASNeNlkmRlHkZsyr3RegIh9K5gKR0
 eJsVQZONeg6iUZ5NsbVhUBe/0VyK4N7if552WhnWsYgGguOcKdtrux+6T93+urdRh1K/4y5ozud
 xaOqeOam30wv+Tq6btzPi81ZiShP8n6wAr+BB59lSX/octn94Dfyl2h/Bt6/LtILaru3NbZPCrj
 qyBUGtYZ7adSI6KHLlw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-20_01,2026-02-20_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 impostorscore=0 priorityscore=1501 lowpriorityscore=0
 clxscore=1015 bulkscore=0 phishscore=0 suspectscore=0 adultscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2601150000
 definitions=main-2602200094
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[25];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-42932-lists,linux-pm=lfdr.de];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[fairphone.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,oss.qualcomm.com:mid,oss.qualcomm.com:dkim];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[konrad.dybcio@oss.qualcomm.com,linux-pm@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[linux-pm,dt];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: AD839167106
X-Rspamd-Action: no action

On 2/20/26 11:40 AM, Luca Weiss wrote:
> On Fri Feb 20, 2026 at 11:00 AM CET, Konrad Dybcio wrote:
>> On 2/20/26 10:19 AM, Luca Weiss wrote:
>>> Add a generic-adc-thermal node to convert the voltage read by the
>>> battery temperature ADC into degree Celsius using the provided lookup
>>> table.
>>>
>>> This will later be used as input for the fuel gauge node (QGauge on the
>>> PM7250B).
>>>
>>> Signed-off-by: Luca Weiss <luca.weiss@fairphone.com>
>>> ---
>>>  arch/arm64/boot/dts/qcom/sm7225-fairphone-fp4.dts | 83 +++++++++++++++++++++++
>>>  1 file changed, 83 insertions(+)
>>>
>>> diff --git a/arch/arm64/boot/dts/qcom/sm7225-fairphone-fp4.dts b/arch/arm64/boot/dts/qcom/sm7225-fairphone-fp4.dts
>>> index b697051a0aaa..7857003099a6 100644
>>> --- a/arch/arm64/boot/dts/qcom/sm7225-fairphone-fp4.dts
>>> +++ b/arch/arm64/boot/dts/qcom/sm7225-fairphone-fp4.dts
>>> @@ -108,6 +108,89 @@ rear_cam_sensor: thermal-sensor-rear-cam {
>>>  		io-channel-names = "sensor-channel";
>>>  	};
>>>  
>>> +	bat_therm_sensor: thermal-sensor-bat-therm {
>>
>> nit: this should be a little higher
> 
> meh, it's surprisingly easy to miss this sorting stuff. Will fix in v3.
> 
>>
>>> +		compatible = "generic-adc-thermal";
>>> +		#thermal-sensor-cells = <0>;
>>> +		#io-channel-cells = <0>;
>>> +		io-channels = <&pm7250b_adc ADC5_BAT_THERM_30K_PU>;
>>> +		io-channel-names = "sensor-channel";
>>> +		/*
>>> +		 * Voltage to temperature table for 10kΩ (B=3435K) NTC with a
>>> +		 * 1.875V reference and 30kΩ pull-up.
>>> +		 */
>>
>> I think this looks good. Is this data going to be correct for all/most
>> devices (i.e. is there a single battery sku)?
> 
> Yes, from my info there's just a single battery SKU, so that makes it
> easy here.
> 
> For Fairphone 3 there's two battery SKUs:
> 
> * (Fuji) F3AC with NTC 100kOhm B=4100, ID resistor 10kOhm
> * (Kayo) F3AC1 with NTC 100kOhm B=4050, ID resistor 49.9kOhm
> 
> In reality, one can probably ignore the difference between the LUT for
> either B value since it only differs by a marginal amount, but
> conceptually I'm not sure how this should really be resolved.
> 
> We could have both battery definitions in the dtb, and then the charging
> driver could determine the battery that's actually present in the
> system (based on the BATT_ID measurement), but given the design here
> now, I'm not sure how this temperature lookup table would be propagated
> to the rest of the system...

The path of least resistance (pun intended) would probably be to make
generic-adc-thermal consume an ID channel and accept a number of LUTs..

That sounds sensible since most battery ID mechanisms are probably also
ADC-based and one would hope (tm) that the values output by these ADC channels
would then be distinct enough for the driver to have an easy time confidently
selecting one of the options (or a fallback)

That said, this is just my guesstimates and perhaps the IIO folks could comment
on that

Konrad

