Return-Path: <linux-pm+bounces-12687-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id F05CB95A7BD
	for <lists+linux-pm@lfdr.de>; Thu, 22 Aug 2024 00:24:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8B954B2214F
	for <lists+linux-pm@lfdr.de>; Wed, 21 Aug 2024 22:24:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C712A17BB12;
	Wed, 21 Aug 2024 22:24:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=panix.com header.i=@panix.com header.b="PlsFdFKx"
X-Original-To: linux-pm@vger.kernel.org
Received: from l2mail1.panix.com (l2mail1.panix.com [166.84.1.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B6E9139CFE;
	Wed, 21 Aug 2024 22:24:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.84.1.75
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724279062; cv=none; b=FUuXTYp9jj5c2JlmmGCdexTOgS9g2VyskvqEaWbrWyeqKCXumuqjSmSL35qtTZ1vI+LLDv6YHyHLV7+Njfge+ifwbtSYlk7BZ/wBbGa778TlfYdFyusXQbsK77OHJA3JUUBJvgm+eY5N7NVxXffPs/NdjsxuzbbkPyktPODD0d0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724279062; c=relaxed/simple;
	bh=s4Dppp6MnjOnzMb8wX8FvUV+U7RP3+p0wHOxRcrdTq8=;
	h=Message-ID:Date:MIME-Version:To:From:Subject:Cc:Content-Type; b=kNuyRWMgyuySAfv8VEDJ6IEM/RTpy1zdeGJGwaOkq3kWAXBUWhFS50q4UPj58Uq6XpvmKMbkyxaVq4PAkkvuBUxPHpWOluZUjt/Hz1xW5CH3HzY+Uqkj686ydtm3tK0kcHQJAOqi63jqXcDnuClPqHxIJu4Z89LGJR70+eZRMs8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=panix.com; spf=pass smtp.mailfrom=panix.com; dkim=pass (1024-bit key) header.d=panix.com header.i=@panix.com header.b=PlsFdFKx; arc=none smtp.client-ip=166.84.1.75
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=panix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=panix.com
Received: from mailbackend.panix.com (mailbackend.panix.com [166.84.1.89])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (1024 bits) server-digest SHA256)
	(No client certificate requested)
	by l2mail1.panix.com (Postfix) with ESMTPS id 4Wq0lg65fnzDPB;
	Wed, 21 Aug 2024 18:06:07 -0400 (EDT)
Received: from [192.168.123.3] (kenny-tx.gotdns.com [162.196.229.233])
	by mailbackend.panix.com (Postfix) with ESMTPSA id 4Wq0lX3w71z4LTJ;
	Wed, 21 Aug 2024 18:06:00 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=panix.com; s=panix;
	t=1724277960; bh=s4Dppp6MnjOnzMb8wX8FvUV+U7RP3+p0wHOxRcrdTq8=;
	h=Date:To:From:Subject:Cc;
	b=PlsFdFKx4a6n33ZkcIGusNmUBH/dvvSuHCTcpYtuOSgoFRW1mq1qOuW/yH1x0PnvN
	 SJU3ftjgmh9cUzedSC2Y3yI4QqwnG5qm9gwaMn6OufrVuPEjzkLAu8HDAEBhBIF4H8
	 aqDXWc4IEGa9ycbGWZSZmvaYkHOhdtUfc9Qzin3s=
Message-ID: <c9feac08-a1fd-4e03-a708-1046793443db@panix.com>
Date: Wed, 21 Aug 2024 15:05:59 -0700
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
 linux-usb@vger.kernel.org
From: Kenneth Crudup <kenny@panix.com>
Subject: My Dell XPS-9320 (kernel 6.10.x, et al.) doesn't detect Thunderbolt
 additions when coming out of suspend or hibernate
Cc: Me <kenny@panix.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


Subject says it all, but to recap my laptop doesn't detect Thunderbolt 
topology changes when resuming or coming out of hibernate; i.e., the 
only time a TB topology change happens is if a TB cable is disconnected 
while suspended or hibernated, but if one is connected, or a different 
TB setup altogether is connected when the system resumes it doesn't 
notice the topology change until I disconnect and reconnect.

I'm currently running 6.10.6, but this has been going on for a while.

----
[    0.000000] DMI: Dell Inc. XPS 9320/0KNXGD, BIOS 2.12.0 04/11/2024
...
[    0.136807] smpboot: CPU0: 12th Gen Intel(R) Core(TM) i7-1280P 
(family: 0x6, model: 0x9a, stepping: 0x3)
----

LMK if you'll (likely) need further information.

-Kenny

-- 
Kenneth R. Crudup / Sr. SW Engineer, Scott County Consulting, Orange 
County CA

