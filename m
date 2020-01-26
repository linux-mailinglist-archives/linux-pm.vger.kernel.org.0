Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3CF88149AA5
	for <lists+linux-pm@lfdr.de>; Sun, 26 Jan 2020 14:01:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728843AbgAZNBN (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 26 Jan 2020 08:01:13 -0500
Received: from mail-io1-f65.google.com ([209.85.166.65]:46089 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728689AbgAZNBN (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 26 Jan 2020 08:01:13 -0500
Received: by mail-io1-f65.google.com with SMTP id t26so6963328ioi.13;
        Sun, 26 Jan 2020 05:01:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=Fe5qGJHJCsCWl/2D934wNBGowgZdtUVYwms1aiiozFs=;
        b=ZH5ARQbuwphpaNvpY1SuKWAtvlC8o3UbaoAE44Le2OJ81OSV/Qq26Di8bqzNIwBBxE
         Git7+VXnwWAkscpL67zZoKZPaasamLylqFNoDq3FDqNLnA5q/Towoczso2enBoycHCrX
         QmOiKUpFOT6dIugN0CH+rfAbO9OCQRUcXLBo7w2nhcSLJEXCtTHIWVfIE4sKGRZPhw7w
         VrkezRzvs2aErk7YilVcRp0mIF94Yws/arNip8htJPJfsdvpe0HoJ1serYvk71brxhIA
         oWoys2RxWf0LSLUW4kZyqZutzLk5c5rQOfnxBcqyD9eD/DawnnJAD9q3kLPmQdRHo92Q
         EaaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=Fe5qGJHJCsCWl/2D934wNBGowgZdtUVYwms1aiiozFs=;
        b=ZhFd/CB9WWKWbyscZHAlRbLlq6HNw7rlg2CZTbdHcDjwWyFIY1d++M5qWpjcgdDr0E
         9/AYabDS9tbeejblW2fdJRW95b1m45T1odIJUvE86raOnvSm2hon0ginVCRraAAiaSPV
         tQHzhIvpMbgs9uU2+KQpGT54ujaeDrkFOp8zh9L6M/+wyhxeOSHjrxEjvU0ZfLHaFIO/
         RvNAfOyJ6fY/mTF3eLs9inHIsQHiQeaeAs6ZdjX1pH+xqmfiJy6XL38SVn9iQeCU+glC
         OYnvM2/LUzBvkv7t67uEaGjeHFbUTu2oyIsm7kW0riOTAgUA9rgwH0CMsNlOOYfknbJA
         ZzkA==
X-Gm-Message-State: APjAAAWE8J5VTbZcwALhfEzC0nzLO7Xfw7p9QccwhK16DrrPfHhEIxXT
        lYX3nvxm+dLIM/zIskHkTvQz3sO75hIHZuzsO24=
X-Google-Smtp-Source: APXvYqyV82IjtOYASKBL3wF70Jmh/kknf2/qksjOk8uUTMPBEV9amI0E9t9oY9cHqJaM3MXS2O302LhyM7Mfn/lXjFc=
X-Received: by 2002:a05:6638:538:: with SMTP id j24mr9294229jar.12.1580043672461;
 Sun, 26 Jan 2020 05:01:12 -0800 (PST)
MIME-Version: 1.0
References: <20200106174639.20862-1-tiny.windzz@gmail.com> <20200106174639.20862-2-tiny.windzz@gmail.com>
 <20200107075816.ly6exfd4qtvfxxua@gilmour.lan> <662e157a-603f-7423-0491-f26f0fc8d7b6@linaro.org>
 <20200109131343.mjyuj5ed2xwvmwd4@gilmour.lan> <af4bca3b-ba95-aa10-5601-753f1c5275b3@linaro.org>
In-Reply-To: <af4bca3b-ba95-aa10-5601-753f1c5275b3@linaro.org>
From:   Frank Lee <tiny.windzz@gmail.com>
Date:   Sun, 26 Jan 2020 21:01:01 +0800
Message-ID: <CAEExFWtmUtzBje-DKt71W46rs3PTF_Di_x3YQCz+tg8+W1kyAA@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] ARM: dts: sun8i-r40: Add thermal sensor and
 thermal zones
To:     Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     Maxime Ripard <mripard@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Chen-Yu Tsai <wens@csie.org>,
        Vasily Khoruzhick <anarsoul@gmail.com>,
        Zhang Rui <rui.zhang@intel.com>,
        Amit Kucheria <amit.kucheria@verdurent.com>,
        =?UTF-8?Q?Ond=C5=99ej_Jirman?= <megous@megous.com>,
        devicetree <devicetree@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

HI Chen-Yu and Maxime,

Can you pick this up again?

Yangtao

On Fri, Jan 10, 2020 at 4:08 AM Daniel Lezcano
<daniel.lezcano@linaro.org> wrote:
>
> On 09/01/2020 14:13, Maxime Ripard wrote:
> > Hi Daniel,
> >
> > On Thu, Jan 09, 2020 at 12:51:27PM +0100, Daniel Lezcano wrote:
> >> On 07/01/2020 08:58, Maxime Ripard wrote:
> >>> On Mon, Jan 06, 2020 at 05:46:39PM +0000, Yangtao Li wrote:
> >>>> There are two sensors, sensor0 for CPU, sensor1 for GPU.
> >>>>
> >>>> Signed-off-by: Yangtao Li <tiny.windzz@gmail.com>
> >>>> Tested-by: Corentin Labbe <clabbe.montjoie@gmail.com>
> >>>> Tested-on: sun8i-r40-bananapi-m2-ultra
> >>>
> >>> As far as I know, tested-on is not documented anywhere (and isn't
> >>> really used either). I've removed it and applied, thanks!
> >>
> >> I think this patch should go through my tree as it refers to a commit =
in
> >> my branch.
> >
> > I'm not quite sure to get why. Even though that patch depends on the
> > one affecting the driver to be functional, it doesn't break anything
> > when merged through arm-soc, and similarly yours doesn't affect any
> > other tree if it's merged through your tree, so there's no dependency?
>
> Sorry, I puzzled myself, I thought you meant you applied patch 1/2
>
>
> --
>  <http://www.linaro.org/> Linaro.org =E2=94=82 Open source software for A=
RM SoCs
>
> Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
> <http://twitter.com/#!/linaroorg> Twitter |
> <http://www.linaro.org/linaro-blog/> Blog
>
