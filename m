Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3EDEB3D2FB
	for <lists+linux-pm@lfdr.de>; Tue, 11 Jun 2019 18:52:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390565AbfFKQwQ (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 11 Jun 2019 12:52:16 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:33402 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389757AbfFKQwQ (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 11 Jun 2019 12:52:16 -0400
Received: by mail-pg1-f195.google.com with SMTP id k187so6790889pga.0;
        Tue, 11 Jun 2019 09:52:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=DQYk/P/AHz+84MHAfqs8A9FFft/ChbHJqGQaIDzi6ok=;
        b=cjJRH/tiJROWu574Li6WdMn+vr3Phrkemo9e0MrIa7BjfXn2y19eO6hPYoPqTcaHm+
         hm86n1rLG16xTwB/lLMEZ2SGn8PMjk7ag060+cgnFYiLM2inu1qWcunQBV1YSvwfqYTT
         DgE717bOFNLWOZArTH/miO/fXl2dyCUiS6unF3rjzsK53ET9uPUrfDplIbVezPaE0owq
         T40LrouoYo1Kjly8EJOlF7nZLhlPBw95nQfBGP3R4rCFndbjLuo5+P13eHpc0hbKjwSf
         j1WcA8dmRUBq2QbCXlBPmirBES11keCDGZCylHH6F7HiSk1MO2DGiSF9oKgwoUiwsuzg
         zNOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=DQYk/P/AHz+84MHAfqs8A9FFft/ChbHJqGQaIDzi6ok=;
        b=iqTkIySDiqNDzZuV4y0c2byf6+eXAFZyRoqPHJsBuJeJGbRza2rJn4B4huz2qp5pwA
         +bo2JJdE3vjoSto16A9rqXwjY/HSFnzT2XXILxOVnqj/kl+6pqxnb+yPJEAvwUcx6rJd
         zViseNHp3adchZGr+f8SFThlUJdHcxvo/ZrOh9I0ohu0XTfaMCS/wIZxjb2vVqwPZhEi
         BflQB7lUN2mklT4M5Q1NfdRy1WiLAEkt2YMqTu0qMfhWqNlk8xSoEzzBbGzUX9etyb1b
         R+ZtVzhsuEBOJ3eieHqWhVihrN0O6sgzrOkoU2/T15KI8GnZTjjS862xhPHk3Z7l9YSi
         F3lg==
X-Gm-Message-State: APjAAAUm9IetSYhgxzvYlf3veKHU1nyoer10JqHG7vOmY/e/hq8mPCjQ
        zWz9IkJeYfrVvqbxx8J93ZOE9disIgwSo2u7dg0=
X-Google-Smtp-Source: APXvYqwIRgwZSvbJvIgasj06odVOLwqV4e1NGaONT67RAQJDqA/rR9sRiGkufN8AoUbyfd4Xe69TJ3rJVeHoEHiPbLI=
X-Received: by 2002:a17:90b:8d2:: with SMTP id ds18mr3765976pjb.132.1560271935519;
 Tue, 11 Jun 2019 09:52:15 -0700 (PDT)
MIME-Version: 1.0
References: <ff457774d46d96e8fe56b45409aba39d87a8672a.1559933665.git.mchehab+samsung@kernel.org>
 <0bea1c7c4fc06c7edabbf3185c0cbbc6e85eafd0.1559933665.git.mchehab+samsung@kernel.org>
In-Reply-To: <0bea1c7c4fc06c7edabbf3185c0cbbc6e85eafd0.1559933665.git.mchehab+samsung@kernel.org>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Tue, 11 Jun 2019 19:52:04 +0300
Message-ID: <CAHp75VfTNJOGZx-PoUXLRvzghqf6bVUdJ+yFjE9hNtDLCQ1=UA@mail.gmail.com>
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

On Fri, Jun 7, 2019 at 10:04 PM Mauro Carvalho Chehab
<mchehab+samsung@kernel.org> wrote:
> Sphinx doesn't like orphan documents:

>     Documentation/laptops/lg-laptop.rst: WARNING: document isn't included in any toctree

>  Documentation/laptops/lg-laptop.rst             | 2 ++

> diff --git a/Documentation/laptops/lg-laptop.rst b/Documentation/laptops/lg-laptop.rst
> index aa503ee9b3bc..f2c2ffe31101 100644
> --- a/Documentation/laptops/lg-laptop.rst
> +++ b/Documentation/laptops/lg-laptop.rst
> @@ -1,5 +1,7 @@
>  .. SPDX-License-Identifier: GPL-2.0+
>
> +:orphan:
> +
>  LG Gram laptop extra features
>  =============================
>

Can we rather create a toc tree there?
It was a first document in reST format in that folder.

-- 
With Best Regards,
Andy Shevchenko
