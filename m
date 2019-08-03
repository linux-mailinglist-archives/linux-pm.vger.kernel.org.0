Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5FA2A80533
	for <lists+linux-pm@lfdr.de>; Sat,  3 Aug 2019 10:12:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387535AbfHCIMU (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sat, 3 Aug 2019 04:12:20 -0400
Received: from mail.kernel.org ([198.145.29.99]:57234 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387532AbfHCIMU (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Sat, 3 Aug 2019 04:12:20 -0400
Received: from X250.getinternet.no (98.142.130.235.16clouds.com [98.142.130.235])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6A33D21726;
        Sat,  3 Aug 2019 08:12:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1564819939;
        bh=48aWMdCMkjYO+TIY+je07w+cK/deQF45Y7RMj+QIouo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=pV0Uoa3/a3Riy4c+yQtXWVkCtm1A2YJ18TfIDr8mmd4J/+Z2ksX/ijYwTKekSstPh
         XImanuCxwCysJLwakWH7twmKJmrc0+aIGc2jlFvPxznu9616ffVKnWOTQen6Tj4wm7
         y55vd7YQVjaTBFKZ3aeXoBXB1c2Uz+RGLrSBjLFg=
Date:   Sat, 3 Aug 2019 10:12:10 +0200
From:   Shawn Guo <shawnguo@kernel.org>
To:     Anson.Huang@nxp.com
Cc:     vireshk@kernel.org, nm@ti.com, sboyd@kernel.org,
        robh+dt@kernel.org, mark.rutland@arm.com, s.hauer@pengutronix.de,
        kernel@pengutronix.de, festevam@gmail.com, leonard.crestez@nxp.com,
        p.zabel@pengutronix.de, ping.bai@nxp.com, daniel.baluta@nxp.com,
        l.stach@pengutronix.de, abel.vesa@nxp.com, angus@akkea.ca,
        andrew.smirnov@gmail.com, ccaione@baylibre.com, agx@sigxcpu.org,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Linux-imx@nxp.com
Subject: Re: [PATCH V2 3/4] arm64: dts: imx8mq: Add opp-suspend property to
 OPP table
Message-ID: <20190803081209.GB8870@X250.getinternet.no>
References: <20190709080015.43442-1-Anson.Huang@nxp.com>
 <20190709080015.43442-3-Anson.Huang@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190709080015.43442-3-Anson.Huang@nxp.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Tue, Jul 09, 2019 at 04:00:14PM +0800, Anson.Huang@nxp.com wrote:
> From: Anson Huang <Anson.Huang@nxp.com>
> 
> Add opp-suspend property to each OPP, the of opp core will
> select the OPP HW supported and with highest rate to be
> suspend opp, it will speed up the suspend/resume process.
> 
> Signed-off-by: Anson Huang <Anson.Huang@nxp.com>

Applied, thanks.
