Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 55BABE6D63
	for <lists+linux-pm@lfdr.de>; Mon, 28 Oct 2019 08:39:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733004AbfJ1Hj4 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 28 Oct 2019 03:39:56 -0400
Received: from verein.lst.de ([213.95.11.211]:33113 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730952AbfJ1Hj4 (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Mon, 28 Oct 2019 03:39:56 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 480AA68C65; Mon, 28 Oct 2019 08:39:53 +0100 (CET)
Date:   Mon, 28 Oct 2019 08:39:53 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     Keith Busch <kbusch@kernel.org>,
        Chris Healy <Chris.Healy@zii.aero>, Jens Axboe <axboe@fb.com>,
        Christoph Hellwig <hch@lst.de>,
        Sagi Grimberg <sagi@grimberg.me>, linux-kernel@vger.kernel.org,
        linux-nvme@lists.infradead.org,
        Akinobu Mita <akinobu.mita@gmail.com>, linux-pm@vger.kernel.org
Subject: Re: [PATCH] nvme: Add hardware monitoring support
Message-ID: <20191028073953.GA20443@lst.de>
References: <20191028024156.23964-1-linux@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191028024156.23964-1-linux@roeck-us.net>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Sun, Oct 27, 2019 at 07:41:56PM -0700, Guenter Roeck wrote:
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

So these reported values seem to generate some interest.  Adding Akinobu
Mita who also planned to wire them up to the thermal framework.  I don't
really know either upper layer so I'm not sure which is the right one,
but with this just like with the previous series I am quite worried that
we add a lot of kernel boilerplate code for information people can
trivially get using nvme-cli.
