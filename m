Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6FC7254DA61
	for <lists+linux-pm@lfdr.de>; Thu, 16 Jun 2022 08:17:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358776AbiFPGRX (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 16 Jun 2022 02:17:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347281AbiFPGRV (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 16 Jun 2022 02:17:21 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E35137030;
        Wed, 15 Jun 2022 23:17:21 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id CBC8D619B0;
        Thu, 16 Jun 2022 06:17:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 97A0DC34114;
        Thu, 16 Jun 2022 06:17:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1655360240;
        bh=3m9N2h1456HQ1VVb/vWgQ24nIe2hiWGIKHhXs67rNaU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=gpXfyyyY7eT0xVipgi1lxMORn+/8dlIFfOtP/IEZJ4R0dFCgtZKCVkcNBfwesN04g
         Y0kX1UGTW4jNtdjv42xrEldzSyp3q2cVXnYCJWWaB1DUbVJQjOPyRVPXFpdHyLcVbQ
         G2t3Pz9m3Ea/4yM1uv6eZ2cZiLbRnzVlwBuy0V4A=
Date:   Thu, 16 Jun 2022 08:17:13 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Adrien Thierry <athierry@redhat.com>
Cc:     linux-rt-users@vger.kernel.org,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Kevin Hilman <khilman@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>,
        Andrew Halaney <ahalaney@redhat.com>,
        Eric Chanudet <echanude@redhat.com>,
        Brian Masney <bmasney@redhat.com>, linux-pm@vger.kernel.org
Subject: Re: [PATCH RFC] base: power: replace generic_pm_domain spinlock by
 raw spinlock
Message-ID: <YqrK6RZes4W4bZJd@kroah.com>
References: <20220615203605.1068453-1-athierry@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220615203605.1068453-1-athierry@redhat.com>
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Wed, Jun 15, 2022 at 04:36:05PM -0400, Adrien Thierry wrote:
> We've been encountering a BUG: scheduling while atomic while running the
> 5.18.0-rt11 kernel on a Qualcomm SoC (see stacktrace below).
> 
> It seems to occur because a spinlock is taken in the PSCI idle code path
> in the idle loop. With the RT patchset applied and CONFIG_PREEMPT_RT
> enabled, spinlocks can sleep, thus triggering the bug.
> 
> In order to prevent this, replace the generic_pm_domain spinlock by a
> raw spinlock.

Ick.  I'll leave this to the RT people, but having a spinlock sleep
feels totally wrong overall and I didn't think that was something that
actually happened.

For mainline, I don't think this is a valid change at this point in time
untill you all work out the details more.

thanks,

greg k-h
