Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 935A6310881
	for <lists+linux-pm@lfdr.de>; Fri,  5 Feb 2021 10:58:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230177AbhBEJ4E (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 5 Feb 2021 04:56:04 -0500
Received: from mail.kernel.org ([198.145.29.99]:49408 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230185AbhBEJyP (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Fri, 5 Feb 2021 04:54:15 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 2096464FBB;
        Fri,  5 Feb 2021 09:53:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1612518806;
        bh=Y8bJVG8zayY3p+rFdJDgw39QGpqNAHVQzjuo01HQbu4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=fp7A0FmKaCne3yXWodqq51CWTZUfBP6EJdOS8eGzbQvbV68N4XllqooRxMW8o0q3P
         eu+WmgDxHB/JgpcMuViTatTRe23bh1kvgJv88uLAWudjR40g1jC0Yls4aVeiyEz7eH
         lYIuiI0yuMLe3CGFDrUraYi4flA3u+hengBIy360=
Date:   Fri, 5 Feb 2021 10:53:23 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Yicong Yang <yangyicong@hisilicon.com>
Cc:     jdelvare@suse.com, linux@roeck-us.net, giometti@enneenne.com,
        abbotti@mev.co.uk, hsweeten@visionengravers.com, kw@linux.com,
        helgaas@kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-hwmon@vger.kernel.org,
        devel@driverdev.osuosl.org, linux-kbuild@vger.kernel.org,
        masahiroy@kernel.org, michal.lkml@markovi.net,
        linuxarm@openeuler.org, prime.zeng@huawei.com
Subject: Re: [PATCH 1/4] driver core: Use subdir-ccflags-* to inherit debug
 flag
Message-ID: <YB0Vk6ERJ3lFc3WD@kroah.com>
References: <1612518255-23052-1-git-send-email-yangyicong@hisilicon.com>
 <1612518255-23052-2-git-send-email-yangyicong@hisilicon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1612518255-23052-2-git-send-email-yangyicong@hisilicon.com>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Fri, Feb 05, 2021 at 05:44:12PM +0800, Yicong Yang wrote:
> From: Junhao He <hejunhao2@hisilicon.com>
> 
> Use subdir-ccflags-* instead of ccflags-* to inherit the debug
> settings from Kconfig when traversing subdirectories.

That says what you do, but not _why_ you are doing it.

What does this offer in benefit of the existing way?  What is it fixing?
Why do this "churn"?

thanks,

greg k-h
