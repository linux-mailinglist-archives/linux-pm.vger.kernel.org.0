Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DC424293A2F
	for <lists+linux-pm@lfdr.de>; Tue, 20 Oct 2020 13:42:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393603AbgJTLmV (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 20 Oct 2020 07:42:21 -0400
Received: from mail.kernel.org ([198.145.29.99]:53802 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2393580AbgJTLmT (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Tue, 20 Oct 2020 07:42:19 -0400
Received: from localhost (83-86-74-64.cable.dynamic.v4.ziggo.nl [83.86.74.64])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id ADF862224A;
        Tue, 20 Oct 2020 11:42:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1603194139;
        bh=OkGC61mG2V3nA0YISOyNn4m3xw11hTw/4PbaYssCzGk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=bbcz/YNWgoqf2RfJOoC4JT9jLWT0Pho6jrXXbEgHUT3FiNuZwIvHjg+n0bQ0HT899
         Dy1BrosPjEaCBikd0mm3ttihYfeZK1YIX4Yn49jT57uJWfFHjkDzZQkQ8K97N4iD25
         CKCVIHVGJfjURV0grZW5LDPjSDtdBp+oNVvVR+QQ=
Date:   Tue, 20 Oct 2020 13:43:02 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Joseph Jang <josephjang@google.com>
Cc:     "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Pavel Machek <pavel@ucw.cz>, Len Brown <len.brown@intel.com>,
        Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        jonglin@google.com, woodylin@google.com, markcheng@google.com
Subject: Re: [PATCH] power: suspend: Replace dpm_watchdog by sleep timer
Message-ID: <20201020114302.GB554297@kroah.com>
References: <20201020095611.1763815-1-josephjang@google.com>
 <20201020110810.GA194512@kroah.com>
 <CAPaOXETgmHATQMM55C+2BKTQDyEnXYjknhWY7KB1jqKYynE-+g@mail.gmail.com>
 <20201020114234.GA554297@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201020114234.GA554297@kroah.com>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Tue, Oct 20, 2020 at 01:42:34PM +0200, Greg Kroah-Hartman wrote:
> A: Because it messes up the order in which people normally read text.
> Q: Why is top-posting such a bad thing?
> A: Top-posting.
> Q: What is the most annoying thing in e-mail?
> 
> A: No.
> Q: Should I include quotations after my reply?
> 
> http://daringfireball.net/2007/07/on_top
> 
> On Tue, Oct 20, 2020 at 07:11:56PM +0800, Joseph Jang wrote:
> > It is the same version, I just changed the commit message and removed
> > dpm_watchdog.
> 
> That is not the "same version", you need to properly version your
> patches when you send them as the documentation states to.
> 
> Otherwise your patches will just be ignored.

And you sent out html email which was rejected by the mailing lists :(
