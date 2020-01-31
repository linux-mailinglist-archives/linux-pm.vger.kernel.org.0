Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0165B14EA80
	for <lists+linux-pm@lfdr.de>; Fri, 31 Jan 2020 11:13:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728268AbgAaKNp (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 31 Jan 2020 05:13:45 -0500
Received: from mail-oi1-f194.google.com ([209.85.167.194]:34300 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728160AbgAaKNp (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 31 Jan 2020 05:13:45 -0500
Received: by mail-oi1-f194.google.com with SMTP id l136so6747661oig.1;
        Fri, 31 Jan 2020 02:13:44 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=raabJwU4zEa7l6nAkAqDBvubVlQSjL6C05vgOXbsY4Y=;
        b=qBYoO8hSNd26sXZI9kaAHYcDMa/5/Xn91LZOGK50pqpaiv31ONUX9azCTRz3Mwls2t
         YOs9s11m7SUKvtCq22bDEY85YzZMrnWKEtIhnn+1S9TIYMCdXmvRQcvbwpxRrFbCtrA0
         Kwgrt+oyfh87L4MKFp+bB5cpOgungwqPpxtAwsWhB6zUHPBaiFsTX+Vndbel9prcQgph
         N9cZoSZa7glDODlM3Xk1z9ZaI1RfA5FcE/YtotrvRpE5uuXSvhmvOJL5Xy+d5iAWfVIC
         pyJZI4h8yyYgfUcAzFaPUnxTYV/YWeDOyjrX7qGJb2X8KnmZqHRwgW7sncoV4f23+wAA
         HfLQ==
X-Gm-Message-State: APjAAAW9Sxvu+VVEvZY+vfN/FYfYjFJNSuot2WOBpj3OVAidi5yZMCM6
        sZOM5fDrPZfaeMM643+BgB1UDqqq9mM9URfp73A=
X-Google-Smtp-Source: APXvYqwANun9+k0d+8aGujSI7AOEX1OlHtdp2RAu5sqPcA4CFr9uMMT9NzlT9H2xd2gMjMXa+DzdY9SgamiGDUmN1xw=
X-Received: by 2002:aca:bfc2:: with SMTP id p185mr5936669oif.57.1580465624588;
 Fri, 31 Jan 2020 02:13:44 -0800 (PST)
MIME-Version: 1.0
References: <20200124132957.15769-1-geert+renesas@glider.be> <20200124132957.15769-2-geert+renesas@glider.be>
In-Reply-To: <20200124132957.15769-2-geert+renesas@glider.be>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Fri, 31 Jan 2020 11:13:33 +0100
Message-ID: <CAJZ5v0ihj48QwB0HqA8LUYkSYiOVEbRmNd4acpy6hbq_0RDzLA@mail.gmail.com>
Subject: Re: [PATCH 1/2] debugfs: regset32: Add Runtime PM support
To:     Geert Uytterhoeven <geert+renesas@glider.be>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Gilad Ben-Yossef <gilad@benyossef.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S . Miller" <davem@davemloft.net>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Rob Clark <robdclark@gmail.com>, Sean Paul <sean@poorly.run>,
        Felipe Balbi <balbi@kernel.org>,
        Alan Stern <stern@rowland.harvard.edu>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Mathias Nyman <mathias.nyman@intel.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Chunfeng Yun <chunfeng.yun@mediatek.com>,
        Bin Liu <b-liu@ti.com>, linux-crypto@vger.kernel.org,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        "open list:ULTRA-WIDEBAND (UWB) SUBSYSTEM:" 
        <linux-usb@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Fri, Jan 24, 2020 at 2:30 PM Geert Uytterhoeven
<geert+renesas@glider.be> wrote:
>
> Hardware registers of devices under control of power management cannot
> be accessed at all times.  If such a device is suspended, register
> accesses may lead to undefined behavior, like reading bogus values, or
> causing exceptions or system locks.
>
> Extend struct debugfs_regset32 with an optional field to let device
> drivers specify the device the registers in the set belong to.  This
> allows debugfs_show_regset32() to make sure the device is resumed while
> its registers are being read.
>
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>

LGTM:

Acked-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

> ---
>  fs/debugfs/file.c       | 8 ++++++++
>  include/linux/debugfs.h | 1 +
>  2 files changed, 9 insertions(+)
>
> diff --git a/fs/debugfs/file.c b/fs/debugfs/file.c
> index dede25247b81f72a..5e52d68421c678f2 100644
> --- a/fs/debugfs/file.c
> +++ b/fs/debugfs/file.c
> @@ -18,6 +18,7 @@
>  #include <linux/slab.h>
>  #include <linux/atomic.h>
>  #include <linux/device.h>
> +#include <linux/pm_runtime.h>
>  #include <linux/poll.h>
>  #include <linux/security.h>
>
> @@ -1057,7 +1058,14 @@ static int debugfs_show_regset32(struct seq_file *s, void *data)
>  {
>         struct debugfs_regset32 *regset = s->private;
>
> +       if (regset->dev)
> +               pm_runtime_get_sync(regset->dev);
> +
>         debugfs_print_regs32(s, regset->regs, regset->nregs, regset->base, "");
> +
> +       if (regset->dev)
> +               pm_runtime_put(regset->dev);
> +
>         return 0;
>  }
>
> diff --git a/include/linux/debugfs.h b/include/linux/debugfs.h
> index bf9b6cafa4c26a68..5d0783ae09f365ac 100644
> --- a/include/linux/debugfs.h
> +++ b/include/linux/debugfs.h
> @@ -35,6 +35,7 @@ struct debugfs_regset32 {
>         const struct debugfs_reg32 *regs;
>         int nregs;
>         void __iomem *base;
> +       struct device *dev;     /* Optional device for Runtime PM */
>  };
>
>  extern struct dentry *arch_debugfs_dir;
> --
> 2.17.1
>
