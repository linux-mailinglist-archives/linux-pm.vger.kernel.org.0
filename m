Return-Path: <linux-pm+bounces-30911-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C4879B0769B
	for <lists+linux-pm@lfdr.de>; Wed, 16 Jul 2025 15:09:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CE56F3B6A39
	for <lists+linux-pm@lfdr.de>; Wed, 16 Jul 2025 13:08:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 025FB2F4309;
	Wed, 16 Jul 2025 13:09:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qoT5j6+1"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD41E2F3C1D;
	Wed, 16 Jul 2025 13:09:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752671343; cv=none; b=RZF2ACXzIihvYfnFRxEVdVoa0UCHF2SLY5URRjcPnZxkUyqRfXqvHNKjJE2COcOf9Y4hJeC8vsCXaEHPdRmwGDXGZmOj/uZnDxpG05UnhLbAj4hbEr98qXH7UmUm3iZlhnyv6zagytCO5SKjCIpg21wnEdnyNrnC5esC7KHW1Gk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752671343; c=relaxed/simple;
	bh=3sNMrCCvmOrN1UDF9Di67oG7Y+yXP/L+hr2KnWDbfcA=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:Cc:To:From:
	 References:In-Reply-To; b=YvrdmuK7ffofBP9igVxXzS7OVuvKSTqIMPsYItN5cPRZR/OZGRQ1QBka1Qvr1r0XDtultUugmYy/8z0SfPKbqL4r/oWLhMApYUlQBIpRtv1PpT6B0FwyhTLlRK/GAwNCbdsv4c11SWaB1xuL2EViXBHdEUs0Lmbyx3Qvk5g7nIQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qoT5j6+1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3E068C4CEF0;
	Wed, 16 Jul 2025 13:08:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752671343;
	bh=3sNMrCCvmOrN1UDF9Di67oG7Y+yXP/L+hr2KnWDbfcA=;
	h=Date:Subject:Cc:To:From:References:In-Reply-To:From;
	b=qoT5j6+1E+4dAhDM8fkvRfa1Cauhp+Xezx0aCuNnSDbx44WDevi6G73dQek5rXok/
	 kFlLhnneEjgTYHyGgbcsaLBbsBtxh2AjMopEU1GZm0u7r8Os+AFc7FB5jSkJkyX7Yq
	 UCGdlHQ13qNUFlCtay6Nb/M8yumZ7RqP+ILSPeg77g93aQXPqLBpxl+9zbA9sXEZ4/
	 AJ2EjjlF3bWMDt5qNorXKBDqbipsOJ6vy8F6+S4pwjU9RpSiRQ698EPinhuiSMSoBH
	 y25bfeXl28Z1KFe3fkdPJl9vt6Dfq7oPZkcsN0ZG8P4AUL9gyJXYQ/THXpT1IV61+H
	 eQ6y6pL2YMeYg==
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 16 Jul 2025 15:08:57 +0200
Message-Id: <DBDI4X0LDTPZ.16PODOZINXKEP@kernel.org>
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
From: "Danilo Krummrich" <dakr@kernel.org>
References: <20250701114733.636510-1-ulf.hansson@linaro.org>
 <CAPDyKFr=u0u2ijczExkntHK1miWZ6hRrEWBMiyUwShS3m6c29g@mail.gmail.com>
 <DBCI05B4Y2ZX.VM9KNB61PGU2@kernel.org>
 <CAPDyKFqUHmMi6tBOJyA2YAOYLX-c_kDMskyRTC1Q+c9B4q_g8w@mail.gmail.com>
In-Reply-To: <CAPDyKFqUHmMi6tBOJyA2YAOYLX-c_kDMskyRTC1Q+c9B4q_g8w@mail.gmail.com>

On Wed Jul 16, 2025 at 2:46 PM CEST, Ulf Hansson wrote:
> On Tue, 15 Jul 2025 at 10:50, Danilo Krummrich <dakr@kernel.org> wrote:
>>
>> Hi Ulf,
>>
>> On Wed Jul 9, 2025 at 1:30 PM CEST, Ulf Hansson wrote:
>> > I decided it was time to give this a try, so I have queued this up for
>> > v6.17 via the next branch at my pmdomain tree.
>> >
>> > If you encounter any issues, please let me know so I can help to fix t=
hem.
>>
>> Can you please address my concern in patch 17 ("driver core: Export
>> get_dev_from_fwnode()")?
>>
>> Since this has been applied already, a subsequent patch would be perfect=
ly fine.
>
> Hi Danilo,
>
> As Greg and Saravana were happy, I didn't want to hold back the whole
> series only because of a minor comment on some missing documentation.

Fair enough -- yet, a brief reply asking if it can be done as a follow-up w=
ould
have been appreciated.

I don't think it's that minor. The race may be unlikely to happen, but if i=
t
happens because someone isn't careful with this (now exported) API - and I'=
m
absolutely sure it's only gonna be a matter of time until that happens -, i=
t'll
be painful. :(

> But, yes, let me look into it. It may take a while though, as vacation
> is getting closer. If you want to send a patch yourself, please, feel
> free to do it.

Ok, let me see if I can get to it.

> Note that, while at it, we should probably also add some documentation
> of device_set_node() (next to get_dev_from_fwnode()) as it also lacks
> it.

Agreed!

Have a nice vacation!

- Danilo

