Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0D9843ADA77
	for <lists+linux-pm@lfdr.de>; Sat, 19 Jun 2021 16:42:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234275AbhFSOoc (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sat, 19 Jun 2021 10:44:32 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:56110 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233240AbhFSOob (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sat, 19 Jun 2021 10:44:31 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: ezequiel)
        with ESMTPSA id EA0FD1F43FFD
Message-ID: <4c178505a73b47d08c17915aa43b5f4239a8c30c.camel@collabora.com>
Subject: Re: [PATCH v2 3/4] dt-bindings: rockchip-thermal: Support the
 RK3568 SoC compatible
From:   Ezequiel Garcia <ezequiel@collabora.com>
To:     Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        kernel@collabora.com, linux-pm@vger.kernel.org,
        Zhang Rui <rui.zhang@intel.com>,
        Kever Yang <kever.yang@rock-chips.com>,
        Heiko Stuebner <heiko@sntech.de>,
        Finley Xiao <finley.xiao@rock-chips.com>,
        linux-rockchip@lists.infradead.org
Date:   Sat, 19 Jun 2021 11:42:09 -0300
In-Reply-To: <196b01a730d236a6eda99b42f18939692bc7ffcc.camel@collabora.com>
References: <20210506175514.168365-1-ezequiel@collabora.com>
         <20210506175514.168365-4-ezequiel@collabora.com>
         <20210506214452.GA853809@robh.at.kernel.org>
         <196b01a730d236a6eda99b42f18939692bc7ffcc.camel@collabora.com>
Organization: Collabora
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.38.2-1 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Sat, 2021-06-19 at 11:40 -0300, Ezequiel Garcia wrote:
> Hi Daniel,
> 
> On Thu, 2021-05-06 at 16:44 -0500, Rob Herring wrote:
> > On Thu, 06 May 2021 14:55:13 -0300, Ezequiel Garcia wrote:
> > > Add a new compatible for the thermal sensor device on RK3568 SoCs.
> > > 
> > > Signed-off-by: Ezequiel Garcia <ezequiel@collabora.com>
> > > ---
> > >  Documentation/devicetree/bindings/thermal/rockchip-thermal.yaml | 1 +
> > >  1 file changed, 1 insertion(+)
> > > 
> > 
> > Acked-by: Rob Herring <robh@kernel.org>
>         
> Gentle ping for 3/4 and 4/4 in this series.
> 

Actually, it's patches 2/4, 3/4 and 4/4.

Thanks!
Ezequiel

