Return-Path: <linux-pm+bounces-39611-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 27F2DCC08FA
	for <lists+linux-pm@lfdr.de>; Tue, 16 Dec 2025 03:07:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id ACC213013EB5
	for <lists+linux-pm@lfdr.de>; Tue, 16 Dec 2025 02:07:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4DFD2C15B5;
	Tue, 16 Dec 2025 02:07:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="LW9KzPpO"
X-Original-To: linux-pm@vger.kernel.org
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92A85284689;
	Tue, 16 Dec 2025 02:07:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.97.179.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765850827; cv=none; b=FNC8qjUFLKNf+VZaLs8b7f/9FvxauCRfAfildwNBSnK4XQVLiYlwtOXB0Kw8p5Qh6oS+NIznbRqNUdDo+Xy8kz4CItHsJ8zAQ69wCkydTpFftpGgCq4cqvj+X4ajoqg0qbl/eKOJzZPc4u0HJ3oZPTuyj//EMCL+L+z4DNFzOWs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765850827; c=relaxed/simple;
	bh=vJNzuAB9aCQ3iCQ/OVtcwtSW5InmdrpWVS63tpANSUY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=eNjkya8c7gyPmQYBYrCqnpD2OlJLgRtDwZt+AWMPh34Gvp9jFEoGmEFyMoEaQBtYBktp43hO/BNCKUEfB7iGVm9sXnHPpYaWN6QywunYeKcB06BNOLOvGkzyXV+jFQsMhHfhm4hlfb0fiaPSu3/QyhW089jZ+vhS3E6mbS7ynAs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=LW9KzPpO; arc=none smtp.client-ip=213.97.179.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
	References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=ldRBwp84+N56IOmiRqFbTLgnv/9C2lSWj3Qv9qjuFSI=; b=LW9KzPpObkzHDAgeJ/VTx9d755
	iGasc+utW+HupKuEC3hgobNMpHf+7na2I4V+NORj0mglCmnLq2br4t33RZxKQ98MTmFc1dvWnKzhQ
	GARcC5o4zSdsjk9nQ+bCQC9ZtVw3dDCbQvj1HD5VLHAwf7WD7N3fYk4hx46RY9is5RwgdxO79yE2E
	PCh1j/2to7SjpsQT5oPTGrZ4WhAhMIu2zSJEKpJe5Utm/sxCuty5dUBdcjuvAGOAOZSHEcr5HTBDf
	vu5fD4k49VLv3aBM9Q0OPncoi1AmLGJDUeoELah6xE7dT+/Ewq2XPd1ZKFEk0ehPRxvEKAYx1a8Ge
	Egr37ivQ==;
Received: from [58.29.143.236] (helo=[192.168.1.6])
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (Exim)
	id 1vVKSm-00DCLx-4S; Tue, 16 Dec 2025 03:06:56 +0100
Message-ID: <0d523461-c9b9-402a-b317-badcbd48dae0@igalia.com>
Date: Tue, 16 Dec 2025 11:06:49 +0900
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Concerns with em.yaml YNL spec
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Andrew Lunn <andrew@lunn.ch>, Donald Hunter <donald.hunter@gmail.com>,
 Lukasz Luba <lukasz.luba@arm.com>, linux-pm@vger.kernel.org,
 sched-ext@lists.linux.dev, Jakub Kicinski <kuba@kernel.org>,
 Network Development <netdev@vger.kernel.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <CAD4GDZy-aeWsiY=-ATr+Y4PzhMX71DFd_mmdMk4rxn3YG8U5GA@mail.gmail.com>
 <081e0ba7-055c-4243-8b39-e2c0cb9a8c5a@lunn.ch>
 <4bb1ea43-ef52-47ae-8009-6a2944dbf92b@igalia.com>
 <bb7871f1-3ea7-4bf7-baa9-a306a2371e4b@lunn.ch>
 <c65961d2-d31b-4ff9-ac1c-b5e3c06a46ba@igalia.com>
 <CAJZ5v0iX39rvdaoha18N-rpKLinGZ1cjTb1rV1Azh0Y7kYdaJQ@mail.gmail.com>
 <d5b50da2-bc1f-4138-9733-218688bc1838@igalia.com>
 <CAJZ5v0gpYQwC=1piaX-PNoyeoYJ7uw=DtAGdTVEXAsi4bnSdbA@mail.gmail.com>
From: Changwoo Min <changwoo@igalia.com>
Content-Language: en-US, ko-KR, en-US-large, ko
In-Reply-To: <CAJZ5v0gpYQwC=1piaX-PNoyeoYJ7uw=DtAGdTVEXAsi4bnSdbA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


On 12/16/25 00:06, Rafael J. Wysocki wrote:
> On Mon, Dec 15, 2025 at 4:01 PM Changwoo Min <changwoo@igalia.com> wrote:
>>
>> Let me provide the context of what has been discussed. Essentially, the
>> question is what the proper name of the netlink protocol is and its file
>> name for the energy model.
>>
>> Donald raised concerns that “em” is too cryptic, so it should be
>> “energy-model”. The following is Donald’s comment:
>>
>>
>>     “- I think the spec could have been called energy-model.yaml and the
>>      family called "energy-model" instead of "em".”
>>
>>
>> Andrew’s opinion is that it would be appropriate to limit the scope of
>> “energy-model” by adding a prefix, for example, “performance-domain-
>> energy-model”. Andrew’s comment is as follows:
>>
>>     “And a dumb question. What is an energy model? A PSE needs some level
>>     of energy model, it needs to know how much energy each PD can consume
>>     in order that it is not oversubscribed. Is the energy model generic
>>     enough that it could be used for this? Or should this energy model get
>>     a prefix to limit its scope to a performance domain? The suggested
>>     name of this file would then become something like
>>     performance-domain-energy-model.yml?”
>>
>> For me, “performance-domain-energy-model” sounds weird because the
>> performance domain is conceptually under the energy model. If adding a
>> prefix to limit the scope, it should be something like “system-energy-
>> model”, and the “system” prefix looks redundant to me.
>>
>> So, the question is what the proper name is for the energy model
>> protocol: “em”, “energy-model”, “performance-domain-energy-model”, or
>> something else?
> 
> I personally would be for something like "device-energy-model", where
> "device" may mean any kind of device including CPU devices.
> 

"device-energy-model" sounds good to me. I will prepare the patchset
using that name. Thanks a lot!

Regards,
Changwoo Min


