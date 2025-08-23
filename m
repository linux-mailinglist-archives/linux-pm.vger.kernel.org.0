Return-Path: <linux-pm+bounces-32934-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 53622B3296C
	for <lists+linux-pm@lfdr.de>; Sat, 23 Aug 2025 16:54:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 243955879D1
	for <lists+linux-pm@lfdr.de>; Sat, 23 Aug 2025 14:54:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FEC52E54AD;
	Sat, 23 Aug 2025 14:54:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kroah.com header.i=@kroah.com header.b="BmCLD8y7";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="FVRPp+dz"
X-Original-To: linux-pm@vger.kernel.org
Received: from flow-a4-smtp.messagingengine.com (flow-a4-smtp.messagingengine.com [103.168.172.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C96721E412A;
	Sat, 23 Aug 2025 14:54:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.139
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755960854; cv=none; b=Amr2s1un6TG03bvCMUc2bUhCSfWyb1m3wsk4riMFqyJUbLaU3A1XmjP9NCgKqNxTpN8/RtGMDXkWb4QsdrZ7IU+Jr0o9Ww5Ya2zX4qQvmwNkVmLJOdg2yp2e7IpSzWwdTaNOQJLi5MYEyBjme6Qc2OAgZ0Tq7Yu+T/Q7n0/hlWs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755960854; c=relaxed/simple;
	bh=Kxa1NZwbKhCZohnVX1PISuwQjBY6U8j916V5dM0MJP8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oPR4Swxt84ez9YMf8LEirxt4QVhw9Rp1St2Ht13dmwxNxg0w8jfQuLdJ4zrmdNngqMhfr1bwKAKXeSaru+6Vb0vD00AJEKP1jiISUZ5I/ypr3jmml256vn6EBnmSXnsew6zz5vMN6FLqc8Zg4M9F1drO6C0NnZh7ArbY8NQUCws=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kroah.com; spf=pass smtp.mailfrom=kroah.com; dkim=pass (2048-bit key) header.d=kroah.com header.i=@kroah.com header.b=BmCLD8y7; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=FVRPp+dz; arc=none smtp.client-ip=103.168.172.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kroah.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kroah.com
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailflow.phl.internal (Postfix) with ESMTP id AB79913802D6;
	Sat, 23 Aug 2025 10:54:09 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-05.internal (MEProxy); Sat, 23 Aug 2025 10:54:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kroah.com; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1755960849;
	 x=1755968049; bh=3yi6INSvOqzxqw231irPJUhbCwMHIzIAaoGR+X1dKNs=; b=
	BmCLD8y71j+UbqoWW4hcXtBuU5pFpA0qMDRcQGhtZOi46M0GDAgZe+rrVaYvt7qQ
	cVTJK64aqT3mOR83rtQ3PHpwveXK0md+NIpLK4ckItGirBrFBAjv9oZhETFj57k7
	iN3xtO6qEBupdjFLXKhxWDkY1YJSI4iFqTG7b8KNy6Lr2M9nZhnHfdf/bAJEPiAl
	al/IyvyeHkHx0AaWkeLkQm7lvKSaw6yJU91S/wfUAvaJeep5az1ofNwj2N5NUCP2
	1WFgro/HdJbsrvDRUm7ZIL8Qze5puXpHrdDFsgPWVYdokvUqIxh+CH/otkViOEpa
	JbODgj2vbOp5lFt+4aNaag==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1755960849; x=
	1755968049; bh=3yi6INSvOqzxqw231irPJUhbCwMHIzIAaoGR+X1dKNs=; b=F
	VRPp+dzXSDdGJ1LGM4ewziwMIDAkYKV83RsGrIbyMyQcjb4hWMfnH9KBhIVjRNsj
	WHTosnL7H7Yc9JeG2cSkrbkEuN5tFfC4ctjd8u/VUG10EpF2HJtUZ2/WzJoEADxo
	8Lx9FWR/h46hOdd4PUhhxz7R0OTvBG1tEqxlMzNGDUAk6pEC1sGpYbUaI6k/bDuJ
	TJvoJ6HQ7q0G5VuNXLhQrxI/FLbSDa93CsaRy3gYMPTCK5v/kjObB6tQ+wHOjd89
	afUd/eDB90oVUC5t1kfiwxPup6zD77IwNyoseGT3BOn1QvqmRTLJ5k1+tnKyUZVd
	/2eFpxvVEH0UO/F4KRbhw==
X-ME-Sender: <xms:ENapaDWIwvlh4PhNvVu74MgJlpkh7ejfKB-kQupiBcDVyFJ1I1gyYw>
    <xme:ENapaPGB0Qt09T3jrrTkuqEXXY4gUHBYPEV1PB04_ayFhexqtBvUyDSZEsg8UVwSH
    wmOjDZ4J_fHSg>
X-ME-Received: <xmr:ENapaH6AMNG-1Ldv5gFn0FjFiDKQLYa8psADYuXuPhB1Kt4RaEtdCOk778vCF6kyUrPGX0l4_G7KqR41r91d4NF5aMBvLOpr_nPcYw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdduieeileefucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkfhggtggugfgjsehtkeertddttdejnecuhfhrohhmpefirhgvghcu
    mffjuceoghhrvghgsehkrhhorghhrdgtohhmqeenucggtffrrghtthgvrhhnpeelkeehje
    ejieehjedvteehjeevkedugeeuiefgfedufefgfffhfeetueeikedufeenucffohhmrghi
    nhepkhgvrhhnvghlrdhorhhgnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpe
    hmrghilhhfrhhomhepghhrvghgsehkrhhorghhrdgtohhmpdhnsggprhgtphhtthhopedv
    vddpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepmhgrrhhkuhhsrdgvlhhfrhhinh
    hgseifvggsrdguvgdprhgtphhtthhopehhnhhssehgohhluggvlhhitghordgtohhmpdhr
    tghpthhtoheplhhinhhugidqphhmsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpth
    htohepkhgvrhhnvghlsehphihrrgdqhhgrnhguhhgvlhgurdgtohhmpdhrtghpthhtohep
    lhgvthhugidqkhgvrhhnvghlsehophgvnhhphhhovghnuhigrdhorhhgpdhrtghpthhtoh
    epjhgvrhhrhidrlhhvsegrgihishdrtghomhdprhgtphhtthhopehsrhgvsehkvghrnhgv
    lhdrohhrghdprhgtphhtthhopehsthgrsghlvgesvhhgvghrrdhkvghrnhgvlhdrohhrgh
    dprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhr
    gh
X-ME-Proxy: <xmx:ENapaBKGOit7tLgucsETsXhdepe-u6bOQfQkqxRtP9dhmu-fu6kkXw>
    <xmx:ENapaCA1SDNPDp_-ketPuuiscFBrypT3UU_g-uGTPHiDFCLOB6PLFg>
    <xmx:ENapaHRvJcfbUA2MuSTn6m13RfjBjlmJPhIWSNZCAsIhJCDV07Ac3A>
    <xmx:ENapaEd8pdA2eTOLh9JE029MCQI9U5T-IWZXT_mMWLxbP3p-DsnXng>
    <xmx:EdapaJ0A2F_L_oZy0ai7mjIu4DpQZpzEhJ2xW30_XEB400s7wt-yta1o>
Feedback-ID: i787e41f1:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 23 Aug 2025 10:54:08 -0400 (EDT)
Date: Sat, 23 Aug 2025 16:54:05 +0200
From: Greg KH <greg@kroah.com>
To: Markus Elfring <Markus.Elfring@web.de>
Cc: "H. Nikolaus Schaller" <hns@goldelico.com>, linux-pm@vger.kernel.org,
	kernel@pyra-handheld.com, letux-kernel@openphoenux.org,
	Jerry Lv <Jerry.Lv@axis.com>, Sebastian Reichel <sre@kernel.org>,
	stable@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
	Andreas Kemnade <andreas@kemnade.info>,
	Pali =?iso-8859-1?Q?Roh=E1r?= <pali@kernel.org>
Subject: Re: [PATCH v2 1/2] power: supply: bq27xxx: fix error return in case
 of no bq27000 hdq battery
Message-ID: <2025082300-resurrect-pennant-ab25@gregkh>
References: <692f79eb6fd541adb397038ea6e750d4de2deddf.1755945297.git.hns@goldelico.com>
 <cac66cc0-c5f1-4bfe-ac43-5ece4a47cf15@web.de>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cac66cc0-c5f1-4bfe-ac43-5ece4a47cf15@web.de>

On Sat, Aug 23, 2025 at 04:46:46PM +0200, Markus Elfring wrote:
> …
> > So we change the detection of missing bq27000 battery to simply set
> …
> 
> See also:
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Documentation/process/submitting-patches.rst?h=v6.17-rc2#n94
> 
> Regards,
> Markus
> 


Hi,

This is the semi-friendly patch-bot of Greg Kroah-Hartman.

Markus, you seem to have sent a nonsensical or otherwise pointless
review comment to a patch submission on a Linux kernel developer mailing
list.  I strongly suggest that you not do this anymore.  Please do not
bother developers who are actively working to produce patches and
features with comments that, in the end, are a waste of time.

Patch submitter, please ignore Markus's suggestion; you do not need to
follow it at all.  The person/bot/AI that sent it is being ignored by
almost all Linux kernel maintainers for having a persistent pattern of
behavior of producing distracting and pointless commentary, and
inability to adapt to feedback.  Please feel free to also ignore emails
from them.

thanks,

greg k-h's patch email bot

