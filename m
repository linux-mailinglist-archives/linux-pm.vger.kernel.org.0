Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B28A2398A11
	for <lists+linux-pm@lfdr.de>; Wed,  2 Jun 2021 14:51:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229635AbhFBMxN (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 2 Jun 2021 08:53:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229533AbhFBMxN (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 2 Jun 2021 08:53:13 -0400
Received: from mail-vs1-xe2b.google.com (mail-vs1-xe2b.google.com [IPv6:2607:f8b0:4864:20::e2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA928C061574
        for <linux-pm@vger.kernel.org>; Wed,  2 Jun 2021 05:51:16 -0700 (PDT)
Received: by mail-vs1-xe2b.google.com with SMTP id x8so1011692vso.5
        for <linux-pm@vger.kernel.org>; Wed, 02 Jun 2021 05:51:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=zDam4v5Fg9p7lK+CPPtdMq2wb+GIbZcnsBCVIiUd08s=;
        b=pPx7UQ5vCXmUVaWp/RGRW8H3dUeJPovQZDDbaJVgs5/Wp6iRe5oN3pKw2b4JwQXMiT
         lMEGL2nBG0T/ztRgyHjWu/z0HHHB/0H9SIzc/4mfpBERd9AKFFV+SGY2FnjATr39V+yy
         IrZXEkbTq2//k3FAo/Un/eAHd4UMhDZaZV4PZHC22BXOslQbAj3t8okWLVTmr+45tT7d
         iAtxORC4HMNJcqe5TQ/uvvMb1EwqvfBjkK3SvbefiKKbpFWUFZls3ukK/eVJH1iPFRfQ
         U2htTY/gOql+jetOZw7vHEGRgW94m+6W3URlxLlhXxyYPcnVDuC4cDiE8PuFj60d5b8v
         fAzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=zDam4v5Fg9p7lK+CPPtdMq2wb+GIbZcnsBCVIiUd08s=;
        b=BAAOZe4NOJ3wBPiNNvrw5j0kuAysHWyICVLdGej/U/VfcSgu2ssmXZv2eafrzGCsCy
         eGZ/OeGp/A1+jlQPQyJEUCPUz1tqhI7xjHk92qMWZ75zqJoeNcYnlxM3uq84S3zMmJJ3
         4tzn3gw5ZqVu9L2dLl3Od1YBIYy8ARqV8f/iggK451GNqbhhyLaTgGTuZxpshu/gb7zz
         //8EsLeItYnNWVe3K8zarVEZ6YnsPFMCt7a75AdauEsON2XGBxKgwg1G98LK4B53FbdU
         lFXSabC98Kohdf+fLYekKNYNlazbNID5x6wIBxdWsBgW52hp/aFMmww5NDQFxSR5J4nS
         hvnw==
X-Gm-Message-State: AOAM531he8xFOQ1VJ5/NQQFZ+TYD27rI29HltxWJvLT8gtW/8FUxXtjv
        etuGqy4SoEi7ikwCMyVcd14IwqhK+Cb0eZHnnSGeHQ==
X-Google-Smtp-Source: ABdhPJzUginGmlokX+ysh4R5RQMBlTK4PfZt1V/KV/Te6Zr4zZ5crlWHz5ddYGKBWzw8HczkDLY1ZEHZw3YTwIkaRuw=
X-Received: by 2002:a05:6102:5da:: with SMTP id v26mr2293516vsf.19.1622638274853;
 Wed, 02 Jun 2021 05:51:14 -0700 (PDT)
MIME-Version: 1.0
References: <1622095949-2014-1-git-send-email-rnayak@codeaurora.org>
 <1622095949-2014-2-git-send-email-rnayak@codeaurora.org> <YLYV3ov/iBffZMg4@gerhold.net>
 <20210601114426.3vhh2twocqx254b6@vireshk-i7> <CAPDyKFqmBoMwQkWHT-w8A2=PeXeDgxE8n=D4prdEyuxM+ZOAaA@mail.gmail.com>
 <20210602105459.t3ptci42lgvrzqlx@vireshk-i7>
In-Reply-To: <20210602105459.t3ptci42lgvrzqlx@vireshk-i7>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Wed, 2 Jun 2021 14:50:38 +0200
Message-ID: <CAPDyKFrO-xTCy+ZRNX8y6yUdUoZqv0KZWcPp6dD_R1kxNB-L-g@mail.gmail.com>
Subject: Re: [PATCH v2 1/3] dt-bindings: power: Introduce 'assigned-performance-states'
 property
To:     Viresh Kumar <viresh.kumar@linaro.org>
Cc:     Rajendra Nayak <rnayak@codeaurora.org>,
        Stephan Gerhold <stephan@gerhold.net>,
        Rob Herring <robh+dt@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        DTML <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Roja Rani Yarubandi <rojay@codeaurora.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Wed, 2 Jun 2021 at 12:55, Viresh Kumar <viresh.kumar@linaro.org> wrote:
>
> On 02-06-21, 12:45, Ulf Hansson wrote:
> > Alright, so it looks like we already have the DT binding that we need for this.
> >
> > That leaves us with the question, at what place should we parse it
> > (call of_get_required_opp_performance_state()) and set the performance
> > state for the device?
> >
> > Does it still make sense to do it while attaching the device to the
> > genpd, you think?
>
> For parsing, yes this is the right place. For getting that into
> effect, whenever the device is supposed to work, i.e. with runtime PM
> somehow.

Okay, thanks for confirming. That would be along the lines of what
Rajendra did in patch2.

Kind regards
Uffe
