Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0230A31664C
	for <lists+linux-pm@lfdr.de>; Wed, 10 Feb 2021 13:13:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231657AbhBJMNq (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 10 Feb 2021 07:13:46 -0500
Received: from mail.kernel.org ([198.145.29.99]:37040 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230263AbhBJMLg (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 10 Feb 2021 07:11:36 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 64F8764E57;
        Wed, 10 Feb 2021 12:10:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1612959039;
        bh=yizkUZ7H1j9p+wU0vTO25UitMqPZWM3xnpZ9pxgynoE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=GeQdUUSx+seiQUBBe2etfCNhgPcc6QRsC1dOSzA6QdmYiUViqpZEYB1JwCV/1eYZg
         gGqCakIJrkwsfAEyrSbPrgZ2MEf3I2NuGAgEotg246pzlYCOwWwK4eePdhTaPaBBlg
         d0+OFL5EmOWfb0WLvgiKsA6rVUOe/OcHvNydzq35F47M7Tfil+u+aLdsVjP2H/9orC
         nJWEfBEcAYtpKQ6JHDZSRkAVPy2bkS1F0hZnVhgr6YXzRacic+TPpwjQNRA+SBd1MW
         sfMZZdoHatJ/ws0eLd8uANLckE6vOe5rqx7VDKEz/1mTjxTv+bb4MzTwDYwqV8qcxr
         RTJYyXHFekBAw==
Date:   Wed, 10 Feb 2021 17:40:35 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Georgi Djakov <georgi.djakov@linaro.org>
Cc:     linux-arm-msm@vger.kernel.org,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Odelu Kukatla <okukatla@codeaurora.org>,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] interconnect: qcom: Add SM8350 interconnect provider
 driver
Message-ID: <20210210121035.GF2774@vkoul-mobl.Dlink>
References: <20210210104724.340991-1-vkoul@kernel.org>
 <20210210104724.340991-2-vkoul@kernel.org>
 <8ab6dfcc-a710-1ecd-6774-1f54ce30685c@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8ab6dfcc-a710-1ecd-6774-1f54ce30685c@linaro.org>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 10-02-21, 13:40, Georgi Djakov wrote:
> Hi Vinod,
> 
> On 2/10/21 12:47, Vinod Koul wrote:
> > Add driver for the Qualcomm interconnect buses found in SM8i350 based
> 
> SM8i350?

fumble fingers :(

> 
> > platforms. The topology consists of several NoCs that are controlled by
> > a remote processor that collects the aggregated bandwidth for each
> > master-slave pairs.
> > 
> > Generated from downstream interconnect driver written by David Dai
> > 
> > Signed-off-by: Vinod Koul <vkoul@kernel.org>
> > ---
> >   drivers/interconnect/qcom/Kconfig  |  10 +
> >   drivers/interconnect/qcom/Makefile |   2 +
> >   drivers/interconnect/qcom/sm8350.c | 635 +++++++++++++++++++++++++++++
> >   3 files changed, 647 insertions(+)
> >   create mode 100644 drivers/interconnect/qcom/sm8350.c
> > 
> > diff --git a/drivers/interconnect/qcom/Kconfig b/drivers/interconnect/qcom/Kconfig
> > index a8f93ba265f8..2ad0aea8336a 100644
> > --- a/drivers/interconnect/qcom/Kconfig
> > +++ b/drivers/interconnect/qcom/Kconfig
> > @@ -85,5 +85,15 @@ config INTERCONNECT_QCOM_SM8250
> >   	  This is a driver for the Qualcomm Network-on-Chip on sm8250-based
> >   	  platforms.
> > +config INTERCONNECT_QCOM_SM8350
> > +	tristate "Qualcomm SM8350 interconnect driver"
> > +	depends on INTERCONNECT_QCOM
> > +	depends on (QCOM_RPMH && QCOM_COMMAND_DB && OF) || COMPILE_TEST
> 
> Maybe depend on INTERCONNECT_QCOM_RPMH_POSSIBLE instead of the above.

That seems to be new thingy in next, sure will update to that as well

Thanks for quick review.

-- 
~Vinod
