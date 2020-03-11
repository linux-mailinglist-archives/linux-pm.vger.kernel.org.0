Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D0D211813AA
	for <lists+linux-pm@lfdr.de>; Wed, 11 Mar 2020 09:53:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728746AbgCKIr1 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 11 Mar 2020 04:47:27 -0400
Received: from mail.manjaro.org ([176.9.38.148]:33266 "EHLO mail.manjaro.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728705AbgCKIr1 (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 11 Mar 2020 04:47:27 -0400
Received: from localhost (localhost [127.0.0.1])
        by mail.manjaro.org (Postfix) with ESMTP id 226753702434;
        Wed, 11 Mar 2020 09:47:26 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at manjaro.org
Received: from mail.manjaro.org ([127.0.0.1])
        by localhost (manjaro.org [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id FeJ_lXY7nzmt; Wed, 11 Mar 2020 09:47:23 +0100 (CET)
Subject: Re: [PATCH v2 2/2] power: supply: add CellWise cw2015 fuel gauge
 driver
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Tobias Schramm <t.schramm@manjaro.org>
Cc:     Sebastian Reichel <sre@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20200309160346.2203680-1-t.schramm@manjaro.org>
 <20200309160346.2203680-3-t.schramm@manjaro.org>
 <20200310101050.GG1922688@smile.fi.intel.com>
 <eb732216-dd19-f18d-9ace-e14c7e8de991@manjaro.org>
 <20200311081450.GZ1922688@smile.fi.intel.com>
From:   Tobias Schramm <t.schramm@manjaro.org>
Message-ID: <503baadb-b8f2-f4bd-a1a8-44b2dc77b933@manjaro.org>
Date:   Wed, 11 Mar 2020 09:48:30 +0100
MIME-Version: 1.0
In-Reply-To: <20200311081450.GZ1922688@smile.fi.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US-large
Content-Transfer-Encoding: 7bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Andy,

was just about to send v3.

> 
> 	__be16 value;
> 
> 
> 	ret = regmap(..., (...)value, sizeof(value));
> 	if (ret)
> 		return ret; // note, you missed this in above.
> 
> 	*val = be16_to_cpu(value);
> 	return 0;
> 

That implementation looks pretty clean. I'll take it.


Thanks,

Tobias
