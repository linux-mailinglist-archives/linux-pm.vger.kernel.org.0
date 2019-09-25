Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DFF19BDEFA
	for <lists+linux-pm@lfdr.de>; Wed, 25 Sep 2019 15:28:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406408AbfIYN2p (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 25 Sep 2019 09:28:45 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:40229 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2406398AbfIYN2p (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 25 Sep 2019 09:28:45 -0400
Received: by mail-pg1-f193.google.com with SMTP id w10so3236416pgj.7
        for <linux-pm@vger.kernel.org>; Wed, 25 Sep 2019 06:28:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=message-id:mime-version:content-transfer-encoding:in-reply-to
         :references:cc:to:from:subject:user-agent:date;
        bh=7Qtpz8pP6Xtu5hQMQ/OiLIkOhJi8maiQgK4EToDIyWo=;
        b=hVpA5j2jkOlUR1iZj0yYcJSI/3wijEBgu5VEoQl7T6aKe26hhNP35ZCbaju9c2MrkK
         mqw6fvaSnImSH61s1jS6oKzkUazLpBpwO09F+fslKYjNG8rs2hnfdqonQSXsrHoTBhY7
         P6Q5ISOKhcmaxqLIV8gsrLUT2FTrF3icZpIcQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:mime-version
         :content-transfer-encoding:in-reply-to:references:cc:to:from:subject
         :user-agent:date;
        bh=7Qtpz8pP6Xtu5hQMQ/OiLIkOhJi8maiQgK4EToDIyWo=;
        b=acTdJxt8QlkgLvgM6NTdw+KfdUWQCq57b62tL3jP9QmvSv88T87hdfppZqV3XWcTH7
         2PenomNpCo/borBWoxbHbxhC43YkTTu1QhR1yU4bhnfoaoKi+8/nd+QfkeTLl5np38tl
         CoLZgJZ3ccRF8IMb4ZsdTKBgTPCJ/ps9ttV8k1H3WsTJWewL2GImtQqzTSdMCQD3ndZQ
         Cro9JKDoorp/CLI0wbSVBz8+wxROhuMyDqF7exGhe158ptyPnxH3zvWVnFnWPuek5kVG
         sGHYYtLtbm0Og3/h2rmK6+p44SlXz+Yp5dAS4f6KDO4FA+1TGz3o+QOZ48qr5WVsQA36
         8dvw==
X-Gm-Message-State: APjAAAUS8iaebaVkXx1bVuUn9wmcQ0Fbk4iusEcM62mLhhrGJLnqDMOn
        iJxyWISdnzBbZMbP4iNOOjnqvw==
X-Google-Smtp-Source: APXvYqwuTDywmZkXR49l0QQyuPDwUOxcYvZ2qEuCze7dUJp0lEXUsMF+xad0MMk/74xUr8QHQOF1Pw==
X-Received: by 2002:a62:27c3:: with SMTP id n186mr9544535pfn.58.1569418124305;
        Wed, 25 Sep 2019 06:28:44 -0700 (PDT)
Received: from chromium.org ([2620:15c:202:1:fa53:7765:582b:82b9])
        by smtp.gmail.com with ESMTPSA id c1sm4606591pfb.135.2019.09.25.06.28.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Sep 2019 06:28:43 -0700 (PDT)
Message-ID: <5d8b6b8b.1c69fb81.14b36.c053@mx.google.com>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20190925055933.GA2810@tuxbook-pro>
References: <20190925054133.206992-1-swboyd@chromium.org> <20190925055933.GA2810@tuxbook-pro>
Cc:     Georgi Djakov <georgi.djakov@linaro.org>,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Maxime Ripard <mripard@kernel.org>, linux-pm@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        Evan Green <evgreen@chromium.org>,
        David Dai <daidavid1@codeaurora.org>
To:     Bjorn Andersson <bjorn.andersson@linaro.org>
From:   Stephen Boyd <swboyd@chromium.org>
Subject: Re: [RFC PATCH] interconnect: Replace of_icc_get() with icc_get() and reduce DT binding
User-Agent: alot/0.8.1
Date:   Wed, 25 Sep 2019 06:28:42 -0700
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Quoting Bjorn Andersson (2019-09-24 22:59:33)
> On Tue 24 Sep 22:41 PDT 2019, Stephen Boyd wrote:
>=20
> > The DT binding could also be simplified somewhat. Currently a path needs
> > to be specified in DT for each and every use case that is possible for a
> > device to want. Typically the path is to memory, which looks to be
> > reserved for in the binding with the "dma-mem" named path, but sometimes
> > the path is from a device to the CPU or more generically from a device
> > to another device which could be a CPU, cache, DMA master, or another
> > device if some sort of DMA to DMA scenario is happening. Let's remove
> > the pair part of the binding so that we just list out a device's
> > possible endpoints on the bus or busses that it's connected to.
> >=20
> > If the kernel wants to figure out what the path is to memory or the CPU
> > or a cache or something else it should be able to do that by finding the
> > node for the "destination" endpoint, extracting that node's
> > "interconnects" property, and deriving the path in software. For
> > example, we shouldn't need to write out each use case path by path in DT
> > for each endpoint node that wants to set a bandwidth to memory. We
> > should just be able to indicate what endpoint(s) a device sits on based
> > on the interconnect provider in the system and then walk the various
> > interconnects to find the path from that source endpoint to the
> > destination endpoint.
> >=20
>=20
> But doesn't this implies that the other end of the path is always some
> specific node, e.g. DDR? With a single node how would you describe
> CPU->LLCC or GPU->OCIMEM?

By only specifying the endpoint the device uses it describes what the
hardware block interfaces with. It doesn't imply that there's only one
other end of the path. It implies that the paths should be discoverable
by walking the interconnect graph given some source device node and
target device node. In most cases the target device node will be a DDR
controller node, but sometimes it could be LLCC or OCIMEM. We may need
to add some sort of "get the DDR controller device" API or work it into
the interconnect API somehow to indicate what target endpoint is
desired. By not listing all those paths in DT we gain flexibility to add
more paths later on without having to update or tweak DT to describe
more paths/routes through the interconnect.

>=20
> > Obviously this patch doesn't compile but I'm sending it out to start
> > this discussion so we don't get stuck on the binding or the kernel APIs
> > for a long time. It looks like we should be OK in terms of backwards
> > compatibility because we can just ignore the second element in an old
> > binding, but maybe we'll want to describe paths in different directions
> > (e.g. the path from the CPU to the SD controller may be different than
> > the path the SD controller takes to the CPU) and that may require
> > extending interconnect-names to indicate what direction/sort of path it
> > is. I'm basically thinking about master vs. slave ports in AXI land.
> >=20
> > Cc: Maxime Ripard <mripard@kernel.org>
> > Cc: <linux-pm@vger.kernel.org>
> > Cc: Rob Herring <robh+dt@kernel.org>
> > Cc: <devicetree@vger.kernel.org>
> > Cc: Bjorn Andersson <bjorn.andersson@linaro.org>
> > Cc: Evan Green <evgreen@chromium.org>
> > Cc: David Dai <daidavid1@codeaurora.org>
> > Signed-off-by: Stephen Boyd <swboyd@chromium.org>
> > ---
> >  .../bindings/interconnect/interconnect.txt    | 19 ++++---------------
> >  include/linux/interconnect.h                  | 13 ++-----------
> >  2 files changed, 6 insertions(+), 26 deletions(-)
> >=20
> > diff --git a/Documentation/devicetree/bindings/interconnect/interconnec=
t.txt b/Documentation/devicetree/bindings/interconnect/interconnect.txt
> > index 6f5d23a605b7..f8979186b8a7 100644
> > --- a/Documentation/devicetree/bindings/interconnect/interconnect.txt
> > +++ b/Documentation/devicetree/bindings/interconnect/interconnect.txt
> > @@ -11,7 +11,7 @@ The interconnect provider binding is intended to repr=
esent the interconnect
> >  controllers in the system. Each provider registers a set of interconne=
ct
> >  nodes, which expose the interconnect related capabilities of the inter=
connect
> >  to consumer drivers. These capabilities can be throughput, latency, pr=
iority
> > -etc. The consumer drivers set constraints on interconnect path (or end=
points)
> > +etc. The consumer drivers set constraints on interconnect paths (or en=
dpoints)
> >  depending on the use case. Interconnect providers can also be intercon=
nect
> >  consumers, such as in the case where two network-on-chip fabrics inter=
face
> >  directly.
> > @@ -42,23 +42,12 @@ multiple paths from different providers depending o=
n use case and the
> >  components it has to interact with.
> > =20
> >  Required properties:
> > -interconnects : Pairs of phandles and interconnect provider specifier =
to denote
> > -             the edge source and destination ports of the interconnect=
 path.
> > -
> > -Optional properties:
> > -interconnect-names : List of interconnect path name strings sorted in =
the same
> > -                  order as the interconnects property. Consumers drive=
rs will use
> > -                  interconnect-names to match interconnect paths with =
interconnect
> > -                  specifier pairs.
> > -
> > -                     Reserved interconnect names:
> > -                      * dma-mem: Path from the device to the main memo=
ry of
> > -                                 the system
> > +interconnects : phandle and interconnect provider specifier to denote
> > +             the edge source for this node.
> > =20
> >  Example:
> > =20
> >       sdhci@7864000 {
> >               ...
> > -             interconnects =3D <&pnoc MASTER_SDCC_1 &bimc SLAVE_EBI_CH=
0>;
> > -             interconnect-names =3D "sdhc-mem";
> > +             interconnects =3D <&pnoc MASTER_SDCC_1>;
>=20
> This example seems incomplete, as it doesn't describe the path between
> CPU and the config space, with this in place I think you need the
> interconnect-names.
>=20
>=20
> But with a single interconnect, the interconnect-names should be
> omitted, as done in other frameworks.
>=20

Sure, no names makes sense when it's just one path.

