Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2056A7C4969
	for <lists+linux-pm@lfdr.de>; Wed, 11 Oct 2023 07:49:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229957AbjJKFtG (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 11 Oct 2023 01:49:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229940AbjJKFtF (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 11 Oct 2023 01:49:05 -0400
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 899FE9B
        for <linux-pm@vger.kernel.org>; Tue, 10 Oct 2023 22:49:02 -0700 (PDT)
Received: by mail-pf1-x434.google.com with SMTP id d2e1a72fcca58-690d2e13074so4984814b3a.1
        for <linux-pm@vger.kernel.org>; Tue, 10 Oct 2023 22:49:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1697003342; x=1697608142; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=i3/xooCfzn+HEb84CSy8n1NiyDH9US0NidBeh+kHVYE=;
        b=DENHURHFEXIX2Casi1G4byCfgdWPbRWZ3fdZYmZbR/8y7e7K60CN4HF7DxokoU7PGz
         IQVwrSqYcd88epKDNfBsi0VP8dH8a7bbWOWuqCQqkU+woXUDNak5J1hEsePjzZNpk9iD
         TbNzpmdlRUqrwZC2BlhSiVOBPWMP0gexI4rnIIE+VIjRExMCHBH/C8LCzvSXvLrOBdXe
         1uE3Xg55EfqlMmMktQRFhx+wp3Fd+QDNRKyovrf40gh04QLaZdnuiELfVQnZ5mgFsZa9
         8tnc/nUfsrXf+ft+MgOheEmBzINuVDKju5Ql5cx9eEYxoBKBXCFHcQJFXiQVjpghcrCq
         +g2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697003342; x=1697608142;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=i3/xooCfzn+HEb84CSy8n1NiyDH9US0NidBeh+kHVYE=;
        b=uF6raV+2Yccblf9gJ6NUmFSxCdVm6G5yCGKZi+82SMvRJ88Te7Q5BH5X4Xkqn7BhQv
         RT0kF6xvGeLCEqzl01yvbk8FdDvcf3gCrwmYLqf9vikotH1SmiecCE/2MDlmJyGL5/A9
         VmfoFZt9DQkupbQD9mpYrAMVNvFg1ghIRfTNEibupyZr//yVEi5yJOPqy/brYHAiq/5o
         wTm++vCMpfMdO5mv5uXuZkNJROYqbIV0/p2amUm48O97MlioJCyIwu26QhE5iFUr00GT
         /BRsRO2o4ogPmMyiDQZIpZ6COilvj2FWpdNYEGzaO112PZVh9OXSFAz/rrLyKgROQfnw
         D+7w==
X-Gm-Message-State: AOJu0YwBdX9foRieWC/7AsKRGwsjgGvHH5vsoU5qmtMMnfbyZhPyvV+r
        tXpbgieAB+obFWmLFMwz1/qoKA==
X-Google-Smtp-Source: AGHT+IELb9UJT6sC7GTilNP+4QfWdcX9+gyN7cf4Rlq0B7kFgPDad3Hdi4I21cnODq4uhQcLWot/+w==
X-Received: by 2002:a05:6a00:885:b0:68f:e810:e86f with SMTP id q5-20020a056a00088500b0068fe810e86fmr21643745pfj.28.1697003341973;
        Tue, 10 Oct 2023 22:49:01 -0700 (PDT)
Received: from localhost ([122.172.81.92])
        by smtp.gmail.com with ESMTPSA id p6-20020a62ab06000000b0069302c3c050sm9172133pff.218.2023.10.10.22.49.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Oct 2023 22:49:00 -0700 (PDT)
Date:   Wed, 11 Oct 2023 11:18:58 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc:     Johan Hovold <johan@kernel.org>, Viresh Kumar <vireshk@kernel.org>,
        Nishanth Menon <nm@ti.com>, Stephen Boyd <sboyd@kernel.org>,
        linux-pm@vger.kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>, andersson@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, linux-kernel@vger.kernel.org,
        robdclark@gmail.com
Subject: Re: [PATCH 2/2] OPP: Disallow "opp-hz" property without a
 corresponding clk
Message-ID: <20231011054858.3vvnr76u5enu5lf6@vireshk-i7>
References: <cover.1669012140.git.viresh.kumar@linaro.org>
 <c03c4f2b9d4dcc3264d1902606c6c5c464b4b043.1669012140.git.viresh.kumar@linaro.org>
 <Y3snGQet8yc7HnJK@hovoldconsulting.com>
 <20221121073946.GE11945@thinkpad>
 <20230125042145.hrjpnskywwqn7b6v@vireshk-i7>
 <20230216064727.GA2420@thinkpad>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230216064727.GA2420@thinkpad>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 16-02-23, 12:17, Manivannan Sadhasivam wrote:
> Sorry for the delay. I've submitted the dts changes [1] to handle the CPU clocks
> for the rest of the Qcom SoCs.
> 
> For the Qcom GPUs, I've CCed Rob Clark who is the maintainer.
> 
> Rob, here is the background on the issue that is being discussed in this
> thread:
> 
> Viresh submitted a series [2] back in July to improve the OPP framework, but
> that ended up breaking cpufreq on multiple Qcom SoCs. After investigation, it
> was found that the series was expecting the clocks supplied to the OPP end
> devices like CPUs/GPUs to be modeled in DT. But on Qcom platforms even though
> the clocks for these nodes are supplied by a separate entity, like CPUFreq
> (EPSS/OSM) for CPUs and GMU for GPUs, there was no clock property present in
> the respective nodes. And these nodes are using OPP table to switch frequencies
> dynamically.
> 
> While the series was merged with a hack that still allows the OPP nodes without
> clock property in DT, we came to an agreement that the clock hierarchy should
> be modeled properly.
> 
> So I submitted a series [3] that added clock provider support to cpufreq driver
> and sourced the clock from cpufreq node to CPU nodes in DT.
> 
> Likewise, it should be handled for the adreno GPUs whose clock is managed by
> GMU on newer SoCs. Can you take a look at this?

Any update on this ?

-- 
viresh
