Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0B6F3EB170
	for <lists+linux-pm@lfdr.de>; Thu, 31 Oct 2019 14:45:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727569AbfJaNpx (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 31 Oct 2019 09:45:53 -0400
Received: from verein.lst.de ([213.95.11.211]:51082 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727549AbfJaNpx (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Thu, 31 Oct 2019 09:45:53 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 9B60A68BE1; Thu, 31 Oct 2019 14:45:49 +0100 (CET)
Date:   Thu, 31 Oct 2019 14:45:49 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     Akinobu Mita <akinobu.mita@gmail.com>,
        Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@fb.com>,
        Christoph Hellwig <hch@lst.de>,
        Sagi Grimberg <sagi@grimberg.me>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-nvme@lists.infradead.org,
        Linux PM <linux-pm@vger.kernel.org>,
        Chris Healy <cphealy@gmail.com>
Subject: Re: [PATCH v2] nvme: Add hardware monitoring support
Message-ID: <20191031134549.GB4763@lst.de>
References: <20191029223214.18889-1-linux@roeck-us.net> <CAC5umyhc=6yULiLwXu65VDvDk2cBiF0R9O39B-T5ftapJfj0rQ@mail.gmail.com> <e62b6763-0d1b-3359-6d3b-cb31e96bb862@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e62b6763-0d1b-3359-6d3b-cb31e96bb862@roeck-us.net>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Wed, Oct 30, 2019 at 07:20:37PM -0700, Guenter Roeck wrote:
>> The nvme_init_identify() can be called multiple time in nvme ctrl's
>> lifetime (e.g 'nvme reset /dev/nvme*' or suspend/resume paths), so
>> should we need to prevent nvme_hwmon_init() from registering hwmon
>> device more than twice?
>>
>> In the nvme thermal zone patchset[1], thernal zone is registered in
>> nvme_init_identify and unregistered in nvme_stop_ctrl().
>>
>
> Doesn't that mean that the initialization should happen in nvme_start_ctrl()
> and not here ?

I think calling it from nvme_init_identify is fine, it just needs to
be in the "if (!ctrl->identified)" section of that function.
