Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 61D7BC4725
	for <lists+linux-pm@lfdr.de>; Wed,  2 Oct 2019 07:47:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726360AbfJBFrk (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 2 Oct 2019 01:47:40 -0400
Received: from mo4-p01-ob.smtp.rzone.de ([85.215.255.54]:12193 "EHLO
        mo4-p01-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726266AbfJBFrj (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 2 Oct 2019 01:47:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1569995255;
        s=strato-dkim-0002; d=goldelico.com;
        h=To:References:Message-Id:Cc:Date:In-Reply-To:From:Subject:
        X-RZG-CLASS-ID:X-RZG-AUTH:From:Subject:Sender;
        bh=m4MmnejFIePSpi3WGLlVz9LTEEmUQI0FZsmc67nbE3A=;
        b=U5L1CM3BWEaRd+2HvFX6EQkGXWY1nN6nQOOoq4bP3JIwXOBcZeArf4ZkQKkkMVIQxu
        TvS8TBJ7qUpuAPC+DVvWysRZaXOQar4Wc0XlLv12cJ8oLlj1bmOJbHfYC2/Jzb4tRlZk
        585I+socoe3+t0Yuo0XQlAkEVPWEnEKFMriNBzeag6h83cqz7AZl4dW6l/om7TmsQRWj
        SNSwuPfQOxbQIfEkyIc7UeQdFw3sM1vP7UK2Q+G8Kw/BBF3EGCX+m2iY5hOv8bpgiMDB
        Ybgk/Zep7WV+YjUJdvEhw0cS282zVeu5kObgGka2LeMfsY1ZulTUpX3moUP/JWDqTf0h
        MoKA==
X-RZG-AUTH: ":JGIXVUS7cutRB/49FwqZ7WcJeFKiMgPgp8VKxflSZ1P34KBj4Qpw9iZeHmMgw47pPLg="
X-RZG-CLASS-ID: mo00
Received: from imac.fritz.box
        by smtp.strato.de (RZmta 44.28.0 DYNA|AUTH)
        with ESMTPSA id v00409v925l7Zg4
        (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (curve secp521r1 with 521 ECDH bits, eq. 15360 bits RSA))
        (Client did not present a certificate);
        Wed, 2 Oct 2019 07:47:07 +0200 (CEST)
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Subject: Re: [PATCH v3 0/8] OMAP3: convert opp-v1 to opp-v2 and read speed binned / 720MHz grade bits
From:   "H. Nikolaus Schaller" <hns@goldelico.com>
In-Reply-To: <DAF6ACB4-AD7E-4528-9F4B-C54104B5E260@goldelico.com>
Date:   Wed, 2 Oct 2019 07:47:07 +0200
Cc:     =?utf-8?Q?Beno=C3=AEt_Cousson?= <bcousson@baylibre.com>,
        Rob Herring <robh+dt@kernel.org>,
        Adam Ford <aford173@gmail.com>,
        =?utf-8?Q?Andr=C3=A9_Roth?= <neolynx@gmail.com>,
        Mark Rutland <mark.rutland@arm.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Enric Balletbo i Serra <eballetbo@gmail.com>,
        Javier Martinez Canillas <javier@dowhile0.org>,
        Roger Quadros <rogerq@ti.com>,
        Teresa Remmet <t.remmet@phytec.de>, linux-omap@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, letux-kernel@openphoenux.org,
        kernel@pyra-handheld.com, linux-arm-kernel@lists.infradead.org
Content-Transfer-Encoding: 7bit
Message-Id: <8C3DD775-07DF-45E0-8E04-2B050CEB5800@goldelico.com>
References: <cover.1568224032.git.hns@goldelico.com> <20190916162816.GF52127@atomide.com> <DAF6ACB4-AD7E-4528-9F4B-C54104B5E260@goldelico.com>
To:     Tony Lindgren <tony@atomide.com>
X-Mailer: Apple Mail (2.3124)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Tony,

> Am 17.09.2019 um 16:35 schrieb H. Nikolaus Schaller <hns@goldelico.com>:
> 
> Hi Tony,
> 
>> Am 16.09.2019 um 18:28 schrieb Tony Lindgren <tony@atomide.com>:
>> 
>> * H. Nikolaus Schaller <hns@goldelico.com> [190911 17:48]:
>>> CHANGES V3:
>>> * make omap36xx control the abb-ldo and properly switch mode
>>> (suggested by Adam Ford <aford173@gmail.com>)
>>> * add a note about enabling the turbo-mode OPPs
>> 
>> Looks good to me, when applying, please provide a
>> minimal immutable branch maybe against v5.3 or v5.4-rc1,
>> that I can also merge in if needed for the dts changes.
> 
> Should I resend a v4 with your Acked-By added?
> 
> BR and thanks,
> Nikolaus
> 

what is the procedure to get this and Adam's thermal setup into linux-next?
BR and thanks,
Nikolaus



