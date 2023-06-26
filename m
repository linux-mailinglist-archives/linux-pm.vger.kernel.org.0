Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 11E6073D7D7
	for <lists+linux-pm@lfdr.de>; Mon, 26 Jun 2023 08:40:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229880AbjFZGkv (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 26 Jun 2023 02:40:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229689AbjFZGku (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 26 Jun 2023 02:40:50 -0400
Received: from mail-pg1-x52b.google.com (mail-pg1-x52b.google.com [IPv6:2607:f8b0:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CDD5719F
        for <linux-pm@vger.kernel.org>; Sun, 25 Jun 2023 23:40:49 -0700 (PDT)
Received: by mail-pg1-x52b.google.com with SMTP id 41be03b00d2f7-543c6a2aa07so1385521a12.0
        for <linux-pm@vger.kernel.org>; Sun, 25 Jun 2023 23:40:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1687761649; x=1690353649;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=OHVea6SnkTeHYvW8S/RdtT2gQKXoW/TrkJMiJDKuRzo=;
        b=EfFr4A+f6j9NsHpEo/w/ZB3pc6i2qYRPgyqZLDC6MMVpvxrGDpjkXGJmXesDfoNTuZ
         1x57aZAI1mIvfmd1a+beZyS5uPrYmWukFeX4sBWZeHk5nzLtLsYx1pK7Zw6xGP5aXFpq
         1xElxfQaEp4puntJx7/4ijwu0GJ75/qFDeyIVu+zk++h6tlw87wI+hHd6bE0Cj/bu9VP
         Ou8lN+nOfcErm547OxzLMAnL3zNFLW3TsBWBow+cAkNQPCPszsHX5HK9tx5cowuf9hTH
         PTBE1AHV69CEPwVunPsLlfkP8BXmJA2TxQAc5b2zC9yTBTM0piD71zWg1bu5HCafTEVu
         mRrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687761649; x=1690353649;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OHVea6SnkTeHYvW8S/RdtT2gQKXoW/TrkJMiJDKuRzo=;
        b=DE0Kp/Sf4w+Mh/nA8KM03OyShSWEWCvHwepTuaNDMadX+v/ajLqn5MHeFdkzhUVFhY
         poNp5aZm2V/L9WrYsTX2+k5e9oriCGZErkgyKgb81NVpQELlAXjg00FS4V/I1NPyCCRb
         U8D5vIo51RiP1jN3hHdgLQc1CKZARFRKUuzXF+78yQiDUtA6YuMqxvdhyVsVH6syCJi4
         jgWW384qyhlFGVXIlmtbJH45E1oBgKRme4skEvXRXmbOsO/jUcZBx1moU8OulwqvCotf
         1xegWx4HPxUqJrsB+M6qOs5FuU7zBw6twJk+ynqKcUbNfJh7uVqBqzwvCqfMjWW+9ZnU
         8pqA==
X-Gm-Message-State: AC+VfDx4NWo/c0GD7XVWWthDDjNbH1iT8uxeJSe3mO5Ss8885moRsWpv
        KzxInY4z45EHkoIiER9PbJkuYw==
X-Google-Smtp-Source: ACHHUZ50Z8DQKDyjlHI1AAK+LW5e6IsmCIq606w4yU8l3nTLI2vBsx6V+octM1Lz6Kvzvgs9PO9Trw==
X-Received: by 2002:a17:90a:3d0d:b0:24e:2e86:5465 with SMTP id h13-20020a17090a3d0d00b0024e2e865465mr20344741pjc.31.1687761649259;
        Sun, 25 Jun 2023 23:40:49 -0700 (PDT)
Received: from localhost ([122.172.87.195])
        by smtp.gmail.com with ESMTPSA id 18-20020a17090a001200b002610468d738sm3989521pja.19.2023.06.25.23.40.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 25 Jun 2023 23:40:48 -0700 (PDT)
Date:   Mon, 26 Jun 2023 12:10:42 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Bjorn Andersson <quic_bjorande@quicinc.com>
Cc:     Andrew Halaney <ahalaney@redhat.com>, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        rafael@kernel.org, konrad.dybcio@linaro.org, andersson@kernel.org,
        agross@kernel.org
Subject: Re: [PATCH] cpufreq: qcom-cpufreq-hw: Use dev_err_probe() when
 failing to get icc paths
Message-ID: <20230626064042.2uh3t3vjwnrmioen@vireshk-i7>
References: <20230623155707.944272-1-ahalaney@redhat.com>
 <20230623170856.GA1736857@hu-bjorande-lv.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230623170856.GA1736857@hu-bjorande-lv.qualcomm.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 23-06-23, 10:08, Bjorn Andersson wrote:
> On Fri, Jun 23, 2023 at 10:57:07AM -0500, Andrew Halaney wrote:
> > This way, if there's an issue (in this case a -EPROBE_DEFER), you can
> > get useful output:
> > 
> >     [root@dhcp19-243-150 ~]# cat /sys/kernel/debug/devices_deferred
> >     18591000.cpufreq        qcom-cpufreq-hw: Failed to find icc paths
> > 
> > Signed-off-by: Andrew Halaney <ahalaney@redhat.com>
> 
> Reviewed-by: Bjorn Andersson <quic_bjorande@quicinc.com>

Applied. Thanks.

-- 
viresh
