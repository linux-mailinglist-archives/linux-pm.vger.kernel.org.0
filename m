Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 391694250D3
	for <lists+linux-pm@lfdr.de>; Thu,  7 Oct 2021 12:16:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238605AbhJGKS1 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 7 Oct 2021 06:18:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231825AbhJGKSZ (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 7 Oct 2021 06:18:25 -0400
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7B6CC061746;
        Thu,  7 Oct 2021 03:16:31 -0700 (PDT)
Received: by mail-wr1-x42d.google.com with SMTP id o20so17426625wro.3;
        Thu, 07 Oct 2021 03:16:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=1gYAE2vWPz0MbraCtd8aQQgWxPLZqacAtSV7iYxbEtQ=;
        b=EbdSYwqx3mHUc7kNlSYIJXdd6OTrPllHE9Wd8JhKhMNbu0hEFfGYAtI3UQ+Pa8yoxe
         KC6ZA+SRfrhiNSnvdR1W5txmyvjKgQvkbk1BLqqkTs+K//aTJl1BC53AzkNZPhHbj4Cj
         VWgCh+lDEedu1+BOMFt+UONsQg1FM8vjKTnvIKmXXQWDTgoWbkxMB4jvRxpk6o171WAf
         7yV0zS2NI9Dh92/WE2viXUmxxoDadKN91gTfU54gtNyqhDdPq0E8yiM+a0umZ7edr7Md
         lYfQC/RDsM6EOXB2s2fEJXkO/JIdRMVGLNaSrQs4xC7/Oq7vpju5VBSAX8hs1jbHr6pe
         U5RQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=1gYAE2vWPz0MbraCtd8aQQgWxPLZqacAtSV7iYxbEtQ=;
        b=T+VK2jwhupWP+dMbLbqheIhPfbQsLwnpuBVxFwM2NacZssS8HqnwbVorUGV04pO0YW
         pTD2CQT4P8ydUb6pOkT6tHNdSYn+cb6dIV4eRxghK74u9wxIo/cgBRz8hK7ZYGrkqSIh
         c24NNbS0ZGYWHGQqJJ63mHhGKN0OXUwQjPPWA48YkI/UO44TiudNpd1JE3dN1Vcj/zuG
         Z9RAyKNsK8nPdmHfH8m7hVI97qPgE56BTNzt5/VRNhT2J8Nd6UXf08F6h9Bu2ugkFvii
         aq4sCMfBYhJFyyRPG9K6wpWaLvBnBRr5H0DyULnNjCNsEigEgugmX9tgmNOXvmbStFyq
         ic5w==
X-Gm-Message-State: AOAM532xBQBmXGTNB+Mb/TvVV4n1288b4mWSQOjToKHpmELC9n6OZpgk
        3M+NbSV8z7zkjolsuCooxJo=
X-Google-Smtp-Source: ABdhPJyO84sEJgEs46P+YCpyCH8r2D08a2F9o/3ytykleY8cSd00FUEVVOpPAaOOAp7N04KX5vUOtQ==
X-Received: by 2002:a1c:f302:: with SMTP id q2mr3697177wmq.56.1633601790274;
        Thu, 07 Oct 2021 03:16:30 -0700 (PDT)
Received: from [192.168.0.14] (095160158079.dynamic-2-waw-k-4-2-0.vectranet.pl. [95.160.158.79])
        by smtp.gmail.com with ESMTPSA id e8sm9576415wrg.48.2021.10.07.03.16.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 07 Oct 2021 03:16:29 -0700 (PDT)
Subject: Re: [PATCH v2 00/34] component: Make into an aggregate bus
To:     Stephen Boyd <swboyd@chromium.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
        Arnd Bergmann <arnd@arndb.de>,
        Benjamin Gaignard <benjamin.gaignard@linaro.org>,
        Chen Feng <puck.chen@hisilicon.com>,
        Chen-Yu Tsai <wens@csie.org>,
        Christian Gmeiner <christian.gmeiner@gmail.com>,
        Chun-Kuang Hu <chunkuang.hu@kernel.org>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Emma Anholt <emma@anholt.net>,
        =?UTF-8?Q?Heiko_St=c3=bcbner?= <heiko@sntech.de>,
        Inki Dae <inki.dae@samsung.com>,
        James Qian Wang <james.qian.wang@arm.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Joerg Roedel <joro@8bytes.org>,
        John Stultz <john.stultz@linaro.org>,
        Joonyoung Shim <jy0922.shim@samsung.com>,
        Jyri Sarha <jyri.sarha@iki.fi>,
        Kai Vehmanen <kai.vehmanen@linux.intel.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        linux-fbdev@vger.kernel.org, linux-omap@vger.kernel.org,
        linux-pm@vger.kernel.org, Liviu Dudau <liviu.dudau@arm.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        Mark Brown <broonie@kernel.org>,
        Maxime Ripard <mripard@kernel.org>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Paul Cercueil <paul@crapouillou.net>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Rob Clark <robdclark@gmail.com>,
        Russell King <linux@armlinux.org.uk>,
        Russell King <linux+etnaviv@armlinux.org.uk>,
        Russell King <rmk+kernel@arm.linux.org.uk>,
        Sandy Huang <hjc@rock-chips.com>,
        Saravana Kannan <saravanak@google.com>,
        Sebastian Reichel <sre@kernel.org>,
        Seung-Woo Kim <sw0312.kim@samsung.com>,
        Takashi Iwai <tiwai@suse.com>,
        Tian Tao <tiantao6@hisilicon.com>,
        Tomas Winkler <tomas.winkler@intel.com>,
        Tomi Valkeinen <tomba@kernel.org>,
        Will Deacon <will@kernel.org>,
        Xinliang Liu <xinliang.liu@linaro.org>,
        Xinwei Kong <kong.kongxinwei@hisilicon.com>,
        Yong Wu <yong.wu@mediatek.com>
References: <20211006193819.2654854-1-swboyd@chromium.org>
From:   Andrzej Hajda <andrzej.hajda@gmail.com>
Message-ID: <5d3f4343-da38-04b4-fdb9-cb2dd4983db2@gmail.com>
Date:   Thu, 7 Oct 2021 12:16:27 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20211006193819.2654854-1-swboyd@chromium.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Stephen,

On 06.10.2021 21:37, Stephen Boyd wrote:
> This series is from discussion we had on reordering the device lists for
> drm shutdown paths[1]. I've introduced an 'aggregate' bus that we put
> the aggregate device onto and then we probe the aggregate device once
> all the components are probed and call component_add(). The probe/remove
> hooks are where the bind/unbind calls go, and then a shutdown hook is
> added that can be used to shutdown the drm display pipeline at the right
> time.
> 
> This works for me on my sc7180 board. I no longer get a warning from i2c
> at shutdown that we're trying to make an i2c transaction after the i2c
> bus has been shutdown. There's more work to do on the msm drm driver to
> extract component device resources like clks, regulators, etc. out of
> the component bind function into the driver probe but I wanted to move
> everything over now in other component drivers before tackling that
> problem.


As I understand you have DSI host with i2c-controlled DSI bridge. And 
there is an issue that bridge is shutdown before msmdrm. Your solution 
is to 'adjust' device order on pm list.
I had similar issue and solved it locally by adding notification from 
DSI bridge to DSI host that is has to be removed: mipi_dsi_detach, this 
notification escalates in DSI host to component_del and this allow to 
react properly.

Advantages:
- it is local (only involves DSI host and DSI device),
- it does not depend on PM internals,
- it can be used in other scenarios as well - unbinding DSI device driver

Disadvantage:
- It is DSI specific (but this is your case), I have advertised some 
time ago more general approach [1][2].

[1]: https://static.sched.com/hosted_files/osseu18/0f/deferred_problem.pdf
[2]: https://lwn.net/Articles/625454/


Regards
Andrzej
