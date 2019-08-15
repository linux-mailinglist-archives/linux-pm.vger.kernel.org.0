Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 019EB8F04F
	for <lists+linux-pm@lfdr.de>; Thu, 15 Aug 2019 18:19:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730602AbfHOQTw (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 15 Aug 2019 12:19:52 -0400
Received: from mail-lf1-f66.google.com ([209.85.167.66]:37714 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728979AbfHOQTw (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 15 Aug 2019 12:19:52 -0400
Received: by mail-lf1-f66.google.com with SMTP id c9so2032723lfh.4
        for <linux-pm@vger.kernel.org>; Thu, 15 Aug 2019 09:19:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:openpgp:autocrypt:message-id:date
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=sRy0HGkkwueoNntrvDsZNILMk3C4/I8h6a3uq64hOBI=;
        b=ydMINYfpYUGZbA9ACQan1VPtHfcdEg+Eww++zFwxCu/4Oo6Q56sPdMh88RK8Lkbtji
         x+QfheLZoqaNk+LuLQXcblUSyc2BzPM222BFXpnIXzEPciqrUJQSfZpZ15umLFHD+muz
         y8tHSdcINQV/WMLMQjGvKjCcF8yVEGKx+CJla/p9H4229ECvVuDs31bEf9pCHyZ6r7CS
         VrUYumiERxsm2GkmrKULXDYlDJCUVLwcR1uZ1bjtdp72PT4Ij2vv6uslklUWtFga5BzS
         bBdF1FYvRAQuqFvlfLFth6IFhagFZ9kD9hN1uT3O7qsH5PD9nhVJH8/pMhfOXvP7Jw0F
         PLHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:openpgp:autocrypt
         :message-id:date:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=sRy0HGkkwueoNntrvDsZNILMk3C4/I8h6a3uq64hOBI=;
        b=J2zg+WUeBxlFbGbQKqkgDR1iY+tVC1UQmNouph9M19CvPfmIbs5FrDkMK3kF6eqC8t
         8QaQHLQA3Ti+QqXYr3JoeZALg0+naMMEWzMoJy6M/j+5I979I8Yaf9OwmL30PObIMlTy
         OGSkTFVsJO4aJKg2hEVfLU0HaQ9BVvEK6Ha4Eywz23wtffAuoyL2/WlfIjsiARgkzF2q
         2W12KhX4y0Dv5epou8v3yfOw5+KFdjNm7dNFgZe25y0H39KGWkyIucGA2nIqJ71v3L4e
         u2n8goOMAHMTPgybmz6JDajpJu4cUJOWwpm7LBjHbZiwVqArnq9Q9farsAS9ctK5WduR
         T7WQ==
X-Gm-Message-State: APjAAAXg8o6iIUBmR18AKKottKtBIroVK3jvTiF5vwQJddarTJ8qCWoG
        u8sEZTJrTpoiFSrFQ80UFtaXRw==
X-Google-Smtp-Source: APXvYqzr+unM1x8AG+bUo1brUXtoWu76G6a4YxVfXpyjHb+cqnX3+LQRYm9IpfUgdBLvaMy/a5BxFw==
X-Received: by 2002:ac2:428d:: with SMTP id m13mr2755522lfh.52.1565885989674;
        Thu, 15 Aug 2019 09:19:49 -0700 (PDT)
Received: from [10.44.66.8] ([212.45.67.2])
        by smtp.googlemail.com with ESMTPSA id d21sm515144lfc.73.2019.08.15.09.19.46
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 15 Aug 2019 09:19:48 -0700 (PDT)
Subject: Re: [PATCH v5 0/3] Introduce Bandwidth OPPs for interconnects
To:     Saravana Kannan <saravanak@google.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
        Stephen Boyd <sboyd@kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc:     vincent.guittot@linaro.org, seansw@qti.qualcomm.com,
        daidavid1@codeaurora.org, adharmap@codeaurora.org,
        Rajendra Nayak <rnayak@codeaurora.org>, sibis@codeaurora.org,
        bjorn.andersson@linaro.org, evgreen@chromium.org,
        kernel-team@android.com, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20190807223111.230846-1-saravanak@google.com>
From:   Georgi Djakov <georgi.djakov@linaro.org>
Openpgp: preference=signencrypt
Autocrypt: addr=georgi.djakov@linaro.org; prefer-encrypt=mutual; keydata=
 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
 KEmKjLDvB0pePJkdTw==
Message-ID: <b8a6020f-eda5-0c3d-b365-a294c28b9650@linaro.org>
Date:   Thu, 15 Aug 2019 19:19:44 +0300
MIME-Version: 1.0
In-Reply-To: <20190807223111.230846-1-saravanak@google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi,

On 8/8/19 01:31, Saravana Kannan wrote:
> Interconnects and interconnect paths quantify their performance levels in
> terms of bandwidth and not in terms of frequency. So similar to how we have
> frequency based OPP tables in DT and in the OPP framework, we need
> bandwidth OPP table support in DT and in the OPP framework.
> 
> So with the DT bindings added in this patch series, the DT for a GPU
> that does bandwidth voting from GPU to Cache and GPU to DDR would look
> something like this:
> 
> gpu_cache_opp_table: gpu_cache_opp_table {
> 	compatible = "operating-points-v2";
> 
> 	gpu_cache_3000: opp-3000 {
> 		opp-peak-KBps = <3000000>;
> 		opp-avg-KBps = <1000000>;
> 	};
> 	gpu_cache_6000: opp-6000 {
> 		opp-peak-KBps = <6000000>;
> 		opp-avg-KBps = <2000000>;
> 	};
> 	gpu_cache_9000: opp-9000 {
> 		opp-peak-KBps = <9000000>;
> 		opp-avg-KBps = <9000000>;
> 	};
> };
> 
> gpu_ddr_opp_table: gpu_ddr_opp_table {
> 	compatible = "operating-points-v2";
> 
> 	gpu_ddr_1525: opp-1525 {
> 		opp-peak-KBps = <1525000>;
> 		opp-avg-KBps = <452000>;
> 	};
> 	gpu_ddr_3051: opp-3051 {
> 		opp-peak-KBps = <3051000>;
> 		opp-avg-KBps = <915000>;
> 	};
> 	gpu_ddr_7500: opp-7500 {
> 		opp-peak-KBps = <7500000>;
> 		opp-avg-KBps = <3000000>;
> 	};
> };
> 
> gpu_opp_table: gpu_opp_table {
> 	compatible = "operating-points-v2";
> 	opp-shared;
> 
> 	opp-200000000 {
> 		opp-hz = /bits/ 64 <200000000>;
> 	};
> 	opp-400000000 {
> 		opp-hz = /bits/ 64 <400000000>;
> 	};
> };
> 
> gpu@7864000 {
> 	...
> 	operating-points-v2 = <&gpu_opp_table>, <&gpu_cache_opp_table>, <&gpu_ddr_opp_table>;
> 	...
> };
> 
> v1 -> v3:
> - Lots of patch additions that were later dropped
> v3 -> v4:
> - Fixed typo bugs pointed out by Sibi.
> - Fixed bug that incorrectly reset rate to 0 all the time
> - Added units documentation
> - Dropped interconnect-opp-table property and related changes
> v4->v5:
> - Replaced KBps with kBps
> - Minor documentation fix
> 
> Cheers,
> Saravana
> 
> Saravana Kannan (3):
>   dt-bindings: opp: Introduce opp-peak-kBps and opp-avg-kBps bindings
>   OPP: Add support for bandwidth OPP tables
>   OPP: Add helper function for bandwidth OPP tables
> 
>  Documentation/devicetree/bindings/opp/opp.txt | 15 ++++--
>  .../devicetree/bindings/property-units.txt    |  4 ++
>  drivers/opp/core.c                            | 51 +++++++++++++++++++
>  drivers/opp/of.c                              | 41 +++++++++++----
>  drivers/opp/opp.h                             |  4 +-
>  include/linux/pm_opp.h                        | 19 +++++++
>  6 files changed, 121 insertions(+), 13 deletions(-)
> 

For the series:
Acked-by: Georgi Djakov <georgi.djakov@linaro.org>

Thanks,
Georgi
