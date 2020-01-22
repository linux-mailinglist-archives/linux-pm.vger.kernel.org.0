Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 59A6E144E6B
	for <lists+linux-pm@lfdr.de>; Wed, 22 Jan 2020 10:15:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726004AbgAVJPD (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 22 Jan 2020 04:15:03 -0500
Received: from mail.kernel.org ([198.145.29.99]:60464 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725911AbgAVJPD (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 22 Jan 2020 04:15:03 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8ED8F24655;
        Wed, 22 Jan 2020 09:15:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579684503;
        bh=iuoQ9ROZAVaX3fCqCWkSIxB+vlYmk6p4ecDWGlcgsjg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=wZQaQ9/9UJ/TkedHsWtISByXdujnpCuCV2Jf5yR5YJMNcyrq54+j2qiHOC+hQWe6k
         h4le40QcciUYWM1Zgitwh+M5jHTxDfvQty8I3AVuLURDi/OfNTL+bWzrhsU7mACwIn
         u1y3Eh7jnQnwVZik7+ykba5aLvCDqIjD9riMVKWc=
Date:   Wed, 22 Jan 2020 10:15:00 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Georgi Djakov <georgi.djakov@linaro.org>
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [GIT PULL 00/12] interconnect changes for 5.6
Message-ID: <20200122091500.GA2688796@kroah.com>
References: <20200117095816.23575-1-georgi.djakov@linaro.org>
 <ec627a0c-3f84-2b7b-e42b-36cb46ceb594@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ec627a0c-3f84-2b7b-e42b-36cb46ceb594@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Wed, Jan 22, 2020 at 11:07:25AM +0200, Georgi Djakov wrote:
> Hi Greg,
> 
> On 1/17/20 11:58, Georgi Djakov wrote:
> > Hi Greg,
> > 
> > Here are the interconnect patches for the 5.6-rc1 merge window.
> > 
> > - New core helper functions for some common functionalities in drivers.
> > - Improvements in the information exposed via debugfs.
> > - Basic tracepoints support.
> > - New interconnect driver for msm8916 platforms.
> > - Misc fixes.
> > 
> > All patches have been for a while in linux-next without reported issues.
> > Please consider queuing them into char-misc-next.
> > 
> > The same is also available via a pull request with a signed tag below.
> > 
> > Thanks,
> > Georgi
> 
> A gentle ping to check whether this email got lost or you require any
> changes?

I think our emails crossed, I had just pulled this :)

