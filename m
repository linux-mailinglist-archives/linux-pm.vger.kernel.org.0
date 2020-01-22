Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 47FB5144E2F
	for <lists+linux-pm@lfdr.de>; Wed, 22 Jan 2020 10:06:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725970AbgAVJF7 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 22 Jan 2020 04:05:59 -0500
Received: from mail.kernel.org ([198.145.29.99]:54802 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725911AbgAVJF7 (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 22 Jan 2020 04:05:59 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1190824125;
        Wed, 22 Jan 2020 09:05:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579683958;
        bh=ACdgyHgVO+oxxxaGgy1XHNef+vgnij9AxwNKIEgKQOg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=sKOSI4efdRAs3/snKdm8nnPxLlePssAbtuA3wfsptRBIHgncjocyZfCWJjimdPM87
         Jqn6nl4zWPwBlm8UVpOGkY4GPxCf0letEfA0TjxdZR7GKoMFIr+gtS/QiNGe02uK8S
         4q3lKny/EYCZj4QU7ucLRyrrb/3HAz16zaP2x0/U=
Date:   Wed, 22 Jan 2020 10:05:56 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Georgi Djakov <georgi.djakov@linaro.org>
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [GIT PULL 00/12] interconnect changes for 5.6
Message-ID: <20200122090556.GA2613910@kroah.com>
References: <20200117095816.23575-1-georgi.djakov@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200117095816.23575-1-georgi.djakov@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Fri, Jan 17, 2020 at 11:58:04AM +0200, Georgi Djakov wrote:
> Hi Greg,
> 
> Here are the interconnect patches for the 5.6-rc1 merge window.
> 
> - New core helper functions for some common functionalities in drivers.
> - Improvements in the information exposed via debugfs.
> - Basic tracepoints support.
> - New interconnect driver for msm8916 platforms.
> - Misc fixes.
> 
> All patches have been for a while in linux-next without reported issues.
> Please consider queuing them into char-misc-next.
> 
> The same is also available via a pull request with a signed tag below.
> 
> Thanks,
> Georgi
> 
> The following changes since commit d1eef1c619749b2a57e514a3fa67d9a516ffa919:
> 
>   Linux 5.5-rc2 (2019-12-15 15:16:08 -0800)
> 
> are available in the Git repository at:
> 
>   https://git.linaro.org/people/georgi.djakov/linux.git tags/icc-5.6-rc1

Pulled and pushed out, thanks.

greg k-h
