Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8C49C2BFE8
	for <lists+linux-pm@lfdr.de>; Tue, 28 May 2019 09:13:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726305AbfE1HNb (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 28 May 2019 03:13:31 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:42212 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726866AbfE1HNb (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 28 May 2019 03:13:31 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: gtucker)
        with ESMTPSA id 318052804FE
Subject: Re: linusw/for-next boot bisection: v5.2-rc1-8-g73a790c68d7e on
 rk3288-veyron-jaq
To:     Elaine Zhang <zhangqing@rock-chips.com>,
        Eduardo Valentin <edubezval@gmail.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Heiko Stuebner <heiko@sntech.de>,
        Linus Walleij <linus.walleij@linaro.org>
Cc:     tomeu.vizoso@collabora.com, mgalka@collabora.com,
        broonie@kernel.org, matthew.hart@linaro.org, khilman@baylibre.com,
        enric.balletbo@collabora.com, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-rockchip@lists.infradead.org,
        Zhang Rui <rui.zhang@intel.com>,
        linux-arm-kernel@lists.infradead.org
References: <5cec74e8.1c69fb81.37335.9d7b@mx.google.com>
From:   Guillaume Tucker <guillaume.tucker@collabora.com>
Message-ID: <0edab48f-06e5-9ed8-09be-7c9976ae1afb@collabora.com>
Date:   Tue, 28 May 2019 08:13:25 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <5cec74e8.1c69fb81.37335.9d7b@mx.google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Linus,

On 28/05/2019 00:38, kernelci.org bot wrote:
> * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
> * This automated bisection report was sent to you on the basis  *
> * that you may be involved with the breaking commit it has      *
> * found.  No manual investigation has been done to verify it,   *
> * and the root cause of the problem may be somewhere else.      *
> * Hope this helps!                                              *
> * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
> 
> linusw/for-next boot bisection: v5.2-rc1-8-g73a790c68d7e on rk3288-veyron-jaq
> 
> Summary:
>   Start:      73a790c68d7e Merge branch 'devel' into for-next
>   Details:    https://kernelci.org/boot/id/5cebf03d59b514dd627a3629
>   Plain log:  https://storage.kernelci.org//linusw/for-next/v5.2-rc1-8-g73a790c68d7e/arm/multi_v7_defconfig/gcc-8/lab-collabora/boot-rk3288-veyron-jaq.txt
>   HTML log:   https://storage.kernelci.org//linusw/for-next/v5.2-rc1-8-g73a790c68d7e/arm/multi_v7_defconfig/gcc-8/lab-collabora/boot-rk3288-veyron-jaq.html
>   Result:     28694e009e51 thermal: rockchip: fix up the tsadc pinctrl setting error
> 
> Checks:
>   revert:     PASS
>   verify:     PASS
> 
> Parameters:
>   Tree:       linusw
>   URL:        https://git.kernel.org/pub/scm/linux/kernel/git/linusw/linux-gpio.git/
>   Branch:     for-next
>   Target:     rk3288-veyron-jaq
>   CPU arch:   arm
>   Lab:        lab-collabora
>   Compiler:   gcc-8
>   Config:     multi_v7_defconfig
>   Test suite: boot
> 
> Breaking commit found:
> 
> -------------------------------------------------------------------------------
> commit 28694e009e512451ead5519dd801f9869acb1f60
> Author: Elaine Zhang <zhangqing@rock-chips.com>
> Date:   Tue Apr 30 18:09:44 2019 +0800
> 
>     thermal: rockchip: fix up the tsadc pinctrl setting error

This commit has now been reverted in mainline.  Would it be OK
for you to rebase your for-next branch on v5.2-rc2 or cherry-pick
the revert to avoid recurring bisections?

Ideally this should have been fixed or reverted in mainline
before v5.2-rc1 was released, or even earlier when this was first
found in -next on 13th May.  Unfortunately it was overlooked and
then spread to other branches like yours.

Thanks,
Guillaume
