Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E4DE7A9F4C
	for <lists+linux-pm@lfdr.de>; Thu, 21 Sep 2023 22:20:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231447AbjIUUUq (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 21 Sep 2023 16:20:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231941AbjIUUUH (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 21 Sep 2023 16:20:07 -0400
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC9FF3B7AF
        for <linux-pm@vger.kernel.org>; Thu, 21 Sep 2023 10:12:24 -0700 (PDT)
Received: by mail-wm1-x333.google.com with SMTP id 5b1f17b1804b1-404314388ceso13648825e9.2
        for <linux-pm@vger.kernel.org>; Thu, 21 Sep 2023 10:12:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1695316342; x=1695921142; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=vhrSVaekmaaS857MYrgyAKM4+ElTs9bb8AF7UO+hWSw=;
        b=p1tYkfwORdaKNDzfwpckKVflBnE+HEwodQbwFoluStv2nYwXVJG7RiLs6f44pvSDVQ
         ZxOKv9LIui2sVXsSBmQIalp2dqfaXa6lxSJWKwN5UkiwBssPOW01o7n2F5ZlzqWko7MZ
         VLWuefnE2/n8Xlq7EE62l5GBgUrMzRcKP1b2+8NrPBvBgurGLvNwnIVttUDyV3W2L9b+
         6PCd5EXof5H/T+86JUbqg3pyubE4JhNDboH03qp6qdJyokVrqb7UovLHA9q8uTfn20d2
         cKObaT6A8IKt217K16G3bGufvLoyk8CUo0Pl4bhAXXqDC7qruDqFlmz9/GoMEMmRQsZe
         1Q+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695316342; x=1695921142;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vhrSVaekmaaS857MYrgyAKM4+ElTs9bb8AF7UO+hWSw=;
        b=Wi+j4U1ZxsGJmi62BwK00gg2ZUWczqSihY4bB3m/PQzjzlQEHIQMSGmm4T6RK1nMc5
         nxTT4j4q47QwnGTrUcchOk9vzsZBf4N0MmfXsOUHp7ci6e8mYRFeTY08a6INjiyIRdWL
         MXAMw+P798TqHrW5+viaArldW9PtrdduluAHLOI9/JJ6N2pS1xd1gbrldym+lTWeh6Zg
         ImwRFzE08Gq3u3NudjlXFgKMLh0KgPcpCiS/SBZhldfz+yzuykEPDpSzTHmMbM4CC+/0
         bQqnPh5lO/0G9dGfAJmo8hS3tc3RxuA8gjcxk040Ds8DWXpQoT7WcYB47gF+5e1QiDQa
         ZQyA==
X-Gm-Message-State: AOJu0YzdP+vJl833+DpXAiZHffKF8FCl4Sp9lAdcas2bKXYCiMKRqOxq
        DMksnSCildngrBRzRG+Rl4l5Th7nIY/Bmif3lnxCA01OXqky1rQ1IZvh1w==
X-Google-Smtp-Source: AGHT+IH/oHbQjIKY1hc68OC0HLda5ssIJG+10LaW+f2EeRjP96QRrNJkfgWAiwt9yxSXP5uqPOv7A04wkNF+ihcnhUM=
X-Received: by 2002:aa7:c3c3:0:b0:532:deae:9c1f with SMTP id
 l3-20020aa7c3c3000000b00532deae9c1fmr4961974edr.18.1695306572624; Thu, 21 Sep
 2023 07:29:32 -0700 (PDT)
MIME-Version: 1.0
References: <20230825112633.236607-1-ulf.hansson@linaro.org> <20230825112633.236607-5-ulf.hansson@linaro.org>
In-Reply-To: <20230825112633.236607-5-ulf.hansson@linaro.org>
From:   Viresh Kumar <viresh.kumar@linaro.org>
Date:   Thu, 21 Sep 2023 16:29:15 +0200
Message-ID: <CAKohpoma56EGs=gTTQGyQ5jw8f1bZvd2tJYZjYTTnkAf4A58tA@mail.gmail.com>
Subject: Re: [PATCH v3 04/13] firmware: arm_scmi: Align perf ops to use
 domain-id as in-parameter
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
> Most scmi_perf_proto_ops are already using an "u32 domain" as an
> in-parameter to indicate what performance domain we shall operate upon.
> However, some of the ops are using a "struct device *dev", which means that
> an additional OF parsing is needed each time the perf ops gets called, to
> find the corresponding domain-id.
>
> To avoid the above, but also to make the code more consistent, let's
> replace the in-parameter "struct device *dev" with an "u32 domain". Note
> that, this requires us to make some corresponding changes to the scmi
> cpufreq driver, so let's do that too.
>
> Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
> ---
>
> Changes in v3:
>         - Re-based.
>
> ---
>  drivers/cpufreq/scmi-cpufreq.c   | 14 +++++++++-----

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
