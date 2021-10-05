Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 23BD94233DC
	for <lists+linux-pm@lfdr.de>; Wed,  6 Oct 2021 00:52:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231304AbhJEWxy (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 5 Oct 2021 18:53:54 -0400
Received: from mail.kernel.org ([198.145.29.99]:45084 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230113AbhJEWxy (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Tue, 5 Oct 2021 18:53:54 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 2DA8C60FDA;
        Tue,  5 Oct 2021 22:52:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1633474323;
        bh=Vpm09a45hp0fKdaY5VZt8/zpE4trbHpiv3teFPZcaXs=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=atu5AkyLNBk6LeUfWrLES0aOugUafED1uwte5zh7zUMImJaDJKO0dyv2TgUVt++8y
         PHa8HNEJLMCXzJ1FD85AmWM+I42ZP4gNEU0uGRCcOTfl95aEItROGyFSXP/RNQiAOv
         gZ7JwF0ZbHU3efbTxqFXMd4yYcD93DxiBV9GoigLMXm1dZAWSy5o0+stqaRfQMZD5W
         r7459iY4nrYH6EHhOr0gWPDhDPEhT0uTK7vsedDih59qEsSBCWqvq4zRJohBZxS/og
         /6y208HBFSwBE6z2NxTGfBU7fWAgyz3ElNsJlPYzYXay7LtFt5hXyuu0R4PtNE3hS2
         MuQ2+pCkW7cEg==
Received: by mail-ed1-f44.google.com with SMTP id z20so2339422edc.13;
        Tue, 05 Oct 2021 15:52:03 -0700 (PDT)
X-Gm-Message-State: AOAM531HO4NL0QUrHLPszyR6ZQUAqhZFxx9jiDLs722D3x4YdY0Tkrw/
        pxcA8YQIO+HvGg254LakOTmDFfW+k1kG2LLo6Q==
X-Google-Smtp-Source: ABdhPJz5pagoqiRhjMIdDUgxwyAxNrRd9/CKrd0fbBZujXW26VXOp60ioGN3uqGK7Mbu5TJuZ8ZV9koBxy6XV9hiWBk=
X-Received: by 2002:a17:906:7217:: with SMTP id m23mr27480951ejk.466.1633474321797;
 Tue, 05 Oct 2021 15:52:01 -0700 (PDT)
MIME-Version: 1.0
References: <20211004044317.34809-1-manivannan.sadhasivam@linaro.org>
 <20211005042300.ix46h3ceu7aiwrg7@vireshk-i7> <20211005044623.GA4195@workstation>
In-Reply-To: <20211005044623.GA4195@workstation>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Tue, 5 Oct 2021 17:51:49 -0500
X-Gmail-Original-Message-ID: <CAL_JsqLSPrj0AUKx3YPAUcT0QY3TorBNratZRjs_ij8wVNgqfQ@mail.gmail.com>
Message-ID: <CAL_JsqLSPrj0AUKx3YPAUcT0QY3TorBNratZRjs_ij8wVNgqfQ@mail.gmail.com>
Subject: Re: [PATCH] dt-bindings: cpufreq: cpufreq-qcom-hw: Convert to YAML bindings
To:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc:     Viresh Kumar <viresh.kumar@linaro.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        "open list:THERMAL" <linux-pm@vger.kernel.org>,
        devicetree@vger.kernel.org,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@somainline.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Mon, Oct 4, 2021 at 11:46 PM Manivannan Sadhasivam
<manivannan.sadhasivam@linaro.org> wrote:
>
> On Tue, Oct 05, 2021 at 09:53:00AM +0530, Viresh Kumar wrote:
> > On 04-10-21, 10:13, Manivannan Sadhasivam wrote:
> > > Convert Qualcomm cpufreq devicetree binding to YAML.
> > >
> > > Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> > > Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@somainline.org>
> > > Reviewed-by: Rob Herring <robh@kernel.org>
> > > Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> > > ---
> >
> > I hope you will be resending this after fixing the DT warnings ?
>
> Yes, but I'm not sure why I can't reproduce the warnings locally. I did
> upgrade dtschema package and installed yamllint.

The checks run against 'main' branch rather than a release. But now
it's in a release because I released v2021.10 today.

Rob
