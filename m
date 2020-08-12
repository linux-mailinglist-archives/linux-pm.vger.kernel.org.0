Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D3648242861
	for <lists+linux-pm@lfdr.de>; Wed, 12 Aug 2020 12:54:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727821AbgHLKyd (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 12 Aug 2020 06:54:33 -0400
Received: from mo4-p01-ob.smtp.rzone.de ([85.215.255.52]:14181 "EHLO
        mo4-p01-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727078AbgHLKyF (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 12 Aug 2020 06:54:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1597229619;
        s=strato-dkim-0002; d=gerhold.net;
        h=In-Reply-To:References:Message-ID:Subject:Cc:To:From:Date:
        X-RZG-CLASS-ID:X-RZG-AUTH:From:Subject:Sender;
        bh=WzJqEDzrqFMuFhAdXgFsojKRmC5Xhk7nkSHAZykB/8o=;
        b=Lcnic/xWYZbD/VaRj9htbJcjsBktafxNXbq2kN2sdlHLLkv3ZaYWV0pJElfJwBnFGG
        IUpmCDYYCbgjR4iUcGqWCNCfJ2WzzUwEl2lCEM+Yt/ODrL+p5B9ONj7KJyxiTTqL/26Z
        CcyAH26IhHVIvbF2LB96a5ctB0hFOgBkug09P3NYL0mMNTx5I0QDDY0UY3SI4yc29Z69
        NwqexLyjWA3065UXR8NeAC5UjumEazonQtwgpyFJ+BUQ7dfS2GpE8k1OiHmlDraFLtaH
        V4r1rx5aNjOqQHRRnuVCFUgkBsBlreu/0UXMUv+0un+zjKnwAYa7sGjW234eaxC9NXvH
        bSGA==
X-RZG-AUTH: ":P3gBZUipdd93FF5ZZvYFPugejmSTVR2nRPhVOQ/OcYgojyw4j34+u26zEodhPgRDZ8j6Ic/MbIo="
X-RZG-CLASS-ID: mo00
Received: from gerhold.net
        by smtp.strato.de (RZmta 46.10.5 DYNA|AUTH)
        with ESMTPSA id Y0939ew7CArbqST
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
        Wed, 12 Aug 2020 12:53:37 +0200 (CEST)
Date:   Wed, 12 Aug 2020 12:53:33 +0200
From:   Stephan Gerhold <stephan@gerhold.net>
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Viresh Kumar <viresh.kumar@linaro.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Kevin Hilman <khilman@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Nishanth Menon <nm@ti.com>, Stephen Boyd <sboyd@kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Georgi Djakov <georgi.djakov@linaro.org>,
        Niklas Cassel <nks@flawful.org>
Subject: Re: [RFC PATCH 1/2] opp: Allow dev_pm_opp_get_opp_table() to return
 -EPROBE_DEFER
Message-ID: <20200812105333.GA913@gerhold.net>
References: <20200727093047.8274-1-stephan@gerhold.net>
 <CAPDyKFq9bbMZD7ifF=ipfBD3ayiLuc6RPwW8_RWZBxMGv_WZkw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPDyKFq9bbMZD7ifF=ipfBD3ayiLuc6RPwW8_RWZBxMGv_WZkw@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Wed, Aug 12, 2020 at 11:10:38AM +0200, Ulf Hansson wrote:
> > I wasn't sure if the changes in drivers/base/power/domain.c
> > should be made in a separate commit, but they need to be made together
> > with the other changes.
> 
> I would suggest to move the changes in drivers/base/power/domain.c
> into a separate patch, still part of the series, but let it preceed
> $subject patch.
> 

OK, will do that in v2 - thank you!

I have another small build fix reported by the kernel test robot,
but will wait with sending that out until Viresh had a chance to give
some feedback on the basic idea. :)

Thanks!
Stephan
