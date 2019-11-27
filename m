Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D4C6610B467
	for <lists+linux-pm@lfdr.de>; Wed, 27 Nov 2019 18:27:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726593AbfK0R1g (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 27 Nov 2019 12:27:36 -0500
Received: from mail.kernel.org ([198.145.29.99]:53794 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726292AbfK0R1g (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 27 Nov 2019 12:27:36 -0500
Received: from localhost (lfbn-1-10718-76.w90-89.abo.wanadoo.fr [90.89.68.76])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0690E20684;
        Wed, 27 Nov 2019 17:27:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1574875655;
        bh=ByMqMjORvr1UlWAYYDkMyxfvBy+o3EuQgE3OMZXqSEQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=2AIH2IH/uPxLpJz3SDjwC/o0aCYNhuQfHG5cvFiEgalqTLyWXggWEwYIgLXxB+9BM
         A2TIRW1oN8Rag6Xq/2OVFN4vMk/Vuq6zj3BU94NY+NccQpJWbVrb1oza+Q3zTSb7p7
         vgOfKS83SpKTZ10fMN6mdV2l5TZjWsOZL2etF+3Q=
Date:   Wed, 27 Nov 2019 18:27:31 +0100
From:   Maxime Ripard <mripard@kernel.org>
To:     Vasily Khoruzhick <anarsoul@gmail.com>
Cc:     Yangtao Li <tiny.windzz@gmail.com>,
        Zhang Rui <rui.zhang@intel.com>,
        Eduardo Valentin <edubezval@gmail.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Amit Kucheria <amit.kucheria@verdurent.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Chen-Yu Tsai <wens@csie.org>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        =?utf-8?Q?Ond=C5=99ej?= Jirman <megous@megous.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 1/7] thermal: sun8i: add thermal driver for
 H6/H5/H3/A64/A83T/R40
Message-ID: <20191127172731.mwmo3zctn7pi6mmp@gilmour.lan>
References: <20191127052935.1719897-1-anarsoul@gmail.com>
 <20191127052935.1719897-2-anarsoul@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191127052935.1719897-2-anarsoul@gmail.com>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi,

Thanks for sending a new version of this!

On Tue, Nov 26, 2019 at 09:29:29PM -0800, Vasily Khoruzhick wrote:
> From: Yangtao Li <tiny.windzz@gmail.com>
>
> This patch adds the support for allwinner thermal sensor, within
> allwinner SoC. It will register sensors for thermal framework
> and use device tree to bind cooling device.
>
> Signed-off-by: Yangtao Li <tiny.windzz@gmail.com>
> Signed-off-by: Ondrej Jirman <megous@megous.com>
> Signed-off-by: Vasily Khoruzhick <anarsoul@gmail.com>

Acked-by: Maxime Ripard <mripard@kernel.org>

Thanks!
Maxime
