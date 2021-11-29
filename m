Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4A5B7462240
	for <lists+linux-pm@lfdr.de>; Mon, 29 Nov 2021 21:32:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231444AbhK2Ufs (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 29 Nov 2021 15:35:48 -0500
Received: from mail-oi1-f172.google.com ([209.85.167.172]:40731 "EHLO
        mail-oi1-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234054AbhK2Udm (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 29 Nov 2021 15:33:42 -0500
Received: by mail-oi1-f172.google.com with SMTP id bk14so36896775oib.7;
        Mon, 29 Nov 2021 12:30:24 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=SFONEV/UGwOEr3r+xHFTXA5oWkpYZRs57IUMi4ZF0Is=;
        b=1ii1+WNTHHiF6BzHvtMSRcNm2H99zttq8HM6aWb8HXUZbJWD/gRVNA6NchxcbGweU3
         y64Gfu6CzpWskCoq1UlQ1QG+xnLu9TEFsC2EeefGKl+6WygXhxkLqR6Lo+U8yoad1ofj
         Vyv/mV7moxHZ7GeNq0ysf7PtM7xwtgWiPNXwjfojq6o/hC56zeS7/F3wl7bGWb1KkLsC
         cYjH6gWhHZIYrShr8g5SHjRCj9RFwowKR4KO/yBHuhpXJBt9XoyEuks2PINfp/L+huv+
         1aqk6E3AlyQH35Vghyd8aV+LanXKLotXOBqRN6edpZlu/zEjr02zGgGPhGV5v3+RwS/l
         ML0Q==
X-Gm-Message-State: AOAM532AYcmBFm6WziWefAEUyyjrFD/acq+rFmdLgKnrEG7wuuAcZ3Ke
        dhhjnqeVe2aa6eNRPHTjaA==
X-Google-Smtp-Source: ABdhPJyH9rvLBU16jghDxM7d76Jt9/VJG4TmH8onMxCz82Eb5MwpFLkjbHO/1vdDGE7MnalqqZ8xSg==
X-Received: by 2002:aca:b382:: with SMTP id c124mr273625oif.169.1638217823784;
        Mon, 29 Nov 2021 12:30:23 -0800 (PST)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id v20sm2876399otj.27.2021.11.29.12.30.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Nov 2021 12:30:23 -0800 (PST)
Received: (nullmailer pid 551568 invoked by uid 1000);
        Mon, 29 Nov 2021 20:30:22 -0000
Date:   Mon, 29 Nov 2021 14:30:22 -0600
From:   Rob Herring <robh@kernel.org>
To:     Niklas =?iso-8859-1?Q?S=F6derlund?= 
        <niklas.soderlund+renesas@ragnatech.se>
Cc:     Amit Kucheria <amitk@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        linux-renesas-soc@vger.kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: thermal: Fix definition of cooling-maps
 contribution property
Message-ID: <YaU4XuiaJgEjGCdQ@robh.at.kernel.org>
References: <20211109103045.1403686-1-niklas.soderlund+renesas@ragnatech.se>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20211109103045.1403686-1-niklas.soderlund+renesas@ragnatech.se>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Tue, 09 Nov 2021 11:30:45 +0100, Niklas Söderlund wrote:
> When converting the thermal-zones bindings to yaml the definition of the
> contribution property changed. The intention is the same, an integer
> value expressing a ratio of a sum on how much cooling is provided by the
> device to the zone. But after the conversion the integer value is
> limited to the range 0 to 100 and expressed as a percentage.
> 
> This is problematic for two reasons.
> 
> - This do not match how the binding is used. Out of the 18 files that
>   make use of the property only two (ste-dbx5x0.dtsi and
>   ste-hrefv60plus.dtsi) sets it at a value that satisfy the binding,
>   100. The remaining 16 files set the value higher and fail to validate.
> 
> - Expressing the value as a percentage instead of a ratio of the sum is
>   confusing as there is nothing to enforce the sum in the zone is not
>   greater then 100.
> 
> This patch restore the pre yaml conversion description and removes the
> value limitation allowing the usage of the bindings to validate.
> 
> Fixes: 1202a442a31fd2e5 ("dt-bindings: thermal: Add yaml bindings for thermal zones")
> Reported-by: Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>
> Signed-off-by: Niklas Söderlund <niklas.soderlund+renesas@ragnatech.se>
> ---
>  .../devicetree/bindings/thermal/thermal-zones.yaml       | 9 ++++-----
>  1 file changed, 4 insertions(+), 5 deletions(-)
> 

Applied, thanks!
