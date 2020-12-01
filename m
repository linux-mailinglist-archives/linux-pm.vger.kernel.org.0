Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0F2F62CA497
	for <lists+linux-pm@lfdr.de>; Tue,  1 Dec 2020 14:59:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388251AbgLANz6 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 1 Dec 2020 08:55:58 -0500
Received: from honk.sigxcpu.org ([24.134.29.49]:46130 "EHLO honk.sigxcpu.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388223AbgLANz6 (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Tue, 1 Dec 2020 08:55:58 -0500
X-Greylist: delayed 515 seconds by postgrey-1.27 at vger.kernel.org; Tue, 01 Dec 2020 08:55:58 EST
Received: from localhost (localhost [127.0.0.1])
        by honk.sigxcpu.org (Postfix) with ESMTP id 87F2AFB03;
        Tue,  1 Dec 2020 14:46:39 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at honk.sigxcpu.org
Received: from honk.sigxcpu.org ([127.0.0.1])
        by localhost (honk.sigxcpu.org [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id X1ChpxCqEnvi; Tue,  1 Dec 2020 14:46:38 +0100 (CET)
Received: by bogon.sigxcpu.org (Postfix, from userid 1000)
        id 33DF04068E; Tue,  1 Dec 2020 14:46:38 +0100 (CET)
Date:   Tue, 1 Dec 2020 14:46:38 +0100
From:   Guido =?iso-8859-1?Q?G=FCnther?= <guido.gunther@puri.sm>
To:     Martin Kepplinger <martin.kepplinger@puri.sm>
Cc:     robh@kernel.org, shawnguo@kernel.org, festevam@gmail.com,
        catalin.marinas@arm.com, will@kernel.org, georgi.djakov@linaro.org,
        cdleonard@gmail.com, kernel@pengutronix.de, linux-imx@nxp.com,
        kernel@puri.sm, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Subject: Re: [PATCH v2 4/7] dt-bindings: mxsfb: Add interconnect bindings for
 LCDIF path
Message-ID: <20201201134638.GA305734@bogon.m.sigxcpu.org>
References: <20201201123932.12312-1-martin.kepplinger@puri.sm>
 <20201201123932.12312-5-martin.kepplinger@puri.sm>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201201123932.12312-5-martin.kepplinger@puri.sm>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Martin,
On Tue, Dec 01, 2020 at 01:39:29PM +0100, Martin Kepplinger wrote:
> Add optional interconnect properties for the dram path requests.
> 
> Signed-off-by: Martin Kepplinger <martin.kepplinger@puri.sm>
> ---
>  Documentation/devicetree/bindings/display/mxsfb.txt | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/display/mxsfb.txt b/Documentation/devicetree/bindings/display/mxsfb.txt
> index c985871c46b3..d494a2674290 100644
> --- a/Documentation/devicetree/bindings/display/mxsfb.txt
> +++ b/Documentation/devicetree/bindings/display/mxsfb.txt
> @@ -15,6 +15,12 @@ Required properties:
>      - "pix" for the LCDIF block clock
>      - (MX6SX-only) "axi", "disp_axi" for the bus interface clock
>  
> +Optional properties:
> +- interconnects : interconnect path specifier for LCDIF according to
> +		Documentation/devicetree/bindings/interconnect/interconnect.txt.
> +- interconnect-names: the name describing the interconnect path.
> +		Should be "dram" for i.MX8MQ.
> +

There's a yaml conversion by Laurentiu for mxsfb in flight:

    https://lore.kernel.org/dri-devel/20201007012438.27970-2-laurent.pinchart@ideasonboard.com/

Cheers,
 -- Guido

>  Required sub-nodes:
>    - port: The connection to an encoder chip.
>  
> -- 
> 2.20.1
> 
