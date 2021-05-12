Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 06AEC37BBD2
	for <lists+linux-pm@lfdr.de>; Wed, 12 May 2021 13:32:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230096AbhELLdl (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 12 May 2021 07:33:41 -0400
Received: from mail-ot1-f45.google.com ([209.85.210.45]:46661 "EHLO
        mail-ot1-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230037AbhELLdl (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 12 May 2021 07:33:41 -0400
Received: by mail-ot1-f45.google.com with SMTP id d3-20020a9d29030000b029027e8019067fso20196989otb.13;
        Wed, 12 May 2021 04:32:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=V2ju9+ojkSTDJQBwgSscuL9ZbQgrRBMumx4KhsSIeck=;
        b=TInRVi4W15pVDBlOpe+EgNUki8f56HFiiyOltwuhTFX1EP0vahzcuPF/j2a5Z94DqM
         I9S8s72p6FlF4YRm3M5lbS0pNqKIfHwcZeRKsTdbaOSWvFaqgWaMpeTtppYVX9gwemc2
         kVeWgwWlb558aG71Q13cK2dWn8BUiqG4qVnKS/I/pRbQePrntsjwImcNaJkT7hDyY7L7
         C8BVvHvWD+OV+smX5f75x+pqOH9QjWS9m1VgjdNO49bpxRxzJpSAKB1BTYkigN/PY6Xd
         S4UoxSrTB4h88l/c/1yRj1GeSmbPTtErpM4EPuS9q0QIJ7Lnu6fHUQeKvZ05181kYg4k
         8hSw==
X-Gm-Message-State: AOAM531+UIDUlGhkR4KZO7vwChPWItLBdahn6mAy+vyHaN1X4B39GFm2
        68jZHwGJPaDqyuLaQDLZ1m15h2CQe7GJqEP+LnE=
X-Google-Smtp-Source: ABdhPJwTTH6tjOt74iZytTucsmVQQMo/3JsYq78oyRg8JeBSSNVu13qYDKUolrp8gLDmug64HupqdBAhs3judaHptSg=
X-Received: by 2002:a9d:3bcb:: with SMTP id k69mr31357903otc.206.1620819152814;
 Wed, 12 May 2021 04:32:32 -0700 (PDT)
MIME-Version: 1.0
References: <3c88cf35-6725-1bfa-9e1e-8e9d69147e3b@hisilicon.com>
 <d16058fc-9876-f6a3-d5e8-ff06b5193f2c@intel.com> <2149723.iZASKD2KPV@kreacher>
 <CAGETcx-tRh45ZJzmbGvHay1htnjeE-EZc3CG9P3=qFfi75owHA@mail.gmail.com>
 <CAJZ5v0iBV2n0yuvhYEzLPTZFuq-O1SpdK_BmLgXz7qrcNKe-gg@mail.gmail.com> <20210512063542.3079-1-hdanton@sina.com>
In-Reply-To: <20210512063542.3079-1-hdanton@sina.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Wed, 12 May 2021 13:32:21 +0200
Message-ID: <CAJZ5v0gbRb+CGEV2D09KqhiRPPWxPBtXmwrp5iyuB-xTBEBfvA@mail.gmail.com>
Subject: Re: Qestion about device link
To:     Hillf Danton <hdanton@sina.com>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Saravana Kannan <saravanak@google.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        "chenxiang (M)" <chenxiang66@hisilicon.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        John Garry <john.garry@huawei.com>,
        "scsi list : TARGET SUBSYSTEM" <linux-scsi@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Wed, May 12, 2021 at 8:38 AM Hillf Danton <hdanton@sina.com> wrote:
>
> On Tue, 11 May 2021 21:43:40 Rafael J. Wysocki  wrote:
> > >  #ifdef CONFIG_SRCU
> > > +static void __device_link_free_fn(struct work_struct *work)
> > > +{
> > > +       device_link_free(container_of(work, struct device_link, srcu.work));
> > > +}
> > > +
> > >  static void __device_link_free_srcu(struct rcu_head *rhead)
> > >  {
> > > -       device_link_free(container_of(rhead, struct device_link, rcu_head));
> > > +       struct device_link *link = container_of(rhead, struct device_link,
> > > +                                               srcu.rhead);
> > > +       struct work_struct *work = &link->srcu.work;
> > > +
> > > +       /*
> > > +        * Because device_link_free() may sleep in some cases, schedule the
> > > +        * execution of it instead of invoking it directly.
> > > +        */
> > > +       INIT_WORK(work, __device_link_free_fn);
> > > +       schedule_work(work);
> > >  }
>
> Nope, you need something like queue_work(system_unbound_wq, work); instead
> because of the blocking wq callback.

system_long_wq rather, as it really doesn't matter when it gets completed.
