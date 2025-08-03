Return-Path: <linux-pm+bounces-31780-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C7768B19326
	for <lists+linux-pm@lfdr.de>; Sun,  3 Aug 2025 11:14:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 890187A4442
	for <lists+linux-pm@lfdr.de>; Sun,  3 Aug 2025 09:13:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33F472874FA;
	Sun,  3 Aug 2025 09:14:32 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from pd.grulic.org.ar (pd.grulic.org.ar [200.16.16.187])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A040717BA9
	for <linux-pm@vger.kernel.org>; Sun,  3 Aug 2025 09:14:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=200.16.16.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754212472; cv=none; b=Ebt8lUlYgK8VToaZjzQI//2WeljY6p49QdHLQYl0hK4WpspV1SER6vQusb/vAxr0qpgfoYB9m//ktn0ireIAsujzCiJ9wrdpAXW/BWojcQU71gEf6TyOHLdMMft5neabnzhqs0krQGg5M3HpirLgkOX6dpN8wWI6XrC8ID3CPyE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754212472; c=relaxed/simple;
	bh=zMZ8fq4pxrCa50e5RAI7mUDhRIUuf9GmKzxY6ddYYSw=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=pGMYa7VMT2AXVE7lS90EZoxKDPWVwjowgFkj1YQc7t1chr3PEmo2EKZM4DSlfjy48hx2DUhyGoZuPOmzTrnEwtzX1NRZ6nBuoSE5y6Sbjg0+PguKSHGGX9BOXvZQ9C3GHH5uorUAkkKz0+vswaWmWGiaIe922AaUNLPeL+e4ZRk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=grulic.org.ar; spf=pass smtp.mailfrom=grulic.org.ar; arc=none smtp.client-ip=200.16.16.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=grulic.org.ar
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=grulic.org.ar
Received: from localhost (82-64-43-81.subs.proxad.net [82.64.43.81])
	by pd.grulic.org.ar (Postfix) with ESMTPSA id 47E9180F8C
	for <linux-pm@vger.kernel.org>; Sun,  3 Aug 2025 06:16:21 -0300 (-03)
Date: Sun, 3 Aug 2025 11:14:17 +0200
From: Marcos Dione <mdione@grulic.org.ar>
To: linux-pm@vger.kernel.org
Subject: Re: [Possible bug]: thermal and an scaling governor issues
Message-ID: <aI8oab68UiW1KNQN@ioniq>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aI6Pb99qXaSaB-Fy@ioniq>

On Sun, Aug 03, 2025 at 10:55:45AM +0200, Marcos Dione wrote:
>     Before anything, please CC: me, as I'm not subscribed to the list.

    This is no longer the case, I'm subscribed now.


    Another data point: CPU freq goes back to normal, when my
compilation stops (last night before 2AM), but goes back down when I
launch it again this morning (at around 10:30):

https://i.imgur.com/l0yZYCQ.png

    Cheers,

	-- Marcos.

