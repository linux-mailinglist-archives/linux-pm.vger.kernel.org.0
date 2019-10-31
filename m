Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 27FBAEB174
	for <lists+linux-pm@lfdr.de>; Thu, 31 Oct 2019 14:46:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727549AbfJaNqp (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 31 Oct 2019 09:46:45 -0400
Received: from verein.lst.de ([213.95.11.211]:51093 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727502AbfJaNqp (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Thu, 31 Oct 2019 09:46:45 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id DC96E68C65; Thu, 31 Oct 2019 14:46:42 +0100 (CET)
Date:   Thu, 31 Oct 2019 14:46:42 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     Christoph Hellwig <hch@lst.de>,
        Akinobu Mita <akinobu.mita@gmail.com>,
        Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@fb.com>,
        Sagi Grimberg <sagi@grimberg.me>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-nvme@lists.infradead.org,
        Linux PM <linux-pm@vger.kernel.org>,
        Chris Healy <cphealy@gmail.com>
Subject: Re: [PATCH v2] nvme: Add hardware monitoring support
Message-ID: <20191031134642.GC4763@lst.de>
References: <20191029223214.18889-1-linux@roeck-us.net> <CAC5umyhc=6yULiLwXu65VDvDk2cBiF0R9O39B-T5ftapJfj0rQ@mail.gmail.com> <20191030140511.GA14252@lst.de> <2931487e-2720-fd42-fda0-e47cf89c90c9@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2931487e-2720-fd42-fda0-e47cf89c90c9@roeck-us.net>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Wed, Oct 30, 2019 at 07:54:47PM -0700, Guenter Roeck wrote:
> On 10/30/19 7:05 AM, Christoph Hellwig wrote:
>> On Wed, Oct 30, 2019 at 08:16:48PM +0900, Akinobu Mita wrote:
>>> The nvme_init_identify() can be called multiple time in nvme ctrl's
>>> lifetime (e.g 'nvme reset /dev/nvme*' or suspend/resume paths), so
>>> should we need to prevent nvme_hwmon_init() from registering hwmon
>>> device more than twice?
>>>
>>> In the nvme thermal zone patchset[1], thernal zone is registered in
>>> nvme_init_identify and unregistered in nvme_stop_ctrl().
>>
>> So Guenter said above the thermal subsystem could use the information
>> from hwmon as well.  Does this mean this patch would solve your needs
>> as well?
>>
> Depends on the requirements. Unlike hwmon/iio, we don't have clear
> guidelines describing when thermal vs. hwmon would be a better choice.
> There is some interconnect between thermal and hwmon, but quite often
> it is a one-way street (hwmon devices can easily register thermal
> zones, for thermal zone devices it is a bit more difficult to register
> associated hwmon devices).

I'd like to hear from Akinobu-san if this also solves the thermal zone
use case.  If so I'd be much happier as we at least solve two use cases
with one patch.
