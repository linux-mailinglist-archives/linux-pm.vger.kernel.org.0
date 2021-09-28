Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F29AD41B657
	for <lists+linux-pm@lfdr.de>; Tue, 28 Sep 2021 20:32:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242500AbhI1SeR (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 28 Sep 2021 14:34:17 -0400
Received: from h04mx15.reliablemail.org ([185.76.67.208]:38487 "EHLO
        h04mx15.reliablemail.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242510AbhI1Sdv (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 28 Sep 2021 14:33:51 -0400
X-Halon-Out: 61755fa5-208a-11ec-a232-556aad082471
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=grimler.se;
        s=default; h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:
        Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=ZICk2IYCnmzzwW2vK4JY7Si4OBFyGwQO3d/G7vlr/BQ=; b=LCPCFk2+4M5wg+6dmSb/IBwTmw
        yaNMjvqq6tr764TBMpp57qZnAn9x9jxOiGJro5ZhhTLzSEPys2riXJzTXRBcertQhkZ4XWWOnDa5x
        jdAaKgKQPrcZSCP7OVREu36W7joDv2B5iJGBgWz4kBSi4nP/AA8u/GbrMHyxTfNX0KSndIw+U82tV
        MZHdc+5uMDxQJ9+HAYx9q0btFgnzkeuUhAnzDhRgFKoFLAG4w0mU1aAbbZIS0VRnlbsR1C8lTd9EN
        Ve/fS8g2sg/9AIzCao7oBraznPVy29PxRomP/2yahNHVy5x5dP/pNuHxJ8JCPGWYi8yTdbUWQ5XOJ
        Ob1d+D/A==;
Date:   Tue, 28 Sep 2021 20:32:03 +0200
From:   Henrik Grimler <henrik@grimler.se>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Cc:     sre@kernel.org, linux-pm@vger.kernel.org,
        linux-samsung-soc@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht, wolfgit@wiedmeyer.de,
        Sebastian Krzyszkowiak <sebastian.krzyszkowiak@puri.sm>,
        Hans de Goede <hdegoede@redhat.com>,
        Nikita Travkin <nikita@trvn.ru>
Subject: Re: [PATCH 1/1] power: supply: max17042_battery: use VFSOC for
 capacity when no rsns
Message-ID: <YVNfo75ALWWGLZeA@grimlerstat.localdomain>
References: <20210919200735.142862-1-henrik@grimler.se>
 <20210919200735.142862-2-henrik@grimler.se>
 <17ba5aaa-c456-2bb9-1680-ff0a302b412f@canonical.com>
 <YVIWC5gehfh3TXX/@grimlerstat.localdomain>
 <6b77953f-cbad-5688-7364-667975309f8f@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6b77953f-cbad-5688-7364-667975309f8f@canonical.com>
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

On Tue, Sep 28, 2021 at 11:18:27AM +0200, Krzysztof Kozlowski wrote:
> On 27/09/2021 21:05, Henrik Grimler wrote:
> > On Fri, Sep 24, 2021 at 01:45:29PM +0200, Krzysztof Kozlowski wrote:
> >> If you switch to VSSoc, I think you need to modify the SOC Alert Config
> >> in MiscCFG register (bits 0:1 to 0x1). Otherwise the alerts will be
> >> generated on different value.
> > 
> > So, 0x1 should correspond to AvSOC (i.e. non-filtered RepSOC), while
> > right now we write 0x3 (VFSOC) to MiscCFG for devices without current
> > sense [1]. Could you elaborate on why AvSOC should be used for alert
> > if we use VFSOC to get PROP_CAPACITY?
> 
> I meant that same measurement should be used for both: for PROP_CAPACITY
> and for alerts.
> 
> I double checked the driver and your change is actually aligned with it.
> If !enable_current_sense, the driver will set MiscCFG to 0x3 to use
> VFSOC for alerts. I think you can ignore that part of my comment before.

Makes sense, thanks!

> However still remaining issue is that switching to VFSoc should happen
> not only if !enable_current_sense but also if ModelGauge m3 is not
> configured.

If I manage to get ModelGauge working on this device in the future I
can address this.

> > On this particular device it does not seem to make a difference what I
> > use for the SOC alert, the alert triggers all the time in any case
> > since RepSOC does not give an accurate value. Supposedly this happens
> > because ModelGauge configuration is incomplete, as you said. Looking
> > at the registers used by the ModelGauge it seems that only the
> > "characterization table" at 0x80 - 0xAF is missing. The rest (FullCap,
> > DesignCap, ICHGTerm, ..) are set to the same values as with vendor
> > kernel.
> 
> Are you sure? I could not find setting of these (e.g.
> MAX17042_FullCAP/config->fullcap) for a DT platform.

Actually, it seems that the registers are set to the default Power-On
Reset (POR) values in both mainline and vendor kernel.  Printing all
the Cell Characterization Information Registers (given in Table 1 in
the MAX17047 datasheet) with something like:

    u32 tmp;
    regmap_read(chip->regmap, MAX17042_FullCAP, &tmp);
    dev_err(&chip->client->dev, "Fullcap %04x\n", tmp);

in both vendor kernel and mainline gives the same values:

    Fullcap    07d0
    DesignCap  07d0
    ICHGTerm   03c0
    FullCapNom 0667
    RCOMP0     0065
    Iavg_empty 0780
    TempCo     0930
    QRes 00    1e2f
    QRes 10    1e00
    QRes 20    1306
    QRes 30    0c00

and these are the POR values (seen in Table 5 of the datasheet).  Only
difference between vendor and mainline is that MAX17042_MODELChrTbl is
all zeros on mainline, while with vendor kernel I get something like:

    00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 
    00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 
    00 50 05 c0 a0 85 a9 f1 e0 5d 84 f1 01 00 00 00

and the values here change over time as well, as the algorithm learns
about the battery(?).

Maybe this means that the ModelGauge algorithm is not configured with
vendor kernel either, and that a full battery characterization
(described in [1]) is needed if we are to use ModelGauge.  ModelGauge
is also not mentioned in the vendor kernel driver for max17047 [2],
but it is mentioned in the very similar max17042 [3] and max17050
drivers in the same kernel.

> Best regards,
> Krzysztof

[1] https://pdfserv.maximintegrated.com/en/an/AN4799.pdf
[2] https://github.com/LineageOS/android_kernel_samsung_smdk4412/blob/2489007e7d74/drivers/battery/max17047_fuelgauge.c
[3] https://github.com/LineageOS/android_kernel_samsung_smdk4412/blob/2489007e7d74/drivers/battery/max17042_fuelgauge.c

Best regards,
Henrik Grimler
