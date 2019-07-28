Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E03A977F90
	for <lists+linux-pm@lfdr.de>; Sun, 28 Jul 2019 15:21:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726300AbfG1NU5 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 28 Jul 2019 09:20:57 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:58888 "EHLO
        atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726032AbfG1NU4 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 28 Jul 2019 09:20:56 -0400
Received: by atrey.karlin.mff.cuni.cz (Postfix, from userid 512)
        id 02D3F80234; Sun, 28 Jul 2019 15:20:40 +0200 (CEST)
Date:   Sun, 28 Jul 2019 15:20:47 +0200
From:   Pavel Machek <pavel@ucw.cz>
To:     Evgeny Kolesnikov <evgenyz@gmail.com>
Cc:     Sebastian Reichel <sre@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Jason Cooper <jason@lakedaemon.net>,
        Andrew Lunn <andrew@lunn.ch>,
        Gregory Clement <gregory.clement@bootlin.com>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 0/5] Add support for WD MyCloud EX2 Ultra (+ versatile
 UART-based restart/poweroff drivers)
Message-ID: <20190728132047.GA8718@xo-6d-61-c0.localdomain>
References: <cover.1563822216.git.evgenyz@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1563822216.git.evgenyz@gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Mon 2019-07-22 21:53:00, Evgeny Kolesnikov wrote:
> This patchset consists of the DTS, which describes the WD MyCloud EX2 Ultra device,
> 'poweroff' and 'resert' drivers for power-managing MCUs connected to a board via UART
> (these drivers are more versatile than qnap-poweroff and could be used as a substitude),
> and DT bindings for these drivers.
> 
> The difference between uart-poweroff and qnap-poweroff is small, but important:
> uart-poweroff is able to send to an MCU a command of arbitrary length, and the command
> itself is defined in a DTS file for a specific device/board, thus making this driver
> applicable to wider range of devices.
> 
>  drivers/power/reset/uart-poweroff.c           | 155 +++++++++
>  drivers/power/reset/uart-restart.c            | 204 ++++++++++++

These twon really need to be combined somehow.

Plus... does it have mini-16550 driver in it? Should it use serdev instead?
										Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
