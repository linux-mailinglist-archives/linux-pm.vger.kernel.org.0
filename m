Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 574629CB08
	for <lists+linux-pm@lfdr.de>; Mon, 26 Aug 2019 09:55:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730177AbfHZHz5 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 26 Aug 2019 03:55:57 -0400
Received: from mail-oi1-f196.google.com ([209.85.167.196]:43131 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730158AbfHZHz5 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 26 Aug 2019 03:55:57 -0400
Received: by mail-oi1-f196.google.com with SMTP id y8so11421446oih.10;
        Mon, 26 Aug 2019 00:55:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=N4MfQm+LP9efTkdP10QsK3nEtRnfq2pmL5jNgo25EAE=;
        b=sRdaqmHJwrN2ALdZiEB1B4w7iFtoj5ksE3hufx2wMCqTRxVxpzhePRBKqVpCwchFMi
         ouZesvq2CS+YYlNtH6gHoBDDPJKDHfUgMUMwQgv/ysRqQHkDts/I4bdp0cl1ICf4sBwS
         1ZqfVxziiQ95/51oooR76aUn7O9L8Q/VPbQ3nR6//h65+1IJNtFoqbxo9IGVaNTm/FxM
         TL6m96bQaYzhNayyPlqb5bAOqArudiOv7WYHuVP+KPOaL3F5raOLApDrRkX6sgC5rgiA
         183zsMg0UGeY35IajZeGjCi34BXL/HbdHMFaW193DAY6QiPh9gBS4LcyYUzaHQuGVRVt
         SgJw==
X-Gm-Message-State: APjAAAXHaWm/1Q4LENCRzC9p0ec4lrlh141qRJBSIuFCqXX2Bbn4Kapt
        PMJ5e3FcmjiosoTOgKNNCI+GJDOm8PrgCiHU2Ovs7A==
X-Google-Smtp-Source: APXvYqxbk6iAI/XN+ORW2IggxqdNlmUCBx+48XJUX1wD+vXCIx7OcBIP1H2XFrPHwZPqSkcLW//qyvwO6kLSp7TqKQM=
X-Received: by 2002:aca:cfcb:: with SMTP id f194mr11935335oig.103.1566806156442;
 Mon, 26 Aug 2019 00:55:56 -0700 (PDT)
MIME-Version: 1.0
References: <20190408161240.GA30623@embeddedor> <16370c2e-c5f9-a4cf-02fc-6b5b4ab65e1c@redhat.com>
 <1c208944-9162-0245-c3bd-016f4274511f@embeddedor.com> <CAJZ5v0jUfLpp_q7ozi33wgJfP7zHmvDh2Srun0KjVZj6Q7NOfw@mail.gmail.com>
 <52803932-12dc-3ea0-12ef-09b5b317818b@embeddedor.com>
In-Reply-To: <52803932-12dc-3ea0-12ef-09b5b317818b@embeddedor.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Mon, 26 Aug 2019 09:55:42 +0200
Message-ID: <CAJZ5v0gX1zTiJkCk51FpeywgwD58K46eGdqCcVjLL2zkhAG_wA@mail.gmail.com>
Subject: Re: [PATCH] tools/power turbostat: fix file descriptor leaks
To:     "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Prarit Bhargava <prarit@redhat.com>,
        Len Brown <lenb@kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Mon, Aug 26, 2019 at 6:25 AM Gustavo A. R. Silva
<gustavo@embeddedor.com> wrote:
>
> Hi Rafael,
>
> On 4/23/19 3:23 AM, Rafael J. Wysocki wrote:
> > On Mon, Apr 22, 2019 at 5:55 PM Gustavo A. R. Silva
> > <gustavo@embeddedor.com> wrote:
> >>
> >> Hi all,
> >>
> >> Friendly ping:
> >>
> >> Who can take this?
> >
> > I've been waiting for Len to comment on this, let me talk to him offlist.
> >
>
> I just noticed this hasn't been applied.
>
> I wonder if you plan to apply it.

Technically, Len Brown is the turbostat maintainer and I have been
waiting for him to review the patch at least.  Let me talk to Len.

Thanks!
