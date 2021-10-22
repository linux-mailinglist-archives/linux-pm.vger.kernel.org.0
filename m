Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D12E34374AF
	for <lists+linux-pm@lfdr.de>; Fri, 22 Oct 2021 11:25:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232343AbhJVJ2L (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 22 Oct 2021 05:28:11 -0400
Received: from mail.kernel.org ([198.145.29.99]:50746 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232307AbhJVJ2L (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Fri, 22 Oct 2021 05:28:11 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 680A761108;
        Fri, 22 Oct 2021 09:25:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1634894753;
        bh=SIajMzLMNLMQsXTgkbt6SFijgk+sopysJiFHmBc20sQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=HAdmLtA1ZZ2p/8+7hX8RFGkNh6xtZgdqS7jgKxxH+Zvt2k3Re+7ga/Ysz95AgLTQe
         wJ9l+Jqauncd4An8QjuPZHkA1M+MZftAjlQ/xiufaDddRYc2GTug6w9W7Apq+nWCiq
         lTNI+K8kwQ/1kac8UhUgHMgiHV0rMsgIhlexSzIw=
Date:   Fri, 22 Oct 2021 11:25:32 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Georgi Djakov <djakov@kernel.org>
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [GIT PULL] interconnect changes for 5.16
Message-ID: <YXKDjMIqkasGXgJz@kroah.com>
References: <20211022091326.28826-1-djakov@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211022091326.28826-1-djakov@kernel.org>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Fri, Oct 22, 2021 at 12:13:26PM +0300, Georgi Djakov wrote:
> Hello Greg,
> 
> This is the pull request with interconnect changes for the 5.16-rc1
> merge window. It contains just driver updates. The details are in the
> signed tag.
> 
> All patches have been in linux-next for more than two weeks. No issues
> have been reported so far. Please pull into char-misc-next.
> 
> Thanks,
> Georgi
> 
> The following changes since commit 9e1ff307c779ce1f0f810c7ecce3d95bbae40896:
> 
>   Linux 5.15-rc4 (2021-10-03 14:08:47 -0700)
> 
> are available in the Git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/djakov/icc.git tags/icc-5.16-rc1

Pulled and pushed out, thanks.

greg k-h
