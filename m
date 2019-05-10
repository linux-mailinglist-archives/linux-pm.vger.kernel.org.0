Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 772D819BCB
	for <lists+linux-pm@lfdr.de>; Fri, 10 May 2019 12:42:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727408AbfEJKmo (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 10 May 2019 06:42:44 -0400
Received: from smtp1.de.adit-jv.com ([93.241.18.167]:52318 "EHLO
        smtp1.de.adit-jv.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727251AbfEJKmo (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 10 May 2019 06:42:44 -0400
Received: from localhost (smtp1.de.adit-jv.com [127.0.0.1])
        by smtp1.de.adit-jv.com (Postfix) with ESMTP id 8ED9C3C00C6;
        Fri, 10 May 2019 12:42:41 +0200 (CEST)
Received: from smtp1.de.adit-jv.com ([127.0.0.1])
        by localhost (smtp1.de.adit-jv.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id Qk2pjdyBt0nv; Fri, 10 May 2019 12:42:34 +0200 (CEST)
Received: from HI2EXCH01.adit-jv.com (hi2exch01.adit-jv.com [10.72.92.24])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
        (No client certificate requested)
        by smtp1.de.adit-jv.com (Postfix) with ESMTPS id A472C3C004C;
        Fri, 10 May 2019 12:42:34 +0200 (CEST)
Received: from vmlxhi-102.adit-jv.com (10.72.93.184) by HI2EXCH01.adit-jv.com
 (10.72.92.24) with Microsoft SMTP Server (TLS) id 14.3.439.0; Fri, 10 May
 2019 12:42:34 +0200
Date:   Fri, 10 May 2019 12:42:31 +0200
From:   Eugeniu Rosca <erosca@de.adit-jv.com>
To:     Niklas =?utf-8?Q?S=C3=B6derlund?= <niklas.soderlund@ragnatech.se>
CC:     Jiada Wang <jiada_wang@mentor.com>, <rui.zhang@intel.com>,
        <edubezval@gmail.com>, <daniel.lezcano@linaro.org>,
        <linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <horms+renesas@verge.net.au>, <geert+renesas@glider.be>,
        <sergei.shtylyov@cogentembedded.com>,
        <marek.vasut+renesas@gmail.com>,
        <kuninori.morimoto.gx@renesas.com>, <hien.dang.eb@renesas.com>,
        <fabrizio.castro@bp.renesas.com>, <dien.pham.ry@renesas.com>,
        <biju.das@bp.renesas.com>, <george_davis@mentor.com>,
        <joshua_frkuska@mentor.com>, Eugeniu Rosca <erosca@de.adit-jv.com>,
        Eugeniu Rosca <roscaeugeniu@gmail.com>
Subject: Re: [PATCH v4 0/2] thermal: rcar_gen3_thermal: fix IRQ issues
Message-ID: <20190510104231.GA15836@vmlxhi-102.adit-jv.com>
References: <20190424051145.23072-1-jiada_wang@mentor.com>
 <20190507235403.GA24112@bigcity.dyn.berto.se>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190507235403.GA24112@bigcity.dyn.berto.se>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Originating-IP: [10.72.93.184]
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Niklas,

On Wed, May 08, 2019 at 01:54:03AM +0200, Niklas Söderlund wrote:
> Hi Jiada,
[..]
> I really like this series, nice work.
> 
> Tested-by: Niklas Söderlund <niklas.soderlund+renesas@ragnatech.se>
> Reviewed-by: Niklas Söderlund <niklas.soderlund+renesas@ragnatech.se>

Is there anything off-the-shelf available for testing the rcar3
thermal driver, to avoid reinventing the wheel via
https://patchwork.kernel.org/cover/10913163/#22602335

Thank you.

-- 
Best Regards,
Eugeniu.
