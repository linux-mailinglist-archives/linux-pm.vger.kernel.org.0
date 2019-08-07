Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8D55D84A6C
	for <lists+linux-pm@lfdr.de>; Wed,  7 Aug 2019 13:14:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728670AbfHGLOb (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 7 Aug 2019 07:14:31 -0400
Received: from mail.kernel.org ([198.145.29.99]:38384 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726418AbfHGLOb (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 7 Aug 2019 07:14:31 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E29ED21922;
        Wed,  7 Aug 2019 11:14:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1565176470;
        bh=yj+w+2FGUwzolRtbAjvMXrqtqOjJq2qU956lKoaJuxQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=W+jGsK6Ad8+48CXBIWYMkIG46on/L5WdbTo6zm6210dHxJSGtFXJvoL0pJtgZuusv
         lL9pjozby0HTgydz5IaKT5EIurGvjEkqncfP5xEOHre3gWH4fszKPjA+b7IBL2jc8W
         AFTFPUM4jNltgIILpbQG/2a5abHV1qPPAoXTq2Cs=
Date:   Wed, 7 Aug 2019 13:14:28 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Tri Vo <trong@android.com>
Cc:     rjw@rjwysocki.net, viresh.kumar@linaro.org, rafael@kernel.org,
        hridya@google.com, sspatil@google.com, kaleshsingh@google.com,
        ravisadineni@chromium.org, swboyd@chromium.org,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        kernel-team@android.com
Subject: Re: [PATCH v8 2/3] PM / wakeup: Use wakeup_source_register() in
 wakelock.c
Message-ID: <20190807111428.GB16863@kroah.com>
References: <20190807014846.143949-1-trong@android.com>
 <20190807014846.143949-3-trong@android.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190807014846.143949-3-trong@android.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Tue, Aug 06, 2019 at 06:48:45PM -0700, Tri Vo wrote:
> kernel/power/wakelock.c duplicates wakeup source creation and
> registration code from drivers/base/power/wakeup.c.
> 
> Change struct wakelock's wakeup source to a pointer and use
> wakeup_source_register() function to create and register said wakeup
> source. Use wakeup_source_unregister() on cleanup path.
> 
> Signed-off-by: Tri Vo <trong@android.com>
> Reviewed-by: Stephen Boyd <swboyd@chromium.org>
> ---
>  kernel/power/wakelock.c | 32 +++++++++++++++++++-------------
>  1 file changed, 19 insertions(+), 13 deletions(-)

Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
