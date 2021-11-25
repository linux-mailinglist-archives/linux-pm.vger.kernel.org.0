Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 95DA345DFA7
	for <lists+linux-pm@lfdr.de>; Thu, 25 Nov 2021 18:26:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347836AbhKYR2j (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 25 Nov 2021 12:28:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348691AbhKYR0j (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 25 Nov 2021 12:26:39 -0500
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2286C06175D
        for <linux-pm@vger.kernel.org>; Thu, 25 Nov 2021 09:16:27 -0800 (PST)
Received: by mail-pj1-x1030.google.com with SMTP id gf14-20020a17090ac7ce00b001a7a2a0b5c3so8165887pjb.5
        for <linux-pm@vger.kernel.org>; Thu, 25 Nov 2021 09:16:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=telus.net; s=google;
        h=from:to:cc:references:in-reply-to:subject:date:message-id
         :mime-version:content-transfer-encoding:content-language
         :thread-index;
        bh=ZcJ/rON8wGKNLK176u9S8NH6zRHqqLGaIZ+pfZTgUPw=;
        b=KYBujD2+qTiES1emT1f3fzJuzyE2lUUnM/LTtkjBnxBAUhT+zffA43ZqQYFgTgvW3Q
         VuZlDKrnoghBs6ucT88wfDb3XfbT5Fx7DqdICQcsHfUeok1e27YohMC4d+uc59ka8t7O
         yzcQomsiXRkIxYyVsjQlPSty7UqL/fXxj7qrd4WzWH44SOT8lr3RvAu1C8NhDm1aOv80
         Hwu4eZ32bVxA6r1FqqF+7nKM+Mxfd923iJK3+UpmHMYLZURLl8OG5zbcshJT6cFsuTKA
         fn/7GJJzXx5GirjTMD0IeDST+KNBmCSs3PzRtcJziIedv27hNJ7EehzRd6Wg38Zzi/yW
         osLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:references:in-reply-to:subject:date
         :message-id:mime-version:content-transfer-encoding:content-language
         :thread-index;
        bh=ZcJ/rON8wGKNLK176u9S8NH6zRHqqLGaIZ+pfZTgUPw=;
        b=ckJUgVgKpmLjPM+etL17rmUWSt3S04s3E/jXPzdP3AoSC2h3ffk43rTJQE97nw72tT
         9QvpI5iYLIkbDZDHnbYejUNrpjV+eNTl1aYrpfp/UAqEB9SHwIHQCXVpeJsG+fUG3/CH
         2jCQgDRyrdT0gHBWZhJgqnXxC5JwIVhiozr1DfqN6m4b0bstguIFZz3MCni+S5EqgC5y
         U3WJEptJqrIRATQEw4paEAKAOAMmuJt9XS0WQD6va/BnxTI9JwLWULJ7iSsqiylzlrq6
         7QRl5flNwTKqvTTVD7L+5fJ1AH+OWTTmyieYVuezECoXrOgA8LPV7ttEzD2S2U1GL3kl
         L8Qg==
X-Gm-Message-State: AOAM532/+goRydiPgaFkUPrJqd934g9BjUeJ54GrCtaZgo/J2lf3lsqS
        wIMxWoSqVGIhN452amSC4qKaYA==
X-Google-Smtp-Source: ABdhPJxwCha2L7wGusNFfYXQo9nPmyDSPKWcNCr9tjNDLTishpMt2VdlrMjkVW0M4ibOqj5ePn2+Lg==
X-Received: by 2002:a17:902:b712:b0:143:72b7:4096 with SMTP id d18-20020a170902b71200b0014372b74096mr31733673pls.25.1637860587337;
        Thu, 25 Nov 2021 09:16:27 -0800 (PST)
Received: from DougS18 ([173.180.45.4])
        by smtp.gmail.com with ESMTPSA id b10sm4044140pfl.200.2021.11.25.09.16.26
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 25 Nov 2021 09:16:26 -0800 (PST)
From:   "Doug Smythies" <dsmythies@telus.net>
To:     "'Maulik Shah'" <quic_mkshah@quicinc.com>,
        <bjorn.andersson@linaro.org>, <rafael@kernel.org>,
        <daniel.lezcano@linaro.org>
Cc:     <linux-arm-msm@vger.kernel.org>, <linux-pm@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <ulf.hansson@linaro.org>,
        <quic_lsrao@quicinc.com>, <rnayak@codeaurora.org>,
        "Doug Smythies" <dsmythies@telus.net>
References: <1637830481-21709-1-git-send-email-quic_mkshah@quicinc.com>
In-Reply-To: <1637830481-21709-1-git-send-email-quic_mkshah@quicinc.com>
Subject: RE: [PATCH 0/4] Allow cpuidle governors to be compiled as modules
Date:   Thu, 25 Nov 2021 09:16:25 -0800
Message-ID: <000601d7e220$2dd78990$89869cb0$@telus.net>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Content-Language: en-ca
Thread-Index: AQGT+IG2EWhj5x7yn247xTDGojnxHKycPHaA
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi All,

I realize that previous replies render this one useless
but sending anyhow.

On 2021.11.25 00:55 Maulik Shah wrote:

> This series makes changes to allow cpuidle governors
> menu, ladder and teo to compiled as modules when
> building with allmodconfig.

One current issue with governors being available as modules
is that they don't appear on the available governors list unless
they are loaded.

Example with this patch set, all done as modules:

~$ grep . /sys/devices/system/cpu/cpuidle/*
/sys/devices/system/cpu/cpuidle/current_driver:none
/sys/devices/system/cpu/cpuidle/current_governor:none
/sys/devices/system/cpu/cpuidle/current_governor_ro:none

However, and based on my systems power consumption,
some sort of idle must be running.

~$ echo teo | sudo tee /sys/devices/system/cpu/cpuidle/current_governor
teo
tee: /sys/devices/system/cpu/cpuidle/current_governor: Invalid argument

~$ sudo modprobe teo
~$ grep . /sys/devices/system/cpu/cpuidle/*
/sys/devices/system/cpu/cpuidle/available_governors:teo
/sys/devices/system/cpu/cpuidle/current_driver:none
/sys/devices/system/cpu/cpuidle/current_governor:teo
/sys/devices/system/cpu/cpuidle/current_governor_ro:teo

By the way, for the cpufreq stuff, while governors that
are actually available, but are modules, changing to them
without first force loading the module works:

$ grep . /sys/devices/system/cpu/cpu*/cpufreq/scaling_available_governors
/sys/devices/system/cpu/cpu0/cpufreq/scaling_available_governors:performance schedutil
/sys/devices/system/cpu/cpu10/cpufreq/scaling_available_governors:performance schedutil
...

$ echo ondemand | sudo tee /sys/devices/system/cpu/cpu*/cpufreq/scaling_governor
ondemand

$ grep . /sys/devices/system/cpu/cpu*/cpufreq/scaling_available_governors
/sys/devices/system/cpu/cpu0/cpufreq/scaling_available_governors:ondemand performance schedutil
/sys/devices/system/cpu/cpu10/cpufreq/scaling_available_governors:ondemand performance schedutil

... Doug


