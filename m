Return-Path: <linux-pm+bounces-20534-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BA23DA13715
	for <lists+linux-pm@lfdr.de>; Thu, 16 Jan 2025 10:54:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4824C3A3868
	for <lists+linux-pm@lfdr.de>; Thu, 16 Jan 2025 09:54:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1EAB1A0731;
	Thu, 16 Jan 2025 09:54:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="E+IJUWpc"
X-Original-To: linux-pm@vger.kernel.org
Received: from out-178.mta1.migadu.com (out-178.mta1.migadu.com [95.215.58.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 591B8156C72
	for <linux-pm@vger.kernel.org>; Thu, 16 Jan 2025 09:54:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737021281; cv=none; b=ceRC/Mb0Y+igggd5iRcVelgpPecx2wvadXmp67ewBS1Mx1I5eR4wP8Cne/akHf6P3LFiCPBEmyNPpsYVLXpwNPNUzu4RsWIffQZ7nrtY27Av4dvppkiOFhn4R+XYPe0ewjfEbbfDlXTBc8kO0Q5LtB9u+xOEnC4kmZrrbNxblfI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737021281; c=relaxed/simple;
	bh=BQPDSFu2aoj60XGPsdX3oXLw73hvgE/qF6qgY60PGig=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tyvaclgrNM3vcIehl2Ijan4zYqOkft3EEFlIKKW49HRKRmx5kJVWPA/fIrfxOPwNUB9pMx0U2WZw53JqN72f9Rhi6d0/9+Oa9p7TdJZ8xwd1AJJYzdH+5JqisS68BfQWepuuPbupMlSuVtmHnqIfexr6vn+sKk3N+/mlaycSGaI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=E+IJUWpc; arc=none smtp.client-ip=95.215.58.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1737021277;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=VwrBhC/YyMly2thWvCHHIUGKY6zNWpcaZUpIR1maiIs=;
	b=E+IJUWpc9P7SteF3+XpDFrM/2l5bhBz/AlkhN9CP2dz8Ey9xUjH67DIWZ6/LL5IcspUI97
	/CBQTCUvPVVmxZZsEaslO8ebnH7Q6Ys1uHEjkwz9OOoeEy1FTilMmdQq+Cem5zbXG9GZyo
	flw3R3kD2U4XoS6+G274KX08pq7QArw=
From: Yuntao Wang <yuntao.wang@linux.dev>
To: bhe@redhat.com
Cc: akpm@linux-foundation.org,
	ebiederm@xmission.com,
	io@r-ricci.it,
	kexec@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-pm@vger.kernel.org,
	pavel@ucw.cz,
	rafael@kernel.org,
	regressions@lists.linux.dev,
	ytcoode@gmail.com
Subject: Re: [REGRESSION] Kernel booted via kexec fails to resume from hibernation
Date: Thu, 16 Jan 2025 17:54:22 +0800
Message-ID: <20250116095422.61742-1-yuntao.wang@linux.dev>
In-Reply-To: <Z4czuvi2BiNlDWPP@MiWiFi-R3L-srv>
References: <Z4czuvi2BiNlDWPP@MiWiFi-R3L-srv>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

On Wed, 15 Jan 2025 12:04:10 +0800, Baoquan He <bhe@redhat.com> wrote:

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
> 
> As for below commit, it seems not a suspect.
> 18d565ea95fe ("kexec_file: fix incorrect temp_start value in locate_mem_hole_top_down()")
> 
> If possible, can you revert below two commits altogether to have a try?
> I am not sure if they caused the problem.
> 
> 18d565ea95fe kexec_file: fix incorrect temp_start value in locate_mem_hole_top_down()
> 816d334afa85 kexec: modify the meaning of the end parameter in kimage_is_destination_range()
> 
> Thanks
> Baoquan 

I'm sorry that my two commits caused these weird issues.

Although I'm currently unable to identify the cause of these problems,
I'm REALLY curious as to why this happened.

Hope we make some progress this time.

