Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 57C4B126EC7
	for <lists+linux-pm@lfdr.de>; Thu, 19 Dec 2019 21:22:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727386AbfLSUW1 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 19 Dec 2019 15:22:27 -0500
Received: from mail-ed1-f66.google.com ([209.85.208.66]:41483 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727552AbfLSUW0 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 19 Dec 2019 15:22:26 -0500
Received: by mail-ed1-f66.google.com with SMTP id c26so6139276eds.8;
        Thu, 19 Dec 2019 12:22:24 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=+XwXmMLYM0uNSnbJNWZYduJB3McxlK0rmyyXpOOOY+E=;
        b=Q61p1QlHzlZXUxnnL3/GYWbDtQRd4v8Qz++Rh+adjdxI1kJGg/ID1V/rmWNMdgOctw
         +AksTB8M/yI1I3kNIwkiepsWvbA9WK8PTjqharvualRUNDS/Q9dfQT06PYFvAH81mL4F
         OmAF9/0wxyYEvWABJoN+yMkcTJvOjbNwZuMzH2ASmZnE59YL0pjX8V8sQ+fXJpw4DOdd
         4jQVApDlNdE3243tZXvM9Lu4NPIyioeS9MUxB4ftESTgpbJT69Lf4tAOKtijvv8rO4/6
         JpnbtKnnrRON2RRzsduvv9brlr26JJpQph+BHuy5/Q/0ZMDT62/ePJffmuE0Hu5EZzTp
         KpEA==
X-Gm-Message-State: APjAAAV/86KwEkcYWof+082ahooju/eslCxPLOz0+GJfJ9SkRpED5MI0
        sSoOlgPhffUly9rA9H+Y6seQPfHw
X-Google-Smtp-Source: APXvYqyvXs1b77JsdU/bIq/7bJEZPvD05zPHc+WyTqQxuAEMRrkLbVyqmxjhV8KF6k+gHok+ePJnvg==
X-Received: by 2002:a17:907:20a8:: with SMTP id pw8mr11469298ejb.248.1576786944265;
        Thu, 19 Dec 2019 12:22:24 -0800 (PST)
Received: from kozik-lap ([194.230.155.234])
        by smtp.googlemail.com with ESMTPSA id s15sm626909edc.22.2019.12.19.12.22.22
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 19 Dec 2019 12:22:23 -0800 (PST)
Date:   Thu, 19 Dec 2019 21:22:20 +0100
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Chanwoo Choi <cw00.choi@samsung.com>
Cc:     robh+dt@kernel.org, mark.rutland@arm.com, heiko@sntech.de,
        leonard.crestez@nxp.com, lukasz.luba@arm.com, a.swigon@samsung.com,
        m.szyprowski@samsung.com, kgene@kernel.org,
        myungjoo.ham@samsung.com, kyungmin.park@samsung.com,
        linux-pm@vger.kernel.org, linux-samsung-soc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-rockchip@lists.infradead.org
Subject: Re: [PATCH 9/9] arm64: dts: exynos: Replace deprecated property for
 Exynos bus
Message-ID: <20191219202220.GC21576@kozik-lap>
References: <20191217055738.28445-1-cw00.choi@samsung.com>
 <CGME20191217055107epcas1p44d46bdea7b326b86689f326742f5444a@epcas1p4.samsung.com>
 <20191217055738.28445-10-cw00.choi@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20191217055738.28445-10-cw00.choi@samsung.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Tue, Dec 17, 2019 at 02:57:38PM +0900, Chanwoo Choi wrote:
> Replace the property related to devfreq and devfreq-event device
> to remove the deprecated property name.
> - Replace 'devfreq' with 'exynos,parent-bus' property
>   for getting the parent devfreq device of exynos-bus.
> - Replace 'devfreq-events' with 'exynos,ppmu-device' property
>   for getting the devfreq-event device to monitor bus utilization.
> 
> Signed-off-by: Chanwoo Choi <cw00.choi@samsung.com>
> ---
>  .../dts/exynos/exynos5433-tm2-common.dtsi     | 20 +++++++++----------
>  1 file changed, 10 insertions(+), 10 deletions(-)

I'll pick it up the next cycle after driver get merged.

Best regards,
Krzysztof

