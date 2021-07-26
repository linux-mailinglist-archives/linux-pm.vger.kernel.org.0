Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DA7683D67F8
	for <lists+linux-pm@lfdr.de>; Mon, 26 Jul 2021 22:16:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230421AbhGZTgV (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 26 Jul 2021 15:36:21 -0400
Received: from mail.kernel.org ([198.145.29.99]:50312 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229646AbhGZTgV (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Mon, 26 Jul 2021 15:36:21 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id CE98760F8F;
        Mon, 26 Jul 2021 20:16:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1627330609;
        bh=Z4hwq6b440OkyWGYI3HMsBLmFm75Y/asw4v0/OVEDyk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=sEREw4glvypOLeWWc3l0NhaVgTrSd6R2J0yIzBQWNnscjxyEhYJgBFBvK2p6Ax6H7
         etXE3FYYDnwHSteOa7Xy1IKLPu4GEMOSt6YL2BgiQFX+jl2U0VwSmgzFI10PuXJAaL
         l+0p+2y/+qUveODb7rEIstqeC9hQ3Gwi+iBl3xsJq5JkgNAoMQfnONgQ5DK9HGNeQc
         Vux6h1JZ17eGPx52tD/kN2bVNnIygn7j1nE1W4l+OEKD83h3Si5/vBbuMS7PsybLhV
         hzMGMetMPudou0k9mz89KwpR8wJjMTUrjglURibH3wIp5rVYCCyvanfPoUj7Lj+F6e
         1PKtHj7LEAwtg==
Date:   Mon, 26 Jul 2021 13:16:47 -0700
From:   Keith Busch <kbusch@kernel.org>
To:     Pavel Machek <pavel@ucw.cz>
Cc:     shiva.linuxworks@gmail.com, rjw@rjwysocki.net, len.brown@intel.com,
        linux-pm@vger.kernel.org, axboe@fb.com, hch@lst.de,
        sagi@grimberg.me, linux-nvme@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Shivamurthy Shastri <sshivamurthy@micron.com>
Subject: Re: [PATCH v2 1/2] PM: enable support for imminent power loss
Message-ID: <20210726201615.GA2025233@dhcp-10-100-145-180.wdc.com>
References: <20210726132223.1661-1-sshivamurthy@micron.com>
 <20210726132223.1661-2-sshivamurthy@micron.com>
 <20210726194146.GA3986@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210726194146.GA3986@localhost>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Mon, Jul 26, 2021 at 09:41:46PM +0200, Pavel Machek wrote:
> > If the shutdown is pwerformed when the platform is running on the
> > limited backup power supply, some of the devices might not have enough
> > power to perform a clean shutdown.
> > 
> > It is necessary to inform the driver about the limited backup power
> > supply, to allow the driver to decide to perform the minimal required
> > operation for a fast and clean shutdown.
> 
> If you can do shutdown that is fast & clean, why not do it always?

At least for nvme, I don't think this faster shutdown qualifies as
"clean". It's just a little better than removing power without telling
the device. Typical implementations take longer to become ready on their
next power-on following the abrupt shutdown sequence.
