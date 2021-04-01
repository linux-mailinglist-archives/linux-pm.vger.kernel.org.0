Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F0EAC350EC5
	for <lists+linux-pm@lfdr.de>; Thu,  1 Apr 2021 08:03:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233255AbhDAGCs (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 1 Apr 2021 02:02:48 -0400
Received: from mail.kernel.org ([198.145.29.99]:43602 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233624AbhDAGCf (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Thu, 1 Apr 2021 02:02:35 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 4B02361057;
        Thu,  1 Apr 2021 06:02:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1617256954;
        bh=lepMH2/hdTH/KNVW2YfmkXWtiUi9q0Zli/keu5PtDyc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=rPRgBe1KHzV8ulzHc3Pjf7quvRbISrZQUU8Byemfde8OchAIBtK5qMdfsPTwfuTPZ
         NNJA3g4NaYKdM/B5De5kipbrhXMXKt0/lsntm9qjTA5N3G/V+S7v4yCOcOeKP5GUB0
         ii00O6QCxOGO/3EIllB3Og4Dma05k+HCNucze1Xw=
Date:   Thu, 1 Apr 2021 08:02:30 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        lukasz.luba@arm.com, rafael@kernel.org
Subject: Re: [PATCH v5 2/5] powercap/drivers/dtpm: Create a registering system
Message-ID: <YGVh9onNL7hVu2mr@kroah.com>
References: <20210331110048.24956-1-daniel.lezcano@linaro.org>
 <20210331110048.24956-2-daniel.lezcano@linaro.org>
 <YGS6NraFr6+qvzda@kroah.com>
 <918bc42d-0bd7-753c-1132-fd19617349ed@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <918bc42d-0bd7-753c-1132-fd19617349ed@linaro.org>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Wed, Mar 31, 2021 at 10:46:48PM +0200, Daniel Lezcano wrote:
> 
> Hi Greg,
> 
> On 31/03/2021 20:06, Greg KH wrote:
> > On Wed, Mar 31, 2021 at 01:00:45PM +0200, Daniel Lezcano wrote:
> >> +struct dtpm *dtpm_lookup(const char *name);
> >> +
> >> +int dtpm_add(const char *name, struct dtpm *dtpm);
> >> +
> >> +void dtpm_del(const char *name);
> > 
> > You can not add new kernel apis that have no user.  How do you know if
> > they actually work or not?  We have no idea as we do not see anyone
> > using them :(
> > 
> > So no need to add things with no user, feel free to just drop this patch
> > until you have one.
> 
> I've sent a couple of patches [1] on top of the previous series. I'm
> finishing to respin it against this new one.
> 
>   -- Daniel
> 
> [1] https://lkml.org/lkml/2021/3/12/1514

Please use lore.kernel.org, we do not control lkml and it has been down
in the past and it's impossible to reply from.

Please always provide a user of a function in the patch series,
otherwise you will end up with comments like mine above.

thanks,

greg k-h
