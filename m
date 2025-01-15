Return-Path: <linux-pm+bounces-20484-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 403BBA1235F
	for <lists+linux-pm@lfdr.de>; Wed, 15 Jan 2025 13:01:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 633F8162D71
	for <lists+linux-pm@lfdr.de>; Wed, 15 Jan 2025 12:01:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 604C82475DB;
	Wed, 15 Jan 2025 12:00:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=r-ricci.it header.i=@r-ricci.it header.b="cL2KtTEG"
X-Original-To: linux-pm@vger.kernel.org
Received: from out-173.mta0.migadu.com (out-173.mta0.migadu.com [91.218.175.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DF312475D0
	for <linux-pm@vger.kernel.org>; Wed, 15 Jan 2025 12:00:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736942459; cv=none; b=HnXauBc0PVegndE1q/wzU877GAI/v3gUXTQHiqmV7Xxim3X8NLuOEePJ0aSNMIsgvq/7La+GsRZlRRuFs3hC/5TqHs1dVQxTyNiWG+TedSdzhnEDKOl/BTZ7Fbe2Ap0P73jZTrh48ZnrySHey1L4YLP3eyjq2Sc/wMYQJiQRDhc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736942459; c=relaxed/simple;
	bh=60r/GbavV6jjAAcCPMGG8G1xsMsyNtrDaJlgTkzL+v8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dpwBlNaGnwhH7o9p5q/S3gNhaSgv6vCX1ZRfNX03ev61OnQlxuYJh8N65NBAQCnwqFxGr0kzsGQqEguaq/elfk17jXSfHscB9A874XHUsLHL5GGw6GU/TIKd5ii2asQpGEEOhQTBcIlIJBO+WdzzGQIzlgUZfF1OMQKoKftWUZI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=r-ricci.it; spf=pass smtp.mailfrom=r-ricci.it; dkim=pass (2048-bit key) header.d=r-ricci.it header.i=@r-ricci.it header.b=cL2KtTEG; arc=none smtp.client-ip=91.218.175.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=r-ricci.it
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=r-ricci.it
Date: Wed, 15 Jan 2025 13:00:45 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=r-ricci.it; s=key1;
	t=1736942450;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=XSA5fxZb1Zqp8xGb+AoSG7h9EPnLoDgiYKVD066+ghk=;
	b=cL2KtTEGF8cCgbVf9/IXVqeIDUuKYS3WSL6t4mtky6ztvJolDkxN0g4J4CN+uM+x03p08Q
	8G0y9sKcOf7/Wn74d0tFANZOtIjMq3zbEi6Ihp4E90+KjyxnzF2IY0d2775pAAf0lpqYeG
	X34r6ag2vqM9egoICBJ+WtqhEX6IclrWlRCb7ZrpCdudK60iKsMm4g2kBVl1WC1hD6qL/j
	ioWq7/QDR0hShTchppAb+yWf8iMa4E6ESubD5Iq6m67C/eaZrtbC2HLFN/UXwjoThhtaKp
	SHRCpAAB0tB80B+uPcmyZ1oPQkXPl6oAzc2SSW6ZOH/O+YDfNu/2/VeT2nNurQ==
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Roberto Ricci <io@r-ricci.it>
To: Baoquan He <bhe@redhat.com>
Cc: ebiederm@xmission.com, rafael@kernel.org, pavel@ucw.cz,
	ytcoode@gmail.com, kexec@lists.infradead.org,
	linux-pm@vger.kernel.org, akpm@linux-foundation.org,
	regressions@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [REGRESSION] Kernel booted via kexec fails to resume from
 hibernation
Message-ID: <Z4ejbdJr87V3IwV8@desktop0a>
References: <Z4WFjBVHpndct7br@desktop0a>
 <Z4Zjmva-pLbLjtQv@desktop0a>
 <Z4czuvi2BiNlDWPP@MiWiFi-R3L-srv>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z4czuvi2BiNlDWPP@MiWiFi-R3L-srv>
X-Migadu-Flow: FLOW_OUT

On 2025-01-15 Wed 12:04:10 +0800, Baoquan He wrote:
> On 01/14/25 at 02:16pm, Roberto Ricci wrote:
> > On 2025-01-13 Mon 22:28:48 +0100, Roberto Ricci wrote:
> > > I can reproduce this with kernel 6.13-rc7 in a qemu x86_64 virtual machine
> > > running Void Linux, with the following commands:
> > > 
> > > ```
> > > # kexec -l /boot/vmlinuz-6.13.0-rc7 --initrd=/boot/initramfs-6.13.0-rc7 --reuse-cmdline
> > > # reboot
> > > # printf reboot >/sys/power/disk
> > > # printf disk >/sys/power/state
> > > ```
> > 
> > Looks like it's the kernel performing the kexec which causes the issue,
> > not the target one. E.g.: kexec-ing 6.7 from 6.13-rc7 makes resume from
> > hibernation fail; but if I kexec 6.13-rc7 from 6.7, then it works fine.
> 
> I tried the latest mainline kernel with your above command execution
> series, I didn't see the problem you reported. Can you try kexec from
> 6.7 to 6.7 or something like that and try to bisect a specific criminal
> commit?

As I mentioned in my initial report, only versions >= 6.8 are affected.
Anyway, I actually was kexec-ing the same kernel which was already booted
when I did the bisection which pointed to 18d565ea95fe.

> As for below commit, it seems not a suspect.
> 18d565ea95fe ("kexec_file: fix incorrect temp_start value in locate_mem_hole_top_down()")
> 
> If possible, can you revert below two commits altogether to have a try?
> I am not sure if they caused the problem.
> 
> 18d565ea95fe kexec_file: fix incorrect temp_start value in locate_mem_hole_top_down()
> 816d334afa85 kexec: modify the meaning of the end parameter in kimage_is_destination_range()

Reverting these two commits does not fix things on v6.13-rc7.

But I have found that reverting 18d565ea95fe fixes the issue for kernels
up to 6.11. Since 6.12 this is not enough. So I'm doing another bisection.
I will report results maybe later today.

