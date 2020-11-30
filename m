Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 214A02C8CAD
	for <lists+linux-pm@lfdr.de>; Mon, 30 Nov 2020 19:25:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388015AbgK3SYg (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 30 Nov 2020 13:24:36 -0500
Received: from mail-ed1-f67.google.com ([209.85.208.67]:38077 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388112AbgK3SYg (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 30 Nov 2020 13:24:36 -0500
Received: by mail-ed1-f67.google.com with SMTP id y4so17472354edy.5;
        Mon, 30 Nov 2020 10:24:13 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=I9ONVBtfScKIMTye82bfGQ5rddLKQrmuSaE2Zj5EgGI=;
        b=irAHwtaB9jiuv+vG00w505UybL5aiKHDguodT6LJytjnXVtNtlwJ76oRFwituz8twK
         WEPEW0R6JStai9TjYrNdp2xpsuZL7WgA/sRsUW7E6KdmtetiXt/tURyp4XuPYCpfqU8P
         ABz3fqwZ6TKFKv5glz0IsRpd4miRvplFOKliaYL92niQOKVnogCK92Je/nJ75o6LYtEc
         sNEMz1lQgDvtpgqAE+hccYt7VFx+OX87lUVhXvfxhg2GJsEIrcOSTNYgR+nbSV4wBKEi
         l7NdNWUkryCRWIkformrHmA9jBPxXIk9IKbcrfwfUhq/CnqwW7be6khT7zadS96PwKCn
         gSig==
X-Gm-Message-State: AOAM533PavAV4lPijyay5l0BGiK+ve6wAtdtYgnN1skGvu5hg0laMHsG
        kO21O1iyYd2qEoVvX0TR5WU=
X-Google-Smtp-Source: ABdhPJwYHGbHVMApFqE392EkdKd4CbGtej8nEk3tKKJMIPVxgXA2gu998VoT05uHS0KZ4By5J9o3BA==
X-Received: by 2002:a50:8f64:: with SMTP id 91mr23297490edy.310.1606760628069;
        Mon, 30 Nov 2020 10:23:48 -0800 (PST)
Received: from kozik-lap (adsl-84-226-167-205.adslplus.ch. [84.226.167.205])
        by smtp.googlemail.com with ESMTPSA id v18sm789274edx.30.2020.11.30.10.23.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Nov 2020 10:23:47 -0800 (PST)
Date:   Mon, 30 Nov 2020 20:23:45 +0200
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Georgi Djakov <georgi.djakov@linaro.org>
Cc:     Dmitry Osipenko <digetx@gmail.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Rob Herring <robh+dt@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Peter De Schrijver <pdeschrijver@nvidia.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Mikko Perttunen <cyndis@kapsi.fi>,
        Viresh Kumar <vireshk@kernel.org>,
        Peter Geis <pgwipeout@gmail.com>,
        Nicolas Chauvet <kwizart@gmail.com>,
        linux-tegra@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org
Subject: Re: [PATCH v10 01/19] dt-bindings: memory: tegra20: emc: Document
 opp-supported-hw property
Message-ID: <20201130182345.GA28450@kozik-lap>
References: <20201123002723.28463-1-digetx@gmail.com>
 <20201123002723.28463-2-digetx@gmail.com>
 <46b3bab7-1c2c-2f50-6e41-f411e532357b@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <46b3bab7-1c2c-2f50-6e41-f411e532357b@linaro.org>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Mon, Nov 30, 2020 at 11:48:18AM +0200, Georgi Djakov wrote:
> On 23.11.20 2:27, Dmitry Osipenko wrote:
> > Document opp-supported-hw property, which is not strictly necessary to
> > have on Tegra20, but it's very convenient to have because all other SoC
> > core devices will use hardware versioning, and thus, it's good to maintain
> > the consistency.
> 
> Hi Dmitry,
> 
> I believe Krzysztof is waiting for Ack on the binding before merging
> this patch (and the rest), but unfortunately it was not sent to the
> DT mailing list for review.

Indeed I am still waiting for Rob's and Thierry's acks for this and the
following patches.  It has been just a week so I'll give it few more
days.

Best regards,
Krzysztof

