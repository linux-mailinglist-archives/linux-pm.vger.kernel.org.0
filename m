Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 08C8F351FD0
	for <lists+linux-pm@lfdr.de>; Thu,  1 Apr 2021 21:29:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234453AbhDAT3W (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 1 Apr 2021 15:29:22 -0400
Received: from mail.kernel.org ([198.145.29.99]:33384 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235069AbhDAT26 (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Thu, 1 Apr 2021 15:28:58 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 45B616113B;
        Thu,  1 Apr 2021 19:28:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1617305337;
        bh=ntCIykOg/5Ez6AiXNdgtg4xQAkA3l2TdvhgGfI7+DE0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Z/UA54VJOKJoIrJm211yLlAfJR2m7RHvr3YXgHMsmZ/71JPnoKheZZ6Ihxi0qxQLe
         /VHHZ48Jq3FfR8a1s81dcY8xwamSrcFUVNkWrKuO2J3BnZRWUhOswyy4FNCcetjKEk
         OygEf/vlsPO71v+6cQfmFZ84dSoXSk/HVJOLK1s0=
Date:   Thu, 1 Apr 2021 21:28:54 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        lukasz.luba@arm.com, rafael@kernel.org
Subject: Re: [PATCH v6 2/7] powercap/drivers/dtpm: Create a registering system
Message-ID: <YGYe9p3oyNpMnsBT@kroah.com>
References: <20210401183654.27214-1-daniel.lezcano@linaro.org>
 <20210401183654.27214-2-daniel.lezcano@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210401183654.27214-2-daniel.lezcano@linaro.org>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Thu, Apr 01, 2021 at 08:36:49PM +0200, Daniel Lezcano wrote:
> A SoC can be differently structured depending on the platform and the
> kernel can not be aware of all the combinations, as well as the
> specific tweaks for a particular board.
> 
> The creation of the hierarchy must be delegated to userspace.

Why?  Isn't this what DT is for?

What "userspace tool" is going to be created to manage all of this?
Pointers to that codebase?

> These changes provide a registering mechanism where the different
> subsystems will initialize their dtpm backends and register with a
> name the dtpm node in a list.
> 
> The next changes will provide an userspace interface to create
> hierarchically the different nodes. Those will be created by name and
> found via the list filled by the different subsystem.
> 
> If a specified name is not found in the list, it is assumed to be a
> virtual node which will have children and the default is to allocate
> such node.

So userspace sets the name?

Why not use the name in the device itself?  I thought I asked that last
time...

thanks,

greg k-h
