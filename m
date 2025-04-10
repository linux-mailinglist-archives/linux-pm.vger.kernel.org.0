Return-Path: <linux-pm+bounces-25094-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 80B07A83FA8
	for <lists+linux-pm@lfdr.de>; Thu, 10 Apr 2025 11:57:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6F3E58C065F
	for <lists+linux-pm@lfdr.de>; Thu, 10 Apr 2025 09:56:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2393026B094;
	Thu, 10 Apr 2025 09:55:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="W8Bx41AG"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9C8E26A1B7;
	Thu, 10 Apr 2025 09:55:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744278942; cv=none; b=ELCR8+iUh3KWz9kydFxvJn1kitQE24TQnmKDgZFNDkoJLQjMarjDRcJQusvqv3YX0Rod2aplFaDnpTnBam8u12f9aWFc23WtZjKZRQ/In7e38CLxbEm1FhdX3jDCenhUnCWKqf9PwMeev49yNT99EiVktday7uunKnVDI3kT2mg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744278942; c=relaxed/simple;
	bh=8EcGJQ3GTOpysp09gNVgiLkuakkbV/LHk6mYwlMi9fU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XEDQdO8hvVWOZP/DFPOeTd1Aj8we6+wD8fwjcWf1QE3l2g4KXwOr+/dEyiES8WY3+2SlrJxWNiguumgEBucf7cX2Lz3ZtCx5aMdud5QkZrNI5n3v6h+hF8JKfkCLEHjTrlc0P4k/7GixyyS5wGLdwKXm7xwId4cJV5SPDWLa+vI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=W8Bx41AG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 58C41C4CEDD;
	Thu, 10 Apr 2025 09:55:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744278941;
	bh=8EcGJQ3GTOpysp09gNVgiLkuakkbV/LHk6mYwlMi9fU=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=W8Bx41AG7OpVbPjErvAMogPWDSIBK/z8os5ohWUvkRE4ds1pTyI5N77noltX8qkor
	 UNhRtMPnyN7jWVB0nH3We6tE18tfb4tcNsFTaKoz5VMAMxUHxYVhp5o20QyselJCjN
	 a19Q+859e8NqWBY/XLMbh1pQK9FNumLGtwI0Q8zXWf0lDPwtvsIVpuY0t4suIGtcrK
	 kyrVDfHcYYiOjj+X9kMaOrOIE/+ieRkHt2WwpGYGTlK4Ii3UmM6sdxi1C/yIxqNi8Z
	 53UV3vGbDt63kblo1uxnSROmr5pGGoGQ9is4TgcifFaOrWtgm6m4I89Pxz1046lIme
	 twCnK1xi5Qinw==
Received: by mail-oa1-f51.google.com with SMTP id 586e51a60fabf-2d060c62b61so346356fac.0;
        Thu, 10 Apr 2025 02:55:41 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCU1c+5ceZwvQuqPVf2LZoinfcbVN4EyIwiATzF32akjgg1C9xPmv2rcFCZeSqa/ymtKKoIULZY77gU=@vger.kernel.org, AJvYcCUjA1V2ddvVBoMVjqTIuukqdkSYHPe0Fln92546/Ih/Avve02gmxQRlqMKTqarwhV7iBcxGjlB6dNM=@vger.kernel.org, AJvYcCXRZg7iACP53MmFdmcJgeR4zRny7pbzHzoh3E4r8wOF8Ge2R1U+ZFLWJA/4q/wuzYtabUwvVedqbFgFK0vr@vger.kernel.org
X-Gm-Message-State: AOJu0Yz5PzhkehK8UhN4eZ3q9fIrB2WDcBNLGzIOClsVHLyAOB6SQnaA
	kSm66KSftAQxm2Nlm2TopFrU4F9j4mAPdMelyMeftI/QzXfXRC+jBPX3/iPm4yuCCHUkjKWMWg6
	IlxMcE3nPP+D1z8UO0sNOwmEwXFA=
