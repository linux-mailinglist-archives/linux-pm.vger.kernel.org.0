Return-Path: <linux-pm+bounces-30853-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 156D4B0555E
	for <lists+linux-pm@lfdr.de>; Tue, 15 Jul 2025 10:50:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 264823BF1B3
	for <lists+linux-pm@lfdr.de>; Tue, 15 Jul 2025 08:49:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CCCE275851;
	Tue, 15 Jul 2025 08:50:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fgbCLmVm"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7F1B231849;
	Tue, 15 Jul 2025 08:50:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752569410; cv=none; b=DyPqK+N4Nctj3U6b89FZ8jaQHwqyEvzaqEfXlJkqbQUPskOTRi6EuGMVYfKSc8TF7ScoTCaIw0gbG9ySOenxua0AdgViSlpfUslJJnaqrZTDMF1Xg2R+kjBR3uGEHyRsRX7hQxBM9JxAbkSwBKgq0KYBULct6Y+577MM12C/vzM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752569410; c=relaxed/simple;
	bh=289O4eRlY4l0x9C7ngrEvXUFEF5rxjK+EO1/Qq/NHTU=;
	h=Mime-Version:Content-Type:Date:Message-Id:From:Subject:Cc:To:
	 References:In-Reply-To; b=alH4oumP6OshDb3Psp1B/JdAZlYybmbuYN0q0mN3lRo2MLhLEYqRkoqKLQL+3YPcZyBTZ+oDs2/d8BFzhuJjvh4p5MBjGw26nG7l8oN+Vbkeb/Mzo731sztHIQeX597L6Zzn5eUls0FknEibijHQRZswBPc3V1T1zQI0ustNpKg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fgbCLmVm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 82C83C4CEE3;
	Tue, 15 Jul 2025 08:50:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752569409;
	bh=289O4eRlY4l0x9C7ngrEvXUFEF5rxjK+EO1/Qq/NHTU=;
	h=Date:From:Subject:Cc:To:References:In-Reply-To:From;
	b=fgbCLmVmkWLQhT4X1hcB5K77kJSFdd+63vBa66dHKERmwum4xP2/2rsMFmRQdFm5X
	 RUy0H18klWoQxp6WV9VAVH9IrDrZLkqolE7bHcRGDp3w2fzrZjfLfM3sJ6veKaw08D
	 5J9ZKeRTNz8KQjhRpInS0E5JE8qQW2qtxXjKCLZ2Rq6RdAdQ/XsWQ6IznhzYxrGWXf
	 B3nWjFnXH6DS97cyGPjYDjxDkTLXqiaHZyv/+ApdWhydk1r+W/DCjUBbJCqmhp+L0L
	 RQtDUCmvSNXumTxRw9w84QRroFe8hm6FNeA/poNypkNTpHE4mstqxh5QV/D5buJUev
	 Nve9vM3UWqElQ==
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 15 Jul 2025 10:50:03 +0200
Message-Id: <DBCI05B4Y2ZX.VM9KNB61PGU2@kernel.org>
From: "Danilo Krummrich" <dakr@kernel.org>
Subject: Re: [PATCH v3 00/24] pmdomain: Add generic ->sync_state() support
 to genpd
Cc: "Saravana Kannan" <saravanak@google.com>, "Stephen Boyd"
 <sboyd@kernel.org>, <linux-pm@vger.kernel.org>, "Rafael J . Wysocki"
 <rafael@kernel.org>, "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
 "Michael Grzeschik" <m.grzeschik@pengutronix.de>, "Bjorn Andersson"
 <andersson@kernel.org>, "Abel Vesa" <abel.vesa@linaro.org>, "Peng Fan"
 <peng.fan@oss.nxp.com>, "Tomi Valkeinen" <tomi.valkeinen@ideasonboard.com>,
 "Johan Hovold" <johan@kernel.org>, "Maulik Shah"
 <maulik.shah@oss.qualcomm.com>, "Michal Simek" <michal.simek@amd.com>,
 "Konrad Dybcio" <konradybcio@kernel.org>, "Thierry Reding"
 <thierry.reding@gmail.com>, "Jonathan Hunter" <jonathanh@nvidia.com>,
 "Hiago De Franco" <hiago.franco@toradex.com>, "Geert Uytterhoeven"
 <geert@linux-m68k.org>, <linux-arm-kernel@lists.infradead.org>,
 <linux-kernel@vger.kernel.org>
To: "Ulf Hansson" <ulf.hansson@linaro.org>
References: <20250701114733.636510-1-ulf.hansson@linaro.org>
 <CAPDyKFr=u0u2ijczExkntHK1miWZ6hRrEWBMiyUwShS3m6c29g@mail.gmail.com>
In-Reply-To: <CAPDyKFr=u0u2ijczExkntHK1miWZ6hRrEWBMiyUwShS3m6c29g@mail.gmail.com>

Hi Ulf,

On Wed Jul 9, 2025 at 1:30 PM CEST, Ulf Hansson wrote:
> I decided it was time to give this a try, so I have queued this up for
> v6.17 via the next branch at my pmdomain tree.
>
> If you encounter any issues, please let me know so I can help to fix them=
.

Can you please address my concern in patch 17 ("driver core: Export
get_dev_from_fwnode()")?

Since this has been applied already, a subsequent patch would be perfectly =
fine.

Thanks,
Danilo

