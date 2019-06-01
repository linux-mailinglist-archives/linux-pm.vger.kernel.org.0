Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 214BB31AAF
	for <lists+linux-pm@lfdr.de>; Sat,  1 Jun 2019 11:04:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726058AbfFAJES (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sat, 1 Jun 2019 05:04:18 -0400
Received: from verein.lst.de ([213.95.11.211]:45981 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725899AbfFAJES (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Sat, 1 Jun 2019 05:04:18 -0400
Received: by newverein.lst.de (Postfix, from userid 2407)
        id 7540C68AFE; Sat,  1 Jun 2019 11:03:53 +0200 (CEST)
Date:   Sat, 1 Jun 2019 11:03:53 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Akinobu Mita <akinobu.mita@gmail.com>
Cc:     linux-nvme@lists.infradead.org, linux-pm@vger.kernel.org,
        Zhang Rui <rui.zhang@intel.com>,
        Eduardo Valentin <edubezval@gmail.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Keith Busch <keith.busch@intel.com>, Jens Axboe <axboe@fb.com>,
        Christoph Hellwig <hch@lst.de>,
        Sagi Grimberg <sagi@grimberg.me>,
        Minwoo Im <minwoo.im.dev@gmail.com>,
        Kenneth Heitke <kenneth.heitke@intel.com>,
        Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
Subject: Re: [PATCH v3 3/3] nvme: notify thermal framework when temperature
 threshold events occur
Message-ID: <20190601090353.GE6453@lst.de>
References: <1558888143-5121-1-git-send-email-akinobu.mita@gmail.com> <1558888143-5121-4-git-send-email-akinobu.mita@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1558888143-5121-4-git-send-email-akinobu.mita@gmail.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

So before we allowed userspace to get smart AEN notifications through
uevent, and would expect userspace to clear the AEN.  I think this
could at least potentially break existing userspace by now doing that
in kernel space.
