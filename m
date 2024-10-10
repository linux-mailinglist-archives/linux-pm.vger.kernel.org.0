Return-Path: <linux-pm+bounces-15434-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 178A3997F2B
	for <lists+linux-pm@lfdr.de>; Thu, 10 Oct 2024 10:17:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9A59EB254EE
	for <lists+linux-pm@lfdr.de>; Thu, 10 Oct 2024 08:17:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A20651CDA31;
	Thu, 10 Oct 2024 07:12:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="btSHV4JP"
X-Original-To: linux-pm@vger.kernel.org
Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net [217.70.183.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 569121C1AC9;
	Thu, 10 Oct 2024 07:12:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728544353; cv=none; b=FFLpwC/jl4s9EMPmY9m8rnyTJJYHNkoEjwO/fVYaBDm2qheD877eGzVYe4A0EJa6k4kLgWRneZzg9s92lNcxhFMd3MoQNzK+8sLGwAihuUdRsvm3GdDXij9uKSCNR+nQXJvhFMa0ZmA3P1i6M9RMj0r3BnOgErDr6QniQu8fDOI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728544353; c=relaxed/simple;
	bh=Cn4B1F4k0S5ou9J1Z37x5AXecRflwso2j6cZdMR+zes=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BM7L60Fk5NFGL4fsVN5Gbt3zb0tph3S/yoCqetbFDWDwdJuPOmQwJlA2BOqHiw7oh0+wdOrnvSdXhGjGhYIuWWIEsFyokLOAFOV7ZMoX37fXAG6+imNYEA1fPMne7pSzWVAYX2mkPFDk8s958w+UrNk8p1xqyY6egRloTW9mrBY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=btSHV4JP; arc=none smtp.client-ip=217.70.183.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id AB8161C0006;
	Thu, 10 Oct 2024 07:12:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1728544349;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=eZhJCmqORkBi7oe0upO8alJrZ9x/l0/NdakZ2rFJ6Nk=;
	b=btSHV4JPklv8RMfZ2wfFB3tKpMR4PyGYB3cKus0VrB2MvhLr9/AaCB/9112DxD9gBMUJB4
	uiMZM5BFgcKec9iA1PEaMrCyEbd5w61aylY8Yn5BsFocOWTBmUPfnTMQa3MsJtC2h3FnRb
	FnxDfG3lM3q7m3nIlpA/DK8jMI9ZD+ZJyMwg4Ct9BWpUxmDAy4nXAKCuFf95fveHwnQfvi
	WBM+KcUH/8ATrOvOEBysNb6X2efRUO24kviJKPRIg/35nVWNjLlMKL6PhZ82Nd+fwP38Fb
	QErayO7QEZpQfRU/yQ+lOd4bG7VRNBGFvf/r70PX9FAR/arBwS8+bgB8EYM/cg==
Message-ID: <fc2c103c-f113-4eca-91fb-3b9904d31d67@bootlin.com>
Date: Thu, 10 Oct 2024 09:12:28 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] pmdomain: ti-sci: set the GENPD_FLAG_ACTIVE_WAKEUP
 flag for all PM domains
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Nishanth Menon <nm@ti.com>, Tero Kristo <kristo@kernel.org>,
 Santosh Shilimkar <ssantosh@kernel.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Jiri Slaby <jirislaby@kernel.org>, linux-arm-kernel@lists.infradead.org,
 linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-serial@vger.kernel.org, u-kumar1@ti.com, tony@atomide.com,
 khilman@kernel.org, gregory.clement@bootlin.com,
 thomas.petazzoni@bootlin.com, theo.lebrun@bootlin.com,
 richard.genoud@bootlin.com
References: <20241008-8250-omap-no-console-suspend-v1-0-e7f0365c02f0@bootlin.com>
 <20241008-8250-omap-no-console-suspend-v1-1-e7f0365c02f0@bootlin.com>
 <CAPDyKFroumouYavhaHp=aSh=0WsDO=_4kbVgS-+Y7CADyO-Kmg@mail.gmail.com>
Content-Language: en-US
From: Thomas Richard <thomas.richard@bootlin.com>
In-Reply-To: <CAPDyKFroumouYavhaHp=aSh=0WsDO=_4kbVgS-+Y7CADyO-Kmg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-GND-Sasl: thomas.richard@bootlin.com

On 10/9/24 15:17, Ulf Hansson wrote:
> On Tue, 8 Oct 2024 at 11:34, Thomas Richard <thomas.richard@bootlin.com> wrote:
>>
>> With this flag, if a device is marked on the wakeup path, the corresponding
>> PM domain is kept powered on.
> 
> Perhaps extend this with some more information that it fixes a problem
> for the uart console too?

Yes, I'll send a v2 (only the patch 1/2) with a more verbose commit message.

> 
>>
>> Suggested-by: Théo Lebrun <theo.lebrun@bootlin.com>
>> Signed-off-by: Thomas Richard <thomas.richard@bootlin.com>
> 
> Should we add a stable/fixes tag?

I guess no.
The first implementation, which was reverted, didn't have a stable/fixes
tag.

Regards,

Thomas


