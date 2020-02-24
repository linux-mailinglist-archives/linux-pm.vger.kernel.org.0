Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 48C5016A6E5
	for <lists+linux-pm@lfdr.de>; Mon, 24 Feb 2020 14:08:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727699AbgBXNIN (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 24 Feb 2020 08:08:13 -0500
Received: from fllv0016.ext.ti.com ([198.47.19.142]:37492 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727329AbgBXNIK (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 24 Feb 2020 08:08:10 -0500
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 01OD7CsK028839;
        Mon, 24 Feb 2020 07:07:12 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1582549632;
        bh=Tx9NLTynxh7HMA5VHJWXsAof1AdXnE/KAs53Nqq7E70=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=J8OaXTwY6rJidCznLf2G/vSUju+4HU3kRW0QV+CMkL2fpPxI5mFwt5l1u7GY1i0cK
         fhdwF15G4WtYxb0NBQQmKRDL/VCrdAXaZORkAKh4uNPMzhrjf4desB5yiRBKSQYI5e
         lr23otClWqEaN2djtLEvvM3O3oRjPmZTJi+w6edQ=
Received: from DLEE115.ent.ti.com (dlee115.ent.ti.com [157.170.170.26])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 01OD7CFB102821
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 24 Feb 2020 07:07:12 -0600
Received: from DLEE101.ent.ti.com (157.170.170.31) by DLEE115.ent.ti.com
 (157.170.170.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3; Mon, 24
 Feb 2020 07:07:11 -0600
Received: from fllv0040.itg.ti.com (10.64.41.20) by DLEE101.ent.ti.com
 (157.170.170.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3 via
 Frontend Transport; Mon, 24 Feb 2020 07:07:12 -0600
Received: from [10.250.65.13] (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 01OD7B3m002482;
        Mon, 24 Feb 2020 07:07:11 -0600
Subject: Re: [PATCH 2/7] docs: dt: fix several broken references due to
 renames
To:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>
CC:     Jonathan Corbet <corbet@lwn.net>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Rob Herring <robh+dt@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, Jyri Sarha <jsarha@ti.com>,
        Tomi Valkeinen <tomi.valkeinen@ti.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Jacek Anaszewski <jacek.anaszewski@gmail.com>,
        Pavel Machek <pavel@ucw.cz>, Stuart Yoder <stuyoder@gmail.com>,
        Laurentiu Tudor <laurentiu.tudor@nxp.com>,
        Andrew Jeffery <andrew@aj.id.au>,
        Linus Walleij <linus.walleij@linaro.org>,
        Joel Stanley <joel@jms.id.au>,
        Kevin Hilman <khilman@baylibre.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        Zhang Rui <rui.zhang@intel.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Amit Kucheria <amit.kucheria@verdurent.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-arm-msm@vger.kernel.org>,
        <linux-clk@vger.kernel.org>, <dri-devel@lists.freedesktop.org>,
        <linux-leds@vger.kernel.org>, <linux-aspeed@lists.ozlabs.org>,
        <openbmc@lists.ozlabs.org>, <linux-gpio@vger.kernel.org>,
        <linux-amlogic@lists.infradead.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-pm@vger.kernel.org>
References: <cover.1582361737.git.mchehab+huawei@kernel.org>
 <83c5df4acbbe0fa55a1d58d4c4a435b51cd2a7ad.1582361737.git.mchehab+huawei@kernel.org>
From:   Dan Murphy <dmurphy@ti.com>
Message-ID: <e9ae8125-3f8f-5f8c-c19c-34ac1bb5c982@ti.com>
Date:   Mon, 24 Feb 2020 07:02:01 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <83c5df4acbbe0fa55a1d58d4c4a435b51cd2a7ad.1582361737.git.mchehab+huawei@kernel.org>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Mauro

On 2/22/20 3:00 AM, Mauro Carvalho Chehab wrote:
> Several DT references got broken due to txt->yaml conversion.
>
> Those are auto-fixed by running:
>
> 	scripts/documentation-file-ref-check --fix
>
> Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
> ---
>   Documentation/devicetree/bindings/arm/arm,scmi.txt        | 2 +-
>   Documentation/devicetree/bindings/arm/arm,scpi.txt        | 2 +-
>   .../devicetree/bindings/arm/bcm/brcm,bcm63138.txt         | 2 +-
>   .../devicetree/bindings/arm/hisilicon/hi3519-sysctrl.txt  | 2 +-
>   .../devicetree/bindings/arm/msm/qcom,idle-state.txt       | 2 +-
>   Documentation/devicetree/bindings/arm/omap/mpu.txt        | 2 +-
>   Documentation/devicetree/bindings/arm/psci.yaml           | 2 +-
>   .../devicetree/bindings/clock/qcom,gcc-apq8064.yaml       | 2 +-
>   .../devicetree/bindings/display/tilcdc/tilcdc.txt         | 2 +-
>   Documentation/devicetree/bindings/leds/common.yaml        | 2 +-

For LEDs

Reviewed-by: Dan Murphy <dmurphy@ti.com>


