Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E80DF190E2B
	for <lists+linux-pm@lfdr.de>; Tue, 24 Mar 2020 13:54:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727385AbgCXMyA (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 24 Mar 2020 08:54:00 -0400
Received: from mail-oi1-f195.google.com ([209.85.167.195]:46096 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727225AbgCXMyA (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 24 Mar 2020 08:54:00 -0400
Received: by mail-oi1-f195.google.com with SMTP id q204so10494512oia.13;
        Tue, 24 Mar 2020 05:54:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=U2wacXSgZRrqld91nBc+2P+qMpfsyfKnAMjLEtgLRG4=;
        b=os2wygwx9Ubr6F4iCHo5w5vJxejnZVsA5ujDrN1N14BXS/m8LvgaVSb5fNrKng0br/
         UzDug9F9TkoFZMM6mGLSlqPSlQOU2PdPtsUDPQrLQPh4ySuPNM3YQfPLX88hVONHkzHz
         fPyidMz/x+Qrdlu5VqFCSZOtDC2trRyrgL2hes0NCBOD4BJeDsLGvPmp4jIe6Y3J8JKr
         2SyhUkWBNYvh7AlJ92Lzzm5OGxPd7LP+bVJx+WgQe0q3LbzxpkvqUHhlL7tYqj241HUJ
         mDKhddduuCS4ql9EbQ+u5LN/PhrzuWwEYBNRc1Ep8hy0s4peshP9qFU/B+enKsfvViYG
         9v/Q==
X-Gm-Message-State: ANhLgQ1VXyoZbgy3v4AttphauVba/nKDpnTJ96RxQILxTfytcVX9+SSn
        EzT9uxtKTew3hdA92jYM/7ni4hNj15F5FvUi/6I=
X-Google-Smtp-Source: ADFU+vu7lVRzij8BdL1iZw5BZVh5vAngXo/3An/UPrFI5dVBYGsPsfi/P3xlGxQQEheZNQWTIsm/Frn0qvjDay39+WI=
X-Received: by 2002:aca:5155:: with SMTP id f82mr3313363oib.103.1585054439854;
 Tue, 24 Mar 2020 05:53:59 -0700 (PDT)
MIME-Version: 1.0
References: <20200324122023.9649-1-andriy.shevchenko@linux.intel.com> <20200324122023.9649-3-andriy.shevchenko@linux.intel.com>
In-Reply-To: <20200324122023.9649-3-andriy.shevchenko@linux.intel.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Tue, 24 Mar 2020 13:53:49 +0100
Message-ID: <CAJZ5v0gg=V8uDd4afJ3MULsgKYvWajKJioANk4jj7xEhBzrRrQ@mail.gmail.com>
Subject: Re: [PATCH v2 3/3] driver core: Replace open-coded list_last_entry()
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Tue, Mar 24, 2020 at 1:20 PM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
>
> There is a place in the code where open-coded version of list entry accessors
> list_last_entry() is used.
>
> Replace that with the standard macro.
>
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Reviewed-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

> ---
> v2: no change
>  drivers/base/dd.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/base/dd.c b/drivers/base/dd.c
> index efd0e4c16ba5..27a4d51b5bba 100644
> --- a/drivers/base/dd.c
> +++ b/drivers/base/dd.c
> @@ -1226,7 +1226,7 @@ void driver_detach(struct device_driver *drv)
>                         spin_unlock(&drv->p->klist_devices.k_lock);
>                         break;
>                 }
> -               dev_prv = list_entry(drv->p->klist_devices.k_list.prev,
> +               dev_prv = list_last_entry(&drv->p->klist_devices.k_list,
>                                      struct device_private,
>                                      knode_driver.n_node);
>                 dev = dev_prv->device;
> --
> 2.25.1
>
