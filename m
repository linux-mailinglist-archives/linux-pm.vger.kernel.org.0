Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1E46518A910
	for <lists+linux-pm@lfdr.de>; Thu, 19 Mar 2020 00:14:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726912AbgCRXOi (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 18 Mar 2020 19:14:38 -0400
Received: from mail.kernel.org ([198.145.29.99]:40542 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726619AbgCRXOi (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 18 Mar 2020 19:14:38 -0400
Received: from mail-qk1-f170.google.com (mail-qk1-f170.google.com [209.85.222.170])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7FD6120774;
        Wed, 18 Mar 2020 23:14:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1584573277;
        bh=xnAd9aM1szJANZpOZYnjr6Q8kk/poW+SW49OK+6CBJA=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=XT6D3puNAvAMgfndY1UkiEwX/BXNrV8lHFBJbFQ6C2BuScL9EglKJPh0UK+mThH/x
         ZWjeAMvPdxvDLboxeGLkF8+cEq1dA3mTBTmQy/kzA3izx6PCAZUUdcteK+FqeqN0yW
         0xnfVXckdm1wnESB6PRDBbRdUELl3okC9iiHjEKU=
Received: by mail-qk1-f170.google.com with SMTP id j2so247188qkl.7;
        Wed, 18 Mar 2020 16:14:37 -0700 (PDT)
X-Gm-Message-State: ANhLgQ3UtG2Nn1hfO3OMVds5Yh0p1PH9+wp1p3qUtGRjEJKl+7gnDKJK
        Kts/5yZzkVF9aaS+7v1oYW+PIB3O9y7VeV+NoQ==
X-Google-Smtp-Source: ADFU+vuzTuEwzK4FnMMP68h9BVgs5HKeW7PynpJbTqVEa9tqOafe3uVDdXHxy4DHtPecBZfqcHfHBSgvLnWqgjn5B3c=
X-Received: by 2002:a37:4a85:: with SMTP id x127mr338927qka.152.1584573276533;
 Wed, 18 Mar 2020 16:14:36 -0700 (PDT)
MIME-Version: 1.0
References: <20200306130341.9585-1-Sergey.Semin@baikalelectronics.ru>
 <20200306130402.1F4F0803079F@mail.baikalelectronics.ru> <20200312211438.GA21883@bogus>
 <20200313130231.wrvvcttm7ofaxbfo@ubsrv2.baikal.int>
In-Reply-To: <20200313130231.wrvvcttm7ofaxbfo@ubsrv2.baikal.int>
From:   Rob Herring <robh@kernel.org>
Date:   Wed, 18 Mar 2020 17:14:25 -0600
X-Gmail-Original-Message-ID: <CAL_Jsq+W84r687zNV=2S-hj9=xbTQxkx9MpVNDTn6TOrBgiGUw@mail.gmail.com>
Message-ID: <CAL_Jsq+W84r687zNV=2S-hj9=xbTQxkx9MpVNDTn6TOrBgiGUw@mail.gmail.com>
Subject: Re: [PATCH 3/4] dt-bindings: power: reset: Add regmap support to the
 SYSCON reboot-mode bindings
To:     Sergey Semin <Sergey.Semin@baikalelectronics.ru>
Cc:     Sebastian Reichel <sre@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Paul Burton <paulburton@kernel.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        "open list:THERMAL" <linux-pm@vger.kernel.org>,
        devicetree@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Fri, Mar 13, 2020 at 7:03 AM Sergey Semin
<Sergey.Semin@baikalelectronics.ru> wrote:
>
> On Thu, Mar 12, 2020 at 04:14:38PM -0500, Rob Herring wrote:
> > On Fri, Mar 06, 2020 at 04:03:40PM +0300, Sergey.Semin@baikalelectronics.ru wrote:
> > > From: Serge Semin <Sergey.Semin@baikalelectronics.ru>
> > >
> > > Optional regmap property will be used to refer to a syscon-controller
> > > having a reboot tolerant register mapped.
> >
> > NAK. It should simply be a child node of the 'syscon-controller'.
>
> Hm, It's dilemma. The driver maintainer said ack, while you disagree.)
> So the code change will be merged while the doc-part won't? Lets discuss then
> to settle the issue.
>
> Why 'syscon-reboot' can be out of syscon-controller node, while
> 'syscon-reboot-mode' can't?

Look at the history and you will see one was reviewed by DT
maintainers and one wasn't.

> They both belong to the same usecase: save
> cause id and reboot. So having similar properties-set and declaring their
> nodes someplace nearby is natural.

Which is what I'm asking for. Where else in the tree does it make
sense to locate the 'syscon-reboot-mode' node? Locate nodes where they
logically belong.

> According to the driver 'syscon-reboot'
> can't lack the regmap property because it's mandatory, while here you refuse
> to have even optional support. Additionally in most of the cases the
> 'syscon-reboot' nodes aren't declared as a child of a system controller
> node. Why 'syscon-reboot-mode' can't work in a similar way?

There's plenty of bad or "don't follow current best practice" examples
in the tree for all sorts of things. That is not a reason for doing
something in a new binding or adding to an existing one.

Rob
