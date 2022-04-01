Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF99E4EE61F
	for <lists+linux-pm@lfdr.de>; Fri,  1 Apr 2022 04:40:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239363AbiDAClk (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 31 Mar 2022 22:41:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231317AbiDAClj (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 31 Mar 2022 22:41:39 -0400
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C30E359A5C
        for <linux-pm@vger.kernel.org>; Thu, 31 Mar 2022 19:39:50 -0700 (PDT)
Received: by mail-pf1-x42c.google.com with SMTP id b15so1349389pfm.5
        for <linux-pm@vger.kernel.org>; Thu, 31 Mar 2022 19:39:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=vUeYd4HcrETg1TwuyK0qAbQ35psGmjFp+yiimtCZEBE=;
        b=ANuro/FzZzKuRWQm2CzkW7xFIaeDiIjiAKxY6M3DOS0TYc9wQdle/4haDAQINMVkHd
         8EeNwWlY3pcBa6zuHLH2BblUhNpX+wKXRIPMT0aqI371Cyllc4MEg+8Cnhf3w16AbS42
         Z2r6NvmhaB3yMlyYZkS8+W6HiBgFduR+xoftdnxHcqKClFZ6v3yCyPynRjtAVGAqplBv
         O33gzBws9OPyFIKFLIpSB8xjIwOH6SlKTs5288TRP+VxYVW0im+3X2Pea1c5kIm5hc9U
         Cs39J06gU+ybWpv4IVT7DOwCY2lpATNLoVcbftdpKKsrBCNUDb8pelVu0LcV7WirVIgH
         iIyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=vUeYd4HcrETg1TwuyK0qAbQ35psGmjFp+yiimtCZEBE=;
        b=tFXKB5bECkzaAtVNE4hM61koae0EdKjz1MOq7pk76fozCEE4if+avKaCAIq+fagv7p
         chYa1urDrMkvVc9nPkTy0Ow/V+pvfmD7mxYVkwOzAiybiOZdlxyTYstN8LHp06KYoKIi
         Gv+o0SN2vSX62MQaBzosoAvfjynkXoQSYWjYfi/s7Z7BQXY3u/T4t9HMu+p/eFJxJQuj
         Rrmg3ofk9OXKYJMRctpOubJXKK69yvfFNTfKPMJTSMxXsJnXFPjJwI7T9TxvGIOqD/YY
         OgrUvrLi/NQbJBbcnPPROUfGHuCFGXbd4Keera43srEtWW1EUsVs8sGxq1WWdpZvnA2f
         P1oA==
X-Gm-Message-State: AOAM532J03lHy8xJbDezbtovDQyMo/op7k87zLkK89xmcLJZKTM/R+TF
        lOUIz49VF5F3nC1lwZxOFCXdThGB/bMYNg==
X-Google-Smtp-Source: ABdhPJyNrdWKaxy8d6ns+EB0QJDxf3uEjW9kh7Kwnqz0JcrB2c5oN2d9nl3svSkGqMykRtr8tl93pQ==
X-Received: by 2002:a63:4147:0:b0:382:9ac9:b12b with SMTP id o68-20020a634147000000b003829ac9b12bmr13444364pga.277.1648780790266;
        Thu, 31 Mar 2022 19:39:50 -0700 (PDT)
Received: from localhost ([223.184.83.228])
        by smtp.gmail.com with ESMTPSA id c4-20020a056a00248400b004faad8c81bcsm840583pfv.127.2022.03.31.19.39.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 31 Mar 2022 19:39:49 -0700 (PDT)
Date:   Fri, 1 Apr 2022 08:09:48 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Andy Gross <agross@kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        Thara Gopinath <thara.gopinath@gmail.com>
Subject: Re: [PATCH v4 0/4] cpufreq: qcom-hw: Fixes for cpu hotplug support
Message-ID: <20220401023948.44hawxwapsnsjgil@vireshk-i7>
References: <20220326155153.7377-1-dmitry.baryshkov@linaro.org>
 <YkX0RQ7Re7J/iG+d@ripper>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YkX0RQ7Re7J/iG+d@ripper>
User-Agent: NeoMutt/20180716-391-311a52
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 31-03-22, 11:34, Bjorn Andersson wrote:
> On Sat 26 Mar 08:51 PDT 2022, Dmitry Baryshkov wrote:
> 
> > This patchseries aims at fixing and improving CPU hotplug support on
> > Qualcomm platforms. First three patches are the fixes for the LMH
> > support in the cpufreq driver. The last patch adds support for
> > lightweight offline() and online() callbacks which are used instead of
> > exit() and init() each time the CPU is put offline or back online.
> > 
> > Patches 1-3 being pure simple fixes can be applied during the -rc
> > stage, while patch 4 is targeting next development cycle
> > 
> 
> Viresh, please consider picking up patch 1-3 for v5.18-rc.

Applied. Thanks.

-- 
viresh
