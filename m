Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 03F455B16E7
	for <lists+linux-pm@lfdr.de>; Thu,  8 Sep 2022 10:26:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231594AbiIHI0B (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 8 Sep 2022 04:26:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230391AbiIHIZh (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 8 Sep 2022 04:25:37 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 888DB8C47F;
        Thu,  8 Sep 2022 01:25:36 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 308B061BB5;
        Thu,  8 Sep 2022 08:25:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5AE46C433D6;
        Thu,  8 Sep 2022 08:25:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1662625535;
        bh=TY+bR3xM8jJob7jJVW+5UA7Dqo3BBJm/pD4n/DrdbCs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=CovvPg9ixES3s4j8IJzJZfCddqtNjBPCOvUEVncdSRAJoACTBB7tPkk249yMey9vP
         4/5s7t7MfhY8WflQvz5OZ1/gV+BP+rRwToAGA2yNTPsugadN0CnDagL9pSnbH2cuoP
         gCMzYQcWn8Qkly2bU+RFrmxTV4pruFsGYBfEoPBOitBBnxipTfMIr/ThQtYRJXiK6C
         msPzBMJINqikQz3l3U7yr6XFvSKHQ3aSrgxNmVd9Z4tw9fN8mmpLNj+2D9VawTYs5+
         3fa83F1/6jfDqu4oC1CSt6q7PrI49Y0bpqx95GOMclfONmPJV/9y1ink/TYNvZm4KO
         ClsT4+Un5sSAg==
Date:   Thu, 8 Sep 2022 09:25:29 +0100
From:   Lee Jones <lee@kernel.org>
To:     Chris Morgan <macroalpha82@gmail.com>
Cc:     linux-pm@vger.kernel.org, linux-rockchip@lists.infradead.org,
        devicetree@vger.kernel.org, zhangqing@rock-chips.com,
        zyw@rock-chips.com, jon.lin@rock-chips.com,
        maccraft123mc@gmail.com, sre@kernel.org, heiko@sntech.de,
        krzysztof.kozlowski+dt@linaro.org, robh+dt@kernel.org,
        philip@pscan.uk, mazziesaccount@gmail.com,
        Chris Morgan <macromorgan@hotmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: Re: [PATCH V10 1/4] dt-bindings: Add Rockchip rk817 battery charger
 support
Message-ID: <Yxmm+VB6CjpACB7f@google.com>
References: <20220827021623.23829-1-macroalpha82@gmail.com>
 <20220827021623.23829-2-macroalpha82@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220827021623.23829-2-macroalpha82@gmail.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Fri, 26 Aug 2022, Chris Morgan wrote:

> From: Chris Morgan <macromorgan@hotmail.com>
> 
> Create dt-binding documentation to document rk817 battery and charger
> usage. New device-tree properties have been added.
> 
> - rockchip,resistor-sense-micro-ohms: The value in microohms of the
>                                       sample resistor.
> - rockchip,sleep-enter-current-microamp: The value in microamps of the
>                                          sleep enter current.
> - rockchip,sleep-filter-current: The value in microamps of the sleep
>                                  filter current.
> 
> Signed-off-by: Chris Morgan <macromorgan@hotmail.com>
> Signed-off-by: Maya Matuszczyk <maccraft123mc@gmail.com>
> Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
>  .../bindings/mfd/rockchip,rk817.yaml          | 50 +++++++++++++++++++
>  1 file changed, 50 insertions(+)

Applied, thanks.

-- 
Lee Jones [李琼斯]
