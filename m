Return-Path: <linux-pm+bounces-15650-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E017899E6AB
	for <lists+linux-pm@lfdr.de>; Tue, 15 Oct 2024 13:44:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A3F42284BAC
	for <lists+linux-pm@lfdr.de>; Tue, 15 Oct 2024 11:44:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E93B1EABAB;
	Tue, 15 Oct 2024 11:43:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ee+LUZmf"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F0361E884C;
	Tue, 15 Oct 2024 11:43:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728992630; cv=none; b=OPLwdfpF2GFQUa/jsgC/Acj9iE5MwhY2DWWVgIoCNsbGPM9cfI/og+Q6GIITlut1aHAfImI9fnvWY9p74+P7fC2sQJXN9HGPsgHQbEp9hxNjZoXWK5fHom9FMZ8Grt9khblp6bn/vuJk2YsmO/EbwBw8EdB9UcE/RQXZcdmAAtI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728992630; c=relaxed/simple;
	bh=mo/gQH4hkR/5aTytPaB8K9yOU0NG0/ishx8d4c82Usw=;
	h=From:To:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=j2stq3vWEIT599VbHH77BSTAHufFAJwH3V8a4ga0NyeA/Xd9OTVxIPXWK8EIv0LIqVPevDCpl0IGsfkA+Vj3PjOn2y0FhVX6FC2SCbGc99sSWcYVDvz4IUKdpZSvRLfukwaNK1VnNGbbaP2ivcP8oq6jGMtm+fzAlWPpvLTyrH8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ee+LUZmf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 01EDBC4CEC6;
	Tue, 15 Oct 2024 11:43:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728992630;
	bh=mo/gQH4hkR/5aTytPaB8K9yOU0NG0/ishx8d4c82Usw=;
	h=From:To:In-Reply-To:References:Subject:Date:From;
	b=ee+LUZmf7X/dLPb6sy14WZNVzdqMubo1HQky6XpYfr+9FhlTkGzNGrfm1DRF80VgY
	 5V1cwcbdKpBYQSt1Qy27MOoMy8NYuwRFuc7crB3zm3iplC1RFJNS/7EJJNyujsjxar
	 9ylTuS9UovxQldRhGL0ONByc8Qt1sGdhwGaSjZcxKUnHwYvgF1NeQ/iSZVPQnjGJiM
	 80NDUlbOSN1ZCre1Eft7KAGtklR0eID082lIydag+LrnXTh3hBn+jXI50xr4cZhdlq
	 apb4ydR1nPKVw/g1ZPrYA0iAm58wAemZC7Yq3vMxQsfttUfN/FWlW652KZ+1FVEDh3
	 hBWrwmNkQn2jw==
From: Lee Jones <lee@kernel.org>
To: devicetree@vger.kernel.org, Lee Jones <lee@kernel.org>, 
 linux-kernel@vger.kernel.org, tony@atomide.com, 
 Rob Herring <robh@kernel.org>, linux-pm@vger.kernel.org, 
 Conor Dooley <conor+dt@kernel.org>, khilman@baylibre.com, 
 linux-omap@vger.kernel.org, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Sebastian Reichel <sre@kernel.org>, Andreas Kemnade <andreas@kemnade.info>
In-Reply-To: <20241007150120.1416698-3-andreas@kemnade.info>
References: <20241007150120.1416698-1-andreas@kemnade.info>
 <20241007150120.1416698-3-andreas@kemnade.info>
Subject: Re: (subset) [PATCH v4 2/4] dt-bindings: mfd: twl: add charger
 node also for TWL603x
Message-Id: <172899262774.511730.12889214471457383320.b4-ty@kernel.org>
Date: Tue, 15 Oct 2024 12:43:47 +0100
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.13.0

On Mon, 07 Oct 2024 17:01:18 +0200, Andreas Kemnade wrote:
> Also the TWL603X devices have a charger, so allow to specify it here.
> 
> 

Applied, thanks!

[2/4] dt-bindings: mfd: twl: add charger node also for TWL603x
      commit: 8a2ef90ff7924250db535454ef92ba2961b80fba

--
Lee Jones [李琼斯]


