Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A5337ACDE6
	for <lists+linux-pm@lfdr.de>; Mon, 25 Sep 2023 04:07:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231638AbjIYCHO (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 24 Sep 2023 22:07:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231659AbjIYCHN (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 24 Sep 2023 22:07:13 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B60AFCF
        for <linux-pm@vger.kernel.org>; Sun, 24 Sep 2023 19:07:07 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BF937C433C8;
        Mon, 25 Sep 2023 02:07:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695607627;
        bh=9NZEuYch24JR1sI2HnCzwnig5hRMmoeVEUVakVvIYj4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=dt6Cj1OX/eql50/F7VNfEAR4kt8w/Qpoa8Hauvv7uhUnD1lrj4Vtk72LPRACUEmnY
         Yol2IlvfqzwRlfWwC12nkldqJAaFw6XhKkf75jrJ7ajtBjG5KJUBFu849hVoBpEObM
         YoJIVAE6BGOUS/imYX22Alg8kgHnxClRno/KVsBgXdvjqspOEJaEIWGTP7y2tLtAL1
         9Xj9lqkK/w/HercIgUueoqeADhh6W95FmSFrE0RuL3GRPXBKQmqA0OP/pW38bRoWCC
         hu75ynfiy4pIHP/q3nckWGzkAsAKGWFwdkFhAtPEUUc6ALwNkTftb8QD32xHHr1ZIV
         ImI1SDZ2CoK+Q==
Date:   Mon, 25 Sep 2023 10:06:56 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Fabio Estevam <festevam@gmail.com>
Cc:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, rafael@kernel.org,
        daniel.lezcano@linaro.org, amitk@kernel.org,
        linux-pm@vger.kernel.org, linux-imx@nxp.com,
        Fabio Estevam <festevam@denx.de>
Subject: Re: [PATCH v2 1/2] arm64: dts: imx93: Add the TMU interrupt
Message-ID: <20230925020656.GX7231@dragon>
References: <20230910125726.1243652-1-festevam@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230910125726.1243652-1-festevam@gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Sun, Sep 10, 2023 at 09:57:25AM -0300, Fabio Estevam wrote:
> From: Fabio Estevam <festevam@denx.de>
> 
> The Thermal Monitoring Unit (TMU) interrupt is number 83.
> 
> Describe it in the devicetree to fix the following schema warning:
> 
> imx93-11x11-evk.dtb: tmu@44482000: 'oneOf' conditional failed, one must be fixed:
> 	'interrupts' is a required property
> 	'interrupts-extended' is a required property
> 	from schema $id: http://devicetree.org/schemas/thermal/qoriq-thermal.yaml#
> 
> Signed-off-by: Fabio Estevam <festevam@denx.de>

Applied, thanks!
