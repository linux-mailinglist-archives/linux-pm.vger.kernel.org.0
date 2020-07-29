Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B5EB2231AD8
	for <lists+linux-pm@lfdr.de>; Wed, 29 Jul 2020 10:07:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727888AbgG2IH5 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 29 Jul 2020 04:07:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727042AbgG2IH5 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 29 Jul 2020 04:07:57 -0400
X-Greylist: delayed 2395 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 29 Jul 2020 01:07:57 PDT
Received: from cavan.codon.org.uk (cavan.codon.org.uk [IPv6:2a00:1098:0:80:1000:c:0:1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D38FC061794;
        Wed, 29 Jul 2020 01:07:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=codon.org.uk; s=63138784; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=bX2NW+bQ7J25ucCAclCnjJzxJsNBxEwD3yGGaPM+RDc=; b=pO4fGZ+uOiD+9pv9wYjU6Nbun
        1hDM8MeFTu5kZQECbz20LzYPdhJAx+MLqpvQFeFau7m8FPsz4qKII6STXRCelniQMuQwPkkk6ghh5
        5cjIRWy7/hZT9xl+lnPfuZV3ryVXP6GLl4ODicC56Tsj3mNqsym1knDX6aQNSxR44cLJ0=;
Received: from mjg59 by cavan.codon.org.uk with local (Exim 4.89)
        (envelope-from <mjg59@cavan.codon.org.uk>)
        id 1k0gVI-0000dh-Tn; Wed, 29 Jul 2020 08:27:56 +0100
Date:   Wed, 29 Jul 2020 08:27:56 +0100
From:   Matthew Garrett <mjg59@srcf.ucam.org>
To:     Perry Yuan <Perry.Yuan@dell.com>
Cc:     sre@kernel.org, pali@kernel.org, dvhart@infradead.org,
        andy@infradead.org, mario.limonciello@dell.com,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        platform-driver-x86@vger.kernel.org
Subject: Re: [PATCH] platform/x86:dell-laptop:Add battery charging thresholds
 and charging mode switch.
Message-ID: <20200729072756.46skroedpbo3fjyn@srcf.ucam.org>
References: <20200729065424.12851-1-Perry_Yuan@Dell.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200729065424.12851-1-Perry_Yuan@Dell.com>
User-Agent: NeoMutt/20170113 (1.7.2)
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: mjg59@cavan.codon.org.uk
X-SA-Exim-Scanned: No (on cavan.codon.org.uk); SAEximRunCond expanded to false
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Tue, Jul 28, 2020 at 11:54:24PM -0700, Perry Yuan wrote:

This seems extremely useful, but:

> diff --git a/Documentation/ABI/testing/sysfs-class-power b/Documentation/ABI/testing/sysfs-class-power
> index bf3b48f022dc..a8adc3b0ca4b 100644
> --- a/Documentation/ABI/testing/sysfs-class-power
> +++ b/Documentation/ABI/testing/sysfs-class-power
> @@ -334,6 +334,29 @@ Description:
>  		Access: Read
>  		Valid values: Represented in microvolts
>  
> +What:		/sys/class/power_supply/<supply_name>/charge_control_charging_mode
> +Date:		March 2020
> +Contact:	linux-pm@vger.kernel.org

The values here seem very Dell specific, but this is going into a 
generic sysfs path. Really stuff here should be as vendor independent as 
possible. If these values don't correspond to a wider industry 
specification it probably makes sense to make this something Dell 
specific.

-- 
Matthew Garrett | mjg59@srcf.ucam.org
