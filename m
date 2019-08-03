Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CA20880668
	for <lists+linux-pm@lfdr.de>; Sat,  3 Aug 2019 15:58:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391000AbfHCN6V (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sat, 3 Aug 2019 09:58:21 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:33495 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390999AbfHCN6V (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sat, 3 Aug 2019 09:58:21 -0400
Received: by mail-lj1-f193.google.com with SMTP id h10so3972332ljg.0
        for <linux-pm@vger.kernel.org>; Sat, 03 Aug 2019 06:58:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=MupMaC+XmWsb2GGGGsZRCBFziER7Wmhu89RotOfylV8=;
        b=qFU43RoQ58wOat3dL3H9kuErmIElXjDBKHkhvJ6htAOTpUDUUxnnlP76KYeE/vseTl
         mvLbGmIT2lfYsQ9s0sCOiApwgMrylnCCAsKYytDT7/8FuIkKPUp7rxvdnt4cY9oDrTYA
         a0gIFp0pwrQ+NmKD0Di6pRIbsxt8DJ+m1RuXkGcROZy0m5sjil92HFXx/q728TC1ltsA
         MbbuahwS0XQYyDKRX2/zzprxBCgC6xfEYDeh2HDnlaGU7mPXmFL6ne5JaMMpenPCNDy1
         eAnO+RO31hgwuuQGWluPDUp06KK61kvC/hfjTZCvAp6nl+wgL/NltJZdymSBmPwVktCF
         yj5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=MupMaC+XmWsb2GGGGsZRCBFziER7Wmhu89RotOfylV8=;
        b=DlMUuNXJXXUIlGX6/f+P60tSIZSpcUJSSc4H+xXpduxXldwqF08+eSU7gAFVk7dTB/
         61OjQKGnlQqbs8jirFasIfYQlsVF1KSW8mzxwQhC5Mw5Vw/F2WeuedMje8wiSUvkzyOL
         c3+/ca1r0f4ks/oja26p7nPyMGhfArf4BL0P2VavScDMICzOEU8JPwto6ZoamyXhtbbk
         HDq1gmOk3Xj3pH2yZQY08+2yx8snANVezdL5jcWHkoSejyZMedYD3d1UTaOfkyntR/8r
         Zk77nWZ5AjrmjMsSnjVZFBQbfey52TNEHfJI2SxL8czgN3UDRsuxFsv68g9WJpjcJwTc
         UsBA==
X-Gm-Message-State: APjAAAXHfe5n31M1YpJn/QMxnjN/pEKssQYs5b+xWzzyEy59py1L3tVj
        Qa1R3FIygxm/EaQmCgK8D8AyvFW/7KfMzxF6if3K1w==
X-Google-Smtp-Source: APXvYqwxZvx2gMGUkGxJBm279SI5kM7npKrkb3Kgq3Y21d91YTewSxvFDB3w98mrOdhQ7DZ4HRHKTpnm4gHPWE9r2Fo=
X-Received: by 2002:a05:651c:28c:: with SMTP id b12mr9571442ljo.69.1564840699603;
 Sat, 03 Aug 2019 06:58:19 -0700 (PDT)
MIME-Version: 1.0
References: <20190717063222.5902-1-linus.walleij@linaro.org>
In-Reply-To: <20190717063222.5902-1-linus.walleij@linaro.org>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Sat, 3 Aug 2019 15:58:08 +0200
Message-ID: <CACRpkdZcuqeUXVtwNJj8N+ncs6CVjmthdoe1cDj+M_imGLqisg@mail.gmail.com>
Subject: Re: [PATCH 1/2] thermal: db8500: Finalize device tree conversion
To:     Zhang Rui <rui.zhang@intel.com>,
        Eduardo Valentin <edubezval@gmail.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     Linux PM list <linux-pm@vger.kernel.org>,
        Lee Jones <lee.jones@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Wed, Jul 17, 2019 at 8:34 AM Linus Walleij <linus.walleij@linaro.org> wrote:

> At some point there was an attempt to convert the DB8500
> thermal sensor to device tree: a probe path was added
> and the device tree was augmented for the Snowball board.
> The switchover was never completed: instead the thermal
> devices came from from the PRCMU MFD device and the probe
> on the Snowball was confused as another set of configuration
> appeared from the device tree.
>
> Move over to a device-tree only approach, as we fixed up
> the device trees.
>
> Cc: Lee Jones <lee.jones@linaro.org>
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>

Thermal folks: can you apply/look into this?

If you're short on time, please just ACK it if it looks OK and
I can send it through the ARM SoC tree.

Yours,
Linus Walleij
