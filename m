Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DE3603F5F66
	for <lists+linux-pm@lfdr.de>; Tue, 24 Aug 2021 15:45:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229517AbhHXNqO (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 24 Aug 2021 09:46:14 -0400
Received: from mail.kernel.org ([198.145.29.99]:56474 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237606AbhHXNqJ (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Tue, 24 Aug 2021 09:46:09 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 8B85461246;
        Tue, 24 Aug 2021 13:45:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1629812725;
        bh=vmfWZQjf0dHkWA4rJ7lMnO8nONI09vPghIVY38m0VNU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=1tH63k9z0Aj1cBrAU7kkidgEl/sadCde+J+pc1BAYJ1HZ1eIzTFQaoVy2SU1gyT3D
         MWaFCII/wDvbqumxq/uq5JglPpQHDMor17EC8Xxu4zY/GCGUkhT36wBUo6TPDeTaGb
         AvzcBo69WOrCFa2GvQVN9neEmg0oL2GNP2rJKG8s=
Date:   Tue, 24 Aug 2021 15:34:01 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Georgi Djakov <djakov@kernel.org>
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [GIT PULL] interconnect changes for 5.15
Message-ID: <YST1SR4nbKsD1+Us@kroah.com>
References: <20210823153222.9638-1-djakov@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210823153222.9638-1-djakov@kernel.org>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Mon, Aug 23, 2021 at 06:32:22PM +0300, Georgi Djakov wrote:
> Hello Greg,
> 
> This is the pull request with the interconnect changes for the 5.15-rc1
> merge window containing framework and driver changes. Details are available
> in the signed tag.
> 
> Patches have been in linux-next for two weeks and without any reported
> issues. Please pull into char-misc-next.
> 
> Thanks,
> Georgi
> 
> The following changes since commit e73f0f0ee7541171d89f2e2491130c7771ba58d3:
> 
>   Linux 5.14-rc1 (2021-07-11 15:07:40 -0700)
> 
> are available in the Git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/djakov/icc.git tags/icc-5.15-rc1

Pulled and pushed out, thanks.

greg k-h
