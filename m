Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 64F14167F05
	for <lists+linux-pm@lfdr.de>; Fri, 21 Feb 2020 14:50:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728177AbgBUNuP (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 21 Feb 2020 08:50:15 -0500
Received: from mail-lf1-f68.google.com ([209.85.167.68]:40745 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727851AbgBUNuP (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 21 Feb 2020 08:50:15 -0500
Received: by mail-lf1-f68.google.com with SMTP id c23so1535558lfi.7
        for <linux-pm@vger.kernel.org>; Fri, 21 Feb 2020 05:50:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Sf0tmWDionUelC4/eEP2OfX8tKBTBWojUFpEbrDtJPI=;
        b=w1ko8Q38gPPhRlUWLFuBF+6XHvtbBVeQklCnr8Gw/u8ROuTSyq04eYQM0bdmspxzCp
         dr+C/U8tS7ilCuKVMfB19EOudBucFcWH32l4Z/4WjId23QTMMxZVtzKwqdk2ciPsHnHf
         c3/e1Q+mKv0Z53+lJ0F1acoE8nUlDnTXtrzIAXvQwEMaRv9fu8QlWIg8wve+w0sdVpQQ
         xKWPTYRyH1m3kSosukY9S5C1QHlvGg4HNvN/rXzAE7Z+IuKKzGkobxWuzjf0ml7BHoVZ
         CMdG0jLsOjr4PHjV1a/BHHuJHHqG8uiBDqVgiH2/Ba2mcZS4crO3QyhZH2iaKJ7tTRx2
         WrdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Sf0tmWDionUelC4/eEP2OfX8tKBTBWojUFpEbrDtJPI=;
        b=T8G1dlQCw06BbWTC0+Eh5EfsrDbVFoUQlja+mQ0sFqsAhVm2TnQB9bDetBnNvbX1ux
         r9Ted3Rfh8IaitGnSJIs//tkRdRbGpMm9WIqHMK3Npe3qwfV9/iDZ0ANA8KUdSp5Dxys
         GwtK/tzjK9QdEJEZRIyBA7gGEMkKyKDJgJQtmFSB7ARc7GosGjdIB5Jf0cUMJ/vlRo29
         r3cAxlcmiGuh0MPIGZPtdwjGcR5v57tLIDKGuwPxgHHUNCeKcwO7cwGNhy78saP++vBx
         C7/kCmAsU6kdl4HLHzOyf+ZOMoboIyEenJR2efOdaVCnno8cuV4g2W+9KSkz9r268NSg
         r6Rg==
X-Gm-Message-State: APjAAAX3MvtiJKXTcMpaOBBpytoNy1eXHOpOF2ThEesAGim+PA60UpvL
        YeivE3H5b5SUhK0so+WYyg8/79tKLnSednvuXkp/9Q==
X-Google-Smtp-Source: APXvYqym050fla+7rVCMpBCZ6/aTMWJZ+KVkmueegzulH2SioUXqzwGBCOQZip0WoqthmngGhqwS/5mD0MnafMEDZPU=
X-Received: by 2002:ac2:44a5:: with SMTP id c5mr8062209lfm.4.1582293013774;
 Fri, 21 Feb 2020 05:50:13 -0800 (PST)
MIME-Version: 1.0
References: <cover.1581597365.git.matti.vaittinen@fi.rohmeurope.com> <a851b8c54662e6fdabfb9e1c9990de59649c1fdb.1581597365.git.matti.vaittinen@fi.rohmeurope.com>
In-Reply-To: <a851b8c54662e6fdabfb9e1c9990de59649c1fdb.1581597365.git.matti.vaittinen@fi.rohmeurope.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Fri, 21 Feb 2020 14:50:02 +0100
Message-ID: <CACRpkdbkVv_NocFBxjbupkwgXiio3qmZJuXOssuQxyhnzt7Yxg@mail.gmail.com>
Subject: Re: [RFC PATCH v2 4/5] power: supply: add battery parameters
To:     Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
Cc:     Matti Vaittinen <mazziesaccount@gmail.com>,
        mikko.mutanen@fi.rohmeurope.com, markus.laine@fi.rohmeurope.com,
        Mark Brown <broonie@kernel.org>,
        Sebastian Reichel <sre@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Linux PM list <linux-pm@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Fri, Feb 14, 2020 at 8:38 AM Matti Vaittinen
<matti.vaittinen@fi.rohmeurope.com> wrote:

> Add parsing of new device-tree battery bindings.
>
>      - tricklecharge-current-microamp
>      - precharge-upper-limit-microvolt
>      - re-charge-voltage-microvolt
>      - over-voltage-threshold-microvolt
>
> Signed-off-by: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
