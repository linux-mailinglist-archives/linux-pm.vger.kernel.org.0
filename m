Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 464E83B0E06
	for <lists+linux-pm@lfdr.de>; Tue, 22 Jun 2021 22:04:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232631AbhFVUGa (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 22 Jun 2021 16:06:30 -0400
Received: from mail.kernel.org ([198.145.29.99]:41572 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232635AbhFVUGa (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Tue, 22 Jun 2021 16:06:30 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 2DBB1610C7;
        Tue, 22 Jun 2021 20:04:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1624392253;
        bh=HbvbSy/HRZY6zA5I4C/FEjDlqXRXldMOtDVFvU50wp4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=wAnLxxkk7Wy9pBFtsv3bGRAmA8SdXxAh8+G3cO8mcYAGVCdPYLOac/RPnD0YbbHdV
         4z1Zc26JCl/yurIIXTPsS2Q1bf5P+yNLkE+b5pGjhdEiwFY5z6KuO58gfsiSf0S30r
         0lx0JJWFlpzPJCyRkZDemxOrUQqcVitwzPQfIi14=
Date:   Tue, 22 Jun 2021 22:04:11 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Georgi Djakov <djakov@kernel.org>
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [GIT PULL] interconnect changes for 5.14
Message-ID: <YNJCO/KMY+cj3Ped@kroah.com>
References: <20210622124337.26529-1-djakov@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210622124337.26529-1-djakov@kernel.org>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Tue, Jun 22, 2021 at 03:43:37PM +0300, Georgi Djakov wrote:
> Hello Greg,
> 
> This is the pull request with the interconnect changes for the 5.14-rc1
> merge window containing driver changes.
> 
> Patches have been in linux-next for more than a month and without any
> reported issues. Please pull into char-misc-next.
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
>   git://git.kernel.org/pub/scm/linux/kernel/git/djakov/icc.git tags/icc-5.14-rc1

Pulled and pushed out, thanks.

greg k-h
