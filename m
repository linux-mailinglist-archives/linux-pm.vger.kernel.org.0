Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E7569631976
	for <lists+linux-pm@lfdr.de>; Mon, 21 Nov 2022 06:20:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229558AbiKUFUG (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 21 Nov 2022 00:20:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbiKUFUE (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 21 Nov 2022 00:20:04 -0500
Received: from mail-pg1-x52b.google.com (mail-pg1-x52b.google.com [IPv6:2607:f8b0:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3E3D25E6
        for <linux-pm@vger.kernel.org>; Sun, 20 Nov 2022 21:20:02 -0800 (PST)
Received: by mail-pg1-x52b.google.com with SMTP id 130so10172441pgc.5
        for <linux-pm@vger.kernel.org>; Sun, 20 Nov 2022 21:20:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=SmbSGrfMl5sX57mZPY6ziSauUhzIAv3tjbcoM5dFVJ0=;
        b=WF+QyOdocMZsoAKkxVFEye9m3D809X7KmFNnNW3D+NdIuMak/E1R9mrOppMi7knBeb
         RrHclkIGnq55SD/RFJl3E/GCN0Zi0EOuE0VzLNq7+Unbh8jXR0zMxga6AarB4dgS/2nj
         9oGjeseSlNzcYGEu+jDITIhIo3SyBDZt1TX+tq9SdZEW2Vz69iUxnu1VUhCklR7wtjw0
         aiyeh//5DYB/nu66CC3qBnbQt/KRTltDbzsfZVNi5qb41fFZ1VQ5WWAf8sNYqdGIK0NZ
         GtG3HOY7faNlDbuc/x3TLfRhd1EXumO3p07pWPxYA5uKS751WcmozXEGVEQhdifxYJNw
         orzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SmbSGrfMl5sX57mZPY6ziSauUhzIAv3tjbcoM5dFVJ0=;
        b=LnGfJbKr6TVyU4QA3nPging8+tngQyNj+WymosdWMl/f6zK7+fqDez6YOMclHYv2X4
         OaUshsXlMS8LVVvKV2rgceU7sNA2b6VuVNYHoajBcaQrPvlWGylPgX8zFcKdD0BalN/P
         ZqkKfzHXdhDUnbc7Z4H/QSLhABnm3nmsVEPFNm0QI9HTP8NBl8ZflbNF+SPkABLJxVK2
         9O5aVGiQnc2949VWQtDvCyUWU6VYVL2LvO8qYsnhfvTX0jn7daizzbIEtDOhbC6ObLKB
         SZuxD6LpZ+XWEPY/CI9G8GVufYY0Q4sB3sev6ZFEncieEvYPX/ZJSnpbEpDNWTE42pdG
         Af+w==
X-Gm-Message-State: ANoB5pkpGe9kzvRHlk9kqryq1MOtVwIWmircpQS4XctYkUcF7hziAPlP
        JCer6QCEVcXlVJ0GPbNKNF7q8A==
X-Google-Smtp-Source: AA0mqf7bw/tHtFB6HxDO3PUB2J4xMJ+MOVsMJf7R8bEoFRj/gNrjL5df+ZdsptjiscK9jyTg5wCaMQ==
X-Received: by 2002:a63:1601:0:b0:454:228c:742b with SMTP id w1-20020a631601000000b00454228c742bmr3404949pgl.494.1669008002232;
        Sun, 20 Nov 2022 21:20:02 -0800 (PST)
Received: from localhost ([122.172.85.60])
        by smtp.gmail.com with ESMTPSA id u139-20020a627991000000b00561cf757749sm7616978pfc.183.2022.11.20.21.20.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 20 Nov 2022 21:20:01 -0800 (PST)
Date:   Mon, 21 Nov 2022 10:49:59 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc:     andersson@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        rafael@kernel.org, robh+dt@kernel.org, johan@kernel.org,
        devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Subject: Re: [PATCH v7 0/4] qcom-cpufreq-hw: Add CPU clock provider support
Message-ID: <20221121051959.hphzjuaif423xwn6@vireshk-i7>
References: <20221117053145.10409-1-manivannan.sadhasivam@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221117053145.10409-1-manivannan.sadhasivam@linaro.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 17-11-22, 11:01, Manivannan Sadhasivam wrote:
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

Applied. Thanks.

If you get review comments later on, please send incremental patches
for that.

-- 
viresh
