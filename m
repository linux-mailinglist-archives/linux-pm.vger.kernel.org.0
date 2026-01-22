Return-Path: <linux-pm+bounces-41321-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cPBfOhtscmnckQAAu9opvQ
	(envelope-from <linux-pm+bounces-41321-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Thu, 22 Jan 2026 19:27:39 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B9906C671
	for <lists+linux-pm@lfdr.de>; Thu, 22 Jan 2026 19:27:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id B63423012165
	for <lists+linux-pm@lfdr.de>; Thu, 22 Jan 2026 17:50:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB47E3612C8;
	Thu, 22 Jan 2026 17:50:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="FUnbEHcI"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-dl1-f46.google.com (mail-dl1-f46.google.com [74.125.82.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E74EF34DCC7
	for <linux-pm@vger.kernel.org>; Thu, 22 Jan 2026 17:49:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769104211; cv=none; b=Vr+XkIUDi1XtteFjBPGBp4eLBS2CfSD/GvJsDxTb3t4XmTBqoGCVhcjeRcwoLgV9hm7NfHHI5qcH8JI/Yv21tI6c8KNM8AqaZGw1TRvkXriPebfLEQBZjKw7illQPCkIOp52tV3NYHJuBUC00pVA6LNKIrikiZ0Cc3POo7uo7h4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769104211; c=relaxed/simple;
	bh=Fy3XirdW3o4O+QTo79Ey4FXxvk1xhYIcaqrUFj49MDY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VGe6iTb4azieLe0YtJbKo2WcsjY6kiccJa+9Sy+7VAOxFIpXGjiYpShPWreOfb5M3yY24L6LTJ/K3z01UwjJ3JtlSI1s+AmUC7WVAHZtBnubo1Vkwj5BmArwfjwNqL1v7nbIs437f7BQXz0gji/kZ0wgbqKkS9ifTOrHdpzZqPU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=FUnbEHcI; arc=none smtp.client-ip=74.125.82.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-dl1-f46.google.com with SMTP id a92af1059eb24-121a0bcd376so3486263c88.0
        for <linux-pm@vger.kernel.org>; Thu, 22 Jan 2026 09:49:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1769104183; x=1769708983; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Cts/XmrIsitUkgW4W0CPI9+Y5A4oJrjzrlI5Y9vqVAc=;
        b=FUnbEHcINfzrYaeQhEuTNy4kGslu9mp46Mq5Qinf3z8vY1geZH0osl34Mtmw3GXf35
         rDX3D+99W8wn0o1SVPrYJHun4mo5OzD7LC8w7Rn3I6h82TW8FPRszv7Y5RwWBzj8oEzd
         SZJrnu5rkwXwao29Wmo3IuwpMzm5OQr4pToyI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769104183; x=1769708983;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Cts/XmrIsitUkgW4W0CPI9+Y5A4oJrjzrlI5Y9vqVAc=;
        b=pXxRV3Ewdy6H4WQ1TqeJVsxe6cAuhbyaQw9Y6N+JqdcimvbP0rZyv5NeeTby9eiaS6
         RXtnV5CMFXAGbPSpXO4LxHr4l7n9Q82Dee4BzkGFyhkdXlk3fFPuosWLlcdX8EwSy3+D
         sfqLuEaEkQnR3LyJ/4ljrgiCuedvmuQDN4SaTOVrTwP5Z1UATbK1FgxYXXqe3/MOtBym
         3z1aS2tBAMJh13PhP5cyDUyZCNpIEZuuGA+O9vWAh7H+Mi2rakTXfNiLJqSqPx5p9xbq
         ETe0/8iQ2R3e9uUnsvoYBWmGFpAY0e4p9R0VjDE5R2apKHEs+m7QmolI4ncSK6SBvOcm
         Zvdg==
X-Forwarded-Encrypted: i=1; AJvYcCW6ULMZ3f/YuIT7UztPeEcEONxCEKKy3DQ4Wqzr2OPThCZIhU6GRaOdU9MlEZWMvpHSPh/WqwNmrQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YwnVXyHWt3Fo/oN4mfF12ngDLmh3t9vJqXGq80K3OEVGKDhyrvd
	AB3++21qJkAO+SWyqw31oE7fONBjozZ4S5LfvEX6Eal13pkxcxLSYBT6oFOvrPkdGw==
X-Gm-Gg: AZuq6aIexbxnmzgLo2hFO0uAYtOR8+/abcPmfbdcoFGf48FHcqE8a6S4C9MLN2y29o+
	jcWBoPRTAyguyPwKLUtMn1g8ivkIU7boIB49fVrzsCtaM9WRd6J1tOFJK4w5/mANq+/80XvJgLX
	ZfkpHz5bv840xTKamK+VFN6i8M82th5eYYyNGgftllv55LhQ+WDnmr8lJpdKrtbSqDJJ/Tksofc
	HcAHrxZuVoVQSiuxQOUIicszJYRiIOnTgUzbmq38QFSDe1I4dDrIr4KgN3+mOkVA+CyhFJymHAB
	oPRM4r8ivVteuZzCFaRuvN2BcXl87gS6WeK6dM1jyOJSgeN5Ml8m+uW1D5U5TFnGDJOll41bL0L
	0i9NMSFWOPKcsLhF8uLZpSs0zF93YmInQXW9OqEBfjmEwzvGMdb7pai/52UbNwucAbqsTxUevsW
	kfJPd/Fo8aJLx9+JCbPbGBsgin0dN8PDJi1m/94NF5+wpv3loC+w==
X-Received: by 2002:a05:7022:660c:b0:119:e56b:c75a with SMTP id a92af1059eb24-1247dbf8d14mr61525c88.31.1769104183224;
        Thu, 22 Jan 2026 09:49:43 -0800 (PST)
Received: from localhost ([2a00:79e0:2e7c:8:f995:553f:5ab5:f684])
        by smtp.gmail.com with UTF8SMTPSA id a92af1059eb24-1247d997f7bsm197174c88.11.2026.01.22.09.49.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 22 Jan 2026 09:49:42 -0800 (PST)
Date: Thu, 22 Jan 2026 09:49:41 -0800
From: Brian Norris <briannorris@chromium.org>
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Marek Szyprowski <m.szyprowski@samsung.com>,
	Bjorn Helgaas <helgaas@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>, Lukas Wunner <lukas@wunner.de>,
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
	linux-pm@vger.kernel.org,
	Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
Subject: Re: [PATCH v4] PCI/PM: Prevent runtime suspend before devices are
 fully initialized
Message-ID: <aXJjNfqcZrXw1_h2@google.com>
References: <20260106222715.GA381397@bhelgaas>
 <CGME20260114094643eucas1p1a2fdc6c35dd27741c18831b34bbed0c8@eucas1p1.samsung.com>
 <0e35a4e1-894a-47c1-9528-fc5ffbafd9e2@samsung.com>
 <aWf4KyTSIocWTmXw@google.com>
 <61e8c93c-d096-4807-b2dd-a22657f2e06a@samsung.com>
 <aWrjhqC_6I2UNXC5@google.com>
 <CAJZ5v0hWt63=0yjFrbTY8zXubh-Uc6ZwAndT73VL7itMkTe81A@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJZ5v0hWt63=0yjFrbTY8zXubh-Uc6ZwAndT73VL7itMkTe81A@mail.gmail.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[chromium.org,none];
	R_DKIM_ALLOW(-0.20)[chromium.org:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-41321-lists,linux-pm=lfdr.de];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	DKIM_TRACE(0.00)[chromium.org:+];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[briannorris@chromium.org,linux-pm@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_SEVEN(0.00)[9];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[linux-pm];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,chromium.org:email,chromium.org:dkim]
X-Rspamd-Queue-Id: 8B9906C671
X-Rspamd-Action: no action

Hi Rafael,

Thanks for your thoughts!

On Sun, Jan 18, 2026 at 12:53:21PM +0100, Rafael J. Wysocki wrote:
> On Sat, Jan 17, 2026 at 2:19 AM Brian Norris <briannorris@chromium.org> wrote:
> > I suppose one way to "solve" that is (untested):
> >
> > --- a/drivers/pci/bus.c
> > +++ b/drivers/pci/bus.c
> > @@ -380,8 +380,12 @@ void pci_bus_add_device(struct pci_dev *dev)
> >                 put_device(&pdev->dev);
> >         }
> >
> > +       if (dev->dev.parent)
> > +               pm_runtime_get_sync(dev->dev.parent);
> >         pm_runtime_set_active(&dev->dev);
> >         pm_runtime_enable(&dev->dev);
> > +       if (dev->dev.parent)
> > +               pm_runtime_put(dev->dev.parent);
> >
> >         if (!dn || of_device_is_available(dn))
> >                 pci_dev_allow_binding(dev);
> >
> > Personally, I'm more inclined to go back to v1, since it prepares the
> > runtime PM status when the device is first discovered. That way, its
> > ancestors are still active, avoiding these sorts of problems. I'm
> > frankly not sure of all the reasons Rafael recommended I make the
> > v1->v3->v4 changes, and now that they cause problems, I'm inclined to
> > question them again.
> >
> > Rafael, do you have any thoughts?
> 
> Yeah.
> 
> Move back pm_runtime_set_active(&dev->dev) back to pm_runtime_init()
> because that would prevent the parent from suspending and keep
> pm_runtime_enable() here because that would prevent the device itself
> from suspending between pm_runtime_init() and this place.

I'll admit, I was a little fuzzy on the details of the first part of the
sentence here -- specifically, that an "active" (but still "disabled")
device will prevent suspend of its parent. I suppose I'm more familiar
with the typical "disabled and suspended" device, which essentially has
no effect on its parent.

Anyway, that's basically v3, so I rerolled a v5 that looks similar.

> And I would add comments in both places.

I tried to add a short comment to each. It's an art form to write
exactly the right size of comment to make everyone happy (people
complain about too much commenting, and then others complain about
non-obvious behaviors that could have used more comments), especially
when it comes to something as tricky as runtime PM. At least I tried...

Brian

