Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C026F61EFF9
	for <lists+linux-pm@lfdr.de>; Mon,  7 Nov 2022 11:10:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231139AbiKGKKs (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 7 Nov 2022 05:10:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231958AbiKGKKp (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 7 Nov 2022 05:10:45 -0500
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42C2118E00
        for <linux-pm@vger.kernel.org>; Mon,  7 Nov 2022 02:10:40 -0800 (PST)
Received: by mail-pj1-x102f.google.com with SMTP id v4-20020a17090a088400b00212cb0ed97eso9810772pjc.5
        for <linux-pm@vger.kernel.org>; Mon, 07 Nov 2022 02:10:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=FfPdfiMeb7d1wqxRJF5SGqNPveJ8RGTJz9eypb5I398=;
        b=QRAKC0O/czl9M13T+3PhWmbh80wgYcJY4mUdtbe6tgrI21Y/li8UELVy/SXJDsjhuf
         Aj6rCClLWrMGVjFAloN7f1z0OS0nc/Poi8dcqTzwWzDRHjRU5V+33JvABee6FX7UxUpq
         Pyxw3E3Hdk5FL4FOURTc69VfN6TuQndh227ApkrYyTFk2QkKdtstkuPZjDpeocJ54DSc
         9yVDJTHtkKsMs1JYnQUHIIB3GLQf45Uv9pwibcV5XExMQRlsyDS/QcXoUtFNERO0JnTh
         ddH2qO97LkFfqy8LiLW+fdO57RRar81fBioDAsOFWupLAiyX7Zm1Gn1lazyCy28Rncz4
         96Lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FfPdfiMeb7d1wqxRJF5SGqNPveJ8RGTJz9eypb5I398=;
        b=U4C4De/40c3nTrJLs/p+0lhpO/wOWJjiaukM0TcQOeK4usemFjy49r5QSxp/kEyekV
         jmN9empixTLaukdx28b8/xXemscWCEIUuCZduwm4GPhcf5ruzN6fRMAw6cak0e3SFPKO
         1NpAu7q1pnAfDggBEm3YPBMSuiqXsiVlQd8pMmD+fzwq7e+xV2rOJqT4BUl3iEm5t77v
         KxjJt0g0vHSCKPkhv7SuWsMGFLo2cQ5S+YX4zblGg6tSfDHqqOqMFu3HfCpB87ZdSi1c
         gaR4xAYMr2QBELX8boqy4Y/pJPOu4iM0MCV3kPvnf/FK/Z95j6T83v9XpCjQj/QyJ6Qx
         7vsw==
X-Gm-Message-State: ACrzQf2CWVUlOVfKLqYJgAqOkvhd8ScWy5lmVZUXy7EGFYlIjvmiodhP
        a7khqUcKdO1jZD4ozyNtTrE8yg==
X-Google-Smtp-Source: AMsMyM5wdIkrf+yOc4+6Vs63SokbBXQbTLJA1hO5szkzyKlNeT/uk/iXDwA0JgqMhFD2VO/BKkAjIw==
X-Received: by 2002:a17:90a:17c8:b0:213:f1db:3119 with SMTP id q66-20020a17090a17c800b00213f1db3119mr39204252pja.190.1667815839749;
        Mon, 07 Nov 2022 02:10:39 -0800 (PST)
Received: from localhost ([122.172.84.80])
        by smtp.gmail.com with ESMTPSA id mn22-20020a17090b189600b001faafa42a9esm3918221pjb.26.2022.11.07.02.10.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Nov 2022 02:10:38 -0800 (PST)
Date:   Mon, 7 Nov 2022 15:40:37 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     andersson@kernel.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc:     krzysztof.kozlowski+dt@linaro.org, rafael@kernel.org,
        robh+dt@kernel.org, johan@kernel.org, devicetree@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org
Subject: Re: [PATCH v4 0/3] qcom-cpufreq-hw: Add CPU clock provider support
Message-ID: <20221107101037.kcs2d2tvpmwdnzgq@vireshk-i7>
References: <20221102090818.65321-1-manivannan.sadhasivam@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221102090818.65321-1-manivannan.sadhasivam@linaro.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 02-11-22, 14:38, Manivannan Sadhasivam wrote:
> Hello,
> 
> This series adds clock provider support to the Qcom CPUFreq driver for
> supplying the clocks to the CPU cores in Qcom SoCs.
> 
> The Qualcomm platforms making use of CPUFreq HW Engine (EPSS/OSM) supply
> clocks to the CPU cores. But this is not represented clearly in devicetree.
> There is no clock coming out of the CPUFreq HW node to the CPU. This created
> an issue [1] with the OPP core when a recent enhancement series was submitted.
> Eventhough the issue got fixed in the OPP framework in the meantime, that's
> not a proper solution and this series aims to fix it properly.
> 
> There was also an attempt made by Viresh [2] to fix the issue by moving the
> clocks supplied to the CPUFreq HW node to the CPU. But that was not accepted
> since those clocks belong to the CPUFreq HW node only.
> 
> The proposal here is to add clock provider support to the Qcom CPUFreq HW
> driver to supply clocks to the CPUs that comes out of the EPSS/OSM block.
> This correctly reflects the hardware implementation.
> 
> The clock provider is a simple one that just provides the frequency of the
> clocks supplied to each frequency domain in the SoC using .recalc_rate()
> callback. The frequency supplied by the driver will be the actual frequency
> that comes out of the EPSS/OSM block after the DCVS operation. This frequency
> is not same as what the CPUFreq framework has set but it is the one that gets
> supplied to the CPUs after throttling by LMh.
> 
> This series has been tested on SM8450 based dev board with the OPP hack removed
> and hence there is a DTS change only for that platform. Once this series gets
> accepted, rest of the platform DTS can also be modified and finally the hack on
> the OPP core can be dropped.

Would be better to get an Ack from Bjorn before I apply these.

-- 
viresh
