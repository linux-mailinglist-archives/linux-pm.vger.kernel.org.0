Return-Path: <linux-pm+bounces-31783-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FEC4B19481
	for <lists+linux-pm@lfdr.de>; Sun,  3 Aug 2025 18:51:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1733B3B1086
	for <lists+linux-pm@lfdr.de>; Sun,  3 Aug 2025 16:51:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63BE819F424;
	Sun,  3 Aug 2025 16:51:41 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from pd.grulic.org.ar (pd.grulic.org.ar [200.16.16.187])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB07174420
	for <linux-pm@vger.kernel.org>; Sun,  3 Aug 2025 16:51:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=200.16.16.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754239901; cv=none; b=IQNm2unrMdHQvThGmvhxAGTVrvn2bEdJa+KegVZo8Gn/e1czyeZyemxY5a6jHE1grhrjJHzJauNMrkdAA41IY0kumFlBj+Mpad5u537uQ7gkdnJyKkWaiz87U74MjKSoA8Pci5KIr97211SHxdboL05vq/LQzoSghU/kCpGL57Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754239901; c=relaxed/simple;
	bh=lpIAKCH/dF0Fn3csHSSzSZWTr89iFtFnYneMr/ga7lc=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=Nh2eDh/3K25Wu493XrfgOQncolj9gyT+cgsvn0Wch4H+XWJSgNaWZEkvxzhmzfImBUeJr6I9kzuwmNOdpW8yImy/UMOPLtE66Qj36/A9DuyQ6wVoaNaeKDN9WBZ/+gcoywwODnJR8tNjphEfhn8W7nhrEmdBJcq51pgBxbTvWb0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=grulic.org.ar; spf=pass smtp.mailfrom=grulic.org.ar; arc=none smtp.client-ip=200.16.16.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=grulic.org.ar
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=grulic.org.ar
Received: from localhost (82-64-43-81.subs.proxad.net [82.64.43.81])
	by pd.grulic.org.ar (Postfix) with ESMTPSA id 50F7D80EA2
	for <linux-pm@vger.kernel.org>; Sun,  3 Aug 2025 13:53:19 -0300 (-03)
Date: Sun, 3 Aug 2025 18:51:16 +0200
From: Marcos Dione <mdione@grulic.org.ar>
To: linux-pm@vger.kernel.org
Subject: Re: [Possible bug]: thermal and an scaling governor issues
Message-ID: <aI-ThPmDMxPQ9Qix@ioniq>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aI8xnBiOEKsUewMQ@ioniq>

On Sun, Aug 03, 2025 at 11:53:32AM +0200, Marcos Dione wrote:
> https://i.imgur.com/qb41dZ0.png

    I gave it a go, reading 3 pages, but got not much better (but
further). You can read it all here:

https://en.osm.town/@mdione/114964442166494174

    In short, I only confirmed that I'm using intel_pstate, but that all
settings point to the performace setting, yet I sill get between 0.8 and
1.1MHz.

    I'm going to reboot this machine now, and frankly I hope I don't hit
this bug again, but:

a) I'm sure I'm going to; and 
b) The file reading times still are an issue.

    Cheers,

	-- Marcos.

