Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E0F83262735
	for <lists+linux-pm@lfdr.de>; Wed,  9 Sep 2020 08:35:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725826AbgIIGfQ (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 9 Sep 2020 02:35:16 -0400
Received: from mail.kernel.org ([198.145.29.99]:43118 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725772AbgIIGfP (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 9 Sep 2020 02:35:15 -0400
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5CFB721532;
        Wed,  9 Sep 2020 06:35:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599633314;
        bh=Jmx/gfAeiOp0+n83Y104nKTHVJsUUirr9Zyouh3z9SU=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=VlIdGeGSfpCGWydEZHncvsgvg1D5Z8pouy4+Dqm+6/KZiUq7yX1jvu+MzDXNEW7Dl
         rYgZusNXR/xgUbzojzQ+RpAXx/Wk2eiWFvgcaqXeddT8QBOtJO0M0m6oG2rnQKQdJi
         wEv+AxBeAzv7md3R4YVg0pa/sioRq59uT0eOPHYc=
Received: by mail-ed1-f53.google.com with SMTP id g4so1491440edk.0;
        Tue, 08 Sep 2020 23:35:14 -0700 (PDT)
X-Gm-Message-State: AOAM531AiNdrbl+vC3jLk+C3OR97TZ8LVlU5umRPvj318zfKXy61XARg
        nCBlNVMi3naFIqFteuxLwxrMdhnhQIC4Ro1mU20=
X-Google-Smtp-Source: ABdhPJyCJq3WS5QRVis8ksBg0a87Uu5M+O+XbjQlSrq+pcwAoif/S8fpOajpxZgwaqRsy01DOOInpTGlPkijuzyYbNE=
X-Received: by 2002:aa7:da16:: with SMTP id r22mr2682276eds.132.1599633312940;
 Tue, 08 Sep 2020 23:35:12 -0700 (PDT)
MIME-Version: 1.0
References: <20200908201319.3567-1-krzk@kernel.org> <20200908201319.3567-2-krzk@kernel.org>
 <33361ba9-51df-3b09-6744-9806cdf166db@ti.com>
In-Reply-To: <33361ba9-51df-3b09-6744-9806cdf166db@ti.com>
From:   Krzysztof Kozlowski <krzk@kernel.org>
Date:   Wed, 9 Sep 2020 08:35:01 +0200
X-Gmail-Original-Message-ID: <CAJKOXPcfMPPK4eUWfU5ifJodt0nd-b+hxKV1AQ6oGbnXi--cdw@mail.gmail.com>
Message-ID: <CAJKOXPcfMPPK4eUWfU5ifJodt0nd-b+hxKV1AQ6oGbnXi--cdw@mail.gmail.com>
Subject: Re: [PATCH 2/7] power: supply: bq27xxx: report "not charging" on all types
To:     Dan Murphy <dmurphy@ti.com>
Cc:     Sebastian Reichel <sre@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        =?UTF-8?Q?Pali_Roh=C3=A1r?= <pali@kernel.org>,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Tue, 8 Sep 2020 at 22:54, Dan Murphy <dmurphy@ti.com> wrote:
>
> Krzysztof
>
> On 9/8/20 3:13 PM, Krzysztof Kozlowski wrote:
> > Commit 6f24ff97e323 ("power: supply: bq27xxx_battery: Add the
> > BQ27Z561 Battery monitor") and commit d74534c27775 ("power:
> > bq27xxx_battery: Add support for additional bq27xxx family devices")
> > added support for new device types by copying most of the code and
> > adding necessary quirks.
> >
> > However they did not copy the code in bq27xxx_battery_status()
> > responsible for returning POWER_SUPPLY_STATUS_NOT_CHARGING.
> >
> > Unify the bq27xxx_battery_status() so for all types when charger is
> > supplied, it will return "not charging" status.
>
> If this is a fix then please populate the Fixes tag.
>
> But not sure how both commits are tied here

I am not convinced that it is a fix. It's rather missing functionality
on these new devices. The commits did not break anything. They just
did not implement "not charging" for new types.

Best Regards,
Krzysztof
