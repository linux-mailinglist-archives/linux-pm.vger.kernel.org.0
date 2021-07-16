Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C96053CB75F
	for <lists+linux-pm@lfdr.de>; Fri, 16 Jul 2021 14:33:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238916AbhGPMgm (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 16 Jul 2021 08:36:42 -0400
Received: from mail.kernel.org ([198.145.29.99]:41260 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232787AbhGPMgl (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Fri, 16 Jul 2021 08:36:41 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id F06BA611C1;
        Fri, 16 Jul 2021 12:33:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1626438827;
        bh=gz2n8iniBPCEVDw34i7UdhmpqPYyoxr5WKn1hgeXFFI=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=PT8Nnh/Q5uUVfmZSwbxyOTgjQJDUkDrj3YtaOT7f4irINzwamnauYE5Wn+qQZRqAx
         0SLgs/LQ6vOlYsk4l+jB4/iSsIZA86rIlUuhwg85gSzPXrG0ktaXmq1CSOFHXcave3
         TWiOZ/P+y2veOD8PgmH2+G2ou9bfKeTTgtE4gnBycqLD1OtpGJmA2yJBUcZmdu0BEM
         GnYuYUKR1sXiSUHx3D3A+GSbYZ1YeCSsAfs4MmNxMLL+eMR9XeYwGzqZkC8Jd1XzJa
         Y3ZODwAUicNao5kCaU62Da1qax9fvq1wbvlhqGcQGEmrJeS0bpZb19WteO/vrBxTf+
         6Psvbf81oKReA==
Subject: Re: [PATCH V5 1/1] misc: NOC Probe Counters
To:     Arnd Bergmann <arnd@arndb.de>, pandith.n@intel.com
Cc:     gregkh <gregkh@linuxfoundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        furong.zhou@intel.com, mgross@linux.intel.com,
        mallikarjunappa.sangannavar@intel.com,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        lakshmi.bai.raja.subramanian@intel.com,
        Linux PM list <linux-pm@vger.kernel.org>
References: <20210713065347.21554-1-pandith.n@intel.com>
 <CAK8P3a1ZYzHQTPDQP+kQH1-x6DmA70H8bJ+kE_iE4NbTs8w3vw@mail.gmail.com>
From:   Georgi Djakov <djakov@kernel.org>
Message-ID: <483da98c-b2fe-87e3-0f68-0de5b4184136@kernel.org>
Date:   Fri, 16 Jul 2021 15:33:41 +0300
MIME-Version: 1.0
In-Reply-To: <CAK8P3a1ZYzHQTPDQP+kQH1-x6DmA70H8bJ+kE_iE4NbTs8w3vw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Pandith,

On 13.07.21 10:22, Arnd Bergmann wrote:
> On Tue, Jul 13, 2021 at 8:54 AM <pandith.n@intel.com> wrote:
>>
>> From: Pandith N <pandith.n@intel.com>
>>
>> Add support for Network on Chip(NOC) counters. Enable features to configure
>> and capture NOC probe counters, needed for DDR bandwidth measurement. NOC
>> driver is specific to Intel Keem Bay SOC. NOC hardware counters are used
>> for DDR statistics profiling, it is not related to timers.
>> Interface details are provided in include/uapi/linux/noc_uapi.h
>>
>> Signed-off-by: Pandith N <pandith.n@intel.com>
>> Reviewed-by: Mark Gross <mgross@linux.intel.com>
> 
> I'm missing some explanation here regarding why this is not part of
> drivers/interconnect/.
> 
> I assume you have discussed this with Georgi Djakov before, but if not, then
> please do. From a very high-level perspective, I would have guessed that this
> would be part of the interconnect framework, with any user facing setup being
> either derived from the DT, or exposed through debugfs.

Thank you for the patch! We already have several drivers that support
some NXP and Qualcomm Network-On-Chip hardware, that is also based on
FlexNoC. I suspect that they also may support counters, but nobody
added that support yet. So maybe it makes sense to have this in
drivers/interconnect/.

I am wondering what is the plan for this. Who will be using the info
from this counters - is it some driver or tool? Who and how will use
the statistics? We already have some debugfs interface that shows the
current bandwidth thats being requested by users on the several ports.
Maybe we could add also information about measured bandwidth? Before
doing a detailed review on the patch, i would like to learn more about
how this and is there any specific reason for choosing ioctl interface
for this? Thanks!

> 
> (full quote below for Georgi, no further comments there)

Thank you Arnd!

BR,
Georgi



