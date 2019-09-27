Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7038DBFE94
	for <lists+linux-pm@lfdr.de>; Fri, 27 Sep 2019 07:36:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725813AbfI0Fgg (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 27 Sep 2019 01:36:36 -0400
Received: from mail.kernel.org ([198.145.29.99]:40404 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725812AbfI0Fgg (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Fri, 27 Sep 2019 01:36:36 -0400
Received: from localhost (unknown [62.119.166.9])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E60B820872;
        Fri, 27 Sep 2019 05:36:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1569562595;
        bh=AaRZAAlTXRa6HzUc0TcRfYdF4U//0dh1f6GVRjtdT64=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=MmPouLzO1AloZYDCYZu959oelmYr2TFKqPbkG/T5KJNEaySqKzwzVfqKVZuL+TEQt
         fEHNTanygIfu675qmcBICXp9vjMrYPMXSwIJ5XbhB6Mo5sHlfopkjOv7T0gUTOmDbT
         mrDK0FCHiBx632rk1jxOA9GIsJW10NIPsZOWEbGo=
Date:   Fri, 27 Sep 2019 07:36:32 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Matthias Kaehlcke <mka@chromium.org>
Cc:     "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Kevin Hilman <khilman@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>,
        Douglas Anderson <dianders@chromium.org>,
        linux-pm@vger.kernel.org, Amit Kucheria <amit.kucheria@linaro.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1] PM / Domains: Add tracepoints
Message-ID: <20190927053632.GB1781519@kroah.com>
References: <20190926150406.v1.1.I07a769ad7b00376777c9815fb169322cde7b9171@changeid>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190926150406.v1.1.I07a769ad7b00376777c9815fb169322cde7b9171@changeid>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Thu, Sep 26, 2019 at 03:04:38PM -0700, Matthias Kaehlcke wrote:
> Define genpd_power_on/off and genpd_set_performance_state
> tracepoints and use them.

This says _what_ you do, but not _why_ you want to do this.  Who is
going to use this?  What can be done with this information that is
needed by anyone/someone?

More details please.

thanks,

greg k-h
