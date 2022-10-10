Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 76F335F97B3
	for <lists+linux-pm@lfdr.de>; Mon, 10 Oct 2022 07:17:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230253AbiJJFRI (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 10 Oct 2022 01:17:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229546AbiJJFRF (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 10 Oct 2022 01:17:05 -0400
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ABC954D4D0
        for <linux-pm@vger.kernel.org>; Sun,  9 Oct 2022 22:17:04 -0700 (PDT)
Received: by mail-pl1-x62c.google.com with SMTP id c24so9403034pls.9
        for <linux-pm@vger.kernel.org>; Sun, 09 Oct 2022 22:17:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=TUWTlqEj5JWA3cymAkX5jVFzyKQy4OyRhFvxdWRqESY=;
        b=rxy6vI5LG209fPsCdbieUHJTe4XVZPFimIwV7gmIese3WGElaaE/Vf0a757rKhwOns
         dwoR/Nzih6W+CNTrJ13eL29H3jd99rEbH59DeDE5VoRULdEe51gH/Ssv5siSXr7Uyf8l
         iy6umHCMFXymiv8zDIF17ha7cbPlwhvjUglwSPss7X/X29EvEp0NI+3TEx6+rTdL5BWA
         IIlbD3TFjYLHyEcY3WAImdU11xmJN7gyCme9E007m8RL2k8tr04jKCMe+8XCvUTYiSQ6
         PMH8VCcYE9K7ZX7ktSN31jrCDsJ59Hb5oV5jt3lmrC1aKgI3N2MuSBR7/6ydJlKTnE6s
         Ujsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TUWTlqEj5JWA3cymAkX5jVFzyKQy4OyRhFvxdWRqESY=;
        b=EOzvd4pNZvBQJ6p4sQqzpGQsbQcFYFh9QgEkIOkRq7ZfUNbVzCux2vRONW7KVd2Dwk
         WM0k6oSwqQeGb/NPq3ofcg88F8qezhe8epzNCTqwF2uUmAOlm8QJ/fDQdsI2euO4aXJQ
         TxsCBkiIEotSlfzYRQIFDFYWZvYlbMHgX1T1HLdlTYLMp9Z2M69nc5sQx0w+ojix/mpB
         zmu1XgEM+g9ACTzxBPObgAIv5ZljeH5x4HpXikUlqx5XnHZGeVkJqIlcZo2AcxXeiK6j
         ilnm9PTStFToo5nMN97IsGzQbLarDZorn6uiRzlMaBIaa+KbjC9MbsfUom36RmJX2u75
         FRiA==
X-Gm-Message-State: ACrzQf2SOjtPIOe4hJIrQZjRG0c8nUHaU+E+7qsOSVAoC3KyuSqUL2wD
        /eei7gUwYd5qVk1C2Tx02Xzokg==
X-Google-Smtp-Source: AMsMyM5EFzT12uCpl+TN78sYq6riM8l0k5H56tLUqytKgP5oj1J7Z3sXfa/UFr94AwIsJBCEXzC8xg==
X-Received: by 2002:a17:902:bb86:b0:17c:4cac:eea4 with SMTP id m6-20020a170902bb8600b0017c4caceea4mr16662325pls.141.1665379024236;
        Sun, 09 Oct 2022 22:17:04 -0700 (PDT)
Received: from localhost ([122.172.86.128])
        by smtp.gmail.com with ESMTPSA id i15-20020a17090332cf00b0017f6c9622b9sm5593969plr.183.2022.10.09.22.17.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 09 Oct 2022 22:17:03 -0700 (PDT)
Date:   Mon, 10 Oct 2022 10:47:01 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Yang Yingliang <yangyingliang@huawei.com>
Cc:     linux-pm@vger.kernel.org, rafael@kernel.org
Subject: Re: [PATCH -next 0/4] cpufreq: Switch to use dev_err_probe() helper
Message-ID: <20221010051701.a2s4u5g76466bqbv@vireshk-i7>
References: <20220927154021.816570-1-yangyingliang@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220927154021.816570-1-yangyingliang@huawei.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 27-09-22, 23:40, Yang Yingliang wrote:
> This patchset is trying to replace dev_err() with dev_err_probe() in
> the probe path. With this helper, it prints the error name instead of
> printing error code which is more readable and sets the defer probe
> reason which can be checked later through debugfs, and it makes error
> path more clean.
> 
> Yang Yingliang (4):
>   cpufreq: dt: Switch to use dev_err_probe() helper
>   cpufreq: imx6q: Switch to use dev_err_probe() helper
>   cpufreq: qcom-nvmem: Switch to use dev_err_probe() helper
>   cpufreq: sun50i: Switch to use dev_err_probe() helper
> 
>  drivers/cpufreq/cpufreq-dt.c           | 6 ++----
>  drivers/cpufreq/imx6q-cpufreq.c        | 4 +---
>  drivers/cpufreq/qcom-cpufreq-nvmem.c   | 7 ++-----
>  drivers/cpufreq/sun50i-cpufreq-nvmem.c | 9 +++------
>  4 files changed, 8 insertions(+), 18 deletions(-)

Applied. Thanks.

-- 
viresh
