Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 15AF167CB0F
	for <lists+linux-pm@lfdr.de>; Thu, 26 Jan 2023 13:45:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232982AbjAZMpz (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 26 Jan 2023 07:45:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229729AbjAZMpx (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 26 Jan 2023 07:45:53 -0500
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C66659992
        for <linux-pm@vger.kernel.org>; Thu, 26 Jan 2023 04:45:50 -0800 (PST)
Received: by mail-pf1-x432.google.com with SMTP id u5so687210pfm.10
        for <linux-pm@vger.kernel.org>; Thu, 26 Jan 2023 04:45:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=sQBrpKdtF81iXahPtF6gU+IPWtlOgCZq7sNUlQBczDo=;
        b=bMI2xEvHCOBw/DZewO0k/Ohq8kIIP0JsaF9SK+iKCGjS02Wctxn9Cpbg7nMZTWw4eo
         XMnIG7omfgGfipSH/PwDeD2VN9IbaN33PADGKe7AcdrD6rNcHGvT47rsach+HUEljG11
         5onzj/nepw/GneyCzttuxs+dCX4TrpY7Qo2m4EwaI7DShRo/h9jt/7IrbPPSRJ6yRP8s
         rEEuKGWyI8Kaivq9ZRD4r4TddEwUBMmNPsL5gX2Ll5Wo/ek0aXFrJvp43pbAk5mLbujN
         p4XUwrThc4HV+9qvC8W+r1UfftvM/s+cBSCOkoURSaQHwe/EOwG0H6oXugxuUTu3FXgB
         DP7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=sQBrpKdtF81iXahPtF6gU+IPWtlOgCZq7sNUlQBczDo=;
        b=4oAFBnnW2fyVUnW3dUz9fa7laiZTZv0TbENAhkYtysIbkga3xXgLZYJZDDCB9M5oTY
         SIwhMb924iCT73WhXVigsAvpKSaz9+G0axE2cGzaM8Wsy2p4sPNH3QZw8edxVVhc3EVW
         5K84tgBQufjA3Wn45B7X/3WBFd8ajcF27Zl0IrRTyXtd94OpzRsVplDQplu8LDssjGVN
         fhCGjTnpONypDa7Dc33dRGGqTN/ENRu1MAobWAk1yg+U4PKlgevHxkoobtQMfImlfUMw
         0XKvp0yw5+hjZ6qcq82TvSaIyKzpTOXWgQmAJjfp+7IIo5V69TLLXC48tXcGqREdwnTh
         3BYg==
X-Gm-Message-State: AO0yUKW3OYVfmQdkLksPqRU7yxYIsAWxX+wC/Tk6Eqgs7l4WAlSzwdrA
        kHRPS57aRoZPntalTq3PpJNzHl7y9Nhg3d4s1ccXwA==
X-Google-Smtp-Source: AK7set9GuXW5qS1QMdZByaefsiV9jzqn+8eQhW82mxF+fn13Cl4JPjXgS1YfrESUzXLoFDvulLlEMDcFbmdOeUlwdNQ=
X-Received: by 2002:a63:a5c:0:b0:4d9:8f35:e0c with SMTP id z28-20020a630a5c000000b004d98f350e0cmr858530pgk.89.1674737148966;
 Thu, 26 Jan 2023 04:45:48 -0800 (PST)
MIME-Version: 1.0
References: <20230125113418.455089-1-krzysztof.kozlowski@linaro.org> <ac3ed1da-fcd1-d8e9-7770-8a047f0e392d@linaro.org>
In-Reply-To: <ac3ed1da-fcd1-d8e9-7770-8a047f0e392d@linaro.org>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Thu, 26 Jan 2023 13:45:12 +0100
Message-ID: <CAPDyKFr9ePUvi-h_jJByrfsBKp+Mu+oyn=qcgp=Ta_jjygEeLw@mail.gmail.com>
Subject: Re: [PATCH v4] cpuidle: psci: Do not suspend topology CPUs on PREEMPT_RT
To:     Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Sudeep Holla <sudeep.holla@arm.com>, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Adrien Thierry <athierry@redhat.com>,
        Brian Masney <bmasney@redhat.com>,
        linux-rt-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Wed, 25 Jan 2023 at 17:46, Daniel Lezcano <daniel.lezcano@linaro.org> wrote:
>
>
> Hi Krzysztof,
>
>
> On 25/01/2023 12:34, Krzysztof Kozlowski wrote:
> > The runtime Power Management of CPU topology is not compatible with
> > PREEMPT_RT:
> > 1. Core cpuidle path disables IRQs.
> > 2. Core cpuidle calls cpuidle-psci.
> > 3. cpuidle-psci in __psci_enter_domain_idle_state() calls
> >     pm_runtime_put_sync_suspend() and pm_runtime_get_sync() which use
> >     spinlocks (which are sleeping on PREEMPT_RT).
> >
> > Deep sleep modes are not a priority of Realtime kernels because the
> > latencies might become unpredictable.  On the other hand the PSCI CPU
> > idle power domain is a parent of other devices and power domain
> > controllers, thus it cannot be simply skipped (e.g. on Qualcomm SM8250).
> >
> > Disable the idle callbacks in cpuidle-psci and mark the domain as
> > always on.  This is a trade-off between making PREEMPT_RT working and
> > still having a proper power domain hierarchy in the system.
>
> Wouldn't make sense to rely on the latency constraint framework ?

The main problem is that for runtime PM there is a per device spinlock
being used, which becomes a sleepable lock on PREEMPT_RT.

In other words, the only simple solution is to avoid the calls to
runtime PM in the idle path.

[...]

Kind regards
Uffe
