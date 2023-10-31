Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A22C7DC4F3
	for <lists+linux-pm@lfdr.de>; Tue, 31 Oct 2023 04:46:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232710AbjJaDqA (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 30 Oct 2023 23:46:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230084AbjJaDp7 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 30 Oct 2023 23:45:59 -0400
Received: from mail-pg1-x529.google.com (mail-pg1-x529.google.com [IPv6:2607:f8b0:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62758B3
        for <linux-pm@vger.kernel.org>; Mon, 30 Oct 2023 20:45:55 -0700 (PDT)
Received: by mail-pg1-x529.google.com with SMTP id 41be03b00d2f7-5b980391d70so1743592a12.0
        for <linux-pm@vger.kernel.org>; Mon, 30 Oct 2023 20:45:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1698723955; x=1699328755; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=w8/wE2g+0JjshJl7bcdAyR9d3Vqag6K8PTfQXcdaHRQ=;
        b=WPTZI9K059QI+gUcvsH7yUYcDqMM+Ux3qDnRYYVLPl6GR28sdkn1c4sQJ3em3VLfYb
         Y7Izwm65HCiNONUufJvlDd4AiZiQi61xDlkckhj3QTv5L8kRzg3et808PcjOf8jfto86
         EYQeIG2WA+mXdzVST26Fo1D01RbylUe+mMzTmmCZVkOnFLWKINJFHP3n274cVd0/W1z1
         UfKSrTsNmDJF+I94DNLpwfA1f/26ttxcwn4g59H63EDwnY1PENoym9NFyzCQrUA+m8SG
         HS5VVdb5ePZ4ccQ1JhL6mPTQDCKhTWMw5Y0K2ULCcNnXZziLtwq8VrImqQFhuq+tvONA
         bRog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698723955; x=1699328755;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=w8/wE2g+0JjshJl7bcdAyR9d3Vqag6K8PTfQXcdaHRQ=;
        b=dqDvwyJxn85l9Zc7xBV94OejvkT2G+PdE4qGnEtf67fHWpsonPSSn58gyRU10FgXU0
         u/7suuEwiw8p6wGiRDIfpV2kPcDJq/oEYlWnNUL78Qyp0z/DMnMKf8j63GOlHj/PrLMj
         DYup2KwA4ygL5bHPJKsVkvlso3pK0JVdFYg330Qh2NiPdz/x8L5mABBfuUNKznUYK50E
         qMdwnPwPD/xVBpI9p9gUUqc2OM8VE8oENFIzEG/wzI96BEKTs/HbFP5nN1I5kr1YbjCI
         raIFcr7mIrC7ZxHGUMF7uRyxI1UjWRxyIqoT9xBx11NMmqPWPnVUMfB5wVi50S76PpoV
         Nh3Q==
X-Gm-Message-State: AOJu0Yzo7h92+UrI6tfY2Ed1JCaymysrY4BRgtrwoLPjtC8aOOabAIgR
        qyzJxp/qv9w2fNSBufGwqH28iw==
X-Google-Smtp-Source: AGHT+IEAqd9bqU+J8II0h06XxRLcU7ldfaAV4k81tSJqPNpoAUNUa2rIutxl8A9k9kQCNZtz37HTig==
X-Received: by 2002:a05:6a21:4881:b0:180:ebec:da31 with SMTP id av1-20020a056a21488100b00180ebecda31mr1187889pzc.8.1698723954798;
        Mon, 30 Oct 2023 20:45:54 -0700 (PDT)
Received: from localhost ([122.172.80.14])
        by smtp.gmail.com with ESMTPSA id d5-20020a170902c18500b001b03f208323sm244356pld.64.2023.10.30.20.45.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Oct 2023 20:45:53 -0700 (PDT)
Date:   Tue, 31 Oct 2023 09:15:51 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Rob Herring <robh@kernel.org>
Cc:     Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
        Stephen Boyd <sboyd@kernel.org>, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [RESEND PATCH] opp: ti: Use device_get_match_data()
Message-ID: <20231031034551.iiroxfz7qoz5r7yn@vireshk-i7>
References: <20231030135411.776744-1-robh@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231030135411.776744-1-robh@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hmm, somehow I didn't receive the direct mail last time to my Linaro account
(alias of kernel.org). I do see the message being posted to LKML though.

On 30-10-23, 08:54, Rob Herring wrote:

Isn't it is compulsory to add some details in the commit log ?

> Signed-off-by: Rob Herring <robh@kernel.org>
> ---
>  drivers/opp/ti-opp-supply.c | 13 +++----------
>  1 file changed, 3 insertions(+), 10 deletions(-)

-- 
viresh
