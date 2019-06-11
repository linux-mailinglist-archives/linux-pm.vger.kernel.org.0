Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B4CA83D56F
	for <lists+linux-pm@lfdr.de>; Tue, 11 Jun 2019 20:23:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2407008AbfFKSXo (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 11 Jun 2019 14:23:44 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:45888 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2405802AbfFKSXo (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 11 Jun 2019 14:23:44 -0400
Received: by mail-pg1-f196.google.com with SMTP id w34so7408384pga.12;
        Tue, 11 Jun 2019 11:23:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=RUaqGS6QUgdTDoLllogq970LN7Ava4NDdFpVFqXYY/M=;
        b=GiGCJBrmLCcwdoXR/hfEWhxRxVXP0yUu9sUUZqvg4wVFwA5vVS81R3w7B/Hws02GBs
         bQf5m5LzSY2evhzZIaPcrTxdlRnOKG6JcgzyoPlFQaOBfdx4zG/zxciv5YgK+lrLTrxM
         cYO9J/gPwcAT2TpewnRYZ31E6KAMbCy2diEh13IEFyvzxVtxzxo7VvptCqzuA/hlCovh
         ZjKXMOGRmPvdeF+5XJnjjjFZqUja5TFKSjRPTAWJT6DPCrYdGGCmiq3H5dJ2O/MfvLXb
         zKyrSiVi+o3Z7jKpHKP2VcOUjPmBH9gPMgDgTzpANCDXfrsR2Ml+cEgzRas33f/OlAYk
         2KbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=RUaqGS6QUgdTDoLllogq970LN7Ava4NDdFpVFqXYY/M=;
        b=a4rfAAxg0jllo/QKU8pgoIIbLO0XeL21wlXCWdXccyzINLgktHVvPeNPIAbYHo0NqZ
         RMEkXkRKdmbad1TNtQ2+xis082vNVg/TEmpVUSYP+Md5a7ePy4KFbkvgfLg1D765cToC
         o3g+b0ICuvopsCQ99//TegC2LRF1xdqNi3cHDQVI/1+nMaBkk7ZCM+A/EXVrRHGOTaaI
         dMtTR9tywTiE0vlIEtdxKlV43poEuqAKUcXdowj8z12C5mHaK6UuAkYiUZIC5q2MbkxX
         2uyM6hRswjexKiR8I0sYvqL0L52blMsEBfweHXHHQVA0Rh5j9Vx0B4ezxWeBYxeVusrp
         zcSA==
X-Gm-Message-State: APjAAAUf/AE30PGBwe+HkthjSMwyzaW2o8+0iRKG1/rV22F+mPPBCjJ9
        0Oz71rQZz8u7wm1Vyb140WqPiUlYZ1L0EbQo0Hg=
X-Google-Smtp-Source: APXvYqz0tqszhCDpzjSzH68sStNjjm2tLdRCgCOXbFIcDIoXYykPNvT0ZevAXzhMLOzrGgeFEbCuT5n6tl8XXCDe+dk=
X-Received: by 2002:a17:90b:d8b:: with SMTP id bg11mr28168554pjb.30.1560277423232;
 Tue, 11 Jun 2019 11:23:43 -0700 (PDT)
MIME-Version: 1.0
References: <ff457774d46d96e8fe56b45409aba39d87a8672a.1559933665.git.mchehab+samsung@kernel.org>
 <0bea1c7c4fc06c7edabbf3185c0cbbc6e85eafd0.1559933665.git.mchehab+samsung@kernel.org>
 <CAHp75VfTNJOGZx-PoUXLRvzghqf6bVUdJ+yFjE9hNtDLCQ1=UA@mail.gmail.com> <20190611140501.11ba091b@coco.lan>
In-Reply-To: <20190611140501.11ba091b@coco.lan>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Tue, 11 Jun 2019 21:23:32 +0300
Message-ID: <CAHp75VcdMXHf=hz_m5ySZ-=fBU=qkFxry9Q-Dos9Jx0qoyHCXQ@mail.gmail.com>
Subject: Re: [PATCH v3 06/20] docs: mark orphan documents as such
To:     Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
Cc:     Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Mauro Carvalho Chehab <mchehab@infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Frederic Barrat <fbarrat@linux.ibm.com>,
        Andrew Donnellan <ajd@linux.ibm.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Sean Paul <sean@poorly.run>,
        Georgi Djakov <georgi.djakov@linaro.org>,
        Matan Ziv-Av <matan@svgalib.org>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        "open list:LINUX FOR POWERPC PA SEMI PWRFICIENT" 
        <linuxppc-dev@lists.ozlabs.org>,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm Mailing List <linux-arm-kernel@lists.infradead.org>,
        dri-devel@lists.freedesktop.org,
        Linux PM <linux-pm@vger.kernel.org>,
        Platform Driver <platform-driver-x86@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Tue, Jun 11, 2019 at 8:05 PM Mauro Carvalho Chehab
<mchehab+samsung@kernel.org> wrote:
>
> Em Tue, 11 Jun 2019 19:52:04 +0300
> Andy Shevchenko <andy.shevchenko@gmail.com> escreveu:
>
> > On Fri, Jun 7, 2019 at 10:04 PM Mauro Carvalho Chehab
> > <mchehab+samsung@kernel.org> wrote:
> > > Sphinx doesn't like orphan documents:
> >
> > >     Documentation/laptops/lg-laptop.rst: WARNING: document isn't included in any toctree
> >
> > >  Documentation/laptops/lg-laptop.rst             | 2 ++
> >
> > > diff --git a/Documentation/laptops/lg-laptop.rst b/Documentation/laptops/lg-laptop.rst
> > > index aa503ee9b3bc..f2c2ffe31101 100644
> > > --- a/Documentation/laptops/lg-laptop.rst
> > > +++ b/Documentation/laptops/lg-laptop.rst
> > > @@ -1,5 +1,7 @@
> > >  .. SPDX-License-Identifier: GPL-2.0+
> > >
> > > +:orphan:
> > > +
> > >  LG Gram laptop extra features
> > >  =============================
> > >
> >
> > Can we rather create a toc tree there?
> > It was a first document in reST format in that folder.
>
> Sure, but:
>
> 1) I have a patch converting the other files on this dir to rst:
>
>         https://git.linuxtv.org/mchehab/experimental.git/commit/?h=convert_rst_renames_v4.1&id=abc13233035fdfdbc5ef2f2fbd3d127a1ab15530
>
> 2) It probably makes sense to move the entire dir to
> Documentation/admin-guide.
>
> So, I would prefer to have the :orphan: here while (1) is not merged.

Fine to me as long as you will drop it by the mentioned effort.

-- 
With Best Regards,
Andy Shevchenko
