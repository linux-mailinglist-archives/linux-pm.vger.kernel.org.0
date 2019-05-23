Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 517D927EFB
	for <lists+linux-pm@lfdr.de>; Thu, 23 May 2019 16:02:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730369AbfEWOCO convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-pm@lfdr.de>); Thu, 23 May 2019 10:02:14 -0400
Received: from mga18.intel.com ([134.134.136.126]:43223 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730323AbfEWOCO (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Thu, 23 May 2019 10:02:14 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 23 May 2019 07:02:13 -0700
X-ExtLoop1: 1
Received: from fmsmsx103.amr.corp.intel.com ([10.18.124.201])
  by orsmga008.jf.intel.com with ESMTP; 23 May 2019 07:02:13 -0700
Received: from fmsmsx118.amr.corp.intel.com (10.18.116.18) by
 FMSMSX103.amr.corp.intel.com (10.18.124.201) with Microsoft SMTP Server (TLS)
 id 14.3.408.0; Thu, 23 May 2019 07:02:13 -0700
Received: from shsmsx104.ccr.corp.intel.com (10.239.4.70) by
 fmsmsx118.amr.corp.intel.com (10.18.116.18) with Microsoft SMTP Server (TLS)
 id 14.3.408.0; Thu, 23 May 2019 07:02:12 -0700
Received: from shsmsx108.ccr.corp.intel.com ([169.254.8.126]) by
 SHSMSX104.ccr.corp.intel.com ([169.254.5.33]) with mapi id 14.03.0415.000;
 Thu, 23 May 2019 22:02:11 +0800
From:   "Zhang, Rui" <rui.zhang@intel.com>
To:     Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Mark Brown <broonie@kernel.org>,
        Eduardo Valentin <edubezval@gmail.com>,
        Elaine Zhang <zhangqing@rock-chips.com>
CC:     "tomeu.vizoso@collabora.com" <tomeu.vizoso@collabora.com>,
        "guillaume.tucker@collabora.com" <guillaume.tucker@collabora.com>,
        "mgalka@collabora.com" <mgalka@collabora.com>,
        "matthew.hart@linaro.org" <matthew.hart@linaro.org>,
        "khilman@baylibre.com" <khilman@baylibre.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Heiko Stuebner <heiko@sntech.de>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-rockchip@lists.infradead.org" 
        <linux-rockchip@lists.infradead.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
Subject: RE: mainline/master boot bisection: v5.2-rc1-165-g54dee406374c on
 rk3288-veyron-jaq
Thread-Topic: mainline/master boot bisection: v5.2-rc1-165-g54dee406374c on
 rk3288-veyron-jaq
Thread-Index: AQHVEQ59ng5b65ntw0ypm8xLYzn0kaZ4KgWAgAAB5wCAAJHx8A==
Date:   Thu, 23 May 2019 14:02:11 +0000
Message-ID: <744357E9AAD1214791ACBA4B0B9092637757AD75@SHSMSX108.ccr.corp.intel.com>
References: <5ce6040d.1c69fb81.60b3b.29fb@mx.google.com>
 <20190523131207.GC17245@sirena.org.uk>
 <ac2f06ac-2bf5-7af6-06c3-37b865c43738@collabora.com>
In-Reply-To: <ac2f06ac-2bf5-7af6-06c3-37b865c43738@collabora.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-titus-metadata-40: eyJDYXRlZ29yeUxhYmVscyI6IiIsIk1ldGFkYXRhIjp7Im5zIjoiaHR0cDpcL1wvd3d3LnRpdHVzLmNvbVwvbnNcL0ludGVsMyIsImlkIjoiMWIyNDI1MTEtODVlNy00ZmQzLWFlZWUtYzI3OGQ0ODdiMDBlIiwicHJvcHMiOlt7Im4iOiJDVFBDbGFzc2lmaWNhdGlvbiIsInZhbHMiOlt7InZhbHVlIjoiQ1RQX05UIn1dfV19LCJTdWJqZWN0TGFiZWxzIjpbXSwiVE1DVmVyc2lvbiI6IjE3LjEwLjE4MDQuNDkiLCJUcnVzdGVkTGFiZWxIYXNoIjoibXUyNlNRZ3U4RWtRSEI1Q1ZFdjlOMURGMmlRVnc0M29SemtQREFEb0FGd0NLdDdUSkNEVXNqS2JzcXV4VXhEcCJ9
x-ctpclassification: CTP_NT
dlp-product: dlpe-windows
dlp-version: 11.0.600.7
dlp-reaction: no-action
x-originating-ip: [10.239.127.40]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org



> -----Original Message-----
> From: Enric Balletbo i Serra [mailto:enric.balletbo@collabora.com]
> Sent: Thursday, May 23, 2019 9:19 PM
> To: Mark Brown <broonie@kernel.org>; Eduardo Valentin
> <edubezval@gmail.com>; Elaine Zhang <zhangqing@rock-chips.com>
> Cc: tomeu.vizoso@collabora.com; guillaume.tucker@collabora.com;
> mgalka@collabora.com; matthew.hart@linaro.org; khilman@baylibre.com;
> Daniel Lezcano <daniel.lezcano@linaro.org>; Heiko Stuebner
> <heiko@sntech.de>; linux-pm@vger.kernel.org; linux-
> kernel@vger.kernel.org; linux-rockchip@lists.infradead.org; Zhang, Rui
> <rui.zhang@intel.com>; linux-arm-kernel@lists.infradead.org
> Subject: Re: mainline/master boot bisection: v5.2-rc1-165-g54dee406374c on
> rk3288-veyron-jaq
> Importance: High
> 
> Hi Mark,
> 
> On 23/5/19 15:12, Mark Brown wrote:
> > On Wed, May 22, 2019 at 07:23:09PM -0700, kernelci.org bot wrote:
> >
> >>   Details:    https://kernelci.org/boot/id/5ce5984c59b514e6a47a364c
> >>   Plain log:  https://storage.kernelci.org//mainline/master/v5.2-rc1-165-
> g54dee406374c/arm/multi_v7_defconfig+CONFIG_EFI=y+CONFIG_ARM_LPAE
> =y/gcc-8/lab-collabora/boot-rk3288-veyron-jaq.txt
> >>   HTML log:   https://storage.kernelci.org//mainline/master/v5.2-rc1-165-
> g54dee406374c/arm/multi_v7_defconfig+CONFIG_EFI=y+CONFIG_ARM_LPAE
> =y/gcc-8/lab-collabora/boot-rk3288-veyron-jaq.html
> >>   Result:     28694e009e51 thermal: rockchip: fix up the tsadc pinctrl setting
> error
> >
> > It looks like this issue has persisted for a while without any kind of
> > fix happening - given that the bisection has identified this commit as
> > causing the regression and confirmed that reverting it fixes shouldn't
> > we just revert?  My guess would be that there's some error with the
> > pinctrl settings in the DT for the board.
> >
> 
> After some discussion Heiko sent a patch that reverts the offending commit
> one day ago [1] and it's waiting for maintainer to pick-up the patch.
> 
I thought Eduardo will take the patch.
But I will apply it and queue it for -rc2 anyway.

Thanks,
Rui

> The reason why we think is best reverting that fix it is explained here [2]
> 
> [1] https://lkml.org/lkml/2019/5/22/467
> [2] https://lkml.org/lkml/2019/4/30/270
> 
> Thanks,
>  Enric
