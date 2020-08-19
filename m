Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 75E9A24A774
	for <lists+linux-pm@lfdr.de>; Wed, 19 Aug 2020 22:07:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726862AbgHSUHe (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 19 Aug 2020 16:07:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726796AbgHSUHd (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 19 Aug 2020 16:07:33 -0400
Received: from mail-vs1-xe43.google.com (mail-vs1-xe43.google.com [IPv6:2607:f8b0:4864:20::e43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EAAF2C061383
        for <linux-pm@vger.kernel.org>; Wed, 19 Aug 2020 13:07:32 -0700 (PDT)
Received: by mail-vs1-xe43.google.com with SMTP id y8so12608062vsq.8
        for <linux-pm@vger.kernel.org>; Wed, 19 Aug 2020 13:07:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=qeG68/iGaDfUT5GNDRtXeBjtRxO2lzb4494Br3HhoQ8=;
        b=nth9Ndu3BBX7zAieFztilD8MMhjA3cdKplDrlZ5W49D+qhHUXF16NTrUFVUtNZIS5h
         nrjyXqD0UKvz/RmioArJ9MppfKV1DecA3144QIXSTdy70+pM6+C0j1wW1xWuwQI0vTGk
         xwDrfNSyE9v1KWX6aTq33r618HHrmZ26rfI20=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=qeG68/iGaDfUT5GNDRtXeBjtRxO2lzb4494Br3HhoQ8=;
        b=LHugbyejm3arU2YwOJDsN717G/nAJ632fqWqC+xP6P/TahOdEeJ33RiOQhZCcopsEH
         SxZFXNnVFtYvuQykF2/6a1Su5VxDE86gi4k65AkMUTIOrW/ZRWDo1yRpb3Ikbllxd5iw
         IUAYsbtJ4mva97jeOUmAkDJ8kAWGeuOyu7JgvP2/Fhf4C+MkScotvAouRdsATnzQdGm3
         5HSlRadC+3dqeuzPBdZ4NzmEpqDHA1oz260OPwUaFJOzLmuraX5l++LyrE96+uSksnDz
         IbuYCVhKzsHopuUE06rcg61H29UU5Aotx+/UbO59UttIDmVRNYJBk/JVcbOpRgWN/ixX
         /s5Q==
X-Gm-Message-State: AOAM532s+4SWfXkvCoIWoB9054q4ajpag1JvCFi+5M1ywkZkrco1Qned
        6Bz20Gi6mNygCwVkbZmr97fE0xmol6e+UA==
X-Google-Smtp-Source: ABdhPJx4VviYm8C7fgQ4KOsY6OxBn8jV/TZKFC51+WjWAAAoYAldP/RTHU++3Fei7RZ0Y7POyyzLMQ==
X-Received: by 2002:a67:e9d4:: with SMTP id q20mr22608vso.176.1597867651723;
        Wed, 19 Aug 2020 13:07:31 -0700 (PDT)
Received: from mail-vs1-f50.google.com (mail-vs1-f50.google.com. [209.85.217.50])
        by smtp.gmail.com with ESMTPSA id a82sm4899621vke.39.2020.08.19.13.07.30
        for <linux-pm@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 19 Aug 2020 13:07:30 -0700 (PDT)
Received: by mail-vs1-f50.google.com with SMTP id b26so12593449vsa.13
        for <linux-pm@vger.kernel.org>; Wed, 19 Aug 2020 13:07:30 -0700 (PDT)
X-Received: by 2002:a67:fd67:: with SMTP id h7mr14388451vsa.121.1597867649964;
 Wed, 19 Aug 2020 13:07:29 -0700 (PDT)
MIME-Version: 1.0
References: <20200806163126.22667-1-georgi.djakov@linaro.org> <20200806163126.22667-6-georgi.djakov@linaro.org>
In-Reply-To: <20200806163126.22667-6-georgi.djakov@linaro.org>
From:   Doug Anderson <dianders@chromium.org>
Date:   Wed, 19 Aug 2020 13:07:18 -0700
X-Gmail-Original-Message-ID: <CAD=FV=UBhxxd2zc6uu7z7LDc7q5sfVRONuJZXQrwKjZYuyMy=w@mail.gmail.com>
Message-ID: <CAD=FV=UBhxxd2zc6uu7z7LDc7q5sfVRONuJZXQrwKjZYuyMy=w@mail.gmail.com>
Subject: Re: [PATCH v2 5/7] arm64: dts: qcom: sdm845: Increase the number of
 interconnect cells
To:     Georgi Djakov <georgi.djakov@linaro.org>
Cc:     Linux PM <linux-pm@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Sibi Sankar <sibis@codeaurora.org>,
        Matthias Kaehlcke <mka@chromium.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi,

On Thu, Aug 6, 2020 at 9:31 AM Georgi Djakov <georgi.djakov@linaro.org> wrote:
>
> Increase the number of interconnect-cells, as now we can include
> the tag information. The consumers can specify the path tag as an
> additional argument to the endpoints.
>
> Tested-by: Sibi Sankar <sibis@codeaurora.org>
> Reviewed-by: Sibi Sankar <sibis@codeaurora.org>
> Reviewed-by: Matthias Kaehlcke <mka@chromium.org>
> Signed-off-by: Georgi Djakov <georgi.djakov@linaro.org>
> ---
>  arch/arm64/boot/dts/qcom/sdm845.dtsi | 44 ++++++++++++++--------------
>  1 file changed, 22 insertions(+), 22 deletions(-)

I believe you missed updating a few places...  Fixup can be found at
<https://crrev.com/c/2364731> or look carefully under "ipa@1e40000"
and "gpu@5000000".

-Doug
