Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DD71992548
	for <lists+linux-pm@lfdr.de>; Mon, 19 Aug 2019 15:39:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727442AbfHSNjf (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 19 Aug 2019 09:39:35 -0400
Received: from mail.kernel.org ([198.145.29.99]:50584 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727301AbfHSNjf (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Mon, 19 Aug 2019 09:39:35 -0400
Received: from X250 (37.80-203-192.nextgentel.com [80.203.192.37])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7EBA620644;
        Mon, 19 Aug 2019 13:39:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1566221975;
        bh=lFBTbfxwQ3ahDdxV2/8NFxtVWweNk5mXIyOhPXcXizw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=p+cNdQz7XRMqQHyZvz2FzrZFclj9OX3QW86mFpRlmhLADyV3CC+KUo4vIBvYJjP8F
         6hD3eqFy9gz9ebMlGNbsDrFhTuOf9kywmohQBdmnLTTJ/X7KkDDfPJYKWbXXBeUxNo
         rv5kcDvfvqBy5RRKGD7sx44d8WG2qLe026tNN9lM=
Date:   Mon, 19 Aug 2019 15:39:22 +0200
From:   Shawn Guo <shawnguo@kernel.org>
To:     Anson Huang <Anson.Huang@nxp.com>
Cc:     robh+dt@kernel.org, mark.rutland@arm.com, s.hauer@pengutronix.de,
        kernel@pengutronix.de, festevam@gmail.com, mturquette@baylibre.com,
        sboyd@kernel.org, rjw@rjwysocki.net, viresh.kumar@linaro.org,
        leonard.crestez@nxp.com, abel.vesa@nxp.com,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-pm@vger.kernel.org, Linux-imx@nxp.com
Subject: Re: [PATCH RESEND V2 6/7] clk: imx8mn: Add necessary frequency
 support for ARM PLL table
Message-ID: <20190819133921.GO5999@X250>
References: <1566109945-11149-1-git-send-email-Anson.Huang@nxp.com>
 <1566109945-11149-6-git-send-email-Anson.Huang@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1566109945-11149-6-git-send-email-Anson.Huang@nxp.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Sun, Aug 18, 2019 at 02:32:24AM -0400, Anson Huang wrote:
> i.MX8MN supports CPU running at 1.5GHz/1.4GHz/1.2GHz, add missing
> frequency for ARM PLL table.
> 
> Signed-off-by: Anson Huang <Anson.Huang@nxp.com>

Applied, thanks.
