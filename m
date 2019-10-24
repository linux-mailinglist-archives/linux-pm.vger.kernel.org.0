Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E3CFEE28DB
	for <lists+linux-pm@lfdr.de>; Thu, 24 Oct 2019 05:29:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390629AbfJXD3N (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 23 Oct 2019 23:29:13 -0400
Received: from mail-qt1-f195.google.com ([209.85.160.195]:33146 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390450AbfJXD3M (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 23 Oct 2019 23:29:12 -0400
Received: by mail-qt1-f195.google.com with SMTP id r5so35757222qtd.0
        for <linux-pm@vger.kernel.org>; Wed, 23 Oct 2019 20:29:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=endlessm-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=CacFV/lTRmHt6F6mhHUKL10O5L8H3YTLLCMha7hrL0Q=;
        b=THz42nOH1jaoEtXaeQaTmQlMy/YfB6LGy17zRJPG1zcWDqtEM7HwK46nnnnGY0fkKD
         BnXyr1jkqA9JCWCblDHeTxOYJ8j4Ysq77YEwm4uZsGgc+ysyqxXbf3Rx2va/es5TnfZk
         wFWj/o0BeRDu3PsghlyiUcBaiojjVUIhMtrRmzpTIHDcui579+6DZhm/qLY1uyJDFEvn
         1xTb1w6F6KYSTI78V0DooalbyVStBl0sk8C3puGcm4i+NjC3yOTqbWtF+KhHYgLx3sFX
         OMBBFR8trx3SRArl8fj2Wm+H2PqJ0AKi/JYGKsTRjOp07bIxYsKFVVdYIbkloV3PW/uX
         V6Hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=CacFV/lTRmHt6F6mhHUKL10O5L8H3YTLLCMha7hrL0Q=;
        b=eV61LH+dUbP0OduqB32CFgd9nSoU03mzovf5NDLsXtcKCLgp8uEEqEj8qSRzCafBon
         lVXEowJ2EiT3exIUUVNr/87nDdyjjSYc3Sm09y/0PB1ipscFqlsPYNXeRJKrRK0G/e1w
         G6ueDL8WCVdHtQaApW6wIrxRWc1ekfOeRItBFOV7c5C1KKqCy8H+cwKgb8Eube8K6xsU
         Gs4IircAc5u/b5zk3RjZ5i6lS36gbi7tpMTbHfXQ7Uh/d7gDS55qt3zejI389ZM/nba2
         MkL5FjSlcjgQanCldmkXj7qVBUFK67V+IWGCvPJZCOeDBkXT+UVEifofGYEn+C9Lg10F
         hwEQ==
X-Gm-Message-State: APjAAAXjyYELVGxkZIvDGQMdnpDyNwcT6MPTf+X5FFpFsbh8svvVh5xb
        7ZGVARMRl66VOD6rxbrgTGUGiKZmLOT6shzMcF2K6g==
X-Google-Smtp-Source: APXvYqyZrz7NqARmFL2eBIDTA+kjbyBSTICNGBsHWH2dyFreIV4B7r6FTsTK1VCom+KCShQPX0OFG3VuirMV5q5t4FQ=
X-Received: by 2002:ac8:c86:: with SMTP id n6mr445293qti.80.1571887750853;
 Wed, 23 Oct 2019 20:29:10 -0700 (PDT)
MIME-Version: 1.0
References: <20191022093349.GC2819@lahna.fi.intel.com> <20191023224003.GA31692@google.com>
In-Reply-To: <20191023224003.GA31692@google.com>
From:   Daniel Drake <drake@endlessm.com>
Date:   Thu, 24 Oct 2019 11:28:59 +0800
Message-ID: <CAD8Lp46KZmTzxjYN6T7u1xH0AODr38hFcCgR-COtvduK9ZuANQ@mail.gmail.com>
Subject: Re: [PATCH] PCI: increase D3 delay for AMD Ryzen5/7 XHCI controllers
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Mika Westerberg <mika.westerberg@linux.intel.com>,
        Linux PCI <linux-pci@vger.kernel.org>,
        "Wysocki, Rafael J" <rafael.j.wysocki@intel.com>,
        Linux Upstreaming Team <linux@endlessm.com>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux USB Mailing List <linux-usb@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Thu, Oct 24, 2019 at 6:40 AM Bjorn Helgaas <helgaas@kernel.org> wrote:
> I think we need something like the patch below.  We already do
> basically the same thing in pci_pm_reset().
>
> [1] https://gist.github.com/dsd/bd9370b35defdf43680b81ecb34381d5
>
> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> index e7982af9a5d8..e8702388830f 100644
> --- a/drivers/pci/pci.c
> +++ b/drivers/pci/pci.c
> @@ -883,9 +883,10 @@ static int pci_raw_set_power_state(struct pci_dev *dev, pci_power_t state)
>          * Mandatory power management transition delays; see PCI PM 1.1
>          * 5.6.1 table 18
>          */
> -       if (state == PCI_D3hot || dev->current_state == PCI_D3hot)
> +       if (state == PCI_D3hot || dev->current_state == PCI_D3hot) {
>                 pci_dev_d3_sleep(dev);
> -       else if (state == PCI_D2 || dev->current_state == PCI_D2)
> +               pci_dev_wait(dev, "D3 transition", PCIE_RESET_READY_POLL_MS);
> +       } else if (state == PCI_D2 || dev->current_state == PCI_D2)
>                 udelay(PCI_PM_D2_DELAY);
>
>         pci_read_config_word(dev, dev->pm_cap + PCI_PM_CTRL, &pmcsr);

You also need to move the pci_dev_wait function definition higher up
in the file.
Tested and that doesn't help this case unfortunately. pci_dev_wait
doesn't do anything since PCI_COMMAND value at this point is 0x100403
:(

Daniel
