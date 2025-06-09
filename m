Return-Path: <linux-pm+bounces-28284-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A36CAD16CC
	for <lists+linux-pm@lfdr.de>; Mon,  9 Jun 2025 04:32:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 558CF3A8402
	for <lists+linux-pm@lfdr.de>; Mon,  9 Jun 2025 02:31:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1EFFD2459E0;
	Mon,  9 Jun 2025 02:31:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZduS/cok"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E836F2459D8;
	Mon,  9 Jun 2025 02:31:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749436318; cv=none; b=bdoj0ScGcjWa9GEFPPSKwuxOQ/GXuwjccIpv0vw9JI3GbyHWjXjn1QGNX5WaJkm5uUk3zgPofv6PN2IkCfY+aA02jFMe9J74PW69Oqp0PPn2Za2w41gp4DQE7jIAB7UHqdacccCtws+vK13ygRJCLY6wpBNZ8ZNNess6bExWjys=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749436318; c=relaxed/simple;
	bh=1I50E9XtKusz1fNbhKpZjCCaNyBNQaPWOO+WRC1LFZc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lITzf7lndsQvfue+qQ3z0+jjLbhdHjwPQuJxTQbaAfwq/bML31cShQl/MS2b3aoLnVfnTVxicsVcWfrgL4jB4qr54l8lXzmsj6PcO9ii1kake/FHpeQ2gKPOxq3tNt2fjaWNd+/zsDC+E6kYedpl+yspg8bZ6NqkzbSw5hZ97Sw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZduS/cok; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 66C93C4CEEE;
	Mon,  9 Jun 2025 02:31:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749436317;
	bh=1I50E9XtKusz1fNbhKpZjCCaNyBNQaPWOO+WRC1LFZc=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=ZduS/cokXnGuePD4xMxftcflPdXoQ+Ub2r8u510rE865G3HfW5ugInSN7+zpQ7JMA
	 MzJtWnX8U8u04OBxqpvolggIfoVVAF7RCO9/UWebjwgwm0vIuxNTd+qy2YCeDTZA4k
	 y5/TY80zKRokL303/8JQ5F03c3MPwESVoJpdD+SvWAK1B82EnlPJnKSAuzdGAcbdZ2
	 6E2AcC48gfzEcCwlqMyGo6+O3MUMkb1zJQ2tnKSh9HzuxkosYbsGBeu1MILYVHpi3f
	 os+7+UpaVl5LYGjImonneTC4zB70l0pXxpGmax4aDAnAy9pn8uETAOpKktopRI6gS/
	 2NVJPR+lqkIRA==
Message-ID: <f656b948-aa3a-4811-b51f-64effa2001fc@kernel.org>
Date: Sun, 8 Jun 2025 21:31:41 -0500
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Build error in 6.16-rc1 in drivers/mfd/88pm860x-core.c
To: Peter Schneider <pschneider1968@googlemail.com>,
 LKML <linux-kernel@vger.kernel.org>, linux-pm@vger.kernel.org
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
 haojian.zhuang@marvell.com, mario.limonciello@amd.com,
 Thomas Gleixner <tglx@linutronix.de>, jirislaby@kernel.org,
 =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>,
 Lee Jones <lee@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>
References: <fbea65b5-2015-44db-a7d9-b53cba9833b3@googlemail.com>
Content-Language: en-US
From: Mario Limonciello <superm1@kernel.org>
In-Reply-To: <fbea65b5-2015-44db-a7d9-b53cba9833b3@googlemail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 6/8/25 8:58 PM, Peter Schneider wrote:
> Hi all,
> 
> I just tried to test-build 6.16-rc1 on my good old 2-socket Ivy Bridge 
> Xeon E5-2697 v2 server, running Proxmox/Debian 12 (Bookworm) with GCC 
> 12.2. I received the following build error:
> 
>    CC      drivers/mfd/88pm860x-core.o
> drivers/mfd/88pm860x-core.c: In function 'device_irq_init':
> drivers/mfd/88pm860x-core.c:576:29: error: unused variable 'node' [- 
> Werror=unused-variable]
>    576 |         struct device_node *node = i2c->dev.of_node;
>        |                             ^~~~
> cc1: all warnings being treated as errors
> make[4]: *** [scripts/Makefile.build:287: drivers/mfd/88pm860x-core.o] 
> Error 1
> make[3]: *** [scripts/Makefile.build:554: drivers/mfd] Error 2
> make[2]: *** [scripts/Makefile.build:554: drivers] Error 2
> make[1]: *** [/usr/src/linux/Makefile:2006: .] Error 2
> make: *** [Makefile:248: __sub-make] Error 2
> 
> 
> My config file is attached. I always build with CONFIG_WERROR=y (same as 
> I do in all of my regular test builds of Greg's stable-RC releases).

I do too; I'm pretty surprised that that the build robots didn't catch this.

> 
> I'm not a Kernel developer nor a C programmer, I only have superficial 
> knowledge of C (but I love to test and to tinker), so I don't quite 
> understand this warning/error message. Becauses some lines below, the 
> node variable is used as a paramter to the of_fwnode_handle macro (from 
> include/linux/of.h):
> 
>          irq_domain_create_legacy(of_fwnode_handle(node), nr_irqs, chip- 
>  >irq_base, 0,
>                                   &pm860x_irq_domain_ops, chip);
> 
> Does that not count as variable usage to the compiler? 
It's not because there is a macro when CONFIG_OF is not defined that 
assigns it as NULL.  So to the compiler there is no variable use.

> Digging in 
> somewhat deeper, I found that probably the patch from [1] is missing in 
> 6.16 and should have been included?!

It was sent during the merge window, it's not a surprise that it wasn't 
picked up.  I just sent it in case they had a chance to grab it because 
not being able to compile with CONFIG_WERROR means other things can more 
easily get missed too.

> 
> When I apply that patch, my build succeeds.
> 
> [1]: https://lore.kernel.org/all/20250602201008.1850418-1- 
> superm1@kernel.org/
> 
> 
> Beste Grüße,
> Peter Schneider
> 


