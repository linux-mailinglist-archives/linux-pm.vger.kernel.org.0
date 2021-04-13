Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9C1CB35D55D
	for <lists+linux-pm@lfdr.de>; Tue, 13 Apr 2021 04:42:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241707AbhDMCmY (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 12 Apr 2021 22:42:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239982AbhDMCmX (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 12 Apr 2021 22:42:23 -0400
Received: from mail-oo1-xc2e.google.com (mail-oo1-xc2e.google.com [IPv6:2607:f8b0:4864:20::c2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A911C06138C
        for <linux-pm@vger.kernel.org>; Mon, 12 Apr 2021 19:42:03 -0700 (PDT)
Received: by mail-oo1-xc2e.google.com with SMTP id c6-20020a4aacc60000b02901e6260b12e2so1012235oon.3
        for <linux-pm@vger.kernel.org>; Mon, 12 Apr 2021 19:42:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=TqizwtPBazn4E4BBJNz6As5MhBNbZCtWHV//Y0hIMZs=;
        b=ufItUzbBA4ZaQvXf4xjPrThPuCmG9xp5YKrfIgj5lJ/k/q31+z1o5Fqxr4FpxNcD2L
         YYS/8XWFhyE0UlbGwRvmncuhuAZ3sF/ClB4lvmyAFip9MkK7AfUedWjLWrlwD1Mqj4nW
         SGhRLRC+6K6eYBaDwsEiC/jzBmmuLSD/RM4PA4lvlYchP6CAxOXzZqm32ZIukLfpkuHg
         IZ/wWYl+qgQQKoLCuFdOTDmeXNqQhVYH7lvSCWnHEtqq4eo9TJqclX66IA2WLdPBQBw9
         VqiB3uB7qXowzEGR/YgLscEXJFXVp1sGMMYOg51ghSxA9ubAxtdcQBYmVi/8CNz+Me7Y
         xJCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=TqizwtPBazn4E4BBJNz6As5MhBNbZCtWHV//Y0hIMZs=;
        b=t8LLZ1X3C8zK080vnS80iZsAsckuJhc3qX287qXM8b2AqL5IjNXog2L625PNMVbjL3
         nH1cs14Q4OxrsFP0tFAYJkAh7zxaCme/7GyrzU+uDjVl8Pesw8dW0AU9VAeaBM66VOBx
         Lzq12bQbYsaXbMSFYCkaKh5QHh6jXwZMLt+1xnnHsojGUnihiT4LzmrsFtgC5WrXE5/Z
         KcVqDbNs+BPX2OeJkbk5HJj9bd0Wy8tMoH5KJBSAvfQydUs8gNZDn381wM95tuUMayC2
         V3BrdsaKtOAwNKpIIF1U2+G352jdVb/2xHWDyeShhG3W7ZmDwHFgrfBih6PHnG/mLcnV
         ZxkA==
X-Gm-Message-State: AOAM530BfaoIFvkxif5VC2qLFKY5uDn2T2G9I5z4orsbcQAia5CL00B1
        fNTluTEcDCujHgVd6B8NGaoGOA==
X-Google-Smtp-Source: ABdhPJwln6Bs1UzxhLsh5C748sEIkLCsUk9ZEx7meQ8HiDvRIVlzkHLxp/oktk9yVkRk9+E4wKBhNg==
X-Received: by 2002:a05:6820:20a:: with SMTP id i10mr25119420oob.6.1618281722315;
        Mon, 12 Apr 2021 19:42:02 -0700 (PDT)
Received: from yoga (104-57-184-186.lightspeed.austtx.sbcglobal.net. [104.57.184.186])
        by smtp.gmail.com with ESMTPSA id q1sm1850149otm.26.2021.04.12.19.42.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Apr 2021 19:42:01 -0700 (PDT)
Date:   Mon, 12 Apr 2021 21:41:59 -0500
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Viresh Kumar <viresh.kumar@linaro.org>
Cc:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@somainline.org>, agross@kernel.org,
        rjw@rjwysocki.net, devicetree@vger.kernel.org, robh+dt@kernel.org,
        amit.kucheria@linaro.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, phone-devel@vger.kernel.org,
        konrad.dybcio@somainline.org, marijn.suijten@somainline.org,
        martin.botka@somainline.org, jeffrey.l.hugo@gmail.com
Subject: Re: [PATCH v4 0/7] cpufreq-qcom-hw: Implement full OSM programming
Message-ID: <20210413024159.GI1538589@yoga>
References: <20210119174557.227318-1-angelogioacchino.delregno@somainline.org>
 <20210412051135.xtpokwrbclaptbot@vireshk-i7>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210412051135.xtpokwrbclaptbot@vireshk-i7>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Mon 12 Apr 00:11 CDT 2021, Viresh Kumar wrote:

> On 19-01-21, 18:45, AngeloGioacchino Del Regno wrote:
> >   **
> >   ** NOTE: To "view the full picture", please look at the following
> >   ** patch series:
> >   ** https://patchwork.kernel.org/project/linux-arm-msm/list/?series=413355
> >   **              This is a subset of that series.
> >   **
> > 
> > Changes in v4:
> > - Huge patch series has been split for better reviewability,
> >   as suggested by Bjorn
> > - Rebased code on top of 266991721c15 ("cpufreq: qcom-hw: enable boost
> >   support")
> 
> Bjorn, what am I supposed to do with patchset ? Is there anyone who can give
> this some reviews from qcom team ?
> 

Sorry Viresh, I've been postponing reviewing this a few times too many.
I'll take the time in the coming days to look through it properly,
including Taniya's feedback.

Regards,
Bjorn
