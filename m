Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0D3663D1A3F
	for <lists+linux-pm@lfdr.de>; Thu, 22 Jul 2021 01:12:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230510AbhGUWaL (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 21 Jul 2021 18:30:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230499AbhGUWaK (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 21 Jul 2021 18:30:10 -0400
Received: from mail-oi1-x22d.google.com (mail-oi1-x22d.google.com [IPv6:2607:f8b0:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60B6FC0613D3
        for <linux-pm@vger.kernel.org>; Wed, 21 Jul 2021 16:10:46 -0700 (PDT)
Received: by mail-oi1-x22d.google.com with SMTP id w188so4618203oif.10
        for <linux-pm@vger.kernel.org>; Wed, 21 Jul 2021 16:10:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:in-reply-to:references:from:user-agent:date:message-id
         :subject:to:cc;
        bh=yKt7vG8EoZe6rzvqs+N9WcJRTj/X2RtpmoC7dUxO8iI=;
        b=mz77Klx7MqX7flN9wWtWJP9PNj7eA2TfVjCvRy5pjJ0qFgS7IH7yYGHfnPpE5M7Kyv
         4QLY9u7rWm7GhxVeJXXaIpUwKP1fG2k+qaoJKiry+Xr6jxpCOChk44N+Lf7+WqwbHuif
         Q9pZ3V1nrDECl1zzeSoEBLD6YwY54ccCDAtBU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from
         :user-agent:date:message-id:subject:to:cc;
        bh=yKt7vG8EoZe6rzvqs+N9WcJRTj/X2RtpmoC7dUxO8iI=;
        b=YynZxOTCPn8pVciHT1PXWAuBu5B21B/zJw6hGVGXqV1t08oyFPgEnMfEgXBJn0aiWW
         AS8vbpC/KOsmjgw/4I/0ZH2pEiIvHBzpHEd4dBjMh8+8eTy2/UBcVmy5b5EjmZbbRyUX
         4SAbjOSU2LcBlTYChd2zv5nF4pNVP/SEssrEj7hmfJnnS2m8RuSUUWp1uGUZT1pDSl8O
         bL4Pjw3pOacH3zMZubAhP47zcgRt9mHaYgBoTrS21kUbP/NFPWyiloj+RVaB7t5F8pna
         DgYgV3zlb8vOfWFzQ3dmFpEAcb6u2jF9I8hXhWDl5VURB3d5tbHmSfl+M9q2oVP1sQzj
         PBfw==
X-Gm-Message-State: AOAM532YmEJMh/6Dx2sMlMpMYEUS0IGZiZsXOQjzl//QAx/kO/sQJ/zI
        bIJovscNS6iv5duukf+KZw/lLjDI789sKQiO+y3b1A==
X-Google-Smtp-Source: ABdhPJwXemZmi9OMyixYs3oJ0hsfOC5OIp++HhdU4bt6AYC4TJC5o0QNKmbzi8zkL0/turPmz6lJ5HWrPI+xQt4yMWQ=
X-Received: by 2002:aca:4dc6:: with SMTP id a189mr4204111oib.166.1626909045839;
 Wed, 21 Jul 2021 16:10:45 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 21 Jul 2021 23:10:45 +0000
MIME-Version: 1.0
In-Reply-To: <1620800053-26405-3-git-send-email-skakit@codeaurora.org>
References: <1620800053-26405-1-git-send-email-skakit@codeaurora.org> <1620800053-26405-3-git-send-email-skakit@codeaurora.org>
From:   Stephen Boyd <swboyd@chromium.org>
User-Agent: alot/0.9.1
Date:   Wed, 21 Jul 2021 23:10:45 +0000
Message-ID: <CAE-0n508FDzxm0uhqfoHpSKoa822HZUuXXX6Cu-MSRR+3Vpw+g@mail.gmail.com>
Subject: Re: [PATCH V4 2/5] dt-bindings: input: pm8941-pwrkey: add pmk8350
 compatible strings
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Sebastian Reichel <sre@kernel.org>,
        satya priya <skakit@codeaurora.org>
Cc:     David Collins <collinsd@codeaurora.org>, kgunda@codeaurora.org,
        linux-input@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, Vinod Koul <vkoul@kernel.org>,
        Andy Yan <andy.yan@rock-chips.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Quoting satya priya (2021-05-11 23:14:10)
> From: David Collins <collinsd@codeaurora.org>
>
> Add power key and resin compatible strings for the PMK8350 PMIC.
> These are needed to distinguish key PON_HLOS register differences
> between PMK8350 and previous PMIC PON modules.
>
> Signed-off-by: David Collins <collinsd@codeaurora.org>
> Signed-off-by: satya priya <skakit@codeaurora.org>
> Acked-by: Rob Herring <robh@kernel.org>
> ---

Reviewed-by: Stephen Boyd <swboyd@chromium.org>
