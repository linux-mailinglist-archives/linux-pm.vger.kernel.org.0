Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D34D218CE61
	for <lists+linux-pm@lfdr.de>; Fri, 20 Mar 2020 14:02:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726884AbgCTNCj (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 20 Mar 2020 09:02:39 -0400
Received: from mail.kernel.org ([198.145.29.99]:37590 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726814AbgCTNCj (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Fri, 20 Mar 2020 09:02:39 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id F09902070A;
        Fri, 20 Mar 2020 13:02:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1584709358;
        bh=796vTxH7O1EdHdkETYnGOjJMck+cJ1ILqR0TYnSw244=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=TQLCaZ8Grm5oL+Ddf7jvqGxg18ywLixVgW8bskWtxbEnd8ca+i06amSC+rwNzCJP7
         a/hBV1dVtRs1I1mCG5P2fmN0lELjcmC8tNMQr5CzwideWed2I5gWGfzApCL1pQ0kYW
         WVVJ8eRrACpUXKXlljFr0001RQEr8iImupsdMNkc=
Date:   Fri, 20 Mar 2020 14:02:05 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Georgi Djakov <georgi.djakov@linaro.org>
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [GIT PULL] interconnect changes for 5.7
Message-ID: <20200320130205.GA510387@kroah.com>
References: <20200320111019.10970-1-georgi.djakov@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200320111019.10970-1-georgi.djakov@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Fri, Mar 20, 2020 at 01:10:19PM +0200, Georgi Djakov wrote:
> Hi Greg,
> 
> Here is a pull request with interconnect changes for the 5.7-rc1 merge
> window. It contains just driver updates, and these are:
> 
> - Refactoring of the SDM845 driver, which is now improved to better
> represent the hardware.
> - New driver for SC7180 platforms.
> - New driver for OSM L3 interconnect hardware found on SDM845/SC7180
> platforms.
> 
> All of these have been in linux-next for more than two weeks without any
> reported issues. Please pull into char-misc-next.
> 
> Thanks,
> Georgi
> 
> The following changes since commit 11a48a5a18c63fd7621bb050228cebf13566e4d8:
> 
>   Linux 5.6-rc2 (2020-02-16 13:16:59 -0800)
> 
> are available in the Git repository at:
> 
>   https://git.linaro.org/people/georgi.djakov/linux.git tags/icc-5.7-rc1

Pulled and pushed out,t hanks.

greg k-h
