Return-Path: <linux-pm+bounces-17796-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F7FB9D30EF
	for <lists+linux-pm@lfdr.de>; Wed, 20 Nov 2024 00:32:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E15C1B215CF
	for <lists+linux-pm@lfdr.de>; Tue, 19 Nov 2024 23:32:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1FE11C4A3F;
	Tue, 19 Nov 2024 23:32:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hGUa1kFh"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 865EB13D279;
	Tue, 19 Nov 2024 23:32:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732059147; cv=none; b=keSkzUBtUB/m85jZTGKGYPNQ02sysxvb1BdhncWb8s6TFDhj1Zfrhbq1mtu/ev3gM94Rd3G8mQ94uvsgTQ0Vsr+Tp2/Wh0C/Fa3shm+AOIIl1qK1LKGK4+6JgMm6xUr+bKNO1DHxEE3HGMhmYmZKkF6fLNzIiEEAgzk6k4Qa/B0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732059147; c=relaxed/simple;
	bh=94Hb0WDDrKNkc+w9VJTwGaTkgRFYoIoCP3YBnwtZjrk=;
	h=Message-ID:Content-Type:MIME-Version:In-Reply-To:References:
	 Subject:From:Cc:To:Date; b=i3plZcy2MbUi8MtUlHdxS2JCeO5FxjNEm3sJqR4oUkOsbq3KCcqChuucMCiMu4NzsDONV301+w/so9mrHhgQsgsEeGm2f+Dwm+O4TTt6yZ7+zlfPybhOnYZsoEr3mW3/2Eu1Fnl9TC52TEUUTHXLZq0ZfNf2p6j6XX9MQAp8/9E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hGUa1kFh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0BF82C4CECF;
	Tue, 19 Nov 2024 23:32:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732059147;
	bh=94Hb0WDDrKNkc+w9VJTwGaTkgRFYoIoCP3YBnwtZjrk=;
	h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
	b=hGUa1kFhVXzkTKEg1Ga5Miuhv41iwOv61TToSaqrNeEDMeCOVpSlydRIoQVMF9JZO
	 JP1f9ZSldvGZvpLlUqwc/Yf/Y8k3k+dCry5fqcWxbpnDgf8KF1utPEgvdqz3vn/WNV
	 2aHyA4691zWEkXwDy6aB4e53KbAc/v9XEiQWOiXI1bGdzxEkEyCaZNjjcn4noczGmx
	 CmtsdaGBv61I+UpaHIKy/LvwOE1x6lQKfBncrAvOKXu97eDSiX+V3vnknW0E87pin5
	 FfB8bqdGtujOWDf2v8geGQs9bUp+InRv8/zYUPOcsAIY5aBe2xEZgXXqb/4XUXIrLK
	 Pds5H0vKzNUyA==
Message-ID: <f6f171aed953b5ff8080290b1cef9f80.sboyd@kernel.org>
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <14689f79-58fd-4be3-87ac-e56cba3deb26@linaro.org>
References: <20241028163403.522001-1-eugen.hristev@linaro.org> <bb5d855954d5ff8694a3978a9f87a9d2.sboyd@kernel.org> <6f14d8d7-7b9a-49e3-8aa8-5c99571a7104@linaro.org> <b587012e868f8936463c46915b8588c3.sboyd@kernel.org> <7b57ccc2-7060-4adf-b896-8992ec05125c@linaro.org> <e6637dcc85ca23efaf72af906f364328.sboyd@kernel.org> <14689f79-58fd-4be3-87ac-e56cba3deb26@linaro.org>
Subject: Re: [PATCH v2] soc: qcom: Rework BCM_TCS_CMD macro
From: Stephen Boyd <sboyd@kernel.org>
Cc: andersson@kernel.org, konradybcio@kernel.org, linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org, linux-pm@vger.kernel.org, djakov@kernel.org, mturquette@baylibre.com, evgreen@chromium.org
To: Eugen Hristev <eugen.hristev@linaro.org>, linux-arm-msm@vger.kernel.org
Date: Tue, 19 Nov 2024 15:32:24 -0800
User-Agent: alot/0.12.dev1+gaa8c22fdeedb

