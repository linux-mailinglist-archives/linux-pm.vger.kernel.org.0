Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AD4E033DB3C
	for <lists+linux-pm@lfdr.de>; Tue, 16 Mar 2021 18:46:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239070AbhCPRqT (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 16 Mar 2021 13:46:19 -0400
Received: from mail.kernel.org ([198.145.29.99]:39650 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S239065AbhCPRqA (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Tue, 16 Mar 2021 13:46:00 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id E23366511D;
        Tue, 16 Mar 2021 17:45:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1615916760;
        bh=fv99BFpn0kVD4tIuLFxKSv7861ZMLBNH/EcrKILKjWA=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=BSdeS4+h/m2Z1HFtKSJaM0YH6JBMgillWeQUbEPHJZjOiEXMstu0LQXm40qgyBGSe
         VIui+USpn59HDldtZJBG8GDotCSiCTvlAishfMW7Amdi+Hp64x0m5MxsWKwQf+bfk3
         Tdj1CC3USsHJWD1KOAT3CUtMPwRi6/6pZO86q+MtRdmhT3r3wbcdq7BQ/2x8NZnsI7
         7LY7KmTud4zmjJS4Ui3n+rN05ZaXIfdX1fB/c1y2BGjGyMchC++SN/FsVCCViIG4xO
         Usggb+w5LQIjY8rtJj+26lDp/qjbjW2X0reN1JqGmkt0uLTlJc96zpRlkhlYBcYsSC
         jgRWUi6qHCNCw==
Received: by mail-qt1-f174.google.com with SMTP id h7so5473313qtx.3;
        Tue, 16 Mar 2021 10:45:59 -0700 (PDT)
X-Gm-Message-State: AOAM531LJ8qYb3T6GAhVukQS+Uy5COfMidofJ9O49aTgb58o8phDl31L
        nA1obfU6Na91ZMGmtYK8pjUOpkWY3dzb3BA24g==
X-Google-Smtp-Source: ABdhPJyh1Ha2+4TxIsexwUabykknLWRHcI7Rq8n5sV2gDBe46i8TR7G68RlC5F/J8yDmYzHcZ3KPg1lu9rpEeyL5DBg=
X-Received: by 2002:ac8:70d1:: with SMTP id g17mr55587qtp.306.1615916759130;
 Tue, 16 Mar 2021 10:45:59 -0700 (PDT)
MIME-Version: 1.0
References: <20210312154357.1561730-1-sebastian.reichel@collabora.com>
 <20210312154357.1561730-9-sebastian.reichel@collabora.com>
 <CAL_Jsq+i=sB7nDzBeF3nRa8FuM_8v=P2SMXQ5XNmuP3b615CKg@mail.gmail.com> <20210316162227.jzueo7cowo6l6isv@earth.universe>
In-Reply-To: <20210316162227.jzueo7cowo6l6isv@earth.universe>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Tue, 16 Mar 2021 11:45:47 -0600
X-Gmail-Original-Message-ID: <CAL_JsqK3Yc4K3LwNYvC4bLT_1kA0THMeGcB0tLdPSc_q1CBE9A@mail.gmail.com>
Message-ID: <CAL_JsqK3Yc4K3LwNYvC4bLT_1kA0THMeGcB0tLdPSc_q1CBE9A@mail.gmail.com>
Subject: Re: [PATCH 08/38] dt-bindings: power: supply: bq24735: Convert to DT
 schema format
To:     Sebastian Reichel <sebastian.reichel@collabora.com>
Cc:     "open list:THERMAL" <linux-pm@vger.kernel.org>,
        devicetree@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Collabora Kernel ML <kernel@collabora.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Tue, Mar 16, 2021 at 10:22 AM Sebastian Reichel
<sebastian.reichel@collabora.com> wrote:
>
> Hi,
>
> On Mon, Mar 15, 2021 at 12:24:09PM -0600, Rob Herring wrote:
> > On Fri, Mar 12, 2021 at 8:44 AM Sebastian Reichel
> > > +  poll-interval:
> > > +    description: |
> > > +      If 'interrupts' is not specified, poll AC adapter presence with this interval (milliseconds).
> >
> > Needs a type.
>
> Ack. Just out of curiousity: Do you know why this was not pointed
> out by dt_binding_check?

There's not really any way we can because there's not a pattern to
match on. So we'd have to do a specific meta-schema for
'poll-interval'. Though maybe we could restructure things to provide a
meta-schema for anything that isn't a common, known property name or a
vendor property.

Rob
