Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 98EC674390
	for <lists+linux-pm@lfdr.de>; Thu, 25 Jul 2019 05:01:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389341AbfGYDBl (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 24 Jul 2019 23:01:41 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:38675 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389299AbfGYDBk (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 24 Jul 2019 23:01:40 -0400
Received: by mail-pf1-f196.google.com with SMTP id y15so21934992pfn.5
        for <linux-pm@vger.kernel.org>; Wed, 24 Jul 2019 20:01:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=jqf8vsSQMR94XfPuzjd466qFEcaiXpTcAQ55AzJc7DU=;
        b=wn50C/Q84xBwjLKKhX7OkkbWtf+dnGxzOKobzhNmx0UeEP8PAmThBR92dQMa1IyUIb
         XUkuQxe35kpZS357GCgy1y4VcJ43hVV37YzTNEHmLLWqiSXlqtFoZSbGcukA4/nNY4ub
         ZO5D2VV9yh29Yw3Iumsw1Q20b76lKOWgG7XxgdgI7WLXeDVMN0VzbNqCypJfwWWoA/PJ
         AYGdncDNfONlMkaRK7M8FQrgxVLAhKY7aslJa0hwfzArkVbBd9z2PRwMTbfVd00rpIrL
         /bTF2fdAyIUg2eYB3nDx9fplBJGpwu3t7od4Ws123jeIsa3ECOD2ILLZYXNCwQJCQ0mO
         TF4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=jqf8vsSQMR94XfPuzjd466qFEcaiXpTcAQ55AzJc7DU=;
        b=XY38W/JFcMqt9V0pA4/LL/Nhh75sJbjPG0KJyGmCM/hP1gcRIV8t8RHOnECbKYT32V
         Su9Ye6dkFM4/wgCIWvbc9o/94Bloxf7NXym0UzTA9LUR0xsJYqFYwvbHc2ggoAhRoeBM
         hyBekMaw/RqOKHYn3ewDmC3Jzt2f9HPgguKACE5ghvtysufkb4Tv8v/Sx2sLen4rIxFS
         vIu/yvzUGlHMAb43Pu+lPE9uGRRHLvf8DsZDN12m5drWU6U+n4mjsZumikNR8uM5SszP
         uGXgepoxrCQobkCTIItsxtPjnlW+G3/Nw1lL0xJP580JaqS7rUEkOXyYn2S/j1gwKs+l
         Ngcw==
X-Gm-Message-State: APjAAAXZTZAXPfZRW7v1ygwdgZeRUZDnCr8EdL7Js6aImvZtBAo6z6ZI
        qdgEbokNBgu3GgFyLLUldutIYg==
X-Google-Smtp-Source: APXvYqw71EQNZoF1EeaQQUf7DPyno7aB8xgu0IkSJ2vtzF50+7ew4BZC2tgrZsLg3aSp2DcnXv0obQ==
X-Received: by 2002:a63:1046:: with SMTP id 6mr86480080pgq.111.1564023700028;
        Wed, 24 Jul 2019 20:01:40 -0700 (PDT)
Received: from localhost ([122.172.28.117])
        by smtp.gmail.com with ESMTPSA id g2sm62095703pfb.95.2019.07.24.20.01.38
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 24 Jul 2019 20:01:39 -0700 (PDT)
Date:   Thu, 25 Jul 2019 08:31:37 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Saravana Kannan <saravanak@google.com>
Cc:     MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
        Stephen Boyd <sboyd@kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Sibi Sankar <sibis@codeaurora.org>,
        Android Kernel Team <kernel-team@android.com>,
        Linux PM <linux-pm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 5/5] PM / devfreq: Add required OPPs support to
 passive governor
Message-ID: <20190725030137.uz22iwvdv37fsw56@vireshk-i7>
References: <20190717222340.137578-1-saravanak@google.com>
 <20190717222340.137578-6-saravanak@google.com>
 <20190723100406.7zchvflrmoaipxek@vireshk-i7>
 <CAGETcx89X0Xra+3HK+jbuCHXMgRL7QCwSShyMy7DY2Bg1eVjDQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAGETcx89X0Xra+3HK+jbuCHXMgRL7QCwSShyMy7DY2Bg1eVjDQ@mail.gmail.com>
User-Agent: NeoMutt/20180716-391-311a52
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 23-07-19, 17:26, Saravana Kannan wrote:
> On Tue, Jul 23, 2019 at 3:04 AM Viresh Kumar <viresh.kumar@linaro.org> wrote:
> > On 17-07-19, 15:23, Saravana Kannan wrote:
> > >       /*
> > > @@ -56,13 +56,20 @@ static int devfreq_passive_get_target_freq(struct devfreq *devfreq,
> > >        * list of parent device. Because in this case, *freq is temporary
> > >        * value which is decided by ondemand governor.
> > >        */
> > > -     opp = devfreq_recommended_opp(parent_devfreq->dev.parent, freq, 0);
> > > -     if (IS_ERR(opp)) {
> > > -             ret = PTR_ERR(opp);
> > > +     p_opp = devfreq_recommended_opp(parent_devfreq->dev.parent, freq, 0);
> > > +     if (IS_ERR(p_opp)) {
> > > +             ret = PTR_ERR(p_opp);
> > >               goto out;
> > >       }
> > >
> > > -     dev_pm_opp_put(opp);
> > > +     if (devfreq->opp_table && parent_devfreq->opp_table)
> > > +             opp = dev_pm_opp_xlate_opp(parent_devfreq->opp_table,
> > > +                                        devfreq->opp_table, p_opp);
> >
> > you put p_opp right here.

What about this comment ?

> >
> > Also shouldn't you try to get p_opp under the above if block only? As
> > that is the only user of it ?
> 
> No, p_opp (used to be called opp) was used even before my changes. If
> there's no required-opps mapping this falls back to assuming the slave
> device OPP to pick should be the same index as the master device's
> opp.
> 
> So I believe this patch is correct as-is.

Right.

-- 
viresh
