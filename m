Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E6F1828F3E
	for <lists+linux-pm@lfdr.de>; Fri, 24 May 2019 04:49:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731697AbfEXCtI (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 23 May 2019 22:49:08 -0400
Received: from mail-it1-f193.google.com ([209.85.166.193]:38817 "EHLO
        mail-it1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731522AbfEXCtI (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 23 May 2019 22:49:08 -0400
Received: by mail-it1-f193.google.com with SMTP id i63so11620169ita.3;
        Thu, 23 May 2019 19:49:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=vAHtKv7wiLYKCEkr3cbu7GfPBp0LIuyfDvpGOBSxNWk=;
        b=sur0YmTeovQti6f+AxK9Ntb6kmiFaT9IX63hBoQV00faFSDOuK1HOuBze6dvotY5JS
         Z5cAOtAwaP+kS3d+s9fovemAxpiHNkCFatZeuDR2M9TiJ7twl2h4RUh68UQVv5fq7GmK
         oUkkolyLu4jYtDUfmD4w/+nP9Cpql2HU8gbzb3q/STkzEP3rza9UKmBCq7pBeiR2pe46
         0JX57ix+ZO1BS5Z8iofremcSZdCi2FR+ZKva2cVtOkhMa6Nn0yHjOh4z9cutw8jDto3n
         IutztA+08cWmqH8IYR5pAs3Tui+DtuAiBX8dBC+nk4XiW4pBJkzhp5GHL48YLsTY3Opa
         IF4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=vAHtKv7wiLYKCEkr3cbu7GfPBp0LIuyfDvpGOBSxNWk=;
        b=XPBkg0gHlYthpD37sH0ni06HJAHxxoOdHK8IXl5SAU95MKF3LDE+fIbe0es5RDftea
         9bEorU0WjM4R5Zc9DxbEHF2v4RGMqZ7z1SryQCKeCngAiE/tDDu6RxNQpXKDlCwrP/Ti
         FvVfOw1R66PTTI/tmAxEokWzXJDzix9FRBIggY+/3xI+ajluYu1277lH8pAOwey9/lX1
         9RljOED6+kPl4DL88TsKkbaONClcVcrr3ztZjbYXHM3iuANUCG+UlM0jKM5xEAK2WR2H
         MJuQ8jrrxskz2MpJM6QZ3CcEsUfSf+yrZ0YGHJQ4+IYtZY5y82O1TK3lEnSw7r0by7VI
         JOzQ==
X-Gm-Message-State: APjAAAUALf9gcVvApmZP7g2zQGJmEy46B9J70fQIpPJdmd+9PJdtsEdL
        ieqrDA7+jQM2bEGIm1ZOYPtHTZaF9s19jFTb4AY=
X-Google-Smtp-Source: APXvYqx0HyrzaAc4jLzzo4MliTjY34qzuDLvuzTKQZWMixPfQwzNTb7VSP+LW6cZPKIKTELVhoNREL3bLNT3jBVDdHU=
X-Received: by 2002:a05:6638:233:: with SMTP id f19mr4106816jaq.24.1558666147485;
 Thu, 23 May 2019 19:49:07 -0700 (PDT)
MIME-Version: 1.0
References: <20190416172203.4679-1-daniel.lezcano@linaro.org>
 <20190423154430.GA16014@localhost.localdomain> <bc10d520-4d15-74d6-0dc2-fd63df8d9a21@linaro.org>
 <ff407865-8606-60c2-62d8-60ae96d1984d@linaro.org>
In-Reply-To: <ff407865-8606-60c2-62d8-60ae96d1984d@linaro.org>
From:   Andrey Smirnov <andrew.smirnov@gmail.com>
Date:   Thu, 23 May 2019 19:48:56 -0700
Message-ID: <CAHQ1cqG-cb=1hyO8oeV4k-6Pq4q+aqhH8RPx04i2oPTNhAhiVg@mail.gmail.com>
Subject: Re: [PATCH] thermal/drivers/of: Add a get_temp_id callback function
To:     Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     Eduardo Valentin <edubezval@gmail.com>,
        Zhang Rui <rui.zhang@intel.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Linux PM list <linux-pm@vger.kernel.org>,
        Chris Healy <cphealy@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Mon, Apr 29, 2019 at 9:51 AM Daniel Lezcano
<daniel.lezcano@linaro.org> wrote:
>
> On 24/04/2019 01:08, Daniel Lezcano wrote:
> > On 23/04/2019 17:44, Eduardo Valentin wrote:
> >> Hello,
> >>
> >> On Tue, Apr 16, 2019 at 07:22:03PM +0200, Daniel Lezcano wrote:
> >>> Currently when we register a sensor, we specify the sensor id and a data
> >>> pointer to be passed when the get_temp function is called. However the
> >>> sensor_id is not passed to the get_temp callback forcing the driver to
> >>> do extra allocation and adding back pointer to find out from the sensor
> >>> information the driver data and then back to the sensor id.
> >>>
> >>> Add a new callback get_temp_id() which will be called if set. It will
> >>> call the get_temp_id() with the sensor id.
> >>>
> >>> That will be more consistent with the registering function.
> >>
> >> I still do not understand why we need to have a get_id callback.
> >> The use cases I have seen so far, which I have been intentionally rejecting, are
> >> mainly solvable by creating other compatible entries. And really, if you
> >> have, say a bandgap, chip that supports multiple sensors, but on
> >> SoC version A it has 5 sensors, and on SoC version B it has only 4,
> >> or on SoC version C, it has 5 but they are either logially located
> >> in different places (gpu vs iva regions), these are all cases in which
> >> you want a different compatible!
> >>
> >> Do you mind sharing why you need a get sensor id callback?
> >
> > It is not a get sensor id callback, it is a get_temp callback which pass
> > the sensor id.
> >
> > See in the different drivers, it is a common pattern there is a
> > structure for the driver, then a structure for the sensor. When the
> > get_temp is called, the callback needs info from the sensor structure
> > and from the driver structure, so a back pointer to the driver structure
> > is added in the sensor structure.
>
> Hi Eduardo,
>
> does the explanation clarifies the purpose of this change?
>

Eduardo, did you ever have a chance to revisit this thread? I would
really like to make some progress on this one to unblock my i.MX8MQ
hwmon series.

Thanks,
Andrey Smirnov
