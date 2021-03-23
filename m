Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7A5883462BE
	for <lists+linux-pm@lfdr.de>; Tue, 23 Mar 2021 16:26:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232762AbhCWP0R (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 23 Mar 2021 11:26:17 -0400
Received: from mail.kernel.org ([198.145.29.99]:46014 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232779AbhCWP0K (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Tue, 23 Mar 2021 11:26:10 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 3C20E61992;
        Tue, 23 Mar 2021 15:26:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1616513169;
        bh=ngQXoqy6y8sLrs0z1JGl1+LPm+uDGKDMfZoSEjUnW1s=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=gP97Yn/jeTWKAK7uEmrFRIzTESb9qbf/oyuEN5mLbHkUs53YleN9NPiKTsHZtxH2n
         EOMaCAfStgAkAb/BM75sXnELhIv43cjnwK/jCNMD7sGXaIwB2CyodlicoKJM/imQgI
         72J/qqsdG/OvAVwRyHsA+A051qvCg38WbVjJ1+Bw=
Date:   Tue, 23 Mar 2021 16:26:06 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Lukasz Luba <lukasz.luba@arm.com>
Cc:     linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        rjw@rjwysocki.net, rafael@kernel.org, ionela.voinescu@arm.com,
        Dietmar.Eggemann@arm.com
Subject: Re: [PATCH] PM / EM: postpone creating the debugfs dir till
 fs_initcall
Message-ID: <YFoIjt3E+MIK3yQQ@kroah.com>
References: <20210323145608.29832-1-lukasz.luba@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210323145608.29832-1-lukasz.luba@arm.com>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Tue, Mar 23, 2021 at 02:56:08PM +0000, Lukasz Luba wrote:
> The debugfs directory '/sys/kernel/debug/energy_model' is needed before
> the Energy Model registration can happen. With the recent change in
> debugfs subsystem it's not allowed to create this directory at early stage
> (core_initcall). Thus creating this directory would fail.
> Postpone the creation of the EM debug dir to later stage: fs_initcall.
> It should be safe since all clients: CPUFreq drivers, Devfreq drivers will
> be initialized in later stages.
> The custom debug log below prints the time of creation the EM debug dir at
> fs_initcall and successful registration of EMs at later stages.
> 
> [    1.505717] energy_model: creating rootdir
> [    3.698307] cpu cpu0: EM: created perf domain
> [    3.709022] cpu cpu1: EM: created perf domain
> 
> fixes: 56348560d495 ("debugfs: do not attempt to create a new file before the filesystem is initalized")
> Reported-by: Ionela Voinescu <ionela.voinescu@arm.com>
> Signed-off-by: Lukasz Luba <lukasz.luba@arm.com>
> ---
> Hi Rafael,
> 
> Please take this patch into your PM v5.12 fixes. The change described in
> the patch above landed in v5.12-rc1. Some of our EAS/EM tests are failing.

Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
