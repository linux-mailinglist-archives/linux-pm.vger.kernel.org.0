Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BAD322205E6
	for <lists+linux-pm@lfdr.de>; Wed, 15 Jul 2020 09:11:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728900AbgGOHLB (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 15 Jul 2020 03:11:01 -0400
Received: from mail.kernel.org ([198.145.29.99]:60828 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728523AbgGOHLA (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 15 Jul 2020 03:11:00 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 008F22065E;
        Wed, 15 Jul 2020 07:10:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1594797060;
        bh=36wFCTNbZVVPOhrcXgP71yVhuwrzj7gt7k6y5e5xpE8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=VbJKaZkyBgIiPNCppTGFtvmaobaT+B6feiSeRdf8SqHOtuIxsmT7+Pl20sfM5zOSl
         r334lvTCu9xrbDiGTi9POvi6NUD65CAckRHPGMlVmKZzgelcUeQDD5cfm9oNlxGnbO
         kyoOegLGizuip2IqB4XklEo+qR5mefLRjpYZ+avc=
Date:   Wed, 15 Jul 2020 09:10:56 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Qiwu Huang <yanziily@gmail.com>
Cc:     sre@kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, jiangfei1@xiaomi.com,
        Qiwu Huang <huangqiwu@xiaomi.com>
Subject: Re: [PATCH v3 5/5] power: supply: core: supply battery soc with
 decimal form
Message-ID: <20200715071056.GC2303720@kroah.com>
References: <cover.1594726859.git.huangqiwu@xiaomi.com>
 <7f59501fb0566895ea8d6656010c52f2a6a18ef8.1594726859.git.huangqiwu@xiaomi.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7f59501fb0566895ea8d6656010c52f2a6a18ef8.1594726859.git.huangqiwu@xiaomi.com>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Wed, Jul 15, 2020 at 08:35:23AM +0800, Qiwu Huang wrote:
> From: Qiwu Huang <huangqiwu@xiaomi.com>
> 
> Broadcast battery soc with decimal form.

What does "soc" mean?


> soc_decimal is the decimal part of battery soc.
> soc_decimal_rate is update frequency of decimal
> part of battery soc.
> We want to report such as 0.01 to 99.99% to
> user space to improve user experience
> when do very quick charging.

You can wrap your lines a bit longer, 72 columns is usually the normal
spot :)

thanks,

greg k-h
