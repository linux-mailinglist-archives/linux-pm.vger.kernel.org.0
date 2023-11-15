Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1490D7EBD17
	for <lists+linux-pm@lfdr.de>; Wed, 15 Nov 2023 07:32:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234545AbjKOGcI (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 15 Nov 2023 01:32:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230364AbjKOGcI (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 15 Nov 2023 01:32:08 -0500
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84D82E8
        for <linux-pm@vger.kernel.org>; Tue, 14 Nov 2023 22:32:04 -0800 (PST)
Received: by mail-pl1-x62e.google.com with SMTP id d9443c01a7336-1cc30bf9e22so4316435ad.1
        for <linux-pm@vger.kernel.org>; Tue, 14 Nov 2023 22:32:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1700029924; x=1700634724; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=KjPeh9ZZjSRMCts51cQqHD3pvna46SMMYGc1kSV+9Ck=;
        b=Cz2AccjvGfFLpje4uB/UbipQJ5l4xyiYYwyfZO6afu3sMZeGYmlULGN68fUf0rENNP
         HJdppXqrIZ9bXJ+O74bVsiKNBq1aXdgb3PkIcXrrAI4zV7ckDUy9cqYkTIt8CNLtKo0q
         dG7l5f0iKX+aEDprqeX3mpF8WW7DDPPrNFqIsFhZplY6gNaWv19N1HhP5aS9MDmbaA0a
         SO4fd6uTK2+0EsArJ1S5N0TiAee78/uLBZk74OWGixpGu7xY5sjIqV/P0gRBzCXF9aJf
         26uY18IEJlfkaEIevFUGcsF9cfJtZnqvUd8mJ6Xhf5zlmAoK2n0y42KgeaitIIwJBrW+
         JJLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700029924; x=1700634724;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KjPeh9ZZjSRMCts51cQqHD3pvna46SMMYGc1kSV+9Ck=;
        b=IthYoUs6x9YAenzDmahvD1UO4dA1YTtcmB05dwHoFkwDTm+/OC9xIiwjZ6filPqKVY
         GA/FnqHWZJSF8WWGlKIeqqh6pc0UBdWHNb6bumLh6o2d52Rze4hiKPdLXZw584EIF+ns
         w0TZukB2oVY3PL5K3wff0jAi2TyNQ7IqtV9Me8vbfHwwnl9HLw8MiYyFCJNlYGjhxmPE
         99AyOMJV6qX98kGiob46VPTuVyUkmJAN8P5wS2ZI35+TnRlxZoO4kdSdWYv76WdgPNKg
         Sok2vdjVQFPfZevgs3ocJu3q1vzI7/Mn2Q0gCUjVsuTPlq3cKnqwyKwIr5wljp9seMNR
         5CvA==
X-Gm-Message-State: AOJu0YwpCGu5QswuNd7j7O5e3/33XKTrXN0TZbdzV6n/EbWe8FPSTTV0
        ppNpoFL1RsaZCw73Qu3pviXCAQ==
X-Google-Smtp-Source: AGHT+IF4oy1UHRgg9t61sFGGYMCdLeuK/M6GoBuJsdsc1lP3/fOd3XTZkPS5GMBipsRduRZ1dRSauQ==
X-Received: by 2002:a17:903:41cd:b0:1c5:cf7c:4d50 with SMTP id u13-20020a17090341cd00b001c5cf7c4d50mr6535924ple.18.1700029923763;
        Tue, 14 Nov 2023 22:32:03 -0800 (PST)
Received: from localhost ([122.172.82.6])
        by smtp.gmail.com with ESMTPSA id w1-20020a170902e88100b001c407fac227sm6693954plg.41.2023.11.14.22.32.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Nov 2023 22:32:03 -0800 (PST)
Date:   Wed, 15 Nov 2023 12:02:01 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc:     Johan Hovold <johan@kernel.org>, Viresh Kumar <vireshk@kernel.org>,
        Nishanth Menon <nm@ti.com>, Stephen Boyd <sboyd@kernel.org>,
        linux-pm@vger.kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>, andersson@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, linux-kernel@vger.kernel.org,
        robdclark@gmail.com
Subject: Re: [PATCH 2/2] OPP: Disallow "opp-hz" property without a
 corresponding clk
Message-ID: <20231115063201.rc3pf3pga6zhoqb5@vireshk-i7>
References: <cover.1669012140.git.viresh.kumar@linaro.org>
 <c03c4f2b9d4dcc3264d1902606c6c5c464b4b043.1669012140.git.viresh.kumar@linaro.org>
 <Y3snGQet8yc7HnJK@hovoldconsulting.com>
 <20221121073946.GE11945@thinkpad>
 <20230125042145.hrjpnskywwqn7b6v@vireshk-i7>
 <20230216064727.GA2420@thinkpad>
 <20231011054858.3vvnr76u5enu5lf6@vireshk-i7>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231011054858.3vvnr76u5enu5lf6@vireshk-i7>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 11-10-23, 11:18, Viresh Kumar wrote:
> On 16-02-23, 12:17, Manivannan Sadhasivam wrote:
> > Sorry for the delay. I've submitted the dts changes [1] to handle the CPU clocks
> > for the rest of the Qcom SoCs.
> > 
> > For the Qcom GPUs, I've CCed Rob Clark who is the maintainer.
> > 
> > Rob, here is the background on the issue that is being discussed in this
> > thread:
> > 
> > Viresh submitted a series [2] back in July to improve the OPP framework, but
> > that ended up breaking cpufreq on multiple Qcom SoCs. After investigation, it
> > was found that the series was expecting the clocks supplied to the OPP end
> > devices like CPUs/GPUs to be modeled in DT. But on Qcom platforms even though
> > the clocks for these nodes are supplied by a separate entity, like CPUFreq
> > (EPSS/OSM) for CPUs and GMU for GPUs, there was no clock property present in
> > the respective nodes. And these nodes are using OPP table to switch frequencies
> > dynamically.
> > 
> > While the series was merged with a hack that still allows the OPP nodes without
> > clock property in DT, we came to an agreement that the clock hierarchy should
> > be modeled properly.
> > 
> > So I submitted a series [3] that added clock provider support to cpufreq driver
> > and sourced the clock from cpufreq node to CPU nodes in DT.
> > 
> > Likewise, it should be handled for the adreno GPUs whose clock is managed by
> > GMU on newer SoCs. Can you take a look at this?
> 
> Any update on this ?

Mani,

Ping.

-- 
viresh
