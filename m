Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7018615A36D
	for <lists+linux-pm@lfdr.de>; Wed, 12 Feb 2020 09:38:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728488AbgBLIig (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 12 Feb 2020 03:38:36 -0500
Received: from mail-vs1-f65.google.com ([209.85.217.65]:35594 "EHLO
        mail-vs1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728478AbgBLIig (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 12 Feb 2020 03:38:36 -0500
Received: by mail-vs1-f65.google.com with SMTP id x123so983129vsc.2
        for <linux-pm@vger.kernel.org>; Wed, 12 Feb 2020 00:38:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=IHqIf5M4paWRQqNMsUfuUrTYwOKU9w45APayE5qNVvs=;
        b=vUVL+4E/ghJvS34Gw+Yj3FC8/V75VOYPhxzpJQgUT6tMqtb9vakYs2GI0k47MFdUq3
         hQ1YQcUXc0R3WTcUgNgO26qcrxwrfbqBk8S03K72PonAAM+wa+C7YAI/+/h1u75Nz7/6
         bXs/K7tD0boEOfEK1j5rFSpxQ77Uht/WRcvdkmaS3Qj/Koerbc7RXmgQiNpT2BqMIviV
         c1aPNJQ2gzdl+kOtoNYtLEv30u82JjAHSQ6Ha2Pvzj9QtPHdRuICR1mVFVspd4LEEt2F
         HLSKF5IedVsH0ZCyqPErwfyRP6aU38jYRni922g7VV6DWoY0s4Hj+QxK6PLixQimyXkh
         AKRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=IHqIf5M4paWRQqNMsUfuUrTYwOKU9w45APayE5qNVvs=;
        b=rG7e8ioct3AxFnugQTuuWoukijlJ7dl3X7sp++RGz/D1MSyN29A6rF+FXCrsIzekUW
         GKLkEg3nuaL62IG42UwSlZdYlCul3UNSRcxr4FhFB96FyUWZwRNQQ0lRiHc2QzeZ7bG0
         YyjcsIOEriSjQcibtTsgJYY5WkSoAHkfizcQP4mnXBBPhku/kfyP0kd5++CLYYNdmRvc
         sv1IpqX9SBhhmsWkdw0CA5ji80kb4D22s1xTfBvnwyQR2zxvT7sqOqX4N+PAs83SmaPg
         ZW5Bq+sEgmsUI3RYqCnoZQq6vgoYWZ1ZA7fVZDBVwOVx3SUoeO4cqOjV4PIEGIP2jC6c
         irJg==
X-Gm-Message-State: APjAAAVAP13udAYqOOA8OAHoVGGscX6T7YZgj2v5UFyxJjiGbt0Nf9TM
        hDjTWKuMzE5yhHZf2wiFz/C+Sa1UISx2FMASOS3bmQ==
X-Google-Smtp-Source: APXvYqxbfXdatWIwHYUuqWnHyNbcSLk+ziuVt3G+MpDqiO/zFVXyM6TIy0v6BZusgksxp8Nbds6bc8i2h3q/OgH6Deg=
X-Received: by 2002:a67:f591:: with SMTP id i17mr605202vso.34.1581496715171;
 Wed, 12 Feb 2020 00:38:35 -0800 (PST)
MIME-Version: 1.0
References: <1654227.8mz0SueHsU@kreacher>
In-Reply-To: <1654227.8mz0SueHsU@kreacher>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Wed, 12 Feb 2020 09:37:59 +0100
Message-ID: <CAPDyKFrcRzDE9=A28uf2sp=zaJpbEGrW5jm3L6CBVVc=GaL-Jg@mail.gmail.com>
Subject: Re: [PATCH 00/28] PM: QoS: Get rid of unuseful code and rework CPU
 latency QoS interface
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc:     Linux PM <linux-pm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Amit Kucheria <amit.kucheria@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Wed, 12 Feb 2020 at 00:39, Rafael J. Wysocki <rjw@rjwysocki.net> wrote:
>
> Hi All,
>
> This series of patches is based on the observation that after commit
> c3082a674f46 ("PM: QoS: Get rid of unused flags") the only global PM QoS class
> in use is PM_QOS_CPU_DMA_LATENCY, but there is still a significant amount of
> code dedicated to the handling of global PM QoS classes in general.  That code
> takes up space and adds overhead in vain, so it is better to get rid of it.
>
> Moreover, with that unuseful code removed, the interface for adding QoS
> requests for CPU latency becomes inelegant and confusing, so it is better to
> clean it up.
>
> Patches [01/28-12/28] do the first part described above, which also includes
> some assorted cleanups of the core PM QoS code that doesn't go away.
>
> Patches [13/28-25/28] rework the CPU latency QoS interface (in the classic
> "define stubs, migrate users, change the API proper" manner), patches
> [26-27/28] update the general comments and documentation to match the code
> after the previous changes and the last one makes the CPU latency QoS depend
> on CPU_IDLE (because cpuidle is the only user of its target value today).
>
> The majority of the patches in this series don't change the functionality of
> the code at all (at least not intentionally).
>
> Please refer to the changelogs of individual patches for details.
>
> Thanks!

A big thanks for cleaning this up! The PM_QOS_CPU_DMA_LATENCY and
friends, has been annoying me for a long time. This certainly makes
the code far better and more understandable!

I have looked through the series and couldn't find any obvious
mistakes, so feel free to add:

Reviewed-by: Ulf Hansson <ulf.hansson@linaro.org>

Note, the review tag also means, that's fine for you to pick the mmc
patch via your tree.

Kind regards
Uffe
