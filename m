Return-Path: <linux-pm+bounces-32093-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4AB71B1FB08
	for <lists+linux-pm@lfdr.de>; Sun, 10 Aug 2025 18:36:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5B4F91893368
	for <lists+linux-pm@lfdr.de>; Sun, 10 Aug 2025 16:36:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13E831E835B;
	Sun, 10 Aug 2025 16:36:34 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from pd.grulic.org.ar (pd.grulic.org.ar [200.16.16.187])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 286A5AD51
	for <linux-pm@vger.kernel.org>; Sun, 10 Aug 2025 16:36:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=200.16.16.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754843794; cv=none; b=NiMM1feSpFq8MqbmIKk3DeYFgK+o2wAo/pKYTJ4RQ5ll6tAIGGtZ8i6SYnhrXkygTr/txLEnVAkT8+Vto3zTT4wdTqaRW/ysQokxiqsLno5RcBrVX+kh0giEpMczyfLaHj6syNWNOOCfrzAwtANHUNYGC6VzVHcVO/32lKuAgZU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754843794; c=relaxed/simple;
	bh=2EOgxN0IsRZYNq3RhjSj0ve4puxsZKoY+AxrWtR4mI0=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=sVFhBF/fD3CMe/WBBJpleUeXjFR0NNmDyRQiuBtIxLXyuxuCYSskL3zh4NhjrEpnkBfcDT5E+cJsU7yIKhv61qk2eaLgeMTGDGSatinuWrP7PYtOyxTRk/5M6s6PoqJsCAljYftdWX+PBEbf8lS7y3/l8NW/m/O+qDfCzp1lTUo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=grulic.org.ar; spf=pass smtp.mailfrom=grulic.org.ar; arc=none smtp.client-ip=200.16.16.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=grulic.org.ar
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=grulic.org.ar
Received: from localhost (82-64-43-81.subs.proxad.net [82.64.43.81])
	by pd.grulic.org.ar (Postfix) with ESMTPSA id EF11F80E45;
	Sun, 10 Aug 2025 13:38:17 -0300 (-03)
Date: Sun, 10 Aug 2025 18:36:02 +0200
From: Marcos Dione <mdione@grulic.org.ar>
To: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: linux-pm@vger.kernel.org
Subject: Re: [Possible bug]: thermal and an scaling governor issues
Message-ID: <aJjKckusX3imDMf2@ioniq>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a61eb3d7-b06a-43ae-b373-d35db316d61c@linaro.org>

On Sun, Aug 03, 2025 at 10:18:33PM +0200, Daniel Lezcano wrote:
> IIUC, it is a laptop.

    yes.

> There can be a couple of things. The difficult part is the firmware can do
> actions under the hood, the userspace may change the governors depending on
> the temperature and the kernel can do something else.

    Do we get any events about this or is 100% transparent?

> I suggest to investigate first the temperature sensor for the skin (or case)
> and the battery. What are their temperature when you compile ?

    As I mention, I had to disable monitoring, but I could check
manually. All I can say is that that was particularly not hot (much less
heatwave-y) week, so it _should_ have been cooler than usual (for this
period). Also, a reboot fixed it, so it was not that.

    Cheers,

	-- Marcos.

