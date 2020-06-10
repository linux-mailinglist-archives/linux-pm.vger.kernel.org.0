Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 65FE81F519F
	for <lists+linux-pm@lfdr.de>; Wed, 10 Jun 2020 11:55:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727994AbgFJJzs (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 10 Jun 2020 05:55:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727915AbgFJJzr (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 10 Jun 2020 05:55:47 -0400
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 751E2C03E96F
        for <linux-pm@vger.kernel.org>; Wed, 10 Jun 2020 02:55:45 -0700 (PDT)
Received: by mail-lf1-x134.google.com with SMTP id j12so1101989lfh.0
        for <linux-pm@vger.kernel.org>; Wed, 10 Jun 2020 02:55:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=IyM/A+avhJkkQHOLp+OvMDI3GG+kxptVRDbu3u0LPow=;
        b=KZ3GCV4oQ8GoZhjx2pBRStzJRFJC/aeLvAH56Ms+z3A6pyxZAqr26DULM6tE604ET4
         Neju+GKK0TxS2BEBiYqrK8ZAAy43gpWB8HQ971utdGJQuFszPl9QZgYYUU0sHCWRnhbd
         6GIHn8MU1axUgQbHaAfMzacFuagYyooDoAmkS8bnScg9G7g+StfE3LYW19Uxic9LK6On
         7FiJDSQEmMhNB5t1sCQgPq+qJ/bSCma6+45ICCeJpUzctEGgFrve+wbAlwsfoxQLe6yE
         B2GSy1pb47oGu2/e3pTl0eh75S/BCedvE9mxxYG9LjtQNOPinBsLstTJ4vPT9T8lwVVt
         vW3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=IyM/A+avhJkkQHOLp+OvMDI3GG+kxptVRDbu3u0LPow=;
        b=JzTw3fm2tU8KgILxhh9wfFvbgdFldLHW0alRFJdtCZH10fxZ40gdIYLQs03z4tsbt6
         LCz9c/2aSap0T7P6PnhwhXxL45axyA/1t9pI87EpxucqMh8e1PCBKj2fniGTLbdLT6BW
         q5RtdcWlA6ggnCHZboZIRF0aDmATvTll48KmS/nZnVNyVpkTC7nBtX5LUx6DGum4pvUU
         PZ3M8NcFIA0HEvZ6pB2b6McRhXmdB/0oR1Fi/SElqd76A15n7ezSshqsxEBs5DrASavt
         TXgcvHXM3S8nltL3ahulyqDgCF9xlLNbUgNKx1wysa5kkEKA+WARVYh+NMPIVlgkO0vE
         j7sg==
X-Gm-Message-State: AOAM533mtqfezgJ7hELwDZ5cEUIjXzpkT4HqOqPvY9cr0dH3fgZ+UN6l
        qGC+f4+Gs+s3gzrNvVhipXjhVfspus2aDLsUD/XSRg==
X-Google-Smtp-Source: ABdhPJw06BW9DC3WVHZ8QRBMneGYcET56eTT8DIAMhEVt8P5RXWMTPAIOnCaPj54gMD05QlYQar3OpWGUm5iy7QPfE0=
X-Received: by 2002:ac2:5a07:: with SMTP id q7mr1267243lfn.77.1591782943164;
 Wed, 10 Jun 2020 02:55:43 -0700 (PDT)
MIME-Version: 1.0
References: <20200605224403.181015-1-sebastian.reichel@collabora.com> <20200605224403.181015-7-sebastian.reichel@collabora.com>
In-Reply-To: <20200605224403.181015-7-sebastian.reichel@collabora.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Wed, 10 Jun 2020 11:55:32 +0200
Message-ID: <CACRpkdZchnn8EG6HOo_QD=veHJzb_Vy5F2Ma0cEOZUjcZwHPYg@mail.gmail.com>
Subject: Re: [PATCHv2 6/6] power: supply: gpio-charger: drop legacy GPIO support
To:     Sebastian Reichel <sebastian.reichel@collabora.com>
Cc:     Sebastian Reichel <sre@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Emil Velikov <emil.velikov@collabora.com>,
        Daniel Mack <daniel@zonque.org>,
        Haojian Zhuang <haojian.zhuang@gmail.com>,
        Robert Jarzmik <robert.jarzmik@free.fr>,
        Russell King <linux@armlinux.org.uk>,
        Linux PM list <linux-pm@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        kernel@collabora.com,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Sat, Jun 6, 2020 at 12:44 AM Sebastian Reichel
<sebastian.reichel@collabora.com> wrote:

> All board files have been converted to use boardfile GPIO
> descriptor tables, so GPIO support can be removed from
> platform data.
>
> Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>

Thanks so much for doing this!
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
