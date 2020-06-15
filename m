Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B27781F8FE6
	for <lists+linux-pm@lfdr.de>; Mon, 15 Jun 2020 09:31:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726299AbgFOHbp (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 15 Jun 2020 03:31:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728369AbgFOHbn (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 15 Jun 2020 03:31:43 -0400
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com [IPv6:2607:f8b0:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DFB7FC05BD43
        for <linux-pm@vger.kernel.org>; Mon, 15 Jun 2020 00:31:41 -0700 (PDT)
Received: by mail-pg1-x541.google.com with SMTP id v14so2241231pgl.1
        for <linux-pm@vger.kernel.org>; Mon, 15 Jun 2020 00:31:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=LrJ4JAo2vjzpAGyvhcbFA7qISNQsytIItEN02iswbAY=;
        b=xIDTWFM2aEF9G48Tte+2/OhzJEH4zIX8UuUvaXknN7D4I4cmnaZPllbbgOZ2Qk+1bY
         xbc+h154cHHO0epDGK216n3MwNuTQp8fqNoImvPxYEWwYNbpZlJyWIj2LFILlM6wvgH+
         PrrwqgyDhhXP7IQ8oGaTW5/tJ5HPe94oZv9gZMHEzR71J+0zMmRMINshTnnEMwgOVaAR
         riY+A1J2/TsZ/dTasy+1g79Vmc0d1usNeEDBgt0+HWb+bXb9RnVRGlHffL4L/ugZBF2w
         Dud6PN5w+IJx6AeU9QRAZD329d15LkFad4bKzdPv8fewOwdQekgvuC7XPd0gsL3i8Aa0
         VR1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=LrJ4JAo2vjzpAGyvhcbFA7qISNQsytIItEN02iswbAY=;
        b=BgwL/YbaVxrLPi3cyG9vHJ5DwVWpXUPUBig5lhMTflv2NLDPqze4oL2asPc9SV+MT3
         YJn/vSlfyNB8tXJ1a2Id87hNMMfGvyJhKxuw2ge2r5y7EtApAAXRysjyY2L3RrkIbrUC
         furcBZhVcnxqN4F6eRfC+/lXDHL1m306cxIbdXAG6ZRDhO8ewy8cLeSzeKycCg1eNlWb
         fFmU1tWlspkSLZd5SVnx5sqHCsxHv5UJJOEPOaKU10uKgrxSGhzOuzg70xw+FVKQht3+
         5pZ1ir8lkbeS6LkHJgqA6ouOHa14tUDIadxyaJ+oSM2raOFFURxG0oXOcui8sGVmeRKP
         7yLA==
X-Gm-Message-State: AOAM533NZC1WS3735tdDKVpZMvxZyw7mCdHprGTMYTETJEtn0cE5gPxk
        dZHdINV8b9aIKrPrRlZN5AeGJg==
X-Google-Smtp-Source: ABdhPJzYVFN3gBHjfNgqZa/g6YU6WbN/APpY56EAa5j7L5CZKm7Xt1592LSNfKcNJdQv1J9FEzZwKg==
X-Received: by 2002:a63:5f41:: with SMTP id t62mr20785803pgb.252.1592206301079;
        Mon, 15 Jun 2020 00:31:41 -0700 (PDT)
Received: from localhost ([122.172.62.209])
        by smtp.gmail.com with ESMTPSA id p14sm11774352pjf.32.2020.06.15.00.31.39
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 15 Jun 2020 00:31:40 -0700 (PDT)
Date:   Mon, 15 Jun 2020 13:01:38 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     "Andrew-sh.Cheng" <andrew-sh.cheng@mediatek.com>
Cc:     MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Nishanth Menon <nm@ti.com>, Stephen Boyd <sboyd@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        srv_heupstream@mediatek.com
Subject: Re: [PATCH 00/12] Add cpufreq and cci devfreq for mt8183, and SVS
 support
Message-ID: <20200615073138.2vk5f3kplsz6rgqc@vireshk-i7>
References: <20200520034307.20435-1-andrew-sh.cheng@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200520034307.20435-1-andrew-sh.cheng@mediatek.com>
User-Agent: NeoMutt/20180716-391-311a52
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 20-05-20, 11:42, Andrew-sh.Cheng wrote:
> 	- Resend depending patches of Sravana Kannan base on kernel-5.7

Saravana's patches were never accepted and I suggested him this which
he never tested I believe.

https://lore.kernel.org/lkml/20191125112812.26jk5hsdwqfnofc2@vireshk-i7/

There is no point rebasing your stuff on a series which hasn't
concluded or is accepted, at least logically.

-- 
viresh
