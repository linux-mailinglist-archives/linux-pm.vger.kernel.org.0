Return-Path: <linux-pm+bounces-43691-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2GxMGYioqWlSBwEAu9opvQ
	(envelope-from <linux-pm+bounces-43691-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Thu, 05 Mar 2026 17:00:08 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C07282150B1
	for <lists+linux-pm@lfdr.de>; Thu, 05 Mar 2026 17:00:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C08DD300FC72
	for <lists+linux-pm@lfdr.de>; Thu,  5 Mar 2026 15:59:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 242D937F8BA;
	Thu,  5 Mar 2026 15:59:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="k726zjVG";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="ceTl3w7l"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C88B33B8D7C
	for <linux-pm@vger.kernel.org>; Thu,  5 Mar 2026 15:59:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772726359; cv=none; b=nNdDTmCFF2MoLPK+vNp+bCccVZ8YskMJTPAswA6ARlBhR6c+VQQy0Rie0vMYMxkryCeFFFd/lgODwnugItn8GMP9fdOcTqSyx8szXzmVt00AvvK95Y+N1QDEzdLjtg6njF6/ZvvOJsmDhXrDqDM/fTuEATPuNHC4FZuimQpeUGs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772726359; c=relaxed/simple;
	bh=nsz4kgvAEf+0wvPBtAtgWX1ce/NBoJxyIvXI/GBZp/I=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Q/ZM1e7WW6yZVuDHxgklR6OWCbHbuxwVlXQ1yG/b8JjHMx/7dzUauoJj6cBDjx+Q8KFzvSKAxuDWaB92iTQJ/R0+900Gd9Q5zwurnRzo/u8717zRIUO21XQBBPJvtD8M6BCOV/VBS/pFmyGv8uFQd3/TqbNULpktFvqcbemFHso=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=k726zjVG; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=ceTl3w7l; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 625AFjGH936026
	for <linux-pm@vger.kernel.org>; Thu, 5 Mar 2026 15:59:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	gJfVH6ArqBR8VxIevRdjDVBkwzQbm4lnsd8aP92U7Tg=; b=k726zjVGqsDbltY6
	l3mDbNIktlyZSUcmAHUEUQ9uj9BxbnOjPARzrXKAuCz2a5Z3/sK1HRm8X/2ZGHwP
	f9qFwRA8hR0SLE7YPYEvDXd4vvaAM75wEB6SkgEhe8zvBjiUw/Y9MMJ0VmTf3fGK
	SPRQs4Bcyr6LD0EcG48CUlW1dYweV+9uOvcYLAq3bK24abFvULob5ylriq+tdbqT
	JrEoHHjZVU455RWI58rLBltSuH2/CAeM7Eo6VnKih1baStv01C/tk6XvYcCwcmXy
	3zDCnF6kEOzm92tDwusjV06gjC520oc9YM6apvuvKdhnpT2KOusd/vFNv2PVDsgr
	pt2NkQ==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com [209.85.222.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4cq04u2qe3-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Thu, 05 Mar 2026 15:59:17 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-8c711251ac5so4688549185a.1
        for <linux-pm@vger.kernel.org>; Thu, 05 Mar 2026 07:59:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1772726356; x=1773331156; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=gJfVH6ArqBR8VxIevRdjDVBkwzQbm4lnsd8aP92U7Tg=;
        b=ceTl3w7lvUe5U5b3Kh6zob/PjuYpym6th8ctFsktrwwphl6MK9XtY7P56+gLYv8Og/
         CZPITVhWGxTEOp5XJuIA5T+1gOxn0n7q6wsaNLhNoIszo/l562nkTPFVCUa0D8SGATGT
         opsdegMzEtXzXjqtL3+9ebnGKjy865pfbAWJuQlavlKa0XDxbuwSmWVNHXF1WN4d41PS
         izLcGwgqpOMT7tDto2aUZ3ve54ya3dOLEFlariGYWSfp2NGqMNhBWZSPc09S/hWjoTu3
         7u5ELgotgmlbmwjm4VD1VOeljTbUCwg9yZfHE5wC70ytNNHkUib4uS2qLy2SrWFEfgzD
         iJUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772726356; x=1773331156;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gJfVH6ArqBR8VxIevRdjDVBkwzQbm4lnsd8aP92U7Tg=;
        b=kQPdHT0u/T78iBccUvpJGBVsF3GsjLgt4AlxaTnS+3BWSM8425sn7Fx3GYJJjKkd29
         bAwZTK5WFbO9ZXrxrSzDAxDfFLA+dKM0oFvhq+oDak2Tvj8jJpp2TqBmtq8oIln18DZQ
         /3jCTKWL7gB+peAy3/74uY51ZhOfVVA8YfL239fq55uR1RI6vynM3VCdLGeZmu0rfoL7
         bkCHqVB5obFWxq4pYr/JW43u+6COfkIbA+X2631hFX6fPIY175YS63+lYHeWua1qbqc4
         qMZ4kCLuLnoiLQxgVruF1rDp4MHhlnd2M4AxZ2BOGwulPmkmrpIGJ+PYK6+auO2fjcUv
         eNFQ==
X-Forwarded-Encrypted: i=1; AJvYcCUmtHPyHGabP8rZ8BZf3Nlwyv+/H2ZCWqfJJM0saSZ/ufbWiTMfs4CkL/1//cP6y+XQBxaYxZZUcg==@vger.kernel.org
X-Gm-Message-State: AOJu0YwBxgM0wf/id62gmpKuIhSM0X9iEkDCC2dT14MUHN8HXfYaCM7h
	ycAqYS8UYW2i0ajZWLXbcUwJElTpwEFbwIkwQuRS7cggBs+Aqh1ZZ+MMvdWq49WHp5ZfwlYFFVT
	jtNpKTqsMDt01BjUG5TbY5SSLWN6G+NwlZvLEiRE24z/EKGkOEE2q32KcXwvUqQ==
X-Gm-Gg: ATEYQzz3d6fQPHOeDzeLtVMwACYYKCei+0uZj6IizeHZjYmMm7aKdcinL4NvaZSK6U4
	9RKH5MnMD95WMN1rTKawjIblnT/ejrHVviCFZ5Yk0YVIUqThsD5RdsVrlHRVZLYkpYPzox3eZCe
	cqKZ3q3S5Vo9v5p426p8XBuJkLdnyraS1QuTq1jOnFwqYK5S6YfOSpN5laac+FJbw7OOVnNvAvk
	mdKFdyQlUCbd97GoD5CJ8TSeGZoDNbcAEISULUBOC64nR1IJdbnDYJS8FWy5ehBViJg5ZZLNWpi
	UDYBnUB8k9ngH2R5Cic/PIp+TBFUUiTR7JyLG+vACVXyqaCeA+DEI7pqStej+VrJBvOg5Q4Eu6w
	taAaHcE2No/fLM0BJ4sF3hvwScuEWaMNZRJMrnHpQ/ZLmv5fD
X-Received: by 2002:a05:620a:4096:b0:8b2:74e5:b36 with SMTP id af79cd13be357-8cd5afa5ad6mr741187385a.68.1772726355983;
        Thu, 05 Mar 2026 07:59:15 -0800 (PST)
X-Received: by 2002:a05:620a:4096:b0:8b2:74e5:b36 with SMTP id af79cd13be357-8cd5afa5ad6mr741182085a.68.1772726355454;
        Thu, 05 Mar 2026 07:59:15 -0800 (PST)
Received: from [192.168.1.29] ([178.197.219.94])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4851fae00absm46179485e9.4.2026.03.05.07.59.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 05 Mar 2026 07:59:14 -0800 (PST)
Message-ID: <c768706e-f063-44bd-92cd-f3984ad3bfbc@oss.qualcomm.com>
Date: Thu, 5 Mar 2026 16:59:12 +0100
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
 <5b6a4284-4766-424c-9171-feaa08c52ad1@oss.qualcomm.com>
 <2d852f07-0bd9-4076-b0dd-93425ed237f4@ti.com>
From: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Content-Language: en-US
Autocrypt: addr=krzysztof.kozlowski@oss.qualcomm.com; keydata=
 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
 cwzYbmi/Et7T2+47PN9NZAOyb771QoVr8A==
In-Reply-To: <2d852f07-0bd9-4076-b0dd-93425ed237f4@ti.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: sRJZiYrOyCb6Wb-98urTTli0adAfrMJY
X-Authority-Analysis: v=2.4 cv=eqTSD4pX c=1 sm=1 tr=0 ts=69a9a855 cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=gOEeR9iKwsj33Yj5oN/cWg==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=bHzazS_3SF2oTeVDu9QA:9 a=QEXdDO2ut3YA:10 a=PEH46H7Ffwr30OY-TuGO:22
X-Proofpoint-ORIG-GUID: sRJZiYrOyCb6Wb-98urTTli0adAfrMJY
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzA1MDEyOCBTYWx0ZWRfXyydUuVKreErD
 goZw/IRnuTst6pK+IlRP7PqIg+2s5z/5cCnu7TSeT3LTonr9C4+H26mkU1ju6fe+J9biV988Geh
 MbQlHxvoBf5VODxEOpzPkTv5XRyJwuR2z/JTh9WUhp2eEYprz4cpv/vKa0sN6NHn9be478eYfnZ
 oAQcFyOzqtbq1IEh9vUlDxwuGDzPfcdQ8yuOBkcECaemiFWs9Gcjq2wHnaPJeJv4Uf4xIN44TAs
 F8Pvdx8ZcILapICyOoavH8X5TGZ7BorjbtxJfyWmX1am36OQ36OkG/QpubxWP/O9SWiSHGZ2LMP
 65FN9F6JAsvAquHlRDqnh7sHVMGFW8lQGB40+kyaqrJOjp+FWlv7W7JmJv9VOzh1LU7HOsXou3z
 EPxTPtWfBmJqfNx/jN9aEYeYyI2v29WwK4Qs1cSquR6ze1jZwrF1S7AKP/DGLz4v6Dl49cpf6k7
 YQFgxwGhOAAOdqw0m7w==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-05_04,2026-03-04_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 bulkscore=0 clxscore=1015 priorityscore=1501 malwarescore=0
 lowpriorityscore=0 spamscore=0 impostorscore=0 adultscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2602130000 definitions=main-2603050128
X-Rspamd-Queue-Id: C07282150B1
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-43691-lists,linux-pm=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,qualcomm.com:dkim,oss.qualcomm.com:dkim,oss.qualcomm.com:mid];
	FREEMAIL_TO(0.00)[ti.com,kernel.org,baylibre.com,gmail.com,linaro.org,pengutronix.de,lists.infradead.org,vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[22];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
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

On 05/03/2026 16:52, Andrew Davis wrote:
>>>> The code is not correct logically, either, because functions like
>>>> ti_sci_get_handle() and ti_sci_put_handle() are meant to modify the
>>>> handle reference counting, thus they must modify the handle.
>>>
>>> The reference counting is handled outside of the ti_sci_handle struct,
>>> the contents of the handle are never modified after it is created.
>>>
>>> The const is only added by functions return a handle to consumers.
>>> We cannot return non-const to consumer drivers or then they would
>>> be able to modify the content without a compiler warning, which would
>>> be a real problem.
>>
>> This is the same argument as making pointer to const the pointer freed
>> via kfree() (or free() in userspace). kfree() does not modify the
>> contents of the pointer, right? The same as getting putting handle does
>> not modify the handle...
>>
> 
> In that argument, if we wanted the consumer of the pointer to not free()
> it we would return a const pointer, free()'ing that would result in the
> warning we want (discards const qualifier).
> 
> If you could somehow malloc() from a const area in memory then free()
> doesn't modify the pointed to values, only the non-const record keeping
> which would be stored outside of the const memory. So even in this analogy
> there isn't a problem.

I am not saying about malloc. I am saying about free() which does not
modify the freed memory.

> 
>> The point is that storing the reference counter outside of handle does
>> not make the argument correct. Logically when you get a reference, you
>> increase the counter, so it is not a pointer to const. And the code
>> agrees, because you must drop the const.
>>
> 
> The record keeping memory is not const and can be modified.
> 
> And where do we drop the const? The outer "struct ti_sci_info" was never
> const to begin with, so no dropped const.

We discuss about different points. I did not say the outer memory is
const. I said that you drop the const - EXPLICITLY - from the pointer to
handle.

And that API which gets a handle (increases reference count) via pointer
to const is completely illogical, because increasing refcnt is already
modifying it. Just because you store the refcnt outside, does not change
the fact that API is simply confusing.

> 
> If the issue is that the handle is not const inside that outer struct
> we could fix that,
> 
> struct ti_sci_info {
> ...
> -	struct ti_sci_handle handle;
> +	const struct ti_sci_handle handle;
> ...
> };
> 
> And with that change even your original commit message example issue
> goes away,
> 
> struct ti_sci_info *info = handle_to_ti_sci_info(handle);
> info->handle.version.abi_major = 0;
> 
> would now fail to work to compile.

But you cannot do that for other reasons in your code because you DO
modify the handle in all the APIs which you call "pointer to const".


Best regards,
Krzysztof

