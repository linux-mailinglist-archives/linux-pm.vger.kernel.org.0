Return-Path: <linux-pm+bounces-12602-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C1B9095950F
	for <lists+linux-pm@lfdr.de>; Wed, 21 Aug 2024 08:49:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 00CE21C22694
	for <lists+linux-pm@lfdr.de>; Wed, 21 Aug 2024 06:49:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E7CA18661C;
	Wed, 21 Aug 2024 06:49:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="tkkCjqKk"
X-Original-To: linux-pm@vger.kernel.org
Received: from mout.web.de (mout.web.de [212.227.17.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D4661865FF;
	Wed, 21 Aug 2024 06:49:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724222991; cv=none; b=AvzTusw5Mn9TyPGQkKFENEJgKeqkQe4+M2elzRHHv8iX06nuxYiih0W3AKVIO3PZEK39x6o/Zmdnj4UmCHuz7dJ5OYjKsvM0hdpUSsFein0n52jzvCYaKPKTxYrwYt2FjZHVHssxbT7o+DvfW6p+75toJBTMG6TbtAafJRSqz7w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724222991; c=relaxed/simple;
	bh=BqvEjNaBLPixdJTzZ/B6t5WySxm2QEG9jD9TzfsRKHk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mIR56YdtUwEtGFn/HjqR0coQR/lmkPtJasgtFAxxnUcthdSrcSHLO1d8TJqJXag/7XXGpcq3r+jUVVB9VfP7kuLb2PYxIHPr8NmU/bgvSF3nqpNSaTelZqI5vkr6fLnqzw3Fltp/Vupvw9LgLDJolT++sXmibeuKs73Nt2t3/fg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=tkkCjqKk; arc=none smtp.client-ip=212.227.17.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1724222975; x=1724827775; i=markus.elfring@web.de;
	bh=BqvEjNaBLPixdJTzZ/B6t5WySxm2QEG9jD9TzfsRKHk=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=tkkCjqKkUdS10Y5oModBEchGIL9OZpGZ8YnQfaVUPWav/aHljNJumMbwLJsjyG+N
	 iuzUbkiwF7eUAXF0RETYDGLqB9LomN1uTwBBSK0XmXA9mE+I71yFs4xSORIE5rRlv
	 bJ/boc2kJwFmTpb1auOW0TATGYND9BWIaMW0PuPG/qWwL4D7m6gMXFp0851A8TvxV
	 LSKxSx6VPJKzrqoK/8U4APQpVtazthptgmUGy9J+U1mEjNhxM50VQJYRUB7O3SKaR
	 aGXQsVxVo90bhOPo6G5k2marFX7F9o4GNYGWgWg1VngRDQzToqvpKjXsWOzn1g+Ch
	 M8BwsVIo2Or4qAe4JA==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.81.95]) by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MMp8Y-1sO1oR2Xqu-00U7iB; Wed, 21
 Aug 2024 08:49:35 +0200
Message-ID: <8059d887-b765-4d62-8367-614fe0a0a462@web.de>
Date: Wed, 21 Aug 2024 08:49:06 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [v3] HID: corsair-void: Add Corsair Void headset family driver
To: Stuart Hayhurst <stuart.a.hayhurst@gmail.com>,
 linux-input@vger.kernel.org, linux-pm@vger.kernel.org
Cc: LKML <linux-kernel@vger.kernel.org>,
 Benjamin Tissoires <bentiss@kernel.org>, Jiri Kosina <jikos@kernel.org>
References: <20240820002210.54014-3-stuart.a.hayhurst@gmail.com>
 <577e96df-5535-4530-ac62-edc53881a443@web.de>
 <CALTg27mK9wPC_1sRzk-Z-NCm7a+25KrEYwB8=JQN62RrCASOOw@mail.gmail.com>
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <CALTg27mK9wPC_1sRzk-Z-NCm7a+25KrEYwB8=JQN62RrCASOOw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:W6HQPTJTd9h/3szQ3mScOiF4oLKbiPaHTYGvV4QuIj4XBuR3Z4O
 VKWXtY814lJ0OC1dvkthh0VUJYrznL01jEzOv2sBlboRabaYyLWPaOv8trWkUM/10jvHlvZ
 u5JfaZnaBT14v1nlqZWMvA+gium4k7bnUB1RMxtCVV92BV1l2d0vCLznBc31akb155IgX5d
 WeDTZugbSxSQumpnERYng==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:f8rMYqyFe6k=;oGvMK8+LwCc1ohzOK6PtcHHeHtn
 +BHCJqe6SbaQEfYWN9Li30uYhHjC21eDdfiauSH1QOIlAhvp0GoqX/0/vhNf+ovZRzJFRTw7g
 A77I6EcmrDo1GMsX3H4EronMLWSX9Nn5fmcMHoJphpykpsx/Z8y2ViBdDEGyf14zGzkUdpRXe
 aFLvsvSCOPWl6/POTrqDHJZAmx/tHd1Dx9wtrBKthrFnqgCgCYled2x5+u3cS/SQOlP0PbOVZ
 F+WI9oMhGmfHyF8jYOAa3/517J7z7qZNvbiIm6kzQhwehKDndsG29bcI19/cgahV5OdqJCltb
 PVyVP5p8bPu8NjO3pHqdF7rjspkyfB7Jmp0NZumHIsEgQ8V2NQyCzUN1Ccf2OXDdV3Tbprkaq
 hDGujsNhSXYfk0QNHXrzOMsG1XLgzg5efc6LVlkPa54a9tk/1BVHBAEmmOMJzEmU2k+feqdzP
 V0W9/WnqprK/KIwAm2OoEdOgSxltmXCEMtXZO5eQzwPE77DnLj3C0X7sEZERbBP5Y9xmEJ5iR
 wNDfmCD65kct5s+6OWM1FewVYkX5a80CvqwuMbCnq1caYXSJGGYhM9J66c3GmDp9bbhH6gwsa
 XvUhz9HqlD1wd9h1jMaGZcDTqaXwol6NZWwh9j6Q+thn56l8uCyZhWDhwLekgh/WHVStpbQtT
 wFCV1Su3WgzwhH2gZlcZGm+JGRzOQcFJc2IdgrFQntkqGS5PGplC2G4WjkR5Ri42G7dAxdef7
 MNEj15V0YY+5s+qIGpzpLRVSdj5F7FZZnuhKshHffT4kVHzLFpsuQhiUKb6CVDAU2aHYMmGVF
 ZQ3nGWgcwh3/6CDf3DEADO4Q==

>> Would you like to choose a corresponding name for such an enumeration?
>
> I'm not entirely convinced it needs one, as the value names are fairly d=
escriptive
>
>> Can any other data type be reused for this purpose?
>
> I'm not sure what you're asking

I imagine that more advanced programming interfaces can be applied for
the management of batteries together with some devices.

Regards,
Markus

