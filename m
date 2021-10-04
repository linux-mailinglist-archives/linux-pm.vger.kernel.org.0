Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 37F7E420B73
	for <lists+linux-pm@lfdr.de>; Mon,  4 Oct 2021 14:56:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233891AbhJDM5V (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 4 Oct 2021 08:57:21 -0400
Received: from mail.kernel.org ([198.145.29.99]:58610 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233675AbhJDM44 (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Mon, 4 Oct 2021 08:56:56 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 5CA97613A8;
        Mon,  4 Oct 2021 12:55:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1633352107;
        bh=mvlyRyhy7emUnuAV9WbaXuu7RE1Tdgh1NRwZw3JefXY=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=s0mTntS7crZzZX4+bY/ZnJVDNWdAQslmqbbcQ0PsO5TIFnkE1uIE6qtD4RRqbNNEq
         zvEfxJ5xGUgJRiPw2rf+LCiKGoTvKDULIBLkKspDzbTt071YZOBWywsrrKL+W8kbsh
         6Iuqp7FUMR0yzIzaGcemXkSGKfPDcgF/gurk5MUlDCBcNXsKcpBfReKx98YZwWqsv1
         ZKf+y4uPTR5dp38Bt3ntCmacz992JweMR1z0e/Iyfxjf8ozNud2dZCsfPZNDUTsfd3
         wADWDAudlIJuFFWNEsK60zCVYh8p6jUlFnN3c3HgNv8kxQB4aI8UqhDWWRbeeyG2v8
         PwSfdI+7BZ5Nw==
Received: by mail-ed1-f50.google.com with SMTP id bm13so14483098edb.8;
        Mon, 04 Oct 2021 05:55:07 -0700 (PDT)
X-Gm-Message-State: AOAM530Ljtpf6XyUr9jXf+7/sLo7zCHIRCmIuU1udQrdGuvrmQ7xBwlG
        M9GUmwDp7IVEBYtd06wXXjRdXgBz5eni8jCfeQ==
X-Google-Smtp-Source: ABdhPJwEBWCl91gtcdMnpixu5wjLc3jqrGi0kyv6wgVkV9ejWdBoOkXFKIO0gyRSYxKpBmvCHWxeaAyshyhuMMzG6UA=
X-Received: by 2002:a17:906:7250:: with SMTP id n16mr16605453ejk.147.1633352098590;
 Mon, 04 Oct 2021 05:54:58 -0700 (PDT)
MIME-Version: 1.0
References: <20211004044317.34809-1-manivannan.sadhasivam@linaro.org>
 <20211004070531.sexvnqmnkoe4j6a2@vireshk-i7> <20211004072222.GE16442@workstation>
 <20211004090310.pwtsjpmwajivclxj@vireshk-i7>
In-Reply-To: <20211004090310.pwtsjpmwajivclxj@vireshk-i7>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Mon, 4 Oct 2021 07:54:46 -0500
X-Gmail-Original-Message-ID: <CAL_JsqKw4LaSOpN2p-wd4r64v6etkC4s8B1XDPi+gTE1Y+42tw@mail.gmail.com>
Message-ID: <CAL_JsqKw4LaSOpN2p-wd4r64v6etkC4s8B1XDPi+gTE1Y+42tw@mail.gmail.com>
Subject: Re: [PATCH] dt-bindings: cpufreq: cpufreq-qcom-hw: Convert to YAML bindings
To:     Viresh Kumar <viresh.kumar@linaro.org>
Cc:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
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

On Mon, Oct 4, 2021 at 4:03 AM Viresh Kumar <viresh.kumar@linaro.org> wrote:
>
> On 04-10-21, 12:52, Manivannan Sadhasivam wrote:
> > On Mon, Oct 04, 2021 at 12:35:31PM +0530, Viresh Kumar wrote:
> > > On 04-10-21, 10:13, Manivannan Sadhasivam wrote:
> > > > Convert Qualcomm cpufreq devicetree binding to YAML.
> > > >
> > > > Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> > > > Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@somainline.org>
> > > > Reviewed-by: Rob Herring <robh@kernel.org>
> > >
> > > I am not sure if Rob ever gave this.
> > >
> >
> > I'm not fooling you :)
> > https://patchwork.kernel.org/project/linux-pm/patch/20210701105730.322718-5-angelogioacchino.delregno@somainline.org/#24312445
>
> Btw, I also wondered about this since we now have "performance-domain"
> bindings and was thinking if this should be moved to use those or not.
>
> Rob ?

Yes, at least for new users, but that's a separate patch from converting this.

Rob
