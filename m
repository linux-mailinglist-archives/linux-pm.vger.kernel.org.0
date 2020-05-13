Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 09B141D117D
	for <lists+linux-pm@lfdr.de>; Wed, 13 May 2020 13:37:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726492AbgEMLhH (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 13 May 2020 07:37:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727794AbgEMLhG (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 13 May 2020 07:37:06 -0400
Received: from mail-io1-xd2f.google.com (mail-io1-xd2f.google.com [IPv6:2607:f8b0:4864:20::d2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2828C061A0C
        for <linux-pm@vger.kernel.org>; Wed, 13 May 2020 04:37:06 -0700 (PDT)
Received: by mail-io1-xd2f.google.com with SMTP id d7so17675679ioq.5
        for <linux-pm@vger.kernel.org>; Wed, 13 May 2020 04:37:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=6iDaIDdenow5UPx14ZGatXd9Q1X2PmhZBTQCbvJhywk=;
        b=TNGcSvFMAsWcarZULbqOk8YOFRjBd+Du/wvBvAAuahSseTYgUajYJaJzLsdehvZGRk
         bl7vZp1IiaSvRVWLwJp4u6ob+z68yMd9Q6CjTTfDlMgYaRLv9AEexfRsK4HfIjErna0g
         Pg5YVkRnT/52+Jq8W2DVdrdYrdgVxPqhfID4+1Op//SaemWmLr9jp6gbFzm/aKTODzoo
         bIG78kmeIijm0daD/90jqMaFy9rkvVfotW4GISeSarw39ogLxQKKkRWCZuR1uFTFhCec
         5qxCBhTMOGy7xIp7cOnBuugwUpEWaeb609hF0p00eWwnkWNGY2rLva6HUxJbOvKjXPkE
         9YSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=6iDaIDdenow5UPx14ZGatXd9Q1X2PmhZBTQCbvJhywk=;
        b=JTwm0WgTUwQJIS+eemCYQGJvQkSSbg3mZHBDJR2CPo2+EwFqgKNK7Htto7AoY3ubsB
         VVmL5VZBR3IB9IkGa5leaC6JuM2ddCdRftMxsHHRONPCY1r+LgvJ7sFZXaOFUUi/dfwX
         wVPhygy7G4sMXJFr2C3f9K9KLZjRGcsSoKVTdewhvw9eIi/qa2hAQuFVrnL/qPiKAqrm
         zC6vRIgb8T/JUsUK+Xz4Tb1jo/rUyJEtaOSPyGyBx5bekFieiRg7VFJRMtJEPInfhoCO
         oSGBhYW31vvQIc2AJyiDyVrmLQmfxR5e5wZz7v44sRl+ZWcWDFZGqzZ/ytJ7vC3KDD9T
         YqGQ==
X-Gm-Message-State: AGi0PuZOS1GKdCkQJPP7Lhh5PgS1YrtoJgEHtyEuijKKj82XIw2hpo4M
        5l44M/iYE5qXagq0Lga6vQWeW1HBl3r2KP0x/ZA=
X-Google-Smtp-Source: APiQypJQKVXzyvsxLYzTP7o6BVgnu5eM5id48zcaKhRNeRQASrVqfUC0IFP91u+SxbBOVrO6fI6EhpO4wxvATTkDrpg=
X-Received: by 2002:a6b:6519:: with SMTP id z25mr13979056iob.124.1589369825734;
 Wed, 13 May 2020 04:37:05 -0700 (PDT)
MIME-Version: 1.0
References: <CAJiuCce9ZxeXnQzEW_3dbBDNZmmtWmKeft0hX+F9+SYu80NU=Q@mail.gmail.com>
 <20200511052530.iazkduojnba3abil@vireshk-i7> <CAJiuCcfRmDbBxEms=HAFQhaiBTznEd1of3TOcnAAc2yuTq0XtA@mail.gmail.com>
 <20200513054601.nvwsjhk6i4bjmgt7@vireshk-i7> <CAJiuCccd+ycnmirL7chtMom0uqbQ8cX9VQf_ZAvhzTto9VSDbA@mail.gmail.com>
 <20200513091922.qnpjx4kw2m3jv2ry@vireshk-i7> <20200513101805.GA4803@sirena.org.uk>
 <20200513104015.oyiaimjpspablq5p@vireshk-i7> <20200513110039.GD4803@sirena.org.uk>
 <20200513110350.uojo5jaufx7rj5v6@vireshk-i7>
In-Reply-To: <20200513110350.uojo5jaufx7rj5v6@vireshk-i7>
From:   =?UTF-8?B?Q2zDqW1lbnQgUMOpcm9u?= <peron.clem@gmail.com>
Date:   Wed, 13 May 2020 13:36:54 +0200
Message-ID: <CAJiuCcdh5101FNMA+LKsvVV++M-iUyWSgqDr5FVQdXcpt6WqyA@mail.gmail.com>
Subject: Re: Question about OPP regulator for Panfrost Devfreq
To:     Viresh Kumar <viresh.kumar@linaro.org>
Cc:     Mark Brown <broonie@kernel.org>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
        Stephen Boyd <sboyd@kernel.org>,
        "open list:ALLWINNER CPUFREQ DRIVER" <linux-pm@vger.kernel.org>,
        Steven Price <steven.price@arm.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Viresh,

On Wed, 13 May 2020 at 13:03, Viresh Kumar <viresh.kumar@linaro.org> wrote:
>
> On 13-05-20, 12:00, Mark Brown wrote:
> > The OPP code can and should be calling regulator_enable().  If the OPP
> > code needs some particular voltage configuration it can and should be
> > calling regulator_set_voltage() to tell the core what it needs.  What
> > I'm saying is that if when the OPP code enables the regulator it needs
> > a particular voltage configuration it should tell the core about that
> > prior to enabling.
>
> I see. Thanks for that.
>
> Clement: I will prepare a patch for you to test then.

Thanks for taking care of that, I'm sure it will works fine for me,
but maybe it should be double tested by Marek Szyprowski on the exynos
bus.

Thanks
Clement

>
> --
> viresh
