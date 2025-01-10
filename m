Return-Path: <linux-pm+bounces-20174-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B3E3A0847E
	for <lists+linux-pm@lfdr.de>; Fri, 10 Jan 2025 02:09:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 15C4A18825B9
	for <lists+linux-pm@lfdr.de>; Fri, 10 Jan 2025 01:09:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D42DA1F941;
	Fri, 10 Jan 2025 01:08:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pf-is-s-u-tokyo-ac-jp.20230601.gappssmtp.com header.i=@pf-is-s-u-tokyo-ac-jp.20230601.gappssmtp.com header.b="pJxT60Gd"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6A8228DA1
	for <linux-pm@vger.kernel.org>; Fri, 10 Jan 2025 01:08:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736471289; cv=none; b=HRkkVN9qhP9Kbh0LB69LjLqcUKXWwMov1t9y7m9lGjT7n7hFkY6Ngp9PoJfsYBUoHp7JqAfS2dfIdfvz/Tr43Lh8pMkmFdvcxEh9JRBMtgS2wdJcNhOj/r0hJFKZ6y73U8LVjif5HNNvX1VgGEadHhOyOHz077z3cO3PPht8fE0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736471289; c=relaxed/simple;
	bh=WCbVpxIvWy0ytQsV3aeOeTRdlRFDjjx0oUo+17KOs9U=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=euVJzfkFqbssvV5JqFwWOjJzrKer5X6s0NIKWK5Rr4jsbuZyvllU0uUCimZSbV5w6ZF0f/X33ZhwBzZH+yEDjY+nzEsHDKHpaBVEjCjEGkkVi2LCD8/iZAW16AO2gKMz30HBrV4kjTTecghXU3u04qqYXd0tVBhX3SEK0LzrIXA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=pf.is.s.u-tokyo.ac.jp; spf=none smtp.mailfrom=pf.is.s.u-tokyo.ac.jp; dkim=pass (2048-bit key) header.d=pf-is-s-u-tokyo-ac-jp.20230601.gappssmtp.com header.i=@pf-is-s-u-tokyo-ac-jp.20230601.gappssmtp.com header.b=pJxT60Gd; arc=none smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=pf.is.s.u-tokyo.ac.jp
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=pf.is.s.u-tokyo.ac.jp
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-2eed82ca5b4so2481422a91.2
        for <linux-pm@vger.kernel.org>; Thu, 09 Jan 2025 17:08:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=pf-is-s-u-tokyo-ac-jp.20230601.gappssmtp.com; s=20230601; t=1736471287; x=1737076087; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=6yDXqAoI77pH4XvnKApFcsfqn8Hj/0/jrKt7jZzCD64=;
        b=pJxT60GddpX+qQ5Nx5dAPOFPIDU3/k0MWizox/diw/VrN6kjIlMEz6j741XNgHoocC
         U1SB2bjK2QkPERp67pFyrorGyQs8OQzV0Wj+A+LOyJ+GIymtaTVBeHqkpXlpsQo4BnBq
         Juz0mmhUBT+B3mS8pYM7NWl3gah/9ryKXlDtqbK0njo/S2Gbu5RdyEAlUGcuAztBk6UG
         00SThgnzHUwn4VVSKIKrA7SWLhOu2UdjnSnWEm7U0aycpNHfyJOhx9t56SWxcsrXl7nx
         7Lz/4Pq3lBLCs77r3CSQGnssKDtxcERDOAOx3IqGSbsvYQRHr4opwmphP8D1HZOQNMPK
         fMKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736471287; x=1737076087;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6yDXqAoI77pH4XvnKApFcsfqn8Hj/0/jrKt7jZzCD64=;
        b=FXNItYvi6e0tAo8Xjw/D3LhrNE8vvQBhPlnww07JB/kNM6WBs8CiCw2MEQfLkEA4SW
         LKRNYwwoanVwaD5pn5aFurJ1CEA0d/89J41TKnxghqWHgOiZr/hM8Pka38+c4kbe25ly
         Oag+MuMqM9IyRFNLMEVdJ4cN7fbNCYGO0eKV5GLh0T/CmzC8l3SIQAuTWu/m/hlLAqjp
         5jgM9Vn1AGrluQQX04/96X6e3v8k+STOBYEmqnsPMrljQiD+ZVs6/MDSwDsIgkXwerMs
         gLkAiyunTK3HnE3fPw+xnYaSF7ZPlJAqjrOMXSU+13QDXED1ee+03mrfhTPTlVKuw5Rp
         uRAQ==
X-Gm-Message-State: AOJu0YwvUK+uchZLyozF95+wTtkbonzP2sUfIz2jd6iWeF5qrM1QwJuh
	AtTyS2ZeI3j6uSaXMBnQVq12tkFek7m6rLcZfZZlAVPc0mhdo2Rcn0X0tO5hYJ4=
X-Gm-Gg: ASbGncv0ZjddaR1awXfzB9SsOPzmJAb9ieIdUfrs7Yzr1QPux5M2M5m++e6wrvm/AjX
	Ex+TiVLRKuxa25l4wS8UfvKIsXOn0Veq5KlEc5Hsn3/lTdUtrLx8kd9kcF7pwC25SEUVpS2z1gt
	E02HfMSB2n+xods3dXRXkKLvNtB+2ZiqhLs5cdzp265FIgjNXs0RZ19nZMa1/uprDVr4+6qmEOK
	y9xL9FVUIHfay33A7HBmke/B+iFGFUF0hyslincbQEkTlT+NGBO889/yXSpHpet8Lywx5N4hFRr
	gDwTru2kCxLGv60BlUpOrCexpSjOVfMb1g==
