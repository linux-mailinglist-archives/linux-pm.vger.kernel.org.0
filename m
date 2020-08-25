Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 74A12251EA7
	for <lists+linux-pm@lfdr.de>; Tue, 25 Aug 2020 19:53:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726356AbgHYRxu (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 25 Aug 2020 13:53:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726090AbgHYRxt (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 25 Aug 2020 13:53:49 -0400
Received: from mail-ot1-x343.google.com (mail-ot1-x343.google.com [IPv6:2607:f8b0:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54F32C061574
        for <linux-pm@vger.kernel.org>; Tue, 25 Aug 2020 10:53:49 -0700 (PDT)
Received: by mail-ot1-x343.google.com with SMTP id h16so11108265oti.7
        for <linux-pm@vger.kernel.org>; Tue, 25 Aug 2020 10:53:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=C1x1jyjBhFzCQy8a0EbMsi3qjsuzPMNqfqLhlXLSl7A=;
        b=k3t5RucNoAwMD2XGqRLYQNKFhfSn1C0q4rGtp52+V7O6X/6WeDPvz2lk7ykbKchVOJ
         kPCDzRJEovZZRaWBYKOZ/dGYhQ3tvXlh4IelW4WQAJEgZo4RP12M8sTKFFGxEQuMoxFQ
         80sJYM2wFiGa55KienyTFIuZkrOZn2IPbVq5bd1X4wviQrMZmvMrrYpGp/GrXocAJYyN
         wK27QECJDk71rlAOvF9ZNCkCTD2Tp3+Eypex5mWXwf/lOH+LZQ1gT1T3JCyYq1rjf0Oy
         g3Uu6LEGQzfu0o/h01UYs6YqslQvZqhW4AqNXUPIoKn98U1VHlUsuLpR/2g7Mx1YMC7F
         BpVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=C1x1jyjBhFzCQy8a0EbMsi3qjsuzPMNqfqLhlXLSl7A=;
        b=NHvcMztaV/ciJArVt87Bbh0risGXU2WHglvAOAsuom1lRfkZ374WbsK6RgYw1/eH0V
         wmJQzpmGCIy4/BVGa2v/wItwIq7cXg9aezkocMrhvEZfxXWPWw1KqaW3xOAOj53/vBUK
         WY5Bu+3saaCFc6xbPLlGKjK2BX7mNnDp9MDB+/wxAvPT6ObEBt4cbMUPt96Jb77jBW1P
         V2btEHmI16/ZtxR8hx/GtRDCxMPdnJcgmYLcApJvsleuL2ycowIR8uB6iRFA1n/K6MvA
         46RI7dXIMRZ7qlmVpA3dp0+UMFvWXWZMUO/M+TIrF7boWH2e0zyy97nbpj5BuqvRbBmz
         A64A==
X-Gm-Message-State: AOAM533abY2ZRSDDWSEW3y1ElVkozRn2b53EpJWauDezloDUVvaw7l1Z
        9nKiW+T5nvVgihrsan9SAuTSTc80sEyHQQ==
X-Google-Smtp-Source: ABdhPJz82wuG/Ujs87c1fACgiNfpycutLB/WbcCGDf6CJAe7OGmHiti1fhnkkMUkGutRcWom15/OCA==
X-Received: by 2002:a9d:27e7:: with SMTP id c94mr1043336otb.360.1598378028593;
        Tue, 25 Aug 2020 10:53:48 -0700 (PDT)
Received: from yoga ([2605:6000:e5cb:c100:8898:14ff:fe6d:34e])
        by smtp.gmail.com with ESMTPSA id b10sm418053oiy.7.2020.08.25.10.53.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Aug 2020 10:53:47 -0700 (PDT)
Date:   Tue, 25 Aug 2020 12:53:45 -0500
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Stephen Boyd <swboyd@chromium.org>
Cc:     Sibi Sankar <sibis@codeaurora.org>, khilman@kernel.org,
        ulf.hansson@linaro.org, rjw@rjwysocki.net, agross@kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-pm@vger.kernel.org, gregkh@linuxfoundation.org, pavel@ucw.cz,
        len.brown@intel.com, rnayak@codeaurora.org, dianders@chromium.org,
        mka@chromium.org
Subject: Re: [PATCH v2 1/2] PM / Domains: Add GENPD_FLAG_NO_SUSPEND/RESUME
 flags
Message-ID: <20200825175345.GC3715@yoga>
References: <20200821204921.32536-1-sibis@codeaurora.org>
 <159804608868.334488.2486130699850456264@swboyd.mtv.corp.google.com>
 <20200824164212.GA3715@yoga>
 <159834001729.334488.11862381163144726708@swboyd.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <159834001729.334488.11862381163144726708@swboyd.mtv.corp.google.com>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Tue 25 Aug 02:20 CDT 2020, Stephen Boyd wrote:
> Quoting Bjorn Andersson (2020-08-24 09:42:12)
> > On Fri 21 Aug 14:41 PDT 2020, Stephen Boyd wrote:
[..]
> > > I find it odd that this is modeled as a power domain instead of some
> > > Qualcomm specific message that the remoteproc driver sends to AOSS. Is
> > > there some sort of benefit the driver gets from using the power domain
> > > APIs for this vs. using a custom API?
> > 
> > We need to send "up" and "down" notifications and this needs to happen
> > at the same time as other standard resources are enabled/disabled.
> > 
> > Further more, at the time the all resources handled by the downstream
> > driver was either power-domains (per above understanding) or clocks, so
> > it made sense to me not to spin up a custom API.
> > 
>  
> So the benefit is not spinning up a custom API? I'm not Ulf, but it
> looks like this is hard to rationalize about as a power domain. It
> doesn't have any benefit to model it this way besides to make it
> possible to turn on with other power domains.
> 
> This modem remoteproc drivers isn't SoC agnostic anyway, it relies on
> SMEM APIs, so standing up another small qmp_remoteproc_booted() and
> qmp_remoteproc_shutdown() API would avoid adding a genpd flag here that
> probably will never be used outside of this corner-case. There is also
> some get/put EPROBE_DEFER sort of logic to implement, but otherwise it
> would be possible to do this outside of power domains, and that seems
> better given that this isn't really a power domain to start with.

In later platforms a few new users of the AOSS communication interface
is introduced that certainly doesn't fit any existing API/framework in
the kernel. So the plan was to pretty much expose qmp_send() to these
drivers.

My worry with using this interface is that we'll probably have to come
up with some DT binding pieces and probably we'll end up adding yet
another piece of hard coded information in the remoteproc drivers.

But I'm not against us doing this work in favor of not having to
introduce a one-off for this corner case.

Regards,
Bjorn
