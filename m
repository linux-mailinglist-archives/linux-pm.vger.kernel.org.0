Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A1155E943F
	for <lists+linux-pm@lfdr.de>; Wed, 30 Oct 2019 01:53:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726506AbfJ3Axg (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 29 Oct 2019 20:53:36 -0400
Received: from mail.kernel.org ([198.145.29.99]:51598 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726076AbfJ3Axf (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Tue, 29 Oct 2019 20:53:35 -0400
Received: from redsun51.ssa.fujisawa.hgst.com (unknown [199.255.47.7])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A898320862;
        Wed, 30 Oct 2019 00:53:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1572396815;
        bh=CiN8+uBGBBbTGDNsi2Hq3KM6FLtlK9d7Wva0KwIc9AE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=f6X+5fgpK5x5cJvSZ6A3HfkeIYsIcBMFlK4k1FonoDO9lwlgatFeb/YO50HwKQmVm
         jrAvuv3CwkdD2EaURvLvWNkF9SyJZwUc0j+9XJkNAdje7SEH/dVmF7w0FUcO3mKiVv
         pZXTiaQxmaw+BxhX3CIAZkdPj5V3mvHWxRnyL7S0=
Date:   Wed, 30 Oct 2019 09:53:27 +0900
From:   Keith Busch <kbusch@kernel.org>
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     Jens Axboe <axboe@fb.com>, Christoph Hellwig <hch@lst.de>,
        Sagi Grimberg <sagi@grimberg.me>, linux-kernel@vger.kernel.org,
        linux-nvme@lists.infradead.org,
        Akinobu Mita <akinobu.mita@gmail.com>,
        linux-pm@vger.kernel.org, Chris Healy <cphealy@gmail.com>
Subject: Re: [PATCH v2] nvme: Add hardware monitoring support
Message-ID: <20191030005327.GC15332@redsun51.ssa.fujisawa.hgst.com>
References: <20191029223214.18889-1-linux@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20191029223214.18889-1-linux@roeck-us.net>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Tue, Oct 29, 2019 at 03:32:14PM -0700, Guenter Roeck wrote:
> nvme devices report temperature information in the controller information
> (for limits) and in the smart log. Currently, the only means to retrieve
> this information is the nvme command line interface, which requires
> super-user privileges.
> 
> At the same time, it would be desirable to use NVME temperature information
> for thermal control.
> 
> This patch adds support to read NVME temperatures from the kernel using the
> hwmon API and adds temperature zones for NVME drives. The thermal subsystem
> can use this information to set thermal policies, and userspace can access
> it using libsensors and/or the "sensors" command.
> 
> Example output from the "sensors" command:
> 
> nvme0-pci-0100
> Adapter: PCI adapter
> Composite:    +39.0°C  (high = +85.0°C, crit = +85.0°C)
> Sensor 1:     +39.0°C
> Sensor 2:     +41.0°C
> 
> Signed-off-by: Guenter Roeck <linux@roeck-us.net>

This looks fine to me, but I'll wait a few more days to see if there are
any additional comments..
