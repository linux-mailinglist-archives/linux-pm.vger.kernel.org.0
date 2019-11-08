Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AF669F57C5
	for <lists+linux-pm@lfdr.de>; Fri,  8 Nov 2019 21:06:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388431AbfKHTkB (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 8 Nov 2019 14:40:01 -0500
Received: from mail.kernel.org ([198.145.29.99]:58232 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387400AbfKHTkB (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Fri, 8 Nov 2019 14:40:01 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9C789206A3;
        Fri,  8 Nov 2019 19:40:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1573242001;
        bh=4fvcXoQrLQoe/vprz0nZ+KmDe8Yp2GAbg+rTjWJa0aI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=NhBIZm/6BG/c5T1CLVBHAKCtUg/vuja0uU0itTuGOvs1Yz9dTz6O/jC7PjO9G3b2Y
         huKuAnTQ34FWmUsIifIsdISkRYEpjDSkuPT14s/KYG1HrHkSIonQ+6nJQIC6W1dClG
         zVblPJbwpmXT2kDMsW5t9bsmC8jbHqeqw30DV748=
Date:   Fri, 8 Nov 2019 20:39:58 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Elliot Berman <eberman@codeaurora.org>
Cc:     sre@kernel.org, tkjos@google.com, tsoni@codeaurora.org,
        rananta@codeaurora.org, bjorn.andersson@linaro.org,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Subject: Re: [PATCH 1/2] reboot: Export reboot_mode
Message-ID: <20191108193958.GA1273544@kroah.com>
References: <1573241532-21554-1-git-send-email-eberman@codeaurora.org>
 <1573241532-21554-2-git-send-email-eberman@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1573241532-21554-2-git-send-email-eberman@codeaurora.org>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Fri, Nov 08, 2019 at 11:32:11AM -0800, Elliot Berman wrote:
> Export reboot_mode to support DLKMs wishing to modify reboot_mode.

"DLKMs"?  What's that?

A kernel module?

> 
> Signed-off-by: Elliot Berman <eberman@codeaurora.org>
> ---
>  kernel/reboot.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/kernel/reboot.c b/kernel/reboot.c
> index c4d472b..6518370 100644
> --- a/kernel/reboot.c
> +++ b/kernel/reboot.c
> @@ -32,7 +32,9 @@ EXPORT_SYMBOL(cad_pid);
>  #define DEFAULT_REBOOT_MODE
>  #endif
>  enum reboot_mode reboot_mode DEFAULT_REBOOT_MODE;
> +EXPORT_SYMBOL(reboot_mode);
>  enum reboot_mode panic_reboot_mode = REBOOT_UNDEFINED;
> +EXPORT_SYMBOL(panic_reboot_mode);

EXPORT_SYMBOL_GPL() perhaps?

thanks,

greg k-h
