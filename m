Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C56C9719B2
	for <lists+linux-pm@lfdr.de>; Tue, 23 Jul 2019 15:48:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732795AbfGWNsZ (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 23 Jul 2019 09:48:25 -0400
Received: from vps0.lunn.ch ([185.16.172.187]:59330 "EHLO vps0.lunn.ch"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732774AbfGWNsZ (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Tue, 23 Jul 2019 09:48:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
        s=20171124; h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:
        Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=hh700sFheglasLLwhcaql8zIvJCDfQNvUkZLvzNr77M=; b=rwbrHRGLTh8/q3qq4bi0P8giyV
        dGkAgmemiQF4xTuTzXHhu43MU4nDRHn2CYLWkyJ0J09bgrsrb92qBcgIQvB00g1cJsVu4/fgiaBQK
        0AGXfsj/CLhXQwS96LeJ4N4f+kQoRmlJuSKbp/EB5b4KedfL9VYvDcrvrTDQI7leqMto=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.89)
        (envelope-from <andrew@lunn.ch>)
        id 1hpv9N-0001IR-0Z; Tue, 23 Jul 2019 15:48:17 +0200
Date:   Tue, 23 Jul 2019 15:48:17 +0200
From:   Andrew Lunn <andrew@lunn.ch>
To:     Evgeny Kolesnikov <evgenyz@gmail.com>
Cc:     Sebastian Reichel <sre@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Jason Cooper <jason@lakedaemon.net>,
        Gregory Clement <gregory.clement@bootlin.com>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 5/5] ARM: dts: armada385-wd-mcex2u: Add DTS file for WD
 My Cloud EX2 Ultra
Message-ID: <20190723134817.GB2381@lunn.ch>
References: <cover.1563822216.git.evgenyz@gmail.com>
 <fd2a97d627c21a7e92a9a1aa15cf26c608d1e383.1563822216.git.evgenyz@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fd2a97d627c21a7e92a9a1aa15cf26c608d1e383.1563822216.git.evgenyz@gmail.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

> +		internal-regs {
> +			timer@c200 {
> +				status = "disabled";
> +			};
> +
> +			i2c0: i2c@11000 {
> +				status = "okay";
> +				clock-frequency = <100000>;
> +			};
> +
> +			i2c1: i2c@11100 {
> +				status = "okay";
> +				clock-frequency = <100000>;
> +			};

It is a bit unusual to enable i2c busses when there is nothing on
them.

> +			ethernet@34000 {
> +				phy = <&phy0>;

phy has been deprecated. Please use phy-handle.

    Andrew
