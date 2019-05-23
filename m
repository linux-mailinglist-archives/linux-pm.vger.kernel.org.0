Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 845EC27DE9
	for <lists+linux-pm@lfdr.de>; Thu, 23 May 2019 15:19:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728309AbfEWNTB (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 23 May 2019 09:19:01 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:36618 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726310AbfEWNTB (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 23 May 2019 09:19:01 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: eballetbo)
        with ESMTPSA id 358BF263ABB
Subject: Re: mainline/master boot bisection: v5.2-rc1-165-g54dee406374c on
 rk3288-veyron-jaq
To:     Mark Brown <broonie@kernel.org>,
        Eduardo Valentin <edubezval@gmail.com>,
        Elaine Zhang <zhangqing@rock-chips.com>
Cc:     tomeu.vizoso@collabora.com, guillaume.tucker@collabora.com,
        mgalka@collabora.com, matthew.hart@linaro.org,
        khilman@baylibre.com, Daniel Lezcano <daniel.lezcano@linaro.org>,
        Heiko Stuebner <heiko@sntech.de>, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-rockchip@lists.infradead.org,
        Zhang Rui <rui.zhang@intel.com>,
        linux-arm-kernel@lists.infradead.org
References: <5ce6040d.1c69fb81.60b3b.29fb@mx.google.com>
 <20190523131207.GC17245@sirena.org.uk>
From:   Enric Balletbo i Serra <enric.balletbo@collabora.com>
Message-ID: <ac2f06ac-2bf5-7af6-06c3-37b865c43738@collabora.com>
Date:   Thu, 23 May 2019 15:18:56 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190523131207.GC17245@sirena.org.uk>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Mark,

On 23/5/19 15:12, Mark Brown wrote:
> On Wed, May 22, 2019 at 07:23:09PM -0700, kernelci.org bot wrote:
> 
>>   Details:    https://kernelci.org/boot/id/5ce5984c59b514e6a47a364c
>>   Plain log:  https://storage.kernelci.org//mainline/master/v5.2-rc1-165-g54dee406374c/arm/multi_v7_defconfig+CONFIG_EFI=y+CONFIG_ARM_LPAE=y/gcc-8/lab-collabora/boot-rk3288-veyron-jaq.txt
>>   HTML log:   https://storage.kernelci.org//mainline/master/v5.2-rc1-165-g54dee406374c/arm/multi_v7_defconfig+CONFIG_EFI=y+CONFIG_ARM_LPAE=y/gcc-8/lab-collabora/boot-rk3288-veyron-jaq.html
>>   Result:     28694e009e51 thermal: rockchip: fix up the tsadc pinctrl setting error
> 
> It looks like this issue has persisted for a while without any kind of
> fix happening - given that the bisection has identified this commit as
> causing the regression and confirmed that reverting it fixes shouldn't
> we just revert?  My guess would be that there's some error with the
> pinctrl settings in the DT for the board.
> 

After some discussion Heiko sent a patch that reverts the offending commit one
day ago [1] and it's waiting for maintainer to pick-up the patch.

The reason why we think is best reverting that fix it is explained here [2]

[1] https://lkml.org/lkml/2019/5/22/467
[2] https://lkml.org/lkml/2019/4/30/270

Thanks,
 Enric
