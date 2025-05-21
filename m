Return-Path: <linux-pm+bounces-27449-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A4397ABF27A
	for <lists+linux-pm@lfdr.de>; Wed, 21 May 2025 13:11:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 762F33A2DD8
	for <lists+linux-pm@lfdr.de>; Wed, 21 May 2025 11:11:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF83E262800;
	Wed, 21 May 2025 11:11:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="C3wGx23I"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C390E2609DB;
	Wed, 21 May 2025 11:11:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747825878; cv=none; b=DFDe8130lZg9JTxJa4XBUgWOTSm0UxU5iPXC5YjWWXmW1fsGBaKB0/e06UeSHIbe3qEuQKzqQXBt6db7sCVR5bcJV+tTP+P7mfzRcdZxSgiOziKbO0m4+wFdxdLFReTSbn58wavvcLIcaXsqEV0CAoQHwAwWx8FIeSAcQ76qilw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747825878; c=relaxed/simple;
	bh=QKalJhRWAYNTqYRsDY84n12XM0NIIzFxBP9AFKFTh8s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PLs3pq66VxH7wk5bbnw38NS1HS6uUghzQ276A/vSo3g6inUUXoDIbt7vEkUQ3bpgHfJMu0HPjp9DvLty1eJU5O4MqqHUDdMCc2t0d7FWdHyG9UNIoEF4p64+5agVEevV8M4bGODIRJrCQ3IIhalfh1Z/JL2pAHCc1+7rH1BHdjY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=C3wGx23I; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C88F7C4CEEF;
	Wed, 21 May 2025 11:11:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1747825877;
	bh=QKalJhRWAYNTqYRsDY84n12XM0NIIzFxBP9AFKFTh8s=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=C3wGx23ITn4mc1GJo9GZD65A3xKcMh4aCNG9nBdTFDEEY5A9QHOkFqIjJQ6LOFhTT
	 YQ/EdwUOrlQcKa5n4xLsZaL1IUz4BUis0BAgWAkLOyu6+hsqO3ZPk610x59kT6oyOB
	 F5gMHa4iuEa+Z3sRk/xsjIbwKO6oapB7qQazE60w=
Date: Wed, 21 May 2025 13:11:14 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Linux PM <linux-pm@vger.kernel.org>,
	LKML <linux-kernel@vger.kernel.org>,
	Jon Hunter <jonathanh@nvidia.com>,
	Saravana Kannan <saravanak@google.com>,
	Heikki Krogerus <heikki.krogerus@linux.intel.com>,
	linux-usb@vger.kernel.org
Subject: Re: [PATCH v1] ucsi_ccg: Disable async suspend in ucsi_ccg_probe()
Message-ID: <2025052158-venture-bottling-a3f8@gregkh>
References: <6180608.lOV4Wx5bFT@rjwysocki.net>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6180608.lOV4Wx5bFT@rjwysocki.net>

On Mon, May 12, 2025 at 03:26:53PM +0200, Rafael J. Wysocki wrote:
> From: Jon Hunter <jonathanh@nvidia.com>
> 
> Commit aa7a9275ab81 ("PM: sleep: Suspend async parents after suspending
> children") had triggered a suspend issue on Tegra boards because it had
> reordered the syspend of devices with async suspend enabled with respect
> to some other devices.  Specifically, the devices with async suspend
> enabled that have no children are now suspended before any other devices
> unless there are device links pointing to them as suppliers.
> 
> The investigation that followed the failure report uncovered that async
> suspend was enabled for the cypd4226 device that was a Type-C controller
> with a dependency on USB PHY and it turned out that disabling async
> suspend for that device made the issue go away.  Since async suspend
> takes dependencies between parents and children into account as well
> as other dependencies between devices represented by device links, this
> means that the cypd4226 has a dependency on another device that is
> not represented in any form in the kernel (a "hidden" dependency), in
> which case async suspend should not be enabled for it.
> 
> Accordingly, make ucsi_ccg_probe() disable async suspend for the
> devices handled by, which covers the cypd4226 device on the Tegra
> boards as well as other devices likely to have similar "hidden"
> dependencies.
> 
> Fixes: aa7a9275ab81 ("PM: sleep: Suspend async parents after suspending children")
> Closes: https://lore.kernel.org/linux-pm/c6cd714b-b0eb-42fc-b9b5-4f5f396fb4ec@nvidia.com/
> Reported-by: Jon Hunter <jonathanh@nvidia.com>
> Tested-by: Jon Hunter <jonathanh@nvidia.com>
> Signed-off-by: Jon Hunter <jonathanh@nvidia.com>
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> ---
> 
> Commit aa7a9275ab81 is in linux-next and it has not reached the mainline yet.

I'm guessing that's in your tree, so can you take this through that?

thanks,

greg k-h

