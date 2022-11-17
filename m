Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3859862D957
	for <lists+linux-pm@lfdr.de>; Thu, 17 Nov 2022 12:24:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239586AbiKQLYN (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 17 Nov 2022 06:24:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239282AbiKQLYJ (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 17 Nov 2022 06:24:09 -0500
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D540C3E0B3
        for <linux-pm@vger.kernel.org>; Thu, 17 Nov 2022 03:24:07 -0800 (PST)
Received: by mail-pj1-x1030.google.com with SMTP id o7so1398826pjj.1
        for <linux-pm@vger.kernel.org>; Thu, 17 Nov 2022 03:24:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=i+s6Ug5M5MNLeX0nDma7SaMLHMCJkt7UhOngWgPpU1U=;
        b=wNNgQ/ujNH4aMiqD04braFOKKTznPN8QXWqPUL3WqXaFDSCXmvcc72WiGKxO5PEz36
         xr/Fsvt7CyfIlnQTopNyjDouuyuKapNzxa5lfXtmpt2sycPaGWyX0EdziRTw7AeU7bDh
         Ux9A5wbvnBFZRUGKmZW+3Jl6qaDWzrIylvnwr8ybkHCNkYKgqJ7scbe2Y2GLWKqi0kYZ
         b9bicqYYE5bY0OT0dnHBY7WtfjClSSQnDvQBc1TUuPHwgyYdGL5p8mciOmma+hF6g9Ua
         NSa0LHXavdxR3GUMlBJkUCnAUEMYheSUTtC21D2raVEAXfdVDkMFi1qniRW9Mrk7RPDg
         fEXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=i+s6Ug5M5MNLeX0nDma7SaMLHMCJkt7UhOngWgPpU1U=;
        b=zFVJQRo74jaJK/5vP7YOJujzKvw8RAepioG81/Aw0PJGMRD9L07DNjwmrkWsp+FNFr
         lynZvXc0UdSENmSLorgM0ceeTTt1rnaUwu6IQ1SZ+2iwTy86prGprXOB69k43Ci0WZH8
         V+WtQkpi+9kfKC5R9/Ing5xY/A6fuDXs6jb5ZzVcaUjOHs+OUEzL0oum2Jx4NQHKwLF7
         I89Oncq4FUWadQMi8IG379gUwqB9bJbgpQDiO5MNBSIeB1/9S07Pl8tAhmwred2H4fcC
         6A+DTNUflJTFYHlUGtQrpD/bkPXhQSC0njq5tE1VtF3p5l1RC9Sh5JKhNj01Q/fHMVwF
         NprA==
X-Gm-Message-State: ANoB5pnlEa4QXC/zZWOsUy4nLvHP6K+27ltzkR3iEpGdAasQYH8S+IPM
        4sebnmFwT+MAOoeOe6WABDMUuMwPehtiQw==
X-Google-Smtp-Source: AA0mqf560Kd2vqBW3wj4OBZezqM8uLWOdkM4wwz1Qay/d9Jm9v2iltTJxm4b4e7pw4JfhJOSm6zreg==
X-Received: by 2002:a17:90a:62c2:b0:20d:bc7f:4fee with SMTP id k2-20020a17090a62c200b0020dbc7f4feemr8385860pjs.168.1668684247332;
        Thu, 17 Nov 2022 03:24:07 -0800 (PST)
Received: from localhost ([122.172.85.60])
        by smtp.gmail.com with ESMTPSA id iz9-20020a170902ef8900b001754cfb5e21sm1062247plb.96.2022.11.17.03.24.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Nov 2022 03:24:05 -0800 (PST)
Date:   Thu, 17 Nov 2022 16:54:03 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Sudeep Holla <sudeep.holla@arm.com>
Cc:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        andersson@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        rafael@kernel.org, robh+dt@kernel.org, johan@kernel.org,
        devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Subject: Re: [PATCH v7 0/4] qcom-cpufreq-hw: Add CPU clock provider support
Message-ID: <20221117112403.haffuclwooudvgwz@vireshk-i7>
References: <20221117053145.10409-1-manivannan.sadhasivam@linaro.org>
 <20221117101903.sw3hxaruj5sfhybw@bogus>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221117101903.sw3hxaruj5sfhybw@bogus>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 17-11-22, 10:19, Sudeep Holla wrote:
> Why do you need the above 3 changes if the below(4/4) will ensure
> cpufreq_get(cpu) returns the clock frequency. I was expecting to drop the
> whole "confusing" clock bindings and the unnecessary clock provider.
> 
> Can't we just use cpufreq_get(cpu) ?

https://lore.kernel.org/lkml/cover.1657695140.git.viresh.kumar@linaro.org/

The basic idea (need) here was to fix the DT and let the CPU nodes have clock
related properties, which are missing currently.

The context can be seen in the above thread.

-- 
viresh
