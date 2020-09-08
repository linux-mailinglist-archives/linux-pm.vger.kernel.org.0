Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E7417260D86
	for <lists+linux-pm@lfdr.de>; Tue,  8 Sep 2020 10:27:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729744AbgIHI1L (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 8 Sep 2020 04:27:11 -0400
Received: from mail.kernel.org ([198.145.29.99]:58802 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729564AbgIHI1K (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Tue, 8 Sep 2020 04:27:10 -0400
Received: from localhost (83-86-74-64.cable.dynamic.v4.ziggo.nl [83.86.74.64])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EAD9D2076C;
        Tue,  8 Sep 2020 08:27:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599553630;
        bh=N6KwgwEUUkfj+0KseKFgjtNwc4nuJeqgrPxo94xJcQ0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Kp0WFZht4dl08Dtqmpc5qpcXEFRgqRB4GQq3GSFWwNJvAVLi1mCynHkn5bAC3Veym
         uCpRSoJcX83s1Yo7d+p6IbwonioVHyZ628OcWq3fUpgAlCyDnXeqJThPhzE/7d8Rv4
         31km3LScm8DwnYrBTzALqrNXJbfNkvvpl3mf98x4=
Date:   Tue, 8 Sep 2020 10:27:22 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Joe Perches <joe@perches.com>
Cc:     Sudeep Holla <sudeep.holla@arm.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Subject: Re: [PATCH 1/4] drivers core: Use sysfs_emit and sysfs_emit_at for
 show(device *...) functions
Message-ID: <20200908082722.GA704757@kroah.com>
References: <cover.1599501047.git.joe@perches.com>
 <1fdeef21167fcf96c94255349401d004a18b7243.1599501047.git.joe@perches.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1fdeef21167fcf96c94255349401d004a18b7243.1599501047.git.joe@perches.com>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Mon, Sep 07, 2020 at 10:58:05AM -0700, Joe Perches wrote:
> Convert the various sprintf fmaily calls in sysfs device show functions
> to sysfs_emit and sysfs_emit_at for PAGE_SIZE buffer safety.

But no sysfs_emit_at() calls are used in this patch :(

thanks,

greg k-h
