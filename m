Return-Path: <linux-pm+bounces-14568-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 858C697EA7C
	for <lists+linux-pm@lfdr.de>; Mon, 23 Sep 2024 13:10:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 74A3C1C2141B
	for <lists+linux-pm@lfdr.de>; Mon, 23 Sep 2024 11:10:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2530196DA4;
	Mon, 23 Sep 2024 11:10:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ljones.dev header.i=@ljones.dev header.b="flpcoaES";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="V/Z6N1dn"
X-Original-To: linux-pm@vger.kernel.org
Received: from fhigh-a2-smtp.messagingengine.com (fhigh-a2-smtp.messagingengine.com [103.168.172.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74A0A7DA95
	for <linux-pm@vger.kernel.org>; Mon, 23 Sep 2024 11:10:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727089810; cv=none; b=fFYpq3xPw6NE4jKT5jMJ/noKJZP0mRFXt9JvneUTeOTZtXmONw5LsV+jkibtcndOEnT8lc0JbaBV08n+15fxYHdGaVWQSHPrci/N9+j5tDrdSHXJKzmd7RZL68O+pPy9b08JCk1ZGIVPPZspJmXlJ624F3/RN1r4agiAFy70hhA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727089810; c=relaxed/simple;
	bh=zxCkSgct4j67PIK1+PlESTLdCFeo3N/UL4hFJgfJCIg=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=ZzyuBbWRdecHI8Q33Swl5E1vw+aGwt+3/J+CG66t54bZQ3qGOIYqg0TseOCTxp//hO7oQMu+yxTV6UKy7IhJy3hX4SerYZn+mKfWAuhIS7JmA2gtFI7FuiB+AhnG1VI5sIgu0wDYrnU7V5MKKb63VmRASC6iSCJelTEoJJtN9hQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ljones.dev; spf=none smtp.mailfrom=ljones.dev; dkim=pass (2048-bit key) header.d=ljones.dev header.i=@ljones.dev header.b=flpcoaES; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=V/Z6N1dn; arc=none smtp.client-ip=103.168.172.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ljones.dev
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ljones.dev
Received: from phl-compute-08.internal (phl-compute-08.phl.internal [10.202.2.48])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 70AD911401DC;
	Mon, 23 Sep 2024 07:10:06 -0400 (EDT)
Received: from phl-imap-01 ([10.202.2.91])
  by phl-compute-08.internal (MEProxy); Mon, 23 Sep 2024 07:10:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ljones.dev; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1727089806;
	 x=1727176206; bh=FxLhnE3hvAdeEz4Shq8lNL9FJa+cXSDJbVFT2D8/WVI=; b=
	flpcoaESYiYjgCILLCKF8MbU8yqsoLJs+hT6l4b4YMGDgA65OFGzzIKvbEjNBnJT
	jnERNVscCfKDn3WGrQv/ypNGmlrsjV3zPoYBS9LRadZrpiIE4sheR/SNOyYkIKAV
	LSddqxEAIiVfnJo1p9ADubkiQGSLQUb29xGT7oNZ3th42gZhblq8FX5x5FLEEa7+
	PmF1Iw3j3bMvlLjIIC/JO7ymsKdwO5IMkJrTAHf8QiTwSdW0qElCnRvTSrv6/m3N
	xP55P1i1MhoaDRt9ZDnmd6ZFeUfdFg54BFaKXLdk5OHU9PFmrVrIsNqGLfwwpvCs
	/rrov/YEpoMLdVgJlfZLEQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1727089806; x=
	1727176206; bh=FxLhnE3hvAdeEz4Shq8lNL9FJa+cXSDJbVFT2D8/WVI=; b=V
	/Z6N1dnqjBIOIsjgiTyzla3S6ZK4388CujfYiwrrC8gLI+qiktdBUMVzOpBmi5Lw
	TAammLoOei8MdHhNNvO+iXt2/qPMlMKI9LxbkQbKUl/0DkfuS1wXTI5T7XbOMsb5
	NLw6L2Ewz53sAOucqqvHkvOvzuNzSjAR193EQKZincW6/MrodU106KZS8sc6V+ps
	/nARR23VbRcvB/wLZYOpHXKsFBflNDCWhluLaJUWoxDVqwLJVLEmMavXLXH7OcCu
	dVlt9wqzqrKkdAGeL2k7ILxzqyj0Rw+i8DgXyJAUIroQ5g7NTOLU3mdLpn22/Df9
	hOFCuKzM1MGw9trqEuEOQ==
X-ME-Sender: <xms:jUzxZobBNo3iOKRIbL7ozRJbJWnwvBnHfMX8B7cIY2oPC3qWPLMkDA>
    <xme:jUzxZjbmrDWbC1HKE6IozShMMpLd1adoLzoARzprX3LTRi7GWEt89hi6HBJlf7p2r
    FYZlj6zS5l56prQSwk>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrudelledgfeekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepofggfffhvfevkfgjfhfutgfgsehtjeertdertddt
    necuhfhrohhmpedfnfhukhgvucflohhnvghsfdcuoehluhhkvgeslhhjohhnvghsrdguvg
    hvqeenucggtffrrghtthgvrhhnpefgieffhedtgffhtedtiedutdefkedvjefgveehhfff
    vedthfejleegfeffkedvveenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmh
    grihhlfhhrohhmpehluhhkvgeslhhjohhnvghsrdguvghvpdhnsggprhgtphhtthhopeei
    pdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehmrghrihhordhlihhmohhntghivg
    hllhhosegrmhgurdgtohhmpdhrtghpthhtoheplhhkmhhlsegrnhhthhgvrghsrdguvghv
    pdhrtghpthhtohepsggvnhgrthhordguvghnihhsleeisehgmhgrihhlrdgtohhmpdhrtg
    hpthhtohepuggvrhgvkhhjohhhnhdrtghlrghrkhesghhmrghilhdrtghomhdprhgtphht
    thhopehmvgeskhihlhgvghhoshhpohgunhgvthhirdgthhdprhgtphhtthhopehlihhnuh
    igqdhpmhesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:jUzxZi_hmjakYuvzFMZTk-H1EPluC3Q0MD-thLbbhUSe_i6jwXzOfA>
    <xmx:jUzxZiqHeQQue9bHFOuNPfQY0bXQTmF5OWByTVi0AXa1VWav949vIg>
    <xmx:jUzxZjoNKlo8D5cqRtGg_3NvWLZVyyBF49rVkEUd0I7kKTmvwet5Xg>
    <xmx:jUzxZgRaKCqaeWkqYwavX9WVIkXObY9txkrb_Tj7wYg9CvJHeMF0BA>
    <xmx:jkzxZkm55azb9Mis4bqTsa64dkSV6wgagrjxi_ydd9fqCmqdSYaKEN_0>
Feedback-ID: i5ec1447f:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id B4A7B3360077; Mon, 23 Sep 2024 07:10:05 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Mon, 23 Sep 2024 23:09:45 +1200
From: "Luke Jones" <luke@ljones.dev>
To: "Antheas Kapenekakis" <lkml@antheas.dev>,
 "Derek J. Clark" <derekjohn.clark@gmail.com>
Cc: "Mario Limonciello" <mario.limonciello@amd.com>, me@kylegospodneti.ch,
 "Denis Benato" <benato.denis96@gmail.com>, linux-pm@vger.kernel.org
Message-Id: <b43f9654-4dd7-4f3c-95b5-575473c3bcc1@app.fastmail.com>
In-Reply-To: 
 <CAGwozwHmS-XjhzYayNvT07vesw4eOBh+ZjWi_NDa4xsOangYDQ@mail.gmail.com>
References: 
 <CAGwozwHqHbHNi53T87m36-OZ8suCEo1wgJ9fPPgPdcLnt_+S4g@mail.gmail.com>
 <20240923013657.7464-1-derekjohn.clark@gmail.com>
 <CAGwozwHmS-XjhzYayNvT07vesw4eOBh+ZjWi_NDa4xsOangYDQ@mail.gmail.com>
Subject: Re: [PATCH v2 0/5] acpi/x86: s2idle: move Display off/on calls outside suspend
 (fixes ROG Ally suspend)
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Mon, 23 Sep 2024, at 5:57 PM, Antheas Kapenekakis wrote:
> Hi Derek,
> 
> > I'm going to be somewhat brief here as I don't like repeating myself, you are
> > working from incomplete information and from that you are inferring incorrect
> > assertions. Due to NDA the full slate of information that would clarify this
> > cannot be released here, but I will be clear: I am not sharing my opinion, I
> > am stating facts. What you have described here is a missinterpretation of the
> > symptoms and is not correct. The _DSM call is not relevant to the proper fix,
> > the sequencing you observe is not applicable to Linux, and the sensitivity of
> > the controller is another symptom of the Windows quirk behaving badly in Linux.
> > Furthermore, the RGB "flourish" as you call it works as intended with the new
> > firmware and no kernel changes required.
> 
> Only thing I am seeing here is a bit of heresay. Please get in touch

What Derek is saying here is correct because it is based on data I have shared with him for testing to help ASUS engineers fix the root issue in firmware.

> with Asus, cross your t's and dot your i's, and share what you found
> with the rest of the class.

I have direct contact with engineers in ASUS and I am under NDA (extended to a few others) so certain information can not be shared. The proper fix for Linux is done in the MCU firmware - this is something ASUS engineers who work on the Ally devices have done with our aid in pinpointing the exact cause.

> I am in no rush to see this merge, and as all gaming distributions
> carry custom kernels that update on a weekly cadence and 90% of users
> are on those kernels with the rest being able to figure it out, there
> is no practical reason for this to merge quickly. Ubuntu (+variant)
> users will get this fix after they've thrown their ally away anyway.

Lucky for Ubuntu and variant users, they can simply update their firmware and have suspend/resume/reboot all work fine.

> > What I can provide is information on a test we did that should hopefully
> > elucidate the issue more clearly for you. We included a patch that allowed us
> > to alter the delay in asus-wmi on the fly by writing to an attribute in sysfs.
> > In addition, we pushed the _DSM calls as early as possible in the suspend
> > sequence. We were unable to find a timing for this that would work consistently
> > on different configurations. The same issue exists in your patch set and the
> > testing bears this out with Denis still getting spurious wakes when using it.
> > The problem with your approach is that you aren't listening to us despite our
> > much broader understanding of the issue at hand. If this worked we would have
> > submitted it ourselves nearly three weeks ago.
> 
> Here you assume I did not do the same. Yes, I did. The asus-wmi quirk
> is subject to racing conditions that mean it will never work correctly
> (well; without newer firmware maybe perhaps). This series is not, as
> the calls happen before suspend starts.
> 
> Yes, my V1 of the patch did not include a delay at all. Since the
> original Ally is XInput, one of the MCUs was left on, which caused
> what Denis experienced. It also triggered a restart of the MCU on the
> Ally X after resume. V2 fixes this restart on the Ally X and makes it
> behave completely properly.

With the fixed firmware no delay is required anywhere, no restructuring of suspend is required, no more trying to figure out an optimal ordering is required.

> In fact, after being included in bazzite-testing yesterday, my Ally X
> unit went on a deep slumber tonight with powersave on, and then woke
> up today beautifully, having only lost 1% of battery.

The Ally X is much less sensitive to things than the Ally 1 is and invariably when we thought we'd found a fix, someone with a different kernel config, distro, and compiler (maybe even with LTO) would change the timing of things just enough. We tried pretty much everything you seem to be trying.

> It is not clear if the issue still exists on the original Ally, I
> could not get a clear signal from Denis but do not worry, one of our
> contributors is on it.

Denis was very clear I thought, perhaps you misread? Thank you for your thorough testing Denis.

> > *Our solution doesn't require any kernel changes for newer firmware*, as I
> > already stated the solution from ASUS fixes the root cause of the problem. Your
> > attempt at a solution attempts to outrace the symptoms of it. Please don't
> > mischaracterize my statements.
> 
> I would hope that is not true and your solution completely removes the
> quirk from asus-wmi for newer firmware, as it prolongs the suspend and
> resume sequences noticeably. However, given my and Denis' limited

Yes that excessive delay is awful. It was a misguided attempt to race or delay things much like you are doing right now.

With the release of the new fixed firmware for the MCU imminent, this will be removed and all users should be strongly encouraged to update their firmware to the fixed version from ASUS.

> testing, I doubt the controller is able to suspend quickly enough even
> with new firmware (you can see the RGB cut before it's able to fade).

It isn't about trying to suspend the thing "quickly enough". And I'm hoping that with your analysing of that statement it provides you some insight as to why it's a bad assumption to make and why things are always going to be at risk of breaking with async linux suspend when you get another device like the Ally. At best the issue may be masked only to have seemingly random fails that people can't reproduce easily.

> In any case, this patch series is not expected to conflict with Asus'
> newer firmware and is in fact complementary with it. Both fix the same
> issue in a different way, which means our users will have a great
> experience, squared. This series also greatly improves resume behavior
> on the Ally, which, let me tell you, is blazing fast now.

You are correct in that it won't conflict. That is because the firmware that ASUS engineers who worked with us to fix, fixes the root cause of the issue regardless of the USB state at suspend time - which fully removes the need to make changes to core suspend code, especially in regards to the Ally devices.

It is perhaps best if I refer to what Denis and Derek told you about modern standby: focus on background downloads and proceed in that direction - the firmware really does fix the suspend/resume/reboot issues. You can also drop the asus-wmi patch (in submissions) as that will get dealt with soon enough.

Sincerely,
Luke.

