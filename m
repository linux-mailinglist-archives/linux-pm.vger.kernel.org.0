Return-Path: <linux-pm+bounces-17956-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B1DE9D5F2E
	for <lists+linux-pm@lfdr.de>; Fri, 22 Nov 2024 13:47:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 01EB9282EE3
	for <lists+linux-pm@lfdr.de>; Fri, 22 Nov 2024 12:47:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E2F61DF72E;
	Fri, 22 Nov 2024 12:46:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="bbOvkUt5"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08C021DF732
	for <linux-pm@vger.kernel.org>; Fri, 22 Nov 2024 12:46:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732279611; cv=none; b=bPS/9YxNWMBG/z8TpDjyQRVWh7ryMvY7YYTCcYqkkT9pSBMb8L8vyarMWHTU4hqlongFsedCcVAoP5K3jnV0pN83zYNghpzs+bqclFEzYZjcvPWDlu4ZXq0iSRl9XZ+UgvaDfRVkyqArd2B6W8bnIUy+JLiHOZhlQap+3IiriYw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732279611; c=relaxed/simple;
	bh=PGxmlMvM42jCb09Sw5Nk0aJULQXXd1s94DyQ/r3iWC0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qAyWEYYH4EkNoELKVdENuFnqJqYkzA0ZnydqRzT25kfUK1em8uGqfDZMvOo2HKqEnZsrjw+UOEqAjqEH8eyNl5VjOFEroAGGGgRJsEZ9mYh4ITOLjSI8FcwqvzEwaipvH+qtLiILveMvz7XAcva+BDSbKsq/IkGjHfB1rKwz1EM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=bbOvkUt5; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4AM9Tdpa003946
	for <linux-pm@vger.kernel.org>; Fri, 22 Nov 2024 12:46:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	Ia4UrDs3vd2kvaJNQHWGjnWaoKrlYpuMSlA2+3djwo8=; b=bbOvkUt5luCh54dG
	6s6J41ui/OjrMkR01OslBwvPoELphPzxgFJcqdGuOmWWipw7bgcOAfnx/X7D7z49
	u4Z3z9JbU5+UE73bDuOatMJ+u9X4olz25Ub9sEFIC/pP1GxrVPkCfSUn+xNaXuuX
	mL5ap7bzR4b7AZlskokOLZ6+QLANTKZnIlTaacUs1RWlFnJXeDF04uWtCRozuypj
	cANqfRv2oT6k6HlrniH6R+vjoJObu+TU9jVW1EQ4kgtdPi0YUWQ+XGIHsBTT2ebR
	7RQaVm2l3Iipw5roctjVEX66YYAT9SOyW0+fMCkjKSgHDXlssmUYrVI8fGgSgJBJ
	IsB0LA==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com [209.85.160.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 431ce3fbuv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Fri, 22 Nov 2024 12:46:49 +0000 (GMT)
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-460903fc1a1so4934811cf.1
        for <linux-pm@vger.kernel.org>; Fri, 22 Nov 2024 04:46:49 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732279608; x=1732884408;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Ia4UrDs3vd2kvaJNQHWGjnWaoKrlYpuMSlA2+3djwo8=;
        b=GnGAr9B8/JhEIWJc2EkEDd5xaq7YZ17dSmaxjSF+SAeVkTt3uhBTb/D4sp8q0mMF4R
         U/PUMYVBjgeIb2h8nK3Z/7GSLTW20z1jc5LVVlAaOyxM6nXaZdt92uPwhACnJdmTvSOp
         Nmfd8S7Z7YZXwkhunMvMfv1zzcyD3kMeu0mknJzKe+a6ZAF1n7gpuabbqIOQC6t30S/u
         7gb8orbJdZ+R9l/30l17p23E3p67RuU64B5+x6lAzQQALS5Z/lCxVO4YiOSDVu7UPk6W
         jjMctnBwvLnqICpXavEgpF2N44YaepaN6OwWIayFzIvLySbcdn13RMkekO0dEca9Orlg
         G6YQ==
X-Forwarded-Encrypted: i=1; AJvYcCUMu9EF/t/7jRHTBFhAXnEzQTCCNuBy0i34+dI1dAwsnlEAed3em7Ja3aUqIUZn8yyblThVrbpDDQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YxrMwevIud92st3mX7gb4N66AF7vWicW32dGtdJsmQ/SFJKlhUe
	IXOfRMSlV77V12UHU9ex0TN3UHfWmgQli6uynVR8Adf/7NXL3wdWeqv5E/4N7N2gAACIrga/4/8
	RN+iLmeRZMRPVWXWYCnT3TH7tjSMXfpC0/dVZs9qZ3Neater2aX1Kia1vqA==
X-Gm-Gg: ASbGnctY7wSitymRxRir2OjrLsjt0JUwjFTASKGIbuEoYD7w8OTIc/DDHzQ/oIDP84t
	9oNb46Ux17SvepFq+M2l+2CGX1EwAKbtHPSjhIUj88teTnU+F6YYtohz2ETZu3jPBYN3jD/DuOu
	7CqPksbWBU2piKVNSKLWdafs+WJWi8XnLKcIpSgYpVElFYpkZAY0oIfJe+YsQqYLV5TRfEYCJLh
	EhVdyOrfavsvtAqqCF2I1xOasuA9E10rXyfa4etC+wv0Yl6YtEDRJo5tmVpMnWe8WmaEnW4cmrZ
	QRZxQKEtRbnf5aFQVrTW/qsfBU1kkLU=
X-Received: by 2002:a05:620a:1713:b0:7af:cb6b:b506 with SMTP id af79cd13be357-7b51451a046mr183920985a.10.1732279607956;
        Fri, 22 Nov 2024 04:46:47 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGmIPXE7w7yZ0oy7BimtfW3pz/4db5Uchdbm73yDFjLne3ud5VpvKRTqnMiznhLBMrqXFvxsg==
X-Received: by 2002:a05:620a:1713:b0:7af:cb6b:b506 with SMTP id af79cd13be357-7b51451a046mr183919485a.10.1732279607627;
        Fri, 22 Nov 2024 04:46:47 -0800 (PST)
Received: from [192.168.212.120] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aa50b28dd8fsm95930466b.39.2024.11.22.04.46.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 22 Nov 2024 04:46:47 -0800 (PST)
Message-ID: <b4716d0d-fcae-4d64-832a-96ecb0a233a7@oss.qualcomm.com>
Date: Fri, 22 Nov 2024 13:46:44 +0100
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V5 3/4] interconnect: qcom: Add EPSS L3 support on SA8775P
To: Raviteja Laggyshetty <quic_rlaggysh@quicinc.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Georgi Djakov <djakov@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>
Cc: Odelu Kukatla <quic_okukatla@quicinc.com>,
        Mike Tipton <quic_mdtipton@quicinc.com>,
        Sibi Sankar
 <quic_sibis@quicinc.com>, linux-arm-msm@vger.kernel.org,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20241121113006.28520-1-quic_rlaggysh@quicinc.com>
 <20241121113006.28520-4-quic_rlaggysh@quicinc.com>
 <bc926d6d-e3d1-4fbf-9b6a-bbd3816a766d@kernel.org>
 <b2a05dfb-a820-4450-a156-8d6b4bd59be3@quicinc.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <b2a05dfb-a820-4450-a156-8d6b4bd59be3@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: PUlSQ04ijqEBt6XcINhTUeZ8TMf8yl9V
