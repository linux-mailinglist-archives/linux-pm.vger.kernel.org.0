Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3E4FE126619
	for <lists+linux-pm@lfdr.de>; Thu, 19 Dec 2019 16:49:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726895AbfLSPtY (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 19 Dec 2019 10:49:24 -0500
Received: from mail-ua1-f65.google.com ([209.85.222.65]:35640 "EHLO
        mail-ua1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726793AbfLSPtY (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 19 Dec 2019 10:49:24 -0500
Received: by mail-ua1-f65.google.com with SMTP id y23so2111229ual.2
        for <linux-pm@vger.kernel.org>; Thu, 19 Dec 2019 07:49:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=lXAvb1r92TnWK6C8dcnV7rx6hUZ8P71du1awwZOMpPs=;
        b=G0gvMHAcbaF/7lf/kFlpKzgPxYInj0tU+AECKhyI4EHND+mz3estSGIpY3oPXmKLMP
         gPo9PxMglxm9IAXdtznEBwxDfqWF3jQBsR2BAx/2VORiVEnhKQELCSolxCXO1H5EurID
         y1+KwpSGrgjMVhQRtqR4Ot/6v7JcGgL9GUjQE78sEUfEx8Jl1rvMbdK3ZpjnqF9lEmXi
         vCMvxQbMAxMWIsCc3kw4yhtYgwY2kyMYt6uloDPZhSWbecC25ecMfLOz7hSjrPrviiSo
         UigrTCd9Bwk6qy8gf6ZKiA1YiyAZrNPHFGKILVelGqsW0+iR8mykssawyJg/Dozs0Hc7
         5AQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=lXAvb1r92TnWK6C8dcnV7rx6hUZ8P71du1awwZOMpPs=;
        b=PrO+UnazUE7LDpRuSESEmdh92oztki6E7RwFkZkLDJcWbPMXSWhD7h4XJfclyQ3qZn
         +vgr4zP2nFA8AIJvZwL1HP2/Ua+3+QBfKT2Q6Qqgq9NfWRPK6jR8pys5ug4tPuFvddmT
         55Kxb4Uzcz/UbuOGyQjSMUmUUaVyiYuJbr0DKOpKjS9nXVCip3qTGCgx2CYCsQ77werr
         cNhfVmvZD4WfrWvbVLmXiv6NCYpPQiKS0+tQPLQiKHzouBTWIw3QsJK2wNSzJ3Bk43vk
         kSdgdeMXgu4uJuPhpMn0+YGcQs0/YxAbu+p4hDU9+R4dJ273mV8TZLSBCkrkBjvEpCwG
         jUmA==
X-Gm-Message-State: APjAAAU1T9oAiX0jcNbFH0/RM+uEXHZCfTXHV7n68ILH18qX708PeF44
        lfEdHhRbFRMYqNNNjWiei/B/PsUsCUN+pFfcDEqtyg==
X-Google-Smtp-Source: APXvYqzxayg//pdNpURx84BRAAl/dDcXVnta1LHOdI+qHwzENvNfTwcnpGaBIkok4+XfnyWH/9ANOFRvCIOH60V/V+c=
X-Received: by 2002:ab0:6894:: with SMTP id t20mr5903032uar.100.1576770563346;
 Thu, 19 Dec 2019 07:49:23 -0800 (PST)
MIME-Version: 1.0
References: <20191211154343.29765-1-ulf.hansson@linaro.org>
 <20191211154343.29765-15-ulf.hansson@linaro.org> <20191219143446.GG20746@bogus>
In-Reply-To: <20191219143446.GG20746@bogus>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Thu, 19 Dec 2019 16:48:47 +0100
Message-ID: <CAPDyKFpkSjq5RzuxCvj8wawU6Q15qq3qiBcrGz=H2X+1Wf3t8w@mail.gmail.com>
Subject: Re: [PATCH v4 14/14] arm64: dts: Convert to the hierarchical CPU
 topology layout for MSM8916
To:     Sudeep Holla <sudeep.holla@arm.com>
Cc:     Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>,
        Rob Herring <robh+dt@kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Lina Iyer <ilina@codeaurora.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Kevin Hilman <khilman@kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Thu, 19 Dec 2019 at 15:34, Sudeep Holla <sudeep.holla@arm.com> wrote:
>
> On Wed, Dec 11, 2019 at 04:43:43PM +0100, Ulf Hansson wrote:
> > To enable the OS to better support PSCI OS initiated CPU suspend mode,
> > let's convert from the flattened layout to the hierarchical layout.
> >
> > In the hierarchical layout, let's create a power domain provider per CPU
> > and describe the idle states for each CPU inside the power domain provider
> > node. To group the CPUs into a cluster, let's add another power domain
> > provider and make it act as the master domain. Note that, the CPU's idle
> > states remains compatible with "arm,idle-state", while the cluster's idle
> > state becomes compatible with "domain-idle-state".
> >
> > Co-developed-by: Lina Iyer <lina.iyer@linaro.org>
> > Signed-off-by: Lina Iyer <lina.iyer@linaro.org>
> > Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
> > ---
> >
> > Changes in v4:
> >       - None.
> >
> > ---
> >  arch/arm64/boot/dts/qcom/msm8916.dtsi | 57 +++++++++++++++++++++++++--
> >  1 file changed, 53 insertions(+), 4 deletions(-)
> >
> > diff --git a/arch/arm64/boot/dts/qcom/msm8916.dtsi b/arch/arm64/boot/dts/qcom/msm8916.dtsi
> > index 8686e101905c..282c36c8fa3b 100644
> > --- a/arch/arm64/boot/dts/qcom/msm8916.dtsi
> > +++ b/arch/arm64/boot/dts/qcom/msm8916.dtsi
> > @@ -102,10 +102,11 @@
> >                       reg = <0x0>;
> >                       next-level-cache = <&L2_0>;
> >                       enable-method = "psci";
> > -                     cpu-idle-states = <&CPU_SLEEP_0>;
> >                       clocks = <&apcs>;
> >                       operating-points-v2 = <&cpu_opp_table>;
> >                       #cooling-cells = <2>;
> > +                     power-domains = <&CPU_PD0>;
> > +                     power-domain-names = "psci";
> >               };
> >
> >               CPU1: cpu@1 {
> > @@ -114,10 +115,11 @@
> >                       reg = <0x1>;
> >                       next-level-cache = <&L2_0>;
> >                       enable-method = "psci";
> > -                     cpu-idle-states = <&CPU_SLEEP_0>;
> >                       clocks = <&apcs>;
> >                       operating-points-v2 = <&cpu_opp_table>;
> >                       #cooling-cells = <2>;
> > +                     power-domains = <&CPU_PD1>;
> > +                     power-domain-names = "psci";
> >               };
> >
> >               CPU2: cpu@2 {
> > @@ -126,10 +128,11 @@
> >                       reg = <0x2>;
> >                       next-level-cache = <&L2_0>;
> >                       enable-method = "psci";
> > -                     cpu-idle-states = <&CPU_SLEEP_0>;
> >                       clocks = <&apcs>;
> >                       operating-points-v2 = <&cpu_opp_table>;
> >                       #cooling-cells = <2>;
> > +                     power-domains = <&CPU_PD2>;
> > +                     power-domain-names = "psci";
> >               };
> >
> >               CPU3: cpu@3 {
> > @@ -138,10 +141,11 @@
> >                       reg = <0x3>;
> >                       next-level-cache = <&L2_0>;
> >                       enable-method = "psci";
> > -                     cpu-idle-states = <&CPU_SLEEP_0>;
> >                       clocks = <&apcs>;
> >                       operating-points-v2 = <&cpu_opp_table>;
> >                       #cooling-cells = <2>;
> > +                     power-domains = <&CPU_PD3>;
> > +                     power-domain-names = "psci";
> >               };
> >
> >               L2_0: l2-cache {
> > @@ -161,12 +165,57 @@
> >                               min-residency-us = <2000>;
> >                               local-timer-stop;
> >                       };
> > +
> > +                     CLUSTER_RET: cluster-retention {
> > +                             compatible = "domain-idle-state";
> > +                             arm,psci-suspend-param = <0x41000012>;
>
> If I followed the thread correctly, we are now just using the param as is
> without any extra logic like ORing like before. i.e. The domain state
> parameter overrides the any param below it in the hierarchy.
>
> If that's correct, then

That's correct!

> Acked-by: Sudeep Holla <sudeep.holla@arm.com>

Thanks!

Kind regards
Uffe
