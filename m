Return-Path: <linux-pm+bounces-15460-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 38F0A99889D
	for <lists+linux-pm@lfdr.de>; Thu, 10 Oct 2024 16:02:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 95527B27CAA
	for <lists+linux-pm@lfdr.de>; Thu, 10 Oct 2024 14:02:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 519BE1C9ED7;
	Thu, 10 Oct 2024 14:02:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rowland.harvard.edu header.i=@rowland.harvard.edu header.b="AJ0ndw4M"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-qv1-f52.google.com (mail-qv1-f52.google.com [209.85.219.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AB681CB314
	for <linux-pm@vger.kernel.org>; Thu, 10 Oct 2024 14:02:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728568923; cv=none; b=RwxxzyThmsoOPTnUhO5L2/TIb08jN4yy3yUHKw04ksXg+SUqd//dTWLNi19XFq3dy/BykFemj59HBfSW2/3hQzrNOheNQDeVvbqCx/gZpKQPOTxbjm0suFt66INkb36/FdreNeAv9bUqMhEseC7QjB5+24uhMM+y5ESjORdvr34=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728568923; c=relaxed/simple;
	bh=tayHagjkyLxbAkzllGMcd20Ms8R/cs52Cg65qYZAqRM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QW/zmRa2ncoDvsYxrIvf26XnB90IQ0DX4UuI2R3CtwdOm6V/YbJWkkNTOuB+6JtJhOZMpZFnjwCd6K/SWMym6VQiziPBCQAc2V18X4xEbIcwgHzCNGfd84uRA0M+l5Cm+4hudJprvutDW4/K1H8cWO1PDfqHX9mAXdel6SOS9Oo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rowland.harvard.edu; spf=fail smtp.mailfrom=g.harvard.edu; dkim=pass (2048-bit key) header.d=rowland.harvard.edu header.i=@rowland.harvard.edu header.b=AJ0ndw4M; arc=none smtp.client-ip=209.85.219.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rowland.harvard.edu
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=g.harvard.edu
Received: by mail-qv1-f52.google.com with SMTP id 6a1803df08f44-6cbceb321b3so7860286d6.3
        for <linux-pm@vger.kernel.org>; Thu, 10 Oct 2024 07:02:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rowland.harvard.edu; s=google; t=1728568920; x=1729173720; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=nlmSIqyj7yLz/4SzCcFVFwBrST/SCNJIfibOOMbF3Yc=;
        b=AJ0ndw4MLoi4U02EUOpnFQGUKcDnN5r3Ve3GaL7etwpIxl2LGyBC6JbIA3c6p214Ap
         L9Hu7jzhcB+lhyh3a2hqC0MuxZqDandZT9NjWjVo+jlzTAPTwdkc+OKbvx9fxjqPQJCr
         9G2j1NgX5UyYE75FO4In0Zs/ROhKT/G1JK6tBvggIzJUbT0P+EHJsP20ipSRAcK5l+/q
         iP4JqfowrxBGc5wiuRJ/JrChlZDDBxoHZG7GOJdUW5Oah+778vfQOSMrkaZ5BffCCLN2
         WyslCEcXANuIAMg9olR7NxozkwhuaqnVszmWhMEcScM1rFLUcDBnL5m7ENvtWeE/jkZM
         cgVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728568920; x=1729173720;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nlmSIqyj7yLz/4SzCcFVFwBrST/SCNJIfibOOMbF3Yc=;
        b=LHx96J6HxO39kxhI5MTryeoeUDPrk33CmdpBzSZqY03iV1hohNTEJlyx6goEiZJI42
         4dMTpGN/I8h6CA/Xt1WUA8iZRCKTlKxRfifnw7T9lFeSgqZqD/0pqQ7gZCwCtnY/SLsS
         HMUrcDBTzUejupx1MM7ghi2W8Grc0E6hQ0KokcFgprdahMA/evh39TP5lY28HnO8igN+
         Gbc0vriKCIMXm7Jp2ons90SMzEfPPaARKCp1sY2YnaMCNwH2d6H/0qtKmBclTgW0neyW
         ivnWycb7f1DYU/6pyf9G89XghdBs4L7Uz8cGDs8LN7KKNQTzR00HF9X+8O/zHINE1sGo
         V5bg==
X-Forwarded-Encrypted: i=1; AJvYcCUokjGMTQHAxsekqwFdgsNBkmxbZ3k+VpsZ3iuPLwlSxekffqoITBD86ooGaQO9NzvW0j8GsYv2zA==@vger.kernel.org
X-Gm-Message-State: AOJu0YyVir0xsrT9AeLwv3U2ol2MQbNOu9vDAiRqc4y+iv4uqwVju+Es
	WmvtjNuBkhQkP4eu2cl9m1DOD7KdHUXCWya9u8Q2DbU3yNMfYTVVWMkYyaa2TA==
X-Google-Smtp-Source: AGHT+IHe0FCqHdwy4gltrZN1qn61uhvd60oeSgZkEe/OjMeokXqgsryBvF/O0vkpfeRYNJ9QuQSCbA==
X-Received: by 2002:a05:6214:8010:b0:6cb:cd88:1794 with SMTP id 6a1803df08f44-6cbcd881948mr83598316d6.2.1728568920310;
        Thu, 10 Oct 2024 07:02:00 -0700 (PDT)
Received: from rowland.harvard.edu ([2601:19b:681:fd10::31c2])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6cbe85b7a70sm5548906d6.53.2024.10.10.07.01.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Oct 2024 07:01:59 -0700 (PDT)
Date: Thu, 10 Oct 2024 10:01:56 -0400
From: Alan Stern <stern@rowland.harvard.edu>
To: Deng Jie <dengjie03@kylinos.cn>
Cc: rafael@kernel.org, gregkh@linuxfoundation.org, len.brown@intel.com,
	linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
	linux-usb@vger.kernel.org, pavel@ucw.cz, xiehongyu1@kylinos.cn,
	xiongxin@kylinos.cn, duanchenghao@kylinos.cn
Subject: Re: [PATCH v2] USB: Fix the issue of S4 wakeup queisce phase where
 task resumption fails due to USB status
Message-ID: <13977202-1571-4987-9f2f-20312f8446fa@rowland.harvard.edu>
References: <85105e45-3553-4a8c-b132-3875c4657c4b@rowland.harvard.edu>
 <20241010004655.9382-1-dengjie03@kylinos.cn>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241010004655.9382-1-dengjie03@kylinos.cn>

On Thu, Oct 10, 2024 at 08:46:55AM +0800, Deng Jie wrote:
> Hi Alan
>   I'm thrilled to receive your reply. Thank you very much.
> Sorry for the late response due to the holiday.

> 1. Although during the S4 quiesce phase, the do_remote_wakeup flag is set
> to 0 within the usb_suspend->choose_wakeup function, the subsequent sequence
> of usb_suspend->usb_suspend_both->usb_suspend_device->hcd_bus_suspend->
> xhci_bus_suspend will disable remote wakeup for the RootHub port.
> 2. However, during the loading image phase prior to the S4 quiesce phase,
> the USB device may have generated an interrupt, setting the WAKEUP_PENDING flag.
> Additionally, due to the execution of freeze_kernel_threads before the loading
> image phase, the USB interrupt generated during the loading image phase is
> unable to execute its interrupt handler's bottom half, resulting in the
> WAKEUP_PENDING flag remaining uncleared.
> 3. Therefore, even though the remote wakeup for the RootHub is disabled in
> usb_suspend_both() during the quiesce phase, due to the WAKEUP_PENDING flag not
> being cleared, the xhci still believes that the RootHub has generated a wakeup
> event when it attempts to suspend. Consequently, the xhci suspend function
> returns an -EBUSY error and does not proceed with the suspend operation.
> 
> >Now maybe things are't working the way they are supposed to.  If that's
> >so then you should submit a patch fixing the code so that it _does_ work
> >this way.
> >
> >For instance, in suspend_common(), do_wakeup is derived from
> >device_may_wakeup(rhdev), which is determined by
> >rhdev->power.should_wakeup -- see the definition in
> >include/linux/pm_wakeup.h.  Maybe this flag isn't getting cleared
> >properly.  (In fact, at the moment I don't see where that flag gets set
> >or cleared at all...)
> 
> After configuring CONFIG_PM_SLEEP, the return value of device_may_wakeup
> should be equal to dev->power.can_wakeup && !!dev->power.wakeup.

Please see my reply on this other email thread, which concerns the same 
problem:

https://lore.kernel.org/linux-usb/2c368013-8363-4a4e-bfee-2f0b14d01162@rowland.harvard.edu/

I should have CC'ed you on that message, but I didn't think of it at the 
time.

Alan Stern

