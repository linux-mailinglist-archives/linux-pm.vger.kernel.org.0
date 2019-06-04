Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6D63B34030
	for <lists+linux-pm@lfdr.de>; Tue,  4 Jun 2019 09:32:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726713AbfFDHcz (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 4 Jun 2019 03:32:55 -0400
Received: from verein.lst.de ([213.95.11.211]:33841 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726589AbfFDHcz (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Tue, 4 Jun 2019 03:32:55 -0400
Received: by newverein.lst.de (Postfix, from userid 2407)
        id 3F56D68B02; Tue,  4 Jun 2019 09:32:30 +0200 (CEST)
Date:   Tue, 4 Jun 2019 09:32:29 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Akinobu Mita <akinobu.mita@gmail.com>
Cc:     Christoph Hellwig <hch@lst.de>, linux-nvme@lists.infradead.org,
        linux-pm@vger.kernel.org, Zhang Rui <rui.zhang@intel.com>,
        Eduardo Valentin <edubezval@gmail.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Keith Busch <keith.busch@intel.com>, Jens Axboe <axboe@fb.com>,
        Sagi Grimberg <sagi@grimberg.me>,
        Minwoo Im <minwoo.im.dev@gmail.com>,
        Kenneth Heitke <kenneth.heitke@intel.com>,
        Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
Subject: Re: [PATCH v3 3/3] nvme: notify thermal framework when temperature
 threshold events occur
Message-ID: <20190604073229.GI15680@lst.de>
References: <1558888143-5121-1-git-send-email-akinobu.mita@gmail.com> <1558888143-5121-4-git-send-email-akinobu.mita@gmail.com> <20190601090353.GE6453@lst.de> <CAC5umyg_nDjtLyJM8iNF5f+YdQ6EG+G5ks-uFqu_VFiX2=e=qQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAC5umyg_nDjtLyJM8iNF5f+YdQ6EG+G5ks-uFqu_VFiX2=e=qQ@mail.gmail.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Sun, Jun 02, 2019 at 10:46:12PM +0900, Akinobu Mita wrote:
> 2019年6月1日(土) 18:04 Christoph Hellwig <hch@lst.de>:
> >
> > So before we allowed userspace to get smart AEN notifications through
> > uevent, and would expect userspace to clear the AEN.  I think this
> > could at least potentially break existing userspace by now doing that
> > in kernel space.
> 
> This change unconditionally sets NVME_SMART_CRIT_TEMPERATURE flag in
> nvme_enable_aen(), it could be problematic for existing userspace.
> So it's better to provide a knob to enable/disable the event notification
> and we can utilize get_mode()/set_mode() in the thermal_zone_device_ops.
> 
> Other than that, this change doesn't remove ctrl->aen_result, so existing
> userspace still receives NVME_AEN=* uevents.

And that is the problem.  Because for notifications we expect userspace to
read the log page and clear the event, while we are not doing it in kernel
space.
