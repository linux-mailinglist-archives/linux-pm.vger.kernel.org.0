Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2911E570F73
	for <lists+linux-pm@lfdr.de>; Tue, 12 Jul 2022 03:28:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229780AbiGLB2f (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 11 Jul 2022 21:28:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230225AbiGLB2e (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 11 Jul 2022 21:28:34 -0400
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A836B6152
        for <linux-pm@vger.kernel.org>; Mon, 11 Jul 2022 18:28:31 -0700 (PDT)
Received: by mail-pl1-x62c.google.com with SMTP id 5so5933131plk.9
        for <linux-pm@vger.kernel.org>; Mon, 11 Jul 2022 18:28:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=c2vyjIbciyVquzlDajX3qmEOd67pfFD4fFZaxPOLy2U=;
        b=R0rW8hG8pcYKfOtv7wArgQWO4c5J5gecTD+iAR430JXAX1rRfxks45tN1PZOo1Lp8A
         JHvlOivBtB+rUjQ2qULebxMkb3MyOr480SWKomBcypBQ7JjjHMpLl0shHWomPo/xwS58
         AfNQ8E9RhYkIwS5JkRAlMgppwClic61i8pUKX+ZK7qNZPQqJWR1DpZz62ZvTmstIQfRR
         1jTgUyNUZLw7eGAL36cwqNWELwLO/w2TBQhV6aIvvZrEqdsVys0rulPO0TRpdr0D4/lW
         Tne3R6dIhYbGuioSNhq9rJUlkC9l4m0do3gQe519qzyHXHKQgWJRq32fJwVIYPgIPF8q
         HvgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=c2vyjIbciyVquzlDajX3qmEOd67pfFD4fFZaxPOLy2U=;
        b=h/uuv/+LtdLI3mSuNdQEDTnJKKPV/9YzaU9c96Ecau0sCj1pY6uxDITp96d/2ZKbrr
         CyHf+Nxfe7np5BuymUWcXuLw5c59Yjx6fchpkYuFFAvMIdDPdIlNfVla2WFXAHn6pMa9
         wwm8FFEHManYSXNMoO9CBG1qK18pwg0eh8qO22Btx0ZjHzu5O3276ysAjeBKTyTL4oXO
         bcCRtHTLaxGs01YaAZm25u2WCmSCXnlITjsjKmG/My/Xln2Tm5ywTqcxgxloO/u5qSWm
         h6zjMIqKzJStV72nn1HBtPRxHUIceEQ1/PYow27KIiEDWH2MtL8oZsUfvCKj4GMntIfY
         f7HA==
X-Gm-Message-State: AJIora/KuT6MPG+f/I34Tk4u+QAP+fWde0Fz4laxtbbtwPHunCNxiK+2
        m3zVQpgzQ52cMu0WlRsMcRfa4w==
X-Google-Smtp-Source: AGRyM1u1FwY6xJU0oOJI9mtvV2RdU6Dl8F3dLvVLbbm+PSf6Nv5lh52eBhMg0gMvhMbko9Cx4tSdBw==
X-Received: by 2002:a17:902:6901:b0:168:9bb4:7adb with SMTP id j1-20020a170902690100b001689bb47adbmr21486583plk.147.1657589311099;
        Mon, 11 Jul 2022 18:28:31 -0700 (PDT)
Received: from leoy-ThinkPad-X240s (n058152077182.netvigator.com. [58.152.77.182])
        by smtp.gmail.com with ESMTPSA id z62-20020a17090a6d4400b001ef8dd1315esm7613045pjj.27.2022.07.11.18.28.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Jul 2022 18:28:30 -0700 (PDT)
Date:   Tue, 12 Jul 2022 09:28:23 +0800
From:   Leo Yan <leo.yan@linaro.org>
To:     Georgi Djakov <djakov@kernel.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Rob Herring <robh+dt@kernel.org>,
        Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 5/5] interconnect: qcom: icc-rpm: Set bandwidth and
 clock for bucket values
Message-ID: <20220712012823.GA10379@leoy-ThinkPad-X240s>
References: <20220711115240.806236-1-leo.yan@linaro.org>
 <20220711115240.806236-6-leo.yan@linaro.org>
 <480d38db-3114-29d1-8b81-b35a07623060@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <480d38db-3114-29d1-8b81-b35a07623060@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Georgi,

On Mon, Jul 11, 2022 at 04:53:47PM +0300, Georgi Djakov wrote:

[...]

> >   static int qcom_icc_set(struct icc_node *src, struct icc_node *dst)
> >   {
> >   	struct qcom_icc_provider *qp;
> >   	struct qcom_icc_node *src_qn = NULL, *dst_qn = NULL;
> >   	struct icc_provider *provider;
> > -	struct icc_node *n;
> >   	u64 sum_bw;
> > -	u64 max_peak_bw;
> >   	u64 rate;
> > -	u32 agg_avg = 0;
> > -	u32 agg_peak = 0;
> > +	u64 agg_avg[QCOM_ICC_NUM_BUCKETS], agg_peak[QCOM_ICC_NUM_BUCKETS];
> > +	u64 max_agg_avg, max_agg_peak;
> 
> Now max_agg_peak is unused?

Sorry for this mistake.  Will send new patch series soon.

Thanks,
Leo
