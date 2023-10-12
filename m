Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F3617C6879
	for <lists+linux-pm@lfdr.de>; Thu, 12 Oct 2023 10:54:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235464AbjJLIkq (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 12 Oct 2023 04:40:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235438AbjJLIkp (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 12 Oct 2023 04:40:45 -0400
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D75090;
        Thu, 12 Oct 2023 01:40:43 -0700 (PDT)
Received: by mail-wm1-x329.google.com with SMTP id 5b1f17b1804b1-405497850dbso7584075e9.0;
        Thu, 12 Oct 2023 01:40:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697100041; x=1697704841; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=d6hjwO0QYem7wB9ncQJktw2M9ObYxqHAubvFpZ1Se2I=;
        b=l9bUcRVFBha3paASp+Zkvrv8qQp1W/idiFA1iTNBLkpvOnafVSnzW4IL3NUTlkG0ZL
         hSaL98+uhRK07bxQmXFASZMOSPo4j5g5XKgwYcLkY5HXtBVL2pQIUZLsYzgV8IkwBw5q
         K46EvntplAh2ZE3zv/4+F1lMJB8uIyoTmrMFlSKti0mEQioX9OzxT2n7dmcHV4gnpnM0
         D7x0JwGsmJYBLPdJAcKOrR9+fujAZLEJsKTS8uGrdrzxYHradNUYZs5OWWpNwXE6HCsM
         GZRAtaFMxB3O7jtKNXirGg5AXtv8gbdeJ/u4MPfp838zRZAhaLcz7uWd4gAFzNnGgwiV
         Uk6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697100041; x=1697704841;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=d6hjwO0QYem7wB9ncQJktw2M9ObYxqHAubvFpZ1Se2I=;
        b=knqxBGRMcznCdJkyhT8Ow3YGKiIjaAY9p4YiwupWq4z/0EXI0NJ32ZbMXoDl7enwnf
         xDo/ENxKD+XgNgs8ATyGs7rQB2CN6CQWMLBWDY3mexDrFaexBbqgTdOGfsbywCDX22NJ
         OnW+KDZRkSvAmp48kR0mtrKIS0dohWk0S7IFy/BItglZQUUqSVYSP3y9wFa/zyHo0yLY
         UyunpHgBD1WkD2jq4nVTCri/oLWwpQBOLd7LBrs5QhuylpACgExDaA1s/CmK0/PO1TdG
         7NKwa9wHOVUZpIlvnY1hj/c3nt7+cd/T4XqzJ+N50q3wD+mJN+C8MjBi3qywevvYvL7G
         qRqw==
X-Gm-Message-State: AOJu0YxK2snFY/dwb8vlbR5c3NY46/AwR3If8eXjL81F6xzKa1cf+mtw
        +dHmJSau2zm6Ei+r4SWXBtg=
X-Google-Smtp-Source: AGHT+IFn0DQmOtn/DUZmU7WVv+0Qp2ojqN902C4Z3/Vk+y14x5P0E/Pq1nUVNf+Hk8fdVD3YSj/W/w==
X-Received: by 2002:a05:600c:b41:b0:405:499a:7fc1 with SMTP id k1-20020a05600c0b4100b00405499a7fc1mr20623780wmr.40.1697100041235;
        Thu, 12 Oct 2023 01:40:41 -0700 (PDT)
Received: from Ansuel-xps. (93-34-89-13.ip49.fastwebnet.it. [93.34.89.13])
        by smtp.gmail.com with ESMTPSA id n24-20020a1c7218000000b004065e235417sm21047460wmc.21.2023.10.12.01.40.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Oct 2023 01:40:40 -0700 (PDT)
Message-ID: <6527b108.1c0a0220.bc8fa.7fd2@mx.google.com>
X-Google-Original-Message-ID: <ZSexBuiBkh0z5oiB@Ansuel-xps.>
Date:   Thu, 12 Oct 2023 10:40:38 +0200
From:   Christian Marangi <ansuelsmth@gmail.com>
To:     Viresh Kumar <viresh.kumar@linaro.org>
Cc:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Ilia Lin <ilia.lin@kernel.org>,
        Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Georgi Djakov <djakov@kernel.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-clk@vger.kernel.org,
        Stephan Gerhold <stephan@gerhold.net>
Subject: Re: [PATCH v5 0/6] cpufreq: qcom-nvmem: support apq8064 cpufreq
 scaling
References: <20231002185940.1271800-1-dmitry.baryshkov@linaro.org>
 <20231010063235.rj2ehxugtjr5x2xr@vireshk-i7>
 <20231012034241.jwtsq22w2lwzfbvn@vireshk-i7>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231012034241.jwtsq22w2lwzfbvn@vireshk-i7>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Thu, Oct 12, 2023 at 09:12:41AM +0530, Viresh Kumar wrote:
> On 10-10-23, 12:02, Viresh Kumar wrote:
> > On 02-10-23, 21:59, Dmitry Baryshkov wrote:
> > > This is a split of APQ8064 cpufreq series, as requested by Viresh. This
> > > series includes only opp and cpufreq parts, with the DT and soc parts
> > > being split to a separate patchset.
> > > 
> > > Each core has independent power and frequency control. Additionally the
> > > L2 cache is scaled to follow the CPU frequencies (failure to do so
> > > results in strange semi-random crashes).
> > > 
> > > Core voltage is controlled through the SAW2 devices, one for each core.
> > > The L2 has two regulators, vdd-mem and vdd-dig.
> > > 
> > > Changes since v4:
> > > - Reordered variables in qcom_cpufreq_init() (Konrad)
> > > - Fixed of_platform_device_create() error check (Konrad)
> > > - Dropped unused ret variable in qcom_cpufreq_apq8064_name_version() (Konrad)
> > 
> > Applied. Thanks.
> 
> Since these are causing build issues, and it isn't entirely clear what's the
> right approach for now, I have dropped the changes from my branch to avoid any
> further issues. You don't need to resend these, lets finalize a solution and
> then I can apply them again.
> 

Hi we have a qcom-cpufreq series that depends on this (or better say we
have rebased it on top of these changes to prevent merge conflicts)

Can you link where this was applied, also can I help in fixing the
compile error to speed things up?

-- 
	Ansuel
