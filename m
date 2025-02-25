Return-Path: <linux-pm+bounces-22907-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A396AA44930
	for <lists+linux-pm@lfdr.de>; Tue, 25 Feb 2025 18:59:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 328BB881A7D
	for <lists+linux-pm@lfdr.de>; Tue, 25 Feb 2025 17:52:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AEE50198A19;
	Tue, 25 Feb 2025 17:52:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VFzZAOVB"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C800156F3A;
	Tue, 25 Feb 2025 17:52:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740505964; cv=none; b=U5vV1bU1/RuLWM5npAFhQyYm2D+i87AL6dafSrY3cRrU7cZ+QupPUoPx20cwH91/ZB9xxTDEiqR1Fhc5QnzS/9WpNkgHXNoJHumBU699NjmmGL2kkYGOO80h4vz8wYuluRTg80aUovS6EAG/Y+YrVF5iIqOdtoMWoulTPwiHcW8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740505964; c=relaxed/simple;
	bh=w0EkbHkGHBYElQYWfADsG+yNVibDYgCQClR6E5omnNM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dX4ge9Nv3YjZ5MlHKJPbE0pfy97sk82ZTT9xUFIy16041r8lE38v9q9kXetDa/ZTmwIjVgY5Zkd4VTN9A6k/5oCLcCh2zKE0Zgg/GUTE3N63QWHd7I+D98eZdlViX3vTJSFgsvURxa2pv8Qbl6R8nXod7rf7aC+xQ9bNTGl0Nek=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VFzZAOVB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 59DBBC4CEE7;
	Tue, 25 Feb 2025 17:52:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740505964;
	bh=w0EkbHkGHBYElQYWfADsG+yNVibDYgCQClR6E5omnNM=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=VFzZAOVB1a78DBjHDtOtuMrJTGr8jVuKit5KqKgfyh/fX73Y6Is0do1MFFrz+Jemp
	 Lbhlg7xS6yHIZaTOWiszvYatZeN/iv+ogT1Za46h/vkopmjCPLm5TwsWwEC80+Kt07
	 A2YDXuIPr6QRVYzYIUlUVeZADuuoe/qm/7R47h6ErvqrkGpSsmCqggvlOE/uz7f8zz
	 peh/7+xGpi7QJ/r4uV9nNEC+HJHbHk6OThzJxJrC/S4+QyoUX2cChMnnIOXLrUZe49
	 1NjBsFrGwjtJxyM4ounylZapEAZfSXeiQ/IIMS6S+yDeBzA19sVB5M3X7cEVJvyy5p
	 eYbjFj/YbZxNg==
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-5e04064af07so9230833a12.0;
        Tue, 25 Feb 2025 09:52:44 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCV8eYc5sR/gFaVIk+9oCiwZ3Gs3qQIhSbmZN3cXW3pNlpRxJmRikGhspPyuCSgZjcqsOA4R+hFdmKJD@vger.kernel.org, AJvYcCVVP2runIw3YrhzgGEasoPeD1tnjJ5SpIJxaP3OmoNyMCqQMKe/1BO+UktAYMGKuRc9BYrsMvonFygk6Hg=@vger.kernel.org, AJvYcCVqsuHg5mqRDKfhS+VvfRxozmLs+Ovq4GkW5Az3bWZZAfkMNVLgnW/uV+m+x7AKUrBaJBiT69wcVLQ2+ki8@vger.kernel.org, AJvYcCWX+almcJFNsA4PquVXwmpJUqsPiMvAcLd7VUAKizYuFYioAiAkGBkzs+w67COdun0bAMXbVo/tO8p6@vger.kernel.org, AJvYcCXc1HEujqh8hCzedc+KPpz1BAyCcQdgGyVTxnilKsoJ2DEfhf2nY1UuofG/1Io823t4pJdp9epB4LE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy++dwbSqQS47iDgUqmAc2EWhfeiDq8jQUpvKYZAJ4oEH1mHKw5
	TW/tWpulKoHKvXceA6MiwgjdLl2YXnostCDlN2uuNcJuUI9x4ZyXHc2SpeySqImuWORASxNp0i1
	8jJHPoIE/l+k+6oLOAHOhf+XIdA==
X-Google-Smtp-Source: AGHT+IF6yxHJA3YSV+Mc7KCSIMedD8jUXEbB4xXTDLc0/UNGPOBcZs5+0oQlFOlVb1ificfP0x+i/oVnnr4HgeYGyas=
X-Received: by 2002:a05:6402:440b:b0:5de:aa54:dc30 with SMTP id
 4fb4d7f45d1cf-5e444481387mr4585735a12.5.1740505962886; Tue, 25 Feb 2025
 09:52:42 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241226050205.30241-1-val@packett.cool> <20241226050205.30241-5-val@packett.cool>
 <173920541986.1887800.1972669785800121190.b4-ty@kernel.org>
In-Reply-To: <173920541986.1887800.1972669785800121190.b4-ty@kernel.org>
From: Rob Herring <robh@kernel.org>
Date: Tue, 25 Feb 2025 11:52:31 -0600
X-Gmail-Original-Message-ID: <CAL_Jsq+PPYeFxr=utwZLemUVCzk5iabtMckOJmNy1-LO39cqeQ@mail.gmail.com>
X-Gm-Features: AQ5f1Jq1Iz82X3jYxZcNLZTXQB24STg7TFTfP3ZcCT_Tig0_TFrubDNC8pk8KUg
Message-ID: <CAL_Jsq+PPYeFxr=utwZLemUVCzk5iabtMckOJmNy1-LO39cqeQ@mail.gmail.com>
Subject: Re: (subset) [PATCH 4/9] mfd: mt6397: Add support for MT6392 pmic
To: Lee Jones <lee@kernel.org>
Cc: Val Packett <val@packett.cool>, Fabien Parent <parent.f@gmail.com>, 
	Dmitry Torokhov <dmitry.torokhov@gmail.com>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Sen Chu <sen.chu@mediatek.com>, 
	Sean Wang <sean.wang@mediatek.com>, Macpaul Lin <macpaul.lin@mediatek.com>, 
	Matthias Brugger <matthias.bgg@gmail.com>, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
	Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, 
	Eddie Huang <eddie.huang@mediatek.com>, 
	Alexandre Belloni <alexandre.belloni@bootlin.com>, 
	Javier Carrasco <javier.carrasco.cruz@gmail.com>, Yassine Oudjana <y.oudjana@protonmail.com>, 
	Chen Zhong <chen.zhong@mediatek.com>, linux-input@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-mediatek@lists.infradead.org, linux-rtc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 10, 2025 at 10:37=E2=80=AFAM Lee Jones <lee@kernel.org> wrote:
>
> On Thu, 26 Dec 2024 01:58:04 -0300, Val Packett wrote:
> > Update the MT6397 MFD driver to support the MT6392 PMIC.
> >
> >
>
> Applied, thanks!
>
> [4/9] mfd: mt6397: Add support for MT6392 pmic
>       commit: 896b1eb4ca771b37ea50feb4d90a78dd4e9cb388

This should be dropped. Missing the sender's S-o-b and the rest of the
series has issues still.


Rob

