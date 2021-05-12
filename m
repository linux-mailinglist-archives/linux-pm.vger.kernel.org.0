Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5BBAD37B7CE
	for <lists+linux-pm@lfdr.de>; Wed, 12 May 2021 10:23:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230213AbhELIYn (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 12 May 2021 04:24:43 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:52726 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229968AbhELIYn (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 12 May 2021 04:24:43 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: sre)
        with ESMTPSA id ACE381F425F6
Received: by earth.universe (Postfix, from userid 1000)
        id 77A653C0C95; Wed, 12 May 2021 10:23:30 +0200 (CEST)
Date:   Wed, 12 May 2021 10:23:30 +0200
From:   Sebastian Reichel <sebastian.reichel@collabora.com>
To:     satya priya <skakit@codeaurora.org>
Cc:     Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        David Collins <collinsd@codeaurora.org>, kgunda@codeaurora.org,
        linux-input@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, Vinod Koul <vkoul@kernel.org>,
        Andy Yan <andy.yan@rock-chips.com>
Subject: Re: [PATCH V4 3/5] dt-bindings: power: reset: Change
 'additionalProperties' to true
Message-ID: <20210512082330.shbrs2mcfdl2ybdb@earth.universe>
References: <1620800053-26405-1-git-send-email-skakit@codeaurora.org>
 <1620800053-26405-4-git-send-email-skakit@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1620800053-26405-4-git-send-email-skakit@codeaurora.org>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi,

On Wed, May 12, 2021 at 11:44:11AM +0530, satya priya wrote:
> Change 'additionalProperties' to true as this is a generic binding.
> 
> Signed-off-by: satya priya <skakit@codeaurora.org>
> Acked-by: Rob Herring <robh@kernel.org>
> ---

Reviewed-by: Sebastian Reichel <sebastian.reichel@collabora.com>

-- Sebastian

> Changes in V3:
>  - This is newly added in V3.
> 
> Changes in V4:
>  - No Changes.
> 
>  Documentation/devicetree/bindings/power/reset/reboot-mode.yaml | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/Documentation/devicetree/bindings/power/reset/reboot-mode.yaml b/Documentation/devicetree/bindings/power/reset/reboot-mode.yaml
> index 9c6fda6..ad0a0b9 100644
> --- a/Documentation/devicetree/bindings/power/reset/reboot-mode.yaml
> +++ b/Documentation/devicetree/bindings/power/reset/reboot-mode.yaml
> @@ -36,7 +36,7 @@ patternProperties:
>    "^mode-.*$":
>      $ref: /schemas/types.yaml#/definitions/uint32
>  
> -additionalProperties: false
> +additionalProperties: true
>  
>  examples:
>    - |
> -- 
> QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member 
> of Code Aurora Forum, hosted by The Linux Foundation
> 
