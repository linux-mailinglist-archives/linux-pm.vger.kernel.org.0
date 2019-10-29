Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9AFE5E833D
	for <lists+linux-pm@lfdr.de>; Tue, 29 Oct 2019 09:32:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728757AbfJ2Ic0 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 29 Oct 2019 04:32:26 -0400
Received: from mail.kernel.org ([198.145.29.99]:36016 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728550AbfJ2Ic0 (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Tue, 29 Oct 2019 04:32:26 -0400
Received: from localhost (unknown [91.217.168.176])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 16AFA2054F;
        Tue, 29 Oct 2019 08:32:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1572337945;
        bh=LgpjDceusfkD7Sr5vD/eZjEXHmIU2YNB4j9b5lzHmo0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=GGvnrn390c/UQVTkzapbjh2Z7Bda5iNhkVt/h2iHLdpA0sOd7PSML/eijBBozGnnZ
         6LMZz6IHyFkPmVK01u7esqQTlv0Mb37A1djm8Zo5fvxtIos7lzMUoFBGVjqJiosJxn
         UXpKPJ8stfkM7ARLl0xpAzTAUAVWJeB1lqECc9x4=
Date:   Tue, 29 Oct 2019 09:32:22 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Ikjoon Jang <ikjn@chromium.org>
Cc:     linux-pm@vger.kernel.org, "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        "Pavel Machek )" <pavel@ucw.cz>, Len Brown <len.brown@intel.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] cpuidle: undelaying cpuidle in dpm_{suspend|resume}()
Message-ID: <20191029083222.GA558937@kroah.com>
References: <20191029073145.154869-1-ikjn@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191029073145.154869-1-ikjn@chromium.org>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Tue, Oct 29, 2019 at 03:31:45PM +0800, Ikjoon Jang wrote:
> cpuidle is paused only during dpm_suspend_noirq() ~ dpm_resume_noirq().
> But some device drivers need random sized IOs in dpm_{suspend|resume}()
> stage (e.g. re-downloading firmware in resume).
> And with such a device, cpuidle's latencies could be critical to
> response time of system suspend/resume.
> 
> To minimize those latencies, we could apply pm_qos to such device drivers,
> but simply undelaying cpuidle from dpm_suspend_noirq() to dpm suspend()
> seems no harm.
> ---
>  drivers/base/power/main.c | 6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)

no signed-off-by?

:(

