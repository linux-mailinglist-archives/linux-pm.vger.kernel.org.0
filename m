Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AA9ED11D73D
	for <lists+linux-pm@lfdr.de>; Thu, 12 Dec 2019 20:38:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730636AbfLLThb (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 12 Dec 2019 14:37:31 -0500
Received: from mail-lj1-f195.google.com ([209.85.208.195]:40599 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730610AbfLLTha (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 12 Dec 2019 14:37:30 -0500
Received: by mail-lj1-f195.google.com with SMTP id s22so3582969ljs.7
        for <linux-pm@vger.kernel.org>; Thu, 12 Dec 2019 11:37:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=dvGJ0797Qz8DUFLYM8Rit14ij9aZ1vENIS91EYjNpec=;
        b=MThukkqGbJH0JqQq7NvRMwiKjEvckHmmxf4wk/k+CyqysQALPXBquylwgn1+SkKOux
         hYds4XHtiXiqnLjBZTCZHVaMufoABT/oCOU20kwUAus7U+22gMzRkYcbyaBccoa7KyYv
         12+iTzwdpt/manm3sKQDH7pyNVNLBK7zrgfczpEB0qxEGoyOp2RO1/x10LHuQJ2M7UF8
         xwcczLh07pEx03HMT6hiKGSuIJDAsez0N1uPaJIkQaw89JkglxUV7L09rhWo2MmtWhMp
         GIqxgm0dT3TxGD4WfuTEc14eHGp2Q5ogVIoDDyp9Pxly8HOvzkn+Q7nAi1hlWOskTmam
         XFGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=dvGJ0797Qz8DUFLYM8Rit14ij9aZ1vENIS91EYjNpec=;
        b=PxHS9x3Kn0DYz6U6tVSybgIJhcilNlTx6MVHk3X6woUcpj47gNZRhw+si4q4n22DJV
         8pkLeJEK2+DP1TYGGyXiiXSJSdW0B6CeGSYB9DhUwLhUn9UKMaR35q5WzpJBdRQvraQD
         YikviYylBWrkz/D3+1lk8mLW+j/90zwMypC+aDi4DBC14XdOQTHV9vj6z08Aew1zCCvB
         qDGSwViVqNVQwbEOVjuGu88n9B5mtgApQqYb7VO/iB9baJ0HoE0qItblivVZNLm3NwTL
         OYsXOndkuh7t/5MELjoeoOGiNn4jI3PgNSTaXpSz1KW5By/Xlozzuz46qm4R8fvqoR6s
         swTg==
X-Gm-Message-State: APjAAAVg1wxruskicG5XwAqLQaLtm/+hJVaJN7goMx1glamKxJNdeFB4
        rU8jDidRfnMC++NP4YHNIauOwzbK+Vf9zlCIUhXzZQ==
X-Google-Smtp-Source: APXvYqz4Z1nagdLRuefbsVS4snEWX7fyZkbq/3ND7xotrEE30d//QZNUnTbwcm2mnmu/6tLOV8m1Zcho9bqz56n4Swo=
X-Received: by 2002:a2e:9e03:: with SMTP id e3mr7189882ljk.186.1576179448269;
 Thu, 12 Dec 2019 11:37:28 -0800 (PST)
MIME-Version: 1.0
References: <1563568344-1274-1-git-send-email-daidavid1@codeaurora.org>
 <1563568344-1274-3-git-send-email-daidavid1@codeaurora.org>
 <20190721191305.GI7234@tuxbook-pro> <0ecba781-ad08-0f09-f4a8-83473569a4c5@codeaurora.org>
In-Reply-To: <0ecba781-ad08-0f09-f4a8-83473569a4c5@codeaurora.org>
From:   Evan Green <evgreen@google.com>
Date:   Thu, 12 Dec 2019 11:36:52 -0800
Message-ID: <CAE=gft57S_2yKQdP6x=R9nVUaHWvreS-ENKkKrKmOzhJYLpzEQ@mail.gmail.com>
Subject: Re: [PATCH 2/2] arm64: dts: sdm845: Redefine interconnect provider DT nodes
To:     David Dai <daidavid1@codeaurora.org>
Cc:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Georgi Djakov <georgi.djakov@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Lina Iyer <ilina@codeaurora.org>,
        Sean Sweeney <seansw@qti.qualcomm.com>,
        Alex Elder <elder@linaro.org>,
        LKML <linux-kernel@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        linux-pm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Tue, Jul 23, 2019 at 11:24 AM David Dai <daidavid1@codeaurora.org> wrote:
>
> Thanks for looking over this, Bjorn.
>
> On 7/21/2019 12:13 PM, Bjorn Andersson wrote:
> > On Fri 19 Jul 13:32 PDT 2019, David Dai wrote:
> >
> >> Add the DT nodes for each of the Network-On-Chip interconnect
> >> buses found on SDM845 based platform and redefine the rsc_hlos
> >> child node as a bcm-voter device to better represent the hardware.
> >>
> >> Signed-off-by: David Dai <daidavid1@codeaurora.org>
> >> ---
> >>   arch/arm64/boot/dts/qcom/sdm845.dtsi | 61 ++++++++++++++++++++++++++++++++++--
> >>   1 file changed, 58 insertions(+), 3 deletions(-)
> >>

What happened to this series? Is it abandoned?
-Evan
