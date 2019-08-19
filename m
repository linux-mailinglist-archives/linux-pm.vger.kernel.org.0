Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 15B8992531
	for <lists+linux-pm@lfdr.de>; Mon, 19 Aug 2019 15:36:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727761AbfHSNga (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 19 Aug 2019 09:36:30 -0400
Received: from mail.kernel.org ([198.145.29.99]:49938 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727424AbfHSNga (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Mon, 19 Aug 2019 09:36:30 -0400
Received: from X250 (37.80-203-192.nextgentel.com [80.203.192.37])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D235D2085A;
        Mon, 19 Aug 2019 13:36:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1566221789;
        bh=Bqv26nTV/Ia2eL7crmeJCMH7ixSvJr/6wY1pgK5NU6w=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=jfMOD0gJ1BDNi7cWr6vtW7uI3ReDUj17kpzemGGFLbuWizjiA+S3en8/EP6Mt9HhT
         v5mEneUnRAyEwjYPrM27h9uGFXyRRy0usqrZq9H1cMLHOAEYOxll+OvH54XBhRo64j
         n0o5fNDQSTAaAXz8ILB4MplbFZZabUkfSo4V9dvg=
Date:   Mon, 19 Aug 2019 15:36:17 +0200
From:   Shawn Guo <shawnguo@kernel.org>
To:     Anson Huang <Anson.Huang@nxp.com>
Cc:     robh+dt@kernel.org, mark.rutland@arm.com, s.hauer@pengutronix.de,
        kernel@pengutronix.de, festevam@gmail.com, mturquette@baylibre.com,
        sboyd@kernel.org, rjw@rjwysocki.net, viresh.kumar@linaro.org,
        leonard.crestez@nxp.com, abel.vesa@nxp.com,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-pm@vger.kernel.org, Linux-imx@nxp.com
Subject: Re: [PATCH RESEND V2 2/7] arm64: dts: imx8mn-ddr4-evk: Add
 rohm,bd71847 PMIC support
Message-ID: <20190819133614.GM5999@X250>
References: <1566109945-11149-1-git-send-email-Anson.Huang@nxp.com>
 <1566109945-11149-2-git-send-email-Anson.Huang@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1566109945-11149-2-git-send-email-Anson.Huang@nxp.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Sun, Aug 18, 2019 at 02:32:20AM -0400, Anson Huang wrote:
> On i.MX8MN DDR4 EVK board, there is a rohm,bd71847 PMIC
> on i2c1 bus, enable it.
> 
> Signed-off-by: Anson Huang <Anson.Huang@nxp.com>

Applied, thanks.
