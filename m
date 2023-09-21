Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E45E7A9832
	for <lists+linux-pm@lfdr.de>; Thu, 21 Sep 2023 19:32:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229826AbjIURca (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 21 Sep 2023 13:32:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230383AbjIURcN (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 21 Sep 2023 13:32:13 -0400
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C08662D203
        for <linux-pm@vger.kernel.org>; Thu, 21 Sep 2023 10:06:20 -0700 (PDT)
Received: by mail-lf1-x12d.google.com with SMTP id 2adb3069b0e04-502e6d632b6so2041716e87.0
        for <linux-pm@vger.kernel.org>; Thu, 21 Sep 2023 10:06:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1695315978; x=1695920778; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=asW3V0UfBRcaqJZf0dqMocPiGq1jVGiQw3a4sepePiw=;
        b=RQX1Hbf6QpYzr5VxDn4jvHJqpHk4O90otjVUObD/pbBtNJSs5b1aKiG+M96XSpD+Ri
         zjwak0k9Hord1C/y21cAoWP8bkTnNN0aCIAwfo1Y5cHgGnPLzHS/13w4/k7OrxTO0TsK
         I7TAZBkfpEwpMOSMGemSCXUQtBGcjp11noS73+Jyl5hHtpFIvHf5YLMUly139gxr2ImC
         y7TozNIvR/XI3GfiZ1YhQzcuu2su1MsnyDViod47vh5nKxfByIJFYsMhxMH/KrqV09GM
         rGWsLG8CeV9DsBg94bYXvZNPDNjQsd+WyyPLVsjVt3P0HQ46TNwBz1GscnXdzjbLRlb5
         CSKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695315978; x=1695920778;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=asW3V0UfBRcaqJZf0dqMocPiGq1jVGiQw3a4sepePiw=;
        b=Hiby6dwQZF/erlDAg89hUuyUiWJ/h8l2AARv1Km6XqjJaUsFkiVDlF6nHWW3l1C3dh
         LrRWR5vIu5Dx+mg0O5kIdRFz2fiGgONnRh8Vrp0f2BtU+I/KPUEQ3rab0T4ZBACtiq9z
         goRKeXOJtLtMWAqKcr5NAs+KSz07twfEuhEPAJq1X6QXI4u/JCq8G2BJeWGk0nWg52Cg
         3FE54sGWWN5LoUJH2rOmAog+BcbyKKcdtes7HmLcvo5LnvdkPTrGbx3ePbIaY3Lda74W
         6FK8Vuse2EAa6h1Ue0AbTmbSC36aFC7YBynB25T5L+SIA8pa5VH3cKFtUrTZs0JjFIqR
         pjiA==
X-Gm-Message-State: AOJu0YwOtiZyY/M972X+n0gwK+ZtlXUSZBl/nZmS561nfCNfEYLwaLpr
        MaCXAmZr2Qu0peFsc1mW7KKMHFEU4TGMMqc63zBfC4ET2PBdtFRLE6M=
X-Google-Smtp-Source: AGHT+IHKm6xOhbvVAKAE+SKogQZbnbEOCIh1XMXLgsfBvyvWuPOrr7N8DqDuN/nUXgGvHylRHerRg2cumFt/fm+7dMg=
X-Received: by 2002:a05:6512:3133:b0:4fd:d470:203b with SMTP id
 p19-20020a056512313300b004fdd470203bmr4350086lfd.69.1695306540696; Thu, 21
 Sep 2023 07:29:00 -0700 (PDT)
MIME-Version: 1.0
References: <20230825112633.236607-1-ulf.hansson@linaro.org> <20230825112633.236607-4-ulf.hansson@linaro.org>
In-Reply-To: <20230825112633.236607-4-ulf.hansson@linaro.org>
From:   Viresh Kumar <viresh.kumar@linaro.org>
Date:   Thu, 21 Sep 2023 16:28:43 +0200
Message-ID: <CAKohpo=qNen_D_8nKATwBJnN9frR3dmBtfajy3Gzw7QKfSRMjw@mail.gmail.com>
Subject: Re: [PATCH v3 03/13] cpufreq: scmi: Prepare to move OF parsing of
 domain-id to cpufreq
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Sudeep Holla <sudeep.holla@arm.com>,
        Cristian Marussi <cristian.marussi@arm.com>,
        Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Nikunj Kela <nkela@quicinc.com>,
        Prasad Sodagudi <psodagud@quicinc.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Fri, 25 Aug 2023 at 13:27, Ulf Hansson <ulf.hansson@linaro.org> wrote:
>
> The OF parsing of the clock domain specifier seems to better belong in the
> scmi cpufreq driver, rather than being implemented behind the generic
> ->device_domain_id() perf protocol ops.
>
> To prepare to remove the ->device_domain_id() ops, let's implement the OF
> parsing in the scmi cpufreq driver instead.
>
> Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
> ---
>
> Changes in v3:
>         - Re-based.
>
> ---
>  drivers/cpufreq/scmi-cpufreq.c | 19 +++++++++++++++----
>  1 file changed, 15 insertions(+), 4 deletions(-)

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
