Return-Path: <linux-pm+bounces-20128-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 108CFA069FA
	for <lists+linux-pm@lfdr.de>; Thu,  9 Jan 2025 01:36:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 471313A0571
	for <lists+linux-pm@lfdr.de>; Thu,  9 Jan 2025 00:36:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3D054C76;
	Thu,  9 Jan 2025 00:36:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pf-is-s-u-tokyo-ac-jp.20230601.gappssmtp.com header.i=@pf-is-s-u-tokyo-ac-jp.20230601.gappssmtp.com header.b="oHVHJreg"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13EA7290F
	for <linux-pm@vger.kernel.org>; Thu,  9 Jan 2025 00:36:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736383008; cv=none; b=d/9nP9zdKbq0APE8N9IaM8ZHn9jI0NMxoipSx3tKh18ORU1H2jSTviSUbv4f+b3btHHRUhB2A+IV0rJvmYSHAm4iY1Q79dCiGjuVxnS/WOIBt2hgGNhFmySTfAxy/1dgwtW8Ql7M5RRKfHm6hL0L5eUAIJOtp5MzxjG2zJpLFrQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736383008; c=relaxed/simple;
	bh=Rq7hFPz+zKOhjsDSM7M1mWOj/ggU2cPcWIqzepbMjkI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RIA0C8HTIA6esW4/XtApE3w3Jl9YlZICQ7MQjRWejMcRK1l7UBTbNHBl138us3xQ2qrezvuRDY87aL0MHLTeh+sPm4vnkOGn+G5FX72NmH0cDQk+5pj2F6i6J/fYoFXCSAYlzv1+fyT/pgQmH1f99iEBoNj3yPNhK4SDAFSNRCY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=pf.is.s.u-tokyo.ac.jp; spf=none smtp.mailfrom=pf.is.s.u-tokyo.ac.jp; dkim=pass (2048-bit key) header.d=pf-is-s-u-tokyo-ac-jp.20230601.gappssmtp.com header.i=@pf-is-s-u-tokyo-ac-jp.20230601.gappssmtp.com header.b=oHVHJreg; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=pf.is.s.u-tokyo.ac.jp
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=pf.is.s.u-tokyo.ac.jp
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-21636268e43so5952645ad.2
        for <linux-pm@vger.kernel.org>; Wed, 08 Jan 2025 16:36:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=pf-is-s-u-tokyo-ac-jp.20230601.gappssmtp.com; s=20230601; t=1736383006; x=1736987806; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Q6OV89NzOxfFpKCEdTDzz1J3WlxxV/sdtJLIhMb2bI8=;
        b=oHVHJregVNDkpDkDh6rtKI9gDDRoxX1KGCeM5XlFQRh4j/d0Whx67ldEX6/mVmRXc9
         eHcbTr063kFEfyu6Eo85wyoVM2Zyo9QIxW0Ie94c1DjjzfnB1joKhuIz2OzWu6EvvWo0
         pPdAQzrUuBf9FpET/qMshnHYaVfC6C17cVLXpyxhiWgkYOelKAFeG1BLQCWQfyfUdxmj
         K1763t9Olzk714j5ikQW/A0C0XohATjpx0/pWyDaNVb0zViszhQ+Dx4ewECX0DAIO3qQ
         iLfxgLuvZDXWOzmkjvFugGNRrdjp+LHzoLRa/v0ArBA46orqtV3v3shWFAy8ya2lBe35
         nkFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736383006; x=1736987806;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Q6OV89NzOxfFpKCEdTDzz1J3WlxxV/sdtJLIhMb2bI8=;
        b=NWCZGXqzozQSR0e3nMyK8KInx9UTmyL8kgRTQ89Q2/C241jL0KUgjP94lyby6Gcru5
         +bzamLzvEfF6097lL0Xnkrp2vrz/hTXd3keDGzOybNWqCg32N9+eJCpV4Chqeqn/9UfI
         l86/maKYtzQCWGpW5l1yLUjmDTbYh9zB6KZB3KpG40goQSz38cObKMaoFmvRgF+HHhab
         nk9GKu3us5XmrEgRfv6BGHGJHIoigHypZ7kE7xE5n0/fT8DTm8zbfwQ/R39nEHcMrkhq
         9N9fY/tOBvVAZPsoZAFA7soPSWIIm1cSBwwJ5ocx+JxIbU6/7f5qlzd8vEeXxFc/tyGx
         5c7Q==
