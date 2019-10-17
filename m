Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 31113DA5A2
	for <lists+linux-pm@lfdr.de>; Thu, 17 Oct 2019 08:31:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392756AbfJQGbH (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 17 Oct 2019 02:31:07 -0400
Received: from mail-pg1-f176.google.com ([209.85.215.176]:34069 "EHLO
        mail-pg1-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2392721AbfJQGbH (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 17 Oct 2019 02:31:07 -0400
Received: by mail-pg1-f176.google.com with SMTP id k20so736057pgi.1
        for <linux-pm@vger.kernel.org>; Wed, 16 Oct 2019 23:31:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=fw1yYhZZ5QW5zX6QjJLpyykgbadh0BT1jKFS5XpcQIg=;
        b=YO85IQp6MRTrBiWnmv/pN2umttDZqF6DIetl5Fvi9BEt4iJSw8UM8eoknkoagueGLY
         CIJTyaS6OStNG8ys8xYrcccIgYObVbNMMjxpSr6tgEOpXy/SmmYrB4DgAd8gs4Ahuuzb
         MfcxPHi8vDOYUpDdJteDOFT/k5y8sKH7J2v5BvMRVtaF/zbv4QG3jhke6rNpYrBEfxM6
         IV4vl76nOIa7hxntrMiC/HUk0uj1isvhX9qQMdbLdZh+ENlyE4LGid2NH3UYnBPF/YuR
         A2XKvvlvWd9fIAu7e58oAdWtP4NUTfuwGcLDk0lPPbT6HqugJf/ljpz4Co6zKEBuCT6A
         i/Kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=fw1yYhZZ5QW5zX6QjJLpyykgbadh0BT1jKFS5XpcQIg=;
        b=Qvhn12A2BxLVuQ30s2f0d0IQMN9Z2YJ7wSJ6JpHDAtIlHLvxyGRornKUW0U/agaU3I
         ao0bqrGjGMve5Im+1Fl6+WjTackoByW7VXANI8e1pO6+0yA7NbGT4MGWmUtcdN/K76a+
         /qRR+t9vDXGTwsWABnKHSiEqSLZrLcZqPjyq3K6AsMsF6lOFFa4hueYsaa02y3mDvBom
         l1/ubvXN8lYi62fn36nqMABpltqBGLkILOWAtpoCUBbuHSii2RwVoxaQLNXEHDxLrE+z
         6oKU/dt3jWbSidTHhCl/HzCyhtx0tRV6K742fL++qPlO83qA05Oe/ww4L8yw6v4f7kgk
         8Nsw==
X-Gm-Message-State: APjAAAX6tF7RIYy8wIy7sqdGacPEzKsV6vdeuDw+V1I0oFezbpmsq5Ef
        9uSIaFNkLKhpKzQA8kADubjr6A==
X-Google-Smtp-Source: APXvYqy/3dKlQYrAL5ENKYviVbasbExy0Ou4NP5sDQoUA4ILd4XMCDRpjzbTMymafYYiopd0yHpkMw==
X-Received: by 2002:a63:4046:: with SMTP id n67mr2177350pga.200.1571293866371;
        Wed, 16 Oct 2019 23:31:06 -0700 (PDT)
Received: from localhost ([122.172.151.112])
        by smtp.gmail.com with ESMTPSA id r24sm1484239pgo.58.2019.10.16.23.31.04
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 16 Oct 2019 23:31:04 -0700 (PDT)
Date:   Thu, 17 Oct 2019 12:01:02 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     "andrew-sh.cheng" <andrew-sh.cheng@mediatek.com>
Cc:     MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Nishanth Menon <nm@ti.com>, Stephen Boyd <sboyd@kernel.org>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-mediatek@lists.infradead.org" 
        <linux-mediatek@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        srv_heupstream <srv_heupstream@mediatek.com>,
        Fan Chen =?utf-8?B?KOmZs+WHoSk=?= <fan.chen@mediatek.com>
Subject: Re: [v4, 7/8] cpufreq: mediatek: add opp notification for SVS support
Message-ID: <20191017063102.4jirlphdxdydl2bm@vireshk-i7>
References: <1565703113-31479-1-git-send-email-andrew-sh.cheng@mediatek.com>
 <1565703113-31479-8-git-send-email-andrew-sh.cheng@mediatek.com>
 <20190820033927.72muldasu4xd6wb7@vireshk-i7>
 <1571193828.22071.5.camel@mtksdaap41>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1571193828.22071.5.camel@mtksdaap41>
User-Agent: NeoMutt/20180716-391-311a52
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 16-10-19, 10:43, andrew-sh.cheng wrote:
> This is due to SVS feature need to fix Vproc for calibration.
> When SVS calibration, it want to disable all opp items, except one with
> voltae 1.0V. (SVS will change the voltage field of that opp item, if the
> corresponding voltage is not 1.0V)
> In this way, SVS can make sure there is no other module, include
> thermal, will change Vproc by DVFS driver.
> After SVS calibration done, SVS will enable those disabled opp items
> back.

But why is this required to be done this way ? Why can't we just update the
voltages without doing this disable/enable dance ?

-- 
viresh
