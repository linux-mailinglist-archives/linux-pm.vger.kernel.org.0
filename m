Return-Path: <linux-pm+bounces-6757-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FD0C8AC4B6
	for <lists+linux-pm@lfdr.de>; Mon, 22 Apr 2024 09:06:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CF6E11F219E2
	for <lists+linux-pm@lfdr.de>; Mon, 22 Apr 2024 07:06:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0769482FA;
	Mon, 22 Apr 2024 07:06:08 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from mx3.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2504482CA
	for <linux-pm@vger.kernel.org>; Mon, 22 Apr 2024 07:06:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=141.14.17.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713769568; cv=none; b=Va1cUSGX87YdJul8UfIGiCnQimweJJGLcWZXLNh0KoLjT38saorx0SF7i1bl0mMqZ7DAUz29EunEMaa/EU4xKLuVAVIUXWrbi89aHK3LfMriugf96Cyb6zDELGCg/K3Tqcj6wXKiSRPqLvUgkOvM5ebxBWnwZek2MuPscw6m8aw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713769568; c=relaxed/simple;
	bh=504QiEX/H/BmIoVnhDO2/r0uMc6St3+PmcFeN6mKmaE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nmrMLpcPVMMLUmjCmKMvhgi1agURSAvuuYPljH6CuKErQ7FWKkYF+Ivr3Kdvj6xxb92Gbs+h86Trzqy4Se5lQK9kQHM7zSYKQjUnCF7/ecDXuqPAxF0c89Qhz2Jfu/4UUgJ+64k6f6KFpJbgV0VX59sfzfT2bA6Ni2uQGF0BLfA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de; spf=pass smtp.mailfrom=molgen.mpg.de; arc=none smtp.client-ip=141.14.17.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=molgen.mpg.de
Received: from [192.168.0.6] (unknown [95.90.245.229])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pmenzel)
	by mx.molgen.mpg.de (Postfix) with ESMTPSA id 18D6B61E5FE05;
	Mon, 22 Apr 2024 09:05:55 +0200 (CEST)
Message-ID: <8464c8e5-72fc-46c4-a0e0-804b21da0652@molgen.mpg.de>
Date: Mon, 22 Apr 2024 09:05:54 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Warning `amd_pstate: the _CPC object is not present in SBIOS or
 ACPI disabled`
To: Perry Yuan <Perry.Yuan@amd.com>
Cc: Xiaojian Du <Xiaojian.Du@amd.com>, Ray Huang <Ray.Huang@amd.com>,
 linux-pm@vger.kernel.org, Mario Limonciello <Mario.Limonciello@amd.com>
References: <d0e7eaad-d549-423c-a138-84c2abc817a7@molgen.mpg.de>
 <DM4PR12MB5136C2314DDEA0C7A20C4E5FF10D2@DM4PR12MB5136.namprd12.prod.outlook.com>
 <58b30395-9ff2-4889-919f-54528ffb8dca@molgen.mpg.de>
 <CYYPR12MB8655D32EA18574C9497E888A9C122@CYYPR12MB8655.namprd12.prod.outlook.com>
Content-Language: en-US
From: Paul Menzel <pmenzel@molgen.mpg.de>
In-Reply-To: <CYYPR12MB8655D32EA18574C9497E888A9C122@CYYPR12MB8655.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Dear Perry,


Am 22.04.24 um 07:41 schrieb Yuan, Perry:

> The Family 17h Models 10h-2Fh CPUs are not supported for amd pstate
> driver, I have a patch to remove the warning message for those CPUs,
> I will push the patch to community review soon.

Thank you very much.


Kind regards,

Paul

