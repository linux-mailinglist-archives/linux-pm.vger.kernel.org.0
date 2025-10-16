Return-Path: <linux-pm+bounces-36214-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 414C7BE1762
	for <lists+linux-pm@lfdr.de>; Thu, 16 Oct 2025 06:59:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B46E919C347B
	for <lists+linux-pm@lfdr.de>; Thu, 16 Oct 2025 04:59:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 556EF21CC68;
	Thu, 16 Oct 2025 04:59:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="gmU1P8B4"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7EC5216E1B
	for <linux-pm@vger.kernel.org>; Thu, 16 Oct 2025 04:59:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760590750; cv=none; b=SrNjYrQlYYYtAS4YdQvLhusrh/vrHs8cXjQrOrWG7YPhg+NNf2xKl9rKx8jXFScQO4IhqS85PC/TDiPq/uMksG4acZz7MiwQB5zITLd8PU5Y/d5+iqKpUXiCrsLGIDLN56p3nTy0QxuDu7hz2kaN7gFptXFe1GYX3H0Ov1sTyl4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760590750; c=relaxed/simple;
	bh=ojVgl1LVryfcqgJbjwS21DlJ4kE/86MdW49ExwHxtas=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DS0f0HwoYQ0yR3OzQKA9gJSKMx4xk/WrG4zqxNGYHH1wjjenEy4tZL3WsXpzpfC0omvpDm1rops2G9TBUKvKILv5L3pA7Mik+TUAyBb9uVIkhgCL7bfKKNl+wNay49xLtv3PjIk4rO0Dr+6Hi01fLVDWahMOOxcYp9O8m3CdAKs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=gmU1P8B4; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-7835321bc98so327755b3a.2
        for <linux-pm@vger.kernel.org>; Wed, 15 Oct 2025 21:59:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1760590748; x=1761195548; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=C7IQhiry+tJsODKqoRHwSfbwUoBnbdX2eSRUQa901FI=;
        b=gmU1P8B4+3LulwylktX7K4F/IfIGGl1GmoYE/5Lg1i0SYJHXEu8J9GVbvU1zwLTTU6
         +Zx6HKNNQzRdWQfw4mDhVjhZ6/wwW0TQujFdJwiWtyPffgu59L6pH5POJ4gtQQjYwefB
         fOugj8gu5udheO1bfiZEtdxY56Z5GwV026dzk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760590748; x=1761195548;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=C7IQhiry+tJsODKqoRHwSfbwUoBnbdX2eSRUQa901FI=;
        b=WyuhuH+siJNjTFJ2+MzPZXTTBonebwPIzFGQS8MPCYrQy3trmGXcerBhFIfWvmSmOx
         /qQ1WAK3lLeZ70MIVYHClMpGkd0Npte0cJoNbF08SYiuNNLhKWC6SZfPQJmA6imyj5dv
         Ap48FWJaVU67CnuMDs95ydr+tbMPF2l0IW6BjpX+iH4Wb9NDUsMYi1wET6R7h6t5hmi0
         gNEe5OtpyBwCbXVvdkH4LMyeRUUpodeSoF3TwBwF/0BTXNv0B+MBavWlLbgNaYNaxcTQ
         jQKJz85HHTNmI8bVMi3rYIxdliPan3hC4QIc+9PdPeR082PDDqiSDznBTtnC5lJJS0lU
         pMhw==
X-Forwarded-Encrypted: i=1; AJvYcCVenBPS2qPfSViCvX+qpuOYrzlm8FDMFiHUq/5dm0FCovsrOokyT6OeFPFOfWvDs+febSu4arTHtw==@vger.kernel.org
X-Gm-Message-State: AOJu0Yz3rV9iZeguWFsP9Gm76eBC+GHbMFXanEeQ2gcJ6tHYTO7CPez6
	BSGx+QX06gWnt5j7O8bbeCFmfCXTIYuv1AbIIrtkM4CbldRKx8i0rh2NMPv88FJhhw==
