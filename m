Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BF68438E6A8
	for <lists+linux-pm@lfdr.de>; Mon, 24 May 2021 14:34:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232638AbhEXMgG (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 24 May 2021 08:36:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:57694 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232486AbhEXMgG (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Mon, 24 May 2021 08:36:06 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 0DCF761209;
        Mon, 24 May 2021 12:34:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1621859677;
        bh=Mt9KSlfEqF3UbTwKtEEmGBsrGRMbjNxytliwTlyydn8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=QXOrFQX1JLWjJV5vWx8rtgDz9BPEz242xTgTeLp9dh3ifD5CoSEPQRlKD3HRZbbkZ
         M1/8rcLMUTgY+PMG8RIAPFq+nMx6om8+nGhIQnTTEINm1h58xaqVcM/bBw0pJPEm7b
         +fBULXBHQuLfSXx+FQNh03AkHjw7fm5BsSLu3kqM=
Date:   Mon, 24 May 2021 14:34:35 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Lee Jones <lee.jones@linaro.org>
Cc:     Elliot Berman <eberman@codeaurora.org>,
        Sebastian Reichel <sre@kernel.org>,
        Todd Kjos <tkjos@google.com>,
        Trilok Soni <tsoni@codeaurora.org>, rananta@codeaurora.org,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        open list <linux-kernel@vger.kernel.org>,
        "open list:THERMAL" <linux-pm@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH v2 1/2] reboot: Export reboot_mode
Message-ID: <YKudW3Z1PIrtN+6l@kroah.com>
References: <1573256452-14838-1-git-send-email-eberman@codeaurora.org>
 <1573256452-14838-2-git-send-email-eberman@codeaurora.org>
 <CAF2Aj3jYtL_42h_4W5zA8uz9e-QVquja70nARSRD4vbECVjxKw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAF2Aj3jYtL_42h_4W5zA8uz9e-QVquja70nARSRD4vbECVjxKw@mail.gmail.com>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Mon, May 24, 2021 at 01:09:18PM +0100, Lee Jones wrote:
> On Fri, 8 Nov 2019 at 23:41, Elliot Berman <eberman@codeaurora.org> wrote:
> 
> > Export reboot_mode to support kernel modules wishing to modify reboot_mode.
> >
> > Signed-off-by: Elliot Berman <eberman@codeaurora.org>
> > ---
> >  kernel/reboot.c | 2 ++
> >  1 file changed, 2 insertions(+)
> >
> 
> Reviewed by Bjorn and GregKH, but never merged.
> 
> I guess all the parties are still solving this downstream.
> 
> Andrew, is this still something you'd consider?

If there is no in-kernel user, it does not need to be exported.

thanks,

greg k-h
