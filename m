Return-Path: <linux-pm+bounces-43688-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4MC4AKGbqWnGAwEAu9opvQ
	(envelope-from <linux-pm+bounces-43688-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Thu, 05 Mar 2026 16:05:05 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A175214218
	for <lists+linux-pm@lfdr.de>; Thu, 05 Mar 2026 16:05:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A1331317C348
	for <lists+linux-pm@lfdr.de>; Thu,  5 Mar 2026 14:59:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E2893B5844;
	Thu,  5 Mar 2026 14:59:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="MYuEArvI";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="H18hMmfa"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B7AC3B5831
	for <linux-pm@vger.kernel.org>; Thu,  5 Mar 2026 14:59:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772722783; cv=none; b=WU28ygyi5GZiKTJvLIi8MOb913YYHZ7rb4shcaVAHlkKLx9v0uu9EfjdqfE8zcqlYt/rAcA7pMNs62LB/z959dIGTLP5gH3lfj1epZn7974Fef/JHgg7MTdUOG1b6aIRYbyiUy+t7K/it5dk9oKWUeWeIJsPWzUSwr5Trz+kKE0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772722783; c=relaxed/simple;
	bh=J2lbMFMnGYo6KcpMR6geLR+TBx5SW6z+n9kOHJ9ak+M=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=h40WFdZaoLUlQBJVEDgM+huWsUs9VYr4nPt968O2f5aLthpOmTtQVRp7bELeMr3xFL40lcRoUn4/NJPZFkSBPdvyifU/ldtkBiyyj4GYV01PFUNNbxM7+IH6KruHqf4geg9wFPCVvG7sZT9bhodHyR1oDSwhbwUm9y/73nO7tC8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=MYuEArvI; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=H18hMmfa; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 625CN0en719999
	for <linux-pm@vger.kernel.org>; Thu, 5 Mar 2026 14:59:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	SmnvSi+Mlmxa1/2IVU2T+BS0zKlOzWLnk6SgpB6s5WE=; b=MYuEArvINTLoJXn/
	5uRsYxESNS3mU0eg5ex/bV0qSOVNpejqqM+0NSrTM/9PrAj9giRpE7tLxs3ZWYFs
	Tq3t/E7uDBXw+RRfcFtOHukGf2rQoSJ0wX5wMt9P7GwUXf5iAmgUFtvEmDTV1BQu
	T5mEEsAmQVQCFyPhtu9SrB7+ZnKtA7ADmvyZ9w/jnKeHvy9Hux2cpOADjV66BFvW
	vcI1hXvcFRn6cxqcN9Mjzg4m4uzaMpZhqSBvDUfaC1H6OMfuupc+O1cExTSCyfZt
	m62vsrmeyyC5q1jB5p8mir57ZVUAu5m08vubsVGG0AhAgfFnu3PTXj+XNVi59vDN
	+xrkBw==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com [209.85.222.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4cq9srgfj6-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Thu, 05 Mar 2026 14:59:40 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-8cb37db8b79so5855642185a.3
        for <linux-pm@vger.kernel.org>; Thu, 05 Mar 2026 06:59:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1772722780; x=1773327580; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=SmnvSi+Mlmxa1/2IVU2T+BS0zKlOzWLnk6SgpB6s5WE=;
        b=H18hMmfa9AAXxi3tUB90f7umkSTsW0ibaHPVjl5IGwSteExRTMvTvIlLb61g25UYsO
         9qJrzsFuJiwz/8Cj1XNMaPMtKrG6RDF/iwaGnVaafxSQbe8WGWxVtiig3MdhtT7CAGy+
         cDjKqf+GBq4MoRlwMiNC1CvzQa0sA7XX4AkM5gH3HSeS0O9vFsiyDgYP/a1P0TG7LlFu
         MIzQ8gDs5WT++t29N52mus5igS9f7AQurMANZsTzFSMdRSfWXUZD/NBoH0kkhLqjOEMm
         KqVj24tZZa1CD1ZnpKzx+0ZVbJpOz4o0gjt0uaLa+6s3doyEetN7Q3JZmGKceq2zl9gn
         D3nA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772722780; x=1773327580;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SmnvSi+Mlmxa1/2IVU2T+BS0zKlOzWLnk6SgpB6s5WE=;
        b=Qv0hAx/JrLPFiB2uTl2AJMyv8LSfXqpRbbCZWCei750Y/JY/wZdeFIViBSqbKrbz9z
         5RZl3t05YHMtRxCOAkIhB5ctrp4aYhWsbdk+cytFnYvjLSDJ3BtchV5u++QDlY0nAx2V
         37Mxj7qyOWywCzfgChVGmePWOPhfeVv9rix8IKMhGS+mfOoFZzNSL3R/QxoWAIdtaxo4
         7bM6aPcJipijZ8sS2lDixVOKZP5s1r8RLZIR87n1DpdoHvA0/v2GMevfPfxaBXDNThR3
         LSmwrvwfEY4a7a9MZ4dgtKKNDOv/pCYCe0/LzlPJXUu4Mlu01NDPgR7SIs6ZABQP+vrm
         TdOQ==
X-Forwarded-Encrypted: i=1; AJvYcCWwGhkvMI1+PUQSwgV9WKUQo8O89d48yZF9+r4lBviRVmiQ8VV0JRlUU2XpOus8mSDAhupd3fl6lA==@vger.kernel.org
X-Gm-Message-State: AOJu0YzHdG1lwI3b4H6ztk8F3wSNTvOWSg1CTgsp1P/78kBJPjA9NoHI
	gRw/dFd4VPax45KeaLXE7TOH8K5+KUZuTPwoljcRoBN21zppDFAb+GcfWZ+jpneGMbHMQ3PfOSI
	lllFsnlEZy++Xx5Bf90WSXPinBA1V8tc5xCgZ4GMOaQpECvZ5lqM+1O56t+w6Qg==
X-Gm-Gg: ATEYQzzOMdi5/aer/IJgaVdR1crYl8zPgWbVil60naCKyDm3IeJ57oqvggYwhquE998
	Nk6sV3L/JhFnEYAfMcX4NEm+E5c78z5xDgE+lQ58en1qoKREKj1yVqwzh/XbS0tIvOcrc2aHxjL
	eDiWHz5k+aP/Dy7PG8Sxs5ImsrSFw1iVucvaJ8zsGcZS8+nTCTRINL70wj5NT6OAXpeofWBZpJ0
	texTyTSH0efb71XylHOmyiyEdeEku5lXN0Yezl/jNg9/phxjZ9buGD9B+wY5GuArPRC2cdyay7x
	WgIoslI8nAjvGQZ0P8GT0ch9+e4fIV03bA0annSyq1/64OVbD1OVBbSc/OojV3Mj/aTnC65XuMI
	+kn+9M7csEFX6KZ6hUXOar2Q23dDSFE+ZGxskSqQqpq4Flxpz
X-Received: by 2002:a05:620a:4481:b0:8c6:adfc:48f0 with SMTP id af79cd13be357-8cd5aefa21fmr710570585a.28.1772722780178;
        Thu, 05 Mar 2026 06:59:40 -0800 (PST)
X-Received: by 2002:a05:620a:4481:b0:8c6:adfc:48f0 with SMTP id af79cd13be357-8cd5aefa21fmr710564485a.28.1772722779676;
        Thu, 05 Mar 2026 06:59:39 -0800 (PST)
Received: from [192.168.1.29] ([178.197.219.94])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4851a8d20f7sm36871635e9.8.2026.03.05.06.59.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 05 Mar 2026 06:59:38 -0800 (PST)
Message-ID: <5b6a4284-4766-424c-9171-feaa08c52ad1@oss.qualcomm.com>
Date: Thu, 5 Mar 2026 15:59:36 +0100
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ti: sci: Drop fake 'const' on handle pointer
To: Andrew Davis <afd@ti.com>, Nishanth Menon <nm@ti.com>,
        Tero Kristo <kristo@kernel.org>,
        Santosh Shilimkar <ssantosh@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd
 <sboyd@kernel.org>,
        Peter Ujfalusi <peter.ujfalusi@gmail.com>,
        Vinod Koul <vkoul@kernel.org>, Frank Li <Frank.Li@kernel.org>,
        Thomas Gleixner <tglx@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Dave Gerlach <d-gerlach@ti.com>, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        dmaengine@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-remoteproc@vger.kernel.org
Cc: stable@vger.kernel.org
References: <20260223202426.566958-2-krzysztof.kozlowski@oss.qualcomm.com>
 <195cc8dc-8642-481c-8bdd-f5409ab8f5b5@ti.com>
From: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Content-Language: en-US
Autocrypt: addr=krzysztof.kozlowski@oss.qualcomm.com; keydata=
 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
 cwzYbmi/Et7T2+47PN9NZAOyb771QoVr8A==
In-Reply-To: <195cc8dc-8642-481c-8bdd-f5409ab8f5b5@ti.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=a/I9NESF c=1 sm=1 tr=0 ts=69a99a5c cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=gOEeR9iKwsj33Yj5oN/cWg==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=dua3lmL7_bghm9Z8UcoA:9 a=QEXdDO2ut3YA:10 a=IoWCM6iH3mJn3m4BftBB:22
X-Proofpoint-GUID: tkcGKMtFYJyz8rG7unS7yTraX22-5htf
X-Proofpoint-ORIG-GUID: tkcGKMtFYJyz8rG7unS7yTraX22-5htf
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzA1MDExOSBTYWx0ZWRfXy3aecAD70b3a
 1fLf2t2CjdiJk3AFBF/4AYFXpVtdxzTdFSwFuynlRkX8oqBod9fxrqNFTW09XshSB+8DQQRmsJY
 qQo7Fbqbhm/TkFNHmLywwhKnVvBO0+Fws24+qzKgIJsdR7RoWlWgHq1mRB8fBNcAH5H1h/F4NaD
 Stf17IqRwnISTegcUx3U/5OqsR4w23KTYk/eAi3vd5uSSS+EfGleuIIJYpUzYiuendaDXugp1Sj
 h2oYLYfmB+6reKnG+fPTIxrQar65g42CbWsZZNRJyfn+TZnv8QnuPORxHaOEvTPjAgl0eunvNec
 IVvuORoLjMhC9pNzw/j+jFPDtkciXUPHkRyr9mQaFxvSdUfHWxBpTz2fgb+iCi8zwLuIOeEAbdn
 JWVKkPj8p+eJRi413fKhpz5VnHgf6lFsKs+b3eymIw+JtOvmZ2IzqC3eQIi49Z4uujHBZXwQOTE
 1yyNHK+e8w7GSZf72pw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-05_04,2026-03-04_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 priorityscore=1501 impostorscore=0 phishscore=0 bulkscore=0
 suspectscore=0 spamscore=0 clxscore=1015 lowpriorityscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2602130000 definitions=main-2603050119
X-Rspamd-Queue-Id: 9A175214218
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-43688-lists,linux-pm=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,qualcomm.com:dkim,oss.qualcomm.com:dkim,oss.qualcomm.com:mid];
	FREEMAIL_TO(0.00)[ti.com,kernel.org,baylibre.com,gmail.com,linaro.org,pengutronix.de,lists.infradead.org,vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[22];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[krzysztof.kozlowski@oss.qualcomm.com,linux-pm@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[linux-pm];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Action: no action

On 02/03/2026 20:12, Andrew Davis wrote:
> On 2/23/26 2:24 PM, Krzysztof Kozlowski wrote:
>> All the functions operating on the 'handle' pointer are claiming it is a
>> pointer to const thus they should not modify the handle.  In fact that's
>> a false statement, because first thing these functions do is drop the
>> cast to const with container_of:
>>
>>    struct ti_sci_info *info = handle_to_ti_sci_info(handle);
>>
>> And with such cast the handle is easily writable with simple:
>>
>>    info->handle.version.abi_major = 0;
>>
> 
> The const is for all the consumers drivers of the handle. Those
> consumers cannot do the above becouse both handle_to_ti_sci_info()
> and struct ti_sci_info itself are only defined inside ti_sci.c.
> 
>> The code is not correct logically, either, because functions like
>> ti_sci_get_handle() and ti_sci_put_handle() are meant to modify the
>> handle reference counting, thus they must modify the handle.
> 
> The reference counting is handled outside of the ti_sci_handle struct,
> the contents of the handle are never modified after it is created.
> 
> The const is only added by functions return a handle to consumers.
> We cannot return non-const to consumer drivers or then they would
> be able to modify the content without a compiler warning, which would
> be a real problem.

This is the same argument as making pointer to const the pointer freed
via kfree() (or free() in userspace). kfree() does not modify the
contents of the pointer, right? The same as getting putting handle does
not modify the handle...

The point is that storing the reference counter outside of handle does
not make the argument correct. Logically when you get a reference, you
increase the counter, so it is not a pointer to const. And the code
agrees, because you must drop the const.


> 
> Andrew
> 
>> Modification here happens anyway, even if the reference counting is
>> stored in the container which the handle is part of.
>>
>> The code does not have actual visible bug, but incorrect 'const'
>> annotations could lead to incorrect compiler decisions.
>>


Please kindly trim the replies from unnecessary context. It makes it
much easier to find new content.


Best regards,
Krzysztof

