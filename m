Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C0C51366A81
	for <lists+linux-pm@lfdr.de>; Wed, 21 Apr 2021 14:09:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239499AbhDUMK2 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 21 Apr 2021 08:10:28 -0400
Received: from mail.kernel.org ([198.145.29.99]:40742 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S239515AbhDUMK0 (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 21 Apr 2021 08:10:26 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 7EF40613E0;
        Wed, 21 Apr 2021 12:09:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1619006993;
        bh=2LUCdUr5aEbuS1s48Lx12yxSKE9UTo8U9uXYQqqVcPE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=kOK4H0EODUbCzdjm3fyht0gXrb+4/8PlHme0ZoTVpw5TXUXaocApBDlkOm8Vdix+7
         avQeX4MjFkRoXz68XaMTXgtYRK/hrLvKDl9FD875kYDXAF3SBbPLriAvODgJvLTl7S
         iwazzRCpbQlT/58e7dXjhV5piMCHk8kvQbNv15zM=
Date:   Wed, 21 Apr 2021 14:09:50 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     matti.vaittinen@fi.rohmeurope.com,
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
Message-ID: <YIAWDh5tMl607kHv@kroah.com>
References: <cover.1616506559.git.matti.vaittinen@fi.rohmeurope.com>
 <eec1797734e3d080662aa732c565ed4a3c261799.1616506559.git.matti.vaittinen@fi.rohmeurope.com>
 <e064fdd7-b276-6732-16fe-2eb2564b2179@redhat.com>
 <YFn5CSB1O3i+SzgR@kroah.com>
 <da0233f3223d7c0816581afe0969caf0abe20378.camel@fi.rohmeurope.com>
 <96935c55-c799-595e-024c-56fd352f279e@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <96935c55-c799-595e-024c-56fd352f279e@redhat.com>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Wed, Apr 21, 2021 at 01:58:29PM +0200, Hans de Goede wrote:
> Hi,
> 
> On 4/21/21 9:51 AM, Matti Vaittinen wrote:
> > 
> > On Tue, 2021-03-23 at 15:19 +0100, Greg KH wrote:
> >> On Tue, Mar 23, 2021 at 02:58:28PM +0100, Hans de Goede wrote:
> >>> Hi,
> >>>
> >>> On 3/23/21 2:56 PM, Matti Vaittinen wrote:
> >>>> Devm helper header containing small inline helpers was added.
> >>>> Hans promised to maintain it.
> >>>>
> >>>> Add Hans as maintainer and myself as designated reviewer.
> >>>>
> >>> Ultimately this is up to Greg though, so lets wait and see what
> >>> Greg has to say about this.
> >>
> >> Can we move some of the devm_* calls in include/device.h into here as
> >> well so that you all can be in charge of them instead of me?
> > 
> > Seems like this was left w/o answer. I guess the question was pointed
> > to Hans
> 
> I believe that Greg was (mostly) joking here. At least that is how
> I interpreted Greg's reply,which is why I did not answer.

I have no idea what this thread was about anymore, sorry :)

> Also note that Greg merged this series, but not this patch,
> so the new devm-helpers.h file will presumably be maintained by Greg.

What's one more file...

thanks,

greg k-h
