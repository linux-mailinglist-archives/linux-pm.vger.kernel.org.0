Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2242E9CB52
	for <lists+linux-pm@lfdr.de>; Mon, 26 Aug 2019 10:13:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730357AbfHZINR (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 26 Aug 2019 04:13:17 -0400
Received: from mail-oi1-f196.google.com ([209.85.167.196]:40598 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729808AbfHZINR (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 26 Aug 2019 04:13:17 -0400
Received: by mail-oi1-f196.google.com with SMTP id h21so11461898oie.7;
        Mon, 26 Aug 2019 01:13:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=uEglIJSck7IpvTcUcp/K5Px+WMHxBVf+kk940fEm91E=;
        b=R2C1BePn0leTKDoAOdVvB8k3bcGADzpGV2j/WX7vCMEEdRNSXTLPq+YdhQIFeB9V3a
         QSVqJMSizyO3s++ADROboOCmYojk6yVb59dxt6qzNH0L3An8kuYDfH/Jw4FDA5K86AaA
         8BJ0HHRrL05DQ9PLlioFhoIeoeV31F3oiwESN1Vo8SbELYUwZjLTEaktXF5wsnoc2C/2
         dMDmrbUkaR8136nbL5PZvoIfnARi9plcJEIskiWWc7EYm0MhlebWFMHX0czpZNhE8pHl
         AQtKMQUxyfu7gU4EfcK5UwfZIVvETxgb1OECSjpI5592CBT89+NFZMXcN5E672kxtS34
         d1Kw==
X-Gm-Message-State: APjAAAXQs+i+1kpcG/i4BvIcOzDXNMwyllbJTcv/Azpm+JHuNftdWn0N
        vmAqFcSsveassCrxdkJC9bi+eKmCeSmrOJ66qYzsFQ==
X-Google-Smtp-Source: APXvYqz+P+hENUjIN29s2OXuhavKXWBtsRFvPNVg1797rd1IlIBHtRdH+Fr7vSX1rcsTPdxu8rdJ6OPUcENe14BFxQY=
X-Received: by 2002:aca:4dd8:: with SMTP id a207mr10887091oib.115.1566807196006;
 Mon, 26 Aug 2019 01:13:16 -0700 (PDT)
MIME-Version: 1.0
References: <20190408161240.GA30623@embeddedor> <16370c2e-c5f9-a4cf-02fc-6b5b4ab65e1c@redhat.com>
 <1c208944-9162-0245-c3bd-016f4274511f@embeddedor.com> <CAJZ5v0jUfLpp_q7ozi33wgJfP7zHmvDh2Srun0KjVZj6Q7NOfw@mail.gmail.com>
 <52803932-12dc-3ea0-12ef-09b5b317818b@embeddedor.com> <CAJZ5v0gX1zTiJkCk51FpeywgwD58K46eGdqCcVjLL2zkhAG_wA@mail.gmail.com>
 <841150bdcbd88a00a30a7ba86272918263959699.camel@gmail.com>
In-Reply-To: <841150bdcbd88a00a30a7ba86272918263959699.camel@gmail.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Mon, 26 Aug 2019 10:13:01 +0200
Message-ID: <CAJZ5v0ii5pihh3uvQqckZmHCXYL+xROohd4sJSR+E-kzviicng@mail.gmail.com>
Subject: Re: [PATCH] tools/power turbostat: fix file descriptor leaks
To:     Artem Bityutskiy <dedekind1@gmail.com>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        Prarit Bhargava <prarit@redhat.com>,
        Len Brown <lenb@kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Mon, Aug 26, 2019 at 10:02 AM Artem Bityutskiy <dedekind1@gmail.com> wrote:
>
> On Mon, 2019-08-26 at 09:55 +0200, Rafael J. Wysocki wrote:
>
> Technically, Len Brown is the turbostat maintainer and I have been
>
> waiting for him to review the patch at least.  Let me talk to Len.
>
>
>
> Hi Rafael,
>
>
> I also sent a couple of turbostat patches waiting for being acted upon, may be you could include them to the conversation too?

Yes, I will, thanks!
