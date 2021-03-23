Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 33271346159
	for <lists+linux-pm@lfdr.de>; Tue, 23 Mar 2021 15:20:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232186AbhCWOT5 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 23 Mar 2021 10:19:57 -0400
Received: from mail.kernel.org ([198.145.29.99]:60380 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231718AbhCWOT4 (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Tue, 23 Mar 2021 10:19:56 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 29323619A9;
        Tue, 23 Mar 2021 14:19:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1616509195;
        bh=Wctfq10oQ7ClbxMnP/cRUCla14+kxy0D+hLSZJhO6qQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=mI74jkxW1+48gr1J47uCQ/U+PD6M529yoLtqnveerHk883YTsI+heQhc28xco0MgJ
         PKKcBbOGSaGDuLGMecQHKpgTpa0rAR1PoLw/Xu90tsI4cYeIbho5FbZnLpv84V+8HQ
         R0ddXnGY4ghWbux/uODn8JaYEJasNIgnPzUw/92o=
Date:   Tue, 23 Mar 2021 15:19:53 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
        Matti Vaittinen <mazziesaccount@gmail.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Mark Gross <mgross@linux.intel.com>,
        Sebastian Reichel <sre@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-hwmon@vger.kernel.org, platform-driver-x86@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-watchdog@vger.kernel.org
Subject: Re: [PATCH v3 2/8] MAINTAINERS: Add entry for devm helpers
Message-ID: <YFn5CSB1O3i+SzgR@kroah.com>
References: <cover.1616506559.git.matti.vaittinen@fi.rohmeurope.com>
 <eec1797734e3d080662aa732c565ed4a3c261799.1616506559.git.matti.vaittinen@fi.rohmeurope.com>
 <e064fdd7-b276-6732-16fe-2eb2564b2179@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e064fdd7-b276-6732-16fe-2eb2564b2179@redhat.com>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Tue, Mar 23, 2021 at 02:58:28PM +0100, Hans de Goede wrote:
> Hi,
> 
> On 3/23/21 2:56 PM, Matti Vaittinen wrote:
> > Devm helper header containing small inline helpers was added.
> > Hans promised to maintain it.
> > 
> > Add Hans as maintainer and myself as designated reviewer.
> > 
> > Signed-off-by: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
> 
> Yes I did promise that, didn't I?  FWIW going this route is still
> fine by me, assuming that having someone else maintain this makes
> this easier on / more acceptable to Greg.
> 
> Ultimately this is up to Greg though, so lets wait and see what
> Greg has to say about this.

Can we move some of the devm_* calls in include/device.h into here as
well so that you all can be in charge of them instead of me?

If so, I'm happy :)

Anyway, this looks sane, I'll queue it up and let's see what breaks in
linux-next...

thanks,

greg k-h
