Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EF042290076
	for <lists+linux-pm@lfdr.de>; Fri, 16 Oct 2020 11:03:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394309AbgJPJCc (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 16 Oct 2020 05:02:32 -0400
Received: from mail.kernel.org ([198.145.29.99]:33652 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2391296AbgJPJCb (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Fri, 16 Oct 2020 05:02:31 -0400
Received: from localhost (83-86-74-64.cable.dynamic.v4.ziggo.nl [83.86.74.64])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DB22520723;
        Fri, 16 Oct 2020 09:02:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1602838951;
        bh=ExonDUv2BTue6ormOuJi9dor30JUezmpADFpWJW81tM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=vXnBkW2MWuCUJ9Twl08UrcRh5Dr+JxyP/lPijK5sXQm9MfqueockjFULOq3rcl2nN
         EbTBTaVj1oEc6stIdXv0HWhhJcgWSfmb0JOCuzTkoF5k52bBME0SNgTPclnwzYFBfG
         w9njf/BeIsHq2FGP7SknhGE+wsKykMigm+VVXsEs=
Date:   Fri, 16 Oct 2020 11:03:02 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Joseph Jang <josephjang@google.com>
Cc:     "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Pavel Machek <pavel@ucw.cz>, Len Brown <len.brown@intel.com>,
        Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        Jonglin Lee <jonglin@google.com>,
        Woody Lin <woodylin@google.com>,
        Mark Cheng <markcheng@google.com>
Subject: Re: [PATCH] power: suspend: Add suspend timeout handler
Message-ID: <20201016090302.GA1748454@kroah.com>
References: <20201016035109.3952356-1-josephjang@google.com>
 <20201016054412.GB155953@kroah.com>
 <CAPaOXERGzo8uF9gh4aAoicEAi_TtHn1M2Yno5LAWQPcWmq_evQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPaOXERGzo8uF9gh4aAoicEAi_TtHn1M2Yno5LAWQPcWmq_evQ@mail.gmail.com>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Fri, Oct 16, 2020 at 04:58:38PM +0800, Joseph Jang wrote:
> Thank you Greg's promptly reply.

<snip>

You just sent html email, which got rejected by all of the mailing
lists :(

Please fix your email client to be sand and resend.

thanks,

greg k-h
