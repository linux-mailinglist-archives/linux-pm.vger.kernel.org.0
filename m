Return-Path: <linux-pm+bounces-20341-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D0E0AA0BCCF
	for <lists+linux-pm@lfdr.de>; Mon, 13 Jan 2025 17:03:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F0F8B1886FAD
	for <lists+linux-pm@lfdr.de>; Mon, 13 Jan 2025 16:03:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47A371FBBDA;
	Mon, 13 Jan 2025 16:03:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rowland.harvard.edu header.i=@rowland.harvard.edu header.b="bIy1iLDm"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-qk1-f174.google.com (mail-qk1-f174.google.com [209.85.222.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9468F14A0A3
	for <linux-pm@vger.kernel.org>; Mon, 13 Jan 2025 16:03:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736784189; cv=none; b=g8+xa2bw+FHEFoqbQsvrlKZaeUZb8+FB/N+eHpBj2ME72SgUwkLjGAVJ2nNVcUJqH8d0+irPeCxGXbkspUSfy3NErkBiXp6+dAgCdTf5r1H8BamV3zKlT24W52aE+TzU2HjlqEj43BnvyMPuXyQnTA8U4hfctw3P+v27BkKlxaY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736784189; c=relaxed/simple;
	bh=aWuF9kiuN5YEGWathPxiQtY/3NHRwFIScrLeYLrju3M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Lq/CkKNZ0kt3mrPsLBwURF2suCHr7ev5lSkiUq6q9uIdctt0IlGM3rxFtRuADou6CLQ7ck58B0hdGgxRyfdah8yIi+0uSyEJEe/0gJlliCwZqxyFXqJ2HbklmdmFD57gdXTAy0T+FGt2vIxzN1qQ1qrGVIN4mkN+MI3OPf0Qp8Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rowland.harvard.edu; spf=fail smtp.mailfrom=g.harvard.edu; dkim=pass (2048-bit key) header.d=rowland.harvard.edu header.i=@rowland.harvard.edu header.b=bIy1iLDm; arc=none smtp.client-ip=209.85.222.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rowland.harvard.edu
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=g.harvard.edu
Received: by mail-qk1-f174.google.com with SMTP id af79cd13be357-7b6edb82f85so536765685a.3
        for <linux-pm@vger.kernel.org>; Mon, 13 Jan 2025 08:03:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rowland.harvard.edu; s=google; t=1736784186; x=1737388986; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=T61/LfgQn7o2pgpOl8TmXADHp/L8xVMdspG/x5cwLCs=;
        b=bIy1iLDmDifMGboa6IETadzYrFJVUUFnRgMqejofwfyJXrLj9AsCepWWlVvi0g5bkE
         lMMxXlUr6RN2QELM1Ngnwu7AhD46arBThxYn2fhtkeXLxw2mT13H6vthIWiwFB7OCNxx
         BluIghSgR8/L/B44p7VBm0X/Y6HRWdWhHvWbwUvGVC94jEf9lVufzuwRpiE6jVUHvoC/
         RatNylMmwgfpHVWYSmy2uRhY2oLNbkAiA7PtmuNzeKDqkPl8xIcAZsfQLSQ1bIAe33vM
         sxLIpFvSHOFPxXXQx5FZ7yi1HRyW3XUrsyGg6MKDNZs6v+OFMXYHE5y6z2JVXYMVWjvg
         f/zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736784186; x=1737388986;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=T61/LfgQn7o2pgpOl8TmXADHp/L8xVMdspG/x5cwLCs=;
        b=pmkymWqOQBjVdOM8HTTbStUBSVnT6XSHqL7Ef3x2aAe9NYLJMOA1/Okjdabdtic+K9
         ZJlER32P98sYODiUjt/bLaygsmWS4McmzaE4DVG6jteDE4GBm938WlXXzxJoNspNLq8y
         LwLnModaAlSliNQADIhTHJklCSCQppVpV5Pbk+gUBi51K7q+Wyf3I92G0Ag0ziSPI3wQ
         TNtS0yXbHXx2TBzX2Cx9dH+Mkevv+mnrdbXUBeUSpwlQPCd3xcZsoik1hKJTHKY7IFuZ
         qRN0bx6IMIaNCJ8q87SYO/ZPaR0sIbMNTkIDFqFNi4OMg0vLObjYbKEAd+sheadsgyNp
         PVXg==
X-Forwarded-Encrypted: i=1; AJvYcCWf7AQwx3p71B4hCxDBT4NJJFY+F2YT6zbTbwfAI9Bq5Q7UR7iDZ0sdVvReggMBmS1FvbSufcuJVQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Yx6iURj7RJ8slZuQFO6SWsODpD+b6lV3W0RaC7u6uN04hoqsVxN
	RhzCUrNKnKUBiatSJ9kfugS0qO/Vvf165Tnw5FNpNxPd5Qyx+ocvBQjinScZoQ==
X-Gm-Gg: ASbGnctckDDmlyqgD72Lw3JAhT5tPE2YbnwP6pPYEsImYcCzn6xUAm/Hcm2Unef293T
	dfSLUaHYuYRxzyxUJShQxL1bkgqmA6lfOcOlpjqfS28vDAMcVxJOuJndC5CZNlrRZgy6zSn/T0k
	yO/L7rpNBM0HWUciZt43EcwUoJfmj1hwCfQZCFYYXsXYsJjfuKROqBqCKjPVh3lyV4s5xwEL2OJ
	ews5UiOK1c6T0XC3RlgPB4x07hVI9GFOJOuDQgMZ7eROBfLZ+Of5F1iDY3lECt/R49rOoheF63W
	JTVrNcA22vMvmauKUDAklcKLk6DfhEja+ZCezpz491sxOz889Q==
X-Google-Smtp-Source: AGHT+IG0v6UJa6w8zNFrUtGFAfJ7CRcsseLfgyj58tb9f+ESUoUk0X5weD9cxofP2m5jFKHxfk32sA==
X-Received: by 2002:a05:620a:4052:b0:7b6:cb66:ad74 with SMTP id af79cd13be357-7bcd973ef81mr3429944085a.18.1736784186482;
        Mon, 13 Jan 2025 08:03:06 -0800 (PST)
Received: from rowland.harvard.edu (nat-65-112-8-51.harvard-secure.wrls.harvard.edu. [65.112.8.51])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7bce3238003sm507220285a.2.2025.01.13.08.03.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jan 2025 08:03:06 -0800 (PST)
Date: Mon, 13 Jan 2025 11:03:03 -0500
From: Alan Stern <stern@rowland.harvard.edu>
To: "Yo-Jung (Leo) Lin" <leo.lin@canonical.com>
Cc: gregkh@linuxfoundation.org, rafael@kernel.org, pavel@ucw.cz,
	len.brown@intel.com, bhelgaas@google.com, duanchenghao@kylinos.cn,
	dlemoal@kernel.org, linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
	hdegoede@redhat.com
Subject: Re: [PATCH] USB: Prevent xhci from resuming root hub during suspend
 entrance
Message-ID: <35aafcc1-8661-48b7-bbb9-4e48ba3c6cf2@rowland.harvard.edu>
References: <20250110084413.80981-1-leo.lin@canonical.com>
 <b16e2b38-e9f8-43af-9df0-0510895c02ee@rowland.harvard.edu>
 <CABscksPKS1prbikpF4FwoTLMvxN13_xrQfdXoXDnbo-4byUB6A@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CABscksPKS1prbikpF4FwoTLMvxN13_xrQfdXoXDnbo-4byUB6A@mail.gmail.com>

On Mon, Jan 13, 2025 at 04:14:07PM +0800, Yo-Jung (Leo) Lin wrote:
> Hi Alan
> 
> On Fri, Jan 10, 2025 at 11:44 PM Alan Stern <stern@rowland.harvard.edu> wrote:
> >
> > On Fri, Jan 10, 2025 at 04:44:10PM +0800, Yo-Jung (Leo) Lin wrote:
> > > The commit d9b4067aef50 ("USB: Fix the issue of task recovery failure
> > > caused by USB status when S4 wakes up") fixed an issue where if an USB
> > > port change happens during the entering steps of hibernation, xhci driver
> > > would attempt to resume the root hub, making the hibernation fail.
> > >
> > > System-wide suspend may fail due to the same reason, but this hasn't been
> > > addressed yet. This has been found on HP ProOne 440[1], as well as on
> > > some newer Dell all-in-one models. When suspend fails due to this reason,
> > > the kernel would show the following messages:
> >
> > I believe this problem was discussed on the mailing list before, and it
> > turned out that the issue was caused by a bug in the xhci-hcd driver,
> > not a bug in the USB core.
> 
> Could you be more specific on which bug/thread it is?
> If you were mentioning thread about d9b4067aef50 ("USB: Fix the
> issue of task recovery failure caused by USB status when S4 wakes up"),
> the log in that commit message suggests that it happened on ehci, while
> here it happened on xhci. So this may be more general than just the xhci.

I was referring to the discussion in the email thread here:

https://lore.kernel.org/linux-usb/7be0c87a-c00f-4346-8482-f41ef0249b57@rowland.harvard.edu/

> > Basically, suspend is _supposed_ to fail if a wakeup event occurs while
> > the suspend is in progress.  As I recall, the bug in xhci-hcd was that
> > it treats some non-wakeup events as if they were wakeup events.
> >
> > In particular, a port change on the root hub should be treated as a
> > wakeup event if and only if the root hub is enabled for wakeup.  Does
> > xhci-hcd check for this before failing the suspend?
> >
> > This reasoning shows that your proposed fix is incorrect.
> >
> Thanks for the feedback, This indeed isn't a correct way to address this.
> Will try to figure out some other ways.

Okay, good.

Alan Stern