Quoting Eugen Hristev (2024-11-11 05:05:02)
>=20
>=20
> On 11/8/24 21:00, Stephen Boyd wrote:
> > Quoting Eugen Hristev (2024-10-30 01:28:14)
> >> On 10/30/24 02:40, Stephen Boyd wrote:
> >>>=20
> >>> If the rpmh-rsc code didn't use writel() or readl() I'd believe
> >>> that the data member is simply a u32 container. But those
> >>> writel() and readl() functions are doing a byte swap, which
> >>> seems to imply that the data member is a native CPU endian u32
> >>> that needs to be converted to little-endian. Sounds like
> >>> BCM_TCS_CMD() should just pack things into a u32 and we can
> >>> simply remove the cpu_to_l32() stuff in the macro?
> >>=20
> >> This review [1] from Evan Green on the original patch submission=20
> >> requested the use of cpu_to_le32
> >>=20
> >> So that's how it ended up there.
> >>=20
> >=20
> > Thanks. I still don't see why this can't just be treated as a u32
> > and then we have writel() take care of it for us.
>=20
> If the values are in the wrong endianness, e.g. 0xff11 instead of=20
> 0x11ff, the corresponding field would be filled up wrongly, even=20
> possibly writing unwanted bits. vote_x and vote_y have a mask of length=20
> 14, so there is one byte and another 6 more bits. If the endianness of=20
> the value is not correct, the one byte might end up written over the 6=20
> bits and 2 extra bits which are supposed to be for another field.
> In my example 0x11 should be in the first 6 bits and the 0xff in the=20
> next byte, but if the endianness of the cpu is different, we might write =

> 0xff on the 6 bit field.
> So we must ensure that the multi-byte fields are in the correct=20
> endianness that the hardware expects.

The vote_x field looks like it goes from bits 14 to 27. No matter the
endian format of the _word_, bits 14 to 27 are for the vote_x field. So
if I set bit 15 and 17 in a big-endian format word (vote_x is decimal
10), pass that 32-bit word to writel(), swap the bytes, it is still set
as bit 15 and 17 in little-endian format. That's because when I read the
32-bit word as a little-endian machine, the first byte is for bits 0 to
7, second byte is for bits 8 to 15, third byte is for 16 to 23, and
fourth byte is for bits 24 to 31. The hardware assembles the 32-bit word
out of that byte order, knowing that bits are mapped that way. Once I
have the 32-bit word, it can be shifted right 14 times so that the
vote_x field is from 0 to 13, and bits 1 and 3 are set, i.e. decimal 10.

Fields that span bytes don't matter here. The hardware is going to read
the word in the format that it is in, which is the order of bytes, and
assemble a full 32-bit word out of it. We're just setting bits in the
field that's shifted so many bits because it's part of a word. The order
of the bits isn't changing.

>=20
> In other words, writel does not know about the multi-byte fields inside=20
> this u32 which have a specific bit shift, and those fields are expected=20
> to be in le32 order written to the hardware. Whether or not the cpu is=20
> le32 is not important because using cpu_to_le32 will make it safe either =

> way.
>=20
> I apologize for my not so great explanation
>=20

I hope my explanation has helped. Long story short, the cpu_to_le32()
usage here is wrong. Typically we try to operate with a type that's the
same size and native format for as long as possible (u32), partially for
performance reasons but also to make it easier to understand. When it
comes time to write that value to the hardware, write it in the hardware
format (writel), and read from the hardware in the hardware format
(readl). Doing this lets you avoid thinking about the endianness almost
entirely, and makes it so that code doesn't have to be rewritten when
running on a different endian CPU to avoid suffering performance
penalties with all the byte swapping.

