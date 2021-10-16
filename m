Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 38A6E43032C
	for <lists+linux-pm@lfdr.de>; Sat, 16 Oct 2021 17:09:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237198AbhJPPME (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sat, 16 Oct 2021 11:12:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233105AbhJPPME (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sat, 16 Oct 2021 11:12:04 -0400
Received: from mail-qk1-x734.google.com (mail-qk1-x734.google.com [IPv6:2607:f8b0:4864:20::734])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2CE1C061570
        for <linux-pm@vger.kernel.org>; Sat, 16 Oct 2021 08:09:55 -0700 (PDT)
Received: by mail-qk1-x734.google.com with SMTP id 77so11267442qkh.6
        for <linux-pm@vger.kernel.org>; Sat, 16 Oct 2021 08:09:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ic2B3qAcwXa3Bb0xn0FSuPPQc9LYrHNTOr5kbu049Qc=;
        b=ZYHCANlUN15by7s7UXXFcFKlreoz0ZiVqI4I2ONz0twA5CNDE/GG6zJ9No+7FvohpD
         lJszz43Nr/keKxSC8UdoOSQKsxNowDAS0GMhuleCRrIQPRjtSPiPhBmxg0d/uRwrCBcR
         GGxVwxP/nF4V1cdqTpixvCyHN0ejejeH6q4gWm0fW2GT6NUwkmdm+Kbwl4YLtRWcIKHc
         ubJuHiLbFjxsg22t+pJWnGtXeRrsQFKRnp7Reu04QuRZD1z3eCnaaMoNixxyCHyRCZUz
         m22l5BcpZv6MzNTfTxHIH+/t6QwwKBFEaiCAoZwlJdLbjOGToKRddNJos8F//crpmc+E
         bQUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ic2B3qAcwXa3Bb0xn0FSuPPQc9LYrHNTOr5kbu049Qc=;
        b=E9iHsgIAP7V1NF4+j3E4QZXoBfcTYvL4tTh892VaCymGv9lLBfhB6mGsRmjaCLIT4X
         bAfGTEXW2b5K7db/ljekShnVhJYn0VWT4RkR+N515O3AFD/xPxEnAqoIpMUDxBrKzg3R
         56kW6GEtGCD3AN7GUm09RfEdIjsjXoLzWT8xmk8xt40MjfvcVN9TGRzux04bg1GukBMs
         +2BAly4+dtdr4UTZJA5Wu5GjlqpV29mof4hNfFrLizbJp9Zf+IhvjnrB/IHt/4PmJGwr
         WkDS8odM4l9NSn74UYechUu6ArLRpnxE0LykRKQ+hVmjYLQ8vVQgk3T35nZmf8fa0StX
         G2kA==
X-Gm-Message-State: AOAM533IG2Zokl0H181MDjxBOv610XTMYkd7Yoc/sLGlrbd19+6vximn
        kmSpCMImUvOUbUx37ydKghkuwU0HP9T0GIJpVQDPFg==
X-Google-Smtp-Source: ABdhPJxV8nVMmu9V10uCeG5Lw0KNhKIjiUhuuUIkqH4ZK83pIFkcbD6pd7PLhPz4YWBYcjHdUOXP70Pnq+vCC5VHtOA=
X-Received: by 2002:ae9:d842:: with SMTP id u63mr15066970qkf.44.1634396995049;
 Sat, 16 Oct 2021 08:09:55 -0700 (PDT)
MIME-Version: 1.0
References: <20211014083016.137441-1-y.oudjana@protonmail.com>
 <20211014083016.137441-8-y.oudjana@protonmail.com> <a8114098-f700-974b-e17e-54f5baebec46@somainline.org>
 <ZVR21R.X63CT137R99A3@protonmail.com>
In-Reply-To: <ZVR21R.X63CT137R99A3@protonmail.com>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date:   Sat, 16 Oct 2021 18:09:43 +0300
Message-ID: <CAA8EJppVVzOmfwqMb==-xcoHGmQrZqD6+2T_+TFtD8tjUC_zNQ@mail.gmail.com>
Subject: Re: [PATCH 7/8] arm64: dts: qcom: msm8996: Add MSM8996 Pro support
To:     Yassine Oudjana <y.oudjana@protonmail.com>
Cc:     Konrad Dybcio <konrad.dybcio@somainline.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Ilia Lin <ilia.lin@kernel.org>,
        Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Loic Poulain <loic.poulain@linaro.org>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@somainline.org>,
        "open list:DRM DRIVER FOR MSM ADRENO GPU" 
        <linux-arm-msm@vger.kernel.org>,
        "open list:COMMON CLK FRAMEWORK" <linux-clk@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Sat, 16 Oct 2021 at 17:51, Yassine Oudjana <y.oudjana@protonmail.com> wrote:
>
>
> On Fri, Oct 15 2021 at 23:01:54 +0400, Konrad Dybcio
> <konrad.dybcio@somainline.org> wrote:
> >
> > On 14.10.2021 10:32, Yassine Oudjana wrote:
> >>  Add a new DTSI for MSM8996 Pro (MSM8996SG) with msm-id and CPU/GPU
> >> OPPs.
> >>  CBF OPPs and CPR parameters will be added to it as well once
> >> support for
> >>  CBF scaling and CPR is introduced.
> >>
> >>  Signed-off-by: Yassine Oudjana <y.oudjana@protonmail.com>
> >>  ---
> >>   arch/arm64/boot/dts/qcom/msm8996.dtsi    |  82 +++----
> >>   arch/arm64/boot/dts/qcom/msm8996pro.dtsi | 281
> >> +++++++++++++++++++++++
> >>   2 files changed, 322 insertions(+), 41 deletions(-)
> >>   create mode 100644 arch/arm64/boot/dts/qcom/msm8996pro.dtsi
> >>
> >>  diff --git a/arch/arm64/boot/dts/qcom/msm8996.dtsi
> >> b/arch/arm64/boot/dts/qcom/msm8996.dtsi
> >>  index 94a846c3f1ee..5b2600a4fb2a 100644
> >>  --- a/arch/arm64/boot/dts/qcom/msm8996.dtsi
> >>  +++ b/arch/arm64/boot/dts/qcom/msm8996.dtsi
> >>  @@ -142,82 +142,82 @@ cluster0_opp: opp_table0 {
> >>              /* Nominal fmax for now */
> >>              opp-307200000 {
> >>                      opp-hz = /bits/ 64 <307200000>;
> >>  -                   opp-supported-hw = <0x77>;
> >>  +                   opp-supported-hw = <0x7>;
> >
> > You didn't describe what's the reason for changing this everywhere.
> >
> > If it's been always broken, perhaps make it a separate commit
> > describing
> >
> > the issue.
> >
> >
> > Konrad
> >
>
> Before removing reading msm-id in qcom_cpufreq_nvmem, bits 0-2 (0x07)
> were MSM8996 speed bins, while bits 4-6 (0x70) were MSM8996 Pro speed
> bins. Now, only bits 0-2 are used for either one, so basically I moved
> bits 4-6 into msm8996pro.dtsi after shifting them right to become bits
> 0-2.
>
> I'll put this in a separate patch and describe the change.

Could you please describe in the commit message why is it changed?
IOW, what prompted you to split 8996SG support from main msm8996.dtsi?

-- 
With best wishes
Dmitry
