Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0936B34549C
	for <lists+linux-pm@lfdr.de>; Tue, 23 Mar 2021 02:06:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231548AbhCWBFw (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 22 Mar 2021 21:05:52 -0400
Received: from mail.kernel.org ([198.145.29.99]:37138 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231481AbhCWBFm (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Mon, 22 Mar 2021 21:05:42 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 867E3619A0;
        Tue, 23 Mar 2021 01:05:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1616461541;
        bh=cjs3F39gfgCw4AONgF6JQMceGgCHpX/zP/p6JQ+Ogpc=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=cJHadrQlVuJMF/6i9v/ECHltUVcdnCEDOo2FMlbPHMvJWy+8mrcGWNjUitPh5SU0W
         /aX2VvpuGNSnJYoDYUX65pQsflqssJQEvg394N6yCpRXDqUw6D9TvMeZzmdA4AsaQ3
         nJ2vgLwRDIHXHK2Gb963LgcMd6MzgijlJ7LsT8vlUt5+0aHpEGswGs7m5+OsOy0xKZ
         lUXkiztvg1bAtiCW+uRUKJCov2f2g93qH1RMim2M5sSo/iBYOfyKhhHJ+X9beaIpb6
         w6Uh7U3DTUXzCgUxAtgspDRKGpbP+MKkc6cGweEHZQDT+8KiIcS2ioszueWPFNIcY3
         EHpxDetgvbzRw==
Received: by mail-ej1-f44.google.com with SMTP id a7so24319769ejs.3;
        Mon, 22 Mar 2021 18:05:41 -0700 (PDT)
X-Gm-Message-State: AOAM531ovWgesX9SjX1gLylFjuzKG5+AMydwe0QCdz1ZA2yH/q3lnl3s
        twXg7tIb/GMMPBIlIxU64GebAYhWPifv2P2kDw==
X-Google-Smtp-Source: ABdhPJwQnmr8ntzvspPT3CUa58Lov2gbyZ6FvMCvVwjklpPn58MIRTIwtRtEQjG1XNpC269TmEWu/wQHLRl7vp4jQR0=
X-Received: by 2002:a17:906:7d48:: with SMTP id l8mr2385795ejp.108.1616461540092;
 Mon, 22 Mar 2021 18:05:40 -0700 (PDT)
MIME-Version: 1.0
References: <20210317134904.80737-1-sebastian.reichel@collabora.com>
 <CAL_JsqLASixNRTf712201w1nghxdaB28HsN7fdsjeogsoA=oQg@mail.gmail.com> <20210322214257.3u6dkmygygnewpyl@earth.universe>
In-Reply-To: <20210322214257.3u6dkmygygnewpyl@earth.universe>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Mon, 22 Mar 2021 19:05:27 -0600
X-Gmail-Original-Message-ID: <CAL_JsqJg_P3+hG3VeG0FkdxNDjrt8DKu-cfUT8yD9Q2=4y5D1A@mail.gmail.com>
Message-ID: <CAL_JsqJg_P3+hG3VeG0FkdxNDjrt8DKu-cfUT8yD9Q2=4y5D1A@mail.gmail.com>
Subject: Re: [PATCHv2 00/38] Convert power-supply DT bindings to YAML
To:     Sebastian Reichel <sebastian.reichel@collabora.com>
Cc:     Tony Lindgren <tony@atomide.com>,
        "open list:THERMAL" <linux-pm@vger.kernel.org>,
        devicetree@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Collabora Kernel ML <kernel@collabora.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Mon, Mar 22, 2021 at 3:43 PM Sebastian Reichel
<sebastian.reichel@collabora.com> wrote:
>
> Hi,
>
> On Mon, Mar 22, 2021 at 10:25:49AM -0600, Rob Herring wrote:
> > On Wed, Mar 17, 2021 at 7:49 AM Sebastian Reichel wrote:
> > > Sebastian Reichel (38):
> > >   ARM: dts: motorola-cpcap-mapphone: Prepare for dtbs_check parsing
> > >   dt-bindings: power: supply: cpcap-battery: Convert to DT schema format
> > >   dt-bindings: power: supply: cpcap-charger: Convert to DT schema format
> > >   [...]
> >
> > Thanks! For the series:
> >
> > Reviewed-by: Rob Herring <robh@kernel.org>
>
> How should we proceed with the DTS patch?
>
> a) Tony takes DT through his tree, I take all YAML files through my tree.
>    The verification might be broken for some time when being merged
>    in wrong order. Looks like there are already quite a few warnings
>    for in-tree DTS files, so it might be ok to have some more
>    temporarily? It's obviously the most simple solution.

This is fine. We're not anywhere close to warning free.

>
> b) Tony takes DTS and the cpcap related patches through his tree;
>    I take the other ones.
>
> c) I take the full series through my tree.
>
> d) I can merge the DT through an immutable branch and provide a PR.
>
> I'm fine with either way.
>
> -- Sebastian
