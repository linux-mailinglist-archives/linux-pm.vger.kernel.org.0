Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1F56A25371E
	for <lists+linux-pm@lfdr.de>; Wed, 26 Aug 2020 20:28:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726820AbgHZS2n (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 26 Aug 2020 14:28:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726753AbgHZS2l (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 26 Aug 2020 14:28:41 -0400
Received: from mail.andi.de1.cc (mail.andi.de1.cc [IPv6:2a01:238:4321:8900:456f:ecd6:43e:202c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A349EC061756;
        Wed, 26 Aug 2020 11:28:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=kemnade.info; s=20180802; h=Content-Transfer-Encoding:Content-Type:
        MIME-Version:References:In-Reply-To:Message-ID:Subject:Cc:To:From:Date:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=ayROP4MQKiCNpNKT6GTubMn3ATg0Pxrq17ErVXh+buk=; b=JHtANQ1UL5uHlW5ZRQQ1RWhb5l
        VWwp7qajTArQCrjN7yuOSdtWq0CJYECBPhC5LKEN/9voxKMpidJ2kQfoLUH0EwObGcIiSrTpKv+X3
        PrN0KvByWYlstelbhZFoHtNsof65sOnT9kfsxG/lDypPGwbw8Y0bkc/LFLzI/2Unqjxc=;
Received: from p200300ccff0d72001a3da2fffebfd33a.dip0.t-ipconnect.de ([2003:cc:ff0d:7200:1a3d:a2ff:febf:d33a] helo=aktux)
        by mail.andi.de1.cc with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <andreas@kemnade.info>)
        id 1kB09z-0008KM-RV; Wed, 26 Aug 2020 20:28:36 +0200
Date:   Wed, 26 Aug 2020 20:28:34 +0200
From:   Andreas Kemnade <andreas@kemnade.info>
To:     Sebastian Reichel <sebastian.reichel@collabora.com>
Cc:     lee.jones@linaro.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, b.galvani@gmail.com, phh@phh.me,
        letux-kernel@openphoenux.org
Subject: Re: [PATCH 1/2] power: supply: Add support for RN5T618/RC5T619
 charger and fuel gauge
Message-ID: <20200826202834.42b1673f@aktux>
In-Reply-To: <20200826174817.vhus3j4i4t7u7jc4@earth.universe>
References: <20200815165610.10647-1-andreas@kemnade.info>
        <20200815165610.10647-2-andreas@kemnade.info>
        <20200826174817.vhus3j4i4t7u7jc4@earth.universe>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Score: -1.0 (-)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Wed, 26 Aug 2020 19:48:17 +0200
Sebastian Reichel <sebastian.reichel@collabora.com> wrote:

> Hi,
> 
> Driver looks mostly good.
> 
> On Sat, Aug 15, 2020 at 06:56:09PM +0200, Andreas Kemnade wrote:
> > [...]
> > +static int rn5t618_battery_current_now(struct rn5t618_power_info *info,
> > +				       union power_supply_propval *val)
> > +{
> > +	u16 res;
> > +	int ret;
> > +
> > +	ret = rn5t618_battery_read_doublereg(info, RN5T618_CC_AVEREG1, &res);
> > +	if (ret)
> > +		return ret;
> > +
> > +	val->intval = res;
> > +	/* 2's complement */
> > +	if (val->intval & (1 << 13))
> > +		val->intval = val->intval - (1 << 14);
> > +
> > +	/* negate current to be positive when discharging */
> > +	val->intval *= -1000;  
> 
> mh, the sign is not documented (which should be fixed). At least
> sbs-battery does it the other way around (negative current when
> discharging, positive otherwise). Some drivers do not support
> signed current and always report positive values (e.g. ACPI driver).
> 
> What did you use as reference for swapping the sign?
> 
Well, I have searched for documentation, found nothing and used the
bq27xxx driver as reference  which I am used to from the GTA04/GTA02,
so things behave equal. That are the devices where a was most
intensively looking at those values.
I thought that there would be some unwritten rule about that.

Regards,
Andreas
