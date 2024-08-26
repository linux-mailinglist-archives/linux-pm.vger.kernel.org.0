Return-Path: <linux-pm+bounces-12867-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 81CA695E72E
	for <lists+linux-pm@lfdr.de>; Mon, 26 Aug 2024 05:06:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B07DD1C20FC0
	for <lists+linux-pm@lfdr.de>; Mon, 26 Aug 2024 03:06:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 894FA22071;
	Mon, 26 Aug 2024 03:06:55 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from bmailout1.hostsharing.net (bmailout1.hostsharing.net [83.223.95.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A828443D;
	Mon, 26 Aug 2024 03:06:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=83.223.95.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724641615; cv=none; b=qlR6wWQsRTRvyFF7Bt5ta0FImX4kZ75GIR8A1U7UuGSiHIMY2NZTYBC4JnCiUJ3zBz3vVV/Q6PdLQC4Z05R8N/+itibo9tSNXJoV3q4MyIsoTM6AmiICJ7Tf+NpwvKgLUf4SbmndiNpgHmzoUz6WY2Lt9HwIwUQxtNnFqwbiKw8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724641615; c=relaxed/simple;
	bh=+PLulXwt0k1tJ7Qzo36D8hm7d8wBUiQ+9Aj7EPQ/x8o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=n2G40PglFOC1kjNAueGuf4+Z+YFNcgk4bIcFhGVvV3vmopEN+xyhN/o/+NymGo00MhqF0WsWrliRTDmgP24piTArUF3NEiXapMDw2XJNOjqXc8fG9RlxYpkoW+uV42tWLglBS7XquoUEE10oZCu7YFVhiJCnZFtgz5DM/MLiRb0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de; spf=none smtp.mailfrom=h08.hostsharing.net; arc=none smtp.client-ip=83.223.95.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=h08.hostsharing.net
Received: from h08.hostsharing.net (h08.hostsharing.net [IPv6:2a01:37:1000::53df:5f1c:0])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256
	 client-signature RSA-PSS (4096 bits) client-digest SHA256)
	(Client CN "*.hostsharing.net", Issuer "RapidSSL TLS RSA CA G1" (verified OK))
	by bmailout1.hostsharing.net (Postfix) with ESMTPS id C27EB300000A0;
	Mon, 26 Aug 2024 05:06:47 +0200 (CEST)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
	id 9F51F35623B; Mon, 26 Aug 2024 05:06:47 +0200 (CEST)
Date: Mon, 26 Aug 2024 05:06:47 +0200
From: Lukas Wunner <lukas@wunner.de>
To: Kenneth Crudup <kenny@panix.com>,
	Mika Westerberg <mika.westerberg@linux.intel.com>,
	linux-usb@vger.kernel.org
Cc: "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
	linux-usb@vger.kernel.org
Subject: Re: My Dell XPS-9320 (kernel 6.10.x, et al.) doesn't detect
 Thunderbolt additions when coming out of suspend or hibernate
Message-ID: <ZsvxR-dQAZtwNi0g@wunner.de>
References: <c9feac08-a1fd-4e03-a708-1046793443db@panix.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c9feac08-a1fd-4e03-a708-1046793443db@panix.com>

[cc += Mika, linux-usb]

On Wed, Aug 21, 2024 at 03:05:59PM -0700, Kenneth Crudup wrote:
> Subject says it all, but to recap my laptop doesn't detect Thunderbolt
> topology changes when resuming or coming out of hibernate; i.e., the only
> time a TB topology change happens is if a TB cable is disconnected while
> suspended or hibernated, but if one is connected, or a different TB setup
> altogether is connected when the system resumes it doesn't notice the
> topology change until I disconnect and reconnect.
> 
> I'm currently running 6.10.6, but this has been going on for a while.
> 
> [    0.000000] DMI: Dell Inc. XPS 9320/0KNXGD, BIOS 2.12.0 04/11/2024
> ...
> [    0.136807] smpboot: CPU0: 12th Gen Intel(R) Core(TM) i7-1280P (family:
> 0x6, model: 0x9a, stepping: 0x3)

This commit went into v6.11-rc1 and will at least detect replacement
of PCI devices (to a certain extent):

https://git.kernel.org/linus/9d573d19547b

However PCI is layered on top of (tunneled through) the Thunderbolt
switching fabric and that's where the real problem likely is here.

Maybe you can open a bug at bugzilla.kernel.org and attach full dmesg
and lspci -vvv output in the working case (device attachment at runtime)
and the non-working case (device attachment during system sleep).

Does the machine wake up if you attach devices during system sleep?
Are you suspending to ACPI S0ix, S3 or S4?

Thanks,

Lukas

