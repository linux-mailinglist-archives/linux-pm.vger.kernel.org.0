Return-Path: <linux-pm+bounces-32828-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 42EAFB301CE
	for <lists+linux-pm@lfdr.de>; Thu, 21 Aug 2025 20:16:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2A7E5602449
	for <lists+linux-pm@lfdr.de>; Thu, 21 Aug 2025 18:16:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3044D74BE1;
	Thu, 21 Aug 2025 18:15:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kemnade.info header.i=@kemnade.info header.b="HHzuGsNT"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail.andi.de1.cc (mail.andi.de1.cc [178.238.236.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53EBE3C33;
	Thu, 21 Aug 2025 18:15:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.238.236.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755800157; cv=none; b=mCAyEi3KTyxj+uZ8rPd+CqOjgHLt0ykcUl8vO5UjXQQNvzOjaGV1fx4UNMAtqhot9f34LRK2Cj0mvSxf54x65SyCL+13kKCQtvp0wDeIclyneLW08eX8DbV4KthhOWs6+rWFNTfZeF/21LKieFRRgiEs5IgLbxKG2SkR683h0Jg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755800157; c=relaxed/simple;
	bh=J72lOg1jhfsoirN+WNSxylyB1lH5ze5gjHkKjCx4rtU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YmI3Cda6DsOtNy1by+nGiSB8hV5GSaOINlnwebRLKV8HbZwlDKO0T131Ovi58D9YIKhtx0Mi823NshCJKlVW7bO+rXV8DBogDytwwmPGhuxcNxsk/LXYq5vWg4+HQn3mfKTaZXSrRmwJtWdRm40fsmCaXk23zLYkGogs1j+tmzQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kemnade.info; spf=pass smtp.mailfrom=kemnade.info; dkim=pass (2048-bit key) header.d=kemnade.info header.i=@kemnade.info header.b=HHzuGsNT; arc=none smtp.client-ip=178.238.236.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kemnade.info
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kemnade.info
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=kemnade.info; s=20220719; h=References:In-Reply-To:Cc:From:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID;
	bh=Pi+yQYK1CHO97Sg/9EQVKEHFHoaJqzqRipLawqydhEE=; b=HHzuGsNTsPcUSlUgQQj0JpYlA2
	H2D7R6nGQZbnbrrICfqhma6isVrlwBQMTQ1xZy73xHmrakI0ghNh9DGQyHss1jke2fQalRlGwJUew
	s8E+I13svIobYvFpwTTagNTxpSF0BAd7NDY2KbgRQbL2bDWEwLAPWfDPATek9GJnjL0B7vWwmOEzC
	ieRCkrkDhWMtqq+hhxtqFAMBkZxIgpzkwFt7kpA4fyQ/iEqhJjcbTW7qWNlPVnrvjcQF5gNChny4L
	p0XlVo3qSd8SjdYdybqzP/u5Sbo99EbqI5Gi6DIL+UebWriQR4f7MjgGQ84q9XI1QccexCrNnoLJN
	1Gu7UbSw==;
Date: Thu, 21 Aug 2025 20:15:44 +0200
From: Andreas Kemnade <andreas@kemnade.info>
To: "H. Nikolaus Schaller" <hns@goldelico.com>
Cc: Sebastian Reichel <sre@kernel.org>, Jerry Lv <Jerry.Lv@axis.com>, Pali
 =?UTF-8?B?Um9ow6Fy?= <pali@kernel.org>, linux-pm@vger.kernel.org,
 linux-kernel@vger.kernel.org, letux-kernel@openphoenux.org,
 stable@vger.kernel.org, kernel@pyra-handheld.com
Subject: Re: [PATCH] power: supply: bq27xxx: fix error return in case of no
 bq27000 hdq battery
Message-ID: <20250821201544.047e54e9@akair>
In-Reply-To: <bc405a6f782792dc41e01f9ddf9eadca3589fcdc.1753101969.git.hns@goldelico.com>
References: <bc405a6f782792dc41e01f9ddf9eadca3589fcdc.1753101969.git.hns@goldelico.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

Hi,

Am Mon, 21 Jul 2025 14:46:09 +0200
schrieb "H. Nikolaus Schaller" <hns@goldelico.com>:

> Since commit
> 
> commit f16d9fb6cf03 ("power: supply: bq27xxx: Retrieve again when busy")
> 
> the console log of some devices with hdq but no bq27000 battery
> (like the Pandaboard) is flooded with messages like:
> 
> [   34.247833] power_supply bq27000-battery: driver failed to report 'status' property: -1
> 
> as soon as user-space is finding a /sys entry and trying to read the
> "status" property.
> 
> It turns out that the offending commit changes the logic to now return the
> value of cache.flags if it is <0. This is likely under the assumption that
> it is an error number. In normal errors from bq27xxx_read() this is indeed
> the case.
> 
> But there is special code to detect if no bq27000 is installed or accessible
> through hdq/1wire and wants to report this. In that case, the cache.flags
> are set (historically) to constant -1 which did make reading properties
> return -ENODEV. So everything appeared to be fine before the return value was
> fixed. Now the -1 is returned as -ENOPERM instead of -ENODEV, triggering the
> error condition in power_supply_format_property() which then floods the
> console log.
> 
> So we change the detection of missing bq27000 battery to simply set
> 
> 	cache.flags = -ENODEV
> 
> instead of -1.
> 
This all is a bit inconsistent, the offending commit makes it worse. 
Normally devices appear only in /sys if they exist. Regarding stuff in
/sys/class/power_supply, input power supplies might be there or not,
but there you can argument that the entry in /sys/class/power_supply
only means that there is a connector for connecting a supply.
But having the battery entry everywhere looks like waste. If would
expect the existence of a battery bay in the device where the common
battery is one with a bq27xxx.

Regards,
Andreas

