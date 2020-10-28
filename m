Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 61E2D29F2CB
	for <lists+linux-pm@lfdr.de>; Thu, 29 Oct 2020 18:17:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726939AbgJ2RRA (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 29 Oct 2020 13:17:00 -0400
Received: from fllv0016.ext.ti.com ([198.47.19.142]:37836 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726811AbgJ2RRA (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 29 Oct 2020 13:17:00 -0400
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 09S7YVAk082354;
        Wed, 28 Oct 2020 02:34:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1603870471;
        bh=7FyZjDkPHbMjozn34bZ1VFAs7xk/d+XHz6/LdreHKWs=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=dJEN1ctsuk0x/MhIn9kicNY8j5dfoWjL0YljwcBvyjv84F1z0Ij5yXFezP81eiEe6
         5rxXcKttRiPFcGpmH3GLpam637JrIeaQlwIoOqYZ3Ew4hBti+gn6LV+5tz4hUSOA0n
         Qr/VDFo9iGbkQRFRTIAT4fM7AL/kzpmnMrBVxPzQ=
Received: from DLEE105.ent.ti.com (dlee105.ent.ti.com [157.170.170.35])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 09S7YUk2089455
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 28 Oct 2020 02:34:31 -0500
Received: from DLEE112.ent.ti.com (157.170.170.23) by DLEE105.ent.ti.com
 (157.170.170.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Wed, 28
 Oct 2020 02:34:30 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DLEE112.ent.ti.com
 (157.170.170.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Wed, 28 Oct 2020 02:34:30 -0500
Received: from [192.168.2.6] (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 09S7YRlP097403;
        Wed, 28 Oct 2020 02:34:27 -0500
Subject: Re: [PATCH v1] of: platform: Batch fwnode parsing in the
 init_machine() path
To:     Saravana Kannan <saravanak@google.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>
CC:     Grygorii Strashko <grygorii.strashko@ti.com>,
        Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-omap <linux-omap@vger.kernel.org>,
        "open list:THERMAL" <linux-pm@vger.kernel.org>,
        Peter Ujfalusi <peter.ujfalusi@ti.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Tony Lindgren <tony@atomide.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Android Kernel Team <kernel-team@android.com>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <CAGETcx8owDP_Bu4oNCyHEsME8XpKygxghm8+yNc2RyMA4wyjCA@mail.gmail.com>
 <20201001225952.3676755-1-saravanak@google.com>
 <CAL_JsqKOUkKBKyxPtZ+BFXPiOfm2uPXhgJPxKP=WS-qX6kSB0w@mail.gmail.com>
 <CAGETcx-tq446JQN0RpKhtyCXB+Y_PUePN_tBZsUmtpO7othm4g@mail.gmail.com>
 <20201002175423.GE3933@pendragon.ideasonboard.com>
 <CAGETcx-7nJaU6pDo_KL-nKmCaxv57C5aaXq-pvo4XiN=N0K5Jg@mail.gmail.com>
 <20201002182712.GF3933@pendragon.ideasonboard.com>
 <11018e7e-a6a1-2df6-5639-821a7c0cb68b@ti.com>
 <CAGETcx8DCiEJy-1PiHheyuuw3YBYfFh67MBcOwv4JEviXmsp3Q@mail.gmail.com>
 <20201003001342.GA1730@pendragon.ideasonboard.com>
 <CAGETcx8Vy2k8igc9QmktFohJSQXvdPTFYu8i_8tgeYvBLk6QfA@mail.gmail.com>
From:   Tomi Valkeinen <tomi.valkeinen@ti.com>
Message-ID: <3fece387-94d9-b806-4cc0-fc20b6be4c6e@ti.com>
Date:   Wed, 28 Oct 2020 09:34:26 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <CAGETcx8Vy2k8igc9QmktFohJSQXvdPTFYu8i_8tgeYvBLk6QfA@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 27/10/2020 05:29, Saravana Kannan wrote:

> Can you try throwing around fw_devlink_pause/resume() around the
> of_platform_populate() call in arch/arm/mach-omap2/pdata-quirks.c?
> Just trying to verify the cause/fix.

AM5 EVM on v5.10-rc1:

[    1.139945] cpuidle: using governor menu
[   13.126461] No ATAGs?

After adding fw_devlink_pause/resume around of_platform_populate:

[    1.139587] cpuidle: using governor menu
[    1.899913] No ATAGs?

 Tomi

-- 
Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
