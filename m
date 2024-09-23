Return-Path: <linux-pm+bounces-14571-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2FF2697EC21
	for <lists+linux-pm@lfdr.de>; Mon, 23 Sep 2024 15:16:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A3710B21B6A
	for <lists+linux-pm@lfdr.de>; Mon, 23 Sep 2024 13:16:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04658199225;
	Mon, 23 Sep 2024 13:16:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="vcQscEt5"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C70B019644B;
	Mon, 23 Sep 2024 13:16:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727097372; cv=none; b=F433dkm/92TWFmZe5ZDI1DFQE6/6BHF1VXLzzzgkl9SvfDzpzq2z3oUOyi4sKQmxEyeAl6y0IgnD6dgZQlTobwGnbQq8vG+F28HFjpMTPpCSvOJgImFQvA01RQ8YaTurmIVJHj3jbgyAl7aUm/XKpAiyMmkfmfPfR0OfjuST1ro=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727097372; c=relaxed/simple;
	bh=KY4Z+q9tIA239UUbBRf0f2Rfkna08HCfCtYkj/W0mos=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WUpwaAjWGeviPwwyh+cMsQ2R4nU3jmBnu8EFgaEKjoCrymCxCEnmb9PuqYbGJsDRYiMEc4ae+jXjv8lhvCHzqnRcy0F4OQwO02e+8GWeqUteQK65uJW4izH79s7DncfgXKPASPTONnBnjim0IE9M1vpWHzmDbCQeqzmgcY5EKaw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=vcQscEt5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A2006C4CEC4;
	Mon, 23 Sep 2024 13:16:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1727097372;
	bh=KY4Z+q9tIA239UUbBRf0f2Rfkna08HCfCtYkj/W0mos=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=vcQscEt5JT2byQlAM/DemY0JgOs2YP1h6NVj8FhGpr/YVV5PBwkvBZ1xKiTvOc6kp
	 4Way/9vsLT6HRdvMy5N0gtwAkyof8xEGAn+IClJDlO4jBQRYnqvIhCrTcgJ3M5D66K
	 QaS/sRM+66imBikXzpF3JhD+XmPUx45XhK8I3sIY=
Date: Mon, 23 Sep 2024 15:16:07 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: dengjie03 <dengjie03@kylinos.cn>
Cc: rjw@rjwysocki.net, pavel@ucw.cz, len.brown@intel.com,
	linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-pm@vger.kernel.org, xiehongyu1@kylinos.cn,
	duanchenghao@kylinos.cn, xiongxin <xiongxin@kylinos.cn>
Subject: Re: [PATCH] KYLIN: USB: Fix the issue of S4 wakeup queisce phase
 where task resumption fails due to USB status
Message-ID: <2024092337-epidermal-drainpipe-cf0d@gregkh>
References: <20240923100553.119324-1-dengjie03@kylinos.cn>
 <2024092355-chip-stuffy-bd93@gregkh>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2024092355-chip-stuffy-bd93@gregkh>

On Mon, Sep 23, 2024 at 03:06:58PM +0200, Greg KH wrote:
> On Mon, Sep 23, 2024 at 06:05:53PM +0800, dengjie03 wrote:
> > Reproduction of the problem: During the S4 stress test,
> > when a USB device is inserted or removed, there is a
> > probability that the S4 wakeup will turn into a reboot.
> > The following two points describe how to analyze and
> > locate the problem points:

Also, what is the "KYLIN" on the subject line for?

thanks

greg k-h

