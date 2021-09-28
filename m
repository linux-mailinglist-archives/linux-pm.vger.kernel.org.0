Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A5F5B41B766
	for <lists+linux-pm@lfdr.de>; Tue, 28 Sep 2021 21:18:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242377AbhI1TUb (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 28 Sep 2021 15:20:31 -0400
Received: from h03mx16.reliablemail.org ([173.236.90.20]:41373 "EHLO
        h03mx16.reliablemail.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242253AbhI1TU3 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 28 Sep 2021 15:20:29 -0400
X-Halon-Out: e72c9685-2090-11ec-a67c-00163c72d6d3
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=grimler.se;
        s=default; h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:
        Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=6gdqqI/giyhAYUrbUwjWsKNav3qRv+eFiZ0eQNMhlhI=; b=Rro2Q17P19gqh2Cii+Ba2zrHdP
        SorXS9mEu2REKZ5+XsX1MDg2il+YUBf0k3K7WonrbeVHfxhgNKgTHbDXrvLeirg5v8Q0FD5HhmYXk
        rF7N53XX5s5/erFDmSCmE2ujtmOHzGTFfonCfPubfddnQRLDXvqSmbk2YaXw6wjIRa/UgAKeY9peb
        nv2i21fyL5aCagO2vXD4iz2/itmjF2WCnbUI7LZe7BukTZ4hTkoTpzKmA5uq2OWxfcsB9OV2QTnve
        Nm2ZD6ot6CYLU3A/cEEQ+r/8cuY848GDESnvQ+cvrk2/256XFpX3Q4ZncACt9sAiWaMIl/42qz0Q9
        wiEY8zKg==;
Date:   Tue, 28 Sep 2021 21:18:44 +0200
From:   Henrik Grimler <henrik@grimler.se>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Cc:     sre@kernel.org, linux-pm@vger.kernel.org,
        linux-samsung-soc@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht, wolfgit@wiedmeyer.de
Subject: Re: [PATCH 1/1] power: supply: max17042_battery: use VFSOC for
 capacity when no rsns
Message-ID: <YVNqlIIAJNil5MFL@grimlerstat.localdomain>
References: <20210919200735.142862-1-henrik@grimler.se>
 <20210919200735.142862-2-henrik@grimler.se>
 <febc15c6-8a40-cc0c-d98c-bbefc9cc953d@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <febc15c6-8a40-cc0c-d98c-bbefc9cc953d@canonical.com>
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - cpsrv07.misshosting.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - grimler.se
X-Get-Message-Sender-Via: cpsrv07.misshosting.com: authenticated_id: henrik@grimler.se
X-Authenticated-Sender: cpsrv07.misshosting.com: henrik@grimler.se
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Tue, Sep 28, 2021 at 11:22:15AM +0200, Krzysztof Kozlowski wrote:
> On 19/09/2021 22:07, Henrik Grimler wrote:
> > On Galaxy S3 (i9300/i9305), which has the max17047 fuel gauge and no
> > current sense resistor (rsns), the RepSOC register does not provide an
> > accurate state of charge value. The reported value is wrong, and does
> > not change over time. VFSOC however, which uses the voltage fuel gauge
> > to determine the state of charge, always shows an accurate value.
> > 
> > At least one max170xx driver, found in Asus' Z00D kernel [1], chooses
> > how to get the capacity based on if current sense is available or not.
> > Lets change the mainline driver to match the Asus Z00D driver's
> > behaviour and thereby fix so that correct state of charge values are
> > obtained on Galaxy S3.
> > 
> > [1] https://github.com/LineageOS/android_kernel_asus_Z00D/blob/c7ab0e3ec5b5/drivers/power/max17042_battery.c#L1103-L1105
> > 
> > Suggested-by: Wolfgang Wiedmeyer <wolfgit@wiedmeyer.de>
> > Signed-off-by: Henrik Grimler <henrik@grimler.se>
> > ---
> >  drivers/power/supply/max17042_battery.c | 5 ++++-
> >  1 file changed, 4 insertions(+), 1 deletion(-)
> > 
> 
> After explanation and double-checking of driver this makes sense. The
> driver already uses VFSoc for alerts (MiscCFG register) if
> !enable_current_sense.
> 
> Fixes: 359ab9f5b154 ("power_supply: Add MAX17042 Fuel Gauge Driver")
> Cc: <stable@vger.kernel.org>
> 
> These could be added when applying but maybe Sebastian wants a v2 with it?
> 
> Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>

I can send a v2 with updated commit message to mention that we already
use VFSOC for the alert on this device, and sneak in a patch to fix a
typo in Iavg_empty parameter.

> Best regards,
> Krzysztof

Best regards,
Henrik Grimler
