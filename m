Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5A1E3E9B08
	for <lists+linux-pm@lfdr.de>; Wed, 30 Oct 2019 12:45:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726321AbfJ3LpE (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 30 Oct 2019 07:45:04 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:53624 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726584AbfJ3LpE (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 30 Oct 2019 07:45:04 -0400
Received: by mail-wm1-f66.google.com with SMTP id n7so1756608wmc.3
        for <linux-pm@vger.kernel.org>; Wed, 30 Oct 2019 04:45:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=ONBAlPsK9csKDOSK3QHrotYDGYKCfVT4Ykd7rd79HM8=;
        b=gmU44ve39exVNhQpXl7TfaUIJe/F+7uLpvMD+Qq1VCL9morsfXsd6hTisukoNCpR2f
         CbDatasQp6znjKaW5Kb59JvO/+om2qX/axgU4OwtaTGhQH5SS5wMC14t9DQQojI3+vsZ
         WQcv3Rzql54PRX7i/s2ti23taKMyr+FghOml9b2jWEMYpsUUP8TnKVFWJyv09y+crFaM
         MuxKEfAlru5dg9AU5tsggf+09+OO7nzO8vPyZUZvvYWXcMzZUiPGaYz3O2c3wm91ODYF
         QH5YS5fxdyWLFXbxF6DDgS9Lgu3e2HU/Y+filyu/OBvgrfi83PuMZEUr2Ura3+NMKBkh
         yQsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=ONBAlPsK9csKDOSK3QHrotYDGYKCfVT4Ykd7rd79HM8=;
        b=Wh63yjZfniucSGyeAEUuZbNEVzN9uaL0snhR4afTjz4qkVG01wjfemmAq5JI5ctKlG
         v679MjleLSkzZ4b9H3HwXwW0x7bA0lA++cjQjRcqh9TEidYGIOdFKM7aTs38myaQYALj
         NNG8dnUqCRZYQsV9yetLHQy75xkOcRQUPPD+MyVbIYFe3xkZ1q7b7NlGiyFHpq9V8VVP
         frdK388Iuu0+RWdbyfaa8Wz8BMWaw+cu1B5AEhtaU+JAi5PbJ086xyT/59ycy25Hj+ia
         kMUk3+kWXREwoeb+y9lsLNpY+AGFcxVNHMRS1YWTxW0tH9A5kY1czm9fzmHeDjXnQEIb
         Pd2A==
X-Gm-Message-State: APjAAAV4eu4UY3bbVZoW4ewvc07Y8szt894yIoBzwiz6FI9zEsLWmPyN
        tF0Qid4bSkC7igAQ3jRRT9LWxw==
X-Google-Smtp-Source: APXvYqzddIaarF/u2d62io5E/bzukrep248eN6mp0JlB9gjWWg7XGxuTQrXTJ38TCdccclBs+Ezfpw==
X-Received: by 2002:a05:600c:2204:: with SMTP id z4mr8411889wml.67.1572435901834;
        Wed, 30 Oct 2019 04:45:01 -0700 (PDT)
Received: from google.com ([2a00:79e0:d:110:d6cc:2030:37c1:9964])
        by smtp.gmail.com with ESMTPSA id n22sm1752077wmk.19.2019.10.30.04.45.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Oct 2019 04:45:00 -0700 (PDT)
Date:   Wed, 30 Oct 2019 11:44:57 +0000
From:   Quentin Perret <qperret@google.com>
To:     Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     Quentin Perret <qperret@qperret.net>, edubezval@gmail.com,
        rui.zhang@intel.com, javi.merino@kernel.org,
        viresh.kumar@linaro.org, amit.kachhap@gmail.com, rjw@rjwysocki.net,
        catalin.marinas@arm.com, will@kernel.org, dietmar.eggemann@arm.com,
        ionela.voinescu@arm.com, mka@chromium.org,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH RESEND v8 0/4] Make IPA use PM_EM
Message-ID: <20191030114457.GA22605@google.com>
References: <20190911130314.29973-1-qperret@qperret.net>
 <1fab36a5-25cf-abd2-ee25-23d8c8d673ac@linaro.org>
 <CAPwzONkaUmZuw7W1w=D11G55DVmj8fxmLwZ4hEYGdGEJbpsqHg@mail.gmail.com>
 <f4ac89b8-32dc-e929-696d-7dfebfbfb3a0@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f4ac89b8-32dc-e929-696d-7dfebfbfb3a0@linaro.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Wednesday 30 Oct 2019 at 11:54:30 (+0100), Daniel Lezcano wrote:
> Hi Quentin,
> 
> On 07/10/2019 15:37, Quentin Perret wrote:
> > Hi Daniel,
> > 
> > On Mon, Oct 7, 2019 at 6:35 AM Daniel Lezcano <daniel.lezcano@linaro.org> wrote:
> >> the series does no longer apply, do you think it is possible to give it
> >> a respin?
> > 
> > Right, I'll try to fix the conflicts and post a v9 shortly.
> 
> we are getting close to the merge window, did you have time to respin
> the series?

Yes, sorry for the delay, but I have a 5.4-rc4-based branch that seems
to work. I'll push that ASAP.

Thanks,
Quentin
