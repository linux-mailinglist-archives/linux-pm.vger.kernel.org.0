Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AD9EB3ADA76
	for <lists+linux-pm@lfdr.de>; Sat, 19 Jun 2021 16:41:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234524AbhFSOnM (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sat, 19 Jun 2021 10:43:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233240AbhFSOnL (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sat, 19 Jun 2021 10:43:11 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5B62C061574;
        Sat, 19 Jun 2021 07:41:00 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: ezequiel)
        with ESMTPSA id F40911F44054
Message-ID: <196b01a730d236a6eda99b42f18939692bc7ffcc.camel@collabora.com>
Subject: Re: [PATCH v2 3/4] dt-bindings: rockchip-thermal: Support the
 RK3568 SoC compatible
From:   Ezequiel Garcia <ezequiel@collabora.com>
To:     Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        kernel@collabora.com, linux-pm@vger.kernel.org,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Kever Yang <kever.yang@rock-chips.com>,
        Heiko Stuebner <heiko@sntech.de>,
        Finley Xiao <finley.xiao@rock-chips.com>,
        linux-rockchip@lists.infradead.org
Date:   Sat, 19 Jun 2021 11:40:47 -0300
In-Reply-To: <20210506214452.GA853809@robh.at.kernel.org>
References: <20210506175514.168365-1-ezequiel@collabora.com>
         <20210506175514.168365-4-ezequiel@collabora.com>
         <20210506214452.GA853809@robh.at.kernel.org>
Organization: Collabora
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.38.2-1 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Daniel,

On Thu, 2021-05-06 at 16:44 -0500, Rob Herring wrote:
> On Thu, 06 May 2021 14:55:13 -0300, Ezequiel Garcia wrote:
> > Add a new compatible for the thermal sensor device on RK3568 SoCs.
> > 
> > Signed-off-by: Ezequiel Garcia <ezequiel@collabora.com>
> > ---
> >  Documentation/devicetree/bindings/thermal/rockchip-thermal.yaml | 1 +
> >  1 file changed, 1 insertion(+)
> > 
> 
> Acked-by: Rob Herring <robh@kernel.org>
	
Gentle ping for 3/4 and 4/4 in this series.

Thanks,
Ezequiel

