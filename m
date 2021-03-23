Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6BD7D345E61
	for <lists+linux-pm@lfdr.de>; Tue, 23 Mar 2021 13:43:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230450AbhCWMnP (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 23 Mar 2021 08:43:15 -0400
Received: from mail.kernel.org ([198.145.29.99]:38598 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230492AbhCWMnJ (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Tue, 23 Mar 2021 08:43:09 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id B7C15619AB;
        Tue, 23 Mar 2021 12:43:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1616503389;
        bh=cAV/LvPBZf6PcCL1S9PPpY7NgmFmnj+4Y1BHWQlvH48=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=qZpTnB5L5SwA+x6JcTHTnYB5IuVG+uWCVHjNy0s9wHGwsycauM6QqPRf9NmlZ8shb
         +VKFUq/vhgPcz+RG7HgJ8Trou9wfxLkkTcTQ8TY8Ty/UA+gjPkl+vjFQwNN6k3QiLX
         XvWuVMnL+PRs0CePVoWp0Uq0+a6BiVWwjOrC+2Yk=
Date:   Tue, 23 Mar 2021 13:43:06 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
Cc:     Matti Vaittinen <mazziesaccount@gmail.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Hans de Goede <hdegoede@redhat.com>,
        Mark Gross <mgross@linux.intel.com>,
        Sebastian Reichel <sre@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-hwmon@vger.kernel.org, platform-driver-x86@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-watchdog@vger.kernel.org
Subject: Re: [RFC RESEND PATCH v2 0/8] Add managed version of delayed work
 init
Message-ID: <YFniWnUwQ7CY7wEM@kroah.com>
References: <cover.1616395565.git.matti.vaittinen@fi.rohmeurope.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1616395565.git.matti.vaittinen@fi.rohmeurope.com>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Mon, Mar 22, 2021 at 09:41:13AM +0200, Matti Vaittinen wrote:
> It's not rare that device drivers need delayed work.
> It's not rare that this work needs driver's data.

I don't normally comment on "RFC" patch series as I can't take them and
the submitter doesn't feel right with them being merged at this point in
time.

So if you think this is all correct now, please resubmit without that so
we can review it properly :)

thanks,

greg k-h
