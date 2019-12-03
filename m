Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E5AE91102EF
	for <lists+linux-pm@lfdr.de>; Tue,  3 Dec 2019 17:54:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726930AbfLCQyK (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 3 Dec 2019 11:54:10 -0500
Received: from mail-vk1-f196.google.com ([209.85.221.196]:36586 "EHLO
        mail-vk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726422AbfLCQyK (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 3 Dec 2019 11:54:10 -0500
Received: by mail-vk1-f196.google.com with SMTP id i4so1269048vkc.3
        for <linux-pm@vger.kernel.org>; Tue, 03 Dec 2019 08:54:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=verdurent-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=AcM7UEIp8ymleTTTyVFIALYBt+4goDjQpS4y6N2B+wI=;
        b=uoPG9cTRt/hqq0DuB5ne0h2K4POk21yL2O8Fa6xz0FrVObCVI0zSRWTUcGvf4krFI/
         asiNumPnrPNLb7J4jVBdwacvkkz384DBFcnw7JLMkl7zvQNAImvxP21kiwvtk4e2XxeN
         9kI7AnlY7SAN8D7iwzo6JmHQGvQHxHq7oeT/P1vwBRWUmuNX/MSDJAk8mJKiOA9QTqhS
         JqeP6vA6UUUt7PMLJCfMTubv/VQLY3QEn8i/RNiwvMVecT/NMo1BCqWJVavnYqYI6Ogv
         4pYiZcgGDJzgVPPp7Mfu4D8R5AFJNSw18GYlBT8lM77MTOqjwLCKpCZ6pJAKjrwCOpq7
         JC7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=AcM7UEIp8ymleTTTyVFIALYBt+4goDjQpS4y6N2B+wI=;
        b=QIzuMwOGBPeEo7E1qs3QHIZWtIDrqtB+M8/je3N56RZs3NFH+lmKvp+QWHUFaQ5H8K
         OyF27J99Md6xn1mmk39peetcw3GHK+QQO6HklLwFO7FuWSpov16OWMWaPWFghY268shM
         sauAC+s6o7xQLWw+auREeN+jUwNHpqV5fZqOMcEN/HH8euMMC+3RWTD41T+TyiMhzo6Y
         5ZP0jRBrD8HmeiB6cOg3OkMLs/mhvk69pobLzpwIJR8TOUp1qFgsr11HzFeVIiD84gXC
         Yx4/verQG4UyyRqNHDTC2/GOlNGpqUedP7qEfZMt4DoJvQWQ4YOxLqBSephJv4iGOy9g
         cvIA==
X-Gm-Message-State: APjAAAVbPVVt/6wnX20hY+zb0abTWIuySixv64J3jgAFsOXklpoQuk8n
        pZYj73x+ugi9tZk9JaQmtT+lDCiGUPAdGMB563T1mQ==
X-Google-Smtp-Source: APXvYqwWfxtECH6IzRO2KWDRHz/G7gB6OReuBEbvIF27Ze3wf/2BXsYSC4Slvqkh+Z8aSkU/Vruvxo83JKiIBbSncWs=
X-Received: by 2002:a1f:bdd0:: with SMTP id n199mr4259634vkf.86.1575392048634;
 Tue, 03 Dec 2019 08:54:08 -0800 (PST)
MIME-Version: 1.0
References: <1568859503-19725-1-git-send-email-thara.gopinath@linaro.org> <1568859503-19725-2-git-send-email-thara.gopinath@linaro.org>
In-Reply-To: <1568859503-19725-2-git-send-email-thara.gopinath@linaro.org>
From:   Amit Kucheria <amit.kucheria@verdurent.com>
Date:   Tue, 3 Dec 2019 22:23:57 +0530
Message-ID: <CAHLCerMif4ZyUwO-r04Ds3AZuRQNtw5bfFjWa9nOhTovMxVYOA@mail.gmail.com>
Subject: Re: [PATCH 1/4] dt-bindings: thermal: Introduce monitor-falling
 parameter to thermal trip point binding
To:     Thara Gopinath <thara.gopinath@linaro.org>
Cc:     Zhang Rui <rui.zhang@intel.com>,
        Eduardo Valentin <edubezval@gmail.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Linux PM list <linux-pm@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Thu, Sep 19, 2019 at 7:48 AM Thara Gopinath
<thara.gopinath@linaro.org> wrote:
>
> Introduce a new binding parameter to thermal trip point description
> to indicate whether the temperature level specified by the trip point
> is monitored for a rise or fall in temperature.
>
> Signed-off-by: Thara Gopinath <thara.gopinath@linaro.org>
> ---
>  Documentation/devicetree/bindings/thermal/thermal.txt | 8 ++++++++
>  1 file changed, 8 insertions(+)
>
> diff --git a/Documentation/devicetree/bindings/thermal/thermal.txt b/Documentation/devicetree/bindings/thermal/thermal.txt
> index ca14ba9..849a2a9 100644
> --- a/Documentation/devicetree/bindings/thermal/thermal.txt
> +++ b/Documentation/devicetree/bindings/thermal/thermal.txt
> @@ -90,6 +90,14 @@ Required properties:
>         "critical":     Hardware not reliable.
>    Type: string
>
> +Optional property:
> +- monitor-falling:     Indicate whether the system action is kick

Stray space after :

> +  Type: boolean                started when the temperature falls below or rises

Unnecessary tab after boolean (I'll fix up the rest of the file in the
yaml conversion)

I suggest not making this boolean. Just use the property as a flag by
itself to denote a falling trip point. No need to deal with true/false
values.

Similarly, the sysfs file would show up only in case of a trip that
sets this flag and just contain a 1, for example.

> +                       above the trip temperature level indicated in
> +                       "temperature".If true, the trip point is monitored

Add space after full stop.


> +                       for falling temperature else the trip point is
> +                       monitored for rising temperature.
> +
>  * Cooling device maps
>
>  The cooling device maps node is a node to describe how cooling devices
> --
> 2.1.4
>
