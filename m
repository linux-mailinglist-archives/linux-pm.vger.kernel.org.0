Return-Path: <linux-pm+bounces-31781-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 927DDB1935C
	for <lists+linux-pm@lfdr.de>; Sun,  3 Aug 2025 11:53:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 55F3F3B7D67
	for <lists+linux-pm@lfdr.de>; Sun,  3 Aug 2025 09:53:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1834924467A;
	Sun,  3 Aug 2025 09:53:51 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from pd.grulic.org.ar (pd.grulic.org.ar [200.16.16.187])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D47841DDC15
	for <linux-pm@vger.kernel.org>; Sun,  3 Aug 2025 09:53:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=200.16.16.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754214831; cv=none; b=aBx+OSH3rt2mlJMuBoMWewj/lHL+ET3iQ4E9+UG/qPfG1J7v7rbx1lpTvymRH8+lVSmExFa22N+dlGGaDyX6q7/b3lvLXl/Y0YmRJpSeKZaswZ/1FKHmz8c2d6+sjU1ozTX6FeISO9MS0YJeR10mGR91x/GPVYcxhNKDBFqUZQs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754214831; c=relaxed/simple;
	bh=9vLxEF53z8X/UKCpRZ19piedsg5kz108HaxbN1cnT6I=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=UzWi2NjZc0Er4EmIt70iDla+52jrwn5r+N26GbjAgqmjaG1aY8s6q6te2v5ZpMJQyFHHPOm2azZEVVHCsEGao9Nb4rQ3sNswOO0U/XqD8DSLzzI/ULQSw8/s/muHXQ411lGOEYTpH2Rs/c2KehpXwgNqf3lbayhWRaL8NfADrmQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=grulic.org.ar; spf=pass smtp.mailfrom=grulic.org.ar; arc=none smtp.client-ip=200.16.16.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=grulic.org.ar
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=grulic.org.ar
Received: from localhost (82-64-43-81.subs.proxad.net [82.64.43.81])
	by pd.grulic.org.ar (Postfix) with ESMTPSA id 5144B803A4
	for <linux-pm@vger.kernel.org>; Sun,  3 Aug 2025 06:55:35 -0300 (-03)
Date: Sun, 3 Aug 2025 11:53:32 +0200
From: Marcos Dione <mdione@grulic.org.ar>
To: linux-pm@vger.kernel.org
Subject: Re: [Possible bug]: thermal and an scaling governor issues
Message-ID: <aI8xnBiOEKsUewMQ@ioniq>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aI8oab68UiW1KNQN@ioniq>

On Sun, Aug 03, 2025 at 11:14:17AM +0200, Marcos Dione wrote:
> On Sun, Aug 03, 2025 at 10:55:45AM +0200, Marcos Dione wrote:
>     Another data point: CPU freq goes back to normal, when my
> compilation stops (last night before 2AM), but goes back down when I
> launch it again this morning (at around 10:30):
> 
> https://i.imgur.com/l0yZYCQ.png

    Another one: I started compiling last night at ~21:00, but later at
~21:50, after a few back and forth between high and low frequencies, it
dropped to low and staed there, even when the compilation lasted for
another 4h.

https://i.imgur.com/qb41dZ0.png

    Cheers,

	-- Marcos.

