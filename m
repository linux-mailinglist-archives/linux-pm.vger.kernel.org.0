Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 57C7D70C508
	for <lists+linux-pm@lfdr.de>; Mon, 22 May 2023 20:18:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230101AbjEVSSe convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-pm@lfdr.de>); Mon, 22 May 2023 14:18:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229830AbjEVSSd (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 22 May 2023 14:18:33 -0400
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB9EBE0
        for <linux-pm@vger.kernel.org>; Mon, 22 May 2023 11:18:32 -0700 (PDT)
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-510ecd2d0caso696931a12.0
        for <linux-pm@vger.kernel.org>; Mon, 22 May 2023 11:18:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684779511; x=1687371511;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+U73OVL5NwSp8SCAs1dkEjKjKbvxTKlrz24Jw5CXNgA=;
        b=aJ4xeV6EK8I0PJx6MZIvVNWSLimBPwyvPThpBl4mbJ48LzkHcFOO9i3cHYQEBYx50M
         BRqa9qKFbJUjJTEJFglnBkYebLFt5O7wpe1TZtR/YL6kaNu/rv/8rq0jA+pgZIeO36xX
         1H1OhSFFM83bcp9Hjw9RKuPyafiB3a2dNcDWWbdvOdjpnr4sklSjBREZ113uWJApk5R0
         E2m34RbUjGbird1fEzoi/IlvfN7b7+3FSNtv7OUOaCCaLqfIwz35af9sWjg4ktn3zR2w
         EA1aIinwpobtNrseoccmIYGeH5IKYMk3iYlsUi0Cqt5Gn9PBDT+ZBIVcjiQFQLLqqNQu
         fsKA==
X-Gm-Message-State: AC+VfDyBUB2B48ecUlEZVFZOhekdvd4TtGS2Qih1XET4FgEYuocPIlsz
        UVjWEVo52aWEHcwLuaiYUVFS5MOTRJA8HbG52tU=
X-Google-Smtp-Source: ACHHUZ73Z9qvqq3OpO0dNGjep3VODBCPZ7kjCNdb9QNTC6frQxVVd8K8FHqKlQaXZOWqtKiJ8ymivCN5Xv5q0EkXoW0=
X-Received: by 2002:a17:906:5350:b0:92e:f520:7762 with SMTP id
 j16-20020a170906535000b0092ef5207762mr10228204ejo.6.1684779511147; Mon, 22
 May 2023 11:18:31 -0700 (PDT)
MIME-Version: 1.0
References: <CAJZ5v0juUuy2xKZHMXAKSRtfQxMyL6z12AFdU8_ZbdFRKKrR=Q@mail.gmail.com>
 <097bd237-81f9-0636-2e8c-0ab6785fab45@arm.com>
In-Reply-To: <097bd237-81f9-0636-2e8c-0ab6785fab45@arm.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Mon, 22 May 2023 20:18:19 +0200
Message-ID: <CAJZ5v0gLSBenjOxxQX2whv98VOk-M-BHAM-OLJvZahU661tmvA@mail.gmail.com>
Subject: Re: [CfP] Power Management and Thermal Control MC (LPC2023)
To:     Lukasz Luba <lukasz.luba@arm.com>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        "Zhang, Rui" <rui.zhang@intel.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Morten Rasmussen <morten.rasmussen@arm.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Mario Limonciello <mario.limonciello@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Lukasz,

On Mon, May 22, 2023 at 7:52 PM Lukasz Luba <lukasz.luba@arm.com> wrote:
>
> Hi Rafael,
>
> On 5/22/23 18:12, Rafael J. Wysocki wrote:
> > Hi Folks,
> >
> > I'm going to submit a Power Management and Thermal Control
> > micro-conference proposal for LPC2023 along the lines of what happened
> > in the previous iterations of it.
> >
> > If you have topics that you'd like to be discussed there, please let
> > me know by Friday, May 26.
> >
> > Please note that LPC MC topics are expected to cover work in progress
> > or at the concept stage.  They are not supposed to be about work that
> > has been done already.
>
> Sounds good. What would be the time slot for one presentation?

That depends on the number of topics.  Usually it has been around 25 -
30 minutes.
