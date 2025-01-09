Return-Path: <linux-pm+bounces-20138-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A0A6A0701A
	for <lists+linux-pm@lfdr.de>; Thu,  9 Jan 2025 09:32:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D07167A16D3
	for <lists+linux-pm@lfdr.de>; Thu,  9 Jan 2025 08:32:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FB10215062;
	Thu,  9 Jan 2025 08:31:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="l1I7iWmi"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67BC82144DD
	for <linux-pm@vger.kernel.org>; Thu,  9 Jan 2025 08:31:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736411515; cv=none; b=dY/je/WEizN2gJrCw7v3UHoyZhcAcAZphHeHtv+VqqCbzvDo2l34FN2p79QVG9s0uV8jQqe/vWEsOcTkm4tXZUZY48E4bDwl5u4SjKOCBIqi/kqpYtJri6CjxG3WhyhdRzLWPYnv2y4S9+2fFFx9EJXON3F+HmUSK5DI5rbCY90=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736411515; c=relaxed/simple;
	bh=KUzLXnatE8mdLNALiIgTUQVGTMSyjfK2KGiyJUM1sNU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hY06loKegu5+QfKLbXKN9gsI20S752F0jZMPiDsqfYifogN7Ma0rC5QGE8xAQhHB9RndMToTj19fDIcvkPteuQVcjP57NVeX6yG98Fs9sbLeZAlEhzRVMeOzC5N4KSH23T1990c5kYabLU7uqObMcWYHFAQjQ/pi5mrXmgqSMRE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=l1I7iWmi; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-3862a921123so397061f8f.3
        for <linux-pm@vger.kernel.org>; Thu, 09 Jan 2025 00:31:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1736411512; x=1737016312; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=aLrSaSlZu+MiuVKXlXrL9LUgOrjEHaZ99KCMNTgbbJw=;
        b=l1I7iWmiAx5al1RtR4tH+YeHY7zHnSzh/mIjhRZLZHdrLtum//OyCLbM0bg/zCXqMO
         JElMw4WxAEaRiuh6qADkWBLjqEZpyMkGC9AMaRqJ+GHxZo8FhWTBTrLrAx85dPcK4nZN
         VEyWy9pxSPBKiL0ZDEnOrNU8Zr/JYnNkdjJ07gXGRK8Uryi2XqCuRXaeQbkXXwv0ptER
         n9M24eKQELZqWVVsnzJVTLCrAeTqUdZfiDCv9kTO6k1TNIlajVRSgW7sdNVRD+mBsPm/
         VouMe7MoMAAthzmnudHB5LQancDkWJTrv++iylp9RL73rfBW/WJ22dAwMFy/+Fl3s/h9
         k/bQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736411512; x=1737016312;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aLrSaSlZu+MiuVKXlXrL9LUgOrjEHaZ99KCMNTgbbJw=;
        b=Q/HAGhx5ne0BczoCcnXWW65Wj31mpjGRbo7LbcKZdDPkM7i+B7wZhUHuFQsN33bDpV
         uXz2cc8o6SDCqMX7EmmoWCxtrEMK9rtaITa8FIa98C4bz0CSBqMlcCuU1MFYMd7hOtR4
         pyeom9ZgUCx6OhEvtA3qdUISVeJCOXb23ievMs6bLANskIlEbUAmBKnA96Q6eyjbVWeL
         +AQow7SUvVH/UdKchc6jN0XRebK6u8LX7H5OgXtKGcvZmA1EWzpLNhNTUmAf+kvl9Mbj
         wE3RVgQKxDe7KavrR86SZsy7d93KeCdFihhivtKXJbfrrPRi14WcReJpbK3BwlCQok4R
         CCpg==
X-Gm-Message-State: AOJu0YxL4gW6Ksnz6Oo2aCQSB6gkvY/llyBO6GO0jq50TURZhdrhi/kV
	NnYfPIuB2vEIUyZGd0V+azsjslk3AE24wWLU994sK7kAn1DDCjU1VWrNGi35Nnzqcd0AR7V7K/v
	7
