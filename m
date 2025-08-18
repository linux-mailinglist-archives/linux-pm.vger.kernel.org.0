Return-Path: <linux-pm+bounces-32556-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D6AEFB2ACCE
	for <lists+linux-pm@lfdr.de>; Mon, 18 Aug 2025 17:33:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C528018A70B5
	for <lists+linux-pm@lfdr.de>; Mon, 18 Aug 2025 15:30:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 918C825A65B;
	Mon, 18 Aug 2025 15:30:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TUiYRhv3"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60DD2258CC1;
	Mon, 18 Aug 2025 15:30:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755531008; cv=none; b=Rpua9NDOpv4AZUXiqNcTio1/r2eXACde2beEqrBftffFDaqQW/j/QQ03zdoBnnDXAZ6PdOIaXNXohaXX5UILRtyYhyYyLfdvqV2qcDuqWYrAwrCCKLCq9DLi46dv4zgJuehxvAqtGgjcglbZ9K04E2zGj8WE5M6GYmDUpGJ/AyA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755531008; c=relaxed/simple;
	bh=0dpJixL1oHRcv/3jNzfC2XXZ+aqq6CYkmZdArMOuDoY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=IGB+5R0Ra//hl6B4rSKB9afnbDw6LuK24+mXXLwxJjz9/5TQ/mw4pHNyENAYEjunI8VPp6mAXliIbe9goNBv+gLXw1/6lXp520Ohj7lQ9ffE2ve4OleRbRA4yZbYRhdppHSRXdw8QzkUN5ZfLD7QzQK8X/Z5iTnKpLTmvQuN3Gc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TUiYRhv3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E5706C113D0;
	Mon, 18 Aug 2025 15:30:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755531007;
	bh=0dpJixL1oHRcv/3jNzfC2XXZ+aqq6CYkmZdArMOuDoY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=TUiYRhv3OxN9v2yoois/MTIq1RAg66QbGVeqXLXRna6GBPLoitAfU5+gXIHywbugf
	 X00aRZagGj9JZAY1UHWYYLwyOEvGPaEDCXSjxOUFCZGppHCl7aMFZJAad4zXTPM60L
	 xbWShtgAz0mK/6jJ3KdipPypAdeKan6efrcwQQmg4X3T3kv6Gt3/SvT8MuB4eQxdo8
	 QDfRYPP2/DNbE2/jpeCouKXiUG2VlioTTVLH2uiay+gJXqJd4ket+v10VHMyy+J8wv
	 wZkV/l6S+UjE0cCmmxpqSVeeggjFJpsG041Sc40Piu+wxpBaoLWkX54tO2/f/Tmwqt
	 ONoyPbr4UUJXg==
Date: Mon, 18 Aug 2025 08:30:06 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Frank Wunderlich <linux@fw-web.de>
Cc: patchwork-bot+netdevbpf@kernel.org, myungjoo.ham@samsung.com,
 kyungmin.park@samsung.com, cw00.choi@samsung.com, djakov@kernel.org,
 robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, andrew@lunn.ch,
 olteanv@gmail.com, davem@davemloft.net, edumazet@google.com,
 pabeni@redhat.com, matthias.bgg@gmail.com,
 angelogioacchino.delregno@collabora.com, johnson.wang@mediatek.com,
 arinc.unal@arinc9.com, Landen.Chao@mediatek.com, dqfext@gmail.com,
 sean.wang@mediatek.com, daniel@makrotopia.org, lorenzo@kernel.org,
 nbd@nbd.name, frank-w@public-files.de, linux-pm@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 netdev@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-mediatek@lists.infradead.org
Subject: Re: [PATCH v9 00/13] further mt7988 devicetree work
Message-ID: <20250818083006.0f277b5b@kernel.org>
In-Reply-To: <8A21C091-0C26-4E9F-9B9E-E28A01F71369@fw-web.de>
References: <20250709111147.11843-1-linux@fw-web.de>
	<175218542224.1682269.17523198222056896163.git-patchwork-notify@kernel.org>
	<8A21C091-0C26-4E9F-9B9E-E28A01F71369@fw-web.de>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 16 Aug 2025 08:55:51 +0200 Frank Wunderlich wrote:
> Any comments on the missing DTS parts or can they applied too?

You should probably put the maintainers you're addressing this question
to in the To: header of the email.

