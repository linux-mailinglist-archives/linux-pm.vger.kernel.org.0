Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D9BBB4AA99
	for <lists+linux-pm@lfdr.de>; Tue, 18 Jun 2019 21:04:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730197AbfFRTEc (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 18 Jun 2019 15:04:32 -0400
Received: from mail-io1-f66.google.com ([209.85.166.66]:38317 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727386AbfFRTEc (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 18 Jun 2019 15:04:32 -0400
Received: by mail-io1-f66.google.com with SMTP id j6so2729030ioa.5;
        Tue, 18 Jun 2019 12:04:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=a/uPUQoJ6eu9AxAlNMMd5WX6nBQBlPI8ohAXNes42aw=;
        b=bXsdOgNNhHUU2Rh39DVh//DYSa8wLO17UKjyb5/VQukQMLaldrf+4dIX59LX69TnYN
         K3WlokHw19Le+wRnE5hPEsWSMb2KbaNDx5aQ+C7b7g5d9yDelAgekAyu8ertsRj+QOT3
         guCRjWqHYE+PLmbZPW3w3AonMOFEZxCC6+RetJ7CfwQSLIkUVWb/FJnImmatNF3vq349
         fbNv1IfWTHrF6RCtOhKB+5LKmi1QtyGn5XN1Ti6YIvMVc6IkJkfULVAYcZ5EvLqVk6na
         ndPSUblNdlZ3TZRg7jeFrHSRj7Rcwi2SpNUAZ8Ww8069HASVMOREAOYZwsIDziRy2bDW
         HlYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=a/uPUQoJ6eu9AxAlNMMd5WX6nBQBlPI8ohAXNes42aw=;
        b=jvxRX+X+k8e6a65z9H7mt4QViYsYF2liUfw4wt10HPDuv/WIviBXXiw3fcSzbX2Zqi
         q/vY4PGXG8O12GmfFZ3sPQ8EmaRpES5uudMqOINNON6dFtW6SC61y2y1RTRmlMlv3bOQ
         4uB2B1RPWE6SVMbwRuE8PYodwiZrIPJNrGo18ejR0L7secsgu21qllWcCyU9FS2S5iGj
         AXCutofHQz/MoBkptmvpJcRyj5EyKIkIXNLcWkeQ9TtQUEo4zaCp5MSZWxBgRRl+4KUT
         J/XjfSHHbkXIzJ0k7saFQ3KtdZJZYhNkK8lDZMr1kFQ2OXNb8weFjm4PJZmSBSZeFhhH
         ke3Q==
X-Gm-Message-State: APjAAAUpVUBXTpQcJonDVR9wFygfrNL9h0bpT54WfJRWDHkztf7psJWt
        jkZYsk0wHJBkb9p1OWLTb1HLcAQTqnaFMeni2sk=
X-Google-Smtp-Source: APXvYqyuCjkE0XkrMs+AVF+eYtg4xPIL2ITAp0mwmOnta8bq2cWffxL5pzIh0ImORxmb0xK8gWevVNC32cPKk+1JltA=
X-Received: by 2002:a5e:8e42:: with SMTP id r2mr26795246ioo.305.1560884669745;
 Tue, 18 Jun 2019 12:04:29 -0700 (PDT)
MIME-Version: 1.0
References: <20190525181329.18657-1-tiny.windzz@gmail.com> <20190525181329.18657-2-tiny.windzz@gmail.com>
 <CA+E=qVdh1E8Y7dZO0JSS4DJE2bo=98MuSKRt7nmeFg-td7Ua9Q@mail.gmail.com>
 <CAEExFWtjNridLsMXOnBe2mJOPhUOYJ6G3wGF3gx=0oQoQROOGg@mail.gmail.com>
 <CA+E=qVeOSw=_z4OiQ4++z8g-KN29UYVXGicNd3PtHobg4xaG+w@mail.gmail.com>
 <CAEExFWs58UNcVcQNnwK3dk5cpmfQRnjdRWAmYs5M1t_ONr1Bpw@mail.gmail.com> <CA+E=qVf-_2DWbf55bCnjbkZH9N4a1_K16OxN9=o=NrZAV7GXPA@mail.gmail.com>
In-Reply-To: <CA+E=qVf-_2DWbf55bCnjbkZH9N4a1_K16OxN9=o=NrZAV7GXPA@mail.gmail.com>
From:   Frank Lee <tiny.windzz@gmail.com>
Date:   Wed, 19 Jun 2019 03:04:18 +0800
Message-ID: <CAEExFWtcNUVKc1-9MVgwoq0QErn3nhSHWTpzQNpcydQRPh9uqw@mail.gmail.com>
Subject: Re: [PATCH v3 1/3] thermal: sun8i: add thermal driver for h6
To:     Vasily Khoruzhick <anarsoul@gmail.com>
Cc:     rui.zhang@intel.com, Eduardo Valentin <edubezval@gmail.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Chen-Yu Tsai <wens@csie.org>,
        "David S. Miller" <davem@davemloft.net>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        paulmck@linux.ibm.com, devicetree <devicetree@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        arm-linux <linux-arm-kernel@lists.infradead.org>,
        Linux PM <linux-pm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Sat, Jun 15, 2019 at 7:08 AM Vasily Khoruzhick <anarsoul@gmail.com> wrote:
>
> On Wed, Jun 12, 2019 at 9:50 AM Frank Lee <tiny.windzz@gmail.com> wrote:
> >
> > > If you have a git tree I'll be happy to contribute A64 support. IIRC
> > > it was quite similar to H3.
> >
> > I built a ths branch and I will do some work later.
> >
> > https://github.com/TinyWindzz/linux/tree/ths
>
> Looks like you forgot to add your patches to this branch.

Done.
