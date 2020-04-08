Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0FB781A2233
	for <lists+linux-pm@lfdr.de>; Wed,  8 Apr 2020 14:39:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727505AbgDHMj6 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 8 Apr 2020 08:39:58 -0400
Received: from mail-oi1-f196.google.com ([209.85.167.196]:34127 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726977AbgDHMj6 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 8 Apr 2020 08:39:58 -0400
Received: by mail-oi1-f196.google.com with SMTP id d3so4564250oic.1
        for <linux-pm@vger.kernel.org>; Wed, 08 Apr 2020 05:39:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=kkV5aCqmaPlq4Pm4QUUj93so6eB1aJOk2q+C8E8j918=;
        b=IA6vCtQ0XXVm/N25pZmxM03jl9Eh1MJQMGevZ3qzJlXJ5gKoUSB8RlRQq/vRiAhq57
         zAIiwTYPUMVBfwW4Fprs5AqiqEnOBdNLsNbWtYB8EvTHD0dEsbkJQgPsNPYUbrwJjxet
         MB6IH8iM/bWyF9Wowr43vXaylWuLUpSemQcN28Y7fUPKI8A8QFvA+gdqwOeOywFEj801
         kHMpbAbv7a2IKZKmQLM/A8XuEQS3UQ0YTXBMYI/1D+Jk6iW8rin4TlA0goQGhgQq3ngy
         lOg4PlDzQNyI1LEUe3YfETLs00Ko5+Pi9dMjeLLv3cYFRJgL4ZJGuaFlrzgorJN2ij27
         iJbQ==
X-Gm-Message-State: AGi0PuYrxKQTx/RceuwDKJq2HS4/koivSKiRnp+dUuNq4zdgft5EQRmL
        dLPhg+6JXW+olAJBcPOiaK8gsy1S3HRvGH9I6Go=
X-Google-Smtp-Source: APiQypIYg1P9XwBga4EuUql+E3lgJ74CAAUUc4SdCxsxnK/B2w++R0oXKeSdczs6nSH8CyuuwX7jM0yUx30JDIsUbGo=
X-Received: by 2002:aca:f07:: with SMTP id 7mr2204476oip.68.1586349597157;
 Wed, 08 Apr 2020 05:39:57 -0700 (PDT)
MIME-Version: 1.0
References: <20200408024412.41402-1-yanaijie@huawei.com>
In-Reply-To: <20200408024412.41402-1-yanaijie@huawei.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Wed, 8 Apr 2020 14:39:45 +0200
Message-ID: <CAJZ5v0j=vzb-p7kr0yiV5P_Y8UYxn0xQ4Ms4r1My9t=d-vvqHA@mail.gmail.com>
Subject: Re: [PATCH] ACPI, x86/boot: make acpi_nobgrt static
To:     Jason Yan <yanaijie@huawei.com>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Wed, Apr 8, 2020 at 4:45 AM Jason Yan <yanaijie@huawei.com> wrote:
>
> Fix the following sparse warning:
>
> arch/x86/kernel/acpi/boot.c:48:5: warning: symbol 'acpi_nobgrt' was not
> declared. Should it be static?
>
> Reported-by: Hulk Robot <hulkci@huawei.com>
> Signed-off-by: Jason Yan <yanaijie@huawei.com>
> ---
>  arch/x86/kernel/acpi/boot.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/arch/x86/kernel/acpi/boot.c b/arch/x86/kernel/acpi/boot.c
> index 1ae5439a9a85..683ed9e12e6b 100644
> --- a/arch/x86/kernel/acpi/boot.c
> +++ b/arch/x86/kernel/acpi/boot.c
> @@ -45,7 +45,7 @@ EXPORT_SYMBOL(acpi_disabled);
>  #define PREFIX                 "ACPI: "
>
>  int acpi_noirq;                                /* skip ACPI IRQ initialization */
> -int acpi_nobgrt;                       /* skip ACPI BGRT */
> +static int acpi_nobgrt;                        /* skip ACPI BGRT */
>  int acpi_pci_disabled;         /* skip ACPI PCI scan and IRQ initialization */
>  EXPORT_SYMBOL(acpi_pci_disabled);
>
> --

Applied as 5.7-rc material, thanks!
