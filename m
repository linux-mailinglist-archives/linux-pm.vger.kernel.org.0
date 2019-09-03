Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9D76EA73FE
	for <lists+linux-pm@lfdr.de>; Tue,  3 Sep 2019 21:49:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725962AbfICTtT (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 3 Sep 2019 15:49:19 -0400
Received: from mail.kernel.org ([198.145.29.99]:45340 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725939AbfICTtS (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Tue, 3 Sep 2019 15:49:18 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9EA2D20882;
        Tue,  3 Sep 2019 19:49:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1567540158;
        bh=HAGOtl8SPG8pETUP9XU4SnDqczahEFprNicQCkAJysA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=qWLUXKHde2suG63juiMAr7g5T0QCuZhAX7vkDmkKlvZadIQ8/iuX9mmtjgLf8v+0X
         vf8P4ZkI3SKdzsEnIzfTl9lR02VPe31h6WGzRgmkyv2Id83Uz7cLcrU2yfYX6GQ6Nc
         XMNghrUbnCD/enXKXkW4lYMwzjoT1F/6wMGA07sw=
Date:   Tue, 3 Sep 2019 21:48:52 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Georgi Djakov <georgi.djakov@linaro.org>
Cc:     Linux PM list <linux-pm@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [GIT PULL] interconnect changes for 5.4
Message-ID: <20190903194852.GB13390@kroah.com>
References: <97f47b2a-7aee-ab4b-7510-43c509db982a@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <97f47b2a-7aee-ab4b-7510-43c509db982a@linaro.org>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Fri, Aug 23, 2019 at 06:14:19PM +0300, Georgi Djakov wrote:
> Hi Greg,
> 
> This is a pull request with interconnect patches for the 5.4 merge window.
> The patches have been for a while in linux-next without reported issues. The
> details are in the signed tag. Please consider pulling into char-misc-next.
> 
> Thanks,
> Georgi
> 
> The following changes since commit d45331b00ddb179e291766617259261c112db872:
> 
>   Linux 5.3-rc4 (2019-08-11 13:26:41 -0700)
> 
> are available in the Git repository at:
> 
>   https://git.linaro.org/people/georgi.djakov/linux.git tags/icc-5.4-rc1

Pulled and pushed out, thanks.

greg k-h
