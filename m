Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2361472BF62
	for <lists+linux-pm@lfdr.de>; Mon, 12 Jun 2023 12:43:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232770AbjFLKnN (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 12 Jun 2023 06:43:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232749AbjFLKm5 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 12 Jun 2023 06:42:57 -0400
Received: from mail-yw1-x112c.google.com (mail-yw1-x112c.google.com [IPv6:2607:f8b0:4864:20::112c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82B26A85B
        for <linux-pm@vger.kernel.org>; Mon, 12 Jun 2023 03:27:27 -0700 (PDT)
Received: by mail-yw1-x112c.google.com with SMTP id 00721157ae682-56cf32f5bf8so21402947b3.3
        for <linux-pm@vger.kernel.org>; Mon, 12 Jun 2023 03:27:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1686565646; x=1689157646;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=7e8+yY+6VnFiyn20cskN6gGyYmdrhPGpnmg4w6IEwoQ=;
        b=VziyCl8bSsxE2IVLUDm9vBcTw5I2pmEjfat9V2goKs5pJ0/4q2FCW9Rrz/Wp98sHXF
         kNu0OKvOPqTH4a4tpfgCv+o+rbVUN37lcboXRO0RFcu196iJYg3aIrw3RIS8sBO1fJlj
         lANsaM9N0pbhsf15bXS4GyzNKr5Xo4u/FiPuP+R7/elVAug4WurJ0umpr3eIDOeLEZ4C
         +zwIL1nWFUvFTW6weUbXIiGvyvY1zIdtYyh5VuwvHf+D36QR5h4WtLdyOTz13a8cIWJH
         TDi1UaiYyZ55xgg329ExCDDe9etCss6PMrOc9v35UKzROWS+1MCtWSMbnZ9VqP2vU+3j
         wpjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686565646; x=1689157646;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7e8+yY+6VnFiyn20cskN6gGyYmdrhPGpnmg4w6IEwoQ=;
        b=H3v3yVGLNaRdx10Q2r66pKtb2cQNdhXsbT8WPSpQwUJd7SFJwLo7tfvd9XLHDNoM/c
         mU71mDteeaqmmYGxqzAtjAPTYwnsMYaXtnJIOrxzpFbwCy99dieVCoLTFA+Uy4YUQysf
         jIdoN2YN2SpqJBCYkjJ8L/VQjRFUnjIdH/2eFDQbeenp4w0df1JaMZtILLVU5jsIP5P4
         KsX8HJj5jQ2yeQ6r+vgRlOHqMceQzLpquYmmCBrzadY3PjRRvX17U9qhCXvE0vX4aSl/
         AMxQJ2zDCYECRzEym4Fm5o0R3n5FJR2m9/J1ZVha1WAFd2RV1kCiBQG8TdStCM5m+V5L
         JrLg==
X-Gm-Message-State: AC+VfDzEOAn7/Ie3U1djcgttC/LlgNjlGIBNHraFZZvbrA7XjkLoSubh
        2bYbWd5tJxAM5JNupSKHT7dM2RtvSnhun1j0ufhD2g==
X-Google-Smtp-Source: ACHHUZ7qTSAphNLSxe8ogbKj8du2SJ+2Z4Qs8asZ1CvsBg8d8HrcWsNIeMaTVM7S7IhHs94tK072MwXgnWl37n3oopo=
X-Received: by 2002:a0d:d3c5:0:b0:569:770d:c9be with SMTP id
 v188-20020a0dd3c5000000b00569770dc9bemr10380583ywd.41.1686565646687; Mon, 12
 Jun 2023 03:27:26 -0700 (PDT)
MIME-Version: 1.0
References: <20230608085544.16211-1-quic_tnimkar@quicinc.com>
In-Reply-To: <20230608085544.16211-1-quic_tnimkar@quicinc.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Mon, 12 Jun 2023 12:26:50 +0200
Message-ID: <CAPDyKFqhVkMH42Vz0+a62j5kFh+R_CvGrcSU7hxoW__tjOhfLw@mail.gmail.com>
Subject: Re: [PATCH 0/2] Add provision to keep idle state disabled
To:     Tushar Nimkar <quic_tnimkar@quicinc.com>
Cc:     "Rafael J . Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        linux-pm@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, quic_lsrao@quicinc.com,
        quic_mkshah@quicinc.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Thu, 8 Jun 2023 at 10:56, Tushar Nimkar <quic_tnimkar@quicinc.com> wrote:
>
> CPUidle already has CPUIDLE_FLAG_OFF to keep idle state disabled,
> Lets extend the support to set this flag using device tree.
>
> This allows to keep an idle state disabled and they can be enabled back using
> sysfs after certain point using below command.
>
> echo N > /sys/devices/system/cpu/cpuX/cpuidle/stateX/disable
>
> This helps in cases where vendors want to keep cpuidle off until home
> screen comes up. In the past attempt was done at [1] but it was not considered
> safe option to export cpu_idle_poll_ctrl().
>
> [1] https://patchwork.kernel.org/project/linux-arm-msm/patch/1637831676-32737-1-git-send-email-quic_mkshah@quicinc.com/

Before considering this, I don't recall if I ever received a reply to
my earlier suggestion to the above thread. So, let me repeat my
question.

I am wondering if a similar improvement can be achieved by
modularizing the cpuidle-psci driver. If insmodding it after the
homescreen, we allow only ARM WFI during boot. This should achieve the
similar results as we get with $subject series, right?

[...]

>
> Thanks,
> Tushar Nimkar.
>
> Tushar Nimkar (2):
>   dt-bindings: cpu: idle-states: Add idle-state-disabled property
>   cpuidle: dt: Add support to keep idle state disabled
>
>  Documentation/devicetree/bindings/cpu/idle-states.yaml | 8 ++++++++
>  drivers/cpuidle/dt_idle_states.c                       | 3 +++
>  2 files changed, 11 insertions(+)
>

Kind regards
Uffe
