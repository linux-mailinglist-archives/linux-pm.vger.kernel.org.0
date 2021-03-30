Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8EE4234E1F9
	for <lists+linux-pm@lfdr.de>; Tue, 30 Mar 2021 09:19:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229567AbhC3HS7 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 30 Mar 2021 03:18:59 -0400
Received: from mail.kernel.org ([198.145.29.99]:54790 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229468AbhC3HSj (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Tue, 30 Mar 2021 03:18:39 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 9B1D761935;
        Tue, 30 Mar 2021 07:18:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1617088718;
        bh=e6UPwPG74FOABGApPWCXz/djBRTKYrByDn3V+BQ9B7k=;
        h=Date:From:To:cc:Subject:In-Reply-To:References:From;
        b=I40GbXr8LjGDORwww9mOgGw971CcBoFOHTjKLw+ompdO/L3gKCpuV3D7JTMhKqtus
         BW/OmPDac0e3Pe81cAIke2EpCPFWaZr+kJar9z1jp81V8i38PChgfbnP4izK3UUm9r
         qqp8dAm5yE75rhjZEUnUXIdtJGvL/Cq5bh5zSvj/nuA2BZnYVbzi2BFIr78MQOzGLP
         8nqHQRpy8c7T/8n/Omx1UnyMQjDjsl1tuPjSH2inhGvT2DvgHUS27lCvXYpo6KfwgY
         32u7ygHHRioAFmSELh31XBBBCByxm3KEjAAcwOIAM50dNnG1GTlTu3azBexxAFReW1
         uq2c80rLKkuBw==
Date:   Tue, 30 Mar 2021 09:18:35 +0200 (CEST)
From:   Jiri Kosina <jikos@kernel.org>
To:     Hans de Goede <hdegoede@redhat.com>
cc:     Sebastian Reichel <sre@kernel.org>,
        Maximilian Luz <luzmaximilian@gmail.com>,
        Linux PM <linux-pm@vger.kernel.org>,
        linux-input <linux-input@vger.kernel.org>,
        "platform-driver-x86@vger.kernel.org" 
        <platform-driver-x86@vger.kernel.org>
Subject: Re: [GIT PULL] Immutable branch between drivers/platform/x86 and
 HID resp. drivers/power/supply due for the v5.13 merge window
In-Reply-To: <ef994907-61c7-2e0e-f26d-25b06a5dbf0f@redhat.com>
Message-ID: <nycvar.YFH.7.76.2103300918170.12405@cbobk.fhfr.pm>
References: <ef994907-61c7-2e0e-f26d-25b06a5dbf0f@redhat.com>
User-Agent: Alpine 2.21 (LSU 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Thu, 18 Mar 2021, Hans de Goede wrote:

> Hi Sebastian, Jiri,
> 
> Here is a pull-req with the drivers/platform/surface changes necessary
> as prereqs for the surface power_supply resp. HID patches which have been
> submitted to you.
> 
> Note the dependency seems to purely be a runtime/Kconfig one, so theoretically
> the patches could be merged without this, but then they cannot be compile-tested,
> since the "depends on SURFACE_AGGREGATOR_REGISTRY" then will never be true.
> 
> Regards,
> 
> Hans
> 
> 
> 
> The following changes since commit a38fd8748464831584a19438cbb3082b5a2dab15:
> 
>   Linux 5.12-rc2 (2021-03-05 17:33:41 -0800)
> 
> are available in the Git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/pdx86/platform-drivers-x86.git tags/platform-drivers-x86-surface-aggregator-v5.13-1
> 
> for you to fetch changes up to aebf0a11a8c1fb6444d1365db97f90672199a867:
> 
>   platform/surface: aggregator_registry: Add HID subsystem devices (2021-03-06 10:23:26 +0100)

Pulled into hid.git#for-5.13/surface-system-aggregator-intergration.

Thanks,

-- 
Jiri Kosina
SUSE Labs