X-Google-Smtp-Source: AGHT+IEmexViKlgkEffDpeC2raagEKm0bOhC4vVnIgwdvz8rjn2fVXxuMs9t01QxOTMnRtcIjs9aKVMkp0Kikyx9UK4=
X-Received: by 2002:a05:6871:20c1:b0:2c8:3620:f595 with SMTP id
 586e51a60fabf-2d0b35741c2mr1284587fac.6.1744278940407; Thu, 10 Apr 2025
 02:55:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250326-cross-lock-dep-v1-0-3199e49e8652@bootlin.com>
 <20250326-cross-lock-dep-v1-1-3199e49e8652@bootlin.com> <CAJZ5v0gFER-nbWpZK6FMDJCXA+iPQUm5DZDAiRY3ahugR2MM=g@mail.gmail.com>
 <874izdlblm.fsf@bootlin.com> <CAJZ5v0irZj7ttvUqb-iENQS6BX+KTGuTqyVh0DxgKmsoKrBcbA@mail.gmail.com>
 <875xjccuyx.fsf@bootlin.com>
In-Reply-To: <875xjccuyx.fsf@bootlin.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Thu, 10 Apr 2025 11:55:29 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0jeMqmeZiVQ_EbZrR0XTMfHwg4fEdVmz1p9S-R-VOCVZw@mail.gmail.com>
X-Gm-Features: ATxdqUEcZnNYsDm7i-WvsX8bhd5c7nQEp9AuWveDK-FjQNDtrXgZyFSE2rDz40g
Message-ID: <CAJZ5v0jeMqmeZiVQ_EbZrR0XTMfHwg4fEdVmz1p9S-R-VOCVZw@mail.gmail.com>
Subject: Re: [PATCH RFC 01/10] PM: runtime: Add helpers to resume consumers
To: Miquel Raynal <miquel.raynal@bootlin.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Pavel Machek <pavel@ucw.cz>, Len Brown <len.brown@intel.com>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Danilo Krummrich <dakr@kernel.org>, 
	Michael Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@kernel.org>, 
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>, linux-pm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org, 
	Chen-Yu Tsai <wenst@chromium.org>, Lucas Stach <l.stach@pengutronix.de>, 
	Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Marek Vasut <marex@denx.de>, 
	Ulf Hansson <ulf.hansson@linaro.org>, Kevin Hilman <khilman@kernel.org>, 
	Fabio Estevam <festevam@denx.de>, Jacky Bai <ping.bai@nxp.com>, Peng Fan <peng.fan@nxp.com>, 
	Shawn Guo <shawnguo@kernel.org>, Shengjiu Wang <shengjiu.wang@nxp.com>, linux-imx@nxp.com, 
	Ian Ray <ian.ray@gehealthcare.com>, =?UTF-8?Q?Herv=C3=A9_Codina?= <herve.codina@bootlin.com>, 
	Luca Ceresoli <luca.ceresoli@bootlin.com>, Saravana Kannan <saravanak@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Thu, Apr 10, 2025 at 9:54=E2=80=AFAM Miquel Raynal <miquel.raynal@bootli=
n.com> wrote:
>
> Hi Rafael,
>
> Thanks for taking the time to read all that.
>
> >> After the LPC discussion with Steven, I also discussed with Saravana
> >> about this and he pointed that since we were using fw_devlink=3Drpm by
> >> default now, all providers -including clock controllers of course- wou=
ld
> >> already be runtime resumed the first time we would make a
> >> runtime_resume(clk), and thus all the nested calls were no longer
> >> needed. This native solution was already addressing point #1 above (an=
d
> >> partially point #3) and all I had to do was to make a similar function
> >> for point #2.
> >
> > So this depends on DT being used and fw_devlink=3Drpm being used,
> > doesn't it?
>
> DT, not really. fw_devlink=3Drpm however, yes.

Which means DT because fw_devlink=3Drpm is DT-specific.  At least it is
not used on systems where ACPI is the firmware interface.

> > You cannot really assume in general that there will be device links
> > between parents and children.
>
> But if runtime PM already mandates fw_devlink to be the information
> source (which, IIRC is the case since fw_devlink=3Drpm), then why wouldn'=
t
> this approach work? For sure there may be holes in fw_devlink, but
> what is the reason for it if we cannot use it?

Well, see above.

> In other words, are you suggesting that this approach is invalid? If yes
> could you elaborate a bit? For this approach to work we do not need all
> the parenting to be perfectly described, just relationships between
> clock consumers and providers, which are in general rather basic.

So you know which devices are parents and children without fw_devlink
and this information can be used readily on all systems AFAICS.

IIUC, the overall approach is to resume the entire hierarchy before
making changes that may deadlock and I think that this is a good idea
in general.

However, you need to do it in a way that's usable on all systems and
when you walk the hierarchy from top to bottom, you need to do it
recursively I think because resuming a device doesn't cause its
children or consumers to resume.

