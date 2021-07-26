Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E01A93D5CE3
	for <lists+linux-pm@lfdr.de>; Mon, 26 Jul 2021 17:24:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234419AbhGZOoI (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 26 Jul 2021 10:44:08 -0400
Received: from mail.kernel.org ([198.145.29.99]:34604 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234355AbhGZOoI (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Mon, 26 Jul 2021 10:44:08 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 5547460E08;
        Mon, 26 Jul 2021 15:24:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1627313077;
        bh=99cfRI4n8mXdOBrLYIVKS49f+F3CgtE4szaa0DvKQbg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=JeXcRRS+acxAoiHCFMk9zlVvkxSQS0EdN2TgTI6IaK6mdzkmELykQStO9GwoRPznr
         VC0gwk//GfhyewE6FrWJkO4neA257W9oVkovk4t9eQgJC6p3KZJxTn5b7zhRl27t8p
         XvWjZz8jb6P5EPGSDpvHZEpvEVOY7b6iSX2qIo6wVd2l8/QFkftcBHkqybVzvEIHJN
         EVXpuMU4ceNLJ0DTz6ZYH0owwQ3HFt8UYiWAqWH+FLRyKglJDYzP/6zidz4TWJLa1c
         7qgQxuVVLOtdoRHiw3ipuJxv47krvflZo5abR9Nw5PdWPuuV42/aMpkWRU28bmlJxQ
         aJLbBfkpfjHJQ==
Date:   Mon, 26 Jul 2021 08:24:34 -0700
From:   Keith Busch <kbusch@kernel.org>
To:     shiva.linuxworks@gmail.com
Cc:     rjw@rjwysocki.net, pavel@ucw.cz, len.brown@intel.com,
        linux-pm@vger.kernel.org, axboe@fb.com, hch@lst.de,
        sagi@grimberg.me, linux-nvme@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Shivamurthy Shastri <sshivamurthy@micron.com>
Subject: Re: [PATCH v2 0/2] Abrupt Shutdown for NVMe SSD
Message-ID: <20210726152434.GA2024939@dhcp-10-100-145-180.wdc.com>
References: <20210726132223.1661-1-sshivamurthy@micron.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210726132223.1661-1-sshivamurthy@micron.com>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Mon, Jul 26, 2021 at 01:22:21PM +0000, shiva.linuxworks@gmail.com wrote:
> In the platform with a limited backup power supply, devices like NVMe
> SSD does unsafe shutdown.
> 
> These two patches address this issue by adding a power loss imminent
> flag. The platform will enable the power loss imminent flag if the
> platform's power is running on the limited backup power supply. During
> the shutdown, the driver checks this information and pwerforms the
> abrupt shutdown.

I think the pm framework and nvme usage are ok, but you need a platform
specific caller to set the new power loss flag before this should be
considered, otherwise this is just unreachable code.
