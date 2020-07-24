Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C920F22C8E9
	for <lists+linux-pm@lfdr.de>; Fri, 24 Jul 2020 17:24:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726366AbgGXPYg (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 24 Jul 2020 11:24:36 -0400
Received: from mail.kernel.org ([198.145.29.99]:45036 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726326AbgGXPYg (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Fri, 24 Jul 2020 11:24:36 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 963D4206E3;
        Fri, 24 Jul 2020 15:24:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1595604276;
        bh=ZqpyUTVflKeaRtY/KQGe4kgXjy2gBFpWOgD4ENKoBBg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=qxD0nw/iFD4oxXl7EvQoWVYj6PqvPabscTGu6AjfBUW6x0H5Q1Elakf7x4tgNqQc3
         mWNr/6HrC4td37VuSmv2TZfcRvj4FHqX0zmlki2Vr9r30O1kBU+D2TSSMrgD8EprPz
         bAKW8npQ0njRbRwPZDStoMi1oF6cbLoQzsWt4IbI=
Date:   Fri, 24 Jul 2020 17:24:37 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Georgi Djakov <georgi.djakov@linaro.org>
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [GIT PULL] interconnect changes for 5.9
Message-ID: <20200724152437.GA434121@kroah.com>
References: <20200724114244.12094-1-georgi.djakov@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200724114244.12094-1-georgi.djakov@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Fri, Jul 24, 2020 at 02:42:44PM +0300, Georgi Djakov wrote:
> Hello Greg,
> 
> This is the pull request with the interconnect changes for the 5.9-rc1
> merge window. It contains some tiny core framework improvements. These
> will allow us to support new provider drivers for Samsung and Nvidia
> platforms, which are expected to land soon.
> 
> All patches have been in linux-next for the last few weeks without any
> reported issues. Please pull into char-misc-next.
> 
> Thanks,
> Georgi
> 
> The following changes since commit b3a9e3b9622ae10064826dccb4f7a52bd88c7407:
> 
>   Linux 5.8-rc1 (2020-06-14 12:45:04 -0700)
> 
> are available in the Git repository at:
> 
>   https://git.linaro.org/people/georgi.djakov/linux.git tags/icc-5.9-rc1

Pulled and pushed out, thanks.

greg k-h
