Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A1F833D362
	for <lists+linux-pm@lfdr.de>; Tue, 11 Jun 2019 19:05:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404929AbfFKRFR (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 11 Jun 2019 13:05:17 -0400
Received: from casper.infradead.org ([85.118.1.10]:41716 "EHLO
        casper.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404647AbfFKRFR (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 11 Jun 2019 13:05:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:Content-Type:
        MIME-Version:References:In-Reply-To:Message-ID:Subject:Cc:To:From:Date:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=7Yq617plFowJ6SPqfSlFnXKBCkZMDSV9shNeKC4mMEY=; b=K0CsPURbcVID3VZgvAW0iTm3wR
        a4w5JgdjFouiUq0BWdslkyoBdxaVdGLJePyibi1Mog+r1AuYwR/+jqWtSVGIrgf6yzUg0z1U28CyG
        ZhJdIclAT572+X/UXggsJ8f8SVJMT/MisC//pgJXvXzFsvm9J+X3u1iSiUKWNx87KYuHGB3heK7cb
        r1U6atgMP9cSs7F68WdhTtVFB7a/r7PPkSHtsAXTs+U5GV1KWlGhJYzDFXrGHhlV1xt/wYfmrvWud
        Gs8cNb0zXmzCs1nXi+2dGANfmt3c8nyUKVKzyntwvyexURPTWIVP8gQmd/HhZ+q8RGBPy2CreqY6B
        yzJmGK5g==;
Received: from 177.41.119.178.dynamic.adsl.gvt.net.br ([177.41.119.178] helo=coco.lan)
        by casper.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1hakCs-0002PQ-Bo; Tue, 11 Jun 2019 17:05:10 +0000
Date:   Tue, 11 Jun 2019 14:05:01 -0300
From:   Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
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
Subject: Re: [PATCH v3 06/20] docs: mark orphan documents as such
Message-ID: <20190611140501.11ba091b@coco.lan>
In-Reply-To: <CAHp75VfTNJOGZx-PoUXLRvzghqf6bVUdJ+yFjE9hNtDLCQ1=UA@mail.gmail.com>
References: <ff457774d46d96e8fe56b45409aba39d87a8672a.1559933665.git.mchehab+samsung@kernel.org>
        <0bea1c7c4fc06c7edabbf3185c0cbbc6e85eafd0.1559933665.git.mchehab+samsung@kernel.org>
        <CAHp75VfTNJOGZx-PoUXLRvzghqf6bVUdJ+yFjE9hNtDLCQ1=UA@mail.gmail.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Em Tue, 11 Jun 2019 19:52:04 +0300
Andy Shevchenko <andy.shevchenko@gmail.com> escreveu:

> On Fri, Jun 7, 2019 at 10:04 PM Mauro Carvalho Chehab
> <mchehab+samsung@kernel.org> wrote:
> > Sphinx doesn't like orphan documents:  
> 
> >     Documentation/laptops/lg-laptop.rst: WARNING: document isn't included in any toctree  
> 
> >  Documentation/laptops/lg-laptop.rst             | 2 ++  
> 
> > diff --git a/Documentation/laptops/lg-laptop.rst b/Documentation/laptops/lg-laptop.rst
> > index aa503ee9b3bc..f2c2ffe31101 100644
> > --- a/Documentation/laptops/lg-laptop.rst
> > +++ b/Documentation/laptops/lg-laptop.rst
> > @@ -1,5 +1,7 @@
> >  .. SPDX-License-Identifier: GPL-2.0+
> >
> > +:orphan:
> > +
> >  LG Gram laptop extra features
> >  =============================
> >  
> 
> Can we rather create a toc tree there?
> It was a first document in reST format in that folder.

Sure, but:

1) I have a patch converting the other files on this dir to rst:

	https://git.linuxtv.org/mchehab/experimental.git/commit/?h=convert_rst_renames_v4.1&id=abc13233035fdfdbc5ef2f2fbd3d127a1ab15530

2) It probably makes sense to move the entire dir to
Documentation/admin-guide.

So, I would prefer to have the :orphan: here while (1) is not merged.

Thanks,
Mauro
