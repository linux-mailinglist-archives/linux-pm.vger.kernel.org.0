Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F157738E849
	for <lists+linux-pm@lfdr.de>; Mon, 24 May 2021 16:07:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232662AbhEXOJO (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 24 May 2021 10:09:14 -0400
Received: from mail-ot1-f41.google.com ([209.85.210.41]:37843 "EHLO
        mail-ot1-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232462AbhEXOJN (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 24 May 2021 10:09:13 -0400
Received: by mail-ot1-f41.google.com with SMTP id v19-20020a0568301413b0290304f00e3d88so25303266otp.4
        for <linux-pm@vger.kernel.org>; Mon, 24 May 2021 07:07:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=JbvNaPlm/uDz/cji5buikxOFE8pc7CiuOox26VOUt6E=;
        b=PF3ejXgrC24eudkS0yZTWf9KQQuvFWCl+i86eY0SF14ZWw5GH51wHWyQCNU32cFyfR
         jmkSdvOKeL/JSp1K02K9llSZfLXZ9rV0sbMOO7LZSk4XBYzM/BkwtnVDcxfZiXp/Ji8D
         VHFnfsvlLVOOz/o774YhenzDOkMHUpeHVH4qHZTvR1ItdZ8GueFvB952KkTb4sazljpB
         XUYYqk6mBbM/U69h6TqoaRtJX6/OUQQcK18qJFj/4FeoK4ZxyTYENgapFPzh5tsaUqC5
         XSp5lPKkUcDH/aR3gU3I2+hjgkH18/vqWza9JmIrfrIoaI2UktqsLOjn09Sr4yhLIyty
         EFTw==
X-Gm-Message-State: AOAM532ET+UyeSpOVHbchyjRQpp2Dtg2OmiKGY1RTDjGGUOMo1XbPyDJ
        ufcsSaoRZ7Vq0GoPEhSBquyW86owiKEkIzpqtBM=
X-Google-Smtp-Source: ABdhPJwVaJO3bD1Ty2KazNBvUAFzCsxx5nJw5zSHQYP/Jq5nP1dgXzQLgfM6HsCJgYYrvgjcAZ7AoDVQbDKtAE7Srps=
X-Received: by 2002:a9d:6c46:: with SMTP id g6mr18652748otq.260.1621865264507;
 Mon, 24 May 2021 07:07:44 -0700 (PDT)
MIME-Version: 1.0
References: <1621496098-50271-1-git-send-email-tiantao6@hisilicon.com>
 <CAJZ5v0ie_ijC4XVBxnS9tid-q_vbMm6zXwvvOoMMEe20E_mLUQ@mail.gmail.com> <YKf3aY4Mj/4Nl1v3@atomide.com>
In-Reply-To: <YKf3aY4Mj/4Nl1v3@atomide.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Mon, 24 May 2021 16:07:28 +0200
Message-ID: <CAJZ5v0i_6asdx3_b3tuJDt-yzEzkhY7gvzO3nXgJDTm+ouOr_Q@mail.gmail.com>
Subject: Re: [PATCH] PM / wakeirq: move to use request_irq by IRQF_NO_AUTOEN flag
To:     Tony Lindgren <tony@atomide.com>, Tian Tao <tiantao6@hisilicon.com>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linux PM <linux-pm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Fri, May 21, 2021 at 8:09 PM Tony Lindgren <tony@atomide.com> wrote:
>
> * Rafael J. Wysocki <rafael@kernel.org> [210521 16:57]:
> > On Thu, May 20, 2021 at 9:35 AM Tian Tao <tiantao6@hisilicon.com> wrote:
> > >
> > > request_irq() after setting IRQ_NOAUTOEN as below
> > > irq_set_status_flags(irq, IRQ_NOAUTOEN);
> > > request_irq(dev, irq...);
> > > can be replaced by request_irq() with IRQF_NO_AUTOEN flag.
> > >
> > > this change is just to simplify the code, no actual functional changes.
> > >
> > > Signed-off-by: Tian Tao <tiantao6@hisilicon.com>
> >
> > Tony, what do you think?
>
> Sounds good to me:
>
> Reviewed-by: Tony Lindgren <tony@atomide.com>

Applied as 5.14 material, thanks!
