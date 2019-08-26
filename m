Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CDC3B9D7D3
	for <lists+linux-pm@lfdr.de>; Mon, 26 Aug 2019 22:55:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726220AbfHZUzy (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 26 Aug 2019 16:55:54 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:40644 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726020AbfHZUzx (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 26 Aug 2019 16:55:53 -0400
Received: by mail-pl1-f196.google.com with SMTP id h3so10608742pls.7
        for <linux-pm@vger.kernel.org>; Mon, 26 Aug 2019 13:55:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=message-id:mime-version:content-transfer-encoding:in-reply-to
         :references:cc:subject:to:from:user-agent:date;
        bh=FghN6Mc40EPJyH60IJRS3NSuxjYJJ6oJa+6cfkHbcEQ=;
        b=CG3B73JctUodMjIEjMsdzkgftz3Lk7Hw301lt+ChJplNaD4WWljA7Mf07AXYJSksH1
         zK8iBXNS71J22cYdDCipqCOVcu10jmcRPqdcB4jWsfUDB3moMUaJLamzkZumWqO4cAbv
         x9nBWiUT7BbCgCsl6xfUyRcRXV8tN/eRY/9eo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:mime-version
         :content-transfer-encoding:in-reply-to:references:cc:subject:to:from
         :user-agent:date;
        bh=FghN6Mc40EPJyH60IJRS3NSuxjYJJ6oJa+6cfkHbcEQ=;
        b=RntKXG2nx//MDh1YPKet/vmGYslWhi87uREourQEdUWjrN3NkglyeBxSaNiNxi7JyF
         m75sTh18iQeMMpOqA9+n2j7B2mTIe2Hma/vcbqqDuVNwp3CyNx59RaCF9hamy/3Q5NMa
         cBVrumMhDXiQhfeNyPd4tqgjThRtOrYgkU/JgNcVf1CQxzr9jbtpCOQclialRcSJ7Va+
         VkjOrumzmR/EKTfyn2UBPwC2ewOg2Ip3isAd8fkKCIVI9i9wvXtFHqSXNTlHzMHNeDrI
         zBUYmW5ryGWSEhYAiBGC1qyq12ZC4KL5GeKcJaArNf0KFiiiQgUQlrOBCqxErBpJYkAI
         G+zw==
X-Gm-Message-State: APjAAAVxzttZ4zN2qYpEcx16LTUjz7nWgPQNHo1JVwGmd4zYL2Dv/lkU
        YSEX2gaYiHOjTeschTpL1ImU+A==
X-Google-Smtp-Source: APXvYqx9XXxGe4Jgq3CTT3CN1lc1lQpUBmkZwGA+hD5RxJH41Dh4HIrKDUhBYRQDSJhlhN27af5CzA==
X-Received: by 2002:a17:902:a40d:: with SMTP id p13mr20580372plq.92.1566852953013;
        Mon, 26 Aug 2019 13:55:53 -0700 (PDT)
Received: from chromium.org ([2620:15c:202:1:fa53:7765:582b:82b9])
        by smtp.gmail.com with ESMTPSA id v184sm11039530pgd.34.2019.08.26.13.55.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Aug 2019 13:55:52 -0700 (PDT)
Message-ID: <5d644758.1c69fb81.76a4f.cf59@mx.google.com>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <CAP245DV=pVF1oK2eFvK=iRng=Qxg=oDLWmHXBWtJH=VMxmmAvQ@mail.gmail.com>
References: <cover.1564091601.git.amit.kucheria@linaro.org> <534b5017c2210ba8d541c206dace204d6617b4c9.1564091601.git.amit.kucheria@linaro.org> <5d577d77.1c69fb81.b6b07.83e6@mx.google.com> <CAHLCerMpWTVquyM3fYQxz-ZhDvnY276hfnZvZOmjV--cgm53UQ@mail.gmail.com> <5d5ab1e0.1c69fb81.d71db.1ca3@mx.google.com> <CAP245DV=pVF1oK2eFvK=iRng=Qxg=oDLWmHXBWtJH=VMxmmAvQ@mail.gmail.com>
Cc:     Andy Gross <agross@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Rob Herring <robh+dt@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Andy Gross <andy.gross@linaro.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Eduardo Valentin <edubezval@gmail.com>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux PM list <linux-pm@vger.kernel.org>
Subject: Re: [PATCH 04/15] drivers: thermal: tsens: Add debugfs support
To:     Amit Kucheria <amit.kucheria@linaro.org>
From:   Stephen Boyd <swboyd@chromium.org>
User-Agent: alot/0.8.1
Date:   Mon, 26 Aug 2019 13:55:51 -0700
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Quoting Amit Kucheria (2019-08-21 05:55:39)
> On Mon, Aug 19, 2019 at 7:57 PM Stephen Boyd <swboyd@chromium.org> wrote:
> >
> > Quoting Amit Kucheria (2019-08-19 00:58:23)
> > > On Sat, Aug 17, 2019 at 9:37 AM Stephen Boyd <swboyd@chromium.org> wr=
ote:
> > > > > +
> > > > > +static void tsens_debug_init(struct platform_device *pdev)
> > > > > +{
> > > > > +       struct tsens_priv *priv =3D platform_get_drvdata(pdev);
> > > > > +       struct dentry *root, *file;
> > > > > +
> > > > > +       root =3D debugfs_lookup("tsens", NULL);
> > > >
> > > > Does this get created many times? Why doesn't tsens have a pointer =
to
> > > > the root saved away somewhere globally?
> > > >
> > >
> > > I guess we could call the statement below to create the root dir and
> > > save away the pointer. I was trying to avoid #ifdef CONFIG_DEBUG_FS in
> > > init_common() and instead have all of it in a single function that
> > > gets called once per instance of the tsens controller.
> >
> > Or call this code many times and try to create the tsens node if
> > !tsens_root exists where the variable is some global.
>=20
> So I didn't quite understand this statement. The change you're
> requesting is that the 'root' variable below should be a global?
>=20
> tsens_probe() will get called twice on platforms with two instances of
> the controller. So I will need to check some place if the 'tsens' root
> dir already exists in debugfs, no? That is what I'm doing below.
>=20

Yeah. I was suggesting making a global instead of doing the lookup, but
I guess the lookup is fine and avoids a global variable. It's all
debugfs so it doesn't really matter. Sorry! Do whatever then.

