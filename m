Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 790F22ECE90
	for <lists+linux-pm@lfdr.de>; Thu,  7 Jan 2021 12:20:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727954AbhAGLTP (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 7 Jan 2021 06:19:15 -0500
Received: from mail.kernel.org ([198.145.29.99]:34864 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727949AbhAGLTO (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Thu, 7 Jan 2021 06:19:14 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 45A63221E9;
        Thu,  7 Jan 2021 11:18:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1610018313;
        bh=CePN95XLwXDP+83fIST32f96djP/fsYDPjd7ZQQqssE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=CvcbyZghY1IZ0LMMm4/G0bzhADIvVPiSVZV5KPz7ymJR9nh21WnJfhS8ZiEkiKHzh
         ThOq6gaB3jUxM0bZNjGA/gBalhLpkEevIRh34dOhKBHD0Anvs5Z3IJt3vwaxzuZJr1
         E70cv6nLVBA4US15UPVZVFIEuT44YmR52B8WHQaw=
Date:   Thu, 7 Jan 2021 12:19:53 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Georgi Djakov <georgi.djakov@linaro.org>
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [GIT PULL] interconnect fixes for 5.11-rc
Message-ID: <X/buWeMxnoIs8ck4@kroah.com>
References: <20210106094723.563-1-georgi.djakov@linaro.org>
 <X/X5euQ0xgzVv/0R@kroah.com>
 <16762fad-e814-6f74-333e-71676aa4b90d@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <16762fad-e814-6f74-333e-71676aa4b90d@linaro.org>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Thu, Jan 07, 2021 at 01:12:14PM +0200, Georgi Djakov wrote:
> On 1/6/21 19:55, Greg KH wrote:
> > On Wed, Jan 06, 2021 at 11:47:23AM +0200, Georgi Djakov wrote:
> > > Hello Greg,
> > > 
> > > Here is a pull request with a few interconnect fixes for 5.11-rc.
> > > More details are available in the signed tag. Please take them into
> > > char-misc-linus when possible. The patches have been in linux-next
> > > during the last few days.
> > > 
> > > Thanks,
> > > Georgi
> > > 
> > > The following changes since commit 5c8fe583cce542aa0b84adc939ce85293de36e5e:
> > > 
> > >    Linux 5.11-rc1 (2020-12-27 15:30:22 -0800)
> > > 
> > > are available in the Git repository at:
> > > 
> > >    git://git.kernel.org/pub/scm/linux/kernel/git/djakov/icc.git tags/icc-5.11-rc3
> > 
> > Pulled and pushed out, thanks.
> > 
> Hi Greg,
> 
> I still don't see this in your tree, so just checking whether i need to fix
> something or some script is stuck? Or maybe I just need to be more patient,
> since you haven't had a chance to push yet.

{sigh}

I forgot the "push" part of the above statement :)

Should now be there, sorry about that.

greg k-h
