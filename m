Return-Path: <linux-pm+bounces-6725-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 184598AB347
	for <lists+linux-pm@lfdr.de>; Fri, 19 Apr 2024 18:24:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 997C7B2115B
	for <lists+linux-pm@lfdr.de>; Fri, 19 Apr 2024 16:24:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64839130E20;
	Fri, 19 Apr 2024 16:24:01 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from mx3.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F3CA13049E
	for <linux-pm@vger.kernel.org>; Fri, 19 Apr 2024 16:23:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=141.14.17.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713543841; cv=none; b=hENYYOky6KUnK5r5YbJ0dbOezPERudaqngiqt+hYqjrILepyK0faPp8dtQP6ZmjHj3f0xUK0wX5QOvyafQ9wdotj2p6uL1DHjH1xc+JDAcoA8fsylLPyPWzA+y2p5AnYJ310kE5P2WWpvyrhcajS45SsT5YdsKdbF4hSrOoVjzo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713543841; c=relaxed/simple;
	bh=sKew3Ik8bOeArnyNuqoo1yaPEkHo4mHVsYmfnrVLeN4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bhj4gsuEz9qufs9uPTYDQcf/YKKlfdpnpfd0FcGoaoh7GE7urcw23FEZ/OwoyKeymHnkPPviae/0CDSzks4UhuycVbFE7/WZaozkRs9mhKqZTCvoZ9naXsetueFb1FANk6OxvJQY7j1VxrzTV8NQx4ask2mRkjX2lcva4y/DzZE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de; spf=pass smtp.mailfrom=molgen.mpg.de; arc=none smtp.client-ip=141.14.17.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=molgen.mpg.de
Received: from [192.168.0.6] (ip5f5af59e.dynamic.kabel-deutschland.de [95.90.245.158])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pmenzel)
	by mx.molgen.mpg.de (Postfix) with ESMTPSA id 4856661E5FE05;
	Fri, 19 Apr 2024 18:23:48 +0200 (CEST)
Message-ID: <58b30395-9ff2-4889-919f-54528ffb8dca@molgen.mpg.de>
Date: Fri, 19 Apr 2024 18:23:46 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Warning `amd_pstate: the _CPC object is not present in SBIOS or
 ACPI disabled`
To: Xiaojian Du <Xiaojian.Du@amd.com>, Ray Huang <Ray.Huang@amd.com>
Cc: linux-pm@vger.kernel.org, Mario Limonciello <Mario.Limonciello@amd.com>,
 Perry Yuan <Perry.Yuan@amd.com>
References: <d0e7eaad-d549-423c-a138-84c2abc817a7@molgen.mpg.de>
 <DM4PR12MB5136C2314DDEA0C7A20C4E5FF10D2@DM4PR12MB5136.namprd12.prod.outlook.com>
Content-Language: en-US
From: Paul Menzel <pmenzel@molgen.mpg.de>
In-Reply-To: <DM4PR12MB5136C2314DDEA0C7A20C4E5FF10D2@DM4PR12MB5136.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Dear Xiaojian,


Thank you for the quick reply.


Am 19.04.24 um 18:13 schrieb Du, Xiaojian:

> Would you try to check the cppc flag?
> "lscpu | grep cppc"

     $ lscpu | grep cppc
     $

> And Ryzen5 Pro 1500 is the first gen ZEN arch, as I know, it doesn't
> support CPCP function.

Thank you for the confirmation. It’d be great, if the warning would not 
be shown then.


Kind regards,

Paul

