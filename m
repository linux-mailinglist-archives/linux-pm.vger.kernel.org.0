Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 92E291D5646
	for <lists+linux-pm@lfdr.de>; Fri, 15 May 2020 18:39:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726223AbgEOQjL (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 15 May 2020 12:39:11 -0400
Received: from mail-oi1-f195.google.com ([209.85.167.195]:47029 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726023AbgEOQjL (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 15 May 2020 12:39:11 -0400
Received: by mail-oi1-f195.google.com with SMTP id p127so2718103oia.13
        for <linux-pm@vger.kernel.org>; Fri, 15 May 2020 09:39:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=wu75K1JQVmD5ftGcEDgptNf2zmztCB2YYmBlZh6hRAs=;
        b=ZaZEPEje2W2YKc5pniVwNX7hIDa8mSZoNMV6fbGlC9xTJuMAfEGBkmYWfyy6Jt0ZF6
         1cSbU7+6KkXi53MdUp5cXtl08VNgiYrYss2btf4PwE238eAVG8zX9s4O6OZ/K958GYYV
         xwmfHoZF0S+oNBDr2dKHqaiywxCylcpaveJQ+DX6gfcbS9COmEaPWrCFSrywVPm0flw7
         hTbQtSXsZXnfRZv/C8tWO6jHiad1BrI8J5Gr6Qx7X9EBWMSfqyPpRg+3xcgJqHOzTat9
         alQdR2zdxyT2Sz4uOHIGorv0CFGO76prwp1BNwosvTeFGQfezGTcvtC0ssYAghZ1r3DW
         Mmyg==
X-Gm-Message-State: AOAM532YdYEsQqq+DH8FyeAG9KrcFbt9RwXodesxu9VCJMfa1/hnaja/
        /KEcit8DQA06OsvFuVQ+X9Vw1GQzch968Q5I4w0=
X-Google-Smtp-Source: ABdhPJxMLi3q/7SEYR9jrQy7LNdJekTiHJaE7sfxiNhuG/9UYGszH1SOLcsUPxRqDsUtYcyp6n6EjKP0pI93K+bkylU=
X-Received: by 2002:aca:eb56:: with SMTP id j83mr2374613oih.110.1589560750449;
 Fri, 15 May 2020 09:39:10 -0700 (PDT)
MIME-Version: 1.0
References: <20200511133346.21706-1-ulf.hansson@linaro.org>
 <20200514142015.GA23401@bogus> <CAPDyKFoVo8L7eiGdEVNYR2DY7cszDuLkmX8O_SfyUKh73pbpMQ@mail.gmail.com>
 <20200514172816.GA42669@bogus> <CAPDyKFrdrOnxFHaAR=cmMi2VfSudyHdjZ7vRZKhTQtepdkiXug@mail.gmail.com>
 <20200515102255.GA25927@bogus> <CAPDyKFrsfLExZHvNrJgqsJj8TTzj9jg5v=jEowBTdi26uyjZXg@mail.gmail.com>
In-Reply-To: <CAPDyKFrsfLExZHvNrJgqsJj8TTzj9jg5v=jEowBTdi26uyjZXg@mail.gmail.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Fri, 15 May 2020 18:38:59 +0200
Message-ID: <CAJZ5v0imyuNQe0yDmK8nV8eCCMBy+oXB7CZttZ47cijt7dEGOA@mail.gmail.com>
Subject: Re: [PATCH] cpuidle: psci: Fixup execution order when entering a
 domain idle state
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Sudeep Holla <sudeep.holla@arm.com>,
        Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>,
        Linux PM <linux-pm@vger.kernel.org>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Lina Iyer <ilina@codeaurora.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Benjamin Gaignard <benjamin.gaignard@st.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Fri, May 15, 2020 at 1:30 PM Ulf Hansson <ulf.hansson@linaro.org> wrote:
>
> On Fri, 15 May 2020 at 12:23, Sudeep Holla <sudeep.holla@arm.com> wrote:
> >
> > On Thu, May 14, 2020 at 09:11:50PM +0200, Ulf Hansson wrote:
> > >
> > > No worries, thanks for reviewing.
> > >
> >
> > You are welcome.
> >
> > > That said, are you fine with Rafel queuing this then?
> > >
> >
> > I am fine with that. However I told if you need fixes tags as there are
> > no users of the notification yet in the kernel. Though this is trivial,
> > but do we need this backported to stable kernel. I don't have strong
> > opinion and leave it to you and Rafael.
>
> I wanted to add the fixes tag, to make it obvious that there is an
> error being fixed.
>
> On the other hand, no need to tag this for stable, nor to need to send
> it as fix for 5.7,
>
> >
> > Acked-by: Sudeep Holla <sudeep.holla@arm.com>
>
> Thanks!

So applied as 5.8 material, thanks!
