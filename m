Return-Path: <linux-pm+bounces-29526-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C756FAE884B
	for <lists+linux-pm@lfdr.de>; Wed, 25 Jun 2025 17:36:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D03E317183D
	for <lists+linux-pm@lfdr.de>; Wed, 25 Jun 2025 15:35:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 553032877DC;
	Wed, 25 Jun 2025 15:35:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MQfl/deX"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74C80267721;
	Wed, 25 Jun 2025 15:35:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750865712; cv=none; b=NdoT5z5rYxpoQCwBs99S1HW5GSIQcHUaETyy8DgGBtBMlVPrSG6atd68QzlB3gs1HdVSSfQSQR7MrtztZISOL8Kn6RJoOmzhSxdfEl3/CPn/XThaqcqCp3pLQawd+RZVyJkGbbBM35+3EskGD+qeWWN0hyEtXQLChyl1YU4+Gs8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750865712; c=relaxed/simple;
	bh=SLnSxdMzd49CyJZwsXNyR3humeDN79RoQxLvBq8LQ2E=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=efXiq4Qe0cr77aCUr716hOD0CC0f+7tzJjoDf9RKrAVueaHu7RsBQ7sDfYzqjKE/qsR/3++2yu3+NxcxKeDMWW8FBfcPltX2tzeYj5Eijr3uGUJpOZhzMe7s4xnWjuQDfclJFI5dIvVhVUw0jSIFNW9F6Mkpv96OlkUpNLXHyUc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MQfl/deX; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-3a50fc7ac4dso1170424f8f.0;
        Wed, 25 Jun 2025 08:35:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750865708; x=1751470508; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=qAN3bI/nam6BzXmhzco2pYTH1ZOriVDoBYCaiNU5Q5g=;
        b=MQfl/deXSrjqEaLrR5t7fj2RMFuc3WaEArHoi3stTSQMiVk8gijV7K5xW8VgcGW4Vu
         djnca8dP7EyanjcM2k4sAMfFrlLyidxMPVmchuIbadjA1f+SK98y7xfHNXmlmeEKSEbM
         5sGr6oPjoahYFLTpjz8usLbIIMMFvqGSeXeJoyyzTzb+gR03P4SC/dfXA+zJPWF003Mb
         whgHR/xMII5ULwuedngzj7NhT7ZvAWdi0fV15xe0kVypSK3gLIx0B/lMiEwvC92rqLT9
         WU66p6anw+xT3XloM+tznZejA2tRSsOEOjo0X+TNqcOnoxpJwVDypfJABuGdV/JvwYLm
         YdDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750865708; x=1751470508;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qAN3bI/nam6BzXmhzco2pYTH1ZOriVDoBYCaiNU5Q5g=;
        b=d0WFnCNwD1iBW8eGyVRoONe9zo+GqdQUmjBmt9x31zy/3UQ1m9dhSmUcR7Cp7eiF/G
         RIxbKEuQ00ixPP9s7ZSRdSPE9TJC8FJtPjrzfNztQH9DeSNOXK3L5t2qU30dgT/zWamQ
         YX5MizF8WgL0uVwhmgdLuoDrkQBmDvRGKG7ec6Vq16soS+fc7bWuQzFYSgkEoC+JSK9+
         CYbdGFXxEcOqv5zezwGs6iqXBMR97M8UIPUvZStDj4U/3iB+Ct/plKuOYaL3T08mu5i4
         yPGIJZJVFoWKvUILPkr4VPbLKtc8c5Qevz8qGhxpU7nS1GzbtuN1DObmWz+BYjsFYFcE
         CSlA==
X-Forwarded-Encrypted: i=1; AJvYcCVy11kpLOAZLemiwDMPrdJr0yXBDlIMbWc3zLjmDAA8xE+ncg0zmMfyIoL+VskjlXuVZrXdzmkbOuCXt7yn@vger.kernel.org, AJvYcCWIYWwE/I46OlSDoWw8jlk6NX5vjSAoxJYLpL/186OaNPQ74hlisBUfZMVWCAYiAEj/y0D2f//FaYM=@vger.kernel.org, AJvYcCWaKX2Ij86/xkIwBGzrvn+5ByyyymZJoFbs1F4fiWV8yTnkb3GoQGXlDYB8mS2XNA0tYx/cByt+aUviOseE@vger.kernel.org
X-Gm-Message-State: AOJu0YwB8jM3KljP3YOxp40QumdL6UAIy5NoWw6EpLRBtfQ+vGbTjhA1
	Lxv+EHR1YpFV+PxUXqnpZlzGLR3uUEkSS46Yj3O1pUWU61cCwYmvZ2dslSJZIA==
X-Gm-Gg: ASbGncualWOiPmgOvWzbly2Mbo7umysG6TJh+iI2gYTBwJ+LsLd56BcUl7EeXiu5QmG
	KYrPZqlvfTl1xxAbxrXUhFe0YCBRO+9VMZnqBqWaYwfFcnvAIg+FeWMc0DYvSu9I+MENxNgOwDE
	nlXQ5iwg+EqPRyQbwWtps7w0DipqX0SepOupl41y1qfj8gh2VdifIv93H9zLRZdeAFdN+Y9YlUV
	ZqvafLRHkmfMQtV6Q2XBg+4ccBo53w2gKEOVUEMH38//ktj4OCbvNGOJ/JW5eeqIvH6h5g4dP+z
	oESY0r2gbrmu/FqaPWR8bKANfAF84xs5C+1xsUHoG680Su0Mzk8nZhn4HHHNg9w2rmTSPH40Hwp
	3Y44L5vJcbcGRAWv9GzhqVOBIM3Y=
