Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4412F6319D4
	for <lists+linux-pm@lfdr.de>; Mon, 21 Nov 2022 07:45:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229747AbiKUGpO (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 21 Nov 2022 01:45:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229772AbiKUGpN (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 21 Nov 2022 01:45:13 -0500
Received: from mail-pg1-x52e.google.com (mail-pg1-x52e.google.com [IPv6:2607:f8b0:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 906371A22D
        for <linux-pm@vger.kernel.org>; Sun, 20 Nov 2022 22:45:11 -0800 (PST)
Received: by mail-pg1-x52e.google.com with SMTP id f3so10325923pgc.2
        for <linux-pm@vger.kernel.org>; Sun, 20 Nov 2022 22:45:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=T9z6VNHAh5buPLOQbn4DZRIbuRpf7GLAza5o2jIuncE=;
        b=oyqKPJqV6ChsbvcTQN+xTD9PeymSUxzZ4mMliDJurfoOfDB9tEnQWdI7PQaKjC1D0T
         LIHx/SMR/6Q/7er1lusBloufr8W4xin7Qq2hfmIpZnRdWzTrEgCcgBJA2GhjmelaXvsI
         V7iWawCflMlMvGxfITd89DW2MG1jgB1MG167Rh5uUUwRYS17aFVz9aT+XBY/hlbLXUwY
         CII1XP/HqWT5StaQo6HXfG3eMIcMvfjbKa9TWZCNplJ5aPb92KuZsbTfZ/2Z9JSee89L
         mm+TGdN+02s25vkFuC/G+eQWp3OjSa/6P8LrPLB2/LUD8mcMO7Mxdimiu+/fdxahIwPo
         NxTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=T9z6VNHAh5buPLOQbn4DZRIbuRpf7GLAza5o2jIuncE=;
        b=Eej7j3KFhzz2LEmMHyWcVEwI8zbThVUGsmj9RVx8mE8IymW4bEkUSTm+27/q1ojwRM
         pPOTQcdcd6kbL4wY9kzmtFpZn+9ZpCDN86ZUBd78W3zzK1NpqKdkcQpE3vRKfy04IMUH
         thSHohmcWl9xYHrZl5vP+39ehkJLNqhEpU2JM3uLRLtOa+2HSl7jejq4ur1vl8XTUcQu
         6Ke/DefKVC5AV8dxBLDXaI336Ag/P0fOkUmszMf9fjJ42A1lYZgmEK6lv5IcbRmZQC8B
         WPV8UnoUPA1U2H0hvQgI162pZ9BS7XAS2zeNs+qJG0towqynlWLOH/hKjdrMouPg/Vqp
         fhxA==
X-Gm-Message-State: ANoB5pkQS4MrMEQj0r4vwb9cWQMwSiYBPSJTfrz/xmHwjAVDypBSdA2A
        e6a7OxYOu0IWw+xfYUiXRqk2
X-Google-Smtp-Source: AA0mqf6ddMnQGXatGtIKDuBbyT3kbY7n1kpxrE0Vd9I/tQTaSSyurICcwD9LRXBLZlh0j9EpMLqbdA==
X-Received: by 2002:a63:5007:0:b0:45f:beda:4116 with SMTP id e7-20020a635007000000b0045fbeda4116mr789381pgb.618.1669013110909;
        Sun, 20 Nov 2022 22:45:10 -0800 (PST)
Received: from thinkpad ([59.92.99.222])
        by smtp.gmail.com with ESMTPSA id d187-20020a6236c4000000b0053e62b6fd22sm7752028pfa.126.2022.11.20.22.45.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 20 Nov 2022 22:45:09 -0800 (PST)
Date:   Mon, 21 Nov 2022 12:15:07 +0530
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     Viresh Kumar <viresh.kumar@linaro.org>
Cc:     andersson@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        rafael@kernel.org, robh+dt@kernel.org, johan@kernel.org,
        devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Subject: Re: [PATCH v7 0/4] qcom-cpufreq-hw: Add CPU clock provider support
Message-ID: <20221121064507.GC11945@thinkpad>
References: <20221117053145.10409-1-manivannan.sadhasivam@linaro.org>
 <20221121051959.hphzjuaif423xwn6@vireshk-i7>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20221121051959.hphzjuaif423xwn6@vireshk-i7>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Mon, Nov 21, 2022 at 10:49:59AM +0530, Viresh Kumar wrote:
> On 17-11-22, 11:01, Manivannan Sadhasivam wrote:
> > Hello,
> > 
> > This series adds clock provider support to the Qcom CPUFreq driver for
> > supplying the clocks to the CPU cores in Qcom SoCs.
> > 
> > The Qualcomm platforms making use of CPUFreq HW Engine (EPSS/OSM) supply
> > clocks to the CPU cores. But this is not represented clearly in devicetree.
> > There is no clock coming out of the CPUFreq HW node to the CPU. This created
> > an issue [1] with the OPP core when a recent enhancement series was submitted.
> > Eventhough the issue got fixed in the OPP framework in the meantime, that's
> > not a proper solution and this series aims to fix it properly.
> > 
> > There was also an attempt made by Viresh [2] to fix the issue by moving the
> > clocks supplied to the CPUFreq HW node to the CPU. But that was not accepted
> > since those clocks belong to the CPUFreq HW node only.
> > 
> > The proposal here is to add clock provider support to the Qcom CPUFreq HW
> > driver to supply clocks to the CPUs that comes out of the EPSS/OSM block.
> > This correctly reflects the hardware implementation.
> > 
> > The clock provider is a simple one that just provides the frequency of the
> > clocks supplied to each frequency domain in the SoC using .recalc_rate()
> > callback. The frequency supplied by the driver will be the actual frequency
> > that comes out of the EPSS/OSM block after the DCVS operation. This frequency
> > is not same as what the CPUFreq framework has set but it is the one that gets
> > supplied to the CPUs after throttling by LMh.
> > 
> > This series has been tested on SM8450 based dev board with the OPP hack removed
> > and hence there is a DTS change only for that platform. Once this series gets
> > accepted, rest of the platform DTS can also be modified and finally the hack on
> > the OPP core can be dropped.
> 
> Applied. Thanks.
> 
> If you get review comments later on, please send incremental patches
> for that.
> 

Sure thing.

Thanks,
Mani

> -- 
> viresh

-- 
மணிவண்ணன் சதாசிவம்
