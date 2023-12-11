Return-Path: <linux-pm+bounces-877-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 12CC080BE5A
	for <lists+linux-pm@lfdr.de>; Mon, 11 Dec 2023 00:48:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 441C41C2088D
	for <lists+linux-pm@lfdr.de>; Sun, 10 Dec 2023 23:48:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20A3F1E513;
	Sun, 10 Dec 2023 23:48:28 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by lindbergh.monkeyblade.net (Postfix) with ESMTP id 34E5EE7;
	Sun, 10 Dec 2023 15:48:25 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 048D6FEC;
	Sun, 10 Dec 2023 15:49:11 -0800 (PST)
Received: from minigeek.lan (unknown [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 4906A3F5A1;
	Sun, 10 Dec 2023 15:48:22 -0800 (PST)
Date: Mon, 11 Dec 2023 00:05:28 +0000
From: Andre Przywara <andre.przywara@arm.com>
To: Maksim Kiselev <bigunclemax@gmail.com>
Cc: anarsoul@gmail.com, bob@electricworry.net, conor+dt@kernel.org,
 daniel.lezcano@linaro.org, devicetree@vger.kernel.org,
 jernej.skrabec@gmail.com, krzysztof.kozlowski+dt@linaro.org,
 linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org,
 linux-sunxi@lists.linux.dev, lukasz.luba@arm.com,
 martin.botka@somainline.org, rafael@kernel.org, robh+dt@kernel.org,
 rui.zhang@intel.com, samuel@sholland.org, tiny.windzz@gmail.com,
 wens@csie.org
Subject: Re: [PATCH v3 5/6] thermal: sun8i: add support for H616 THS
 controller
Message-ID: <20231211000528.57cb646c@minigeek.lan>
In-Reply-To: <a14fb458-caf0-4a4a-b76b-c2503b0840d2@gmail.com>
References: <20231128005849.19044-6-andre.przywara@arm.com>
	<a14fb458-caf0-4a4a-b76b-c2503b0840d2@gmail.com>
Organization: Arm Ltd.
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.31; x86_64-slackware-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 9 Dec 2023 13:44:34 +0300
Maksim Kiselev <bigunclemax@gmail.com> wrote:

Hi Maksim,

> Hi Martin, Andre.
> 
> May I inquire? Why do we need a separate sun50i_h616_ths_calibrate() 
> function? Why can't we just extend an existing sun50i_h6_ths_calibrate()?
> 
> At my glance the calculations in both functions are the same. We just 
> need to handle a special case for the 4th sensor.

You seem to be right, they are indeed the same, just written slightly
differently. Do you already have any patches that unify that?
I don't know if Martin or I find time to do it this week, but we could
also optimise this later.

Cheers,
Andre

