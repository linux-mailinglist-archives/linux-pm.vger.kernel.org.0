Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 315A4434423
	for <lists+linux-pm@lfdr.de>; Wed, 20 Oct 2021 06:24:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229941AbhJTE0g (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 20 Oct 2021 00:26:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229735AbhJTE0f (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 20 Oct 2021 00:26:35 -0400
Received: from mail-ot1-x329.google.com (mail-ot1-x329.google.com [IPv6:2607:f8b0:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36E63C061746
        for <linux-pm@vger.kernel.org>; Tue, 19 Oct 2021 21:24:22 -0700 (PDT)
Received: by mail-ot1-x329.google.com with SMTP id v2-20020a05683018c200b0054e3acddd91so4628030ote.8
        for <linux-pm@vger.kernel.org>; Tue, 19 Oct 2021 21:24:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:in-reply-to:references:from:user-agent:date:message-id
         :subject:to:cc;
        bh=elvoUBl7XEkbVo1g2RE1z3K+d4jyUSFlULoK7AzhEdQ=;
        b=f1QKTIRCxNZb0itcE4P7vDHamWDkwmiUTe7FxK85ftucfSGYVuGRin5WuQc0AMorfL
         ywKnPZMOlvBzFcunr64r7ASciayJ3Bhpfa/OBAjCWMMlNkBv/A8MWgOA+KANZQ9TFxns
         lxnvWXTkZ3QI3Jky81N9oEkkZISXT/A+S3XkY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:in-reply-to:references:from
         :user-agent:date:message-id:subject:to:cc;
        bh=elvoUBl7XEkbVo1g2RE1z3K+d4jyUSFlULoK7AzhEdQ=;
        b=RbB/uakiskdJU8AEa1c92FHUX5tf5scTo4rm1Qd8GOQcWFSdj4iqV4eZ27DFc1g/b/
         +9su6EMRtAnRssWrYxnggUBG2YAGSgDnJhpl1RyeniQqnVkGqcQKQ4VHqOharfVv+85l
         K3ZSyXPoNqM9TvqUzI41BUPbFrn+mhwvFBFFsR5LCrUbQ95+5HD4M8JuZJjGXsF+RKPn
         XY7pLZSO29p/+z3n34i00MwONf0khfKNf8+sVA9Mn2RujH2BQyhsvwhYIHm0ZzoLQbGQ
         4anmr3a6YYA4+gFeCQ1eAvYy0ymtAO2oPQAqn0UYuA3FPXIf04iPjp0NVU6i6dudiZlK
         9ugQ==
X-Gm-Message-State: AOAM533vfq4c4jJCYSO2neMJ8Wxe/CgI4KB5QcQLQkh5AH/kNJQGJhSI
        ZTQza6fZJvnOxHT8xcGsqN/XPSMwRTOfxMGlFTp9yg==
X-Google-Smtp-Source: ABdhPJxaMZNzxtyBmA4rCXE3sYY70xRGR5VrFGomRibATDr1WeO/j2fA6f2qZduAErjFaES8HxDZ5QCDKXAE3lvSHz0=
X-Received: by 2002:a05:6830:4187:: with SMTP id r7mr8915979otu.126.1634703861597;
 Tue, 19 Oct 2021 21:24:21 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 19 Oct 2021 23:24:21 -0500
MIME-Version: 1.0
In-Reply-To: <20211019154224.624204-1-arnd@kernel.org>
References: <20211019154224.624204-1-arnd@kernel.org>
From:   Stephen Boyd <swboyd@chromium.org>
User-Agent: alot/0.9.1
Date:   Tue, 19 Oct 2021 23:24:21 -0500
Message-ID: <CAE-0n51jb=H=tTusjhQYY09A5B6BVgYWokGoVsSaQUQ+0rtqGA@mail.gmail.com>
Subject: Re: [PATCH 1/3] qcom: spm: allow compile-testing
To:     Arnd Bergmann <arnd@kernel.org>, linux-pm@vger.kernel.org
Cc:     soc@kernel.org, Daniel Lezcano <daniel.lezcano@linaro.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        linux-arm-msm@vger.kernel.org,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>, Andy Gross <agross@kernel.org>,
        Lina Iyer <ilina@codeaurora.org>,
        John Stultz <john.stultz@linaro.org>,
        Maulik Shah <mkshah@codeaurora.org>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@somainline.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Mahesh Sivasubramanian <msivasub@codeaurora.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Stephan Gerhold <stephan@gerhold.net>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        He Ying <heying24@huawei.com>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Quoting Arnd Bergmann (2021-10-19 08:42:02)
> From: Arnd Bergmann <arnd@arndb.de>
>
> ARM_QCOM_SPM_CPUIDLE can be selected when compile-testing on
> other architectures, but this causes a Kconfig warning
> for QCOM_SPM:
>
> WARNING: unmet direct dependencies detected for QCOM_SPM
>   Depends on [n]: ARCH_QCOM [=n]
>   Selected by [y]:
>   - ARM_QCOM_SPM_CPUIDLE [=y] && CPU_IDLE [=y] && (ARM [=y] || ARM64) && (ARCH_QCOM [=n] || COMPILE_TEST [=y]) && !ARM64 && MMU [=y]
>
> Make it possible to also compile-test this one, which can
> be done now that v5.15-rc5 lets you select QCOM_SCM everywhere.
>
> Fixes: a871be6b8eee ("cpuidle: Convert Qualcomm SPM driver to a generic CPUidle driver")
> Fixes: 498ba2a8a275 ("cpuidle: Fix ARM_QCOM_SPM_CPUIDLE configuration")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---

Reviewed-by: Stephen Boyd <swboyd@chromium.org>
