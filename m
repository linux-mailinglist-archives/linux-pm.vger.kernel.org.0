Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CBC3125D7DE
	for <lists+linux-pm@lfdr.de>; Fri,  4 Sep 2020 13:52:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729582AbgIDLwO (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 4 Sep 2020 07:52:14 -0400
Received: from mail.kernel.org ([198.145.29.99]:55428 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728588AbgIDLwO (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Fri, 4 Sep 2020 07:52:14 -0400
Received: from localhost (83-86-74-64.cable.dynamic.v4.ziggo.nl [83.86.74.64])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 21F1F20791;
        Fri,  4 Sep 2020 11:52:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599220332;
        bh=oA5ZpR+IKkziVuvdJ8WZUrJXW1JY9oaKsUJTFfY4zeU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=zUoYImby912duewe/56eTe5zDCRF5BcFmxPk5+YnftYJWyD7iTprdp22tCWQXtuDw
         U5n69uRBPwh9crIeS1bHk9o42fVO75AynfR88s9aqZ4ZS7Fv6e5OpSmI8eDpyouHoB
         g4jexx9s3AyNzdrC1vBq5L3DR49v7DHDYu8L73Xw=
Date:   Fri, 4 Sep 2020 13:52:31 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Georgi Djakov <georgi.djakov@linaro.org>
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [GIT PULL] interconnect fixes for 5.9
Message-ID: <20200904115231.GA2964473@kroah.com>
References: <20200904114850.4306-1-georgi.djakov@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200904114850.4306-1-georgi.djakov@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Fri, Sep 04, 2020 at 02:48:50PM +0300, Georgi Djakov wrote:
> Hello Greg,
> 
> Here is a small pull request with interconnect fixes for 5.9-rc. Please
> take them into char-misc-linus when possible.
> 
> Thanks,
> Georgi
> 
> The following changes since commit f75aef392f869018f78cfedf3c320a6b3fcfda6b:
> 
>   Linux 5.9-rc3 (2020-08-30 16:01:54 -0700)
> 
> are available in the Git repository at:
> 
>   https://git.linaro.org/people/georgi.djakov/linux.git tags/icc-5.9-rc4

Pulled and pushed out,t hanks,

greg k-h
