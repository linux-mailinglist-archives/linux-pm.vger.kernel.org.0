Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0574D392F1E
	for <lists+linux-pm@lfdr.de>; Thu, 27 May 2021 15:07:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236097AbhE0NIm (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 27 May 2021 09:08:42 -0400
Received: from mail.kernel.org ([198.145.29.99]:38028 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236238AbhE0NIl (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Thu, 27 May 2021 09:08:41 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 4614C610CE;
        Thu, 27 May 2021 13:07:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1622120827;
        bh=01dJwNd6qp1AexQopdVxCxmr7y+a68LvCvjlNexTFFM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=R4E9PzeIZ05ne7FDPOIRY3FCNvgzv/dy7MBtRa97zkVmcH2hfXEWg6JYOZQXFv0Cf
         4Eu8HztGVVIBjT+5AYDn+IyRzymPF2/l7a/7A+ZkH9pihOnkFtE+y3YqrUy+Cb4LrU
         2epBAWeVnsx592PyW8GBwx0Ys96nH1Q/yJ96k/Dk=
Date:   Thu, 27 May 2021 15:07:05 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Georgi Djakov <djakov@kernel.org>
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        georgi.djakov@linaro.org
Subject: Re: [GIT PULL] interconnect fixes for 5.13-rc
Message-ID: <YK+ZeXvAnL2FK+Bu@kroah.com>
References: <20210527122255.31418-1-djakov@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210527122255.31418-1-djakov@kernel.org>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Thu, May 27, 2021 at 03:22:55PM +0300, Georgi Djakov wrote:
> Hello Greg,
> 
> This pull request contains a few tiny interconnect driver fixes for 5.13-rc.
> The details are in the signed tag. Please pull them into char-misc-linus
> when possible. The patches have been in linux-next for more than two weeks.
> 
> Thanks,
> Georgi
> 
> The following changes since commit 6efb943b8616ec53a5e444193dccf1af9ad627b5:
> 
>   Linux 5.13-rc1 (2021-05-09 14:17:44 -0700)
> 
> are available in the Git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/djakov/icc.git tags/icc-5.13-rc4

Pulled and pushed out, thanks.

greg k-h