X-Gm-Message-State: AOJu0Yx5lAIcdr8d1/Gll+NS0W71/Rx/6LEenYcCNNxE0UQeceLY5T2l
	OhtqKNJudnjaiXjL6KgOAsVrpXoHmPcK1D0LETL5TmXQ6dTcjqy9vFt/Ag0GqL11VVMlb0eoAU1
	3
X-Gm-Gg: ASbGncs2wRzEG2mzCn/7PCt9osGcEVTRQS6/y/ho2zzVuE/DsmTRb8zsA60Zqs2UuCk
	Ds7G/QxScDX/XdlYUh7j9UfJEJuXwYhz0Mg8vS0gn5N17pVdIYC2S90vCJemUaD69ic2smqoZIL
	6S755irIpZ0V+jkJC7EWZtgbEQZOb8tyiDhUWqgu9f7sjfn6Vry7b8RU2u15moNVroiE/KgeMAh
	ZvrRqhOrI6OLwgLkl/4nbxUjI0g7IVvFDyTMzt0HcMwv8WCmc3MroPv9jAWexD6cQxNYl38azW6
	SPnHpXGpvO1RpO2dq4er2yc+/uOfLYKHSi83
X-Google-Smtp-Source: AGHT+IEhouwYAWdMgmzI0BEy59Oqgb5ddCPZmKeoRBNyh/vW3PWe40B0Z7RUwDoft6oWhLqVDRTs1g==
X-Received: by 2002:a17:902:db0e:b0:215:a57e:88e7 with SMTP id d9443c01a7336-21a83f48cd6mr68283395ad.3.1736383006333;
        Wed, 08 Jan 2025 16:36:46 -0800 (PST)
Received: from ?IPV6:2001:f70:39c0:3a00:f27c:126b:5cab:241a? ([2001:f70:39c0:3a00:f27c:126b:5cab:241a])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21a82e61eaasm21904595ad.255.2025.01.08.16.36.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 08 Jan 2025 16:36:45 -0800 (PST)
Message-ID: <68cdb73b-59cd-47be-9bc1-9affa606ba8f@pf.is.s.u-tokyo.ac.jp>
Date: Thu, 9 Jan 2025 09:36:43 +0900
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [bug report] powercap: balance device refcount in
 powercap_register_control_type()
To: Dan Carpenter <dan.carpenter@linaro.org>
Cc: linux-pm@vger.kernel.org
References: <97c5c93d-e31e-483b-83c3-28b797b69e9a@stanley.mountain>
Content-Language: en-US
From: Joe Hattori <joe@pf.is.s.u-tokyo.ac.jp>
In-Reply-To: <97c5c93d-e31e-483b-83c3-28b797b69e9a@stanley.mountain>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Dan,

Thank you for the report.

On 1/8/25 19:11, Dan Carpenter wrote:
> Hello Joe Hattori,
> 
> Commit cae442480e40 ("powercap: balance device refcount in
> powercap_register_control_type()") from Dec 15, 2024 (linux-next),
> leads to the following Smatch static checker warning:
> 
> 	drivers/powercap/powercap_sys.c:632 powercap_register_control_type()
> 	warn: freeing device managed memory (UAF): 'control_type'
> 
> drivers/powercap/powercap_sys.c
>      622         }
>      623         mutex_init(&control_type->lock);
>      624         control_type->ops = ops;
>      625         INIT_LIST_HEAD(&control_type->node);
>      626         control_type->dev.class = &powercap_class;
>      627         dev_set_name(&control_type->dev, "%s", name);
>      628         result = device_register(&control_type->dev);
>      629         if (result) {
>      630                 put_device(&control_type->dev);
> 
> The patch adds this call to put_device() based on static analysis but
> I'm pretty sure that will lead to a double free so the patch should be
> reverted.
> 
> We can see on line 626 that the class is powercap_class, so
> put_device() will call powercap_release().  The means that control_type
> will be freed.

Indeed, I missed that.

> 
>      631                 if (control_type->allocated)
> --> 632                         kfree(control_type);
> 
> Use after free and double free.

Instead of reverting the patch, How about removing these two lines to 
avoid the double free (so that mutex_destroy() is called in the cleanup 
function as well. Not that it makes that big of a difference though). If 
that is ok with you, I will work on a patch to fix it.

> 
>      633                 return ERR_PTR(result);
>      634         }
>      635         idr_init(&control_type->idr);
>      636
>      637         mutex_lock(&powercap_cntrl_list_lock);
>      638         list_add_tail(&control_type->node, &powercap_cntrl_list);
>      639         mutex_unlock(&powercap_cntrl_list_lock);
>      640
>      641         return control_type;
>      642 }
> 
> regards,
> dan carpenter

Best,
Joe

