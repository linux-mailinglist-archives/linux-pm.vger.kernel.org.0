Return-Path: <linux-pm+bounces-24575-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B0536A746C0
	for <lists+linux-pm@lfdr.de>; Fri, 28 Mar 2025 10:59:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 690581B603CC
	for <lists+linux-pm@lfdr.de>; Fri, 28 Mar 2025 09:59:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9E60214A6C;
	Fri, 28 Mar 2025 09:59:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="CyNQntcA"
X-Original-To: linux-pm@vger.kernel.org
Received: from relay9-d.mail.gandi.net (relay9-d.mail.gandi.net [217.70.183.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1937E42A97;
	Fri, 28 Mar 2025 09:59:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743155979; cv=none; b=HW8+vXFPzkGQ+LxuMgf8wrRv0MOAobU981t3pVes/FRu5Wh9y57k3k2IYnmNJU1CNzvLnz3eG/ImcX4E+KpSHdSynyvZpyrufunxQ4ZYZOoqdBqeLIBB6WEp5K+X1qHZapqqxuMSed2Xzyj2y4pT3BMt9BPZZrjVa/X5tmcaHjw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743155979; c=relaxed/simple;
	bh=hNNA/d/v3lN7oYWEV0sFTmuJdeaOkQ/iC+Hv1NB56PI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=l9cqXMvu5coiOPcLV0djzIS0d5RJZ6wuT+J5sy5zpL+SwISeELBvT+xpNvSVD39TEP03nFd8kFNJdS035CDaIG4HrIYay7c31v4YQcOkZ4BdLI2EmvIVtzaYwHJos4N3iPdund1gYBMXOk5SrEXOPW/M1tYkKAf8r1N2/xxtX/o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=CyNQntcA; arc=none smtp.client-ip=217.70.183.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id DF75D441FE;
	Fri, 28 Mar 2025 09:59:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1743155975;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ZzPCpChQK+Tk3U5esg1UPETkUAwKsnZ9Cr/dBBfydlo=;
	b=CyNQntcAaPHSO6/SH4mvZIv2j+Y0AZCWZ4upqISbI94iBXhOM6/N7ZPqagBLP9011ua/Bu
	HTfuhW1nWTzjiBwhxYTsXo+5tRT7+Hwk8RhwPDqim0i9bdh4/A96CUHU9fGFmawL4da1ZJ
	91vS+vnD6cc79baEy0NbSDO61LLP5bBbTDsyhKmKeebRBEx7cBPw+E71ge0zgqqWUButef
	K4SCrhavecisuxkOmPDsh0sk3XsdPL71P8id3WRYodKfU+wW4x4mValg4JyEh/r65czOTq
	DlCN4vMTl4o13Y27JPV4W0wJlUjuVoW1QGXHX0YijQ9C+p3r5k7WbntjY+mG0g==
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Pavel Machek <pavel@ucw.cz>,  Len Brown <len.brown@intel.com>,  Greg
 Kroah-Hartman <gregkh@linuxfoundation.org>,  Danilo Krummrich
 <dakr@kernel.org>,  Michael Turquette <mturquette@baylibre.com>,  Stephen
 Boyd <sboyd@kernel.org>,  Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
  linux-pm@vger.kernel.org,  linux-kernel@vger.kernel.org,
  linux-clk@vger.kernel.org,  Chen-Yu Tsai <wenst@chromium.org>,  Lucas
 Stach <l.stach@pengutronix.de>,  Laurent Pinchart
 <laurent.pinchart@ideasonboard.com>,  Marek Vasut <marex@denx.de>,  Ulf
 Hansson <ulf.hansson@linaro.org>,  Kevin Hilman <khilman@kernel.org>,
  Fabio Estevam <festevam@denx.de>,  Jacky Bai <ping.bai@nxp.com>,  Peng
 Fan <peng.fan@nxp.com>,  Shawn Guo <shawnguo@kernel.org>,  Shengjiu Wang
 <shengjiu.wang@nxp.com>,  linux-imx@nxp.com,  Ian Ray
 <ian.ray@gehealthcare.com>,  =?utf-8?Q?Herv=C3=A9?= Codina
 <herve.codina@bootlin.com>,
  Luca Ceresoli <luca.ceresoli@bootlin.com>,  Saravana Kannan
 <saravanak@google.com>
Subject: Re: [PATCH RFC 01/10] PM: runtime: Add helpers to resume consumers
In-Reply-To: <CAJZ5v0gFER-nbWpZK6FMDJCXA+iPQUm5DZDAiRY3ahugR2MM=g@mail.gmail.com>
	(Rafael J. Wysocki's message of "Wed, 26 Mar 2025 20:18:03 +0100")
References: <20250326-cross-lock-dep-v1-0-3199e49e8652@bootlin.com>
	<20250326-cross-lock-dep-v1-1-3199e49e8652@bootlin.com>
	<CAJZ5v0gFER-nbWpZK6FMDJCXA+iPQUm5DZDAiRY3ahugR2MM=g@mail.gmail.com>
User-Agent: mu4e 1.12.7; emacs 29.4
Date: Fri, 28 Mar 2025 10:59:33 +0100
Message-ID: <874izdlblm.fsf@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddujedtleelucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuifetpfffkfdpucggtfgfnhhsuhgsshgtrhhisggvnecuuegrihhlohhuthemuceftddunecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvfevufgjfhgffffkgggtgfesthhqredttderjeenucfhrhhomhepofhiqhhuvghlucftrgihnhgrlhcuoehmihhquhgvlhdrrhgrhihnrghlsegsohhothhlihhnrdgtohhmqeenucggtffrrghtthgvrhhnpeejgeeftdefledvieegvdejlefgleegjefhgfeuleevgfdtjeehudffhedvheegueenucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecukfhppeeltddrkeelrdduieefrdduvdejnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepledtrdekledrudeifedruddvjedphhgvlhhopehlohgtrghlhhhoshhtpdhmrghilhhfrhhomhepmhhiqhhuvghlrdhrrgihnhgrlhessghoohhtlhhinhdrtghomhdpnhgspghrtghpthhtohepvdejpdhrtghpthhtoheprhgrfhgrvghlsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehprghvvghlsehutgifrdgtiidprhgtphhtthhopehlvghnrdgsrhhofihnsehinhhtvghlrdgtohhmpdhrtghpthhtohepghhrvghgkhhhsehlihhnuhigfhhouhhnuggrthhiohhnrdhorhhgpdhrtghpthhtohepuggrkhhrsehkvghrnhgvlhdrohhrghdpr
 hgtphhtthhopehmthhurhhquhgvthhtvgessggrhihlihgsrhgvrdgtohhmpdhrtghpthhtohepshgsohihugeskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepthhhohhmrghsrdhpvghtrgiiiihonhhisegsohhothhlihhnrdgtohhm
X-GND-Sasl: miquel.raynal@bootlin.com

Hello Rafael,

>> The runtime PM core currently allows to runtime resume/suspend a device,
>> or its suppliers.
>>
>> Let's make it also possible to runtime resume/suspend consumers.
>>
>> Consumers and suppliers are seen here through the description made by
>> device_links.
>
> It would be good to explain why all of this is needed.
>
> I gather that it is used for resolving some synchronization issues in
> the clk framework, but neither the cover letter nor this changelog
> explains how it is used.

The explanation is quite long, there have been already 3 full threads
from people attempting to fix a problem that resides in the clock
subsystem (but that may also be probably problematic in others, just
uncovered so far). I don't know if you took the time to read the cover
letter:
https://lore.kernel.org/linux-clk/20250326-cross-lock-dep-v1-0-3199e49e8652=
@bootlin.com/
It tries to explain the problem and the approach to fix this problem,
but let me try to give a runtime PM focused view of it here.

[Problem]

We do have an ABBA locking situation between clk and any other subsystem
that might be in use during runtime_resume() operations, provided that
these subsystems also make clk calls at some point. The usual suspect
here are power domains.

There are different approaches that can be taken but the one that felt
the most promising when we discussed it during last LPC (and also the
one that was partially implemented in the clk subsystem already for a
tiny portion of it) is the rule that "subsystem locks should not be kept
acquired while calling in some other subsystems".

Typically in the clk subsystem the logic is:

func() {
        mutex_lock(clk);
        runtime_resume(clk);
        ...
}

Whereas what would definitely work without locking issues is the
opposite:

func() {
        runtime_resume(clk);
        mutex_lock(clk);
        ...
}

Of course life is not so simple, and the clock core is highly
recursive, which means inverting the two calls like I hinted above
simply does not work as we go deeper in the subcalls. As a result, we
need to runtime resume *all* the relevant clocks in advance, before
calling functions recursively (the lock itself is allowed to re-enter
and is not blocking in this case).

I followed all possible paths in the clock subsystem and identified 3
main categories. The list of clocks we need to runtime resume in advance
can either be:
1- the parent clocks
2- the child clocks
3- the parent and child clocks
4- all the clocks (typically for debugfs/sysfs purposes).

[Solution 1: discarded]

The first approach to do that was do to some guessing based on the clock
tree topology. Unfortunately this approach does not stand because it is
virtually unbounded. In order to know the clock topology we must acquire
the clock main lock. In order to runtime resume we must release it. As a
result, this logic is virtually unbounded (even though in practice we
would converge at some point). So this approach was discarded by Steven.

[Solution 2: this proposal]

After the LPC discussion with Steven, I also discussed with Saravana
about this and he pointed that since we were using fw_devlink=3Drpm by
default now, all providers -including clock controllers of course- would
already be runtime resumed the first time we would make a
runtime_resume(clk), and thus all the nested calls were no longer
needed. This native solution was already addressing point #1 above (and
partially point #3) and all I had to do was to make a similar function
for point #2.

And here we are, trying to resume all consumers (from a device link
perspective) which include, but is not limited to, consumer clocks.

I hope this explanation will help understanding this patch and why it is
needed for this series. As stated in the cover letter, I've tried to
keep the changes here to their minimum. Maybe there are other/better
ways to do that and we can discuss them. My priority is however to get
this possible ABBA deadlock situation sorted out.

I can further expand the commit log with these details if you want.

Thanks,
Miqu=C3=A8l

