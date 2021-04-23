Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 760283691DB
	for <lists+linux-pm@lfdr.de>; Fri, 23 Apr 2021 14:17:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242306AbhDWMRn (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 23 Apr 2021 08:17:43 -0400
Received: from mail-wr1-f44.google.com ([209.85.221.44]:37873 "EHLO
        mail-wr1-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230225AbhDWMRn (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 23 Apr 2021 08:17:43 -0400
Received: by mail-wr1-f44.google.com with SMTP id j5so47220229wrn.4;
        Fri, 23 Apr 2021 05:17:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=qcNT1qM1P7B38rdaKoad+tizCvZx8z7FWhgeyv/uNpY=;
        b=KJMpHPW+H69mVjcQI1QWM9t0I4Npg4gyVHRne9IOp8Iu6KyoLNNZMamFulblZ52WSA
         Lzmd0/VwAmW3y2PQh3jc5ZuphsFZC7DjK2v/qmAL/O92/BKYFpuiVoj3wBNyORu7CaOU
         bOphGM+geNKw9wpKerc2oWKX7SMyUGUw9C3VDRWc1xexEfUuadWaMH9DPiT7OQ/Ij26Z
         vOT2ypWRwjx0XMrVHNAHcHqL2eJ4MsM1soXornqdC9edF26mJhxU6bQPYgB8iU/4dxfk
         rAQns6TAp9xA2AMvd7lp6YbhIU9/o6RHvOvMyZ/ToKo3Ht4bOM4Npv/XBitemWJWFeSj
         Tplw==
X-Gm-Message-State: AOAM533m5Fd3RkT2+w6Q3T8ZhmsPLLdYhAr2yz1k/OEZW89jKFPrzcHS
        qDScnc3nnYV64nWjgawyncYwybIxbcV6qq4uykYXEdpu
X-Google-Smtp-Source: ABdhPJwTRgDU6Ireg0YfTMrcvbLppuHeWicH0io40ZtAqMxYd+S120SoP4+h0GT/PU8Mxk+dQVyXCLYEQLm9xpv2hpQ=
X-Received: by 2002:adf:facf:: with SMTP id a15mr4343793wrs.261.1619180226028;
 Fri, 23 Apr 2021 05:17:06 -0700 (PDT)
MIME-Version: 1.0
References: <20210423081223.26111-1-zhaoxiao@uniontech.com>
In-Reply-To: <20210423081223.26111-1-zhaoxiao@uniontech.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Fri, 23 Apr 2021 14:16:54 +0200
Message-ID: <CAJZ5v0hSR7PkrqsXJyoSjWEHnCzLqbEfWJOaTo=zy8N9CkYGeQ@mail.gmail.com>
Subject: Re: [PATCH] PM: Use pm_pr_dbg() instead of pr_debug().
To:     zhaoxiao <zhaoxiao@uniontech.com>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Pavel Machek <pavel@ucw.cz>, Len Brown <len.brown@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Fri, Apr 23, 2021 at 10:12 AM zhaoxiao <zhaoxiao@uniontech.com> wrote:
>
> These prints are useful if we're doing PM suspend debugging. Having them
> at pr_debug() level means that we need to either enable DEBUG in this
> file, or compile the kernel with dynamic debug capabilities. Both of
> these options have drawbacks like custom compilation or opting into all
> debug statements being included into the kernel image.

I'm not quite sure what you wanted to say here.

What's wrong with dynamic debug in particular?

> Given that we already have infrastructure to collect PM debugging information with
> CONFIG_PM_DEBUG and friends, let's change the pr_debug usage here to be
> pm_pr_dbg() instead so we can collect the wakeup information in the
> kernel logs.

What wakeup information do you mean?

This is all about manipulating dpm_list and your change would cause
pm_debug_messages to generate quite a bit of noise if enabled early.
