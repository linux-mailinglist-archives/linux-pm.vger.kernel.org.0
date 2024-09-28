Return-Path: <linux-pm+bounces-14888-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DC89A988F07
	for <lists+linux-pm@lfdr.de>; Sat, 28 Sep 2024 12:50:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DBC231C20CE7
	for <lists+linux-pm@lfdr.de>; Sat, 28 Sep 2024 10:50:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A96F0183CD6;
	Sat, 28 Sep 2024 10:50:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="MWET9nlm"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A50812E75;
	Sat, 28 Sep 2024 10:50:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727520630; cv=none; b=b9Tg+ZCkouZ34nHTniYnyS5G32mMZbKwtjVudNGFf0/vRy03p1Brpqes+IWJXEkzYapj6xWUAGx9YNTs9omD1UtL9sk3l8LVtLlhrt1fk7B7LaegyucZMMtOe7cFER77o+hnVFSjp5G/Y4rcsY+rY433Jqv6wDcOr6klXpas9Ug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727520630; c=relaxed/simple;
	bh=derXC/iYKGo7lUr6kvmLUS4NflZd1br/P30+QWMsE/Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nqlMQbjLe8U/ISZw2KgkMP7S0lK4B+Dhjgn2ro7kstc8rzWXJw9Qmx4CTguIohPNZfNYZCfh0UuXdUJrZ0UsomkQF6OdaKSCssIfw5Y1praRTN3BeAhZunD8gBCvyCsL0t7PHDOBFkpCDkkJewYb3uv2xd25sRz0ggcgdW1Hla8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=MWET9nlm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A1315C4CEC3;
	Sat, 28 Sep 2024 10:50:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1727520630;
	bh=derXC/iYKGo7lUr6kvmLUS4NflZd1br/P30+QWMsE/Q=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=MWET9nlmwbYX+y1u9PHhUZlCjeV0btkWdANYXJTWc0Cr63kqoKb4xuiemROaDFAzG
	 +5zP/HsVVbHWbctKqpNaqeA3ukZA6hTCtBT1Tt0Ai7BQ/N/DtEMgySn//xVVh3RNly
	 RkvI6uHo9lqPnZRnZ2BKvY7zHTIiy8qcVeDFIQKA=
Date: Sat, 28 Sep 2024 12:50:21 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Zijun Hu <quic_zijuhu@quicinc.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>,
	Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>,
	Johan Hovold <johan+linaro@kernel.org>,
	Tony Lindgren <tony@atomide.com>, Zijun Hu <zijun_hu@icloud.com>,
	linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH RFC] PM: sleep: wakeirq: Fix a serious logical error in
 dev_pm_disarm_wake_irq()
Message-ID: <2024092842-diabetic-suction-861a@gregkh>
References: <20240928-fix_wakeirq-v1-1-25d13a7e13ba@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240928-fix_wakeirq-v1-1-25d13a7e13ba@quicinc.com>

On Sat, Sep 28, 2024 at 02:26:27AM -0700, Zijun Hu wrote:
> IT is a serious logical error for dev_pm_disarm_wake_irq() not to disable
> the wake irq enabled by dev_pm_arm_wake_irq(), fixed by simply correcting
> the wrong if condition.
> 
> Signed-off-by: Zijun Hu <quic_zijuhu@quicinc.com>

What commit id does this fix?

> ---
> List relevant commits as following:
> 
> johan+linaro@kernel.org  2023-07-13
> Commit: 8527beb12087 ("PM: sleep: wakeirq: fix wake irq arming")
> 
> tony@atomide.com  2018-02-09
> Commit: 69728051f5bf ("PM / wakeirq: Fix unbalanced IRQ enable for wakeirq")
> 
> The former commit fixes the later.

I do not understand this series of commits, what exactly are you trying
to show here?

confused,

greg k-h

