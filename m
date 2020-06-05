Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B4A511EF6E1
	for <lists+linux-pm@lfdr.de>; Fri,  5 Jun 2020 13:56:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726324AbgFEL4y (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 5 Jun 2020 07:56:54 -0400
Received: from mail-ot1-f67.google.com ([209.85.210.67]:44339 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726314AbgFEL4y (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 5 Jun 2020 07:56:54 -0400
Received: by mail-ot1-f67.google.com with SMTP id e5so7351197ote.11;
        Fri, 05 Jun 2020 04:56:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=qInNzFs9OuInC8XUdISfvho2DGF8I27nH1b8Z9VVeDA=;
        b=j5JzhS49igjJPCiKhvbCUw8tHRafRRt5fj/pYCDuMjW+zEUJmXI0tseXCONtO1fV6e
         lzBDHS3P6ux8UHfMHa54FMY26YIxPru/LLkbWXYWNSlbMrBmDM1oVM2MavUlqeZ3h6Kb
         RDEe4YBspnvsIuWPPs1pe5/ReSsBwZNlHOJyhlXBs372xYgGidHR2P+9OIcA/X7EBKS+
         HV6LkBG2+KA7byPJ9zTdtRF/QEB5AMTqsKRKrw3CqBjqeC0u1TECBkrWdGBS09cXbHMN
         Lby+kUzQWKj0nnUFBOaSeJDUGoU5wN/aFU5EEhfmIxZsjxITKpSx/tDuoSmloTn15YjV
         +ZJg==
X-Gm-Message-State: AOAM530XUO6MWPjmCnKq9lST2UvhVu/cBmnMGkU6ipbmifZEi5RQ2Ypo
        z/6APCQ2a+Dw5cka/WmRAcSSUqUPJDKqRvW6r+8=
X-Google-Smtp-Source: ABdhPJxRLaIx3AEGb1LLnk6ZGsFvh4ZBuPVgMUwGbOd63KGxEAuLoT1dNUTMppRydnaZ9O3PLo5VZ1HV+Bn9eWw2Yxo=
X-Received: by 2002:a9d:39f5:: with SMTP id y108mr701232otb.262.1591358212129;
 Fri, 05 Jun 2020 04:56:52 -0700 (PDT)
MIME-Version: 1.0
References: <20200531210059.647066-1-christophe.jaillet@wanadoo.fr>
In-Reply-To: <20200531210059.647066-1-christophe.jaillet@wanadoo.fr>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Fri, 5 Jun 2020 13:56:41 +0200
Message-ID: <CAJZ5v0gCZtAxsLi8LdDDDnUg6resj8WvKOberoJ+9VznwWpmAQ@mail.gmail.com>
Subject: Re: [PATCH] kernel: power: swap: mark a function as __init to save
 some memory
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Pavel Machek <pavel@ucw.cz>, Len Brown <len.brown@intel.com>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        kernel-janitors@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Sun, May 31, 2020 at 11:01 PM Christophe JAILLET
<christophe.jaillet@wanadoo.fr> wrote:
>
> 'swsusp_header_init()' is only called via 'core_initcall'.
> It can be marked as __init to save a few bytes of memory.
>
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
> ---
>  kernel/power/swap.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/kernel/power/swap.c b/kernel/power/swap.c
> index ca0fcb5ced71..01e2858b5fe3 100644
> --- a/kernel/power/swap.c
> +++ b/kernel/power/swap.c
> @@ -1590,7 +1590,7 @@ int swsusp_unmark(void)
>  }
>  #endif
>
> -static int swsusp_header_init(void)
> +static int __init swsusp_header_init(void)
>  {
>         swsusp_header = (struct swsusp_header*) __get_free_page(GFP_KERNEL);
>         if (!swsusp_header)
> --

Applied as 5.8-rc material under the "PM: hibernate: Add __init
annotation to swsusp_header_init()" subject, thanks!
