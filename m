Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 94DB932F645
	for <lists+linux-pm@lfdr.de>; Sat,  6 Mar 2021 00:03:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229591AbhCEXDG (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 5 Mar 2021 18:03:06 -0500
Received: from rere.qmqm.pl ([91.227.64.183]:32669 "EHLO rere.qmqm.pl"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229792AbhCEXCe (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Fri, 5 Mar 2021 18:02:34 -0500
Received: from remote.user (localhost [127.0.0.1])
        by rere.qmqm.pl (Postfix) with ESMTPSA id 4Dsjtb56rBzL0;
        Sat,  6 Mar 2021 00:02:31 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=rere.qmqm.pl; s=1;
        t=1614985352; bh=SZHwnu6Rhn8QiMnEN2V1F4jUIvqNotWt5soGJPrBegA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=oQId8WMfqBoaRrfZPG9CkUf0ZVKeWwczfSPSv0TOjPq4wAk55pdhc9Ew+V+8lPSCH
         wR/HYFeMgFz63iYdebjAfc25Ui8cYBPeLUWgyRarMOH8GPzCx1XcoMeuetALOveUeb
         F/BYmh5JP3VsdTW+4JtEzJAg+X4fmmIL3MyvGXJSOz/EkyQFeJPRWQzaijxbq/3HMy
         mMgXbpOXMYC5J1H003FVZf2IP2WWemzYzbw3vkpKBP3H8RW991gZHSDohXnSlmY/ow
         eDpRzkIREhXZfJ4nyAmM3yj8lvnlij5N35ftdWwCULVuL8DhAy0VCYUPbzkTZshKoc
         B0P2pde08URTw==
X-Virus-Status: Clean
X-Virus-Scanned: clamav-milter 0.102.4 at mail
Date:   Sat, 6 Mar 2021 00:02:22 +0100
From:   =?iso-8859-2?Q?Micha=B3_Miros=B3aw?= <mirq-linux@rere.qmqm.pl>
To:     Dmitry Osipenko <digetx@gmail.com>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Matt Merhar <mattmerhar@protonmail.com>,
        Peter Geis <pgwipeout@gmail.com>,
        Nicolas Chauvet <kwizart@gmail.com>,
        linux-tegra@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org
Subject: Re: [PATCH v13 1/2] drm/tegra: dc: Support memory bandwidth
 management
Message-ID: <20210305230222.GA28867@qmqm.qmqm.pl>
References: <20210302124445.29444-1-digetx@gmail.com>
 <20210302124445.29444-2-digetx@gmail.com>
 <20210303230827.GA22628@qmqm.qmqm.pl>
 <1b352c7e-cc72-ba08-32ba-08c05cc3aa03@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1b352c7e-cc72-ba08-32ba-08c05cc3aa03@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Fri, Mar 05, 2021 at 12:45:51AM +0300, Dmitry Osipenko wrote:
> 04.03.2021 02:08, Michał Mirosław пишет:
> > On Tue, Mar 02, 2021 at 03:44:44PM +0300, Dmitry Osipenko wrote:
> >> Display controller (DC) performs isochronous memory transfers, and thus,
> >> has a requirement for a minimum memory bandwidth that shall be fulfilled,
> >> otherwise framebuffer data can't be fetched fast enough and this results
> >> in a DC's data-FIFO underflow that follows by a visual corruption.
[...]
> >> +	/*
> >> +	 * Horizontal downscale takes extra bandwidth which roughly depends
> >> +	 * on the scaled width.
> >> +	 */
> >> +	if (src_w > dst_w)
> >> +		mul = (src_w - dst_w) * bpp / 2048 + 1;
> >> +	else
> >> +		mul = 1;
> > 
> > Does it really need more bandwidth to scale down? Does it read the same
> > data multiple times just to throw it away?
> The hardware isn't optimized for downscale, it indeed takes more
> bandwidth. You'll witness a severe underflow of plane's memory FIFO
> buffer on trying to downscale 1080p plane to 50x50.
[...]

In your example, does it really need 16x the bandwidth compared to
no scaling case?  The naive way to implement downscaling would be to read
all the pixels and only take every N-th.  Maybe the problem is that in
downscaling mode the latency requirements are tighter?  Why would bandwidth
required be proportional to a difference between the widths (instead e.g.
to src/dst or dst*cacheline_size)?

Best Regards
Michał Mirosław
