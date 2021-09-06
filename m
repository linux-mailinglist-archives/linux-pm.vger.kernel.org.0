Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 99BA740160A
	for <lists+linux-pm@lfdr.de>; Mon,  6 Sep 2021 07:52:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238924AbhIFFoC (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 6 Sep 2021 01:44:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238731AbhIFFoB (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 6 Sep 2021 01:44:01 -0400
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84870C061757
        for <linux-pm@vger.kernel.org>; Sun,  5 Sep 2021 22:42:54 -0700 (PDT)
Received: by mail-pj1-x1030.google.com with SMTP id d3-20020a17090ae28300b0019629c96f25so3782448pjz.2
        for <linux-pm@vger.kernel.org>; Sun, 05 Sep 2021 22:42:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=eoAIhJtotM9fW/V8q/8nvkbM7z9RVFj/ZC0pPXbVjzY=;
        b=bIs9tTCQ+SZzkkvM5x5WK5AHxKAr5EcO0zuV6Po6xPnjusJ5c2CAXdNn5FtI29++E6
         7hI4FfjLko9Jhvn67jrPOvvCY+kG958uOWEYDAEiklKzO5Sa6KD0GBVuq3gXn7YQlW2u
         6SdZrIztyfQ5iRY7DsGQ+P0gSEsHUvxueL+C7CQ2ZhYgYe0aBgvdSX4E9O/D2IrqlO/x
         vf4K3fapeMjhM1I/uD06q0W0+UFeuEt4yBBg4mrT2Ro4m7WYLy48DBw/bqGVFUrC+piO
         kjL1OJNImU6na9zMdmeX7Ix08eRo5p1jjF2im+HcWlMmTOXBEYvhfSkNQE9SMf1uxwRG
         Ql2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=eoAIhJtotM9fW/V8q/8nvkbM7z9RVFj/ZC0pPXbVjzY=;
        b=B/F8Rm6Smp16eRGch2jUq9esBWFtvqj7d/o5SNewqAC6UK1v6PpQXAzcvMpct+l2BC
         8ANnzWuKFMhRKDewAqs8sgB3gTTtM5LdLi7g4SurPZRTQ8hZyFiDUiD1kWcg4TjvmHFI
         Nr1Pi12+irPUPmjOLPZzefzjKqBTibGKL/0U71qjbj6SBeeJWkXqPkufo2iChT99e3bl
         PTNlArQD640L/wMG+y2zKRtpsS+OpAdH/TKZL31avbG36hZ63g9ieRiqp27aNK3VGp2X
         tZY8EwRnei2YX56IVSOV6oqMuay17Nki4rKJWE6Qbm0JLq58aQzZptB1CJdiAcQOabTo
         ATnA==
X-Gm-Message-State: AOAM533KD9WBjC65wNjcbIJrgtrByfqRFySu1cxLa0r48YOhiewePn35
        DPfhSbcMGmel/NEwbXWvThi9WSwoT4RezQ==
X-Google-Smtp-Source: ABdhPJyHcdKKFuaNZKaVVSUYu5ccU3GRuTh6whsomxuwB36bE3X2S8IfpvvRaTIZXp7BGkgYGY5nfA==
X-Received: by 2002:a17:90a:ad8b:: with SMTP id s11mr12152889pjq.76.1630906973981;
        Sun, 05 Sep 2021 22:42:53 -0700 (PDT)
Received: from dragon (80.251.214.228.16clouds.com. [80.251.214.228])
        by smtp.gmail.com with ESMTPSA id l22sm7887825pgo.45.2021.09.05.22.42.51
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 05 Sep 2021 22:42:53 -0700 (PDT)
Date:   Mon, 6 Sep 2021 13:42:46 +0800
From:   Shawn Guo <shawn.guo@linaro.org>
To:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Georgi Djakov <djakov@kernel.org>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@somainline.org>,
        Yassine Oudjana <y.oudjana@protonmail.com>,
        linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org
Subject: Re: [PATCH v2 0/11] interconnect: merge AP-owned support into icc-rpm
Message-ID: <20210906054245.GA25255@dragon>
References: <20210903232421.1384199-1-dmitry.baryshkov@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210903232421.1384199-1-dmitry.baryshkov@linaro.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Sat, Sep 04, 2021 at 02:24:10AM +0300, Dmitry Baryshkov wrote:
> This patch series merges support for AP-owned and bus QoS from SDM660
> into common code (icc-rpm.c). MSM8916 and MSM8939 support code is
> extended to support these features. As I was touching these drivers, per
> Bjorn's suggestion expand DEFINE_QNODE macros (which makes adding
> QoS support much easier to review).
> 
> Dependencies:
>  - https://lore.kernel.org/linux-arm-msm/20210902054915.28689-1-shawn.guo@linaro.org/
>  - https://lore.kernel.org/linux-arm-msm/20210823014003.31391-1-shawn.guo@linaro.org/
>  - https://lore.kernel.org/linux-arm-msm/20210824043435.23190-1-shawn.guo@linaro.org/
> 
> Changes since v1:
>  - Rebase on top a2noc clocks support patch.
>  - Expand DEFINE_QNODE
>  - Simplify struct qcom_icc_node by moving links to separate array
> 
> ----------------------------------------------------------------
> Dmitry Baryshkov (11):
>       interconnect: icc-rpm: move bus clocks handling into qnoc_probe
>       interconnect: sdm660: expand DEFINE_QNODE macros
>       interconnect: sdm660: drop default/unused values
>       interconnect: sdm660: merge common code into icc-rpm
>       interconnect: icc-rpm: add support for QoS reg offset
>       interconnect: msm8916: expand DEFINE_QNODE macros
>       interconnect: msm8916: add support for AP-owned nodes
>       interconnect: msm8939: expand DEFINE_QNODE macros
>       interconnect: msm8939: add support for AP-owned nodes
>       interconnect: qcs404: expand DEFINE_QNODE macros
>       interconnect: qcom: drop DEFINE_QNODE macro

On MSM8939 and SDM660:

Tested-by: Shawn Guo <shawn.guo@linaro.org>
