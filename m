Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6FE56331AC7
	for <lists+linux-pm@lfdr.de>; Tue,  9 Mar 2021 00:09:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230070AbhCHXIY (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 8 Mar 2021 18:08:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229971AbhCHXHw (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 8 Mar 2021 18:07:52 -0500
Received: from mail-oi1-x22a.google.com (mail-oi1-x22a.google.com [IPv6:2607:f8b0:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8280FC061760
        for <linux-pm@vger.kernel.org>; Mon,  8 Mar 2021 15:07:52 -0800 (PST)
Received: by mail-oi1-x22a.google.com with SMTP id t83so2873137oih.12
        for <linux-pm@vger.kernel.org>; Mon, 08 Mar 2021 15:07:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=4hvbKRFY7Gs9YDqGOyz0/NvmnAh1JPz6EfNarEQ6wA8=;
        b=G674hH9UyzvI0ioSt5BG9expqlepPHZakDtglNtJ5zHcpyc/GmtGTwrnFgcB2qP9rm
         4PZ3Jqc/kZktu5JHYs1/xTfwjbdNykb0Hay6Rhme+ju/0BFUbMkiUQoaNqbpAmFMDpuQ
         QY9lCsH61+rJL91wkQ0Bcca/MFDvG9eXHTrzC5Ebb5u5aTQM/nuVdZkdviREq/fFfZIt
         ogNL0ntfGqyc1ZCeZ8zZUjWu2FdtX7+8CUH+Fv6XJ0m2WKttmicd3C1kZmQMYzfqHMhF
         x3KfvEdj6wFzQclp85rXq2NLVQId/TdH9WL+57kK+B0nBkLjcA5hoDXRlWYEYt8UogQn
         005A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=4hvbKRFY7Gs9YDqGOyz0/NvmnAh1JPz6EfNarEQ6wA8=;
        b=XLXxDS9Ym5dEuAYPHCcbI17DvX+AQ4BH/euKqZQRUT/0sK10y5nmRlmFpCs6lFZkKT
         Hot0qkc3xqRA+7bAJgI080eUSypxzrY3bRCJomw9DcqJiyh2c//ncPSID9QuBKpdL+UF
         bg8jtYAuJGbC0eejw5YR+XxcBq2a+IafYa4Phvde8UJifLDjompFvLBJcfYROjgjZFPW
         1vPNaIt43UxZNiDWJQ4LYjChJdG4aTWDQ2V4OnBBPAhiuM57Gw9MV3HOmwtQJIWeMZzZ
         dwxbScmKq2nS9k3RDketsvGP0yrUf2mDA+F6QV5ynA1NSSwm+toJWRWiDfOGg5GeufFL
         c5Kw==
X-Gm-Message-State: AOAM532gaM+zvYSUuZKVisjcc3tQ6wXvu/pljM0rOu2xMLOYhvgbRckw
        8u3zEm3lrqhv9PlRLu1lX41dKg==
X-Google-Smtp-Source: ABdhPJxE5DEMhzUk2EXfK4SAN7Gzv+ovKX70wN9qc3D+l1U7WWpQVSjnKb+Y0Q99IB5cclKWi21c1Q==
X-Received: by 2002:aca:2b13:: with SMTP id i19mr900239oik.148.1615244871809;
        Mon, 08 Mar 2021 15:07:51 -0800 (PST)
Received: from builder.lan (104-57-184-186.lightspeed.austtx.sbcglobal.net. [104.57.184.186])
        by smtp.gmail.com with ESMTPSA id w7sm2772999oie.7.2021.03.08.15.07.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Mar 2021 15:07:51 -0800 (PST)
Date:   Mon, 8 Mar 2021 17:07:49 -0600
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Konrad Dybcio <konrad.dybcio@somainline.org>
Cc:     phone-devel@vger.kernel.org, ~postmarketos/upstreaming@lists.sr.ht,
        martin.botka@somainline.org,
        angelogioacchino.delregno@somainline.org,
        marijn.suijten@somainline.org, Andy Gross <agross@kernel.org>,
        Amit Kucheria <amitk@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 34/41] arm64: dts: qcom: sdm630-nile: Configure WCN3990
 Bluetooth
Message-ID: <YEauRWCv7PENpiIc@builder.lan>
References: <20210226200414.167762-1-konrad.dybcio@somainline.org>
 <20210226200414.167762-35-konrad.dybcio@somainline.org>
 <71ea4ebd-f446-ede3-7623-ae5b339d7905@somainline.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <71ea4ebd-f446-ede3-7623-ae5b339d7905@somainline.org>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Sat 27 Feb 04:40 CST 2021, Konrad Dybcio wrote:

> 
> > From: AngeloGioacchino Del Regno <angelogioacchino.delregno@somainline.org>
> 
> From: Martin Botka <martin.botka@somainline.org>
> 
> 
> That got caught in rebasing madness.. Should any additional mistakes appear, I'll send a V2.
> 

Patches looks good, but I'm a little bit confused about author and s-o-b
of the once you replied to.

Please respin the whole thing with the proper authors/s-o-b, and I'll be
happy to apply it.

(And please remember to pick up Rob's ack)

Regards,
Bjorn
