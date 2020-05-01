Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0305B1C1382
	for <lists+linux-pm@lfdr.de>; Fri,  1 May 2020 15:33:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729890AbgEANaO (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 1 May 2020 09:30:14 -0400
Received: from rere.qmqm.pl ([91.227.64.183]:9192 "EHLO rere.qmqm.pl"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729897AbgEANaN (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Fri, 1 May 2020 09:30:13 -0400
Received: from remote.user (localhost [127.0.0.1])
        by rere.qmqm.pl (Postfix) with ESMTPSA id 49DCmL4hYwz7N;
        Fri,  1 May 2020 15:30:10 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=rere.qmqm.pl; s=1;
        t=1588339811; bh=df1zMSo857OmD6bMwuGX0U3QsXa2EYWws/vLhmRKD5I=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=HVR74c+TgNmjXzHbHgAf8zUizG6qUVh2yQtlEpfUuorGlirN04XEI/Xkt+C3HFnUU
         08uYs/Ld7bZdjV5O84mbKhVCZp4zzKNBCo0qhqVplbXhl5IetrUc5uY8oasWazxWTE
         usDHiLz3W49Xmu0+oHXX2eNCy6xAJih94CiSy5sUg7jZQuMPrqRGW6MgEvM1UeWLts
         zue5D0xdSWakcXYlGEgkaDuT4CDWZ/UEC+QDDAjY1lxeVtLGkuELiOLYGwUS0PWBzR
         WKXVx+1IAVix88Mck3SlhyMeSYlmxnZ/NaFHIcMczrZ4Lt/jjOpuS6MEWwfuN58m9c
         YBFkWWhuSrT5Q==
X-Virus-Status: Clean
X-Virus-Scanned: clamav-milter 0.102.2 at mail
Date:   Fri, 1 May 2020 15:30:08 +0200
From:   =?iso-8859-2?Q?Micha=B3_Miros=B3aw?= <mirq-linux@rere.qmqm.pl>
To:     Sebastian Reichel <sebastian.reichel@collabora.com>
Cc:     Andrey Smirnov <andrew.smirnov@gmail.com>,
        Guenter Roeck <linux@roeck-us.net>,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Subject: Re: [PATCH v3 02/11] power: charger-manager: don't write through
 desc->properties
Message-ID: <20200501133008.GA8927@qmqm.qmqm.pl>
References: <cover.1585944770.git.mirq-linux@rere.qmqm.pl>
 <a529e64edb81a4795fe0b6480f1e4051bed1b099.1585944770.git.mirq-linux@rere.qmqm.pl>
 <20200501123849.ws2a5ybeeej6phyr@earth.universe>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200501123849.ws2a5ybeeej6phyr@earth.universe>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Fri, May 01, 2020 at 02:38:49PM +0200, Sebastian Reichel wrote:
> Hi,
> 
> On Fri, Apr 03, 2020 at 10:20:31PM +0200, Micha³ Miros³aw wrote:
> > psy_desc->properties will become pointer to const.  Avoid writing
> > through the pointer to enable constification of the tables elsewhere.
> > 
> > Signed-off-by: Micha³ Miros³aw <mirq-linux@rere.qmqm.pl>
> For patches 1-3 I used my version, that I wrote in parallel while
> reviewing a different patch series. It is slightly different, but
> achieves the same goal.

There is a bug in the tree now regarding use of num_properties
in charger-manager.  Following patch should fix it.

Best Regards,
Micha³ Miros³aw

diff --git a/drivers/power/supply/charger-manager.c b/drivers/power/supply/charger-manager.c
index a71e2ee81423..2ef53dc1f2fb 100644
--- a/drivers/power/supply/charger-manager.c
+++ b/drivers/power/supply/charger-manager.c
@@ -1740,14 +1740,14 @@ static int charger_manager_probe(struct platform_device *pdev)
 	}
 	if (!power_supply_get_property(fuel_gauge,
 					  POWER_SUPPLY_PROP_CHARGE_NOW, &val)) {
-		properties[cm->charger_psy_desc.num_properties] =
+		properties[num_properties] =
 				POWER_SUPPLY_PROP_CHARGE_NOW;
 		num_properties++;
 	}
 	if (!power_supply_get_property(fuel_gauge,
 					  POWER_SUPPLY_PROP_CURRENT_NOW,
 					  &val)) {
-		properties[cm->charger_psy_desc.num_properties] =
+		properties[num_properties] =
 				POWER_SUPPLY_PROP_CURRENT_NOW;
 		num_properties++;
 	}