X-Google-Smtp-Source: AGHT+IHR6Q4kuNfzivi7gk/SqdDnJ4iePjEkphL6vUUKC52dSMwy2Js3+Cwst/JU0qjvPRKcNdNiPg==
X-Received: by 2002:a05:6000:2006:b0:3a5:3b14:1ba3 with SMTP id ffacd0b85a97d-3a6ed66eaedmr2636093f8f.49.1750865707405;
        Wed, 25 Jun 2025 08:35:07 -0700 (PDT)
Received: from [192.168.20.170] (5D59A51C.catv.pool.telekom.hu. [93.89.165.28])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-453823c42e1sm23251785e9.37.2025.06.25.08.35.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 25 Jun 2025 08:35:06 -0700 (PDT)
Message-ID: <ac5ba192-b538-457e-acc4-c2d358b1fd0e@gmail.com>
Date: Wed, 25 Jun 2025 17:35:07 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] interconnect: avoid memory allocation when
 'icc_bw_lock' is held
To: Johan Hovold <johan@kernel.org>
Cc: Georgi Djakov <djakov@kernel.org>,
 Raviteja Laggyshetty <quic_rlaggysh@quicinc.com>,
 Johan Hovold <johan+linaro@kernel.org>,
 Bryan O'Donoghue <bryan.odonoghue@linaro.org>, linux-pm@vger.kernel.org,
 linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250625-icc-bw-lockdep-v3-1-2b8f8b8987c4@gmail.com>
 <aFvr1zSkf4KmIcMT@hovoldconsulting.com>
 <aFvuiVX0kMIqXQtZ@hovoldconsulting.com>
 <84b94649-a248-46b0-a401-772aeb8777a2@gmail.com>
 <aFwBYRF0wJwVDdeX@hovoldconsulting.com>
Content-Language: hu
From: Gabor Juhos <j4g8y7@gmail.com>
In-Reply-To: <aFwBYRF0wJwVDdeX@hovoldconsulting.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

2025. 06. 25. 16:02 keltezéssel, Johan Hovold írta:
> On Wed, Jun 25, 2025 at 03:15:53PM +0200, Gabor Juhos wrote:
>> 2025. 06. 25. 14:41 keltezéssel, Johan Hovold írta:
>>> On Wed, Jun 25, 2025 at 02:30:15PM +0200, Johan Hovold wrote:
>>>> On Wed, Jun 25, 2025 at 01:25:04PM +0200, Gabor Juhos wrote:
>>>
>>>>> @@ -276,13 +276,17 @@ int qcom_icc_rpmh_probe(struct platform_device *pdev)
>>>>>  		qcom_icc_bcm_init(qp->bcms[i], dev);
>>>>>  
>>>>>  	for (i = 0; i < num_nodes; i++) {
>>>>> +		bool is_dyn_node = false;
>>>>> +
>>>>>  		qn = qnodes[i];
>>>>>  		if (!qn)
>>>>>  			continue;
>>>>>  
>>>>>  		if (desc->alloc_dyn_id) {
>>>>> -			if (!qn->node)
>>>>> +			if (!qn->node) {
>>>>
>>>> AFAICS, qn->node will currently never be set here and I'm not sure why
>>>> commit 7f9560a3bebe ("interconnect: qcom: icc-rpmh: Add dynamic icc node
>>>> id support") added this check, or even the node field to struct
>>>> qcom_icc_desc for that matter.
>>>>
>>>> But if there's some future use case for this, then you may or may not
>>>> need to make sure that a name is allocated also in that case.
>>>
>>> Ok, I see what's going on. The qn->node may have been (pre-) allocated
>>> in icc_link_nodes() dynamically, which means you need to make sure to
>>> generate a name also in that case.
>>>
>>>> And that could be done by simply checking if node->id >=
>>>> ICC_DYN_ID_START instead of using a boolean flag below. That may be
>>>> preferred either way.
>>>
>>> So you should probably use node->id to determine this.
>>
>> You are right. The problem is that ICC_DYN_ID_START is only visible from the
>> core code. Either we have to move that into the 'interconnect-provider.h' header
>> or we have to add an icc_node_is_dynamic() helper or something similar.
>>
>> Which is the preferred solution?
> 
> I think adding a helper like icc_node_is_dynamic() in a separate
> preparatory patch is best here.

Ok, although i don't see why it should be done in a separate patch.

> If it wasn't for nodes now being created also in icc_link_nodes() we
> could otherwise perhaps just as well have moved the name generation into
> icc_node_create_dyn().

I already have tried to add the name allocation to the icc_node_create_dyn()
function, but I was not satisfied with the result. B


> Now it seems we'd need a new helper to set the
> name (or add error handling for every icc_node_add()), but we've already
> spent way too much time trying to clean up this mess...

True, and the patch is getting more and more complicated with each iteration. :)

Nevertheless, I think that we can have a simpler solution. We can create a
wrapper around icc_node_add(), and allocate the name from there. I mean
something like this:

int icc_node_add_dyn(struct icc_node *node, struct icc_provider *provider)
{
	if (node->id >= ICC_DYN_ID_START) {
		node->name = devm_kasprintf(provider->dev, GFP_KERNEL, "%s@%s",
					    node->name, dev_name(provider->dev));
		if (!node->name)
			return -ENOMEM;
	}

	icc_node_add(node, provider);
	return 0;
}

Then we can change the qcom_icc_rpmh_probe() and qcom_osm_l3_probe() to use the
wrapper instead of the plain version. Since the wrapper can return an error
code, it can be handled in the callers. And as a bonus, we don't have to touch
other users of icc_node_add() at all.

Of course we can still continue the previous approach.

What do you think?

Regards,
Gabor

