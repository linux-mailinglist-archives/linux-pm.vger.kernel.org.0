Return-Path: <linux-pm+bounces-21714-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BE24A2F420
	for <lists+linux-pm@lfdr.de>; Mon, 10 Feb 2025 17:50:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D8B233A1174
	for <lists+linux-pm@lfdr.de>; Mon, 10 Feb 2025 16:50:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D95CA2586CE;
	Mon, 10 Feb 2025 16:50:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tCi+UeAo"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 999832586C2;
	Mon, 10 Feb 2025 16:50:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739206213; cv=none; b=oMBGDtPT+uWgcwa/cJjCO8uxu2rOteQTCHFpKmYOc0Fr0uIiBjBNzoavDUuqiXYKC5JBOXrAajs385/FOcAwRQNsK7H/r19vf0QD5DAaVMGVmvgrmCyWlBADxLptCuGUSxdTYCD6jwBDJ7hRT4FHzG1xyMtqFJWQmfHg03T0/zE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739206213; c=relaxed/simple;
	bh=RoQqBYbP9aHYBtW9G+kY1z2Gcw7QCa9D5m8qCyEWhgg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=URFFBCfYRadB4n0YdwHsB69GCMC5owl3rG8GJHG/TxCH3xFCSTOinlgdL8O29FvdvYe7S9Vz5mRBrCTSSLBjlr39fH5/NqdhE4Zvpc6ECSkq7w3/xwQz1klpLgU20kSNLLGW6LMT7zkd5Gyi+5ECyZAvxTKaajvJuc/L49FDG7w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tCi+UeAo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 86225C4CED1;
	Mon, 10 Feb 2025 16:50:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739206213;
	bh=RoQqBYbP9aHYBtW9G+kY1z2Gcw7QCa9D5m8qCyEWhgg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=tCi+UeAoP//GzfkCV1Sm1qDrMrgDldX0pf1R5NIar3SiKfRurctKExQiugQquMZVn
	 KFIauFPrDvSjX4NN1Y7aq1kWZEXqaqRpcDJ78/u3U5sMte4/OLJ0mYAdlzfbd0gTW/
	 Nwqj1t/xX/SfnrQ17BtYg3CMFE+75MgUmhZ9vHTRBdips1NzvFrTsK3Mj3wbR0rZEY
	 fdSJaz5yru8jFc4Ngt0Cl8/3l4bqI6LKfKUh5PMDr/xh0YmAPxCpPPl1kv73zJIoPL
	 VC7FMEPDDPeiIOyUkqKds+cfyihJwAcdRd++c5QAnZPPZJwRLduKnYDulK9AlG/21i
	 y6ztCLYQv+xQA==
Date: Mon, 10 Feb 2025 16:50:06 +0000
From: Lee Jones <lee@kernel.org>
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Dzmitry Sankouski <dsankouski@gmail.com>,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	Sebastian Reichel <sre@kernel.org>,
	Chanwoo Choi <cw00.choi@samsung.com>, Rob Herring <robh@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Pavel Machek <pavel@ucw.cz>, Hans de Goede <hdegoede@redhat.com>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Sebastian Krzyszkowiak <sebastian.krzyszkowiak@puri.sm>,
	Purism Kernel Team <kernel@puri.sm>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>, linux-pm@vger.kernel.org,
	open list <linux-kernel@vger.kernel.org>,
	"open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" <devicetree@vger.kernel.org>,
	linux-input@vger.kernel.org, linux-leds@vger.kernel.org
Subject: Re: Patchset status - 'Add support for Maxim Integrated MAX77705
 PMIC'
Message-ID: <20250210165006.GB1868108@google.com>
References: <CABTCjFBx-QpCKFWs5MPCgLAjJWT6ygrvS_A0nJk2BBxmWAxF+Q@mail.gmail.com>
 <e67c0375-1024-483b-aabf-6a11339ab9af@linaro.org>
 <CABTCjFBvYkEG0WYhCt6tP_cO8Ct82t0=UhwBefZEJrUiFc7vAw@mail.gmail.com>
 <3e69dc53-cf05-479b-9707-eabc2eae9291@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <3e69dc53-cf05-479b-9707-eabc2eae9291@kernel.org>

On Mon, 10 Feb 2025, Krzysztof Kozlowski wrote:

> On 10/02/2025 08:11, Dzmitry Sankouski wrote:
> > вс, 9 февр. 2025 г. в 22:38, Krzysztof Kozlowski
> > <krzysztof.kozlowski@linaro.org>:
> >>
> >> On 09/02/2025 15:13, Dzmitry Sankouski wrote:
> >>> For the patchset I sent 2 weeks ago, [patchwork][1] shows status
> >>> 'Handled Elsewhere, archived'. Is anything blocking it?
> >>>
> >>> [1]: https://patchwork.kernel.org/project/linux-pm/list/?series=927848&archive=both&state=*
> >>
> >> That's PM patchwork, not necessarily power supply. But anyway, what does
> >> the cover letter say? Who do you expect to merge it? Above link does not
> >> provide cover letter, unfortunately.
> >>
> > 
> > I didn't found anything related to power supply in the list of mail lists at
> > https://subspace.kernel.org/vger.kernel.org.html.
> > 
> > However I found my series in linux-input with New status.
> > 
> > Here is my cover letter:
> > https://lore.kernel.org/all/20250123-starqltechn_integration_upstream-v17-0-8b06685b6612@gmail.com/
> 
> Nothing in cover letter gives any expectations or directions of merging,
> so maybe that was a factor here?
> 
> > I guess I would expect a person from the MAINTAINERS list to merge it?  In that
> > case it would be Chanwoo Choi <cw00.choi@samsung.com> and
> > Krzysztof Kozlowski <krzk@kernel.org> from
> > MAXIM PMIC AND MUIC DRIVERS FOR EXYNOS BASED BOARDS entry.
> 
> Haha, nice! :) There is no such subsystem. This cannot be taken by these
> maintainers because there is nowhere they could put it and no one would
> take it from them even if they did find the place.

It's likely that I would take the set.

-- 
Lee Jones [李琼斯]

