Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 37767373103
	for <lists+linux-pm@lfdr.de>; Tue,  4 May 2021 21:48:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232596AbhEDTtA (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 4 May 2021 15:49:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232487AbhEDTs7 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 4 May 2021 15:48:59 -0400
Received: from mail-qk1-x72e.google.com (mail-qk1-x72e.google.com [IPv6:2607:f8b0:4864:20::72e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 860B1C06174A
        for <linux-pm@vger.kernel.org>; Tue,  4 May 2021 12:48:03 -0700 (PDT)
Received: by mail-qk1-x72e.google.com with SMTP id v20so9844375qkv.5
        for <linux-pm@vger.kernel.org>; Tue, 04 May 2021 12:48:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=dLRKtbyO50ZwLbGZ3RGT/lGz35DJJd92L3sxN1YsG2k=;
        b=laSCr644OH3wrJ6rLbeSdBIYes8vO3VEwMCv+BerwVh5PMGVlK4rSZhtFDngmFMKgb
         jQ4U1Vdqq5qHLpzHYR0T+qBvogRxh5xcqorNf2qL7f7J7An22P2JA3wMWzEP7CT0G00c
         pvFBnSmuf7bR3zp+CdBeEbVr//XxFhekeVjM4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=dLRKtbyO50ZwLbGZ3RGT/lGz35DJJd92L3sxN1YsG2k=;
        b=Kd5sHvR1Bca9EJwCjsoEe1Zzj2v6o3jqdza8dMvmQaArBRpzkFBlBugKDACMEkJ0R3
         WSGU24QgwfU39bRqYngsPxVLCwkTmf4/eeJDZVf2AlvS6AnSLM4vPqIEJUVX7TnNk6ya
         A9aLgDL9NqYL67zqrTXXlc88Mg2Pw35JWkE/lgKBjj00PjXc+qQDR0A5z3nePhZIYaFF
         UfXIQy0xvyY2XuCm8lrtXXqcBc5s8tejHQTiXpr9ueN2ArwIiar7YxhXhIRRcSC2AT/o
         TOpw7jeunDzFA3V08/lqTOKjK6Rm/DnHWN8258dA7AZbOfvc7QvW6iOMIjlE+iJ5EaEW
         HSJQ==
X-Gm-Message-State: AOAM5315QfN+N2FSddzuqldUuVyqHV23o18zJXvXRSg9kNPSRlTvnG2u
        KMvjOxkT0TCL1oR3hUFcH7mrAz30QXMNXA==
X-Google-Smtp-Source: ABdhPJw5VhfHyrxOSotKOmnUs8ZTREMqVMuuRUy6Zz38gAF5sb3SIb6CwtVdztwv4G+hF+D8KX/bQQ==
X-Received: by 2002:a37:9802:: with SMTP id a2mr27921345qke.473.1620157682438;
        Tue, 04 May 2021 12:48:02 -0700 (PDT)
Received: from mail-yb1-f172.google.com (mail-yb1-f172.google.com. [209.85.219.172])
        by smtp.gmail.com with ESMTPSA id l16sm3190694qtr.65.2021.05.04.12.48.01
        for <linux-pm@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 04 May 2021 12:48:01 -0700 (PDT)
Received: by mail-yb1-f172.google.com with SMTP id l7so13740463ybf.8
        for <linux-pm@vger.kernel.org>; Tue, 04 May 2021 12:48:01 -0700 (PDT)
X-Received: by 2002:a25:9c86:: with SMTP id y6mr36946496ybo.405.1620157681041;
 Tue, 04 May 2021 12:48:01 -0700 (PDT)
MIME-Version: 1.0
References: <1620111510-31455-1-git-send-email-sibis@codeaurora.org> <1620111510-31455-2-git-send-email-sibis@codeaurora.org>
In-Reply-To: <1620111510-31455-2-git-send-email-sibis@codeaurora.org>
From:   Doug Anderson <dianders@chromium.org>
Date:   Tue, 4 May 2021 12:47:49 -0700
X-Gmail-Original-Message-ID: <CAD=FV=XNh63TTtCEO4gbRm3s6mJ0C9jiN=B58f5+5n1KZeAOng@mail.gmail.com>
Message-ID: <CAD=FV=XNh63TTtCEO4gbRm3s6mJ0C9jiN=B58f5+5n1KZeAOng@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] cpufreq: blacklist SC7280 in cpufreq-dt-platdev
To:     Sibi Sankar <sibis@codeaurora.org>
Cc:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Matthias Kaehlcke <mka@chromium.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi,

On Mon, May 3, 2021 at 11:58 PM Sibi Sankar <sibis@codeaurora.org> wrote:
>
> Add SC7280 to cpufreq-dt-platdev blacklist since the actual scaling is
> handled by the 'qcom-cpufreq-hw' driver.
>
> Signed-off-by: Sibi Sankar <sibis@codeaurora.org>
> ---
>  drivers/cpufreq/cpufreq-dt-platdev.c | 1 +
>  1 file changed, 1 insertion(+)

Reviewed-by: Douglas Anderson <dianders@chromium.org>
