Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C1021420AF6
	for <lists+linux-pm@lfdr.de>; Mon,  4 Oct 2021 14:37:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233098AbhJDMjL (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 4 Oct 2021 08:39:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229486AbhJDMjL (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 4 Oct 2021 08:39:11 -0400
Received: from mail-qt1-x832.google.com (mail-qt1-x832.google.com [IPv6:2607:f8b0:4864:20::832])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84109C061745
        for <linux-pm@vger.kernel.org>; Mon,  4 Oct 2021 05:37:22 -0700 (PDT)
Received: by mail-qt1-x832.google.com with SMTP id b16so15655152qtt.7
        for <linux-pm@vger.kernel.org>; Mon, 04 Oct 2021 05:37:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=jGP8TVCyTNKC8lYp46gRsaBQwXm6B5JGGuNtiC4p2to=;
        b=xg7b0UuDwntcgtEAt/AHqlb+K0LE+HZmn1Oqe4wj9ZTl8ACrCiVaPxulOPo7qzXjdH
         nctGwYnj9vWCI0hSXGYlRTI2GBcOla4sXRzmQUrYYb83H+Kr9FEmWL25y+y/LpgouP+f
         4rgbquxjLzD84AEaX1HQOsVh4t0JsK/OEae805W4QrbMfzNN9s+WepJf8ouualMpJ94t
         Q1yY6y81WM5PhMn/gTBbVfYvddoAkDKrdQzuflsINtSuQEfAqZtyKQRuGIIGrqI2jYGq
         YLtMXXawXGIuJjicJmhByzqJB7ZDpXguKFQ42ASwc2AWuPq3lHn/p9p6hDtxb8wk/Upb
         OxnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=jGP8TVCyTNKC8lYp46gRsaBQwXm6B5JGGuNtiC4p2to=;
        b=5lVQv/Iq+A6dqPKwI+Qs1bf2c6izkM4K0wB48LBtS1mPORZKhtZbv8JfgAYiWTrprt
         99N0L5ORnHZeSj1E1BAuwXr7jg+67t0lOQP6APs2H4r+NuJ/+iqP870fi1/v1lqvVt3n
         20vh5MxMz0QFLOdfFHAJVCuedubPNP76Re6yVufPdff8KB/4P4W8ksoBVLn7wgHE/Wdd
         N+7QJy6Mv4uZ1AUlA/iktfGV6H497W84EkhZHBJjuwy4fTKG1bRThFMmvlLQ7c8DMsZC
         wPAhKO54T6ziZtZVubv+G15DklGdiL4GLZSjtJAX7EQzbZEAolb2fRb2ZVqrukPYROJG
         Q4qA==
X-Gm-Message-State: AOAM532qApKOwNvFFVhLjP13FvUFeCeMrwME/ZEhRFshaHMf7C1INSw9
        B9wRLGm3CS6JMaSPVzsNzeHz6qvpWRvg1pfFcmk+Zw==
X-Google-Smtp-Source: ABdhPJyZdhtbVrhLrPMBAYTp9LsJkvO2y3XEFNx9DpQIGB9Wr40AxahoMxXtorTA5kV8paCC1Yd9yueJDIKEbs3eXOk=
X-Received: by 2002:ac8:6690:: with SMTP id d16mr12938010qtp.285.1633351041516;
 Mon, 04 Oct 2021 05:37:21 -0700 (PDT)
MIME-Version: 1.0
References: <20210903232421.1384199-1-dmitry.baryshkov@linaro.org>
 <36128ee3-0dad-dbdb-ca66-0d0e45aa0b9d@linaro.org> <2fe2f8bd-c487-e859-54e1-28e6cb0fdece@kernel.org>
In-Reply-To: <2fe2f8bd-c487-e859-54e1-28e6cb0fdece@kernel.org>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date:   Mon, 4 Oct 2021 15:37:10 +0300
Message-ID: <CAA8EJpoozRQ4iq4x8Xnp3rT3=f9svfosi=3PNPOoG=QS-VYLRA@mail.gmail.com>
Subject: Re: [PATCH v2 0/11] interconnect: merge AP-owned support into icc-rpm
To:     Georgi Djakov <djakov@kernel.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@somainline.org>,
        Shawn Guo <shawn.guo@linaro.org>,
        Yassine Oudjana <y.oudjana@protonmail.com>,
        "open list:DRM DRIVER FOR MSM ADRENO GPU" 
        <linux-arm-msm@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Mon, 4 Oct 2021 at 14:56, Georgi Djakov <djakov@kernel.org> wrote:
>
> On 25.09.21 22:40, Dmitry Baryshkov wrote:
> > On 04/09/2021 02:24, Dmitry Baryshkov wrote:
> >> This patch series merges support for AP-owned and bus QoS from SDM660
> >> into common code (icc-rpm.c). MSM8916 and MSM8939 support code is
> >> extended to support these features. As I was touching these drivers, per
> >> Bjorn's suggestion expand DEFINE_QNODE macros (which makes adding
> >> QoS support much easier to review).
> >>
> >> Dependencies:
> >>   -
> >> https://lore.kernel.org/linux-arm-msm/20210902054915.28689-1-shawn.guo@linaro.org/
> >>
> >>   -
> >> https://lore.kernel.org/linux-arm-msm/20210823014003.31391-1-shawn.guo@linaro.org/
> >>
> >>   -
> >> https://lore.kernel.org/linux-arm-msm/20210824043435.23190-1-shawn.guo@linaro.org/
> >>
> >>
> >> Changes since v1:
> >>   - Rebase on top a2noc clocks support patch.
> >>   - Expand DEFINE_QNODE
> >>   - Simplify struct qcom_icc_node by moving links to separate array
> >
> > Georgi, since all dependencies were pulled in by you, I wanted to
> > remind/ask: do you intend to pull this patchset for 5.16?
>
> Hi Dmitry,
> Yes, that's the plan. I just responded with a few minor comments/fixes
> to some of the patches. I can just fix them before applying, if you are
> fine with these.

Yes, I'm fine with your fixes. Please use them and apply the patchset.
Thank you!

>
> Thanks again to all the people involved with this patchset!
>
> Thanks,
> Georgi
>
> >
> >>
> >> ----------------------------------------------------------------
> >> Dmitry Baryshkov (11):
> >>        interconnect: icc-rpm: move bus clocks handling into qnoc_probe
> >>        interconnect: sdm660: expand DEFINE_QNODE macros
> >>        interconnect: sdm660: drop default/unused values
> >>        interconnect: sdm660: merge common code into icc-rpm
> >>        interconnect: icc-rpm: add support for QoS reg offset
> >>        interconnect: msm8916: expand DEFINE_QNODE macros
> >>        interconnect: msm8916: add support for AP-owned nodes
> >>        interconnect: msm8939: expand DEFINE_QNODE macros
> >>        interconnect: msm8939: add support for AP-owned nodes
> >>        interconnect: qcs404: expand DEFINE_QNODE macros
> >>        interconnect: qcom: drop DEFINE_QNODE macro
> >>
> >>   drivers/interconnect/qcom/icc-rpm.c |  263 ++++-
> >>   drivers/interconnect/qcom/icc-rpm.h |   56 +-
> >>   drivers/interconnect/qcom/msm8916.c | 1214 ++++++++++++++++++++--
> >>   drivers/interconnect/qcom/msm8939.c | 1283 +++++++++++++++++++++--
> >>   drivers/interconnect/qcom/qcs404.c  |  967 +++++++++++++++--
> >>   drivers/interconnect/qcom/sdm660.c  | 1940
> >> ++++++++++++++++++++++++-----------
> >>   6 files changed, 4815 insertions(+), 908 deletions(-)
> >>
> >>
> >
> >
>


-- 
With best wishes
Dmitry
