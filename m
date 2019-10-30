Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C036AE9D19
	for <lists+linux-pm@lfdr.de>; Wed, 30 Oct 2019 15:05:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726501AbfJ3OFQ (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 30 Oct 2019 10:05:16 -0400
Received: from verein.lst.de ([213.95.11.211]:45675 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726284AbfJ3OFQ (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 30 Oct 2019 10:05:16 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id BC5D068C4E; Wed, 30 Oct 2019 15:05:11 +0100 (CET)
Date:   Wed, 30 Oct 2019 15:05:11 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Akinobu Mita <akinobu.mita@gmail.com>
Cc:     Guenter Roeck <linux@roeck-us.net>,
        Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@fb.com>,
        Christoph Hellwig <hch@lst.de>,
        Sagi Grimberg <sagi@grimberg.me>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-nvme@lists.infradead.org,
        Linux PM <linux-pm@vger.kernel.org>,
        Chris Healy <cphealy@gmail.com>
Subject: Re: [PATCH v2] nvme: Add hardware monitoring support
Message-ID: <20191030140511.GA14252@lst.de>
References: <20191029223214.18889-1-linux@roeck-us.net> <CAC5umyhc=6yULiLwXu65VDvDk2cBiF0R9O39B-T5ftapJfj0rQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAC5umyhc=6yULiLwXu65VDvDk2cBiF0R9O39B-T5ftapJfj0rQ@mail.gmail.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Wed, Oct 30, 2019 at 08:16:48PM +0900, Akinobu Mita wrote:
> The nvme_init_identify() can be called multiple time in nvme ctrl's
> lifetime (e.g 'nvme reset /dev/nvme*' or suspend/resume paths), so
> should we need to prevent nvme_hwmon_init() from registering hwmon
> device more than twice?
> 
> In the nvme thermal zone patchset[1], thernal zone is registered in
> nvme_init_identify and unregistered in nvme_stop_ctrl().

So Guenter said above the thermal subsystem could use the information
from hwmon as well.  Does this mean this patch would solve your needs
as well?
