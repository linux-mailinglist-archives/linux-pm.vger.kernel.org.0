Return-Path: <linux-pm+bounces-36316-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D9003BE5DDF
	for <lists+linux-pm@lfdr.de>; Fri, 17 Oct 2025 02:16:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 98F9F584DD3
	for <lists+linux-pm@lfdr.de>; Fri, 17 Oct 2025 00:16:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EAAE11DC1AB;
	Fri, 17 Oct 2025 00:16:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=panix.com header.i=@panix.com header.b="nst4UH6L"
X-Original-To: linux-pm@vger.kernel.org
Received: from mailbackend.panix.com (mailbackend.panix.com [166.84.1.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FC531B042E;
	Fri, 17 Oct 2025 00:16:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.84.1.89
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760660186; cv=none; b=lzJ41s7TNqVd1+2AlFQuGCRsOyY1kxgK6zFia5h/OpVSpJw8RnhOvpYg8TxUYv2aBvs/a+rmSltUcgb3Lw0QBPqaqqcVHLQJASHWnTiZeH1AUtBZiPEvQXIfTeZoY2Bc8j7enpT2t3sqSlEyVssghlzhAek0rnNO8IR6WccgNns=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760660186; c=relaxed/simple;
	bh=7sAlPsgPaqVRtg4vyciG7ZFOALiAgARqEcWosXY9e6Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VU6xmdF08PyPPxwepln5J+u2CK+LtW0PVWTBDpTbAVn0ZFgr2XQT6DcZ0fGVPCnc4bs9lYW1ni6iSoF49bus96t5SdvAIzX0dnA4UvdG1U1SfJshyhS/3MlO23y1PgE6a+KElSHbiBwmRxgJ9WQU8/SyxxcoIHiWMBdhqFawJHA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=panix.com; spf=pass smtp.mailfrom=panix.com; dkim=pass (1024-bit key) header.d=panix.com header.i=@panix.com header.b=nst4UH6L; arc=none smtp.client-ip=166.84.1.89
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=panix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=panix.com
Received: from [10.50.4.39] (45-31-46-51.lightspeed.sndgca.sbcglobal.net [45.31.46.51])
	by mailbackend.panix.com (Postfix) with ESMTPSA id 4cnljX0Bc1z4Dsh;
	Thu, 16 Oct 2025 20:16:15 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=panix.com; s=panix;
	t=1760660177; bh=7sAlPsgPaqVRtg4vyciG7ZFOALiAgARqEcWosXY9e6Y=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=nst4UH6LnYjVbhkBZDDNnvzfIOgMoNlL9vrFKGDyEFxUwQbe2kX/VOT/RXi0YzLnR
	 +fFnRXBjMYJ5njiyJFXf/0K5qd0BeocHwkyO3o2R4VZxvO0hDT/jt2t/U/qlhRKLPU
	 gDdl4CJFyvzxjCijNZzTtfztvyPSIdBTLPaVSSQE=
Message-ID: <7f969633-6a5c-4694-a33e-b7d4d975ce59@panix.com>
Date: Thu, 16 Oct 2025 17:16:15 -0700
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/3] UCSI Power Supply Updates
To: Jameson Thies <jthies@google.com>, heikki.krogerus@linux.intel.com,
 linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
 Kenneth C <kenny@panix.com>
Cc: dmitry.baryshkov@oss.qualcomm.com, bleung@chromium.org,
 gregkh@linuxfoundation.org, akuchynski@chromium.org,
 abhishekpandit@chromium.org, sebastian.reichel@collabora.com,
 linux-pm@vger.kernel.org
References: <20251016235909.2092917-1-jthies@google.com>
Content-Language: en-US
From: Kenneth Crudup <kenny@panix.com>
In-Reply-To: <20251016235909.2092917-1-jthies@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


On 10/16/25 16:59, Jameson Thies wrote:

> v2 changes
> - Removed patch adding support for reporting DRP power supply types.
>    It led to spam in dmesg and needs further debug.

So far, so good! I'm currently booted (along with the "Add power supply 
status" patch) and no issues so far.

I'll look for the sysfs entries and report back with a Tested-By: if all 
is well.

-Kenny--
Kenneth R. Crudup / Sr. SW Engineer, Scott County Consulting, Orange 
County CA


