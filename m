Return-Path: <linux-pm+bounces-20390-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id BEEBEA0C58A
	for <lists+linux-pm@lfdr.de>; Tue, 14 Jan 2025 00:19:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 682927A3AE9
	for <lists+linux-pm@lfdr.de>; Mon, 13 Jan 2025 23:18:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22CE51FA243;
	Mon, 13 Jan 2025 23:17:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="WqXOsmoJ"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC6D71FA16B;
	Mon, 13 Jan 2025 23:17:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736810271; cv=none; b=pnsPzCCnZ5WC54BgGehQjpjrJpptxr1s4by6P0ywffo+OAaC/mDfx3toiltM0XeGx4lSGFltedC9edA7cUEZrLvaDfOKmXQf2OFRaR+MbDmsQFJhWqond3ZtXaU8tlu9BKBIKnJQmhhmCxLfseDJIPb7ExcA20xELIhWWUTDh+c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736810271; c=relaxed/simple;
	bh=lpPz3KIoYsNKggLSdbQpd1eZ1ajQzwS8JiFc/wdHVME=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=tun4CyWeIYF1WTclr0/6qfxAzSNnV4yZ+3txFe5//pcQS5gHs6H2NnoQejc9JCPmD7N13rTwYz7WxKgpVCXVCra13ndJp1HPTzfGSECX3xcSvBXjXJAHO5KwQNn5iIyMQCCy4z+kGZcvS1hKOuCsAgKgaSSBtgn7ydnC6Rg+cg4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=WqXOsmoJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 28477C4CED6;
	Mon, 13 Jan 2025 23:17:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1736810270;
	bh=lpPz3KIoYsNKggLSdbQpd1eZ1ajQzwS8JiFc/wdHVME=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=WqXOsmoJUtXRUxxGx8ODSj+hKxpQo2BOAmJ5NddyCHsC7C/Hd3rkL2e0QGjizcktc
	 ThuxGqeJL/U4DDbJBHf/qIMaHf2pLngjV8lbWXWn0ugWWuEa+xhdQHXgREhhnzATDy
	 fi0I8lOigirxtjca/jrj+I3OKutr2cMZA31ctIno=
Date: Mon, 13 Jan 2025 15:17:49 -0800
From: Andrew Morton <akpm@linux-foundation.org>
To: Roberto Ricci <io@r-ricci.it>
Cc: ebiederm@xmission.com, rafael@kernel.org, pavel@ucw.cz,
 ytcoode@gmail.com, kexec@lists.infradead.org, linux-pm@vger.kernel.org,
 regressions@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [REGRESSION] Kernel booted via kexec fails to resume from
 hibernation
Message-Id: <20250113151749.b687c35e9f4c6d596449f433@linux-foundation.org>
In-Reply-To: <Z4WFjBVHpndct7br@desktop0a>
References: <Z4WFjBVHpndct7br@desktop0a>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 13 Jan 2025 22:28:44 +0100 Roberto Ricci <io@r-ricci.it> wrote:

> After rebooting the system via kexec, hibernating and rebooting the machine, this oops occurs:
> 
> ...
>
> # kexec -l /boot/vmlinuz-6.13.0-rc7 --initrd=/boot/initramfs-6.13.0-rc7 --reuse-cmdline
> # reboot
> # printf reboot >/sys/power/disk
> # printf disk >/sys/power/state
> ```
> 
> If kexec is not used, hibernation works fine.
> 
> This started happening since the 6.8 series; 6.7 works fine.
> I performed a bisection and it pointed to
> 18d565ea95fe ("kexec_file: fix incorrect temp_start value in locate_mem_hole_top_down()").
> 
> #regzbot introduced: 18d565ea95fe553f442c5bbc5050415bab3c3fa4
> 
> I will send the kernel config and dmesg in replies to this email.

Thanks.  Are you able to confirm that reverting 18d565ea95fe fixes things?

