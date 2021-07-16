Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 078983CBDA7
	for <lists+linux-pm@lfdr.de>; Fri, 16 Jul 2021 22:21:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233119AbhGPUYa (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 16 Jul 2021 16:24:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234034AbhGPUYU (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 16 Jul 2021 16:24:20 -0400
Received: from mail-oi1-x22e.google.com (mail-oi1-x22e.google.com [IPv6:2607:f8b0:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37AFAC061760
        for <linux-pm@vger.kernel.org>; Fri, 16 Jul 2021 13:21:11 -0700 (PDT)
Received: by mail-oi1-x22e.google.com with SMTP id c197so12276233oib.11
        for <linux-pm@vger.kernel.org>; Fri, 16 Jul 2021 13:21:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:in-reply-to:references:from:user-agent:date:message-id
         :subject:to:cc;
        bh=g7XJc1DeK5RWLC2lwkpTVSEYbVo2aCJXOnkX5WvjkxQ=;
        b=X1ci68RUJiUzWjCTVEYL2rfpiWUTIDEiuEAdFprxYxCbNXbL0xlI835nzhNf9V8B/a
         vOnst8QCa8IsA/iNtd69ejQWQJEq/dV7DNrpWRP6qbjhXitYy83acrW8qyvrMt74sDlb
         C8ltdkIKsuitRqgJCvUPojfAXZXFGoLDWPDNY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from
         :user-agent:date:message-id:subject:to:cc;
        bh=g7XJc1DeK5RWLC2lwkpTVSEYbVo2aCJXOnkX5WvjkxQ=;
        b=kQGb9JH3eiq2LUhljknn5M3Hf08emMSm4QcNwW6HHaxG22cxy8TSF6U+5znP1t2dZx
         ub974fedfGai1lNOjI6OYhqVilitdxgaCHVUdcizoyZzFrUkGHl7IKrJnzM7qzzoi7fe
         CKBxBVYJKLtdWVxEMhLOH8MH5TI9ZSthovalMhsFLAzBLFakgFGuIOnQmXQwn84e5E6X
         Ekr5kokFjMOKEOb9LUGdjhc1XMf7pGMm0nckDMAgOgGtsTwYxhWDuatl4uNQR9UlIutD
         c7Tz2y3SB2T2wRgdFWnETwT3C1L+Q2PxlolIX6Unaxejn24U5+2BsPDwJe0kTeaUAr70
         aEaQ==
X-Gm-Message-State: AOAM533Gpx6uJTpoDu95iC5469cnSe1nvYnzmolmfFXSV3G4CtGpdmLn
        DrOwN1EKHhSERetPU+3FG0r4j87Qx2264zsAtSkOGQ==
X-Google-Smtp-Source: ABdhPJyK/jDp1Y5/AHnP6IVkZ7SwhZYlMNmFNUjxPUBlIgUz+nYo5ou6AL7km0hPj2UzUHV2sG6WvLOkEzWqNVmPO+o=
X-Received: by 2002:aca:7545:: with SMTP id q66mr9370162oic.19.1626466870695;
 Fri, 16 Jul 2021 13:21:10 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Fri, 16 Jul 2021 22:21:09 +0200
MIME-Version: 1.0
In-Reply-To: <YPHpsO5LlQRQxj9y@yoga>
References: <1626429658-18961-1-git-send-email-rnayak@codeaurora.org>
 <1626429658-18961-3-git-send-email-rnayak@codeaurora.org> <YPHpsO5LlQRQxj9y@yoga>
From:   Stephen Boyd <swboyd@chromium.org>
User-Agent: alot/0.9.1
Date:   Fri, 16 Jul 2021 22:21:06 +0200
Message-ID: <CAE-0n53CHD8c7C4ETWRgzmZmFSCcBw46wSs4pKbYMRjA_tD3yg@mail.gmail.com>
Subject: Re: [PATCH v4 2/2] arm64: dts: sc7180: Add required-opps for i2c
To:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rajendra Nayak <rnayak@codeaurora.org>
Cc:     ulf.hansson@linaro.org, viresh.kumar@linaro.org,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        rojay@codeaurora.org, stephan@gerhold.net
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Quoting Bjorn Andersson (2021-07-16 13:18:56)
> On Fri 16 Jul 05:00 CDT 2021, Rajendra Nayak wrote:
>
> > qup-i2c devices on sc7180 are clocked with a fixed clock (19.2 MHz)
> > Though qup-i2c does not support DVFS, it still needs to vote for a
> > performance state on 'CX' to satisfy the 19.2 Mhz clock frequency
> > requirement.
> >
>
> Sounds good, but...
>
> > Use 'required-opps' to pass this information from
> > device tree, and also add the power-domains property to specify
> > the CX power-domain.
> >
>
> ..is the required-opps really needed with my rpmhpd patch in place?
>

Yes? Because rpmhpd_opp_low_svs is not the lowest performance state for
CX.
