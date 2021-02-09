Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2EBFE3151DF
	for <lists+linux-pm@lfdr.de>; Tue,  9 Feb 2021 15:44:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231475AbhBIOmY (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 9 Feb 2021 09:42:24 -0500
Received: from mail-ot1-f53.google.com ([209.85.210.53]:34037 "EHLO
        mail-ot1-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230260AbhBIOmX (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 9 Feb 2021 09:42:23 -0500
Received: by mail-ot1-f53.google.com with SMTP id y11so17667208otq.1
        for <linux-pm@vger.kernel.org>; Tue, 09 Feb 2021 06:42:07 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=cmKrdxE4CfebwoU7wYZhgQLSXYcPuJnV9rw1A1E5pVQ=;
        b=ac4StYgzvdaRzzffwNaDj/7XeAxXUZml7i0Ae68C7Wir47Temx/Q7krCfcX6v7Lnr7
         3NLGQTdXnpcyHMoNuW4E+/naMUDviQnw9IQI2E+zEioDz9QZxvym9PTJiBHHMO9YeBnH
         P0JXLY9URtoTe+cLtxWT6PgenZHjhfSFnhiy/mYHtZH51u+AbWzLWtT/PQ7Qhzi54uYy
         y5KkREMsCIcQtymxi7U/zh0OslTvFT5Lc1KdG2sZHKV6ACrsLNnxNgXyd9ww88x9cbJ9
         NTobFULbsKvUu8wVX3RyLdTekHxXG6DpZOCSSuNdj0Kf3Cm32974ofbzQpHptDNVxbDQ
         qKlw==
X-Gm-Message-State: AOAM530H4Z0uXp06SBOPMsiEBN+w//E1oLT/r6sLRrM1QvO2mW/r/iW2
        j9jn9oBuF2EyT0bSzIW1YhB5J2EM+SIj/yYTrtfffcKU
X-Google-Smtp-Source: ABdhPJzAIXt5Nxizq+TZMDRxGT+tu2n8tbxdSi+folK1+un3H27unsa8oUIDO/5dFNf0CJ5ky7h95GavmLNilScTlCk=
X-Received: by 2002:a05:6830:1481:: with SMTP id s1mr4698707otq.206.1612881702101;
 Tue, 09 Feb 2021 06:41:42 -0800 (PST)
MIME-Version: 1.0
References: <CGME20210209100206epcas1p25af750e4292a7af7c68b9238e24bca0e@epcas1p2.samsung.com>
 <f0478d74-5539-4ad1-5be0-1aa0b3931f26@samsung.com>
In-Reply-To: <f0478d74-5539-4ad1-5be0-1aa0b3931f26@samsung.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Tue, 9 Feb 2021 15:41:29 +0100
Message-ID: <CAJZ5v0hZ9N3xpjtCG1Fr2MZCQfpyoxwJHk_miqpCMabCZXVLig@mail.gmail.com>
Subject: Re: [GIT PULL] devfreq next for v5.12
To:     Chanwoo Choi <cw00.choi@samsung.com>
Cc:     "Rafael J. Wysocki <rjw@rjwysocki.net>" <rjw@rjwysocki.net>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "Chanwoo Choi (chanwoo@kernel.org)" <chanwoo@kernel.org>,
        =?UTF-8?B?7ZWo66qF7KO8?= <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Tue, Feb 9, 2021 at 11:06 AM Chanwoo Choi <cw00.choi@samsung.com> wrote:
>
> Dear Rafael,
>
> This is devfreq-next pull request for v5.12-rc1. I add detailed description of
> this pull request on the following tag. Please pull devfreq with following updates.
> - tag name : devfreq-next-for-5.12
>
> And OPP maintainer will send the pull request including the following patches:
> [1] [v6,0/3] Add required-opps support to devfreq passive gov
> - https://patchwork.kernel.org/project/linux-pm/cover/20210204081424.2219311-1-hsinyi@chromium.org/
>
> Best Regards,
> Chanwoo Choi
>
> The following changes since commit 5c8fe583cce542aa0b84adc939ce85293de36e5e:
>
>   Linux 5.11-rc1 (2020-12-27 15:30:22 -0800)
>
> are available in the Git repository at:
>
>   git://git.kernel.org/pub/scm/linux/kernel/git/chanwoo/linux.git tags/devfreq-next-for-5.12
>
> for you to fetch changes up to fc1745c0e40cfc98c0bc466b95ddedf28e5019b4:
>
>   PM / devfreq: rk3399_dmc: Remove unneeded semicolon (2021-02-02 16:17:27 +0900)

Pulled, thanks!
