Return-Path: <linux-pm+bounces-14613-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DF699846DE
	for <lists+linux-pm@lfdr.de>; Tue, 24 Sep 2024 15:38:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A9114B226B9
	for <lists+linux-pm@lfdr.de>; Tue, 24 Sep 2024 13:38:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 473311A7AD0;
	Tue, 24 Sep 2024 13:38:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rowland.harvard.edu header.i=@rowland.harvard.edu header.b="wiGorOeh"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-qv1-f46.google.com (mail-qv1-f46.google.com [209.85.219.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80D531A7249
	for <linux-pm@vger.kernel.org>; Tue, 24 Sep 2024 13:38:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727185101; cv=none; b=mAbEZ6WIw9GNOUiCqy9NlgMIZZQvTD9ElM7AKWQ2DX/OPWrYAauhy9fADYnRdR/2LKZRAMchWOkkZ/35/ywm7B+scC2gseMXgq58dYUB5zzf74XIGMHdEigFckxFzjR6f4T6dbPIUbAbbQELQp8PFLeqG1bs6kgH+suew4g+rWk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727185101; c=relaxed/simple;
	bh=IKIonoNeYoNmdWzWzqLWJDubzCyc9w9DCE0STMcXt9k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=o9oPvTB7GCUg5UKASMDLPiGFkAr0ZwvMaHST27Mzy4lHta0cePG404SECpwx6MkqrxwdVPQzO+h/XLtFiH6CMGAlSCfdWJbcat965UPhLuF3pX88s3tlw6kMV1VYDW2DwECWGKy7kL++a2YHnwl6/YtS/lTPo4Mo1cRZNuo/sOg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rowland.harvard.edu; spf=pass smtp.mailfrom=g.harvard.edu; dkim=pass (2048-bit key) header.d=rowland.harvard.edu header.i=@rowland.harvard.edu header.b=wiGorOeh; arc=none smtp.client-ip=209.85.219.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rowland.harvard.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=g.harvard.edu
Received: by mail-qv1-f46.google.com with SMTP id 6a1803df08f44-6c35357cdacso37580676d6.0
        for <linux-pm@vger.kernel.org>; Tue, 24 Sep 2024 06:38:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rowland.harvard.edu; s=google; t=1727185097; x=1727789897; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=E6JXM+QLU+4X/JWyyIOkIQda0pDB3qoLDILb8gSMbAA=;
        b=wiGorOehl8AO4wv7rvKu82vKmmcnd+dUxqJetfg8hIpBR+Q/IfzcmA2pWttvBI7HLu
         s/ebfi5X1YDS2w/9OKG633x5cvzl9a3qDAhp3g/o5uPpsbStMc6bimmyeMGM9mbIV3yc
         iLhBI09WMHB7pxOoCz/N56dx7MGYksvTKunxpTvGvspaUwJE7Mo7Np2ZbiY+WTxNfaVs
         qMeEXaIvLtYC/w3Wj/vsHBzDwXXJBjMY1463m+Nsimdb4/OfLWXfvmyL2s0fsc89Qxkb
         ozbELBqOPtJq2LRq1+/cjVQYdMhJtVwhn3K6i6pv2dY+5iROQ15B8kbZlrX5oLpjTmQH
         u14g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727185097; x=1727789897;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=E6JXM+QLU+4X/JWyyIOkIQda0pDB3qoLDILb8gSMbAA=;
        b=adQvZ5ms4WiAAWKGDKE80d7J7AAjoRw4aAqXY1zSHPwSwYDjcuDWdWdJcAweploQ4S
         O1sUmwXY8bFgA7+EuKn8976fe7iy61b/8F4r55/t+bYOjXQqUTr4945KfeSTlYaTCifw
         x9lVkaPFxUlccpPmBgDfT4Fr8smC9nikof8/Z3mpfS2rCQXJjDrEeOCZkmSXzGlRHnr5
         j7giaAGDporIe6hM0tnye4WF2Ew1CfJ1x82N/7tAsrBJIc9IOp4KyZKmksiTfsDZu5WC
         ZT9xprUQtQ4NaIQCr4dDUuPnbnR60x5N1AE+0cjJpN8g6PCRwMyzGs3hG6/FDfXZQHj2
         L85Q==
X-Forwarded-Encrypted: i=1; AJvYcCVaKJ6ggF/pUhfCyWM1bmYmM92lxn5OX4yLYggMkqflK07uJDTptWsAEAKxNsQMBIuhbac6iEV/fQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YxtYCE43JDQiBnyy8ItTBeqU6B7ayXyi91JOSe1WoVsDY3SB0aB
	ljbzfl7RwJPYsSI6q+Z3Z+a7lknOdq7NCX58yxEw8tM+xOp+oLhrDNKJIj8Udw==
X-Google-Smtp-Source: AGHT+IEVIlIwj5quOIWB4UukHBgt1Esg0Kf6gJRumiEhfFika6XFCL04I3ekSou3MMOQiIZHQSdjmA==
X-Received: by 2002:a05:6214:3a06:b0:6bf:7b7f:68e with SMTP id 6a1803df08f44-6c7bd5e802dmr243389286d6.40.1727185097391;
        Tue, 24 Sep 2024 06:38:17 -0700 (PDT)
Received: from rowland.harvard.edu ([2601:19b:681:fd10::884e])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6cb0f552c15sm6566746d6.76.2024.09.24.06.38.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Sep 2024 06:38:16 -0700 (PDT)
Date: Tue, 24 Sep 2024 09:38:13 -0400
From: Alan Stern <stern@rowland.harvard.edu>
To: duanchenghao <duanchenghao@kylinos.cn>
Cc: Hongyu Xie <xy521521@gmail.com>, gregkh@linuxfoundation.org,
	linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
	linux-usb@vger.kernel.org, niko.mauno@vaisala.com, pavel@ucw.cz,
	stanley_chang@realtek.com, tj@kernel.org,
	Hongyu Xie <xiehongyu1@kylinos.cn>
Subject: Re: [PATCH] USB: Fix the issue of task recovery failure caused by
 USB status when S4 wakes up
Message-ID: <84a4f66a-5b0e-46a8-8746-be6cd7d49629@rowland.harvard.edu>
References: <20240906030548.845115-1-duanchenghao@kylinos.cn>
 <1725931490447646.3.seg@mailgw.kylinos.cn>
 <a618ada1582c82b58d2503ecf777ea2d726f9399.camel@kylinos.cn>
 <8b07752d-63c4-41e3-bd20-ce3da43dfffc@rowland.harvard.edu>
 <8068130ce4ece6078b2893c4c6333c06c792b6c0.camel@kylinos.cn>
 <b8dc326b-8aee-4903-bbb6-64083cf66b4d@rowland.harvard.edu>
 <bddecd4e-d3c8-448e-8a22-84bbc98c4d1b@kylinos.cn>
 <b2ec107d4797f6e1e8e558f97c0ad1be6d46572c.camel@kylinos.cn>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <b2ec107d4797f6e1e8e558f97c0ad1be6d46572c.camel@kylinos.cn>

On Mon, Sep 23, 2024 at 04:00:35PM +0800, duanchenghao wrote:
> Hi Alan,
> 
> Do you think this plan is feasible, or is there any unclear part in my
> description that needs to be supplemented?

I apologize for not getting back to you earlier -- I've been incredibly 
busy during the last few weeks.

I still haven't had time to go over this throroughly.  If I don't 
respond by the end of this week, remind me again.

Alan Stern

> duanchenghao
> 
> 
> 在 2024-09-14星期六的 10:43 +0800，Hongyu Xie写道：
> > From: Hongyu Xie <xiehongyu1@kylinos.cn>
> > 
> > 
> > Hi Alan,
> > On 2024/9/12 23:00, Alan Stern wrote:
> > > On Thu, Sep 12, 2024 at 11:21:26AM +0800, duanchenghao wrote:
> > > > 在 2024-09-11星期三的 10:40 -0400，Alan Stern写道：
> > > > > On Tue, Sep 10, 2024 at 05:36:56PM +0800, duanchenghao wrote:
> > > > > > S4 wakeup restores the image that was saved before the system
> > > > > > entered
> > > > > > the S4 sleep state.
> > > > > > 
> > > > > >      S4 waking up from hibernation
> > > > > >      =============================
> > > > > >      kernel initialization
> > > > > >      |
> > > > > >      v
> > > > > >      freeze user task and kernel thread
> > > > > >      |
> > > > > >      v
> > > > > >      load saved image
> > > > > >      |
> > > > > >      v
> > > > > >      freeze the peripheral device and controller
> > > > > >      (Check the HCD_FLAG_WAKEUP_ PENDING flag of the USB. If
> > > > > > it is
> > > > > > set,
> > > > > >       return to EBUSY and do not perform the following
> > > > > > restore
> > > > > > image.)
> > > > > 
> > > > > Why is the flag set at this point?  It should not be; the
> > > > > device and
> > > > > controller should have been frozen with wakeup disabled.
> > > > > 
> > > > This is check point, not set point.
> > > 
> > > Yes, I know that.  But when the flag was checked, why did the code
> > > find
> > > that it was set?  The flag should have been clear.
> > Maybe duanchenghao means this,
> > freeze_kernel_threads
> > load_image_and_restore
> >    suspend roothub
> >                                       interrupt occurred
> >                                         usb_hcd_resume_root_hub
> >                                           set HCD_FLAG_WAKEUP_PENDING
> >                                           queue_work // freezed
> >    suspend pci
> >      return -EBUSY  because HCD_FLAG_WAKEUP_PENDING
> > 
> > So s4 resume failed.
> > > 
> > > > > Is your problem related to the one discussed in this email
> > > > > thread?
> > > > > 
> > > > > https://lore.kernel.org/linux-usb/d8600868-6e4b-45ab-b328-852b6ac8ecb5@rowland.harvard.edu/
> > > > > 
> > > > > Would the suggestion I made there -- i.e., have the xhci-hcd
> > > > > interrupt handler skip calling usb_hcd_resume_root_hub() if the
> > > > > root
> > > > > hub
> > > > > was suspended with wakeup = 0 -- fix your problem?
> > > > 
> > > > Skipping usb_hcd_resume_root_hub() should generally be possible,
> > > > but
> > > > it's important to ensure that normal remote wakeup functionality
> > > > is not
> > > > compromised. Is it HUB_SUSPEND that the hub you are referring to
> > > > is in
> > > > a suspended state?
> > > 
> > > I don't understand this question.  hub_quiesce() gets called with
> > > HUB_SUSPEND when the hub enters a suspended state.
> > > 
> > > You are correct about the need for normal remote wakeup to work
> > > properly.  The interrupt handler should skip calling
> > > usb_hcd_resume_root_hub() for port connect or disconnect changes
> > > and for
> > > port overcurrent changes (when the root hub is suspended with
> > > wakeup =
> > > 0).  But it should _not_ skip calling usb_hcd_resume_root_hub() for
> > > port
> > > resume events.
> > > 
> > > Alan Stern
> > > 
> > 
> > Hongyu Xie
> 

