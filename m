Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B817216C039
	for <lists+linux-pm@lfdr.de>; Tue, 25 Feb 2020 13:06:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729189AbgBYMGz (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 25 Feb 2020 07:06:55 -0500
Received: from mail-lf1-f68.google.com ([209.85.167.68]:35903 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726019AbgBYMGz (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 25 Feb 2020 07:06:55 -0500
Received: by mail-lf1-f68.google.com with SMTP id f24so9590789lfh.3
        for <linux-pm@vger.kernel.org>; Tue, 25 Feb 2020 04:06:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=qL37Y4QwC2H5BVQcBjGxnhk5Q0ixQAlzjLOKjSRSjzg=;
        b=sAPoYCpPeqNu1VtPX1gXiQd8dXC9Ud2kT4nsPsqkPjP3zT0K32Y/IeK8JfXh4BF3lr
         jkwYdlfWZcPTDjrbWeWEh40nPgt+T4+MmNrd5i4YpaaUuJbjXprQyie7WiLLWVLFI612
         vbcV8uCfmIUI7JIY0nhk7p2ChzdllK/kao+L+oCjBRyTGOTcX9bAcO4OVnYTeHRis5oB
         ELDgUbJn4tdo9imAGxWaOWsdEsvshYK0XFKDf36phutEiWJda7cdLhBXYMFC1WeE8PbK
         rCZH4JLpQY/MDgFCrCAY8ibiVOREbl4XByl7pwe4wXdFMsCecj5eoeq/tSHCk4PmtLSK
         q0eA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=qL37Y4QwC2H5BVQcBjGxnhk5Q0ixQAlzjLOKjSRSjzg=;
        b=kAkJwZazkqcV/9/b0MCTu4ffFYItALMFtIsr6zIM5s7fP/G6YwUm47tIx+BmOgwUCM
         tgkzHdXxf2MPfDlEoDJOimiIUoHcA9lYMWgxc/5Mn+Pzf5PZ3eXgTlRc8Fg3PuBSuAAO
         z8CJtDSeKqIKSASJdBliSyHFLL8p9Jt3XQBBFBUBpzlRGW98xhKa7iyDn34yNeOdgCQm
         nSniE4XXz4oolYd2rOYWnuBy54s+3CZvgk2nDgIMyrVlsqH3zI9q+HgdqQepJJOmSC3K
         +AhXAFbh1+Rc2T/RHeeF6OWwuWCfOpH4lZbsH1lkeVy7U9JtPFIgLe8exAuKV8t9gZT7
         1Gpg==
X-Gm-Message-State: APjAAAWnozLoc/zp2HEYwKUi0u/Xla+uRu5vGrxnQg/AEn/mAgqcVBAR
        9Gwh/zu4XuPa5MrA4pddDz8HVwSlzGThqYnYui1zuw==
X-Google-Smtp-Source: APXvYqx4hD9HaTlSuNdaASWszKdhnnTGw4UdpRdVSDuvLrBOJV88/DSZ6LkAIwOgsPHB/a0L3ZRa+lZx6hi8twr3z8I=
X-Received: by 2002:ac2:5a05:: with SMTP id q5mr6326196lfn.143.1582632411863;
 Tue, 25 Feb 2020 04:06:51 -0800 (PST)
MIME-Version: 1.0
References: <cover.1582615616.git.amit.kucheria@linaro.org>
 <0f506cfdd8eb9d50b5eb43c9dca510284ac8ded1.1582615616.git.amit.kucheria@linaro.org>
 <20200225101614.GN2618@vkoul-mobl>
In-Reply-To: <20200225101614.GN2618@vkoul-mobl>
From:   Amit Kucheria <amit.kucheria@linaro.org>
Date:   Tue, 25 Feb 2020 17:36:40 +0530
Message-ID: <CAP245DUh2zZA=pfhoYswuffdR1_p72QR73SdWJCH8w8XySFpvg@mail.gmail.com>
Subject: Re: [PATCH v1 1/3] dt-bindings: thermal: tsens: Make dtbs_check pass
 for sc7180 tsens
To:     Vinod Koul <vkoul@kernel.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        sivaa@codeaurora.org, Andy Gross <agross@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Amit Kucheria <amit.kucheria@verdurent.com>,
        Linux PM list <linux-pm@vger.kernel.org>,
        DTML <devicetree@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Tue, Feb 25, 2020 at 3:46 PM Vinod Koul <vkoul@kernel.org> wrote:
>
> On 25-02-20, 13:01, Amit Kucheria wrote:
> > Fixes the following warnings:
> > builds/arch/arm64/boot/dts/qcom/sc7180-idp.dt.yaml:
> > thermal-sensor@c263000: compatible: ['qcom,sc7180-tsens',
> > 'qcom,tsens-v2'] is not valid under any of the given schemas (Possible
> > causes of the failure):
> > builds/arch/arm64/boot/dts/qcom/sc7180-idp.dt.yaml:
> > thermal-sensor@c263000: compatible:0: 'qcom,sc7180-tsens' is not one of
> > ['qcom,msm8916-tsens', 'qcom,msm8974-tsens']
> > builds/arch/arm64/boot/dts/qcom/sc7180-idp.dt.yaml:
> > thermal-sensor@c263000: compatible:0: 'qcom,sc7180-tsens' is not one of
> > ['qcom,msm8976-tsens', 'qcom,qcs404-tsens']
> > builds/arch/arm64/boot/dts/qcom/sc7180-idp.dt.yaml:
> > thermal-sensor@c263000: compatible:0: 'qcom,sc7180-tsens' is not one of
> > ['qcom,msm8996-tsens', 'qcom,msm8998-tsens', 'qcom,sdm845-tsens']
> > builds/arch/arm64/boot/dts/qcom/sc7180-idp.dt.yaml:
> > thermal-sensor@c263000: compatible:1: 'qcom,tsens-v0_1' was expected
> > builds/arch/arm64/boot/dts/qcom/sc7180-idp.dt.yaml:
> > thermal-sensor@c263000: compatible:1: 'qcom,tsens-v1' was expected
>
> I think the patch title should be "add qcom,sc7180-tsens to  qcom-tsens.yaml"
>
> and it would be great to see explanation on how adding it fixes these
> warns.

Agreed. I'll send out a new version with the commit messages fixed.

> Relooking at series I think this applies to rest of the series too :)
>

Thanks for the review.
