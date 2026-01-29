Return-Path: <linux-pm+bounces-41676-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aNskFV83e2mGCQIAu9opvQ
	(envelope-from <linux-pm+bounces-41676-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Thu, 29 Jan 2026 11:33:03 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E5D3EAEC0C
	for <lists+linux-pm@lfdr.de>; Thu, 29 Jan 2026 11:33:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id D5D48300AC97
	for <lists+linux-pm@lfdr.de>; Thu, 29 Jan 2026 10:33:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35DE23815D7;
	Thu, 29 Jan 2026 10:33:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="l9eJcJqp";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="fRd7mZOR"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A34DF37FF6A
	for <linux-pm@vger.kernel.org>; Thu, 29 Jan 2026 10:32:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769682781; cv=none; b=WREqBLWzYDGIl0ndI+aOZZSpn3soyaZkzWU6mjtU8DcrHnuqCygEqKku3FZNytB5Cu8viWWEJq3iaXyMYUCBa5BkORH96HXoy3b76p/p/GjUXvmcIIRxZiU6XemJpA0pgfRaTrxAWsZ2Dhdxv/fqqXJqnx2eYAwn4l9itHxVVt0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769682781; c=relaxed/simple;
	bh=oHUBI5wS+aYJL2pSTSPoeDZI/0I7Pb1vC66WMf2UeKs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SOTK+JZ9RgCVbagU9pHQQjuDUEwX+TjvnYQNzKEIEYF1lvGkfrkxUcV956oWgMft9BFhgME7B2qNYBCbZyMpkQFVtzOj68XO/1UIvFM0T3HlyR3miyHYB8UbZ2nf8QMwU7X1a6XJPIasNX+L/qam1Ka1LhXPDMWVhZa6tkiSjiw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=l9eJcJqp; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=fRd7mZOR; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 60TARw6s3713472
	for <linux-pm@vger.kernel.org>; Thu, 29 Jan 2026 10:32:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	QOqjZJLJs5gDvla8rd+g87KJ7IFJ9OH5vIIsz79XB14=; b=l9eJcJqpeAyL/FcO
	eLuOK5UqvtcuTcOyqwvuSg8RziAkLr8vArhI2m/n1nOOfYhVn+AhMabtCB2LgjeY
	+zmTV26rzesBegTjfcTIBA0S0Mh8ee4CfJpfiVNWxKLdM56n/TzRUV9IM+u45fGO
	VVaHJ92/spmzL5v6DB7IU5DER9I5vYeLIyRcT1uWsMh599RnKtZ73qHti79k1gnf
	JhXGkn5X+kOFFrnLaoGJCIc74/GAgwJkWqoi/ZwfQeBVKxw6hUtQJ+iDGlgzdSKm
	HY7gyQB3sP00RF7MPK4N3N7kvufUGOTf0wNYKglFPhpHZTB7jylcx4aR99z+CJqI
	PZgQTA==
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com [209.85.219.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4byxcu9fq1-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Thu, 29 Jan 2026 10:32:58 +0000 (GMT)
Received: by mail-qv1-f72.google.com with SMTP id 6a1803df08f44-88880bc706cso3039506d6.2
        for <linux-pm@vger.kernel.org>; Thu, 29 Jan 2026 02:32:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1769682778; x=1770287578; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=QOqjZJLJs5gDvla8rd+g87KJ7IFJ9OH5vIIsz79XB14=;
        b=fRd7mZORvcWInMNOl3dy51fRXsZEaR9jQH2LsrWym7ngFd85xjKRwzz7L5AqRBKHot
         ZoC2vsxxzNUcyk+bI3nnNg1uPgr7fFyLsMBN7nD4Zoo+MjnlPzJcrIeRgRGeYt+Y3mUP
         mWIx62y6Rcm2Sg85OWk9cOSc+rXAAYEsN3JHDycrrbI4v8zUIP7Or/B4liDl/P9AKON+
         FP2lY/qxne9fNezCUUsrKJnyeVAMWfDzA8UOMO0cB9nfStN/c038uCLBoAFDmlXlJSX2
         /a4yC1URnniASC48U87cEGesiZsGHqmj7D3G15BXp0xJmEIrJmo+RWPryWFaJ/m/9p5M
         4utQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769682778; x=1770287578;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QOqjZJLJs5gDvla8rd+g87KJ7IFJ9OH5vIIsz79XB14=;
        b=SYvnqX9DHhhEOX35HESlzplP6/Inl604sQsyNW+2uu6IJCzmPTec8i+emGgnfuWciA
         9zNGdcmIXDlxVQtQeQvq8ePHnP1j0ihVQJMwIwi6AZhZRAJt6U+PsLwmTxdHSAMYJYuf
         crKFsW6U/H0strDehqNNlhIIzeCXCKKACz63dhb9C/7OT7C0Pv/NUfKjrfKAnFi4HtHh
         jHVhVbteXa5T6eY/8RjVWtxNQGVLhro/P5l0yoFndjUbl145h1aE4dIGXsSpoVrAdWzy
         4YbiqNthYArTRlrrCWW+oJ1RgicaTYxla8fEvFbdqQjaRKYo8TnIBTWlZUNXqfjLxE9V
         wXKg==
X-Forwarded-Encrypted: i=1; AJvYcCW3bKi2jyA98lw6gSWbFwXSj4gJkiQDjys9ZbT/927yEH9oaIwFTmYbcvTsOtNvLboDDatLLxcf2A==@vger.kernel.org
X-Gm-Message-State: AOJu0Yw1386VhFBSFckuFrEUHtvAwzkBsZe/Pxsr+wQvupRW/nXg3tDA
	YlIYS8a9ZFYyZahYMeE51r9WA7P9CYQybkFDn/fYIR8gGfYEtH483FpOhYxYcq6K4oR7YJ68N/W
	BfHHVgbApaAomHs5+W4M5tYPHz8Nhyfclpb8iei/PtlXm6bE8xSZ71iGbppgO9A==
X-Gm-Gg: AZuq6aKYP4kuHQTXH1pX+ARL3yMy9BOlkNNPa60S/4KUChCnkzbUEdO0oCcmWVcgKUZ
	Ku32kwVyxc5QdOAtGCjXjMCtyJXiIQkfGhzMG8RHjR/8XUht4gPzO57JedULWayNx7TPRWnU+2I
	zKqRqsPp14wqctVX3WkQWvli4GCKYjBzdSWDbUDRRYU+9vS/MC+Ebu7U3k1R6NKdzF398eEuGqE
	2pd3b36TFC910axiINo1gnyxooZ37VtQB3KtY1MaMBK5SxdemyUiH4MbTcbS1oadXnfsgFqAS+G
	paRKLIYtEIUHNzb8wfiWm5BAWxBJ7MPvqZ0qs5kAKwkcbVXz2e5K8S+qmaf3YNGkoimW+aqO7/c
	yzlW3sjCCfoLQ1WWckXZj0LAERcpRT+XWf8QsSQzoP5a/zmo+DAmCWludV3t+Uu07Tms=
X-Received: by 2002:a05:620a:44d1:b0:8c6:2539:dcda with SMTP id af79cd13be357-8c714b4f97amr512809985a.2.1769682777854;
        Thu, 29 Jan 2026 02:32:57 -0800 (PST)
X-Received: by 2002:a05:620a:44d1:b0:8c6:2539:dcda with SMTP id af79cd13be357-8c714b4f97amr512807285a.2.1769682777472;
        Thu, 29 Jan 2026 02:32:57 -0800 (PST)
Received: from [192.168.119.254] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b8dbefc69ebsm244806166b.20.2026.01.29.02.32.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 29 Jan 2026 02:32:56 -0800 (PST)
Message-ID: <d50ef396-5d02-4b26-89aa-1a9d2950a290@oss.qualcomm.com>
Date: Thu, 29 Jan 2026 11:32:54 +0100
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/3] dt-bindings: interconnect: qcom,qcs8300-rpmh: add
 clocks property to enable QoS
To: Odelu Kukatla <odelu.kukatla@oss.qualcomm.com>,
        Georgi Djakov <djakov@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>
Cc: Raviteja Laggyshetty <raviteja.laggyshetty@oss.qualcomm.com>,
        Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Mike Tipton <mike.tipton@oss.qualcomm.com>
References: <20260127090116.1438780-1-odelu.kukatla@oss.qualcomm.com>
 <20260127090116.1438780-2-odelu.kukatla@oss.qualcomm.com>
 <5b62fc63-314e-40a0-a975-9df75ec49e9a@oss.qualcomm.com>
 <ee02056d-34a4-4300-acab-98fc50c43a0b@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <ee02056d-34a4-4300-acab-98fc50c43a0b@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTI5MDA2OSBTYWx0ZWRfX2p9NRPJ9IBAE
 FaOHZeSemMOA4UHqWL4WOetkwqZk+AuZ4M6Vfbe6x59iCFeCU12+UvIe3OsmQSem5LbORi8rW7T
 hIxCn6Ry4X8WzC/osyEWmHJ87V4mh9LbmKNm79cRan21ur86Wg2pWwO1ejlSXB0cDJP61k73XlB
 hWoOE+DDuw8dr6VlAZju6Q4K3vFX4q2wgi6OBFXKHXGczeVMLcuoFQnICBagLkt8M7yBT/2m+Xd
 9k4y3MQzXi3P+OFIA5L5HnXwyszDjan/7P0qz/F+GK8cQIiFDxZ3oWCh1ErrqToDSV5KjgXWxbn
 XE64F+WaJxu0UJ3w3uDlKTco75lZGSt7wn9T/zcSxKBP+7yz0EACILihb6iDpBpqjtSgQ9Xhkpj
 pEVdqEAsSs+Y0WMHmZUOw9IMgDXwG3XuhpX20wEqWZmTXsfTx4d1JDVfyfJ/nwmWBYbLxv06UDs
 1B7anoCs8yFprsiIOOw==
X-Authority-Analysis: v=2.4 cv=QpRTHFyd c=1 sm=1 tr=0 ts=697b375a cx=c_pps
 a=7E5Bxpl4vBhpaufnMqZlrw==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=vUbySO9Y5rIA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=EUspDBNiAAAA:8 a=WMlQ1W5rKAuT8PP_VscA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=pJ04lnu7RYOZP9TFuWaZ:22
X-Proofpoint-GUID: ensQOigsp0Gu2kVH2HTa9xvNg7A34ExE
X-Proofpoint-ORIG-GUID: ensQOigsp0Gu2kVH2HTa9xvNg7A34ExE
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-01-29_02,2026-01-28_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 lowpriorityscore=0 clxscore=1015 priorityscore=1501 phishscore=0
 impostorscore=0 bulkscore=0 malwarescore=0 spamscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2601150000 definitions=main-2601290069
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[15];
	TAGGED_FROM(0.00)[bounces-41676-lists,linux-pm=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[qualcomm.com:email,qualcomm.com:dkim,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,oss.qualcomm.com:mid,oss.qualcomm.com:dkim];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[konrad.dybcio@oss.qualcomm.com,linux-pm@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-pm,dt];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: E5D3EAEC0C
X-Rspamd-Action: no action

On 1/29/26 11:10 AM, Odelu Kukatla wrote:
> 
> 
> On 1/27/2026 4:24 PM, Konrad Dybcio wrote:
>> On 1/27/26 10:01 AM, Odelu Kukatla wrote:
>>> Some QCS8300 interconnect nodes have QoS registers located inside
>>> a block whose interface is clock-gated. For those nodes, driver
>>> must enable the corresponding clock(s) before accessing the
>>> registers. Add the 'clocks' property so the driver can obtain
>>> and enable the required clock(s).
>>>
>>> Only interconnects that have clock‑gated QoS register interface
>>> use this property; it is not applicable to all interconnect nodes.
>>>
>>> Signed-off-by: Odelu Kukatla <odelu.kukatla@oss.qualcomm.com>
>>> ---

[...]

>>> +  - if:
>>> +      properties:
>>> +        compatible:
>>> +          contains:
>>> +            enum:
>>> +              - qcom,qcs8300-aggre2-noc
>>> +    then:
>>> +      properties:
>>> +        clocks:
>>> +          items:
>>> +            - description: RPMH CC IPA clock
>>
>> LeMans also has ufscard clk here
>>
> 
> For aggre2 noc, QCS8300 does not integrate the ufscard controller
> present on LeMans, so that clock is not part of the QCS8300 hardware.
> The only QoS relevant clock on this node for QCS8300 is the RPMH CC IPA
> clock, which is why only that one appears in the binding.

Ohhh I forgot UFSCard translated to UFS1..


>>> +
>>> +  - if:
>>> +      properties:
>>> +        compatible:
>>> +          contains:
>>> +            enum:
>>> +              - qcom,qcs8300-gem-noc
>>> +    then:
>>> +      properties:
>>> +        clocks:
>>> +          items:
>>> +            - description: GCC DDRSS GPU AXI clock
>>
>> and lacks this one
>>
>> Are there actual reasons for these differences?
>>
> 
> The gem noc QoS interface on QCS8300 requires the DDRSS GPU AXI clock to
> be enabled for QoS register access, so it is listed in the binding. The
> difference is therefore due to SoC level differences.

Alright, thanks

Konrad

