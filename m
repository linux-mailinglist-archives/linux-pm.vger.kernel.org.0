Return-Path: <linux-pm+bounces-14429-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F2D897C3EA
	for <lists+linux-pm@lfdr.de>; Thu, 19 Sep 2024 07:51:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F100D1F21F83
	for <lists+linux-pm@lfdr.de>; Thu, 19 Sep 2024 05:51:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E70758222;
	Thu, 19 Sep 2024 05:51:38 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from mx3.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9DC15674D
	for <linux-pm@vger.kernel.org>; Thu, 19 Sep 2024 05:51:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=141.14.17.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726725098; cv=none; b=emsxrhJAD05VnRC6c1fmFsn0inUdadavTNMrLffiyygg9IsF8gHM082VKo25iWYHa12eT/T9uU6MN/NXKRfkyj2HoSOrbI9AFCI9BteI5IHA178wG/x3E01Pg4oPgDFI1/jZOtS0d8/E6qO4pMpfGE4Pn5z6N4whF9nByIoVp5M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726725098; c=relaxed/simple;
	bh=sL2pBfwgQPrKUSSEW/3Sc/p/OmOc7fQfQ8tcs7jMfR0=;
	h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type; b=cojTXclwYmVlxFgnK/9lwyo2KYka0VupBDSbT+iSBc5tMmp3jsMebSRnwVESlzQQ3a2q3wNj7iB6PVI0z2pA1pcrqtUAKQ3aF1uAc7mzaXA1wzr7UdWbdtxrrjBd+4oAG+I8A6QGtJ+JsDbr6mB1Mvg8rVTfYBGkzfCw3+Ojwl0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de; spf=pass smtp.mailfrom=molgen.mpg.de; arc=none smtp.client-ip=141.14.17.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=molgen.mpg.de
Received: from [172.30.4.124] (unknown [193.158.90.91])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pmenzel)
	by mx.molgen.mpg.de (Postfix) with ESMTPSA id 8D39361DFA93D;
	Thu, 19 Sep 2024 07:51:06 +0200 (CEST)
Message-ID: <18784f62-91ff-4d88-9621-6c88eb0af2b5@molgen.mpg.de>
Date: Thu, 19 Sep 2024 07:51:05 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: linux-pm@vger.kernel.org
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, regressions@lists.linux.dev,
 Petr Mladek <pmladek@suse.com>
From: Paul Menzel <pmenzel@molgen.mpg.de>
Subject: Fails to ACPI S3 supend on Dell XPS 13 9630
 (6.11.0-04557-g2f27fce67173)
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Dear Linux folks,


On the Intel Kaby Lake laptop Dell XPS 13, Linux 
6.11.0-04557-g2f27fce67173 (“6.12-rc0”) fails to ACPI S3 suspend the 
system. The screen turns black (as expected) and the power button LED 
stays on.

Doing

     echo N | sudo tee /sys/module/printk/parameters/console_suspend

and on tty2

     sudo systemctl stop gdm3
     sudo systemctl start getty@tty1.service

and then on tty1

     sudo systemctl suspend

I see some panic messages and traces containing ktime_get or so, but I 
failed to save the messages. (Hints very much appreciated.)

I try to test the printk changes, but otherwise bisecting is not 
feasible, as it’s my production machine.


Kind regards,

Paul

