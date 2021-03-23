Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A5F6A34610F
	for <lists+linux-pm@lfdr.de>; Tue, 23 Mar 2021 15:09:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232156AbhCWOJV (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 23 Mar 2021 10:09:21 -0400
Received: from mail.kernel.org ([198.145.29.99]:58486 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232209AbhCWOJC (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Tue, 23 Mar 2021 10:09:02 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id D210C619BB;
        Tue, 23 Mar 2021 14:09:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1616508542;
        bh=Ne+mdEaEHnyMgYQAD1Dg1Obh9Ysk1nIYZq+vNqyKW/0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=tAdPk9ut/M6YBETYg/qSfI4WSP3BAFS5xe7DfPdO28rr/BbVM0cs8iIpjmc9u6d0A
         VtARQ4956Q7ATJc11QH4hYv42yTrrjRwB1Nvg72RLjEKJluPRDFyY7FRYg9hnBcnUX
         E/VnrYYqTm3ic0MP8prKrONHJrwFRO9SMMynU3Oo=
Date:   Tue, 23 Mar 2021 15:08:59 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Joseph Jang <josephjang@google.com>
Cc:     "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Pavel Machek <pavel@ucw.cz>, Len Brown <len.brown@intel.com>,
        Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Kees Cook <keescook@chromium.org>,
        Anton Vorontsov <anton@enomsg.org>,
        Colin Cross <ccross@android.com>,
        Tony Luck <tony.luck@intel.com>,
        "David S . Miller " <davem@davemloft.net>,
        Rob Herring <robh@kernel.org>,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        jonglin@google.com, woodylin@google.com, markcheng@google.com
Subject: Re: [PATCH v6] power: suspend: Move dpm_watchdog to suspend.c and
 enhance it
Message-ID: <YFn2e85YkMqTw2zA@kroah.com>
References: <20210128093927.2206179-1-josephjang@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210128093927.2206179-1-josephjang@google.com>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Thu, Jan 28, 2021 at 05:39:27PM +0800, Joseph Jang wrote:
> Since dpm_watchdog just cover two functions __device_suspend() and
> device_resume(), we proposed to move it to core power suspend.c to extend
> its coverage and monitor more devices suspend hand issues.
> 
> We propose to use new name suspend watchdog and new timeout handler to
> cover more sleep hang issues. The new timeout handler will dump disk
> sleep task call trace at first round timeout and trigger kernel panic
> at second round timeout.
> The default timer for each round is defined in
> CONFIG_PM_SUSPEND_WATCHDOG_TIMEOUT.
> 
> Signed-off-by: Joseph Jang <josephjang@google.com>

Seems sane, but I'm not the maintainer of this stuff:

Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
