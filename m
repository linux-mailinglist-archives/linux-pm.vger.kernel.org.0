Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 110002EC2D1
	for <lists+linux-pm@lfdr.de>; Wed,  6 Jan 2021 18:55:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726532AbhAFRyb (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 6 Jan 2021 12:54:31 -0500
Received: from mail.kernel.org ([198.145.29.99]:56304 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725890AbhAFRyb (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 6 Jan 2021 12:54:31 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 2AB122311B;
        Wed,  6 Jan 2021 17:53:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1609955630;
        bh=XJAFZWjemspt3J3J50rFVt4EXzDZy7yr03zuq4DmAZM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=zyY/fhCN7PFvWNCFVWkApb57WslG6VmiV82fLHDf/td1HyrfaeGcsMYzET3bx33s5
         ZDTefrLU6ail6u34jEw7r+ZPTDKEMuLyVvKFGUAX7S0sycBPReFbH8GSiN7UufdIuG
         qTi6EUUPEjXaAMq23ARr4AHqrifltGxMEmz7XwfY=
Date:   Wed, 6 Jan 2021 18:55:06 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Georgi Djakov <georgi.djakov@linaro.org>
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [GIT PULL] interconnect fixes for 5.11-rc
Message-ID: <X/X5euQ0xgzVv/0R@kroah.com>
References: <20210106094723.563-1-georgi.djakov@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210106094723.563-1-georgi.djakov@linaro.org>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Wed, Jan 06, 2021 at 11:47:23AM +0200, Georgi Djakov wrote:
> Hello Greg,
> 
> Here is a pull request with a few interconnect fixes for 5.11-rc.
> More details are available in the signed tag. Please take them into
> char-misc-linus when possible. The patches have been in linux-next
> during the last few days.
> 
> Thanks,
> Georgi
> 
> The following changes since commit 5c8fe583cce542aa0b84adc939ce85293de36e5e:
> 
>   Linux 5.11-rc1 (2020-12-27 15:30:22 -0800)
> 
> are available in the Git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/djakov/icc.git tags/icc-5.11-rc3

Pulled and pushed out, thanks.

greg k-h
