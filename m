Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CDD567A8EB0
	for <lists+linux-pm@lfdr.de>; Wed, 20 Sep 2023 23:50:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229472AbjITVuK (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 20 Sep 2023 17:50:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbjITVuK (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 20 Sep 2023 17:50:10 -0400
Received: from mail-yb1-xb33.google.com (mail-yb1-xb33.google.com [IPv6:2607:f8b0:4864:20::b33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2CF71AF;
        Wed, 20 Sep 2023 14:50:04 -0700 (PDT)
Received: by mail-yb1-xb33.google.com with SMTP id 3f1490d57ef6-d818d4230f6so445898276.1;
        Wed, 20 Sep 2023 14:50:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695246603; x=1695851403; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=mQx5kR2+x3nFQSDzEdoMYbuPwtfcLZH/PujwlS1E1J4=;
        b=VwyLHEt/Fwp1D47qNTR04FQ2IIgDQxbiPd+HRyVuxm6+3ofcKR2nt4jjTjk8ehSE4E
         HRAIFmMNHAKfTofrZynzFXSWzoeh2CQbKz9ryaVbrEK0uH2wZc1NzTFGxjz2Ev65MKKZ
         lSbCtNZO/o+Gra0ADeJNl8hxycPCSxSB66a/Xsy7KnBk5pKC/awUvYNRpmUQymmllzxn
         8MK5wvLDBOjGUsedgHhflpXeVGPhfFPOwOFK7AaZK4AbzLmW2CuDm9ldVtIXmlwe5tne
         9+Jd9cdptA8t035KkWmIjh208QWhYZsiO7+yUFlQHoWcpszW3C7KhYLlTbzvWCN6OmSF
         0KtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695246603; x=1695851403;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mQx5kR2+x3nFQSDzEdoMYbuPwtfcLZH/PujwlS1E1J4=;
        b=nAGq6lZojNDDkGCMKCi45sAEuiXlvSUwVMMUifcLh61PIsWj4SF/mP9BcjAWDbHuQA
         bR/3oOE6Jy3TwmjjwTzTjw8RLCzj40tD/JFyjqfBhqUsWvKeXCbz3A5l0xDjIfSdnD/0
         m5qN2LSiOXzf0kwNLQrRJa5hpRj6rziOUzMs7Y8QaLK8YMhewvx3018jqhVTK9aEjKGo
         r55XwmenP6LDqk+byJHioeN3HOiuIaVZODKJV23rehOJ+dOdPC1pUfmZZve1wUV8LqNk
         uiF5LgUhesvXwgrA08m12XJd2rdIZ6F9Gv4q50+WLtG4tQG+fUZEL0Ly1Rx97GhNKJod
         VtoA==
X-Gm-Message-State: AOJu0YxRTTxs1Z60TsHmZAjS51Bj4K2hL88zu+4bS5izDu7Cac16VuG3
        r6W31zgcfqG9//pqnFLmJic=
X-Google-Smtp-Source: AGHT+IEygTwYLySY4BjNw/ewyPAQ2Qpy7n0akNiWnZACj9K8CWmE4Xt6icWC72UevDMvuVkVSNlvvw==
X-Received: by 2002:a25:3787:0:b0:d3a:28bb:2c95 with SMTP id e129-20020a253787000000b00d3a28bb2c95mr3716281yba.22.1695246603281;
        Wed, 20 Sep 2023 14:50:03 -0700 (PDT)
Received: from localhost ([2607:fea8:529e:7800::efbe])
        by smtp.gmail.com with ESMTPSA id a125-20020a254d83000000b00d7bb3c4893fsm34541ybb.8.2023.09.20.14.50.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Sep 2023 14:50:02 -0700 (PDT)
Date:   Wed, 20 Sep 2023 17:49:58 -0400
From:   Richard Acayan <mailingradian@gmail.com>
To:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Georgi Djakov <djakov@kernel.org>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Sibi Sankar <quic_sibis@quicinc.com>, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH v2 0/3] SDM670 CPU frequency scaling: dtschema fixes
Message-ID: <ZQtpBtX-tN4Hg3uh@radian>
References: <20230816230412.76862-6-mailingradian@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230816230412.76862-6-mailingradian@gmail.com>
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,FREEMAIL_REPLY,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Wed, Aug 16, 2023 at 07:04:14PM -0400, Richard Acayan wrote:
> Changes since v1 (20230815223108.306018-5-mailingradian@gmail.com):
>  - add compatible to allOf area (2/3)
>  - change subject line (Acked-by tag retained) (1/3)
>  - add fixes tag (2/3)
>
> This adds appropriate compatible strings to pass bindings checks.
>
> Patch 1/3 is preserved from a previous series, as it was not applied to
> linux-next yet and I wasn't notified that it was applied anywhere else:
> https://lore.kernel.org/linux-arm-msm/20230724214209.208699-7-mailingradian@gmail.com/
>
> Richard Acayan (3):
>   dt-bindings: interconnect: OSM L3: add SDM670 compatible
>   dt-bindings: cpufreq: cpufreq-qcom-hw: add SDM670 compatible
>   arm64: dts: qcom: sdm670: add specific cpufreq compatible

Hi, just a reminder that this series is here, and patches 2-3 are stale.

Would it help to send them separately?

>
>  Documentation/devicetree/bindings/cpufreq/cpufreq-qcom-hw.yaml  | 2 ++
>  Documentation/devicetree/bindings/interconnect/qcom,osm-l3.yaml | 1 +
>  arch/arm64/boot/dts/qcom/sdm670.dtsi                            | 2 +-
>  3 files changed, 4 insertions(+), 1 deletion(-)
>
> -- 
> 2.41.0
>
