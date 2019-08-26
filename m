Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 83AA89D765
	for <lists+linux-pm@lfdr.de>; Mon, 26 Aug 2019 22:26:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388067AbfHZU0p (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 26 Aug 2019 16:26:45 -0400
Received: from mail-oi1-f195.google.com ([209.85.167.195]:39750 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387468AbfHZU0p (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 26 Aug 2019 16:26:45 -0400
Received: by mail-oi1-f195.google.com with SMTP id 16so13155801oiq.6
        for <linux-pm@vger.kernel.org>; Mon, 26 Aug 2019 13:26:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=CU9vIq4P5BZXCg5wzqzK4HuykkAahQhh1wQ2fSzqgKc=;
        b=gz1tm9J2aVDQhUGqXvflptDxFexfPuJgbyu3Nkky/w2jUzcjMYbLvBPe9Kl1dJyURy
         yYOabbLS/9X83B9ppvE14aGfD8arZPC9khfKQwH3ODxWDFSiBk8fI81mPz7A2Uw7PfV8
         zhjYkULvFEeU2lAZPxiH52Y69RMEdk3PnCVC0CL+F9DSMDc32DAnlVZ2ZQhQYdiVPf3p
         NQug9mcXFwt3bW+JT2KWT4Ryk+D9hwlepv5Xd0MXHlQwCslTmF1Vi2n66WprJFZwMcwS
         DPKzUG2jqJLHBawdKS3NOFabxSbhJKLUMtqs7bBkxlLA6keLM53nB29lOiJ8Sj6IaFPo
         oa4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=CU9vIq4P5BZXCg5wzqzK4HuykkAahQhh1wQ2fSzqgKc=;
        b=p/xdsGBfea5cd3Z4TPKIcHFy1f6F8NCCm3A7vr5caApTQYlBT75LoS1Wsjk0Q3TNLt
         ykelaGVmW28UfXBcdT4FXyUcj+JwDuLEKks2fNBOaiotvwrUwb8sgxvf/Rw2LIYguoln
         L+skSeeC97KQfsxW/80NyanZkwNIcPP5+py0WFAU8q4RpMZlt2l0l6aiEMPZPacv0xNC
         I+6MCYo73wrR+7qD898iEupoBxQHf7444cktP5KNdn9JWnZ89Ibx/pfmvnupvHhoDNBU
         wTinFMw+sro3vrex3GY1dPIiX6IaESvVya5NujiC/7MFvgQgytj82gupxoyBK1u3ZMm9
         IGaQ==
X-Gm-Message-State: APjAAAXcWos1eBHegDQO6ly35Ra9i1aRpis9e3tRzKyZm8Q067wFllNv
        FP0zJkE1TNS/VsXb2Yt5XcLek6cGyE/197HfcLUAWA==
X-Google-Smtp-Source: APXvYqxifHTyu88QNI+xE/H7y5lAlWbyLdUeL/fr8tthhWEEjrsQhIOC8x+zG6CGeLCSCCxy9LENRIMv6SvRrWwAnO8=
X-Received: by 2002:aca:5106:: with SMTP id f6mr14016778oib.69.1566851203738;
 Mon, 26 Aug 2019 13:26:43 -0700 (PDT)
MIME-Version: 1.0
References: <20190807223111.230846-1-saravanak@google.com> <20190807223111.230846-2-saravanak@google.com>
 <20190821203353.GA11783@bogus>
In-Reply-To: <20190821203353.GA11783@bogus>
From:   Saravana Kannan <saravanak@google.com>
Date:   Mon, 26 Aug 2019 13:26:07 -0700
Message-ID: <CAGETcx_vPtPoqtXRmoOuJp9fx10-121YG64rADPh2W=3r8KrDg@mail.gmail.com>
Subject: Re: [PATCH v5 1/3] dt-bindings: opp: Introduce opp-peak-kBps and
 opp-avg-kBps bindings
To:     Rob Herring <robh@kernel.org>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Georgi Djakov <georgi.djakov@linaro.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        "Sweeney, Sean" <seansw@qti.qualcomm.com>,
        David Dai <daidavid1@codeaurora.org>, adharmap@codeaurora.org,
        Rajendra Nayak <rnayak@codeaurora.org>,
        Sibi Sankar <sibis@codeaurora.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Evan Green <evgreen@chromium.org>,
        Android Kernel Team <kernel-team@android.com>,
        Linux PM <linux-pm@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Wed, Aug 21, 2019 at 1:33 PM Rob Herring <robh@kernel.org> wrote:
>
> On Wed,  7 Aug 2019 15:31:09 -0700, Saravana Kannan wrote:
> > Interconnects often quantify their performance points in terms of
> > bandwidth. So, add opp-peak-kBps (required) and opp-avg-kBps (optional) to
> > allow specifying Bandwidth OPP tables in DT.
> >
> > opp-peak-kBps is a required property that replaces opp-hz for Bandwidth OPP
> > tables.
> >
> > opp-avg-kBps is an optional property that can be used in Bandwidth OPP
> > tables.
> >
> > Signed-off-by: Saravana Kannan <saravanak@google.com>
> > ---
> >  Documentation/devicetree/bindings/opp/opp.txt     | 15 ++++++++++++---
> >  .../devicetree/bindings/property-units.txt        |  4 ++++
> >  2 files changed, 16 insertions(+), 3 deletions(-)
> >
>
> Reviewed-by: Rob Herring <robh@kernel.org>

Thanks Rob!

-Saravana
