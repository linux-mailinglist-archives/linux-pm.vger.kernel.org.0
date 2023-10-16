Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 926427C9DAC
	for <lists+linux-pm@lfdr.de>; Mon, 16 Oct 2023 05:19:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231464AbjJPDTb (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 15 Oct 2023 23:19:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230451AbjJPDTa (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 15 Oct 2023 23:19:30 -0400
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E01FD6
        for <linux-pm@vger.kernel.org>; Sun, 15 Oct 2023 20:19:28 -0700 (PDT)
Received: by mail-pj1-x1030.google.com with SMTP id 98e67ed59e1d1-27d0251d305so2087362a91.2
        for <linux-pm@vger.kernel.org>; Sun, 15 Oct 2023 20:19:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1697426368; x=1698031168; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=pDYopfK40jPubbfAMF0ZB98ABj9yrqlTAb4VRGo8NsM=;
        b=oWHer8PnXr3OD+mogE5TjrmVcequgErZ1BXNuaJelY3NJzWbfrVpL3PrxNQqG6VFnz
         2U3grcedmhp9DckNJP1yq2ITip+qP4JbkbJwxK41VZTOXSWIoGkPHzUUGXbBb4HGzDPP
         ehaM9h5HpnIMbYR/loIjA6kZ1YKeMPGJnLFA7zCqt1W4axXmzMLHAuW0e+UXKiMExM8y
         0hmnz5Clj3Il9Cxggn2WdKHY44YHmOixs2eMfn8OyXbEisGonDar7akdG0AEU56Fy3W/
         3rI4K7f0UMFslEx39tlmnZNF267FvPBxWE59C4NVDj43jQ/MRRpvSVcrzQ2wVm8QUTpk
         e4pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697426368; x=1698031168;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pDYopfK40jPubbfAMF0ZB98ABj9yrqlTAb4VRGo8NsM=;
        b=AywR9ENZddlzB/djDIWQy9z/WjH9H+TI01fL0460h400enQBXnwDa36z8YoGk3kb4b
         YOnAy2UXV6SSNDBeGgGNaOh7xoYyGSaiW2pRE+D3AjF/f8tadpehHX9bm9nIdFemGn99
         N0yB74PvUcFdgYYcKHRSPnXQFq4BRHBYNPjE1RkfHNAZ9QkRLq9if6cFFawAYls0KSRX
         leJMxb3dEO7Gac7qDWNXxd+JHxMTPMAsTLTFZ9VfT3Wj4VDSsumFoBD/ketK5pI9i0v9
         29PMdboBNxAPiPlzhN+wgDdMhz4tgJjRdJl0nD85Lse9dstytllHCAaw9xyThk/7OAHy
         VE5Q==
X-Gm-Message-State: AOJu0Yyt0CVC0q+pyq6MOyR4kizlPjAQEUBT24Rp/keEA/m8AUMYFelX
        tpD0Va2x/bvt7MBECbqnBg635A==
X-Google-Smtp-Source: AGHT+IGxPwpQoJbeM42Kx91ViLrPK676fLQ+CDc22svG4x4yLe446Rh+QuDeJMDtUYlcQYEaVooOGg==
X-Received: by 2002:a17:90b:4e8f:b0:27d:492e:137a with SMTP id sr15-20020a17090b4e8f00b0027d492e137amr4631222pjb.45.1697426367777;
        Sun, 15 Oct 2023 20:19:27 -0700 (PDT)
Received: from localhost ([122.172.80.14])
        by smtp.gmail.com with ESMTPSA id ge9-20020a17090b0e0900b0026b3a86b0d5sm3648903pjb.33.2023.10.15.20.19.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 15 Oct 2023 20:19:26 -0700 (PDT)
Date:   Mon, 16 Oct 2023 08:49:16 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Manivannan Sadhasivam <mani@kernel.org>
Cc:     Rohit Agarwal <quic_rohiagar@quicinc.com>, agross@kernel.org,
        andersson@kernel.org, konrad.dybcio@linaro.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        rafael@kernel.org, tglx@linutronix.de, maz@kernel.org,
        robimarko@gmail.com, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org
Subject: Re: [PATCH v4 4/5] dt-bindings: cpufreq: cpufreq-qcom-hw: Add SDX75
 compatible
Message-ID: <20231016031916.mprtotrnkg5htyid@vireshk-i7>
References: <1686311438-24177-1-git-send-email-quic_rohiagar@quicinc.com>
 <1686311438-24177-5-git-send-email-quic_rohiagar@quicinc.com>
 <20230609155635.GF6847@thinkpad>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230609155635.GF6847@thinkpad>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 09-06-23, 21:26, Manivannan Sadhasivam wrote:
> On Fri, Jun 09, 2023 at 05:20:37PM +0530, Rohit Agarwal wrote:
> > Add compatible for EPSS CPUFREQ-HW on SDX75.
> > 
> > Signed-off-by: Rohit Agarwal <quic_rohiagar@quicinc.com>
> 
> Acked-by: Manivannan Sadhasivam <mani@kernel.org>

Applied. Thanks.

-- 
viresh
