Return-Path: <linux-pm+bounces-32847-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 346BAB30A2E
	for <lists+linux-pm@lfdr.de>; Fri, 22 Aug 2025 02:15:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B335B2A57B9
	for <lists+linux-pm@lfdr.de>; Fri, 22 Aug 2025 00:15:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51DA84C81;
	Fri, 22 Aug 2025 00:12:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="UqOWNexb"
X-Original-To: linux-pm@vger.kernel.org
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60AAF4A3E;
	Fri, 22 Aug 2025 00:11:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.97.179.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755821522; cv=none; b=WDJgpGKejlQVrIR38f8lQuL2/DEYnWf5V9bnpC5H5X2ppaoMHbFX5TjBBBRo/lD80OmuWYi5AvYRd4d0jSiL7mnEBcdhfGnQ0xqvHg6FtiIaiHD4muKnIuysNVIOZid64J1umk2m9PfXfGARPlYibxSh/S/N7OvTp5ivCtmHl2k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755821522; c=relaxed/simple;
	bh=ABAWepAjHiZJzYettTX3FTQg/SU/KOcCVAnQL50u/gg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lbr0C/XoUQiJbgZflhj3AOC9X3f9WbZtrmbI96g0Uc6BUW2eB6ugcPbMkqoYtWa1vzSLsiei0sXlDWLPfBl1qi9zKw5GFaKMzp3wLhQPlVXth3NT7gdMmVoO966P/zRYqP7/uxgvby6qKtLsqlvi5Yu/nQCmGiyVZY0q+j9NryQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=UqOWNexb; arc=none smtp.client-ip=213.97.179.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
	References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=aeUBRdfQnoF/XeLI+FS29F1kvxnlVvl/a40ejNepzFw=; b=UqOWNexbepiAZnlzW+cl6Rn7Kx
	FbmRX41KlgAEJBXWEpW6sGdtT1hvX/dgZe/HxldMHrYUL7DgpwuTSqXKY5nrvyK6lqGsiSxyiCdcK
	CipY5jnGkDS5D8xxnR82TPXQ0cZ/DrY1G64rhT5qFiPf04z88FmAqdnwWd51568YkK5bHu+eThLX3
	b8VigckODHM4XMTGwnk7eLNjDbrxP9jMQjTsjHzdiLVNPNYGoP1iUGnER/EKm5xNT7sEZLupcWmY6
	at/xkCgAeLI/vJVVm1ZfqwbXgYfNJnMLZQcFp6vWXMduFXUGVu2QZdh03kWvMOkMkCW6ZyYIB7Cwd
	CwrmJbOg==;
Received: from [59.10.240.225] (helo=[172.28.113.15])
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (Exim)
	id 1upFNZ-00HTRe-Rv; Fri, 22 Aug 2025 02:11:38 +0200
Message-ID: <2c5134f4-c0b6-47a8-ba44-402b7f6893bd@igalia.com>
Date: Fri, 22 Aug 2025 09:11:28 +0900
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RESEND v3 00/10] PM: EM: Add netlink support for the
 energy model.
To: "Rafael J. Wysocki" <rafael@kernel.org>, lukasz.luba@arm.com
Cc: len.brown@intel.com, pavel@kernel.org, christian.loehle@arm.com,
 tj@kernel.org, kernel-dev@igalia.com, linux-pm@vger.kernel.org,
 sched-ext@lists.linux.dev, linux-kernel@vger.kernel.org,
 "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
References: <20250810233347.81957-1-changwoo@igalia.com>
 <CAJZ5v0ibEHC+Ckgisr+VAU=B21MgKJz2=QqGH2hd6UjUFutMSg@mail.gmail.com>
From: Changwoo Min <changwoo@igalia.com>
Content-Language: en-US, ko-KR, en-US-large, ko
In-Reply-To: <CAJZ5v0ibEHC+Ckgisr+VAU=B21MgKJz2=QqGH2hd6UjUFutMSg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Rafael,

On 8/21/25 20:27, Rafael J. Wysocki wrote:
> Hi,
> 
> On Mon, Aug 11, 2025 at 1:34 AM Changwoo Min <changwoo@igalia.com> wrote:
>>
> I've done a high-level review of this and it looks reasonable to me
> overall, but I'd like to get some feedback from Lukasz on it.

Thank you, Rafael, for the review! I will send v4 as soon as
I get feedback from Lukasz.

> 
> My two requests for now are: please reorder the series, so patches
> [3-5] go first, and remove the ending period (".") from all of the
> patch subjects.

Sure. Moving [3-5] to the beginning of the series and making the
title style consistent makes sense. I will change it in the next
version as suggested.

Regards,
Changwoo Min

