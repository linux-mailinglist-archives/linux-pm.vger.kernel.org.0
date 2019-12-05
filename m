Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E79A3113F7D
	for <lists+linux-pm@lfdr.de>; Thu,  5 Dec 2019 11:37:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729048AbfLEKhN (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 5 Dec 2019 05:37:13 -0500
Received: from metis.ext.pengutronix.de ([85.220.165.71]:37347 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726384AbfLEKhM (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 5 Dec 2019 05:37:12 -0500
Received: from kresse.hi.pengutronix.de ([2001:67c:670:100:1d::2a])
        by metis.ext.pengutronix.de with esmtp (Exim 4.92)
        (envelope-from <l.stach@pengutronix.de>)
        id 1icoVT-0001Rs-6X; Thu, 05 Dec 2019 11:37:11 +0100
Message-ID: <475aa5cfd3d3ccac5b2c76ba031bf925db09a917.camel@pengutronix.de>
Subject: Re: baseline power consumtion kernel > 5.3.10
From:   Lucas Stach <l.stach@pengutronix.de>
To:     Guido Riedel <guido.riedel@web.de>, linux-pm@vger.kernel.org
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        dri-devel@lists.freedesktop.org
Date:   Thu, 05 Dec 2019 11:37:10 +0100
In-Reply-To: <3ebca53c-b8fa-1e7f-6d4e-abdc93cbf2a6@web.de>
References: <3ebca53c-b8fa-1e7f-6d4e-abdc93cbf2a6@web.de>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.30.5-1.1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::2a
X-SA-Exim-Mail-From: l.stach@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pm@vger.kernel.org
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Do, 2019-12-05 at 08:52 +0100, Guido Riedel wrote:
> Hi,
> 
> Since Kernel 5.3.11 I got a significant increased baseline Power 
> consumption. I tried up to 5.4.1 on arch linux. Powertop shows an 
> increase from 3.6W on 5.3.10 to 5.x W on higher Kernels. My laptop fan 
> spins a lot more.
> 
> I read that a lot of Intel stuff has entered the Kernel in 5.3.11, could 
> this cause it? Will it stay like this in the next Versions? Can I maybe 
> switch something off etc. to get a lower baseline power?
> 
> I hope I write to the right address, otherwise sorry.

7e34f4e4aad3 ("drm/i915/gen8+: Add RC6 CTX corruption WA"), which has
been backported to 5.3.11 causes a major power regression due to Intel
GPUs not being able to enter rc6 anymore.

Fixes for this are -next, but I don't know what the plans for landing
and maybe backporting are.

Regards,
Lucas

