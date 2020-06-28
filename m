Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7585C20C6E2
	for <lists+linux-pm@lfdr.de>; Sun, 28 Jun 2020 10:02:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726038AbgF1ICj (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 28 Jun 2020 04:02:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725996AbgF1ICi (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 28 Jun 2020 04:02:38 -0400
Received: from mail-ed1-x543.google.com (mail-ed1-x543.google.com [IPv6:2a00:1450:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DEA9C061794;
        Sun, 28 Jun 2020 01:02:38 -0700 (PDT)
Received: by mail-ed1-x543.google.com with SMTP id dm19so3834336edb.13;
        Sun, 28 Jun 2020 01:02:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ImT/z6HRlqF9wUIfKM7sD2bCnF81PCfYcsSDMaBnhGc=;
        b=FoxSsu1cPWMqMvmeVSqteaMCX49HGWdG8tw5XWmMjTQ5VkJYnC8ZfO3OHO3NaNjP3L
         GieCzjGP5IOxy2qrUCS939V6uAGuPRRRYKAdBRDO2GcUZu2WGHcVAEJk7HInpZGrpcPE
         1Uid9r32oMOXA9k/nqVs1xNovcBHwDudpfzRJQmbiNRTNuEUJTRRflfwmmOpIYla9Nzy
         pmEvJCyAZ85E1Kz7sAsuu4YoVMORHRulZZbTr6EO7hJo9gBujjuGiuziikA5q8QnPhA3
         6xOBf2c7kcOXMh0ODMykXsq8ZV094iAdPdt4qVUdbCNfQnaBMhhzpyltdHedQ/MLWCGH
         83Kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ImT/z6HRlqF9wUIfKM7sD2bCnF81PCfYcsSDMaBnhGc=;
        b=nHIPVKAdNPqsZGqrFNTHZBmqosIC3X4O0RvdxBZavPdlcPAv3Vc/a2P98XWqOiA0K+
         q3Xo8AhPcA0emccx2nXf1aMH4Cx6a7OuY0vLILf5EK6VERDq9y+tbt6oS9aFanMJ7kuo
         pHodc0QOTKsIe9KsREAAa3oTjMSDA8oWMcWZ/5Y9oMm9gVe+0GttMI+etYubzoczDF3Y
         5SPeNyuw3gYbs97Ox1Nv/FLKKVCyyEm7Q/G6qWHYNUA1kc/G0wDADKwUGgoKHDqolNQ1
         MjQU3TWCkmDq+8UT3v+9of3BkksX8Nd7b3YpEvitnBiV+WcactQTwmhF7Tx5v8w2fD6R
         qcBQ==
X-Gm-Message-State: AOAM530uVH6XNdtGu/BgSpKFZ3iHYCH/E+rR0l7DTSro+65DcjJAi+4w
        NKMdArQDJ8lc/XNeFnGfXb5KNZswmNs7dTaA4Cc=
X-Google-Smtp-Source: ABdhPJw96Fu/gzHDKV1//oEkAgNYwQo9MIDUh5woTzG9gNIQJFcnYK9CofMozqvVpHwOCNAwnwzuGsE+5X/oQFlnwAA=
X-Received: by 2002:a50:ec8f:: with SMTP id e15mr11535293edr.70.1593331356976;
 Sun, 28 Jun 2020 01:02:36 -0700 (PDT)
MIME-Version: 1.0
References: <20200501203311.143934-1-konradybcio@gmail.com>
 <20200501203311.143934-2-konradybcio@gmail.com> <20200628073908.GA8343@dragon>
In-Reply-To: <20200628073908.GA8343@dragon>
From:   Konrad Dybcio <konradybcio@gmail.com>
Date:   Sun, 28 Jun 2020 10:02:01 +0200
Message-ID: <CAMS8qEWb6tZxVvy=bqNAt1th_WoqqCQSJjMy3kbBAv-ZCWVQoQ@mail.gmail.com>
Subject: Re: [PATCH 1/2] thermal: qcom: tsens-v0_1: Add support for MSM8939
To:     Shawn Guo <shawn.guo@linaro.org>
Cc:     skrzynka@konradybcio.pl, Amit Kucheria <amit.kucheria@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Linux PM list <linux-pm@vger.kernel.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        DTML <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Shawn,

Thanks for your review.

>For the record, I'm working my version of msm8939 tsens driver support,
>and I would highlight the things that differ from this patch.

I would be absolutely happy if you superseded that patch with your one, as
I'm currently working on sdm630.

Otherwise, thanks for pointing out the stuff I got wrong in the first place.

Regards
Konrad
