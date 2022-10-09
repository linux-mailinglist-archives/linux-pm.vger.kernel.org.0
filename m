Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C81E5F9582
	for <lists+linux-pm@lfdr.de>; Mon, 10 Oct 2022 02:21:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232340AbiJJAVG (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 9 Oct 2022 20:21:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232370AbiJJAT2 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 9 Oct 2022 20:19:28 -0400
Received: from rere.qmqm.pl (rere.qmqm.pl [91.227.64.183])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31AE320354
        for <linux-pm@vger.kernel.org>; Sun,  9 Oct 2022 16:54:11 -0700 (PDT)
Received: from remote.user (localhost [127.0.0.1])
        by rere.qmqm.pl (Postfix) with ESMTPSA id 4MlyBc28Z5z3S;
        Mon, 10 Oct 2022 00:58:16 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=rere.qmqm.pl; s=1;
        t=1665356297; bh=kC2AfgLqA9evwDOE3HGpb3qZuVBerTid8ESxgAQMAO0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=bytwkhtzKEkR8Uk/qhqIr6FOGeB+8WFDuuHwJGOp6XU0nBK4xq8Hnnyv427/zk7Mb
         IVhwCdBsddZWjcGXs7YPB5EuFtOkG7vO19ziwWntIMK/VnP33dzZossQ3NmH+CcqWI
         i5nmUYfN6zwicxFS9o7Fg8cg89X4QRCFNPp5T4BDH68C4+rwzIti+76Ei6oZ6KX3d2
         zG+SA2TGRFJmicFCK2l/RRBH6B9XqazSAjJvqJP1bDoMc6dbJa1vAtFm5N1adBvrIJ
         AjVCgunZVaJ8mGknv2/TUHbApF0V8TX/zpYKJkiKGP0/cxn9eyLY5nzQdXkLze2qWp
         Gd5yc0gpjWjXg==
X-Virus-Status: Clean
X-Virus-Scanned: clamav-milter 0.103.7 at mail
Date:   Mon, 10 Oct 2022 00:58:14 +0200
From:   =?iso-8859-2?Q?Micha=B3_Miros=B3aw?= <mirq-linux@rere.qmqm.pl>
To:     Marek Vasut <marex@denx.de>
Cc:     linux-pm@vger.kernel.org,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Sebastian Reichel <sebastian.reichel@collabora.com>
Subject: Re: [PATCH 2/2] power: supply: bq25890: Rename
 POWER_SUPPLY_PROP_CURRENT_NOW to CC current
Message-ID: <Y0NSBvkcOOx/3XcR@qmqm.qmqm.pl>
References: <20221009191839.102686-1-marex@denx.de>
 <20221009191839.102686-2-marex@denx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20221009191839.102686-2-marex@denx.de>
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Sun, Oct 09, 2022 at 09:18:39PM +0200, Marek Vasut wrote:
> The POWER_SUPPLY_PROP_CURRENT_NOW property represents, as far as I can tell,
> the immediate power supply input current, however, this driver reports the
> immediate battery charge current using that property, i.e. content of REG12
> ICHGR -- ADC conversion of Charge Current (IBAT). Replace the property with
> POWER_SUPPLY_PROP_CONSTANT_CHARGE_CURRENT, which as far as I can tell should
> be used to report immediate battery charge voltage.
> 
> This also aligns the behavior of POWER_SUPPLY_PROP_CONSTANT_CHARGE_CURRENT
> with POWER_SUPPLY_PROP_CONSTANT_CHARGE_VOLTAGE, as the former reports IBAT
> and the later reports VBAT.

I believe this is wrong: CC_CURRENT would be the constant-current charge phase
current limit (ICHG in REG04).

Documentation/power/power_supply_class.rst mentions that:

CONSTANT_CHARGE_CURRENT
  constant charge current programmed by charger.

and:

Postfixes:
_NOW
  momentary/instantaneous values.

Best Regards
Micha³ Miros³aw
