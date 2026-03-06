Return-Path: <linux-pm+bounces-43855-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aI+hJUETq2kRZwEAu9opvQ
	(envelope-from <linux-pm+bounces-43855-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Fri, 06 Mar 2026 18:47:45 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id EBFBF2266BD
	for <lists+linux-pm@lfdr.de>; Fri, 06 Mar 2026 18:47:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id CC0393037F0F
	for <lists+linux-pm@lfdr.de>; Fri,  6 Mar 2026 17:47:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9D4A41B344;
	Fri,  6 Mar 2026 17:47:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="gc5bfsfg";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="YfzrkU7r"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A866B3B582A
	for <linux-pm@vger.kernel.org>; Fri,  6 Mar 2026 17:47:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772819261; cv=none; b=oLgoVbJu6KkB3Xj/UeYI8bP9ZMxzkAJyAPBSdIo28MeRADhM8PXy0gysKIAj5fzLxv8mmQ/GysaGThtbilGoaSQvHPw3AfsoNESttuuzgK3rVhqeQF7pXj5rhJI96pKgVOeURCmC0Il6e0kSf9h1wYADQha5T5B5H5qHLukFwEg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772819261; c=relaxed/simple;
	bh=MZoj1Zp4UcUKrCppYKZk7u6NI7JYXHrxsT/T7X3Se1M=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tN/q9ikChDrRjJhm4q392bKKS5GiYTyMo7HhrJwsgDOjsPijcmVaWvwwE/5/qGEgp5KwJ5zn3KOk6BNtqzXG9kIb0Sh5ewyKtw//eYEH1g1JytLMyLhDorU8Tc19MlhChSc4IXaEfNe5Ebd7J8D7IOhPKNOi/wJD4ANwGs3LWhc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=gc5bfsfg; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=YfzrkU7r; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 626H2R93742790
	for <linux-pm@vger.kernel.org>; Fri, 6 Mar 2026 17:47:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	GU4wXuq9kpZDHUDCo2D0RU4Kuhjlasu2wJX3TFoVNQk=; b=gc5bfsfgYiG7Wkfm
	bRjuAPqorP0C9wEN3tOXowtI+ySd0nhYc1OIGWOrXVaTFx+9xBjI4i2puRjpC+m3
	7r8EXYbge/cGRTkcUTlYva776J6PwxdjaWLlABUGND6CwkY76lnnIzPGW3ArTy5g
	nzjFsyC8LAwB+bhaZ2eB2NL8T6yAatMEWvV7lRsBbnOwWJoidj8iJMlkG7wc3ETx
	eFRbODG/kMIjBcD23uhEFr7hO8vQq7vEAKFFV4sRXPeyiI7aaO51lqWgBcRMyGsW
	N2h4MxvBpPTVka+T+IggBaUoDxdOfgEvDnIqwfW5FRVB8rrie9xSBP8nO5b7yaZD
	mBqVYw==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com [209.85.222.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4cqpxdttbg-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Fri, 06 Mar 2026 17:47:38 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-8cb6291d95aso1741267785a.1
        for <linux-pm@vger.kernel.org>; Fri, 06 Mar 2026 09:47:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1772819258; x=1773424058; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=GU4wXuq9kpZDHUDCo2D0RU4Kuhjlasu2wJX3TFoVNQk=;
        b=YfzrkU7rKAr2EkMP4o+oiT5WKUBFlQiTzt6MFnnITwasOcrs+K476lPLTNl+CdDnsT
         RGAlG/mfghdNUVszev9A1uUat0D63YEYwlYcjFivwvy9YdZPI3TuWmA1NfLL66qMVEa4
         MjLrTgb6CYTcWUSMm4rAZKOHxOJSRg95QID9gd6IB7bZ7Ywe/IckCxR/skEnti9Cb9ul
         Tp/IONqdcZ6Uw4rHu38ofBtkgyoLSQUBWcktH650fUQNn3euS5wIq+kdAoGhYK3nCfur
         BLDDs5jWTrbuwlIlmYj+i9H4WOAajxUQ17ml7KlOQWb4jaXpIvwkIEc2+lJ8GmxmegpS
         JM7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772819258; x=1773424058;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GU4wXuq9kpZDHUDCo2D0RU4Kuhjlasu2wJX3TFoVNQk=;
        b=SyBIT3jJgLfE6K/0UhCJgMFkH6h1sPjXz1pGAbrftk7Z9vTNP+WV2gnqMaopemUQn6
         KrV25wMNREB545K2BB3+iCJhedQwoccShqQXxs+5ocZZfAwbYeIYfLzNe1DZk8B8WHdv
         H7Qw1w58TZveT+Iyl81FfOyKQczSytPd5MVtKqyt6ocAjs+P89PD4BTNqDpd6L4lJ4u3
         SGKXPGK+CepCCMbJmXkNNnXYpT4H7mQe0td/ypYIspxlLK4CGy61u7ICcA8d7g9P6/o9
         52+kD4Z0oaoplEoJJ+ubPLHxCO+vNDqihtxcFNUPyV5yx9J86rTHLZm3CPeye2kjVNv4
         64Kg==
X-Gm-Message-State: AOJu0YzF8helW4FRQpheKRQ+3xkDqKQQq7CNBr1tw/9QKys4Wio7ojBg
	LdFFwHEm++6HWE8BTc3oLb5XWJQQaFm2v6yghhOFq0V9WK2RqK2X0QkiMyE3oF67w3IZtPyorgs
	he4r4ZQlqRuOsiw5zdnIuXzWM9V+1KZbs1Y794NVq3fFJQUzhqtlWO8yXD/je8w==
X-Gm-Gg: ATEYQzwds7UUxYLVhxxQdWMsAn6lQzCMgq9jP++/cUc86r+HXQL8iaB266hlxQP6iEP
	7Xb9sJejej1uQlMFzgIjEDYCcZUxHmwiljBGafKue3jDi9ZjDbNw/KvF17HWzb1rHBVV9v63pUO
	d8EUbk6N+jvNZ5U2fTF948IG+H915y5HkGVFnSldVBVOMIOaq+Ed4MD1GN95hslkH0J0FzNfv77
	0PvM4bcWIp4pHgdaJ3Nm9wrWx8YQG6edAoZR8IyuwENqsSs/5x9tvMI+RQtIx+fL9ph3WXPARM6
	7kzy2urVpLtzS+mtJMRh1pcqZUaAFleX4pxfiCIBmi4TJNYFIMmCS45NzaWTs6sJpVyGMcRSDpC
	e2nd0vYMMHULXgf3pBh0IbjfMmUOipE8cFQulyccHJxzuR8Cg86DTndCL/vc+tZHA/wXklQ==
X-Received: by 2002:a05:620a:444b:b0:8c5:2dbc:624b with SMTP id af79cd13be357-8cd6d4cc1d5mr371111085a.46.1772819257837;
        Fri, 06 Mar 2026 09:47:37 -0800 (PST)
X-Received: by 2002:a05:620a:444b:b0:8c5:2dbc:624b with SMTP id af79cd13be357-8cd6d4cc1d5mr371108285a.46.1772819257436;
        Fri, 06 Mar 2026 09:47:37 -0800 (PST)
Received: from ?IPV6:2a05:6e02:1041:c10:1265:158c:17d1:c76e? ([2a05:6e02:1041:c10:1265:158c:17d1:c76e])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4851fad27e6sm149170015e9.3.2026.03.06.09.47.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 06 Mar 2026 09:47:36 -0800 (PST)
Message-ID: <0e318331-73b5-41c0-ada5-46e38c74cbf7@oss.qualcomm.com>
Date: Fri, 6 Mar 2026 18:47:35 +0100
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] thermal/of: Add OF node address to output message
To: Alexander Stein <alexander.stein@ew.tq-group.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260305163508.2643106-1-alexander.stein@ew.tq-group.com>
Content-Language: en-US
From: Daniel Lezcano <daniel.lezcano@oss.qualcomm.com>
In-Reply-To: <20260305163508.2643106-1-alexander.stein@ew.tq-group.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: Jnt9ug2G0hLEFmn1a5jguXl8aUBZJk3P
X-Authority-Analysis: v=2.4 cv=E83AZKdl c=1 sm=1 tr=0 ts=69ab133a cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22 a=8f9FM25-AAAA:8
 a=Xhz3KCuwslOUG7yFF-0A:9 a=QEXdDO2ut3YA:10 a=PEH46H7Ffwr30OY-TuGO:22
 a=uSNRK0Bqq4PXrUp6LDpb:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzA2MDE2OCBTYWx0ZWRfX2wtWtmx/VWwe
 9pu4wKkTI0Njne/7edEc43278SR/60/t0N20mn4htx5I51ZeLDjCf35peUoLjq6Qpxl2/ypfyxq
 rCQshuecm7TMnuJzl3coHLRIrEvA+M2P0+C1QJ4MQsf4vHpxrMJu87bRM5z2dwo+GZdp/n6DCzw
 CypUSvYCIEXt1mgnth7qaYSrwrsfhwsTWyHQNBEJwPs9rW3aE4NXJ2MFXdRSxi/XaRVBrYXSUxl
 Q41+GY/lfQjklyj8bAYgz6Mp7DcAuX9uKXateMypyBRtbtTYGHqrVj7IeDW9VvAF1/6zOUMtMpe
 +yTnQmdyRKDrbBHT6SDRnDKVVnFMKvoHXUpX+lQAvmpA8YhlasetsTLGexBn4Z29WkK60gHagkS
 vLW3x0D6oMV/UbttU4dG2Xx9wemcoNtyCk3TgAJXk36mpy24jzOWiTaGYAyLd8ijQz4XrshUatp
 lLpwiOPqrXBMbRDX6zQ==
X-Proofpoint-GUID: Jnt9ug2G0hLEFmn1a5jguXl8aUBZJk3P
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-06_05,2026-03-06_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 suspectscore=0 bulkscore=0 phishscore=0 impostorscore=0
 adultscore=0 lowpriorityscore=0 priorityscore=1501 malwarescore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2602130000 definitions=main-2603060168
X-Rspamd-Queue-Id: EBFBF2266BD
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[qualcomm.com:dkim,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,oss.qualcomm.com:dkim,oss.qualcomm.com:mid];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-43855-lists,linux-pm=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-pm];
	FROM_NEQ_ENVFROM(0.00)[daniel.lezcano@oss.qualcomm.com,linux-pm@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-0.948];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Action: no action

On 3/5/26 17:35, Alexander Stein wrote:
> Temperature sensors are supposed to have the DT node name
> temperature-sensors. Having multiple ones the node name alone isn't very
> helpful. Add the node address to make them more distinguishable.
> 
> Signed-off-by: Alexander Stein <alexander.stein@ew.tq-group.com>
> ---

Applied, thanks