X-Proofpoint-ORIG-GUID: PUlSQ04ijqEBt6XcINhTUeZ8TMf8yl9V
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 malwarescore=0 clxscore=1015 priorityscore=1501 impostorscore=0
 bulkscore=0 mlxscore=0 adultscore=0 spamscore=0 mlxlogscore=999
 suspectscore=0 phishscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2409260000 definitions=main-2411220109

On 21.11.2024 7:03 PM, Raviteja Laggyshetty wrote:
> 
> 
> On 11/21/2024 5:28 PM, Krzysztof Kozlowski wrote:
>> On 21/11/2024 12:30, Raviteja Laggyshetty wrote:
>>> Add Epoch Subsystem (EPSS) L3 interconnect provider on
>>> SA8775P SoCs with multiple device support.
>>>
>>
>>
>> ...
>>
>>> -DEFINE_QNODE(osm_l3_master, OSM_L3_MASTER_NODE, 16, OSM_L3_SLAVE_NODE);
>>> -DEFINE_QNODE(osm_l3_slave, OSM_L3_SLAVE_NODE, 16);
>>> +DEFINE_QNODE(osm_l3_master, 16, osm_l3_slave);
>>> +DEFINE_QNODE(osm_l3_slave, 16);
>>>  
>>> -static const struct qcom_osm_l3_node * const osm_l3_nodes[] = {
>>> +static struct qcom_osm_l3_node * const osm_l3_nodes[] = {
>>>  	[MASTER_OSM_L3_APPS] = &osm_l3_master,
>>>  	[SLAVE_OSM_L3] = &osm_l3_slave,
>>>  };
>>>  
>>> -DEFINE_QNODE(epss_l3_master, OSM_L3_MASTER_NODE, 32, OSM_L3_SLAVE_NODE);
>>> -DEFINE_QNODE(epss_l3_slave, OSM_L3_SLAVE_NODE, 32);
>>> +DEFINE_QNODE(epss_l3_master, 32, epss_l3_slave);
>>> +DEFINE_QNODE(epss_l3_slave, 32);
>>>  
>>> -static const struct qcom_osm_l3_node * const epss_l3_nodes[] = {
>>> +static struct qcom_osm_l3_node * const epss_l3_nodes[] = {
>>
>>
>> I think dropping const makes the code worse, not better. Commit msg does
>> not explain all these changes and I could not figure out the intention
>> (except modifying but that's just obvious).
> 
> EPSS L3 on SA8775P has two instances and this requires creation of two device nodes in devicetree.
> As Interconnect framework requires a unique node id, each device node needs to have different compatible and data.
> To overcome the need of having two different compatibles and data, driver code has been modified to acquire unique node id from IDA 
> and the node name is made dynamic (nodename@address).
> Updating node id and node name is not possible with const.

I think it would be better to just fix the interconnect API to do it
internally

Konrad

