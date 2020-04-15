Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 662E71AAB27
	for <lists+linux-pm@lfdr.de>; Wed, 15 Apr 2020 17:01:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392903AbgDOO5o (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 15 Apr 2020 10:57:44 -0400
Received: from mail-ot1-f65.google.com ([209.85.210.65]:45913 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2392861AbgDOO5m (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 15 Apr 2020 10:57:42 -0400
Received: by mail-ot1-f65.google.com with SMTP id i22so120205otp.12;
        Wed, 15 Apr 2020 07:57:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Md07fNLqLIHZrcf6yHruBR5stSBvgH18ECgUZmAAWJc=;
        b=d3XITQ+HoGkH1S3Epjy1JdyjDvXCBX1ErKJKnUv9C/4AT377XNOiRF6VCU9FxM2M8y
         mhg6Wiyp/zOWR7wsvKvlw3y+Iw3LWtOAn4UE9qydtdo/9TmcFYomsgYMba4TnRClGbDS
         dxnRSF7XJvOVOr65QF2nzRnlRo63fGSs+P56+4TOZDmcbnNLizirWBLwJ3XCcxCWafJP
         H53coGRSryQkIttnElVznAPKqjqqUN9uZEc+yHZEWdea6b3L0s8yTResCEpanfnK/P9U
         8Bxj8hBqsWA0vxUeQMyIlYivStCuvw80nI3PWVO1rk5X5E/UpIPK51Ie/o2XXw0FVvSL
         5udw==
X-Gm-Message-State: AGi0PuZTVw6KAoq11S4lis004h3nNorTfoCSzs5ydY/SPsUZF8crmQfc
        NjWRz14c5koMZpae5TMP3w==
X-Google-Smtp-Source: APiQypI+K9Fe9kS2hXHo19Qwp7IVK/mV6pz5Na84hA37jXreGi0sZ498aqbZYHTX0TIMHMh8Pw/pUQ==
X-Received: by 2002:a05:6830:1185:: with SMTP id u5mr5502347otq.54.1586962661357;
        Wed, 15 Apr 2020 07:57:41 -0700 (PDT)
Received: from rob-hp-laptop (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id k13sm5232247oou.27.2020.04.15.07.57.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Apr 2020 07:57:40 -0700 (PDT)
Received: (nullmailer pid 8889 invoked by uid 1000);
        Wed, 15 Apr 2020 14:57:39 -0000
Date:   Wed, 15 Apr 2020 09:57:39 -0500
From:   Rob Herring <robh@kernel.org>
To:     Tobias Schramm <t.schramm@manjaro.org>
Cc:     Sebastian Reichel <sre@kernel.org>, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Tobias Schramm <t.schramm@manjaro.org>
Subject: Re: [RESEND v6 2/3] dt-bindings: power: supply: add cw2015_battery
 bindings
Message-ID: <20200415145739.GA7406@bogus>
References: <20200414125208.1091989-1-t.schramm@manjaro.org>
 <20200414125208.1091989-3-t.schramm@manjaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200414125208.1091989-3-t.schramm@manjaro.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Tue, 14 Apr 2020 14:52:07 +0200, Tobias Schramm wrote:
> This patch adds the dts binding schema for the cw2015 fuel gauge.
> 
> Signed-off-by: Tobias Schramm <t.schramm@manjaro.org>
> ---
>  .../bindings/power/supply/cw2015_battery.yaml | 82 +++++++++++++++++++
>  1 file changed, 82 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/power/supply/cw2015_battery.yaml
> 

Please add Acked-by/Reviewed-by tags when posting new versions. However,
there's no need to repost patches *only* to add the tags. The upstream
maintainer will do that for acks received on the version they apply.

If a tag was not added on purpose, please state why and what changed.
