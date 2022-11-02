Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE07D615B6E
	for <lists+linux-pm@lfdr.de>; Wed,  2 Nov 2022 05:28:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229548AbiKBE2y (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 2 Nov 2022 00:28:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229462AbiKBE2x (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 2 Nov 2022 00:28:53 -0400
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7298BBBE
        for <linux-pm@vger.kernel.org>; Tue,  1 Nov 2022 21:28:52 -0700 (PDT)
Received: by mail-pj1-x102e.google.com with SMTP id m14-20020a17090a3f8e00b00212dab39bcdso1050112pjc.0
        for <linux-pm@vger.kernel.org>; Tue, 01 Nov 2022 21:28:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=VGNiahs6hX5ZvMHkL2FovfAhXr5AX8OYLJp5JLaYUCU=;
        b=j7sT/eTuWOFh4nxlTckUHUlheNTNZry/B3vaZ31/z8qoUmHkWtsdc31aTiqWojROLW
         h+joxl12X39mR768q+urvQFEsHA3l7qTGADYEKAncj3OSi7GbUlB7US5DT+8Jw1VJNKL
         dA1jj3MQqUMEbse0RSZ7uNLpfX7D4HjEMJvmvJYbO8CIwFGZOS9LNiOqpwh7Tm1wqcfR
         L4puIMmN8KF33MkP/1/MCNHQ/CSYIvzShfpvhTE3tt73PiluLhs12cLQt9SbbhvwNUMe
         1uzjyTZ/0xES3nrbQ5GWbr2MqV2C5AA8z16lVLIBcQ+pKGE6IBjFr0zXs0eEGLtL+DfM
         xUbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VGNiahs6hX5ZvMHkL2FovfAhXr5AX8OYLJp5JLaYUCU=;
        b=e/yQ1huiPV/jAtu2tYNKVxIKxzabwTCM+2WQuu/ivb1roG3UxlwSdfy6bicuGx1A75
         NVd8lbIwClrp2GZrBKv9890otyTy8STJGh8v7HMIDYLbMUR7Pg+M9kavrGR/jbAogkj2
         vkyULJT8HhgF+0XGsA6IZ2aNTLuFwckMdnJ+bfbIiVUoJhdGCzhMYJoMIDfZEXRfiOT9
         VQolkcWXqrgNjG66TOfZTttkrkBM41wSiSaB8EbT7390LGbEcxuLs1weRhU76FonmDC3
         mr7/yos5kuNIyimNyDMOxDDi6ynvelj/jO1owwlMPwbfY4KPJF5J0qKLSH0FJVA2zqsJ
         p8nQ==
X-Gm-Message-State: ACrzQf0Yddz30iA37U5DPkv9hedwenq7ZYr2sRN0JK5VOJjbljLitHCk
        886jXN6ig+PKHrs1aAdigjkt2w==
X-Google-Smtp-Source: AMsMyM4xh8AbMmR+mGtUChrGRjwUGbaKq6o9iCpRPiFkv4uKhs/y2DXP2sWUkw3nooe4OdnCvmppHw==
X-Received: by 2002:a17:903:2352:b0:186:aaed:e7b8 with SMTP id c18-20020a170903235200b00186aaede7b8mr22467061plh.47.1667363331996;
        Tue, 01 Nov 2022 21:28:51 -0700 (PDT)
Received: from localhost ([122.172.84.80])
        by smtp.gmail.com with ESMTPSA id kx2-20020a17090b228200b00200a85fa777sm406615pjb.1.2022.11.01.21.28.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Nov 2022 21:28:51 -0700 (PDT)
Date:   Wed, 2 Nov 2022 09:58:49 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc:     andersson@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        rafael@kernel.org, robh+dt@kernel.org, johan@kernel.org,
        devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Subject: Re: [PATCH v2 7/7] cpufreq: qcom-hw: Add CPU clock provider support
Message-ID: <20221102042849.q3qnaoebeudpbpnv@vireshk-i7>
References: <20221025073254.1564622-1-manivannan.sadhasivam@linaro.org>
 <20221025073254.1564622-8-manivannan.sadhasivam@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221025073254.1564622-8-manivannan.sadhasivam@linaro.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 25-10-22, 13:02, Manivannan Sadhasivam wrote:
>  	for (i = 0; i < num_domains; i++) {
>  		struct qcom_cpufreq_data *data = &qcom_cpufreq.data[i];
> +		static struct clk_init_data init = {};

Why not make this part of a driver level structure instead of static ?
And what will {} do ? Initialize to 0 ? static would have already done
that.

-- 
viresh
