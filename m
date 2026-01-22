Return-Path: <linux-pm+bounces-41331-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4IVZDgZ+cmmklQAAu9opvQ
	(envelope-from <linux-pm+bounces-41331-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Thu, 22 Jan 2026 20:44:06 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 612436D2A6
	for <lists+linux-pm@lfdr.de>; Thu, 22 Jan 2026 20:44:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id D335D3002B5D
	for <lists+linux-pm@lfdr.de>; Thu, 22 Jan 2026 19:44:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9511B374734;
	Thu, 22 Jan 2026 19:44:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="JwBPpL0R";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="TPaOOQG0"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B777832E6BC
	for <linux-pm@vger.kernel.org>; Thu, 22 Jan 2026 19:43:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769111037; cv=none; b=CZCPsWbIof57UOhfHkdx81YL0mFQXXPRKSj3fHOknmQpu+3QOc1o2I7uGJfbgneZKw9QTm9ZRXnDhs96n2ifB1GWwyt7MjHAq9bKAk6sUpmmXdhpYK6gagcDJq8n3uSEPoS0mz7Gg0Nuhv7llS8fXH8W+GTVfsIvy21kMHkxCeg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769111037; c=relaxed/simple;
	bh=9rsKXIE31gTBR0x7TqIbrMufINopJsjLamejzKyRKKI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=l7S6LifG1P8BSvfdr8UNcbX5X2flfJBvZrA+3WsAy++kOxGIFut0SkZRO2epSFXMKpHT7zx11/D9lB9Nsue+uG+43vq7GivDm5BTlhEe7/dWWHG7pNVPktZD5VBbQHPZg1aoWj5n9CKD8BT58f+y4AmgxgN3WiLkOMAQJWg7jeY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=JwBPpL0R; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=TPaOOQG0; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 60MH4kOj3283238
	for <linux-pm@vger.kernel.org>; Thu, 22 Jan 2026 19:43:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	Fk3pUDgcfEz61b1Sxdo+ROI51s1I7AiQwz+sq54t1DM=; b=JwBPpL0RHrYWf5l5
	3nrdkp8ljx3hGWSD2LxEleSChAQOovVIl4EGF96H7tH2y9lxDHTNH+/22hjR0034
	fg1Es0X3OFl/UI8zw5Ql/fVvzTq/Po5G7hFf0CXZUDGF912uaCnglhgRneksZuBJ
	COUj0EY7CfJOh4efGDLzvcfy5GrcLxitOMGaU3GT8C4ipeUe5mvmlJFL9vE8+m59
	FG2ZL7asqxoVY6WV6sbIAvTaOc2N0bf3MCFdrdssY6HCeJ7k7PM4L/VEn/doLjPj
	p2o/Ieqi6Tm5aLSYJk9N5qpJMMhFQXuM8tAGCrS8xgxPok9jG7QkbYv1DTgTc17c
	MyvDRw==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com [209.85.222.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4buqyp0j09-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Thu, 22 Jan 2026 19:43:43 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-8c6de73fab8so26564185a.3
        for <linux-pm@vger.kernel.org>; Thu, 22 Jan 2026 11:43:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1769111023; x=1769715823; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Fk3pUDgcfEz61b1Sxdo+ROI51s1I7AiQwz+sq54t1DM=;
        b=TPaOOQG0c+a30w+PAaGcSmJnzR0QXXxfkyIZZ/FLv+n8P/CDylje4noYVTAYMEMB2v
         Zz1C+Y7GifgeVTqMAcD3Zrn4Z02ZtpxOa2/AAbSZR9m3SAhUL4eDrbfhjbJ9oJLEPsDn
         diUWBDVMtymH7HiVRWLe1PJubAzPRaXSaIityPS1f6xjzwCw6sz7AZdj/VNkSw11+MBh
         aE7w0k7YRySL3JR4zMKqQDEZD7XiAdrviXsJkH/L8I24l/qEm5J/WXT72WUsQ1hfwQrS
         elLKtMBHPi+ZmQiJ9l4m56/0QZ+/r/OIMNNrRAjqJcrYlCecdCwnCLEK322z2enJ5tEp
         AqRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769111023; x=1769715823;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Fk3pUDgcfEz61b1Sxdo+ROI51s1I7AiQwz+sq54t1DM=;
        b=wY6C8yjnDFRmYTuhPLppIh29tm7OHJpTC5Odfc/ZFQT73lU966fYDhzAzIG8Go4IN3
         Blho29rUdZJ+Jk1mmWrSqwjAn5bsiHrxDqm33D7slmHdjuKqC/HuyMHc1CGqJ9yd8J1l
         ksRkX4u4MouQs7pubXbHKXA8BMQrkhZTY7tT3juB9hmicVERQamkHUKullUyAwFA8ouO
         qr3drSKL5PhE3rQfxWdL3iqQhS1hAk3PpuSQkDFSBZm59HkKC3uV/CeoIsnyJIn8NsR4
         P4yt4DwJChUVEBJIx4DYBjjp9LqCeYyTohUMppAgFiZovGriqbaYYYE2irp2STwgMlMI
         ZqHg==
X-Forwarded-Encrypted: i=1; AJvYcCU9CCIdb9ffNUuSWjhNhDRoxfzddpYT3W4BnITn3ND9erTH3eCCgccX9SyRrX0CGXBswXeFUxjXlQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YzQ0nLm+SDbYfBpShFsVaDyGA6wtw/6RwJ/ksnU5/h11IX+VRlI
	RRQjdMP5EPUW0kU5+weM7UCeq0bgf0iFCFH+hQoueJHbNTUkXdVr5N7uM23qoEdPkyRxfrl4Z9D
	8DN8DqJAsSNNE98hnDb9RycP+OjTblMHkE7hxLdL/+ojG2B60pAgQK/6ZikgGnw==
X-Gm-Gg: AZuq6aKZ5m3Ww35bSh/AUqBUMaigxdfXm06gpbyWpZK9f9cMuNNVlPTxTF4gbk5cwu3
	NTiCSHOYzK4SxKC07L5ktFqo2/bTH+ue5JMVtVkQKohTYJKxcxZWBd6O1v5owCxNvEwexDNxoma
	DIClBkJ95TCEpyN8EtzYxK/tK/PVTdaOCOme5vG6GxnmPviuKJozMcAb1dvXFBZz6b5koInW4aY
	Fia4sFCLoPiP0zyawJo05bHS1HiEQofIXXrKEyXU/Uxu2bzHACxzai8y7xNNKWwO+9qgLWCDL0C
	vX2c/3JpHcNlBTnLJHWL00+HOZTfvVntohD82m+G82qJyB31uGeDOqfz5xIJAuT+pJ5Pb/wuw4g
	qYhbRB91O+au7Fn0mBtK+ho/5EUQcpy9OjkgFMtoI/cFDN9RMiboutA8IaStSObJHkyE=
X-Received: by 2002:a05:620a:45a2:b0:8c5:33bf:524c with SMTP id af79cd13be357-8c6e2e1d328mr56826985a.6.1769111023083;
        Thu, 22 Jan 2026 11:43:43 -0800 (PST)
X-Received: by 2002:a05:620a:45a2:b0:8c5:33bf:524c with SMTP id af79cd13be357-8c6e2e1d328mr56825685a.6.1769111022620;
        Thu, 22 Jan 2026 11:43:42 -0800 (PST)
Received: from [192.168.119.254] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b885b3db257sm11079966b.6.2026.01.22.11.43.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 22 Jan 2026 11:43:41 -0800 (PST)
Message-ID: <466605a7-c860-4691-b84f-5d1486b49bf0@oss.qualcomm.com>
Date: Thu, 22 Jan 2026 20:43:40 +0100
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] interconnect: qcom: msm8974: drop duplicated
 RPM_BUS_{MASTER,SLAVE}_REQ defines
To: Gabor Juhos <j4g8y7@gmail.com>, Georgi Djakov <djakov@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20260122-icc-qcom-dupe-defines-v1-0-eea876c2d98f@gmail.com>
 <20260122-icc-qcom-dupe-defines-v1-2-eea876c2d98f@gmail.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20260122-icc-qcom-dupe-defines-v1-2-eea876c2d98f@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=RMy+3oi+ c=1 sm=1 tr=0 ts=69727def cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=vUbySO9Y5rIA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=pGLkceISAAAA:8 a=EUspDBNiAAAA:8
 a=PErah1Q9QXaL-jeRjzYA:9 a=QEXdDO2ut3YA:10 a=zZCYzV9kfG8A:10
 a=NFOGd7dJGGMPyQGDc5-O:22
X-Proofpoint-ORIG-GUID: Vz_XdR8UIymhh42M4ITPhMAyjN4IWty5
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTIyMDE1MSBTYWx0ZWRfX52meDY2LjpsP
 tH7bo8KcuyOqizXlr/M2rR09FgrJvoUifiJkEThd9G1tbdDlhi8SYVf03yAj5NKoEieJk/Xqreu
 Gc3WHkXlyztne+uEpmTMVwdih3W0J2+4o5S3qiW0mcE41RMxWvRIP/7+NPbwpsS8d9YF9MU7GuO
 qXo4soaDkUWsxiwYA/5iyOV4ScY+FEGlGIdLsnFpp6pNV0G+ni82LJp9vXIOhJhE3557xnJdpHl
 i5tkDm65x66wKLo7xr5fmArmxoXoH54pmY9vrao64OIaKnY2am9T3wDNWAcH5/1KEZQO7rHuIz9
 geV+BFlyFEeOrv2HkA+vpirp43DIZjGvTHfBfYQCk3tCJzDAoJoWjwJl0EmSMzuD5u6NmgMksTX
 kErFKTykKKXI1GRJwZc+szoCJT9NIbDw1kfnq5PSaMUW898r0gAWnS8dWRuKo4XIfqCdjXg6yvF
 YmF7ib/JKT8U0oi/ziQ==
X-Proofpoint-GUID: Vz_XdR8UIymhh42M4ITPhMAyjN4IWty5
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.20,FMLib:17.12.100.49
 definitions=2026-01-22_04,2026-01-22_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 priorityscore=1501 clxscore=1015 impostorscore=0
 lowpriorityscore=0 suspectscore=0 bulkscore=0 adultscore=0 spamscore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2601150000
 definitions=main-2601220151
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-41331-lists,linux-pm=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,oss.qualcomm.com:mid,oss.qualcomm.com:dkim];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[konrad.dybcio@oss.qualcomm.com,linux-pm@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[linux-pm];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 612436D2A6
X-Rspamd-Action: no action

On 1/22/26 8:34 PM, Gabor Juhos wrote:
> Both the RPM_BUS_MASTER_REQ and the RPM_BUS_SLAVE_REQ constants are
> also defined in the 'icc-rpm.h' header.
> 
>   $ git grep -nHE 'define[[:blank:]]+RPM_BUS_MASTER_REQ[[:blank:]]'
>   drivers/interconnect/qcom/icc-rpm.h:16:#define RPM_BUS_MASTER_REQ       0x73616d62
>   drivers/interconnect/qcom/msm8974.c:176:#define RPM_BUS_MASTER_REQ      0x73616d62
> 
>   $ git grep -nHE 'define[[:blank:]]+RPM_BUS_SLAVE_REQ[[:blank:]]'
>   drivers/interconnect/qcom/icc-rpm.h:17:#define RPM_BUS_SLAVE_REQ        0x766c7362
>   drivers/interconnect/qcom/msm8974.c:177:#define RPM_BUS_SLAVE_REQ       0x766c7362
> 
> Drop the local defines to avoid the duplications.
> 
> No functional changes intended. Compile tested only.
> 
> Signed-off-by: Gabor Juhos <j4g8y7@gmail.com>
> ---

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Konrad


