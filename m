Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1E6A63E0866
	for <lists+linux-pm@lfdr.de>; Wed,  4 Aug 2021 20:57:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240388AbhHDS5k (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 4 Aug 2021 14:57:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240395AbhHDS5f (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 4 Aug 2021 14:57:35 -0400
Received: from mail-oi1-x22e.google.com (mail-oi1-x22e.google.com [IPv6:2607:f8b0:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1525BC061799
        for <linux-pm@vger.kernel.org>; Wed,  4 Aug 2021 11:57:22 -0700 (PDT)
Received: by mail-oi1-x22e.google.com with SMTP id 21so3989073oin.8
        for <linux-pm@vger.kernel.org>; Wed, 04 Aug 2021 11:57:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:in-reply-to:references:from:user-agent:date:message-id
         :subject:to:cc;
        bh=W0RU2njrJYwNw31OX+GKz1dnas7rS+0peN2BXk2nTOM=;
        b=XQG1pb4WN8xpvB82dpmucAJRgEyqKxa/pnqs92acP0GjyGJg6pbgmHVkt4VIIBWHZ2
         9lg1QU4BnUj9PaX5g6rsqOV31lVBH/YiGh5Muf2InY6gVAzhbwCNcNt0M9ZT1kilr1lB
         peNOAvCJ/Gk4wKYe3BIAV7+jN1n2GxKn9pORY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from
         :user-agent:date:message-id:subject:to:cc;
        bh=W0RU2njrJYwNw31OX+GKz1dnas7rS+0peN2BXk2nTOM=;
        b=ZGpWINSblPYZDWB98vv46JFT/2tS7ehPELvGUTlzLfwoikUybyXd2gId7M/FX0fRYO
         QxqMH2CainDEZUfYmVv4xYImvac+Kq7L8o5/CFspjqxGrDQ0z9MK8pFiT0ZiiTMSeU9n
         pPzZuS9C9VXIzSPOTBcZEUj5L6440HSTEWzK7nlTQ6qTsYvMPNRq7OlnfIA5sinJ+/f+
         FPRzphx8f/QTP6gEugQSTFTUvHXkc26lozcaWZyxxn25S3OW/8gbcKZCB3Xc1aOEkgkA
         mfS1h6I2QmvybpX0DQJESVKkl/Q6Zin2iUxD+JyU8cUcUOrNNenvU8PioV81szHn/1rm
         2IfQ==
X-Gm-Message-State: AOAM532LLCPsHA8Kui23nzXtj48ncZTS00IBdzlpJfG7470lnmIZG9Co
        ArDL33faVtZ4Sb2mrv57RdeTk+/qBRO+oQE9CLU6EA==
X-Google-Smtp-Source: ABdhPJxnaosSbnczMAr1y6z1t5NO2fUtY+Th+88s1vPF8mmT7ZwOvdJJWTYMH3xeYdgzDiiMnXNGokR3TdHCDuJICOc=
X-Received: by 2002:a05:6808:619:: with SMTP id y25mr3998610oih.166.1628103441478;
 Wed, 04 Aug 2021 11:57:21 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 4 Aug 2021 11:57:20 -0700
MIME-Version: 1.0
In-Reply-To: <1627581885-32165-4-git-send-email-sibis@codeaurora.org>
References: <1627581885-32165-1-git-send-email-sibis@codeaurora.org> <1627581885-32165-4-git-send-email-sibis@codeaurora.org>
From:   Stephen Boyd <swboyd@chromium.org>
User-Agent: alot/0.9.1
Date:   Wed, 4 Aug 2021 11:57:20 -0700
Message-ID: <CAE-0n5249t-DCDY0-HSV5EYN5yOv02NKJwKpibpL5NdTmnCrfg@mail.gmail.com>
Subject: Re: [PATCH 3/4] arm64: dts: qcom: sc7280: Fixup the cpufreq node
To:     Sibi Sankar <sibis@codeaurora.org>, bjorn.andersson@linaro.org,
        mka@chromium.org, robh+dt@kernel.org
Cc:     viresh.kumar@linaro.org, agross@kernel.org, rjw@rjwysocki.net,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        dianders@chromium.org, tdas@codeaurora.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Quoting Sibi Sankar (2021-07-29 11:04:44)
> Fixup the register regions used by the cpufreq node on SC7280 SoC to
> support per core L3 DCVS.
>
> Fixes: 7dbd121a2c58 ("arm64: dts: qcom: sc7280: Add cpufreq hw node")
> Signed-off-by: Sibi Sankar <sibis@codeaurora.org>
> ---

Reviewed-by: Stephen Boyd <swboyd@chromium.org>