X-Gm-Gg: ASbGncu+XSWTdI4ee0PCZMv29y/8WPI3dF3etVgt9CQLYJEvj1+0R5DRaHWuu1vG1Si
	6xyortCojKHmgd94hYgEAXkvNXOtK4h3RkVupgOKpkqiUs/4lriu9bCXHqImTmIVTODEtub2URp
	Pw+HIRxOh8mKO9HyugMbiFk6hUewTj06wX87kPTo46q/0Bmeyi8i9wu3mpPb3jTqKwjffQwwYP0
	TWQ5X6UqCHkVM3l6QNDKJqcHqb1vDeUv7JWbb6Il7N0yicgOjcKDs74I7CXdJCJi0/x7uBzWwOR
	/m4qyIwXTXUhRpVtOcdrorQQILlIAOw58QBHDJbgjTOVoq0WnP5ZOGYbzQJEaRySJ8nj29smECN
	9Gts9g7ofWKOUmRGhxDYvI4h52A9p2vSb8LY4BxbyYhs9Uy6QEq0sSnKr3t86J2/Ak3eKU/2U8Q
	KFYWSuajKfNGSYvQ==
X-Google-Smtp-Source: AGHT+IF8i59pqIJ10iUVBW21MsNsjP0W/N9hc5HRpbWDVehk+KejBdGe0d9HU1R+rNjZ98P24Lm3Rw==
X-Received: by 2002:a05:6a20:1591:b0:334:8c6b:f0b3 with SMTP id adf61e73a8af0-3348c6c1916mr5922821637.15.1760590748070;
        Wed, 15 Oct 2025 21:59:08 -0700 (PDT)
Received: from google.com ([2401:fa00:8f:203:18d7:f088:3b2a:6563])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7992bc18c96sm20698225b3a.37.2025.10.15.21.59.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Oct 2025 21:59:07 -0700 (PDT)
Date: Thu, 16 Oct 2025 13:59:02 +0900
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: Doug Smythies <dsmythies@telus.net>
Cc: 'Sergey Senozhatsky' <senozhatsky@chromium.org>, 
	"'Rafael J. Wysocki'" <rafael@kernel.org>, 'Christian Loehle' <christian.loehle@arm.com>, 
	"'Rafael J. Wysocki'" <rafael.j.wysocki@intel.com>, 'Greg Kroah-Hartman' <gregkh@linuxfoundation.org>, 
	'Artem Bityutskiy' <artem.bityutskiy@linux.intel.com>, 'Sasha Levin' <sashal@kernel.org>, 
	'Daniel Lezcano' <daniel.lezcano@linaro.org>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	'Tomasz Figa' <tfiga@chromium.org>, stable@vger.kernel.org
Subject: Re: stable: commit "cpuidle: menu: Avoid discarding useful
 information" causes regressions
Message-ID: <ewahdjfgiog4onnrd2i4vg4ucbrchesrkksrqqpr7apyy6b76p@uznmxhbcwctw>
References: <08529809-5ca1-4495-8160-15d8e85ad640@arm.com>
 <2zreguw4djctgcmvgticnm4dctcuja7yfnp3r6bxaqon3i2pxf@thee3p3qduoq>
 <8da42386-282e-4f97-af93-4715ae206361@arm.com>
 <nd64xabhbb53bbqoxsjkfvkmlpn5tkdlu3nb5ofwdhyauko35b@qv6in7biupgi>
 <49cf14a1-b96f-4413-a17e-599bc1c104cd@arm.com>
 <CAJZ5v0hGu-JdwR57cwKfB+a98Pv7e3y36X6xCo=PyGdD2hwkhQ@mail.gmail.com>
 <7ctfmyzpcogc5qug6u3jm2o32vy2ldo3ml5gsoxdm3gyr6l3fc@jo7inkr3otua>
 <001601dc3d85$933dd540$b9b97fc0$@telus.net>
 <sw4p2hk4ofyyz3ncnwi3qs36yc2leailqmal5kksozodkak2ju@wfpqlwep7aid>
 <001601dc3ddd$a19f9850$e4dec8f0$@telus.net>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <001601dc3ddd$a19f9850$e4dec8f0$@telus.net>

On (25/10/15 07:11), Doug Smythies wrote:
> >> What thermal limiting methods are being used? Is idle injection being used? Or CPU frequency limiting or both.
> >
> > How do I find out?
> 
> From the turbostat data you do not appear to be using the TCC offset method. This line:
> 
> cpu0: MSR_IA32_TEMPERATURE_TARGET: 0x0f690080 (105 C)
> 
> whereas on my test computer, using the TCC offset method, shows:
> 
>  cpu0: MSR_IA32_TEMPERATURE_TARGET: 0x14641422 (80 C) (100 default - 20 offset)
> 
> To check if thermal is being used do:
> 
> systemctl status thermal

chromeos doesn't use systemd.
A quick ps grep doesn't show any thermal-related processes.

