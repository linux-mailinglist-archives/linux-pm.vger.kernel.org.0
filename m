Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 95B0A70EDF
	for <lists+linux-pm@lfdr.de>; Tue, 23 Jul 2019 03:56:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731876AbfGWB4i (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 22 Jul 2019 21:56:38 -0400
Received: from vps0.lunn.ch ([185.16.172.187]:57822 "EHLO vps0.lunn.ch"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727851AbfGWB4i (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Mon, 22 Jul 2019 21:56:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
        s=20171124; h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:
        Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=3UPS6SnYVearlAWk6p3v30CJre0DZAAwQz9HmajYiJE=; b=cgn8c/EVPnhqqkTTKzJUTz8wH8
        zy+TZ0cFEj/uUyajGn9DuybbZeGoHdsRrI31SQOlsQaKyel8/mVddkZKIFWAwzhvOgj3cGNMYtCW+
        Ds11XZyT39fGEMdnjrAr5dMtFVwWB6PKcdR9ssXQsFwUge/zRukl81/256xZ2kQtxmEs=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.89)
        (envelope-from <andrew@lunn.ch>)
        id 1hpk2Z-0006U1-NM; Tue, 23 Jul 2019 03:56:31 +0200
Date:   Tue, 23 Jul 2019 03:56:31 +0200
From:   Andrew Lunn <andrew@lunn.ch>
To:     Evgeny Kolesnikov <evgenyz@gmail.com>
Cc:     Mark Rutland <mark.rutland@arm.com>,
        Jason Cooper <jason@lakedaemon.net>, linux-pm@vger.kernel.org,
        Gregory Clement <gregory.clement@bootlin.com>,
        Sebastian Reichel <sre@kernel.org>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
Subject: Re: [PATCH 0/5] Add support for WD MyCloud EX2 Ultra (+ versatile
 UART-based restart/poweroff drivers)
Message-ID: <20190723015631.GI8972@lunn.ch>
References: <cover.1563822216.git.evgenyz@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1563822216.git.evgenyz@gmail.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Mon, Jul 22, 2019 at 09:53:00PM +0200, Evgeny Kolesnikov wrote:
> This patchset consists of the DTS, which describes the WD MyCloud EX2 Ultra device,
> 'poweroff' and 'resert' drivers for power-managing MCUs connected to a board via UART
> (these drivers are more versatile than qnap-poweroff and could be used as a substitude),
> and DT bindings for these drivers.
> 
> The difference between uart-poweroff and qnap-poweroff is small, but important:
> uart-poweroff is able to send to an MCU a command of arbitrary length, and the command
> itself is defined in a DTS file for a specific device/board, thus making this driver
> applicable to wider range of devices.

Hi Evgeny

There is a lot of replicated code here, and in the original
qnap-poweroff.c driver. Please consolidate it by extending the current
driver. It should be easy to add a new compatible string, and turn
power_off_cfg.cmd into an array.

	  Andrew
