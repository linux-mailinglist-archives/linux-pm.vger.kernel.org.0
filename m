Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 89A147428CF
	for <lists+linux-pm@lfdr.de>; Thu, 29 Jun 2023 16:48:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232077AbjF2OsH (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 29 Jun 2023 10:48:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231766AbjF2OsG (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 29 Jun 2023 10:48:06 -0400
Received: from mail-io1-f53.google.com (mail-io1-f53.google.com [209.85.166.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5DD8F1FC1;
        Thu, 29 Jun 2023 07:48:05 -0700 (PDT)
Received: by mail-io1-f53.google.com with SMTP id ca18e2360f4ac-78363328c04so33499339f.0;
        Thu, 29 Jun 2023 07:48:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688050084; x=1690642084;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uilq6z/8qDMrMwwK/ThP4YRy5D7LVd88uC6Jk/hXOB0=;
        b=Dae4MVNbjKDJ2ZbZzGH/TgQM9eIuK8bnVBtWNA/DzXLlgLECwRskyNM1yCrwer0eOH
         MCEKCJUTojf+TDyspB7Ygi5/OvBnXcSahb8soMTH1bV+uMPymOunSkIoZiaAHRxJ9ffi
         lQuR6OKey6p8KlWt+q6t50rS1TiaUQVFwfLh6webvk+q4F8mau1WUCD1wA4gTN7LyrLy
         rW8FeArd45DIg7tI3zQtlWPX9/jQg+qvQoB9bOVqAdHXtytSi4+/z5DgwcS89TZrPTmK
         mH0vReeaqdCVApjZ3XxpHFqhwQXz8NaqF7O/pppWbXoiIyYB6Ik/VUKsWYmCGinya+9m
         VP0g==
X-Gm-Message-State: AC+VfDzj7WSSl8l5pobJcdCAu+fHmLMvk7NWgIRhzg6KRcBccaEiX6Ka
        e6cQLpDgQVmcD8nR6cVb7A==
X-Google-Smtp-Source: ACHHUZ5ZVvbmn50/zDnLJaH0yQC1yqsQQY1KVrAIBDo0Kk8dgB7tB6uNKpFuUkQokEuPl8zkbvpgBg==
X-Received: by 2002:a6b:dd09:0:b0:783:5452:e343 with SMTP id f9-20020a6bdd09000000b007835452e343mr11464812ioc.14.1688050084530;
        Thu, 29 Jun 2023 07:48:04 -0700 (PDT)
Received: from robh_at_kernel.org ([64.188.179.250])
        by smtp.gmail.com with ESMTPSA id h23-20020a5e8417000000b00783634b9eafsm2541364ioj.50.2023.06.29.07.48.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Jun 2023 07:48:03 -0700 (PDT)
Received: (nullmailer pid 2947111 invoked by uid 1000);
        Thu, 29 Jun 2023 14:48:01 -0000
Date:   Thu, 29 Jun 2023 08:48:01 -0600
From:   Rob Herring <robh@kernel.org>
To:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc:     devicetree@vger.kernel.org, Stephan Gerhold <stephan@gerhold.net>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-pm@vger.kernel.org, Conor Dooley <conor+dt@kernel.org>,
        Viresh Kumar <vireshk@kernel.org>,
        Christian Marangi <ansuelsmth@gmail.com>,
        Andy Gross <agross@kernel.org>, linux-clk@vger.kernel.org,
        linux-arm-msm@vger.kernel.org,
        Bjorn Andersson <andersson@kernel.org>,
        Nishanth Menon <nm@ti.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Rob Herring <robh+dt@kernel.org>,
        Ilia Lin <ilia.lin@kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Georgi Djakov <djakov@kernel.org>
Subject: Re: [PATCH v2 01/26] dt-bindings: opp: opp-v2-kryo-cpu: support
 Qualcomm Krait SoCs
Message-ID: <168805008087.2947031.13766833790422511577.robh@kernel.org>
References: <20230625202547.174647-1-dmitry.baryshkov@linaro.org>
 <20230625202547.174647-2-dmitry.baryshkov@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230625202547.174647-2-dmitry.baryshkov@linaro.org>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


On Sun, 25 Jun 2023 23:25:22 +0300, Dmitry Baryshkov wrote:
> Exted the opp-v2-kryo-cpu.yaml to support defining OPP tables for the
> previous generation of Qualcomm CPUs, 32-bit Krait-based platforms.
> 
> It makes no sense to use 'operating-points-v2-kryo-cpu' compatibility
> node for the Krait cores. Add support for the Krait-specific
> 'operating-points-v2-krait-cpu' compatibility string and the relevant
> opp-microvolt subclasses properties.
> 
> The listed opp-supported-hw values are applicable only to msm8996 /
> msm8996pro platforms. Remove the enum as other platforms will use other
> bit values. It makes little sense to list all possible values for all
> the platforms here.
> 
> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> ---
>  .../devicetree/bindings/opp/opp-v2-kryo-cpu.yaml     | 12 ++++++++----
>  1 file changed, 8 insertions(+), 4 deletions(-)
> 

Acked-by: Rob Herring <robh@kernel.org>

