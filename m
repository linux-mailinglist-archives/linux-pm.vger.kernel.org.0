Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 838C33505FC
	for <lists+linux-pm@lfdr.de>; Wed, 31 Mar 2021 20:07:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234511AbhCaSHI (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 31 Mar 2021 14:07:08 -0400
Received: from mail.kernel.org ([198.145.29.99]:47142 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234874AbhCaSGt (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 31 Mar 2021 14:06:49 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 3F6D760FEE;
        Wed, 31 Mar 2021 18:06:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1617214008;
        bh=SR9DbDE458AoE+SuuH6oOsUTJL6twomumSsFCFpUduA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=RrMaoErQutr/JjjleXYJ2KHOXbege8ByoAr4iCZjWFDULNFGM1RGzTjt/RAZkz3Z1
         0qH4gRg3LeNubqEolSFUqjIdTb4p05wBqgTdt9XlX9uRCzL3wwACZiAJHNqyQQbAwg
         t9K+FKEt1mYP9TjsLD4RNmFKf4LIr31L/IPOwyQs=
Date:   Wed, 31 Mar 2021 20:06:46 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        lukasz.luba@arm.com, rafael@kernel.org
Subject: Re: [PATCH v5 2/5] powercap/drivers/dtpm: Create a registering system
Message-ID: <YGS6NraFr6+qvzda@kroah.com>
References: <20210331110048.24956-1-daniel.lezcano@linaro.org>
 <20210331110048.24956-2-daniel.lezcano@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210331110048.24956-2-daniel.lezcano@linaro.org>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Wed, Mar 31, 2021 at 01:00:45PM +0200, Daniel Lezcano wrote:
> +struct dtpm *dtpm_lookup(const char *name);
> +
> +int dtpm_add(const char *name, struct dtpm *dtpm);
> +
> +void dtpm_del(const char *name);

You can not add new kernel apis that have no user.  How do you know if
they actually work or not?  We have no idea as we do not see anyone
using them :(

So no need to add things with no user, feel free to just drop this patch
until you have one.

thanks,

greg k-h
