Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A3E1B4531FC
	for <lists+linux-pm@lfdr.de>; Tue, 16 Nov 2021 13:18:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235749AbhKPMVM (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 16 Nov 2021 07:21:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232525AbhKPMVL (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 16 Nov 2021 07:21:11 -0500
Received: from todd.t-8ch.de (todd.t-8ch.de [IPv6:2a01:4f8:c010:41de::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F410C061746;
        Tue, 16 Nov 2021 04:18:13 -0800 (PST)
Date:   Tue, 16 Nov 2021 13:18:09 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=weissschuh.net;
        s=mail; t=1637065091;
        bh=cCgpA89cKBgN/pAn0p9KVi8LU03GGQSfKl3QzsHCXw8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=IqOFjlcX/Pgfrfec+ZiVtqFM7Oxra6IElEHtEWj3fzCyBvGm3Dd+stv9soWOciLXR
         v+7DgjstXGAf1c2O5745wioBd8HLs+TtQi/5wDSC7o/Cb91DibrSQpwL7n1QbzCvzQ
         OnLTVMWbU7jFPE5B0+hrXVBrDydlPxo5gxgJbTHA=
From:   Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <linux@weissschuh.net>
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     linux-pm@vger.kernel.org, Sebastian Reichel <sre@kernel.org>,
        ibm-acpi-devel@lists.sourceforge.net,
        platform-driver-x86@vger.kernel.org,
        Mark Gross <markgross@kernel.org>,
        Henrique de Moraes Holschuh <hmh@hmh.eng.br>,
        linux-kernel@vger.kernel.org, linrunner@gmx.net, bberg@redhat.com,
        hadess@hadess.net, markpearson@lenovo.com,
        nicolopiazzalunga@gmail.com, njoshi1@lenovo.com, smclt30p@gmail.com
Subject: Re: [PATCH 4/4] platform/x86: thinkpad_acpi: support inhibit-charge
Message-ID: <754b4466-4636-4a51-980a-5e5c21953f44@t-8ch.de>
References: <20211113104225.141333-1-linux@weissschuh.net>
 <20211113104225.141333-5-linux@weissschuh.net>
 <09a66da1-1a8b-a668-3179-81670303ea37@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <09a66da1-1a8b-a668-3179-81670303ea37@redhat.com>
Jabber-ID: thomas@t-8ch.de
X-Accept: text/plain, text/html;q=0.2, text/*;q=0.1
X-Accept-Language: en-us, en;q=0.8, de-de;q=0.7, de;q=0.6
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Hans,

On 2021-11-16 11:58+0100, Hans de Goede wrote:
> Thank you for working on this!

Thanks for the review!

> On 11/13/21 11:42, Thomas Weißschuh wrote:
> > @@ -9673,6 +9711,11 @@ static ssize_t charge_behaviour_show(struct device *dev,
> >  			return -ENODEV;
> >  		if (ret)
> >  			active = POWER_SUPPLY_CHARGE_BEHAVIOUR_FORCE_DISCHARGE;
> > +	} else if (available & BIT(POWER_SUPPLY_CHARGE_BEHAVIOUR_INHIBIT_CHARGE)) {
> 
> The use of else-if here seems wrong, this suggests that batterys can never
> support both force-discharge and inhibit-charge behavior, which they can, so this
> means that active can now never get set to BEHAVIOUR_INHIBIT_CHARGE on
> batteries which support both.
> 
> So AFAICT the else part of the else if should be dropped here, making this
> a new stand alone if block.

Indeed, I'll fix this logic for v2.

Thanks,
Thomas
