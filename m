Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BB7C9826A7
	for <lists+linux-pm@lfdr.de>; Mon,  5 Aug 2019 23:15:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730600AbfHEVPR (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 5 Aug 2019 17:15:17 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:41596 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730572AbfHEVPQ (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 5 Aug 2019 17:15:16 -0400
Received: by mail-pf1-f195.google.com with SMTP id m30so40274232pff.8
        for <linux-pm@vger.kernel.org>; Mon, 05 Aug 2019 14:15:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=message-id:mime-version:content-transfer-encoding:in-reply-to
         :references:subject:from:cc:to:user-agent:date;
        bh=6keXzspKhAmzHHzUYun2hJRtsp74WGjMcjc/4i8xe0o=;
        b=IPgMHj+EcmPJ2dDH01EyZqip1NHlIJQNthd6U1205Ff0WJvlhkvwc8qLu8636IzfIV
         d1eP/tAlFQNp1tuEqKZBk2JCAGKEQ1YBKU3PAVAInp/d9O+WHourXyWS556U3XvXkbWy
         6HvgO1wLh5JtSyn4/J3b+laIkLf/HYISi8P4M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:mime-version
         :content-transfer-encoding:in-reply-to:references:subject:from:cc:to
         :user-agent:date;
        bh=6keXzspKhAmzHHzUYun2hJRtsp74WGjMcjc/4i8xe0o=;
        b=a3xehRoKmNxUhrf00QfWJwGoek+UhSyCeBV6JEwLe8Bf7CvkK5U3mjBdr4awOHpnB1
         vIwCgKN+/rEgz/3x2QG5tXPCYSabm9AZJwbRmbQ8cNEJhdKYcm38z/mNRjdUNFICIeSe
         oxDll2OyPzjeRRb5l/VgKPPCtLLC+cZmRAnD371MoS5VNzGpMGtY7SuE/xcIoWVh4Oxz
         AMzKpIDUPJrgmnJRQP0Z1Eq/cxwJmbnOAUOz4i5uXGliZqTbGt0Je6xpkWCUgFhZySEG
         BJpK/xFh3gUO3aVoFZZlG6U4gVG95vZ1tbw9G40DQukEfNaJQ/07eplUT2tXYPgTGHyf
         uQUg==
X-Gm-Message-State: APjAAAVg9Kl+NaR3+6ODqgKdy0XcpjGxNlpuY3Mvv1ODKrA1195jQSso
        Oev0XfgBCZgBMkTHUZp9Vee3gg==
X-Google-Smtp-Source: APXvYqxUCVPnWbjyu68XCc3fQ5aGD1/GCroeo2qy0DJlXwm8x/Cq36U/Awi4tu3dV9++yFSmFeBFVA==
X-Received: by 2002:a17:90a:208d:: with SMTP id f13mr19474353pjg.68.1565039716253;
        Mon, 05 Aug 2019 14:15:16 -0700 (PDT)
Received: from chromium.org ([2620:15c:202:1:fa53:7765:582b:82b9])
        by smtp.gmail.com with ESMTPSA id i126sm99416306pfb.32.2019.08.05.14.15.15
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 05 Aug 2019 14:15:15 -0700 (PDT)
Message-ID: <5d489c63.1c69fb81.f26ec.f009@mx.google.com>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <CANA+-vBX0ZAyZu3itcHUpFcqbbDsa5n3xz547mMYCn_q2dbHtw@mail.gmail.com>
References: <20190805175848.163558-1-trong@android.com> <20190805175848.163558-2-trong@android.com> <5d48976e.1c69fb81.a6781.3565@mx.google.com> <CANA+-vBX0ZAyZu3itcHUpFcqbbDsa5n3xz547mMYCn_q2dbHtw@mail.gmail.com>
Subject: Re: [PATCH v7 1/3] PM / wakeup: Drop wakeup_source_init(), wakeup_source_prepare()
From:   Stephen Boyd <swboyd@chromium.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Hridya Valsaraju <hridya@google.com>,
        Sandeep Patil <sspatil@google.com>,
        Kalesh Singh <kaleshsingh@google.com>,
        Ravi Chandra Sadineni <ravisadineni@chromium.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        "Cc: Android Kernel" <kernel-team@android.com>
To:     Tri Vo <trong@android.com>
User-Agent: alot/0.8.1
Date:   Mon, 05 Aug 2019 14:15:14 -0700
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Quoting Tri Vo (2019-08-05 14:11:55)
> On Mon, Aug 5, 2019 at 1:54 PM Stephen Boyd <swboyd@chromium.org> wrote:
> >
> > Quoting Tri Vo (2019-08-05 10:58:46)
> > > @@ -96,13 +79,23 @@ EXPORT_SYMBOL_GPL(wakeup_source_prepare);
> > >  struct wakeup_source *wakeup_source_create(const char *name)
> > >  {
> > >         struct wakeup_source *ws;
> > > +       const char *ws_name;
> > >
> > > -       ws =3D kmalloc(sizeof(*ws), GFP_KERNEL);
> > > +       ws =3D kzalloc(sizeof(*ws), GFP_KERNEL);
> > >         if (!ws)
> > > -               return NULL;
> > > +               goto err_ws;
> > > +
> > > +       ws_name =3D kstrdup_const(name, GFP_KERNEL);
> > > +       if (!ws_name)
> >
> > Does this intentionally change this function to return an error if
> > 'name' is NULL? Before, wakeup_source_prepare() would just assign
> > ws->name to NULL, but now it errors out. I don't see how it's good or
> > useful to allow NULL for the wakeup source name, but it is what it is.
>=20
> Yes, the change to not allow ws->name to be NULL is intentional.

Ok. It would be good to mention it in the commit text so we don't think
it was a bug when looking back a few months later.

