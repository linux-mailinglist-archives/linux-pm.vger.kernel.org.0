Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A7C70714392
	for <lists+linux-pm@lfdr.de>; Mon, 29 May 2023 07:07:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229652AbjE2FHW (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 29 May 2023 01:07:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229521AbjE2FHV (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 29 May 2023 01:07:21 -0400
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83D5E92
        for <linux-pm@vger.kernel.org>; Sun, 28 May 2023 22:07:20 -0700 (PDT)
Received: by mail-pl1-x635.google.com with SMTP id d9443c01a7336-1b011cffef2so25620465ad.3
        for <linux-pm@vger.kernel.org>; Sun, 28 May 2023 22:07:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1685336840; x=1687928840;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=q9sUwlBK46qxesE1hXYhvmEGftJnAtWaPJfITAm6b/I=;
        b=jZV9k7gV51BR83VDhVCqaVMA8M9K1UfVUyOmW76Nq9cU6SkKeTWisJW7D2siKUsEdF
         hSnWjbduNhxmj/943YyA1G8J40eSSAmabMkQxueSy4ebUtpcVHvZ+GcrnOo4YLYvep8q
         5fR+HhllkPVArwf+B1LTuqdRR/jEY+0QgOiqbCD+Ke+fHvxSAlniBs5sioWJmnjsClGs
         ttTAKeADO0B0Im1QkobK6/7aTv+7t+tMDbZftsVW4/cVI8FPGzhs6Jf8oMrZdPbY5MCZ
         lEiSQs+zt+btLSsqnoa4NOzygsV54PEuLYESLZRhsEPw/7ruvH1vyheTjLgeUb1GM5fL
         0Z2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685336840; x=1687928840;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=q9sUwlBK46qxesE1hXYhvmEGftJnAtWaPJfITAm6b/I=;
        b=GoxOuLfEp5Ba1+Okb35hVQAg1FY+wwRfV+DvXJhQ97tEHBOAGTayHNAPVCGSjfWXui
         JwqW4ISwJzNN2mBLzDeyv+3W5MheqG/BNo+Hq7l4jmhuhZUZ8h8keVaqXNSuX//dkH4Y
         0cbcP2oL8a+NXB23FzElQQkjkYEY6CCy6JycBH5m1WWBtCfIU58XTvxIlCcTxu19qn1x
         30EqnCDNx4U+yopfb+XCNRVrXo24Q/pMrcf7/8sRNpL41iPfsO14DkeCGeEV37Q46d/3
         BwLA2LuaRtNoeXReuR//ux+KdV9nPXtyN41UFE3jJT6CDzMZZFG47d0j9flDoGZydbbO
         ePbQ==
X-Gm-Message-State: AC+VfDyoSxXhGOVhcRjRBdcqoMFQPJX/6o3azgum3NSa48OOLqX6iL/f
        0/CTCnD3tZ+mdOPzUltbcrrm/Q==
X-Google-Smtp-Source: ACHHUZ7HLQFKaQ9i5oJP35GxCZzMgVTjDo4Su5uvNn5lyOS4zzN395Vbdg1j05xhXSng2p4sOYPG7A==
X-Received: by 2002:a17:903:182:b0:1af:d812:d16 with SMTP id z2-20020a170903018200b001afd8120d16mr11735860plg.21.1685336839990;
        Sun, 28 May 2023 22:07:19 -0700 (PDT)
Received: from localhost ([122.172.87.195])
        by smtp.gmail.com with ESMTPSA id w14-20020a1709029a8e00b0019719f752c5sm7103623plp.59.2023.05.28.22.07.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 28 May 2023 22:07:19 -0700 (PDT)
Date:   Mon, 29 May 2023 10:37:17 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Conor Dooley <conor@kernel.org>
Cc:     Robert Marko <robimarko@gmail.com>, ilia.lin@kernel.org,
        agross@kernel.org, andersson@kernel.org, konrad.dybcio@linaro.org,
        rafael@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        linux-pm@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        ansuelsmth@gmail.com
Subject: Re: [PATCH 1/2] dt-bindings: cpufreq: qcom-cpufreq-nvmem: document
 IPQ8074
Message-ID: <20230529050717.x5by6iopk4r6wgjy@vireshk-i7>
References: <20230527095229.12019-1-robimarko@gmail.com>
 <20230527-pang-barracuda-7e39f866e1bd@spud>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230527-pang-barracuda-7e39f866e1bd@spud>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 27-05-23, 11:30, Conor Dooley wrote:
> On Sat, May 27, 2023 at 11:52:28AM +0200, Robert Marko wrote:
> > Document IPQ8074 compatible for Qcom NVMEM CPUFreq driver.
> > 
> > Signed-off-by: Robert Marko <robimarko@gmail.com>
> 
> Acked-by: Conor Dooley <conor.dooley@microchip.com>

Applied. Thanks.

-- 
viresh
