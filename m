Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7FBFF456786
	for <lists+linux-pm@lfdr.de>; Fri, 19 Nov 2021 02:42:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230385AbhKSBp5 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 18 Nov 2021 20:45:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229914AbhKSBp5 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 18 Nov 2021 20:45:57 -0500
Received: from mail-oi1-x22f.google.com (mail-oi1-x22f.google.com [IPv6:2607:f8b0:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 959ACC061574
        for <linux-pm@vger.kernel.org>; Thu, 18 Nov 2021 17:42:56 -0800 (PST)
Received: by mail-oi1-x22f.google.com with SMTP id 7so18462802oip.12
        for <linux-pm@vger.kernel.org>; Thu, 18 Nov 2021 17:42:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=X+4PtbwP22GNL58EB2Kn0kBSekJZJrlBoC1EpDbCbXg=;
        b=IVpsHQisSXq61n+KCFmaFVTIZs1m7P8sptH88Rs2nCWyy05xN3D5zLggCYBoSoA+0l
         u7fcIUffkGErYpwi8Y3XHROuyUIsWALMQr5rqYfomny0130g5jsmqlK2y1NvQ2SMD9gQ
         ZWCyuZF6T+AUUWS/dQpyOovCAMnpSDbrezyWD2zyo5Eh3qjK/7Bl/65Y73GuXE0LngfN
         wdih7bwfGmPzfsEkdR5CQSc7llv9dtBiDwvvW8+9A3TUTvREyPh4+6iciM9Gpt/BXr2C
         d2R9FHaiAMfDTOUN6iEDX6lC8sX7K3olLhiiRDKeX/1I9SbrKt/1ceST/AfOyhCSB32R
         ECbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=X+4PtbwP22GNL58EB2Kn0kBSekJZJrlBoC1EpDbCbXg=;
        b=g8fBvRc/6S0+My34tNMgU3a19CERBJ6bcDg0Wl0JUVNgrj8UxkISOcwJIadlO2t2iO
         Bdkn7LC6Q13Sz3nMXI0OcCWfrbCCWlT6iKv1EujlnZJ2w59r7R5EpMsZbr+vqGCI+JLs
         le+nOMw76pIZaoEIiGd+J9ObuY9CEHa8pfVwgfiXX/MfrkUksYKeWEzgwV8Fg0oGKwAW
         vDpSykIcn39ukhNjsONjs/hA2Fpq1Tn/HZEh3WO98jzO1HaaWV/hOpxByFxwSAU+6Psb
         +0MsCKYEPFkpPDSgFRf5wDMxVJnYnXEBUZAMv9WRU6VpwYtCZfTe6ajOejgRje7oGiO/
         pCyw==
X-Gm-Message-State: AOAM531DBE8BDsY6vXSC1yyxtdHNwpUozcppLPPGyWsjrN7bNfl5GtTC
        2k6it+30WXgulKl9qn9jP1H5x31YE+N8jiUI0tNUy1/RtgQ=
X-Google-Smtp-Source: ABdhPJyivwAYVdXUPMbQ2Y5VnZ8qk/PZC4e3Bk2bhJcLGXxX5foQprxJzFpUAszMwIztcuhdwXgdbO39GFXWDz6eZ7Y=
X-Received: by 2002:a54:4791:: with SMTP id o17mr1587886oic.114.1637286175950;
 Thu, 18 Nov 2021 17:42:55 -0800 (PST)
MIME-Version: 1.0
References: <cover.1637061794.git.matti.vaittinen@fi.rohmeurope.com> <6645a55c05cf12954f97347ade1cf47ddf62bb86.1637061794.git.matti.vaittinen@fi.rohmeurope.com>
In-Reply-To: <6645a55c05cf12954f97347ade1cf47ddf62bb86.1637061794.git.matti.vaittinen@fi.rohmeurope.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Fri, 19 Nov 2021 02:42:44 +0100
Message-ID: <CACRpkda5YunVXZWp7dnY0qiKMXHSs4qviYuLVh1uc0jB9aaY9A@mail.gmail.com>
Subject: Re: [RFC PATCH v3 4/9] power: supply: Add batinfo getters usable
 prior supply registration
To:     Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
Cc:     Matti Vaittinen <mazziesaccount@gmail.com>,
        Sebastian Reichel <sre@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Lee Jones <lee.jones@linaro.org>, rostokus@gmail.com,
        fan.chen@mediatek.com, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-power@fi.rohmeurope.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Tue, Nov 16, 2021 at 1:26 PM Matti Vaittinen
<matti.vaittinen@fi.rohmeurope.com> wrote:

> In some cases it is beneficial to be able to query the static battery
> node properties prior power_supply registration. The device-tree
> parsing does not really depend on psy so add APIs which can
> be used without the power-supply. Also, convert APIs to operate on
> fwnode while at it.
>
> Signed-off-by: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>

This looks quite useful!
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
