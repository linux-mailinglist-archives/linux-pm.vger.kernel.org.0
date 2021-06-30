Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 407D13B849E
	for <lists+linux-pm@lfdr.de>; Wed, 30 Jun 2021 16:03:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234935AbhF3OFn (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 30 Jun 2021 10:05:43 -0400
Received: from mail.kernel.org ([198.145.29.99]:43476 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236572AbhF3OE6 (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 30 Jun 2021 10:04:58 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 33BB561433;
        Wed, 30 Jun 2021 14:02:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1625061749;
        bh=2VTAthiOxx7m8GI/drDYhPA/JsJS45hlRGyfodRHa6s=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=eVyb6dS5v0WOH9NG9ZUTZhP4ScHwcVZN0TgyP3fOzZADrpzet3BcA4sw7XpXc8GJL
         j8YaxkmW6NAvsGY+zPtvhg+g+19IYrMrgy34XA0+l/oYUDsXDgrksgWTQVm7ftePcT
         X4CVWCwo1fpcuLXeubVYD16DXuDNdAD6uvCDy/c9a3fvxUSSGvRmHdEilQPbtj+r/d
         3ynXxpG39bzEw1RfDXu72E833p22ecJR76Ih7IxwQfXv2tRaDpa0fz3u6JanKVpOjc
         +QEVOi+gI0aPxkn1UrhTVGuyQHel9SauKyf7wPHR91XD8BhaU7oc3EmyL/yn3Dp3XL
         /htaEgeRiyoBQ==
Date:   Wed, 30 Jun 2021 16:02:23 +0200
From:   Marek =?UTF-8?B?QmVow7pu?= <kabel@kernel.org>
To:     Viresh Kumar <viresh.kumar@linaro.org>,
        Gregory CLEMENT <gregory.clement@bootlin.com>
Cc:     Robert Marko <robert.marko@sartura.hr>,
        Pali =?UTF-8?B?Um9ow6Fy?= <pali@kernel.org>,
        Tomasz Maciej Nowak <tmn505@gmail.com>,
        Anders Trier Olesen <anders.trier.olesen@gmail.com>,
        Philip Soares <philips@netisense.com>,
        linux-pm@vger.kernel.org,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        linux-arm-kernel@lists.infradead.org,
        Konstantin Porotchkin <kostap@marvell.com>,
        nnet <nnet@fastmail.fm>, Nadav Haklai <nadavh@marvell.com>
Subject: Re: [PATCH] cpufreq: armada-37xx: forbid cpufreq for 1.2 GHz
 variant
Message-ID: <20210630160223.285a505f@dellmb>
In-Reply-To: <20210630135942.29730-1-kabel@kernel.org>
References: <20210630135942.29730-1-kabel@kernel.org>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Wed, 30 Jun 2021 15:59:42 +0200
Marek Beh=C3=BAn <kabel@kernel.org> wrote:

> Signed-off-by: Marek Beh=C3=BAn <kabel@kernel.iorg>

OMG, this should be

Signed-off-by: Marek Beh=C3=BAn <kabel@kernel.org>

Marek
