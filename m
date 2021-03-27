Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 85FD734B6DB
	for <lists+linux-pm@lfdr.de>; Sat, 27 Mar 2021 12:43:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230420AbhC0Ln5 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sat, 27 Mar 2021 07:43:57 -0400
Received: from mail.kernel.org ([198.145.29.99]:51700 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230288AbhC0Ln5 (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Sat, 27 Mar 2021 07:43:57 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 2AB2160C40;
        Sat, 27 Mar 2021 11:43:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1616845436;
        bh=95hulK7NfqIjV7CFH5YuyGaaZJhEO5HRIqLyyBSU0ZA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=RURTVUa4AIk+H1Y6DBJfg+R7+FtzteRCrfqDEf0czMlVrTRqiU0CF2UcB73YknMQ9
         9g+8MAqwbHzxq2uYtGGOI/Fy6oXM3Ahnz6c1KGwT96iC8vbsU6M2UfWi+jUUFkT5Z6
         qSdj5pjDcerguzHY03kiAuYgzw6Y6c7baxgw6G5c=
Date:   Sat, 27 Mar 2021 12:43:54 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Georgi Djakov <djakov@kernel.org>
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        georgi.djakov@linaro.org
Subject: Re: [GIT PULL] interconnect fixes for 5.12-rc
Message-ID: <YF8aev/+soLjlMM0@kroah.com>
References: <20210326164603.28202-1-djakov@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210326164603.28202-1-djakov@kernel.org>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Fri, Mar 26, 2021 at 06:46:03PM +0200, Georgi Djakov wrote:
> Hello Greg,
> 
> Here is a pull request with a few tiny interconnect fixes for 5.12-rc.
> The details are in the signed tag. Please take them into char-misc-linus
> when possible. The patches have been in linux-next for more than a week.
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
>   git://git.kernel.org/pub/scm/linux/kernel/git/djakov/icc.git tags/icc-5.12-rc5

Pulled and pushed out, thanks.

greg k-h
