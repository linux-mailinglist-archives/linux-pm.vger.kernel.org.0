Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 351749E6A9
	for <lists+linux-pm@lfdr.de>; Tue, 27 Aug 2019 13:21:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726435AbfH0LVt (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 27 Aug 2019 07:21:49 -0400
Received: from mail-lf1-f67.google.com ([209.85.167.67]:37132 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726333AbfH0LVt (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 27 Aug 2019 07:21:49 -0400
Received: by mail-lf1-f67.google.com with SMTP id w67so6696101lff.4
        for <linux-pm@vger.kernel.org>; Tue, 27 Aug 2019 04:21:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=D+MUi7W3UwD/DF/e2Cr5moLgnRLJItQ6PUbyO9QGLoU=;
        b=tBVGkSsi7ARebfmEi/Fcfxe4vA+8X7qeq+l8ccBb7VHmpLE0qjNReurymd8ldJRUwS
         0ujB5OVjSopZDzOEHykJ27r5MGyiK9sqgl1TMXkoC+r2gba9SPUSSGdyNZF8y7/VKYms
         mK8xwTbcQ0Hk2bdOVbpRV64LMZquLzSlMeNtAW/kxb68/ZtrulReE6Va+x1aguaU/NO2
         gTT8jXFOazSFmdskSVV8WToQC/33WI7s/rIsUAEj+9TOYv174P1p7pJxh6hOjfAoWyxw
         fG1zam5afD9O8mkHZQwYhpZQwkLer10K5k7WhIje0N4yXjpGsabXUfLFh+mIDlvyu24U
         WO2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=D+MUi7W3UwD/DF/e2Cr5moLgnRLJItQ6PUbyO9QGLoU=;
        b=SkxBjoqPtV4w952Ks52AgT9Rw7WqACqxFSl+u10m2D4YpJO2nL7kAhCeTtYiaf1V6f
         iJ+HXGychTKisXvl3lFccv/MCiOvtcloTwoHLwaFErwKWjlr+L5UdYzP9p/5WGnfSpJO
         dmxYm3VkNRzaaw49MXIbYgilw4ihZ4vUUk5cQ2OdR7b/jMyPaYw5BYjIbJBMgXBBbSne
         RdsRkkOr2Xuujjn+si+FMlEFQdkQRG/zCvmcDRKobhrQu86hcqrrgGUBLWF43vM96UGu
         RBtBflExNURt4tqSN8ttugh/n8OL6DqRtcDDxe/0ZaKEAdfwUdmThgo8yDrqpYKFbnNn
         UN+Q==
X-Gm-Message-State: APjAAAX5t4T/+StkO8eC7ppUmsulSpGPYikW8tlDKgDDDbW9DIRG5Yjp
        M7W74LuzJMSDOETv7G0tTiS8lmiIyXb/eKQLhvNIWQ==
X-Google-Smtp-Source: APXvYqxReb1BWUue6JmUVfyEy65BlZkMiFr7+j19KiGElE8x6eO0c6VeyhPd2oh3rqdfDoM6IwBFGwV6O5bAoqwWPeo=
X-Received: by 2002:a19:14f:: with SMTP id 76mr1708716lfb.92.1566904906939;
 Tue, 27 Aug 2019 04:21:46 -0700 (PDT)
MIME-Version: 1.0
References: <20190717063222.5902-1-linus.walleij@linaro.org> <47cb523f-60ad-750e-4374-6563f8230593@linaro.org>
In-Reply-To: <47cb523f-60ad-750e-4374-6563f8230593@linaro.org>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Tue, 27 Aug 2019 13:21:35 +0200
Message-ID: <CACRpkdYqjW_SHHLaSqgWO64CsGeyoOVGsOhnav0mwVA5W2fbuw@mail.gmail.com>
Subject: Re: [PATCH 1/2] thermal: db8500: Finalize device tree conversion
To:     Daniel Lezcano <daniel.lezcano@linaro.org>
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

> I've been through the DT and I don't understand why there is:
>
>         [ ... ]
>         trip0-temp = <70000>;
>         trip0-type = "active";
>         trip0-cdev-num = <1>;
>         trip0-cdev-name0 = "thermal-cpufreq-0";
>         [ ... ]
>
> Those bindings already exists for the thermal no?
>
> Why not create a thermal-zone node and then add the values above?

I guess you refer to arch/arm/boot/dts/ste-snowball.dts
where this is in the thermal@801573c0 node.
(I moved it to the main SoC file for the next kernel.)

I think the reason is that this was merged in:
commit dc1956b5f84de7d453ec4d9fe68385fffd689686
"Thermal: Add ST-Ericsson DB8500 thermal properties and platform data."
Date:   Thu Nov 15 18:56:43 2012 +0800

Thermal zones were not added until:
commit 4e5e4705bf69ea450f58fc709ac5888f321a9299
"thermal: introduce device tree parser"
Date:   Wed Jul 3 15:35:39 2013 -0400

Which is half a year after this device tree was written.

Apparently Hongbo stopped working on this driver before
that and didn't convert the driver or consumers over to the
new thermal zone APIs with trip points and cooling maps
defined in the device tree (which by the way is an awesome
feature).

> Another point is there are too many trip points, two should be enough,
> one for throttling and one for critical, the governor will handle that
> properly by stepping the opps.
>
> And one last point is the trip point should be passive, not active.

OK I get it, can we merge these two patches that just move
the code to the thermal driver and then I can make
a new patch or some new patches on top to migrate to
Eduardo's new framework for device tree defined thermal
zones?

Yours,
Linus Walleij
