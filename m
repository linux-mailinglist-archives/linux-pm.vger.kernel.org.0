Return-Path: <linux-pm+bounces-25086-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 29189A83BCA
	for <lists+linux-pm@lfdr.de>; Thu, 10 Apr 2025 09:55:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1B3DB16ACCB
	for <lists+linux-pm@lfdr.de>; Thu, 10 Apr 2025 07:54:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62DE21E230E;
	Thu, 10 Apr 2025 07:54:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="lPD8fPdh"
X-Original-To: linux-pm@vger.kernel.org
Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net [217.70.183.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A9431B85F8;
	Thu, 10 Apr 2025 07:54:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744271678; cv=none; b=iWMv9a0tnFPpRV2hfIxQSQZjpim23qU+HD9U7h5aGoN6JiFtA2Uk3T2zhBQSox5htryjpHiisnDrRxbBPQGv0Au2cONyN/5xihdXkF4d3/Oiuih9xabfdlsXXgOohVRtNs74Tobnt15qpopnZmtNvd045ZERfF3pathuP/UARko=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744271678; c=relaxed/simple;
	bh=ZIf2LBI9LMMVbcsNUcHJc26fy6z7q0wIldUNiVXvb2M=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=KSeaziU20sBUpRgm6uodmH/R1YuYX/bf4JD4XHkSbic0dHSCsZkMbsvKtkRkbFNhTMjWDNbYYlTpoEfEjEhPMp27gimZ7EcDjKN3371p3Acn+MRLMyjVAr4YPUt6IkKHVZ5J+jELMD4IxDWMjE5viW63BE++npLhMFFpo9GcqMI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=lPD8fPdh; arc=none smtp.client-ip=217.70.183.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id D902044365;
	Thu, 10 Apr 2025 07:54:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1744271673;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ZIf2LBI9LMMVbcsNUcHJc26fy6z7q0wIldUNiVXvb2M=;
	b=lPD8fPdhQZD9qE/YgTYf8FfFhxu7P56+YtbCxm4gsFXE5E6AdIUTS2d9fFRrLgzyhxdC8/
	vG/DO6Anp/ffLGmZjeGlSdyPWJ02zZbTJOlOvzCYI1zP+9dqlhoK8ftN4Az95hOuHgnO+/
	SSvNnJZPET/UCofxVwhwtMg1xT63cnOz5tnhQV4MRwurrh7MOg1AWOaV00zqhcNOowLx+t
	wQK0q2gPORz9r9QDbOVQJpoQ10zIkSdsx0sOaTIIinUFR1+S4l3dqINFhbwWqR9GOmqlJl
	GxrBU4SaxxKz+8JAaBE5xYiZFj4m6AwOVaEoQWqqAlD0w46zE7UaoubQ4fClXw==
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
In-Reply-To: <CAJZ5v0irZj7ttvUqb-iENQS6BX+KTGuTqyVh0DxgKmsoKrBcbA@mail.gmail.com>
	(Rafael J. Wysocki's message of "Wed, 9 Apr 2025 19:55:19 +0200")
References: <20250326-cross-lock-dep-v1-0-3199e49e8652@bootlin.com>
	<20250326-cross-lock-dep-v1-1-3199e49e8652@bootlin.com>
	<CAJZ5v0gFER-nbWpZK6FMDJCXA+iPQUm5DZDAiRY3ahugR2MM=g@mail.gmail.com>
	<874izdlblm.fsf@bootlin.com>
	<CAJZ5v0irZj7ttvUqb-iENQS6BX+KTGuTqyVh0DxgKmsoKrBcbA@mail.gmail.com>
User-Agent: mu4e 1.12.7; emacs 29.4
Date: Thu, 10 Apr 2025 09:54:30 +0200
Message-ID: <875xjccuyx.fsf@bootlin.com>
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
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvtdekfeegucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuifetpfffkfdpucggtfgfnhhsuhgsshgtrhhisggvnecuuegrihhlohhuthemuceftddunecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvfevufgjfhgffffkgggtgfesthhqredttderjeenucfhrhhomhepofhiqhhuvghlucftrgihnhgrlhcuoehmihhquhgvlhdrrhgrhihnrghlsegsohhothhlihhnrdgtohhmqeenucggtffrrghtthgvrhhnpeffgefhjedtfeeigeduudekudejkedtiefhleelueeiueevheekvdeludehiedvfeenucfkphepvdgrtddumegtsgdtleemkedtgeehmeguudelrgemjeegudhfmeelfegrugemtggtieehmeejieejleenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpedvrgdtudemtggstdelmeektdegheemugdulegrmeejgedufhemleefrggumegttgeiheemjeeijeelpdhhvghloheplhhotggrlhhhohhsthdpmhgrihhlfhhrohhmpehmihhquhgvlhdrrhgrhihnrghlsegsohhothhlihhnrdgtohhmpdhnsggprhgtphhtthhopedvjedprhgtphhtthhopehrrghfrggvlheskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepphgrvhgvlhesuhgtfidrtgiipdhrtghpthhtoheplhgvnhdrsghrohifnhesihhnthgvlhdrtghomhdprhgtphhtthhopehgrhgvghhkhheslhhinhhugihfohhunhgur
 ghtihhonhdrohhrghdprhgtphhtthhopegurghkrheskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepmhhtuhhrqhhuvghtthgvsegsrgihlhhisghrvgdrtghomhdprhgtphhtthhopehssghohigusehkvghrnhgvlhdrohhrghdprhgtphhtthhopehthhhomhgrshdrphgvthgriiiiohhnihessghoohhtlhhinhdrtghomh
X-GND-Sasl: miquel.raynal@bootlin.com

Hi Rafael,

Thanks for taking the time to read all that.

>> After the LPC discussion with Steven, I also discussed with Saravana
>> about this and he pointed that since we were using fw_devlink=3Drpm by
>> default now, all providers -including clock controllers of course- would
>> already be runtime resumed the first time we would make a
>> runtime_resume(clk), and thus all the nested calls were no longer
>> needed. This native solution was already addressing point #1 above (and
>> partially point #3) and all I had to do was to make a similar function
>> for point #2.
>
> So this depends on DT being used and fw_devlink=3Drpm being used,
> doesn't it?

DT, not really. fw_devlink=3Drpm however, yes.

> You cannot really assume in general that there will be device links
> between parents and children.

But if runtime PM already mandates fw_devlink to be the information
source (which, IIRC is the case since fw_devlink=3Drpm), then why wouldn't
this approach work? For sure there may be holes in fw_devlink, but
what is the reason for it if we cannot use it?

In other words, are you suggesting that this approach is invalid? If yes
could you elaborate a bit? For this approach to work we do not need all
the parenting to be perfectly described, just relationships between
clock consumers and providers, which are in general rather basic.

Thanks,
Miqu=C3=A8l

