Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 571E540CD56
	for <lists+linux-pm@lfdr.de>; Wed, 15 Sep 2021 21:41:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231689AbhIOTmS (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 15 Sep 2021 15:42:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231486AbhIOTmS (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 15 Sep 2021 15:42:18 -0400
Received: from mail-ot1-x330.google.com (mail-ot1-x330.google.com [IPv6:2607:f8b0:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01CD1C061574
        for <linux-pm@vger.kernel.org>; Wed, 15 Sep 2021 12:40:59 -0700 (PDT)
Received: by mail-ot1-x330.google.com with SMTP id l7-20020a0568302b0700b0051c0181deebso5054276otv.12
        for <linux-pm@vger.kernel.org>; Wed, 15 Sep 2021 12:40:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:in-reply-to:references:from:user-agent:date:message-id
         :subject:to:cc;
        bh=mDzdWtBB1uSsJFNpS+LW0eoU/BmEDcIzioUx3tBX9MQ=;
        b=Ly9kyawmN861/4Wr1C8M9aEGfTfVB+G/JQ7VM6jBRtd5RWpnuD2lPePwRMRuLavd/Z
         l8suHz6HXSPxNA92D6B5fDECCdQZfwfXlT/5HCGbUPotXdK7yhmz23qRgEnePR+XiRHf
         BSt2Q4tYyys9osDsdTtmsmngLHLwlhPe6oNPU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:in-reply-to:references:from
         :user-agent:date:message-id:subject:to:cc;
        bh=mDzdWtBB1uSsJFNpS+LW0eoU/BmEDcIzioUx3tBX9MQ=;
        b=GvMGZCIcK/sNVtPylmsKy2W1sd5qKUltXB9uhjwlAemje4Q5y7OtN279cSshBcC8B3
         B+w1nRxz8H0RgiITuBbHNNZUyP6EWc0F09CTrh7awJpB/Hale8LaGlngUgmwMj6v9XNN
         f2qulpuhNGxp/7DlhY5dGL0gNJDz7lPHvCVYgN8Cgi38QJxMo6H2SpWRup5XFGqi6YIu
         v+0gBBJvIdNIk6ou3kCGwAMt2YfveaYumxsquvSkg3+DqyUogHPVIbcmSVz9GHCt5Jvt
         LsAJeqbkVA9QerQDMpJ2bpojryqszwIg06tWQNL8TiXeoafaku1Eitt9BBt0j8YhsLkV
         /u/g==
X-Gm-Message-State: AOAM532msQcquTjtS9ciwAo3L487Ad4bc3UzFEIqgy0gAEJ8zIjGMVix
        I36VK/1ufnTf9Ti8DCLDoRg8pX2xnPy+97mqTujyFarJY/E=
X-Google-Smtp-Source: ABdhPJwivxhkg8fCpBrYDaYtdYT13Ef9VjmdoM5RJyzQ0CrKUqXreux0XnV6qMdYSvfLig+lS8I5BpdTbzuXMDMwPsI=
X-Received: by 2002:a05:6830:18c7:: with SMTP id v7mr1527419ote.126.1631734858214;
 Wed, 15 Sep 2021 12:40:58 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 15 Sep 2021 12:40:57 -0700
MIME-Version: 1.0
In-Reply-To: <36fe241f845a27b52509274d007948b1@codeaurora.org>
References: <1629458622-4915-1-git-send-email-okukatla@codeaurora.org>
 <1629458622-4915-4-git-send-email-okukatla@codeaurora.org>
 <CAE-0n51WBdLoJRPs9tWZgdAukJMnkD3V00o7xNYVX77-eToKvw@mail.gmail.com>
 <749157bdb4613ae370adfb7ba055a2a9@codeaurora.org> <36fe241f845a27b52509274d007948b1@codeaurora.org>
From:   Stephen Boyd <swboyd@chromium.org>
User-Agent: alot/0.9.1
Date:   Wed, 15 Sep 2021 12:40:57 -0700
Message-ID: <CAE-0n53g=qGoVAMh_me_W0ksp39WUm2CCwAttcAK+Do5nYXq5g@mail.gmail.com>
Subject: Re: [v7 3/3] arm64: dts: qcom: sc7280: Add EPSS L3 interconnect provider
To:     okukatla@codeaurora.org
Cc:     Andy Gross <agross@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        bjorn.andersson@linaro.org, devicetree@vger.kernel.org,
        evgreen@google.com, georgi.djakov@linaro.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        mdtipton@codeaurora.org, sibis@codeaurora.org,
        saravanak@google.com, seansw@qti.qualcomm.com, elder@linaro.org,
        linux-pm@vger.kernel.org, linux-arm-msm-owner@vger.kernel.org,
        okukatla=codeaurora.org@codeaurora.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Quoting okukatla@codeaurora.org (2021-09-14 23:26:19)
> On 2021-09-15 10:35, okukatla@codeaurora.org wrote:
> > On 2021-09-04 00:36, Stephen Boyd wrote:
> >> Quoting Odelu Kukatla (2021-08-20 04:23:41)
> >>> Add Epoch Subsystem (EPSS) L3 interconnect provider node on SC7280
> >>> SoCs.
> >>>
> >>> Signed-off-by: Odelu Kukatla <okukatla@codeaurora.org>
> >>> ---
> >>>  arch/arm64/boot/dts/qcom/sc7280.dtsi | 11 +++++++++++
> >>>  1 file changed, 11 insertions(+)
> >>>
> >>> diff --git a/arch/arm64/boot/dts/qcom/sc7280.dtsi
> >>> b/arch/arm64/boot/dts/qcom/sc7280.dtsi
> >>> index 53a21d0..cf59b47 100644
> >>> --- a/arch/arm64/boot/dts/qcom/sc7280.dtsi
> >>> +++ b/arch/arm64/boot/dts/qcom/sc7280.dtsi
> >>> @@ -1848,6 +1848,17 @@
> >>>                         };
> >>>                 };
> >>>
> >>> +               epss_l3: interconnect@18590000 {
> >>> +                       compatible = "qcom,sc7280-epss-l3";
> >>> +                       reg = <0 0x18590000 0 1000>,
> >>
> >> Is this supposed to be 0x1000?
> >>
> > No, This is 1000 or 0x3E8.

Wow ok. Why is it the only size that isn't in hex format? Please try to
be consistent and use hex throughout.

> We have mapped only required registers for L3 scaling, 1000/0x3E8 is
> suffice.
> But i will update it to 0x1000 in next revision so that entire clock
> domain region-0 is mapped.

Doesn't that conflict with the cpufreq-hw device?

> >>> +                             <0 0x18591000 0 0x100>,
> >>> +                             <0 0x18592000 0 0x100>,
> >>> +                             <0 0x18593000 0 0x100>;
> >>> +                       clocks = <&rpmhcc RPMH_CXO_CLK>, <&gcc
> >>> GCC_GPLL0>;
> >>> +                       clock-names = "xo", "alternate";
> >>> +                       #interconnect-cells = <1>;
> >>> +               };
> >>> +
> >>>                 cpufreq_hw: cpufreq@18591000 {
> >>>                         compatible = "qcom,cpufreq-epss";
> >>>                         reg = <0 0x18591100 0 0x900>,
