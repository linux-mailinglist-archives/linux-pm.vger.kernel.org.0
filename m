Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A8E0A21EA31
	for <lists+linux-pm@lfdr.de>; Tue, 14 Jul 2020 09:37:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725780AbgGNHhN (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 14 Jul 2020 03:37:13 -0400
Received: from mail.kernel.org ([198.145.29.99]:37996 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725601AbgGNHhN (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Tue, 14 Jul 2020 03:37:13 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0C8122084C;
        Tue, 14 Jul 2020 07:37:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1594712232;
        bh=40U6VTXe/lr6IqsUj4uyhrm9QvKozidHXSzQ9Zqf+jo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=f/FYDnjUC84jxEf2D4SCbed8LMHWZuCqvzYjhvq+wkItyXvbngmhjmVg69RK9laqt
         80scyy3fZWGgU0YOmwN5xs+oz4kxKLX2/Oc0Eb5nWJL5U/TgfjZVV2hvjm3Lt+ZK3F
         zwnpj6uq+s8Y5Afc6GgXETqgCOLV0orSHDh8u8lA=
Date:   Tue, 14 Jul 2020 09:37:11 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     ivan <yanziily@gmail.com>
Cc:     sre@kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, jiangfei1@xiaomi.com,
        Qiwu Huang <huangqiwu@xiaomi.com>
Subject: Re: [PATCH v2 1/5] power: supply: core: add quick charge type
 property
Message-ID: <20200714073711.GA689066@kroah.com>
References: <cover.1594612572.git.huangqiwu@xiaomi.com>
 <38b7b1dc10cf608faceae923374791a52a450919.1594612572.git.huangqiwu@xiaomi.com>
 <20200713084113.GC215949@kroah.com>
 <CAPtXDt2ALhYRTTn7m6Jb3k+339VC84YUDC7V=Yb7-a+DpvuVtg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPtXDt2ALhYRTTn7m6Jb3k+339VC84YUDC7V=Yb7-a+DpvuVtg@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

A: http://en.wikipedia.org/wiki/Top_post
Q: Were do I find info about this thing called top-posting?
A: Because it messes up the order in which people normally read text.
Q: Why is top-posting such a bad thing?
A: Top-posting.
Q: What is the most annoying thing in e-mail?

A: No.
Q: Should I include quotations after my reply?

http://daringfireball.net/2007/07/on_top

On Tue, Jul 14, 2020 at 03:31:52PM +0800, ivan wrote:
> I think we should add an enumederated for this

What is "this"?

> 
> for example
> 
> abi document
> 
> What: /sys/class/power_supply/<supply_name>/quick_charge_type
> Date: Jul 2020
> Contact: Fei Jiang <jiangfei1@xiaomi.com>
> Description:
> Reports the kind of quick charge type based on different adapter power.
> Different quick charge type represent different charging power.
> QUICK_CHARGE_NORMAL : Charging Power <= 10W
> QUICK_CHARGE_FAST : 10W < Charging Power <= 20W
> QUICK_CHARGE_FLASH : 20W < Charging Power <= 30W
> QUICK_CHARGE_TURBE : 30W < Charging Power <= 50W
> QUICK_CHARGE_SUPER : Charging Power > 50W
> 
> Access: Read-Only
> Valid values:
> 0: QUICK_CHARGE_NORMAL,
> 1: QUICK_CHARGE_FAST,
> 2: QUICK_CHARGE_FLASH,
> 3: QUICK_CHARGE_TURBE,
> 4: QUICK_CHARGE_SUPER.
> 
> 
> power_supply.h
> 
> enum power_supply_quick_charge_type {
> QUICK_CHARGE_NORMAL = 0,
> QUICK_CHARGE_FAST,
> QUICK_CHARGE_FLASH,
> QUICK_CHARGE_TURBE,
> QUICK_CHARGE_SUPER,
> QUICK_CHARGE_MAX,
> };

That seems like a good change, why not do this?  :)

thanks,

greg k-h
