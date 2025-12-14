Return-Path: <linux-pm+bounces-39487-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D45BCBBA73
	for <lists+linux-pm@lfdr.de>; Sun, 14 Dec 2025 12:38:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 3FCD6300671C
	for <lists+linux-pm@lfdr.de>; Sun, 14 Dec 2025 11:38:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E3AB283FDB;
	Sun, 14 Dec 2025 11:38:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="K4Y4CELm"
X-Original-To: linux-pm@vger.kernel.org
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D8A51C8604;
	Sun, 14 Dec 2025 11:38:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.97.179.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765712313; cv=none; b=sGRUKYEXucVHskUlbkFrYGjpTr4ZkCCpHbDXsK2Rh9YSIOU6q5OL2swzjJtZp28tM0c9dmuNLSZAzospHEZx5oBFbOLUK8G4jMMLe7YJO4oAaSOsgyU4IAepZIgIvm6sPcYcZzO9YucxfWS3aIRHOXkbksQNsoSvDCYP8956SW0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765712313; c=relaxed/simple;
	bh=tQJI9bBJVzeNh7j7Fe4SiqB4uLMrk8E+RlOVB/2+qPA=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:References:
	 In-Reply-To:Content-Type; b=SIrRZPPuyLMMmUA5Xbbr0g+zjhtxCCGBOQXxlKd6Xh19beI/UPm2V83vZiuONnWuS2QYVRrFkChICCRygWC08rToRYHg6C2nKlVWN24WV8IiPMnpjSn5Op2yXhFD4N5mo+0C9Kys8WXyHGlgeHE/r1nV6ODpmlpl//1W4TMPK4A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=K4Y4CELm; arc=none smtp.client-ip=213.97.179.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:References:
	To:From:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:Cc:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=CYQCx5nELsmFJglYy4O01LUVxqU/WUARHYc7KKCY3wg=; b=K4Y4CELmVptELF7kqbfJVtT6BJ
	hNlxoMU6yeZIYe8HDVqBhtWd1KcxoDQ7Zz80Em3W5qKMBf8PG1WMxRN1vcA+0oqx5B/0w0+k4xsQ+
	JJpdowuU+oK+gcU19SMtlksQEi14wwfgTOlg137aErFHtJIjmmfJKR5BWlGWfdyRYL/GPv476IVjx
	tPgHHzu8rCcPFp1JmD3qyQaCc4Z6EjJBiCJkBMmpILx2Z0FI6IiHgAj63I6XJ+PJoAho7DzaE6GeF
	WgqF3FEfGCGfAEQvyXl30gOMCtivqMx+lAi74Nx5ImNKUQTjZqvLX01YJgUSIWBcIPxW7qWLjNkI0
	1QZkXuMg==;
Received: from [58.29.143.236] (helo=[192.168.1.6])
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (Exim)
	id 1vUkQl-00CbVI-VE; Sun, 14 Dec 2025 12:38:28 +0100
Message-ID: <73d24d31-f852-4722-b40e-ac44032e913e@igalia.com>
Date: Sun, 14 Dec 2025 20:38:22 +0900
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Concerns with em.yaml YNL spec
From: Changwoo Min <changwoo@igalia.com>
To: Donald Hunter <donald.hunter@gmail.com>, Lukasz Luba
 <lukasz.luba@arm.com>, linux-pm@vger.kernel.org, sched-ext@lists.linux.dev,
 Jakub Kicinski <kuba@kernel.org>,
 Network Development <netdev@vger.kernel.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <CAD4GDZy-aeWsiY=-ATr+Y4PzhMX71DFd_mmdMk4rxn3YG8U5GA@mail.gmail.com>
 <5d3c37c0-d956-410d-83c8-24323d6f2aea@igalia.com>
Content-Language: en-US, ko-KR, en-US-large, ko
In-Reply-To: <5d3c37c0-d956-410d-83c8-24323d6f2aea@igalia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 12/14/25 20:14, Changwoo Min wrote:

>> - I think the spec could have been called energy-model.yaml and the
>> family called "energy-model" instead of "em".
>>
>> - the get-pds should probably be both do and dump which would give
>> multi responses without the need for the pds attribute set (unless I'm
>> missing something).
>  >
> 

Will change as you suggested.

Regards,
Changwoo Min

