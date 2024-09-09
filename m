Return-Path: <linux-pm+bounces-13881-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 840C29712CC
	for <lists+linux-pm@lfdr.de>; Mon,  9 Sep 2024 11:01:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 25DB41F21D1E
	for <lists+linux-pm@lfdr.de>; Mon,  9 Sep 2024 09:01:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24D2A1B29A8;
	Mon,  9 Sep 2024 09:01:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="UDwX4EVU"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C40671AC88E;
	Mon,  9 Sep 2024 09:01:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725872512; cv=none; b=HhKOtb4CxAurTYvQs8oupqIc5evrbjPtUlcbFjKxbkMys9bzptAsplQBgKhk488XH02DbzyJ0FoLCD4qukBOl2e/y8jpyW5pPpWtIqw+Zm3Hd08wB7hHQncb7eaQD63rfmWhwJXarxiqxpIXtEK1im4c6btL+oSEG9b4O6CFG0k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725872512; c=relaxed/simple;
	bh=ku5W56W1XNsijkLvO7GmJwyBMqN3cGd5vZD15ts6Trc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bh/n8DwH2hBP/JnDRekLwk+ibc5gHcwzZJ30QAY4j6SMuBLlFrZArboaWjxnxu4XPkQb2lVJ6MnCPU3CNv699Wl/7L4BsDZUzfcHE0W3yvAFr+cwEPwsKu1mtpOQ4Akmz6WMW3PRTMMHVrx29Am8UZutQTBLmWOjpf2fpYWnlnQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=UDwX4EVU; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1725872510; x=1757408510;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=ku5W56W1XNsijkLvO7GmJwyBMqN3cGd5vZD15ts6Trc=;
  b=UDwX4EVUDpDqgh6C0ftR+/gdQGbTgJef0ZfXexwYsbZc30VNKwRqnCPB
   cuFAT+7VTp4cs2jztkRkDqTeUgfJsBYu7Yr/mjGeJ86SIE6zYzgvBczQd
   KdDay2mHB/zFYIkPWI944dy4DmO8OIe2hEISf1D4xRXoyPL97szKjzr0G
   mv2Vl6nr6olj3CqdgeIIMx6cEVP7D72ys+ukMmtRtCWw/Xn5vNWP2Dha7
   CHwM5tx6Bv+VB28AeK+b+a1L3/qSLHfVEDuq/FZAoDyNg6hygZKYATBgQ
   OfvKzpW9WN6p0viXLcJ9ZkqomhS7Cis9+FEr5somWcABEdIZmTiXzaRUT
   Q==;
X-CSE-ConnectionGUID: jh5owUL3RtGuiBbv0Zd8Sw==
X-CSE-MsgGUID: T8PZQ8f5QAG/WO2ngRTWyg==
X-IronPort-AV: E=McAfee;i="6700,10204,11189"; a="13436258"
X-IronPort-AV: E=Sophos;i="6.10,213,1719903600"; 
   d="scan'208";a="13436258"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Sep 2024 02:01:49 -0700
X-CSE-ConnectionGUID: iry4G+k1Sj2U1cXyP2emXg==
X-CSE-MsgGUID: UV4YPHqLRvmu3MOvLenbGg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,213,1719903600"; 
   d="scan'208";a="66594619"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmviesa009.fm.intel.com with ESMTP; 09 Sep 2024 02:01:48 -0700
Received: by black.fi.intel.com (Postfix, from userid 1001)
	id 12201297; Mon, 09 Sep 2024 12:01:46 +0300 (EEST)
Date: Mon, 9 Sep 2024 12:01:46 +0300
From: Mika Westerberg <mika.westerberg@linux.intel.com>
To: Kenneth Crudup <kenny@panix.com>
Cc: Lukas Wunner <lukas@wunner.de>, linux-usb@vger.kernel.org,
	"linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>
Subject: Re: My Dell XPS-9320 (kernel 6.10.x, et al.) doesn't detect
 Thunderbolt additions when coming out of suspend or hibernate
Message-ID: <20240909090146.GG275077@black.fi.intel.com>
References: <c9feac08-a1fd-4e03-a708-1046793443db@panix.com>
 <ZsvxR-dQAZtwNi0g@wunner.de>
 <6322b3f1-c5d9-4291-96da-72b85248dea0@panix.com>
 <5e7183c8-1843-4390-aef1-1772e538a359@panix.com>
 <20240904122835.GG1532424@black.fi.intel.com>
 <98c3c35d-c694-4fcd-b8b4-6101c4764ae4@panix.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <98c3c35d-c694-4fcd-b8b4-6101c4764ae4@panix.com>

Hi,

On Mon, Sep 09, 2024 at 12:51:18AM -0700, Kenneth Crudup wrote:
> 
> I can't get to the dmesg when it crashes, but I did a SysRq-S/C and have
> attached the crash output; let me know if this is at all helpful.
> 
> I see I'd SysRq-S/C on a previous hang, I've attached that one, too.

Unfortunately I did not see anything too useful in that. There is the
suspend thread going on but it does not seem to show what exactly is
hanging there.

> This particular time it suspended OK, but hung indefinitely when I plugged
> it into another TB3 dock (the previous one was TB4, if it matters).

Can you describe the flow with bit more details? And let's stick with
one dock for now (if both have the same issue anyway).

You do something like this?

1. Boot the system up, TB4 dock connected.
2. Verify everything is working. BTW, do you have monitor(s) connected
   to the dock?
3. Enter system suspend.
4. Verify it is suspended (suspend LED if exists is "blinking", fans are
   turned off).
5. Wake it up from keyboard.

  Expectation: System wakes up fine, all the devices work exactly same as
  prior suspend. All connected monitors display picture.

If this is the flow, can you do steps up to 3 with
"thunderbolt.dyndbg=+p" and provide full dmesg of that at least so if
nothing else I can try to reproduce it on our end?

