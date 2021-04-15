Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BF857360541
	for <lists+linux-pm@lfdr.de>; Thu, 15 Apr 2021 11:07:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231915AbhDOJH5 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 15 Apr 2021 05:07:57 -0400
Received: from mail.kernel.org ([198.145.29.99]:44850 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231725AbhDOJH5 (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Thu, 15 Apr 2021 05:07:57 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 640F361073;
        Thu, 15 Apr 2021 09:07:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1618477655;
        bh=UpKEx1Ic+uS0XKkk9Za8KD1453dzjRscUhZX/VZe7zY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=uxUZmabtUfb4rGYfzSfaikEo6QPcagJX/+ZKi+sPkBONDiN8obnW7B+1hHo7zLPDs
         SdUpCOOHJSXVe3pbgZRK7s010CjMOky3iUl7FN2cFp6fB+njIVJOuVMSvBKuhj5xhm
         WzlBlHVTP6d+Q8On/lcQv47cg8MxEG4bC/QNitiA=
Date:   Thu, 15 Apr 2021 11:07:16 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Georgi Djakov <djakov@kernel.org>
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        georgi.djakov@linaro.org
Subject: Re: [GIT PULL] interconnect changes for 5.13
Message-ID: <YHgCRJIoLB99WiB1@kroah.com>
References: <20210415080948.17167-1-djakov@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210415080948.17167-1-djakov@kernel.org>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Thu, Apr 15, 2021 at 11:09:48AM +0300, Georgi Djakov wrote:
> Hello Greg,
> 
> This is the pull request with the interconnect changes for the 5.13-rc1
> merge window. These include two new drivers.
> 
> Patches have been in linux-next without any reported issues. Please pull
> into char-misc-next.
> 
> Thanks,
> Georgi
> 
> The following changes since commit a38fd8748464831584a19438cbb3082b5a2dab15:
> 
>   Linux 5.12-rc2 (2021-03-05 17:33:41 -0800)
> 
> are available in the Git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/djakov/icc.git tags/icc-5.13-rc1

Pulled and pushed out, thanks.

greg k-h
