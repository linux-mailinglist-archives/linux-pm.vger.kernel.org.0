Return-Path: <linux-pm+bounces-37274-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 8EA92C29B84
	for <lists+linux-pm@lfdr.de>; Mon, 03 Nov 2025 01:49:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id BB5904E3330
	for <lists+linux-pm@lfdr.de>; Mon,  3 Nov 2025 00:49:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E9C1225415;
	Mon,  3 Nov 2025 00:48:41 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E630B22156A;
	Mon,  3 Nov 2025 00:48:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762130920; cv=none; b=Z40LiGht5TVgVnxNrn958O1nKlGAqE+YaNvKZH427gi6hd/g7R+0GNUgq7sOmMmL1MJR9ExmdZaEvRChMw6zo8C0/bEElm3qiwvrL6bzDNZnQCl/RRAQ6s8sP0c4ktycJSRU57WoWiNzir484gNr8x9KArbuhyaudeH0Wp0Fmmg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762130920; c=relaxed/simple;
	bh=s/uZrYG0J1VoRSPDy5vlbSvXSTmXTUOXn0IoyZq29ZA=;
	h=From:To:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=FPWpQ9CgLzYSCLVm3J3POjbZ7c5EiTFcGUN8kLi3lZ2sNxi3JZx174TwR6DKnofffhFDUxsUnKZIBHwyLYNGf3CmDifyrFh/vTspKxSmg1irG58lVAjUW+vWY1N4mcgCyF8Fh8oGTrm+KvTUp5+/rqhumlLpWFyLpFa8Qwt3Dz4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9B498C2BC87;
	Mon,  3 Nov 2025 00:48:40 +0000 (UTC)
Received: by venus (Postfix, from userid 1000)
	id 6B97C1822D9; Mon, 03 Nov 2025 01:48:33 +0100 (CET)
From: Sebastian Reichel <sebastian.reichel@collabora.com>
To: Sebastian Reichel <sre@kernel.org>, Anton Vorontsov <cbou@mail.ru>, 
 linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, 
 =?utf-8?q?Ahelenia_Ziemia=C5=84ska?= <nabijaczleweli@nabijaczleweli.xyz>
In-Reply-To: <xczpgox57hxbunkcbdl5fxhc4gnsajsipldfidi7355afezk64@tarta.nabijaczleweli.xyz>
References: <xczpgox57hxbunkcbdl5fxhc4gnsajsipldfidi7355afezk64@tarta.nabijaczleweli.xyz>
Subject: Re: [PATCH] power: supply: apm_power: only unset own
 apm_get_power_status
Message-Id: <176213091342.301408.14482368410534019640.b4-ty@collabora.com>
Date: Mon, 03 Nov 2025 01:48:33 +0100
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.14.3


On Fri, 17 Oct 2025 00:05:18 +0200, Ahelenia Ziemiańska wrote:
> Mirroring drivers/macintosh/apm_emu.c, this means that
>   modprobe apm_power && modprobe $anotherdriver && modprobe -r apm_power
> leaves $anotherdriver's apm_get_power_status instead of deleting it.
> 
> 

Applied, thanks!

[1/1] power: supply: apm_power: only unset own apm_get_power_status
      commit: bd44ea12919ac4e83c9f3997240fe58266aa8799

Best regards,
-- 
Sebastian Reichel <sebastian.reichel@collabora.com>


