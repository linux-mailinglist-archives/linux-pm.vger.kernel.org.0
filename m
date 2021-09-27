Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 51ED6419EDC
	for <lists+linux-pm@lfdr.de>; Mon, 27 Sep 2021 21:05:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236101AbhI0THb (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 27 Sep 2021 15:07:31 -0400
Received: from h04mx15.reliablemail.org ([185.76.67.208]:11335 "EHLO
        h04mx15.reliablemail.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235880AbhI0THa (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 27 Sep 2021 15:07:30 -0400
X-Halon-Out: eda8a205-1fc5-11ec-a232-556aad082471
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=grimler.se;
        s=default; h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:
        Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=pN1JWfUtQK5RnfrNT62FZbXkwiasWCkQhH5ojUXTPSc=; b=Y8kjVHTQo/i3uIj4FOMETduDxQ
        n9H4dC6dDw32hqmR54757Dbk6oo5zjz2nzOkMKKNGVRb0+9clo6o/EKItlZ83rLf6pmwwFFUJ6sOq
        y+iZ3mzlJXFSUB+Vabb7c4958ZIUyFu4d4FtC8mIM7RKW1BoLfFTQRiH5lP/SjQV72hEVAT+jNYc+
        66wpdRa8agp24w/85HyqR+hoLTppDsJbOjIEWACxO2dGeepjx9CSuBFLvTUMc4eOGP9bhSNTIY/5R
        C5SFuzIlezH25YNLiyy5Yrsrl86Wz3IQ2pw8VSsKdZQG/LWivkDV4TJHOXJoPQKUJZhDcI2DyRJUY
        2UUk5OpQ==;
Date:   Mon, 27 Sep 2021 21:05:47 +0200
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
Message-ID: <YVIWC5gehfh3TXX/@grimlerstat.localdomain>
References: <20210919200735.142862-1-henrik@grimler.se>
 <20210919200735.142862-2-henrik@grimler.se>
 <17ba5aaa-c456-2bb9-1680-ff0a302b412f@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <17ba5aaa-c456-2bb9-1680-ff0a302b412f@canonical.com>
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

On Fri, Sep 24, 2021 at 01:45:29PM +0200, Krzysztof Kozlowski wrote:
> Thanks for the patch. I found also my comments to Wolfgang's patch in
> 2016, which you resolve here but I have more. :)
> 
> I think my previous message about current sense are not correct. What is
> important is whether ModelGauge is being used/configured. For example
> none of DT platforms support it but ACPI might.
> There is incoming patch around it:
> https://lore.kernel.org/lkml/5702731.UytLkSCjyO@pliszka/
> 
> If you switch to VSSoc, I think you need to modify the SOC Alert Config
> in MiscCFG register (bits 0:1 to 0x1). Otherwise the alerts will be
> generated on different value.

So, 0x1 should correspond to AvSOC (i.e. non-filtered RepSOC), while
right now we write 0x3 (VFSOC) to MiscCFG for devices without current
sense [1]. Could you elaborate on why AvSOC should be used for alert
if we use VFSOC to get PROP_CAPACITY?

On this particular device it does not seem to make a difference what I
use for the SOC alert, the alert triggers all the time in any case
since RepSOC does not give an accurate value. Supposedly this happens
because ModelGauge configuration is incomplete, as you said. Looking
at the registers used by the ModelGauge it seems that only the
"characterization table" at 0x80 - 0xAF is missing. The rest (FullCap,
DesignCap, ICHGTerm, ..) are set to the same values as with vendor
kernel.

> Different topic:
> When touching Exynos-based boards (like Galaxy S3), please Cc me as
> well, even if I don't pop up in the maintainers.
> 
> For max17042 we need to Cc broader group of users, for example using it
> in ACPI platforms. The best is to pick the contributors.

Thanks for taking the time to explain this.

> Best regards,
> Krzysztof

[1]
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/power/supply/max17042_battery.c#n1092

Best regards,
Henrik Grimler
