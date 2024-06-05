Return-Path: <linux-pm+bounces-8621-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A4878FC7FD
	for <lists+linux-pm@lfdr.de>; Wed,  5 Jun 2024 11:38:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CC8041F21AA3
	for <lists+linux-pm@lfdr.de>; Wed,  5 Jun 2024 09:38:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE586192B81;
	Wed,  5 Jun 2024 09:34:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="VKIh4okJ"
X-Original-To: linux-pm@vger.kernel.org
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4A1F18FDDD;
	Wed,  5 Jun 2024 09:34:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717580043; cv=none; b=CJcNCJYDrmllfHL6tSwynrr6igXjwN2XPlK6baLoDMGPmc9ChwFLXgNukED3LfJgFN48RirRAhPm0PNmMDBwilasccT6NCDfx3TrahBTE+juASyRn7Mx4UyoTgQFT8vZs2/p0a6T1hJvybpmLyvl09WS1/iWbOdfmFzKxajP4Jg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717580043; c=relaxed/simple;
	bh=o3s3eeCGuDiHinRfMmQ6kt6dHWRjaZ0xd0fUvfgcYWs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=C0PnWgXPunl/HgRREFkcS5qRlLfO3I5qfIgQV7sZ1cGx3oOTEOzx1x9bJJE3Lm3d3dN1oWu7P9I0QMZgSeYGiz8uQGlOMSC1wgRPB52k8FOuZLX4L40K9xKxEQZQVIbLLYvHEsyn11fPf3JQqLKQLCbVIoHn29TxYg5qqg63KWI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net; spf=pass smtp.mailfrom=weissschuh.net; dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b=VKIh4okJ; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weissschuh.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1717580039;
	bh=o3s3eeCGuDiHinRfMmQ6kt6dHWRjaZ0xd0fUvfgcYWs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=VKIh4okJIDtWmWBa7iTGOvpbQKYWknJRrrEAEZ1ZPvZ8/fUCJiClTbmuRqQV2xWlD
	 fClu3im9eqq4vN0HSAl9XCTAaUBg4Mj/B6QLlyI0uu+WOZ8NfJUzHDt4ToePa4VEsu
	 uGq9TycDfo/HLCuKTnPFbZsfBAUcNM2KImuxDrmo=
Date: Wed, 5 Jun 2024 11:33:58 +0200
From: Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <linux@weissschuh.net>
To: Dustin Howett <dustin@howett.net>
Cc: Benson Leung <bleung@chromium.org>, 
	Guenter Roeck <groeck@chromium.org>, Sebastian Reichel <sre@kernel.org>, Lee Jones <lee@kernel.org>, 
	chrome-platform@lists.linux.dev, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, 
	Mario Limonciello <mario.limonciello@amd.com>, Stephen Horvath <s.horvath@outlook.com.au>, 
	Rajas Paranjpe <paranjperajas@gmail.com>
Subject: Re: [PATCH v2 0/3] ChromeOS Embedded Controller charge control driver
Message-ID: <a527a3fd-1458-43cc-aac0-0b360beeb349@t-8ch.de>
References: <20240528-cros_ec-charge-control-v2-0-81fb27e1cff4@weissschuh.net>
 <CA+BfgNJByawxkZukaCXYcmOo_K9aQ0W1x8B6Y+Hyg_fZaJ4axw@mail.gmail.com>
 <5baf3caf-dc09-4829-96db-2666fc902710@t-8ch.de>
 <CA+BfgN+LE3YyF3te4m8sWbtH85tU+ERUDW7YR_BFecusVTAWWw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CA+BfgN+LE3YyF3te4m8sWbtH85tU+ERUDW7YR_BFecusVTAWWw@mail.gmail.com>

On 2024-06-04 20:27:57+0000, Dustin Howett wrote:
> On Mon, Jun 3, 2024 at 3:59 PM Thomas Weißschuh <linux@weissschuh.net> wrote:
> >
> > Can you try disabling all of the Framework-specific charge control
> > settings and test again?
> > Probably the different, disparate logics in the Framework ECs are
> > conflicting with each other.
> 
> Fascinating! This board does indeed support charge limiting through
> both interfaces. It looks like the most recently set one wins for a
> time.

If it is the most recent one, shouldn't the driver have worked?
What does "for a time" mean?
I'm using only the upstream EC command and that seems to work fine.

> The UEFI setup utility only sets the framework-specific charge limit value.
> 
> We should probably find some way to converge them, for all of the
> supported Framework Laptop programs.

In the long term, Framework should align their implementation with
upstream CrOS EC and either drop their custom command or make it a thin
wrapper around the normal the upstream command.

(As you are familiar with EC programming maybe you want to tackle this?)

Until then I think we can detect at probe-time if the Framework APIs are
available and use them to disable the Framework-specific mechanism.
Then the CrOS EC commands should be usable.

The drawback is, that userspace using the Framework APIs will break
the driver. That userspace would need to migrate to the standard UAPI.

Also the settings set in the firmware would be ignored at that point.

I don't want to use the functionality of the Framework command because
it's less featureful and I really hope it will go away at some point.

