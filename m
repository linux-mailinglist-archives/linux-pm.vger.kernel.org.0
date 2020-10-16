Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A8525290708
	for <lists+linux-pm@lfdr.de>; Fri, 16 Oct 2020 16:18:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2408727AbgJPOSR (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 16 Oct 2020 10:18:17 -0400
Received: from mail-oi1-f193.google.com ([209.85.167.193]:45177 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2395474AbgJPOSR (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 16 Oct 2020 10:18:17 -0400
Received: by mail-oi1-f193.google.com with SMTP id j7so2562985oie.12;
        Fri, 16 Oct 2020 07:18:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=dQ/DB7YEOOz+uQHKJSzCgk0kg/KMTwE6MoDm7Iru7Ww=;
        b=pTYNOY67LKES1D+Rs8MDBivdSMYiJn8V7TRqm77JDKRS5Y7zkeydVzRxNaK4TChtia
         Bk9kD5pOK80tbVrpgZz80e4LigfQEc2Ife99oeN6hHv+9fbfByzxQnkAaaVJ0rzUvJ7d
         yBlsEhOiuSc/Fltwqa0ImbbWmJRlwqN7o1+cSsi/fHx+HRtLdvS3PNbQ7+K9Qm4oVaY9
         FD1pMQQAVW212cbMlwRl/zK0WQ3tDVwjTtbaeU6LmRTYleH9BwVZbo2oNGkSVoNxwzGa
         syq0nj7hNQl5cDNQTYAqbuujzWnY5bpgxut3SfBBU1ydK3nOMhomYXMNF58Of6JPebEa
         6KFg==
X-Gm-Message-State: AOAM531py+AyJM2sfTkukL5BdsHVGMzMKMbj2giqLXPkv8H/ABH+3L6m
        VVVbQ1EmmbPRguqT6WrKhGyqdO3IngUnnai6LzQ=
X-Google-Smtp-Source: ABdhPJyqX3U8GqwKg9yvTxEIHBV0GJ3ykA10HHPwHxjK/JNlQIM9xMrzIbzx9vZAJJWwAjoBMzmPi2AxMYP+ELYcfhs=
X-Received: by 2002:aca:5256:: with SMTP id g83mr2686759oib.71.1602857896605;
 Fri, 16 Oct 2020 07:18:16 -0700 (PDT)
MIME-Version: 1.0
References: <396f8b57-50f5-cd20-7a32-40785e669048@linuxfoundation.org> <8acb2352-579f-5a5a-840c-d9330807b3f7@linuxfoundation.org>
In-Reply-To: <8acb2352-579f-5a5a-840c-d9330807b3f7@linuxfoundation.org>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Fri, 16 Oct 2020 16:18:05 +0200
Message-ID: <CAJZ5v0ha_WHK_mtcT9wrwSkXM_ebpLW_QMNoeprA-=fhXBAVaQ@mail.gmail.com>
Subject: Re: [GIT PULL] cpupower update for Linux 5.10-rc1
To:     Shuah Khan <skhan@linuxfoundation.org>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Thomas Renninger <trenn@suse.de>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Tue, Oct 13, 2020 at 7:15 PM Shuah Khan <skhan@linuxfoundation.org> wrote:
>
> On 10/13/20 11:13 AM, Shuah Khan wrote:
> > Hi Rafael,
> >
> > Please pull the following cpupower update for Linux 5.10-rc1 or for
> > a later rc.
> >
> > This cpupower update for Linux 5.10-rc1 consists of minor fixes for
> > spelling and speeding up generating git version string which will
> > in turn speedup compiles.
> >
> > diff is attached.
> >
>
> Sorry. Here is the diff.

Pulled, thanks!