X-Google-Smtp-Source: AGHT+IEuV69Ovlf0E0rSyLpApdpn5ESd9H9IbaYLocHeQMbz/SMxDCpoAVQooFRhKYT3BLOVQFWunw==
X-Received: by 2002:a17:90b:538e:b0:2ee:c4f2:a76d with SMTP id 98e67ed59e1d1-2f548f59a46mr11807308a91.21.1736471286944;
        Thu, 09 Jan 2025 17:08:06 -0800 (PST)
Received: from [192.168.0.78] (133-32-227-190.east.xps.vectant.ne.jp. [133.32.227.190])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2f54a36a06fsm4315906a91.46.2025.01.09.17.08.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 09 Jan 2025 17:08:06 -0800 (PST)
Message-ID: <022a2fcc-ac64-433c-9ff5-46e3c0072227@pf.is.s.u-tokyo.ac.jp>
Date: Fri, 10 Jan 2025 10:08:04 +0900
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [bug report] powercap: balance device refcount in
 powercap_register_control_type()
To: srinivas pandruvada <srinivas.pandruvada@linux.intel.com>,
 Dan Carpenter <dan.carpenter@linaro.org>
Cc: linux-pm@vger.kernel.org
References: <97c5c93d-e31e-483b-83c3-28b797b69e9a@stanley.mountain>
 <68cdb73b-59cd-47be-9bc1-9affa606ba8f@pf.is.s.u-tokyo.ac.jp>
 <9d85c85f-c520-4e69-a412-22aaae7ba414@stanley.mountain>
 <c33fda7bde0b7fed4d47a3d1fc46e448bf8f99ff.camel@linux.intel.com>
Content-Language: en-US
From: Joe Hattori <joe@pf.is.s.u-tokyo.ac.jp>
In-Reply-To: <c33fda7bde0b7fed4d47a3d1fc46e448bf8f99ff.camel@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 1/10/25 03:42, srinivas pandruvada wrote:
> Hi All,
> 
> On Thu, 2025-01-09 at 11:31 +0300, Dan Carpenter wrote:
>> On Thu, Jan 09, 2025 at 09:36:43AM +0900, Joe Hattori wrote:
>>> Hi Dan,
>>>
>>> Thank you for the report.
>>>
>>> On 1/8/25 19:11, Dan Carpenter wrote:
>>>> Hello Joe Hattori,
>>>>
>>>> Commit cae442480e40 ("powercap: balance device refcount in
>>>> powercap_register_control_type()") from Dec 15, 2024 (linux-
>>>> next),
>>>> leads to the following Smatch static checker warning:
>>>>
>>>> 	drivers/powercap/powercap_sys.c:632
>>>> powercap_register_control_type()
>>>> 	warn: freeing device managed memory (UAF):
>>>> 'control_type'
>>>>
>>>> drivers/powercap/powercap_sys.c
>>>>       622         }
>>>>       623         mutex_init(&control_type->lock);
>>>>       624         control_type->ops = ops;
>>>>       625         INIT_LIST_HEAD(&control_type->node);
>>>>       626         control_type->dev.class = &powercap_class;
>>>>       627         dev_set_name(&control_type->dev, "%s", name);
>>>>       628         result = device_register(&control_type->dev);
>>>>       629         if (result) {dev_release
>>>>       630                 put_device(&control_type->dev);
>>>>
>>>> The patch adds this call to put_device() based on static analysis
>>>> but
>>>> I'm pretty sure that will lead to a double free so the patch
>>>> should be
>>>> reverted.
>>>>
>>>> We can see on line 626 that the class is powercap_class, so
>>>> put_device() will call powercap_release().  The means that
>>>> control_type
>>>> will be freed.
>>>
>>> Indeed, I missed that.
>>>
>>>>
>>>>       631                 if (control_type->allocated)
>>>> --> 632                         kfree(control_type);
>>>>
>>>> Use after free and double free.
>>>
>>> Instead of reverting the patch, How about removing these two lines
>>> to avoid
>>> the double free (so that mutex_destroy() is called in the cleanup
>>> function
>>> as well. Not that it makes that big of a difference though). If
>>> that is ok
>>> with you, I will work on a patch to fix it.
>>>
>>
>> What you are suggesting *sounds* like the correct thing to do, but
>> surely the original author thought of that too?  Except the original
>> code was written 15 years ago and that was a completely different era
>> so maybe that explains it?  We could CC Srinivas and see if he
>> remembers this code that he wrote back when he was still a child.
>>
> Indeed, long time back during 3.14.
> Looking at 3.14, callers of device_register(), on failure there was no
> call to put_device().
> So if device_register fails then this memory needs to be freed.
> If I look at code now, put_device() is called.
> 
> Looking at the code of device_register(), the need of this free will be
> only required if the call to get_device() fails. But get_device() can't
> fail here.
> After call to get_device() the put_device() should call dev_release(),
> so we can remove code at line 631-632.

Thank you for the confirmation. Reflected in the new patch that I just sent.

> 
> 
> Thanks,
> Srinivas
> 
>> I don't know this code well enough to be confident.
>>
>> regards,
>> dan carpenter
>>
>>>>
>>>>       633                 return ERR_PTR(result);
>>>>       634         }
>>>>       635         idr_init(&control_type->idr);
>>>>       636
>>>>       637         mutex_lock(&powercap_cntrl_list_lock);
>>>>       638         list_add_tail(&control_type->node,
>>>> &powercap_cntrl_list);
>>>>       639         mutex_unlock(&powercap_cntrl_list_lock);
>>>>       640
>>>>       641         return control_type;
>>>>       642 }
>>>>
>>>> regards,
>>>> dan carpenter
>>>
>>> Best,
>>> Joe
>>
> 

Best,
Joe

