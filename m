Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 30BF5B507A
	for <lists+linux-pm@lfdr.de>; Tue, 17 Sep 2019 16:35:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728324AbfIQOf1 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 17 Sep 2019 10:35:27 -0400
Received: from mo4-p02-ob.smtp.rzone.de ([81.169.146.169]:33219 "EHLO
        mo4-p02-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728128AbfIQOf1 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 17 Sep 2019 10:35:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1568730925;
        s=strato-dkim-0002; d=goldelico.com;
        h=To:References:Message-Id:Cc:Date:In-Reply-To:From:Subject:
        X-RZG-CLASS-ID:X-RZG-AUTH:From:Subject:Sender;
        bh=aDkxVMbY8vRvqozEwY9dfWbrp1yfXlJPYl/GV2fom4s=;
        b=TEA2P3pdTKwtdTJbORsNcJvcpWV+xP3Cn45HdtSkp5vdIgFyvrkVum+t2l+QQ+yhHf
        6DvmGvykcNsS+QIfYnoAWtnqROv6k22YHLzUroaUNAqbLMFmTHPBOeYiiq+LgBPHgYsO
        Yfk8SdGSmMrkzszN1LOhp/JIgjMsb4C2DV5TfCDhV4Q/OkYBW2ltOl8WlqmzgawF629O
        VsRLLFZfXizeshXSciPKUPgtIvvhaL8HfmQi9sJzjsZweYtL5wOrdEk2Z7pNKRy6Kt2i
        VnYgKUJiqZpp+Ur3vVLhVZH6zG0obe2yzRJSe4x3k5GNQ5u7ksXbjZhl/dEsjNakPuf0
        NjfQ==
X-RZG-AUTH: ":JGIXVUS7cutRB/49FwqZ7WcJeFKiMgPgp8VKxflSZ1P34KBp5hRw/qOxWRk4dCyjDPUnsm74p9bR0nKSw0V7uzbYrtFUHmEd2msW"
X-RZG-CLASS-ID: mo00
Received: from [IPv6:2001:16b8:266f:d200:e9b9:e9c0:8734:b26d]
        by smtp.strato.de (RZmta 44.27.0 AUTH)
        with ESMTPSA id u036f9v8HEZ6XP4
        (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (curve secp521r1 with 521 ECDH bits, eq. 15360 bits RSA))
        (Client did not present a certificate);
        Tue, 17 Sep 2019 16:35:06 +0200 (CEST)
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Subject: Re: [PATCH v3 0/8] OMAP3: convert opp-v1 to opp-v2 and read speed binned / 720MHz grade bits
From:   "H. Nikolaus Schaller" <hns@goldelico.com>
In-Reply-To: <20190916162816.GF52127@atomide.com>
Date:   Tue, 17 Sep 2019 16:35:22 +0200
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
Message-Id: <DAF6ACB4-AD7E-4528-9F4B-C54104B5E260@goldelico.com>
References: <cover.1568224032.git.hns@goldelico.com> <20190916162816.GF52127@atomide.com>
To:     Tony Lindgren <tony@atomide.com>
X-Mailer: Apple Mail (2.3124)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Tony,

> Am 16.09.2019 um 18:28 schrieb Tony Lindgren <tony@atomide.com>:
> 
> * H. Nikolaus Schaller <hns@goldelico.com> [190911 17:48]:
>> CHANGES V3:
>> * make omap36xx control the abb-ldo and properly switch mode
>>  (suggested by Adam Ford <aford173@gmail.com>)
>> * add a note about enabling the turbo-mode OPPs
> 
> Looks good to me, when applying, please provide a
> minimal immutable branch maybe against v5.3 or v5.4-rc1,
> that I can also merge in if needed for the dts changes.

Should I resend a v4 with your Acked-By added?

BR and thanks,
Nikolaus

