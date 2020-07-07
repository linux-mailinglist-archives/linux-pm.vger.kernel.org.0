Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6C10D216F01
	for <lists+linux-pm@lfdr.de>; Tue,  7 Jul 2020 16:41:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727895AbgGGOke (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 7 Jul 2020 10:40:34 -0400
Received: from mail.kernel.org ([198.145.29.99]:40994 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727090AbgGGOkd (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Tue, 7 Jul 2020 10:40:33 -0400
Received: from mail-oi1-f173.google.com (mail-oi1-f173.google.com [209.85.167.173])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 364F920738;
        Tue,  7 Jul 2020 14:40:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1594132833;
        bh=8v1IK9I/RiUHc4Y90iaoqpgiKdh/ulMwUOHQrlAkoW4=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=oqB+OZTUNrkgAKgkfhXYl0/rKfMUPAA5iS13rf60xElNMqqDZQn1uK7ckHtmik4oD
         VIV8fWaWJg6SYUYj2SPwU2dKCgeY2RU46lt7synIyQwh7c14RI6RlfE+qW2/yLAi40
         CteJsoeQ2IkTv67lxdjBp5NQdDrbOi8fiBlKaNqU=
Received: by mail-oi1-f173.google.com with SMTP id l63so33619614oih.13;
        Tue, 07 Jul 2020 07:40:33 -0700 (PDT)
X-Gm-Message-State: AOAM531nTUmKz9NYdN0TpsmjxaMHKg20075MI2OL5ff5V93n31fzWoZb
        Uc3ZhjURBGI2YQJUeVt5ibP6vGgkIEIjK4Om0Q==
X-Google-Smtp-Source: ABdhPJwvhd+sPbLV1cRDjV2wPZAm1TiF2oXKUXY0jL+TVjsRMtT3cOUq27c842rQNh2vpF21N7YOpN1MzRW9HiYJBKg=
X-Received: by 2002:aca:30d2:: with SMTP id w201mr3554712oiw.147.1594132832575;
 Tue, 07 Jul 2020 07:40:32 -0700 (PDT)
MIME-Version: 1.0
References: <20200701211044.18590-1-r-rivera-matos@ti.com> <20200701211044.18590-3-r-rivera-matos@ti.com>
 <20200702205320.GA1672139@bogus> <54914eed-4a65-745b-b61b-9515737023e3@ti.com>
In-Reply-To: <54914eed-4a65-745b-b61b-9515737023e3@ti.com>
From:   Rob Herring <robh@kernel.org>
Date:   Tue, 7 Jul 2020 08:40:20 -0600
X-Gmail-Original-Message-ID: <CAL_JsqKXC1TFFCq6HBqdbHNeWbA=SnCqHkTx+FQXiPYDLb6sNw@mail.gmail.com>
Message-ID: <CAL_JsqKXC1TFFCq6HBqdbHNeWbA=SnCqHkTx+FQXiPYDLb6sNw@mail.gmail.com>
Subject: Re: [EXTERNAL] Re: [PATCH v15 2/4] dt-bindings: power: Convert
 battery.txt to battery.yaml
To:     Ricardo Rivera-Matos <r-rivera-matos@ti.com>
Cc:     =?UTF-8?Q?Pali_Roh=C3=A1r?= <pali@kernel.org>,
        "open list:THERMAL" <linux-pm@vger.kernel.org>,
        Sandeep Patil <sspatil@android.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Andrew F. Davis" <afd@ti.com>, Dan Murphy <dmurphy@ti.com>,
        Sebastian Reichel <sre@kernel.org>, devicetree@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Mon, Jul 6, 2020 at 12:45 PM Ricardo Rivera-Matos
<r-rivera-matos@ti.com> wrote:
>
> Rob
>
> On 7/2/20 3:53 PM, Rob Herring wrote:
> > On Wed, 01 Jul 2020 16:10:42 -0500, Ricardo Rivera-Matos wrote:
> >> From: Dan Murphy <dmurphy@ti.com>
> >>
> >> Convert the battery.txt file to yaml and fix up the examples.
> >>
> >> Signed-off-by: Dan Murphy <dmurphy@ti.com>
> >> ---
> >>   .../bindings/power/supply/battery.txt         |  86 +---------
> >>   .../bindings/power/supply/battery.yaml        | 157 ++++++++++++++++++
> >>   2 files changed, 158 insertions(+), 85 deletions(-)
> >>   create mode 100644 Documentation/devicetree/bindings/power/supply/battery.yaml
> >>
> >
> > My bot found errors running 'make dt_binding_check' on your patch:
> >
> > Unknown file referenced: [Errno 2] No such file or directory: '/usr/local/lib/python3.6/dist-packages/dtschema/schema/types.yaml'
> > Documentation/devicetree/bindings/Makefile:20: recipe for target 'Documentation/devicetree/bindings/power/supply/battery.example.dts' failed
> > make[1]: *** [Documentation/devicetree/bindings/power/supply/battery.example.dts] Error 255
> > make[1]: *** Waiting for unfinished jobs....
> > Makefile:1347: recipe for target 'dt_binding_check' failed
> > make: *** [dt_binding_check] Error 2
> I think your bot is looking for the types.yaml in the wrong place.

Really? Yet it works fine on thousands of other patches?

> '/usr/local/lib/python3.6/dist-packages/dtschema/schema/types.yaml'
> should be
> '/usr/local/lib/python3.6/dist-packages/dtschema/schemas/types.yaml'. I
> renamed might 'schemas' directory to 'schema' and my battery.yaml passed
> the dt_binding_check.

Maybe fix the 'schema/' path in your schema file which is wrong.

Rob
