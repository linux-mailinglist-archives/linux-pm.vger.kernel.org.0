Return-Path: <linux-pm+bounces-15461-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 20953998AC1
	for <lists+linux-pm@lfdr.de>; Thu, 10 Oct 2024 17:01:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E0FA2B3207C
	for <lists+linux-pm@lfdr.de>; Thu, 10 Oct 2024 14:27:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A7231CBEAF;
	Thu, 10 Oct 2024 14:21:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rowland.harvard.edu header.i=@rowland.harvard.edu header.b="THu5v9dm"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-qt1-f179.google.com (mail-qt1-f179.google.com [209.85.160.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B29E01CC175
	for <linux-pm@vger.kernel.org>; Thu, 10 Oct 2024 14:21:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728570110; cv=none; b=Ynvvlh9Og3T3rO45pekFS04rjy952/9/pwVOdL3GrSvwB2SNclFnwypnZO4hbo4NZF7K6KYQDj0fe9z+z6L5NHOxtzBelvIhP8YAJk3dhNDcfCiY002ozcy4qZrK3WlD2vIvcKZAX8QshWooZBzQTMFIQRXjUBfC19OFlJ3UJHo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728570110; c=relaxed/simple;
	bh=Pn+/ovAfKzaZgF1lOOQemSoa3w7I63F4I3qtxW0337Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RqbDc3TOvOkQOcoJgtQFP+IWPZTxKpLPiTMJN7RTZZv4xLTYycyP3PzxCx5z+lxf4lQ72ISJii6GKzXcOjnwqB+hXEZpmWjweXD2WI0jgtVgSh95HYUBa7903om2K7aBHAMzJZQH+L+39c7L1tZV5xNCijBlV3VPLIbWPBsCVKk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rowland.harvard.edu; spf=fail smtp.mailfrom=g.harvard.edu; dkim=pass (2048-bit key) header.d=rowland.harvard.edu header.i=@rowland.harvard.edu header.b=THu5v9dm; arc=none smtp.client-ip=209.85.160.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rowland.harvard.edu
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=g.harvard.edu
Received: by mail-qt1-f179.google.com with SMTP id d75a77b69052e-460464090d5so4278141cf.2
        for <linux-pm@vger.kernel.org>; Thu, 10 Oct 2024 07:21:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rowland.harvard.edu; s=google; t=1728570108; x=1729174908; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=vtQNH6rvFcrdxN4zHa126S8BT47FK08wSbNoHwbhRl0=;
        b=THu5v9dmI28MJFTQc4Ws0lmriBo44cwiS+kcTBpct3vKr65hdmxTCm7XmxDpcD3vGY
         712FO30yPRA4XizJigNhRDoxF2Y9Wqvu9fAZlwJ6tbpkHkr/dNf5OGAAay0lqpgz0zi7
         fhC9A02nuJzcnpPngUbh65iCAsx11KDl6MKM9uL7ooatlvuvOS5X4ESWroEOOScikla7
         leaKPIljZAWH6akBgVf8awbU/V9pBWAsgpGjqU16tAPTpdvVDGYT0iY9GGpqOANnxL8o
         UHPkfgpb/qEsPQVBSFKm6yHFtb0TekkeIoUCfrnDvZy1TDuWZOwjKoZT6u93kuEXAF4P
         d5QQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728570108; x=1729174908;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vtQNH6rvFcrdxN4zHa126S8BT47FK08wSbNoHwbhRl0=;
        b=cJIbnWe3gHtMQ1WDI0lVV7a173uCs1BF2XWBjaviFwx/t3S8Xdl8bb/FBI9xJmuyIG
         Q6dyqt5QD51HowYir8HNXmchBKmsi5ybwqFBIZvCjFNFTCUjKCJRlkq6nyFzXtSsHrS7
         Trp4+/RwJ6FSaP1zE1sMbQx8sPM5WJJogOKNG32S4t0xYU1Y69HOaBZAkPFySx3KrrP7
         sdlbTC2RrjQWzDZVNQbFa6U6S5RZglBDCmTWi+v9b9IaO+AjdpOdSRlEegpl3MkeGJx+
         YcaO8uc8++nI5lsRNF9f4cKKh1B9tG3B2Xa4wvlSVM8D7/SdtsAqLkx+qxv1p3ivyqDv
         K9ZA==
X-Forwarded-Encrypted: i=1; AJvYcCXU5wPluDUTVf/lmBTZhAco9PwhwFLqmXPp0x3iJ8dkEb0pFZRRUxdZwSeE7j6k0sWYO6unAPJueQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Yy9VpiDnpUymmRxuCFl+eZ1LaxfkAC67t6FznWcNumr4qcAW6Ho
	+TFk+Zw84jQ4LT1eqtNOc8DSBf4uU8lGalfdvWTy6BjzzM6cN2+D1C6li76Zig==
X-Google-Smtp-Source: AGHT+IE+UsnOG49Pq5AyS2xIUjW9P9DXzZJGhEQefQupzSZHTswqoW16lQIgXA8ZNNhcWysuNuhDWQ==
X-Received: by 2002:ac8:7d46:0:b0:44f:f14c:6a63 with SMTP id d75a77b69052e-45fa5ec0fe9mr96443611cf.11.1728570107392;
        Thu, 10 Oct 2024 07:21:47 -0700 (PDT)
Received: from rowland.harvard.edu ([2601:19b:681:fd10::31c2])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-460427d5178sm5748291cf.25.2024.10.10.07.21.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Oct 2024 07:21:47 -0700 (PDT)
Date: Thu, 10 Oct 2024 10:21:43 -0400
From: Alan Stern <stern@rowland.harvard.edu>
To: duanchenghao <duanchenghao@kylinos.cn>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>,
	Hongyu Xie <xy521521@gmail.com>, gregkh@linuxfoundation.org,
	linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
	linux-usb@vger.kernel.org, niko.mauno@vaisala.com, pavel@ucw.cz,
	stanley_chang@realtek.com, tj@kernel.org,
	Hongyu Xie <xiehongyu1@kylinos.cn>
Subject: Re: [PATCH] USB: Fix the issue of task recovery failure caused by
 USB status when S4 wakes up
Message-ID: <d70e070f-5224-402c-ac27-0703b4010b18@rowland.harvard.edu>
References: <a618ada1582c82b58d2503ecf777ea2d726f9399.camel@kylinos.cn>
 <8b07752d-63c4-41e3-bd20-ce3da43dfffc@rowland.harvard.edu>
 <8068130ce4ece6078b2893c4c6333c06c792b6c0.camel@kylinos.cn>
 <b8dc326b-8aee-4903-bbb6-64083cf66b4d@rowland.harvard.edu>
 <bddecd4e-d3c8-448e-8a22-84bbc98c4d1b@kylinos.cn>
 <b2ec107d4797f6e1e8e558f97c0ad1be6d46572c.camel@kylinos.cn>
 <84a4f66a-5b0e-46a8-8746-be6cd7d49629@rowland.harvard.edu>
 <fa347849defa66a7d4af23ac6317ae5b37357ea4.camel@kylinos.cn>
 <2c368013-8363-4a4e-bfee-2f0b14d01162@rowland.harvard.edu>
 <5f2f6b979e95e4c2bc33ea0277112939164f6024.camel@kylinos.cn>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5f2f6b979e95e4c2bc33ea0277112939164f6024.camel@kylinos.cn>

On Thu, Oct 10, 2024 at 01:59:08PM +0800, duanchenghao wrote:
> Hi Alan,

> Thank you very much for your evaluation of the scheme. I have a
> question regarding why the set_bit operation for the
> HCD_FLAG_WAKEUP_PENDING flag is performed in the top half of an
> interrupt handler, while the clear_bit operation is done in the bottom
> half. This seems to contradict conventional practices. The issue is not
> limited to S4; if other processes freeze the work queue in the bottom
> half, the same problem may arise.

The flag is treated this way because that's what it means: A wakeup is 
pending.  The kernel first learns about the wakeup when it receives the 
wakeup interrupt from the host controller, so that's when it sets the 
flag -- in the top half of the interrupt handler.  The wakeup procedure 
isn't complete until the root hub has been resumed, so the flag remains 
set until that resume is finished, in the bottom half.

You say "the same problem may arise", but I don't think it is a problem.  
If the system is about to suspend the host controller with wakeups 
enabled, and a wakeup request has already been received but the system 
has not yet finished acting on it, then the suspend _should_ fail.  
After all, if the wakeup interrupt had arrived just after the host 
controller was suspended rather than just before, it would have caused 
the host controller to be resumed right away -- with exactly the same 
effect as if the controller had never been suspended in the first place.

> The solution you described below should be able to resolve the current
> S4 issue, but for now, we haven't identified any other scenarios that
> require the same operation.

Perhaps because there aren't any.

>  Based on my understanding, the USB device
> is woken up in the bottom half of the interrupt,

You are failing to distinguish between the host controller and the root 
hub.  The host controller (which is a PCI device on your system, not a 
USB device) is woken up in the top half of the interrupt handler.  The 
root hub (which is a virtual USB device) is woken up in the bottom half.  
Both operations have to occur before the wakeup can be considered fully 
complete.

>  and both the set_bit
> and clear_bit operations for the HCD_FLAG_WAKEUP_PENDING flag should be
> executed within the same thread in the bottom half. May I ask if there
> are any other reasons why the set_bit is executed in the top half?

Because the root hub's wakeup becomes pending when the host controller 
is resumed, in the top half.

Alan Stern


