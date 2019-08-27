Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5679D9E89E
	for <lists+linux-pm@lfdr.de>; Tue, 27 Aug 2019 15:07:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729412AbfH0NHV (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 27 Aug 2019 09:07:21 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:39348 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729626AbfH0NHV (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 27 Aug 2019 09:07:21 -0400
Received: by mail-lj1-f194.google.com with SMTP id x4so18378512ljj.6
        for <linux-pm@vger.kernel.org>; Tue, 27 Aug 2019 06:07:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=hJI9d9byk+sHyxtv645WYv/HAV4WhPcUJIirxXzW90E=;
        b=Ihg/6EuzPw8O7v7FS6FYk7dbxL4+uqm+nNc7V5c6Ms1/EJfcnFomnnk9XJkOmFOZX5
         1OhA/fQ6mq0bHwPn5JZJULPPV++s7QR0QXvQhVmWIqUGmVmPNr6F4puorwGFYlhbY4nq
         gt3BpAAY2++R8RdbsKDj7+9z+oCF1w2pbubUndJ8l9I7Z7akdkna7sv8Odt/fLFr2mlz
         FgHeB0e71ZZ0gNV3pGIL7q0ixOhSchgQTGptDhNS5cQJcJifAiomfWdaEgIMAC0T0Wah
         ktP0AtL/B8qW/tLixtwGBkRt6z5crGwMNrywPhpPB/nzdoNbOmEgFx1GqaK1vA1gQzoW
         D3QA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=hJI9d9byk+sHyxtv645WYv/HAV4WhPcUJIirxXzW90E=;
        b=svaEVPbUXaD/idgDkSm19xdOlvcJL8C1F2t35NDXv1UQitZqBsNMGyg69caxW2BpV5
         wrHECT3uwqmGaL8p1csqnpGGpIvoVsofMNO6jBmXEt0Gb12I68FKOx2eenHusErNvcQd
         Wp4wfFMch/6haRpqI+o3uWnF76QJEvKzkiGpJA8FiUBYU/NZZp66vyvmRofP5MAZPVWk
         4S0YQd1sZjhkiXIHVzAmGh60WdtthRWODQvLvKANjJexDVg4y0X28jYn5DOYbKRaHjj3
         FgTKsydInKI4uOo+g04G3nQVzabc76fHAwenLI1Q1D21ThNujFnIIxXqnGNHgQ3YQ/Cv
         hL7g==
X-Gm-Message-State: APjAAAUtt6t37zbqNv4ttcEziadlJK1iZReyAlhNKYcauaYP81OG8yRg
        QHGWJO17Qhc9ykugy0NXlTBmmWCfpcasBpmVyIaoZw==
X-Google-Smtp-Source: APXvYqwQH0/bYm1NasVXtfwUrO5FPLrBnZG1t5JUQC2JxUHRHa8p0GiT6g0iVuvJD5Uae4Wk6bcp+OJ+uxVPjWXFanY=
X-Received: by 2002:a2e:80da:: with SMTP id r26mr13084343ljg.62.1566911239226;
 Tue, 27 Aug 2019 06:07:19 -0700 (PDT)
MIME-Version: 1.0
References: <20190717063222.5902-1-linus.walleij@linaro.org> <47cb523f-60ad-750e-4374-6563f8230593@linaro.org>
In-Reply-To: <47cb523f-60ad-750e-4374-6563f8230593@linaro.org>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Tue, 27 Aug 2019 15:07:06 +0200
Message-ID: <CACRpkdYO7zzrUg=7=4D7XMUwoa6XQggm0jB1PtPhKK=3EV9AyQ@mail.gmail.com>
Subject: Re: [PATCH 1/2] thermal: db8500: Finalize device tree conversion
To:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        Vincent Guittot <vincent.guittot@linaro.org>
Cc:     Zhang Rui <rui.zhang@intel.com>,
        Eduardo Valentin <edubezval@gmail.com>,
        Linux PM list <linux-pm@vger.kernel.org>,
        Lee Jones <lee.jones@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Thu, Aug 22, 2019 at 8:16 AM Daniel Lezcano
<daniel.lezcano@linaro.org> wrote:

> Another point is there are too many trip points, two should be enough,
> one for throttling and one for critical, the governor will handle that
> properly by stepping the opps.

I looked a bit into this, and it seems that there are a number of
trip points simply for inspecting the system (Vincent may know better
because he worked directly with this): the thermal sensor can only
set an IRQ for a certain temperature, there is no interface to just
read the temperature. By setting a number of trip points and
first let the IRQ fire at the lowest you see how the system moves
up in the temperature points and that makes it easier to inspect,
so this sensor will set 70 degress, wait until the IRQ fires,
then set 75 degrees, wait until IRQ fires, set 80 degrees...
etc. It does the same with the IRQ for falling temperature so it
moves up and down this scale, and interpolates the temperature
between the trip points.

It is a bit crude but it gives some kind of granularity and control
over the reported temperature from the sensor.

I think this is something that should be done inside the
driver, not by abusing the trip points, so I try to rewrite the logic
so that the driver fires these IRQs internally without using any
trip points from the thermal subsystem.

Yours,
Linus Walleij
