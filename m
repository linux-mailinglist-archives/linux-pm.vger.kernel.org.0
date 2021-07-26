Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5FAEA3D6799
	for <lists+linux-pm@lfdr.de>; Mon, 26 Jul 2021 21:41:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231844AbhGZTB0 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 26 Jul 2021 15:01:26 -0400
Received: from jabberwock.ucw.cz ([46.255.230.98]:51742 "EHLO
        jabberwock.ucw.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229882AbhGZTBZ (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 26 Jul 2021 15:01:25 -0400
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
        id 49F911C0B76; Mon, 26 Jul 2021 21:41:52 +0200 (CEST)
Date:   Mon, 26 Jul 2021 21:41:46 +0200
From:   Pavel Machek <pavel@ucw.cz>
To:     shiva.linuxworks@gmail.com
Cc:     rjw@rjwysocki.net, len.brown@intel.com, linux-pm@vger.kernel.org,
        kbusch@kernel.org, axboe@fb.com, hch@lst.de, sagi@grimberg.me,
        linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
        Shivamurthy Shastri <sshivamurthy@micron.com>,
        Keith Busch <kbush@kernel.org>
Subject: Re: [PATCH v2 1/2] PM: enable support for imminent power loss
Message-ID: <20210726194146.GA3986@localhost>
References: <20210726132223.1661-1-sshivamurthy@micron.com>
 <20210726132223.1661-2-sshivamurthy@micron.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210726132223.1661-2-sshivamurthy@micron.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi!

> If the shutdown is pwerformed when the platform is running on the
> limited backup power supply, some of the devices might not have enough
> power to perform a clean shutdown.
> 
> It is necessary to inform the driver about the limited backup power
> supply, to allow the driver to decide to perform the minimal required
> operation for a fast and clean shutdown.

If you can do shutdown that is fast & clean, why not do it always?

How fast is normal shutdown vs. fast shutdown?

> +#define PM_SUSPEND_FLAG_POWER_LOSS_IMMINENT	BIT(3)

I believe we should be more concrete here. Like explaining use (did
UPS say battery is low? Or does it mean 10 seconds remaining? Or...?)

Plus, who sets this flag? Userland?

Best regards,
								Pavel


-- 