X-Gm-Gg: ASbGncsu/J5L35tieyHgXflfI+sUycVkYEGxb9Wume0s08/SN+foD5Wmw9iaq+IaS+l
	xrgVi2Yl8KxYIiTfeTtVmw9WATLbDxv/Eb4BaQFHCDE+PK0RijOz9SjSn+W+mVevCjxpvigVxsd
	wfRrAHX/q0WEikY53M1nBYs8sC+3OvrsqU1HJSiNovxmdP0i8U9+KonLg6Rc4z+H/XTV4mD2kSL
	JBjkpKs0MJ0CaSrEyUAIm3f6XL/pbHcUbhceTWd0F6iHm/H6gVsVKSmCWQy5w==
X-Google-Smtp-Source: AGHT+IHZ4NJxNZhXaX70emboKBRjLNwUaaFMXH8djYapKVmnFiCDjf/CenPwC28YcYtmyshZaZ1xzg==
X-Received: by 2002:a05:6000:1847:b0:386:3825:2c3b with SMTP id ffacd0b85a97d-38a87304672mr4275676f8f.18.1736411511676;
        Thu, 09 Jan 2025 00:31:51 -0800 (PST)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-436e9dc895esm12872235e9.13.2025.01.09.00.31.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jan 2025 00:31:51 -0800 (PST)
Date: Thu, 9 Jan 2025 11:31:47 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Joe Hattori <joe@pf.is.s.u-tokyo.ac.jp>,
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Cc: linux-pm@vger.kernel.org
Subject: Re: [bug report] powercap: balance device refcount in
 powercap_register_control_type()
Message-ID: <9d85c85f-c520-4e69-a412-22aaae7ba414@stanley.mountain>
References: <97c5c93d-e31e-483b-83c3-28b797b69e9a@stanley.mountain>
 <68cdb73b-59cd-47be-9bc1-9affa606ba8f@pf.is.s.u-tokyo.ac.jp>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <68cdb73b-59cd-47be-9bc1-9affa606ba8f@pf.is.s.u-tokyo.ac.jp>

On Thu, Jan 09, 2025 at 09:36:43AM +0900, Joe Hattori wrote:
> Hi Dan,
> 
> Thank you for the report.
> 
> On 1/8/25 19:11, Dan Carpenter wrote:
> > Hello Joe Hattori,
> > 
> > Commit cae442480e40 ("powercap: balance device refcount in
> > powercap_register_control_type()") from Dec 15, 2024 (linux-next),
> > leads to the following Smatch static checker warning:
> > 
> > 	drivers/powercap/powercap_sys.c:632 powercap_register_control_type()
> > 	warn: freeing device managed memory (UAF): 'control_type'
> > 
> > drivers/powercap/powercap_sys.c
> >      622         }
> >      623         mutex_init(&control_type->lock);
> >      624         control_type->ops = ops;
> >      625         INIT_LIST_HEAD(&control_type->node);
> >      626         control_type->dev.class = &powercap_class;
> >      627         dev_set_name(&control_type->dev, "%s", name);
> >      628         result = device_register(&control_type->dev);
> >      629         if (result) {
> >      630                 put_device(&control_type->dev);
> > 
> > The patch adds this call to put_device() based on static analysis but
> > I'm pretty sure that will lead to a double free so the patch should be
> > reverted.
> > 
> > We can see on line 626 that the class is powercap_class, so
> > put_device() will call powercap_release().  The means that control_type
> > will be freed.
> 
> Indeed, I missed that.
> 
> > 
> >      631                 if (control_type->allocated)
> > --> 632                         kfree(control_type);
> > 
> > Use after free and double free.
> 
> Instead of reverting the patch, How about removing these two lines to avoid
> the double free (so that mutex_destroy() is called in the cleanup function
> as well. Not that it makes that big of a difference though). If that is ok
> with you, I will work on a patch to fix it.
> 

What you are suggesting *sounds* like the correct thing to do, but
surely the original author thought of that too?  Except the original
code was written 15 years ago and that was a completely different era
so maybe that explains it?  We could CC Srinivas and see if he
remembers this code that he wrote back when he was still a child.

I don't know this code well enough to be confident.

regards,
dan carpenter

> > 
> >      633                 return ERR_PTR(result);
> >      634         }
> >      635         idr_init(&control_type->idr);
> >      636
> >      637         mutex_lock(&powercap_cntrl_list_lock);
> >      638         list_add_tail(&control_type->node, &powercap_cntrl_list);
> >      639         mutex_unlock(&powercap_cntrl_list_lock);
> >      640
> >      641         return control_type;
> >      642 }
> > 
> > regards,
> > dan carpenter
> 
> Best,
> Joe

