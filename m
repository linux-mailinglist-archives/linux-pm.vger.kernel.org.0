Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB5A47AA30B
	for <lists+linux-pm@lfdr.de>; Thu, 21 Sep 2023 23:46:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232749AbjIUVqc (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 21 Sep 2023 17:46:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232723AbjIUVqR (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 21 Sep 2023 17:46:17 -0400
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A17AA4E5C6
        for <linux-pm@vger.kernel.org>; Thu, 21 Sep 2023 10:26:51 -0700 (PDT)
Received: by mail-ed1-x531.google.com with SMTP id 4fb4d7f45d1cf-532e6f8125cso1423141a12.3
        for <linux-pm@vger.kernel.org>; Thu, 21 Sep 2023 10:26:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1695317209; x=1695922009; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=vckO2Ou8wXEnI7d8lHB0QrnLKODbimrd2Exu1O4oi7I=;
        b=bdDPjG1hPL22M6Y/ATc10RRT7MSEAUDZzQg2KUKofoV7YoCoG2mAqDOHcmU5ZDKdKW
         EcIfXfKBzw+Vx7AbbefGb1dctDB3SdqUZy60PeA47RRvffsc9h2fcuY7VTXnFOIhYXPU
         Q7bfmWIN7eLdU6x0RTeaoy+n4cfcAwqqhxKbNGwFRNEY05S40PjmaRPKgYa8q3Gc+pfd
         Fb++6/9pthrQI37A4LlUNuK2XCAieLEZlEFhFpsS+pw2BddcvT4EkFgck9lNQ6qIr5gL
         7uagv/BZ1wd9edwAsWNFqtmtZbhcAIZIjD3StDCGcA716Ouz2bLbdyi/hgo6MAwsNTyC
         Dfzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695317209; x=1695922009;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vckO2Ou8wXEnI7d8lHB0QrnLKODbimrd2Exu1O4oi7I=;
        b=Sj2K4g3Ag0tTT9GrTykRxl3UiTF9UIE/C2tczbBvCs89x+dIRGdFGGBDx9RH962Lif
         nu+KEH5FLdNEfmnN7JxQAv8ATLqfQkxEJ4UKC6dJ0dR0gnpt5JY+dm403hRVI44Ia5mY
         FGw6ACcMAbkbAqhqCFgKdmvkwFh0H1oL6+9MrlV+JHmda5V0QMRilGlDGFIM32UGijDA
         8on6JXkSovGKBUQW7vrIgJLzr1NjaZ98CLlDAtp+3G93L3zaCqclbLbF8B5ne550AqAD
         UE0Dayk5C7RZlTo0qL4teajh17D8KiozMYfG0KVYsOSAKesTVb2KHxtSssm7pHOEjoe1
         WqHQ==
X-Gm-Message-State: AOJu0YyXtiKcDUSgkNbqNeSnVPF9qxC3ajizg4NJEOs6hxE0ZG/y1+mX
        E8tUrjluTUCp79/bMUub+JiqOym5qGQ9+SF25dsJ1s9pIxosgFv5K0QHUQ==
X-Google-Smtp-Source: AGHT+IEfSM5McKsl77zEbSbSQ/62col2t+rBr/iYepzNVWwTMse0QnfUNVYb8moy61mVG36093h3Ze7co2vcfHeYDbI=
X-Received: by 2002:a05:6402:88e:b0:530:a19b:175 with SMTP id
 e14-20020a056402088e00b00530a19b0175mr5146291edy.2.1695306601856; Thu, 21 Sep
 2023 07:30:01 -0700 (PDT)
MIME-Version: 1.0
References: <20230825112633.236607-1-ulf.hansson@linaro.org> <20230825112633.236607-7-ulf.hansson@linaro.org>
In-Reply-To: <20230825112633.236607-7-ulf.hansson@linaro.org>
From:   Viresh Kumar <viresh.kumar@linaro.org>
Date:   Thu, 21 Sep 2023 16:29:44 +0200
Message-ID: <CAKohpo=1Pud8Hq-w0HOqz2TNE2gwMWFuv-DDRmb9q4W+fpEGtw@mail.gmail.com>
Subject: Re: [PATCH v3 06/13] cpufreq: scmi: Avoid one OF parsing in scmi_get_sharing_cpus()
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
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Fri, 25 Aug 2023 at 13:27, Ulf Hansson <ulf.hansson@linaro.org> wrote:
>
> The domain-id for the cpu_dev has already been parsed at the point when
> scmi_get_sharing_cpus() is getting called. Let's pass it as an in-parameter
> to avoid the unnecessary OF parsing.
>
> Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
> ---
>
> Changes in v3:
>         - None.
>
> ---
>  drivers/cpufreq/scmi-cpufreq.c | 11 ++++-------
>  1 file changed, 4 insertions(+), 7 deletions(-)

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
