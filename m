Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6EBE778BAB
	for <lists+linux-pm@lfdr.de>; Mon, 29 Jul 2019 14:21:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726267AbfG2MVN (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 29 Jul 2019 08:21:13 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:39353 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725956AbfG2MVM (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 29 Jul 2019 08:21:12 -0400
Received: by mail-lj1-f194.google.com with SMTP id v18so58336375ljh.6;
        Mon, 29 Jul 2019 05:21:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Lus5TxJaffuFpsnjVsSfL9Xup/2Q5tADoKnscqx0e0o=;
        b=InwwDQ224lgQiDVL9i6pVtS0Vvh/lrCRZAxHHs4uW1jMEQPzbbUSxpf4sKK/Q3pwIl
         ZdTz2bXA7p1Cdp5KBxKh3ZZxvyU+r3a6IPnDAaLC1vMZ2LgYDpx3ybkwByC86vuTMmTz
         3rAuPRhyobMGW1t8u/jALQxJRjDYuL1EVqIdME9w0sIrUSuAKhm5KzRM/scP+HLr9lMy
         En33fmBmbL8yfRBJ15NY4JFAwox6OLvV/nhvbKL0YYnVyOvfOtcuFtW8cft3f5iLfRF7
         HI5LsUGxSdhYCDDCOdSi/p6WntIlRfnF+CsTLP05zNREVNWGEBzHJxKIZlHCS38Ke5f/
         1LQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Lus5TxJaffuFpsnjVsSfL9Xup/2Q5tADoKnscqx0e0o=;
        b=St3YIIhTddGRxK2ntSzVI3rRabNipzaIVRRq35hT0ik16PV6DybuQ6J88aDpDGDpsC
         F+9rwK7JilCck8FF8A/DyWAW6WTCASM9tWnGHkmUBpuTK5OYQrbMRE15dlP8EBolUao4
         ypKqhsEZy0iMB6vjUIF2+ysdrSKrukbmwZqllDy3k3rP1VwZODLtcstux6HAOo5srPYw
         3QhLyw//yBK4flyMtVe4jaaeI85wt5k0NPfd2zCMaZMDZqJbwJZjyOwT29LhnOY0nM8r
         BPMoKa+05ziVaLzSIqjfFPmZaQjl/0TMWpafPA7CsbKU54Ic6PIcCaJU/EGYQadxFbXG
         XO2g==
X-Gm-Message-State: APjAAAWL+NTtwSx20QI0m7kEIOKwg4vLxFc4fPVDenRWP3IMQw2Oxdcb
        MHOCqbSF/0llxqMyWIpHzw7B8Gs2umJckRXLUpM=
X-Google-Smtp-Source: APXvYqxkW5SmThMalAQq31UlmmO81GX4lGXENqxdVeAnVIsK+llwHK4DqHkMcrejGumyqG/qS1DuqMlt/5yp0CWS+HM=
X-Received: by 2002:a2e:a311:: with SMTP id l17mr55967735lje.214.1564402870592;
 Mon, 29 Jul 2019 05:21:10 -0700 (PDT)
MIME-Version: 1.0
References: <20190729083915.4855-1-Anson.Huang@nxp.com> <20190729083915.4855-3-Anson.Huang@nxp.com>
In-Reply-To: <20190729083915.4855-3-Anson.Huang@nxp.com>
From:   Fabio Estevam <festevam@gmail.com>
Date:   Mon, 29 Jul 2019 09:21:15 -0300
Message-ID: <CAOMZO5Ao8aNGfj3KHd+rsX=kj528BvzeSHFvQR6pEWXN3BD98g@mail.gmail.com>
Subject: Re: [PATCH V2 3/4] dt-bindings: thermal: qoriq: Add optional clocks property
To:     Yongcai Huang <Anson.Huang@nxp.com>
Cc:     "rui.zhang" <rui.zhang@intel.com>,
        Eduardo Valentin <edubezval@gmail.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, linux-pm@vger.kernel.org,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        NXP Linux Team <Linux-imx@nxp.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Anson,

On Mon, Jul 29, 2019 at 6:04 AM <Anson.Huang@nxp.com> wrote:
>
> From: Anson Huang <Anson.Huang@nxp.com>
>
> Some platforms have clock control for TMU, add optional
> clocks property to the binding doc.

Please add a note that this is needed for i.MX8M.
