Return-Path: <linux-pm+bounces-36014-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 950ECBD6BBA
	for <lists+linux-pm@lfdr.de>; Tue, 14 Oct 2025 01:27:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 48EFF3E7C1B
	for <lists+linux-pm@lfdr.de>; Mon, 13 Oct 2025 23:27:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBB812D6E44;
	Mon, 13 Oct 2025 23:26:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=panix.com header.i=@panix.com header.b="ERKP5NJU"
X-Original-To: linux-pm@vger.kernel.org
Received: from mailbackend.panix.com (mailbackend.panix.com [166.84.1.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BF2C2C15B4;
	Mon, 13 Oct 2025 23:26:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.84.1.89
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760398016; cv=none; b=BbQgmswr/wUIW2CTC+LiX7Fey7dEC5JlejGw8HPK1I1Fqas/vmgNYAf8TYvkZSWBEAu6JXhaxWLWPPHnHzb2bAmPAI5KDtea6k61D+lkG1gCXl1o480DnXjrdOpXoeYNjY0ZZ6ajyfrpIe7q8XbOBiNqBGYYSGNnEKHbOgHo7Uk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760398016; c=relaxed/simple;
	bh=VNxZxYSj80cciUaAzc5ogobO9Sur4mkO6fE8sHd/E98=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=h4dEp0mwENjpgLByTiTZqt8Ig0GbEWZ0+Ji5M4nRVzffCZ23rFfPR5gJDu7hWGU4u7kFISftcO0EUIhDSH+/bIBv63A/7IjE2VnbPmz9rvWF9SaGqVhkd3zsHA9saziEHfP51U5EHGLyc9uhDOXvoPpVGMsJgKW5qj6gfXKairQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=panix.com; spf=pass smtp.mailfrom=panix.com; dkim=pass (1024-bit key) header.d=panix.com header.i=@panix.com header.b=ERKP5NJU; arc=none smtp.client-ip=166.84.1.89
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=panix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=panix.com
Received: from [10.50.4.39] (45-31-46-51.lightspeed.sndgca.sbcglobal.net [45.31.46.51])
	by mailbackend.panix.com (Postfix) with ESMTPSA id 4cltlw0NwfzL5B;
	Mon, 13 Oct 2025 19:26:51 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=panix.com; s=panix;
	t=1760398013; bh=VNxZxYSj80cciUaAzc5ogobO9Sur4mkO6fE8sHd/E98=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=ERKP5NJUMNiiRiE3ewpGUPs8DyIUDT0Wndgt9KXlrJ5NbBoRRTOnmcXd8DBmDiQha
	 5N8DsPJe/ZRh78p/wYv7o6yi/yIxTe/CNRdkO6NC3P+tds+Axu87turIhD8IoiVd0u
	 MwozXw60lB0sqheNh3xPN+DNfyhUDXFIkS2+y/3I=
Message-ID: <27c4252a-8699-4168-a043-939e3fa40eca@panix.com>
Date: Mon, 13 Oct 2025 16:26:50 -0700
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/6] UCSI Power Supply Updates and Bug Fixes
To: Jameson Thies <jthies@google.com>
Cc: heikki.krogerus@linux.intel.com, linux-usb@vger.kernel.org,
 linux-kernel@vger.kernel.org, dmitry.baryshkov@oss.qualcomm.com,
 bleung@chromium.org, gregkh@linuxfoundation.org, akuchynski@chromium.org,
 abhishekpandit@chromium.org, sebastian.reichel@collabora.com,
 linux-pm@vger.kernel.org, Kenneth C <kenny@panix.com>
References: <20251007000007.3724229-1-jthies@google.com>
 <92c821fb-537a-40e6-98fc-616941b57778@panix.com>
 <CAMFSARf8--QW9otZDFGE4yr9i_WjYuwehJ0cV3ioD8KZFzjXaw@mail.gmail.com>
Content-Language: en-US
From: Kenneth Crudup <kenny@panix.com>
In-Reply-To: <CAMFSARf8--QW9otZDFGE4yr9i_WjYuwehJ0cV3ioD8KZFzjXaw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 10/13/25 15:53, Jameson Thies wrote:

> You are correct that adding POWER_SUPPLY_USB_TYPE_PD_DRP in
> ucsi_register_port_psy() is missing here. I would have expected that
> adding it resolves the issue. 

The issue must be deeper than that, as I even went as far as making the 
check for "allowed types" pass all the time (as the dmesg was swamped 
making booting difficult so debugging was somewhat painful) and was 
still getting "enum" errors.

... that being said, I had a flight to catch on Friday so didn't keep 
working on a fix.

-Kenny

-- 
Kenneth R. Crudup / Sr. SW Engineer, Scott County Consulting, Orange 
County CA


