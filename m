Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 634B34BA9CB
	for <lists+linux-pm@lfdr.de>; Thu, 17 Feb 2022 20:29:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245179AbiBQT3R (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 17 Feb 2022 14:29:17 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:47370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232139AbiBQT3Q (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 17 Feb 2022 14:29:16 -0500
Received: from mail-yb1-f182.google.com (mail-yb1-f182.google.com [209.85.219.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5523A1133C4;
        Thu, 17 Feb 2022 11:29:01 -0800 (PST)
Received: by mail-yb1-f182.google.com with SMTP id v63so15063420ybv.10;
        Thu, 17 Feb 2022 11:29:01 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=qm71u0lTCBuIvlmVJOVjj1OyfdzOPEJNDkL3dkmwu1o=;
        b=KxdsRMqBpiJA0xxvyJM2d28E2tvoKOSxgne9BaW6i+QNtGYc4g3/DSSW21y7eZAkZs
         m87n/250vz4BN7PBbfXWQIpdElzB4rf+oZnyNvflTygw0LUiqhas9J7lBMdFepNtpx5+
         Sa4VhjRurrcYdBuAHGHN24SpD3ARLiJYpcgD4GhRCN24N64+i2jHa0poCbdbLS3J6OM6
         A89+idI4uVoKoW+ttujOqVIuXOT+Wqz+je6sn5E33lAmsaHJQgZX7b52tHzY5t7Zk8Tj
         qgvgVlbwCxcVGmRdjU23GuUZaUxwpmuCL3v2gVkhbtlrXlVRDHCPpvOt7kRD1BpfqJhm
         4hkw==
X-Gm-Message-State: AOAM531v9T3Tc0+TXw033HtvLWGwWeyx3gU4/8NPHoEucoZRPoDwMycG
        Gdwes6WBV/QfgRmFYspxxkCMUkTdVcKHiOGFJRIxTCj4
X-Google-Smtp-Source: ABdhPJx/fFFpegIzC4JcUg9AmBRpEbZMysUsqcdzm1QMfO+9Jg1raDXejtVRq44X5W0dC5YSSBhiJRofJodhNV2GbDc=
X-Received: by 2002:a25:bbc1:0:b0:610:b4ce:31db with SMTP id
 c1-20020a25bbc1000000b00610b4ce31dbmr3821787ybk.482.1645126140430; Thu, 17
 Feb 2022 11:29:00 -0800 (PST)
MIME-Version: 1.0
References: <3aaa74cc6e0714cfc8ba4f729efbe8cc5b443eba.camel@intel.com>
In-Reply-To: <3aaa74cc6e0714cfc8ba4f729efbe8cc5b443eba.camel@intel.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Thu, 17 Feb 2022 20:28:49 +0100
Message-ID: <CAJZ5v0j405cSudAq8fvTDO6fMxJECvvgjUba-hSVaJdwL1BCwQ@mail.gmail.com>
Subject: Re: [GIT PULL]: tools/power/x86/intel-speed-select pull request for 5.18-rc1
To:     "Pandruvada, Srinivas" <srinivas.pandruvada@intel.com>
Cc:     "rafael@kernel.org" <rafael@kernel.org>,
        "hdegoede@redhat.com" <hdegoede@redhat.com>,
        "mgross@linux.intel.com" <mgross@linux.intel.com>,
        "prarit@redhat.com" <prarit@redhat.com>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "daniel.lezcano@linaro.org" <daniel.lezcano@linaro.org>,
        "platform-driver-x86@vger.kernel.org" 
        <platform-driver-x86@vger.kernel.org>,
        "srinivas.pandruvada@linux.intel.com" 
        <srinivas.pandruvada@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Thu, Feb 17, 2022 at 8:07 PM Pandruvada, Srinivas
<srinivas.pandruvada@intel.com> wrote:
>
> Hi Rafael,
>
> Changes on top of
> https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git
> thermal-hfi
>
>
> The following changes since commit
> c95aa2bab974394809edea28690f6504a15791b6:
>
>   thermal: intel: hfi: INTEL_HFI_THERMAL depends on NET (2022-02-10
> 20:58:24 +0100)
>
> are available in the Git repository at:
>
>   https://github.com/spandruvada/linux-kernel.git intel-sst-thermal
>
> for you to fetch changes up to
> f3874e96fad596cd2c2441802be7e1d0c9fa8677:
>
>   tools/power/x86/intel-speed-select: v1.12 release (2022-02-17
> 10:57:38 -0800)
>
> ----------------------------------------------------------------
> Srinivas Pandruvada (3):
>       tools/power/x86/intel-speed-select: OOB daemon mode
>       tools/power/x86/intel-speed-select: HFI support
>       tools/power/x86/intel-speed-select: v1.12 release
>
>  tools/power/x86/intel-speed-select/Build         |   2 +-
>  tools/power/x86/intel-speed-select/Makefile      |  10 ++-
>  tools/power/x86/intel-speed-select/hfi-events.c  | 309
> +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
> ++++++++++++
>  tools/power/x86/intel-speed-select/isst-config.c |  54 ++++++++++++---
>  tools/power/x86/intel-speed-select/isst-daemon.c | 244
> +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
>  tools/power/x86/intel-speed-select/isst.h        |  13 ++++
>  6 files changed, 617 insertions(+), 15 deletions(-)
>  create mode 100644 tools/power/x86/intel-speed-select/hfi-events.c
>  create mode 100644 tools/power/x86/intel-speed-select/isst-daemon.c

Merged into the thermal-hfi branch and pushed out.

Next time I would appreciate adding a concise summary of the changes
to the pull request, so that I can add it to the merge commit log.

Thanks!
