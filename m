Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 060B84197C2
	for <lists+linux-pm@lfdr.de>; Mon, 27 Sep 2021 17:23:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235030AbhI0PYn (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 27 Sep 2021 11:24:43 -0400
Received: from mail.kernel.org ([198.145.29.99]:60566 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235090AbhI0PYn (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Mon, 27 Sep 2021 11:24:43 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id C0F1B61041;
        Mon, 27 Sep 2021 15:23:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1632756185;
        bh=b23haRgxEOPZmLbMCC2otMaH8H2mn6jOjJHNVyjJXGU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=p9SYy7RzafC0ikpcGCsYBtuQHpEmCYmFmg5igLLazoWx/HFU2V6a3Udk6ZkxlRkw7
         DNqci2d8AUIXGzcYsmNxK9eJAQBg7HJvMS4F4zps6t7wN3oiCm07dUAtf1JEHWZddC
         uHXxzf+FXH4Q/g7QPlSFM0+HIDW0frD2uGmJlNF4=
Date:   Mon, 27 Sep 2021 17:23:01 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Georgi Djakov <djakov@kernel.org>
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [GIT PULL] interconnect fixes for 5.15-rc
Message-ID: <YVHh1WHV1SzUeecU@kroah.com>
References: <20210924131451.31371-1-djakov@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210924131451.31371-1-djakov@kernel.org>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Fri, Sep 24, 2021 at 04:14:51PM +0300, Georgi Djakov wrote:
> Hello Greg,
> 
> This pull request contains interconnect driver fixes for 5.15-rc.
> The details are in the signed tag. Please pull them into char-misc-linus
> when possible. The patches have been in linux-next during the last few
> days.
> 
> Thanks,
> Georgi
> 
> The following changes since commit 6880fa6c56601bb8ed59df6c30fd390cc5f6dd8f:
> 
>   Linux 5.15-rc1 (2021-09-12 16:28:37 -0700)
> 
> are available in the Git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/djakov/icc.git tags/icc-5.15-rc3

Pulled and pushed out, thanks.

greg k-h
